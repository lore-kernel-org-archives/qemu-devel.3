Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A099C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8o-0003yf-Pk; Mon, 05 Jan 2026 07:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8X-0003r9-Fn
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8V-0007xe-Cf
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGnMfdF6G4uUQw2uzyCr9taP/1Mlago7zualsFQFCLg=;
 b=XyZ1XWg7ccAbFM3O4yJHfIt5SRU8qTxHbDNDCN3Tf1PrDt7E+gZoc2anWutAi5LzSnO07P
 s/ucb+J2ZuZz4WotFpKAQGqOMOR2WUftK7tWWI9jiyfqjOV3qFrMeEC7fy038SlCtR3Dm4
 PJhxbTctyn7qXY+AJ7JU4af1DnaGMmw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-lzSEMYAsNTOi54Sy2NvY-g-1; Mon,
 05 Jan 2026 07:56:36 -0500
X-MC-Unique: lzSEMYAsNTOi54Sy2NvY-g-1
X-Mimecast-MFC-AGG-ID: lzSEMYAsNTOi54Sy2NvY-g_1767617795
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92ED7195609F; Mon,  5 Jan 2026 12:56:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ECD519560A7; Mon,  5 Jan 2026 12:56:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/36] tests/functional/arm/test_aspeed_ast1060: Add functional
 tests for Aspeed AST1060 SoC
Date: Mon,  5 Jan 2026 13:55:46 +0100
Message-ID: <20260105125613.622667-10-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add functional tests for the Aspeed AST1060 SoC and its evaluation board.
The new test test_aspeed_ast1060.py validates booting the AST1060 EVB
machine using the Zephyr OS and ASPEED PROT application (ast1060_prot_v03.02.tgz)
and ensures basic console functionality.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251112030553.291734-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/meson.build            |  1 +
 tests/functional/arm/test_aspeed_ast1060.py | 52 +++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tests/functional/arm/test_aspeed_ast1060.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index d1ed076a6aa8..1762a496049d 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -28,6 +28,7 @@ tests_arm_system_quick = [
 
 tests_arm_system_thorough = [
   'aspeed_ast1030',
+  'aspeed_ast1060',
   'aspeed_palmetto',
   'aspeed_romulus',
   'aspeed_witherspoon',
diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
new file mode 100644
index 000000000000..034efa534262
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast1060.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED SoCs with firmware
+#
+# Copyright (C) 2025 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from aspeed import AspeedTest
+from qemu_test import Asset, exec_command_and_wait_for_pattern
+
+
+class AST1060Machine(AspeedTest):
+    ASSET_ASPEED_AST1060_PROT_3_02 = Asset(
+        ('https://github.com/AspeedTech-BMC'
+         '/aspeed-zephyr-project/releases/download/v03.02'
+         '/ast1060_prot_v03.02.tgz'),
+         'dd5f1adc935316ddd1906506a02e15567bd7290657b52320f1a225564cc175bd')
+
+    def test_arm_ast1060_prot_3_02(self):
+        self.set_machine('ast1060-evb')
+
+        kernel_name = "ast1060_prot/zephyr.bin"
+        kernel_file = self.archive_extract(
+            self.ASSET_ASPEED_AST1060_PROT_3_02, member=kernel_name)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_file, '-nographic')
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+        exec_command_and_wait_for_pattern(self, "help",
+                                          "Available commands")
+
+    def test_arm_ast1060_otp_blockdev_device(self):
+        self.vm.set_machine("ast1060-evb")
+
+        kernel_name = "ast1060_prot/zephyr.bin"
+        kernel_file = self.archive_extract(self.ASSET_ASPEED_AST1060_PROT_3_02,
+                                           member=kernel_name)
+        otp_img = self.generate_otpmem_image()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-kernel", kernel_file,
+            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
+            "-global", "aspeed-otp.drive=otp",
+        )
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.52.0


