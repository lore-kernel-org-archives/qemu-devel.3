Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FF1EEA854
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQ9-0008BK-Mc; Thu, 12 Feb 2026 16:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ4-00088X-0v
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ1-00065M-Qq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JO9L76PmT5FEoC7nSjKMyGVVXxJIi0nQmig2x5pSFk=;
 b=aPbycQ0Lz6T8I0bwFNV2o6escFlkWf/Q5J4iK2/x3pQqnct99j852oiLu1sc+ieTri/RXq
 6fNaVhs5l0dd3Yi/np2iqp0WR5CwL6fus9mlnktt+by4H9HUWzYTTde289JLVUI230xCKk
 qaERDzJ/Pe8jRFAfWbtv0gamQ9278R0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-8U9YaNVYMz-pQJu-uKc3MQ-1; Thu,
 12 Feb 2026 16:40:11 -0500
X-MC-Unique: 8U9YaNVYMz-pQJu-uKc3MQ-1
X-Mimecast-MFC-AGG-ID: 8U9YaNVYMz-pQJu-uKc3MQ_1770932410
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D30B18004BB; Thu, 12 Feb 2026 21:40:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB1431800668; Thu, 12 Feb 2026 21:40:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/16] tests/functional/arm/aspeed_ast2600: Enhance OTP test
 with functional validation
Date: Thu, 12 Feb 2026 22:39:44 +0100
Message-ID: <20260212213955.2225662-6-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kane Chen <kane_chen@aspeedtech.com>

Improve the OTP test script by adding functional verification of OTP
strap registers. The test now validates that OTP modifications made
in U-Boot persist through the Linux boot process and survive a
subsequent reboot.

Key changes:
- Added interactive console commands for U-Boot and Linux.
- Implemented verification for OTP register 0x30 across reboots.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211052326.430475-2-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
index 4066532d5dec..31a1c3bed670 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
@@ -7,6 +7,8 @@
 from qemu_test import Asset
 from aspeed import AspeedTest
 
+from qemu_test import wait_for_console_pattern, exec_command
+from qemu_test import exec_command_and_wait_for_pattern
 
 class AST2600Machine(AspeedTest):
 
@@ -16,6 +18,7 @@ class AST2600Machine(AspeedTest):
 
     def test_arm_ast2600_otp_blockdev_device(self):
         self.vm.set_machine("ast2600-evb")
+        self.require_netdev('user')
 
         image_path = self.archive_extract(self.ASSET_SDK_V1100_AST2600)
         otp_img = self.generate_otpmem_image()
@@ -25,9 +28,34 @@ def test_arm_ast2600_otp_blockdev_device(self):
             "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
             "-global", "aspeed-otp.drive=otp",
         )
-        self.do_test_arm_aspeed_sdk_start(
-            self.scratch_file("ast2600-default", "image-bmc"))
-        self.wait_for_console_pattern("ast2600-default login:")
+        self.vm.add_args('-drive', 'file=' +
+                self.scratch_file("ast2600-default", "image-bmc") +
+                ',if=mtd,format=raw',
+                '-net', 'nic', '-net', 'user', '-snapshot')
+        self.vm.launch()
+
+        # Set OTP value via uboot command
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot:')
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')
+        exec_command_and_wait_for_pattern(self,
+            'otp pb strap  o 0x30 1', 'ast#')
+        # Validate OTP value in uboot stage
+        exec_command_and_wait_for_pattern(self,
+            'otp read strap 0x30', '0x30      1')
+        exec_command_and_wait_for_pattern(self, 'boot',
+            "ast2600-default login:")
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc',
+            'root@ast2600-default:~#')
+        # Validate OTP value in BMC stage
+        exec_command_and_wait_for_pattern(self,
+            'otp read strap 0x30', '0x30      1')
+        exec_command_and_wait_for_pattern(self,
+            'reboot', 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')
+        # Validate OTP value in uboot stage
+        exec_command_and_wait_for_pattern(self,
+            'otp read strap 0x30', '0x30      1')
 
 
 if __name__ == '__main__':
-- 
2.53.0


