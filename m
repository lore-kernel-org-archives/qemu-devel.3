Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0C1EF06FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 06:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpL6y-00048t-VB; Mon, 09 Feb 2026 01:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpL6x-00047u-F0
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 01:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpL6v-0005Es-Pm
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 01:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770619864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkQ1KMtOymei0+V2Zk4g+GU7YfwxNmhasIvLDwsBcz4=;
 b=HdyDNVoQQa4DyEwP2KTzITxyBJR996Jsu/lbQFl7oNbF7jOgHpCWqcgZe1jy1UWkHl0qPu
 Yr7+4RtSgRIpWFj7Q6lHPa1uuoO9996nKKW53wsmvnW/e1/vsmwbDuRzshNZlAiIpTxq7i
 gukQOSda4wxWFP5r3EdDliLxij5+xXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-SqLhyOClMO2K1-hfCUmy_g-1; Mon,
 09 Feb 2026 01:51:01 -0500
X-MC-Unique: SqLhyOClMO2K1-hfCUmy_g-1
X-Mimecast-MFC-AGG-ID: SqLhyOClMO2K1-hfCUmy_g_1770619860
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 998C11956095; Mon,  9 Feb 2026 06:50:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.73])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1A001956053; Mon,  9 Feb 2026 06:50:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] tests/functional: Add SDK tests with Linux 5.15
Date: Mon,  9 Feb 2026 07:50:44 +0100
Message-ID: <20260209065044.239378-3-clg@redhat.com>
In-Reply-To: <20260209065044.239378-1-clg@redhat.com>
References: <20260209065044.239378-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add functional tests for AST2500 and AST2600 machines using the
OpenBMC SDK v11.00 with Linux kernel 5.15. These tests complement the
existing SDK tests and verify that QEMU correctly boots older kernel
versions on these platforms.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/meson.build              |  4 +++
 .../arm/test_aspeed_ast2500_sdk_515.py        | 29 +++++++++++++++++++
 .../arm/test_aspeed_ast2600_sdk_515.py        | 29 +++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk_515.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_515.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 175a83a2acd7..2f538f29a2de 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -5,10 +5,12 @@ test_arm_timeouts = {
   'aspeed_romulus' : 120,
   'aspeed_witherspoon' : 120,
   'aspeed_ast2500_sdk' : 720,
+  'aspeed_ast2500_sdk_515' : 720,
   'aspeed_ast2500_buildroot' : 480,
   'aspeed_ast2600_buildroot' : 480,
   'aspeed_ast2600_buildroot_tpm' : 720,
   'aspeed_ast2600_sdk' : 720,
+  'aspeed_ast2600_sdk_515' : 720,
   'aspeed_ast2600_sdk_otp' : 720,
   'aspeed_bletchley' : 480,
   'aspeed_catalina' : 480,
@@ -36,10 +38,12 @@ tests_arm_system_thorough = [
   'aspeed_romulus',
   'aspeed_witherspoon',
   'aspeed_ast2500_sdk',
+  'aspeed_ast2500_sdk_515',
   'aspeed_ast2500_buildroot',
   'aspeed_ast2600_buildroot',
   'aspeed_ast2600_buildroot_tpm',
   'aspeed_ast2600_sdk',
+  'aspeed_ast2600_sdk_515',
   'aspeed_ast2600_sdk_otp',
   'aspeed_bletchley',
   'aspeed_catalina',
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
new file mode 100755
index 000000000000..464a4e43961d
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py
@@ -0,0 +1,29 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class AST2500Machine(AspeedTest):
+
+    ASSET_SDK_V1100_AST2500_515 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2500-default-515-obmc.tar.gz',
+        '5732255d4617d98b76bbbc116d331d6ac89906fa212969eb8213fdc4aea86451')
+
+    def test_arm_ast2500_evb_sdk_515(self):
+        self.set_machine('ast2500-evb')
+
+        self.archive_extract(self.ASSET_SDK_V1100_AST2500_515)
+
+        self.do_test_arm_aspeed_sdk_start(
+            self.scratch_file("ast2500-default-515", "image-bmc"))
+
+        self.wait_for_console_pattern('ast2500-default-515 login:')
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
new file mode 100755
index 000000000000..f48da301d567
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py
@@ -0,0 +1,29 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class AST2600Machine(AspeedTest):
+
+    ASSET_SDK_V1100_AST2600_515 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-515-obmc.tar.gz',
+        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6')
+
+    def test_arm_ast2600_evb_sdk_515(self):
+        self.set_machine('ast2600-evb')
+
+        self.archive_extract(self.ASSET_SDK_V1100_AST2600_515)
+
+        self.do_test_arm_aspeed_sdk_start(
+            self.scratch_file("ast2600-default-515", "image-bmc"))
+
+        self.wait_for_console_pattern('ast2600-default-515 login:')
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.53.0


