Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9E5CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbFY-000510-5N; Fri, 19 Sep 2025 09:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbFW-000502-4O
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbFL-0002rC-TE
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYT1Dn0HktLar6gmqLifDjp6I3VC8KOqZ9g1EThVtrw=;
 b=TJpar+eDleUG2Yv+dFYqzwiKbgFuXQbMKcuXXHiqYvKfx7yiVG4bnKfonbczKQRonifCY4
 KOsRma7Pow3ThshhsoqY+c1yohHTsZ8dTFwCIcCkge6TM/w0WAlGphVfSYphjIuJjb1oih
 Oqqh7itR9oARqv/4ppY78MOSt1X43QM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-LCrK87_BOXOfypHbC3SyEA-1; Fri,
 19 Sep 2025 09:33:46 -0400
X-MC-Unique: LCrK87_BOXOfypHbC3SyEA-1
X-Mimecast-MFC-AGG-ID: LCrK87_BOXOfypHbC3SyEA_1758288824
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C3A01955F2A; Fri, 19 Sep 2025 13:33:44 +0000 (UTC)
Received: from localhost (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2318318004A3; Fri, 19 Sep 2025 13:33:42 +0000 (UTC)
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
Subject: [PATCH 03/24] scripts/archive-source: silence subprojects downloads
Date: Fri, 19 Sep 2025 17:32:57 +0400
Message-ID: <20250919133320.240145-4-marcandre.lureau@redhat.com>
In-Reply-To: <20250919133320.240145-1-marcandre.lureau@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

It's too verbose.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/archive-source.sh | 2 +-
 tests/lcitool/libvirt-ci  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 85cd0a63a0..68eb9672de 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -77,7 +77,7 @@ function subproject_dir() {
 git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 
-meson subprojects download $subprojects
+meson subprojects download $subprojects >/dev/null
 test $? -ne 0 && error "failed to download subprojects $subprojects"
 
 for sp in $subprojects; do
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 18c4bfe02c..7a92fe388f 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 18c4bfe02c467e5639bf9a687139735ccd7a3fff
+Subproject commit 7a92fe388f55d1bbc33e639e3484533f88c542ec
-- 
2.51.0


