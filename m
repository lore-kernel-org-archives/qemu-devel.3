Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC19F4613D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w515P-0007zq-BT; Tue, 24 Mar 2026 08:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w515D-0007wA-8T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w5157-0001SD-Km
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774356112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xF4Unaogif06++3MuPaBPCsMUumLCQSbewHrI7H2EY8=;
 b=NlQhSDaiw0nJFL7VhLhZr0nin8E3Jb9R9rmD3uIGcQ5IS1ZhBkWqGEa+JvmWpCLGWMHQLr
 MFXHqCoviSHIRIjOIYC5wK6izh2mNlT3+mhbvZZ4blV+mD2TpXv+xu1Gsinho8V81d2t1I
 lPnL0f8v8ZV9R7iArR5i5YxdRhfWafQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-lRJ0XEtyOxKzbp7M3jEU4w-1; Tue,
 24 Mar 2026 08:41:48 -0400
X-MC-Unique: lRJ0XEtyOxKzbp7M3jEU4w-1
X-Mimecast-MFC-AGG-ID: lRJ0XEtyOxKzbp7M3jEU4w_1774356107
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F6D5195608B; Tue, 24 Mar 2026 12:41:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B39371955D71; Tue, 24 Mar 2026 12:41:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/5] tests/functional/aarch64/test_aspeed: Disable kernel
 crypto self-tests in AST2700 boot tests
Date: Tue, 24 Mar 2026 13:41:29 +0100
Message-ID: <20260324124131.1053711-4-clg@redhat.com>
In-Reply-To: <20260324124131.1053711-1-clg@redhat.com>
References: <20260324124131.1053711-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Disable the kernel crypto self-tests in the AST2700 functional tests by
appending "cryptomgr.notests=1" to the U-Boot bootargs before booting
the kernel.

The ASPEED SDK enables crypto self-tests during kernel startup to
validate the hardware crypto engine. However, the current QEMU
implementation of the AST2700 HACE/crypto engine is still incomplete.
As a result, the kernel crypto self-tests trigger multiple warnings
during boot when running under QEMU.

Typical examples observed in the kernel log include failures for
several cipher modes such as DES/TDES/AES in ECB/CBC/CTR modes:

alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes failed (rc=-22)
alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=-22)
...

To reduce noise in the functional test logs, the tests now append
the following parameter to the kernel bootargs:

  cryptomgr.notests=1

This disables the kernel crypto self-tests when running the functional
tests under QEMU.

For validating the HACE implementation, we should instead rely on the
dedicated QEMU unit tests located in:

  tests/qtest/ast2700-hace-test.c

Once the QEMU implementation of the ASPEED HACE/crypto model has
progressed further and supports the missing crypto modes, we can
reassess whether enabling the kernel crypto self-tests again in the
functional tests is appropriate.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260316081549.1279841-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 11 +++++++++--
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 11 +++++++++--
 tests/functional/aarch64/test_aspeed_ast2700fc.py |  9 +++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
index 5c0c4b0ed50f..b0c08854daa9 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
@@ -51,9 +51,11 @@ def verify_vbootrom_firmware_flow(self):
         wait_for_console_pattern(self, 'pass')
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
 
+    def disable_kernel_crypto_selftest(self):
+         exec_command_and_wait_for_pattern(self,
+            'setenv bootargs "${bootargs} cryptomgr.notests=1"', '=>')
+
     def enable_ast2700_pcie2(self):
-        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
-        exec_command_and_wait_for_pattern(self, '\012', '=>')
         exec_command_and_wait_for_pattern(self,
             'cp 100420000 403000000 900000', '=>')
         exec_command_and_wait_for_pattern(self,
@@ -67,8 +69,13 @@ def enable_ast2700_pcie2(self):
 
     def verify_openbmc_boot_start(self, enable_pcie=True):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        self.disable_kernel_crypto_selftest()
         if enable_pcie:
             self.enable_ast2700_pcie2()
+        else:
+            exec_command(self, 'boot')
         wait_for_console_pattern(self, 'Linux version ')
 
     def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
index cc62a915b538..ed414999f4fa 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
@@ -51,9 +51,11 @@ def verify_vbootrom_firmware_flow(self):
         wait_for_console_pattern(self, 'pass')
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
 
+    def disable_kernel_crypto_selftest(self):
+         exec_command_and_wait_for_pattern(self,
+            'setenv bootargs "${bootargs} cryptomgr.notests=1"', '=>')
+
     def enable_ast2700_pcie2(self):
-        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
-        exec_command_and_wait_for_pattern(self, '\012', '=>')
         exec_command_and_wait_for_pattern(self,
             'cp 100420000 403000000 900000', '=>')
         exec_command_and_wait_for_pattern(self,
@@ -67,8 +69,13 @@ def enable_ast2700_pcie2(self):
 
     def verify_openbmc_boot_start(self, enable_pcie=True):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        self.disable_kernel_crypto_selftest()
         if enable_pcie:
             self.enable_ast2700_pcie2()
+        else:
+            exec_command(self, 'boot')
         wait_for_console_pattern(self, 'Linux version ')
 
     def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index f68f40a1bfaf..df889134edaa 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -27,9 +27,11 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
 
         self.vm.launch()
 
+    def disable_kernel_crypto_selftest(self):
+         exec_command_and_wait_for_pattern(self,
+            'setenv bootargs "${bootargs} cryptomgr.notests=1"', '=>')
+
     def enable_ast2700_pcie2(self):
-        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
-        exec_command_and_wait_for_pattern(self, '\012', '=>')
         exec_command_and_wait_for_pattern(self,
             'cp 100420000 403000000 900000', '=>')
         exec_command_and_wait_for_pattern(self,
@@ -43,6 +45,9 @@ def enable_ast2700_pcie2(self):
 
     def verify_openbmc_boot_and_login(self, name):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        self.disable_kernel_crypto_selftest()
         self.enable_ast2700_pcie2()
         wait_for_console_pattern(self, 'Starting kernel ...')
 
-- 
2.53.0


