Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E550E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJY7s-0003zc-Nu; Fri, 06 Dec 2024 08:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7q-0003y5-AZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7o-000742-AK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733490723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UzU8VmtwuxYdLR2F2yxMMWNha2eFBb4W2uXMJRDx+E=;
 b=G09OpmmnssgSSX4EiPasZNLFtm9hKpektxPdY4ywDEqBQe/YQ2F7oVA8sLvaaB5R+iG7Co
 jIDy6owYtTQnrxxt1UYVNoz877HWYr9RjKDFKvuzn4+ngdobY56Z11nIiMdz3aIyO62p3j
 dGh/ORIIKKU1KpobfdD2ADlQC5fc94I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-CKWmnaqdOdO0IaCQw8sffw-1; Fri,
 06 Dec 2024 08:11:59 -0500
X-MC-Unique: CKWmnaqdOdO0IaCQw8sffw-1
X-Mimecast-MFC-AGG-ID: CKWmnaqdOdO0IaCQw8sffw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74D16195608B; Fri,  6 Dec 2024 13:11:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.16])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 771791954201; Fri,  6 Dec 2024 13:11:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/7] tests/functional: Introduce a specific test for
 palmetto-bmc machine
Date: Fri,  6 Dec 2024 14:11:27 +0100
Message-ID: <20241206131132.520911-3-clg@redhat.com>
In-Reply-To: <20241206131132.520911-1-clg@redhat.com>
References: <20241206131132.520911-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This introduces a new aspeed module for sharing code between tests and
moves the palmetto test to a new test file. No changes in the test.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aspeed.py                   | 23 +++++++++++++++++++
 tests/functional/meson.build                 |  2 ++
 tests/functional/test_arm_aspeed.py          | 10 --------
 tests/functional/test_arm_aspeed_palmetto.py | 24 ++++++++++++++++++++
 4 files changed, 49 insertions(+), 10 deletions(-)
 create mode 100644 tests/functional/aspeed.py
 create mode 100644 tests/functional/test_arm_aspeed_palmetto.py

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
new file mode 100644
index 000000000000..d4dc5320b97a
--- /dev/null
+++ b/tests/functional/aspeed.py
@@ -0,0 +1,23 @@
+# Test class to boot aspeed machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest
+
+class AspeedTest(LinuxKernelTest):
+
+    def do_test_arm_aspeed(self, machine, image):
+        self.set_machine(machine)
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-snapshot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern("U-Boot 2016.07")
+        self.wait_for_console_pattern("## Loading kernel from FIT Image at 20080000")
+        self.wait_for_console_pattern("Starting kernel ...")
+        self.wait_for_console_pattern("Booting Linux on physical CPU 0x0")
+        self.wait_for_console_pattern(
+                "aspeed-smc 1e620000.spi: read control register: 203b0641")
+        self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
+        self.wait_for_console_pattern("systemd[1]: Set hostname to")
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ef593d4b9928..3cd079f910a8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -19,6 +19,7 @@ test_timeouts = {
   'aarch64_virt' : 720,
   'acpi_bits' : 420,
   'arm_aspeed_ast1030' : 10,
+  'arm_aspeed_palmetto' : 120,
   'arm_aspeed' : 600,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -68,6 +69,7 @@ tests_alpha_system_thorough = [
 tests_arm_system_thorough = [
   'arm_aspeed',
   'arm_aspeed_ast1030',
+  'arm_aspeed_palmetto',
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index 9e58fcd84009..48a229608ef6 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -37,16 +37,6 @@ def do_test_arm_aspeed(self, machine, image):
         self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
         self.wait_for_console_pattern("systemd[1]: Set hostname to")
 
-    ASSET_PALMETTO_FLASH = Asset(
-        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
-         'obmc-phosphor-image-palmetto.static.mtd'),
-        '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
-
-    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
-        image_path = self.ASSET_PALMETTO_FLASH.fetch()
-
-        self.do_test_arm_aspeed('palmetto-bmc', image_path)
-
     ASSET_ROMULUS_FLASH = Asset(
         ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
          'obmc-phosphor-image-romulus.static.mtd'),
diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/test_arm_aspeed_palmetto.py
new file mode 100644
index 000000000000..6588c02aad79
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_palmetto.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+class PalmettoMachine(AspeedTest):
+
+    ASSET_PALMETTO_FLASH = Asset(
+        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
+         'obmc-phosphor-image-palmetto.static.mtd'),
+        '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
+
+    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
+        image_path = self.ASSET_PALMETTO_FLASH.fetch()
+
+        self.do_test_arm_aspeed('palmetto-bmc', image_path)
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.47.0


