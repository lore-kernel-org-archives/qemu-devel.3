Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07575E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBY-0000tT-3r; Wed, 04 Feb 2026 05:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBR-0000fM-UO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBP-00043S-Pw
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+v+b3II5Y8nhsN1LqDSRrfyCnxXbW3wCaEj5O6zlLc=;
 b=O7SwbsICj2Q4NnlUhpNx9/yjCxzZ1ec6Smyj3WAapl/Pk11z7fdDqbudas18RFYeGTItWl
 vPOSz3pof4mfxKU76WM6YmKYDzscZgjvnB9uOx3X0glJA99V7QkzOU8s5QMCaFjOIjNhAb
 8eoWjxKJiyrS+x2Uqvjw7R9Ir9T55pw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-2sq3Jd8yOAmhU4HfJiO87Q-1; Wed,
 04 Feb 2026 05:32:23 -0500
X-MC-Unique: 2sq3Jd8yOAmhU4HfJiO87Q-1
X-Mimecast-MFC-AGG-ID: 2sq3Jd8yOAmhU4HfJiO87Q_1770201142
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B130118005AD; Wed,  4 Feb 2026 10:32:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F3C918004AD; Wed,  4 Feb 2026 10:32:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/45] tests/functional/aarch64/test_aspeed_ast2700: Enable
 PCIe2 DTS status for AST2700 tests
Date: Wed,  4 Feb 2026 11:31:11 +0100
Message-ID: <20260204103136.1795455-21-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

PCIe2 is disabled by default starting from SDK v10.00.

Add a helper function to stop U-Boot autoboot and update the device
tree at runtime, setting the PCIe2 node status to "okay" before
booting Linux. This allows the AST2700 functional test to verify
the PCIe2 root complex behavior correctly.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260203020855.1642884-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../functional/aarch64/test_aspeed_ast2700.py  | 18 ++++++++++++++++--
 .../aarch64/test_aspeed_ast2700fc.py           | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 0ced1a25021d..1f1b5749f4a0 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -9,7 +9,7 @@
 import os
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 
 
@@ -37,9 +37,23 @@ def verify_vbootrom_firmware_flow(self):
         wait_for_console_pattern(self, 'done')
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
 
+    def enable_ast2700_pcie2(self):
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'cp 100420000 403000000 900000', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'bootm start 403000000', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
+        exec_command(self, 'bootm go')
+
     def verify_openbmc_boot_start(self):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        self.enable_ast2700_pcie2()
         wait_for_console_pattern(self, 'Linux version ')
 
     def verify_openbmc_boot_and_login(self, name):
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index 8dbc8f234f9c..a1d8046f58e6 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -9,7 +9,7 @@
 import os
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import wait_for_console_pattern, exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 
 
@@ -27,9 +27,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
 
         self.vm.launch()
 
+    def enable_ast2700_pcie2(self):
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'cp 100420000 403000000 900000', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'bootm start 403000000', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
+        exec_command(self, 'bootm go')
+
     def verify_openbmc_boot_and_login(self, name):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        self.enable_ast2700_pcie2()
         wait_for_console_pattern(self, 'Starting kernel ...')
 
         wait_for_console_pattern(self, f'{name} login:')
-- 
2.52.0


