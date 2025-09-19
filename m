Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5214CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbFN-0004r0-Ra; Fri, 19 Sep 2025 09:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbFL-0004qU-QZ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbFB-0002lp-LO
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTBMNcDqVuJV/gtKAAAxrAW9tqpviGi0ZJ2TsgcFCmw=;
 b=P2NFKFTmSqMDMGWf8NmXpLIR36ZFGlHdZ4g5dmGNgRLUxYR872RYyjne8hXNURSC0FrXHE
 PsiN9BerH2smbsLL0Mrg+p4QovoOvWqwo5Z9VoyzfSGmm3DQeQJ55hrEZH4xmT3Ok2jRy1
 W84lMeE5CzaS5ibDmU9koAB4uGR7uTU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-eyA34JwvPB6EWkKtrTqL2w-1; Fri,
 19 Sep 2025 09:33:41 -0400
X-MC-Unique: eyA34JwvPB6EWkKtrTqL2w-1
X-Mimecast-MFC-AGG-ID: eyA34JwvPB6EWkKtrTqL2w_1758288818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 708191800285; Fri, 19 Sep 2025 13:33:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13C9F19560BB; Fri, 19 Sep 2025 13:33:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 02/24] scripts/archive-source: speed up downloading subprojects
Date: Fri, 19 Sep 2025 17:32:56 +0400
Message-ID: <20250919133320.240145-3-marcandre.lureau@redhat.com>
In-Reply-To: <20250919133320.240145-1-marcandre.lureau@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Running meson on each subproject is quite slow.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/archive-source.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 035828c532..85cd0a63a0 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -77,9 +77,10 @@ function subproject_dir() {
 git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 
+meson subprojects download $subprojects
+test $? -ne 0 && error "failed to download subprojects $subprojects"
+
 for sp in $subprojects; do
-    meson subprojects download $sp
-    test $? -ne 0 && error "failed to download subproject $sp"
     tar --append --file "$tar_file" --exclude=.git subprojects/"$(subproject_dir $sp)"
     test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
 done
-- 
2.51.0


