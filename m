Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B089CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8v-0004uN-Es; Mon, 29 Sep 2025 12:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7n-0002yW-2s
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7d-0002oa-Ng
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+ZQAAhU87/YX5/hMdCzNPOqYmeNjXyy3qddKmYrX08=;
 b=BZaFyhoMDENcfHf7K1VBdxga2qFj6aCJavfIldKN5YFeggPOca8dBBmexi64QsdEs5tQfn
 eXBthbvw5NiQ3n1Gw25avONfN9QVNwjtK/sqYFrosNLki9akfMPpspPK7o+Trq0mjQfzul
 ldwyaxoE36E/MLjeaHca705VuuiawGQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-ezlWGGTqMmqSZv3wVH9MJg-1; Mon,
 29 Sep 2025 12:53:05 -0400
X-MC-Unique: ezlWGGTqMmqSZv3wVH9MJg-1
X-Mimecast-MFC-AGG-ID: ezlWGGTqMmqSZv3wVH9MJg_1759164784
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 138011956065; Mon, 29 Sep 2025 16:53:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EB2A1800446; Mon, 29 Sep 2025 16:53:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/32] tests/functional/arm: Add AST1030 boot test with
 generated OTP image
Date: Mon, 29 Sep 2025 18:52:10 +0200
Message-ID: <20250929165230.797471-13-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Add a functional test that boots an AST1030 machine with a generated
OTP image. The test verifies that OTP contents are read during early
boot and that the system reaches the expected console prompt.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250917035917.4141723-3-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast1030.py | 24 +++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
index 42126b514ff9..e47b597d0bd9 100755
--- a/tests/functional/arm/test_aspeed_ast1030.py
+++ b/tests/functional/arm/test_aspeed_ast1030.py
@@ -7,17 +7,18 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
+from aspeed import AspeedTest
 from qemu_test import exec_command_and_wait_for_pattern
 
 
-class AST1030Machine(LinuxKernelTest):
+class AST1030Machine(AspeedTest):
 
     ASSET_ZEPHYR_3_02 = Asset(
         ('https://github.com/AspeedTech-BMC'
          '/zephyr/releases/download/v00.03.02/ast1030-evb-demo.zip'),
         '1ec83caab3ddd5d09481772801be7210e222cb015ce22ec6fffb8a76956dcd4f')
 
-    def test_ast1030_zephyros_3_02(self):
+    def test_arm_ast1030_zephyros_3_02(self):
         self.set_machine('ast1030-evb')
 
         kernel_name = "ast1030-evb-demo-3/zephyr.elf"
@@ -36,7 +37,7 @@ def test_ast1030_zephyros_3_02(self):
          '/zephyr/releases/download/v00.01.07/ast1030-evb-demo.zip'),
         'ad52e27959746988afaed8429bf4e12ab988c05c4d07c9d90e13ec6f7be4574c')
 
-    def test_ast1030_zephyros_1_07(self):
+    def test_arm_ast1030_zephyros_1_07(self):
         self.set_machine('ast1030-evb')
 
         kernel_name = "ast1030-evb-demo/zephyr.bin"
@@ -68,6 +69,21 @@ def test_ast1030_zephyros_1_07(self):
                 'kernel uptime',
         ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")
 
+    def test_arm_ast1030_otp_blockdev_device(self):
+        self.vm.set_machine("ast1030-evb")
+
+        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_02, member=kernel_name)
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
 
 if __name__ == '__main__':
-    LinuxKernelTest.main()
+    AspeedTest.main()
-- 
2.51.0


