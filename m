Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD03D44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDPnO-0005cX-Le; Tue, 19 Nov 2024 10:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnL-0005Zt-Fc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDPnJ-0003f5-6G
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732028731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/j25DoaTM+J6e6fMux/TuPMvG0ZzjuZPFWGMca+3EQ=;
 b=cKJD9ugBjO/U6gogtsthkrMlDLkAtYcHYxxBdqR8PsNWtXCfM6139yY8y7316jdIfVVqDe
 1CdD4Xh4HkPzAVwpMycDMcYbh+JXPjzt6w83SC7t5gYcGRMLxxE0fgP6l94nXPlSvptbR9
 12wrYz/DC1yuU3X5/cbxV7R6hLN0two=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-Vsc4ZZpEP8WWQ39x3jCI3w-1; Tue,
 19 Nov 2024 10:05:27 -0500
X-MC-Unique: Vsc4ZZpEP8WWQ39x3jCI3w-1
X-Mimecast-MFC-AGG-ID: Vsc4ZZpEP8WWQ39x3jCI3w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B0551955EEA; Tue, 19 Nov 2024 15:05:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AFA019560A3; Tue, 19 Nov 2024 15:05:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/15] tests/functional: fix mips64el test to honour workdir
Date: Tue, 19 Nov 2024 15:05:05 +0000
Message-ID: <20241119150519.1123365-2-berrange@redhat.com>
In-Reply-To: <20241119150519.1123365-1-berrange@redhat.com>
References: <20241119150519.1123365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The missing directory separator resulted in the kernel file being
created 1 level higher than expected.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_mips64el_malta.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 6c6355b131..24ebcdb9c1 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -129,7 +129,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         screendump_path = os.path.join(self.workdir, 'screendump.pbm')
 
         kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
-        kernel_path = self.workdir + "vmlinux"
+        kernel_path = self.workdir + "/vmlinux"
         gzip_uncompress(kernel_path_gz, kernel_path)
 
         tuxlogo_path = self.ASSET_TUXLOGO.fetch()
-- 
2.46.0


