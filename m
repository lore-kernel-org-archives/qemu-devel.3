Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E426FCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvR-0004nS-DI; Mon, 13 Oct 2025 08:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvC-0004Xm-P7
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hv7-0007wp-DQ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zj8RUAWBVOGH7gmS2hiKjB5z3WQq2i5b5hBsObdM3AU=;
 b=SFEbHOOK25TzNghG1LjD/y2o1iUeM2OJ32MzFS7qNMCWO1XnHkYHgotZxdtTFLVRz6r+FN
 Zl2xcfCdrPrAW1rboE1GpCzm3ZYnUTA8ytVxp93V3s/F74PA20f9jKi88xzKXC06VnpR8j
 dcDsyKMzFTkkIEipT1t8YOOM4NXkj0o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-XhIp4oITMl6a2JLF9XuftA-1; Mon,
 13 Oct 2025 08:44:52 -0400
X-MC-Unique: XhIp4oITMl6a2JLF9XuftA-1
X-Mimecast-MFC-AGG-ID: XhIp4oITMl6a2JLF9XuftA_1760359491
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 038D31954105; Mon, 13 Oct 2025 12:44:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21D711800446; Mon, 13 Oct 2025 12:44:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PULL 13/29] test/functional/aarch64: Split the ast2700a1-evb OpenBMC
 boot test
Date: Mon, 13 Oct 2025 14:44:04 +0200
Message-ID: <20251013124421.71977-14-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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

The 'ast2700a1-evb' machine has two functional tests: one loading
firmware components into memory and another using a vbootrom
image. Both tests perform a full OpenBMC boot and run checks on I2C
and PCIe devices, which is redundant and time-consuming.

To save CI resources, the vbootrom test is refactored to focus on the
firmware boot process only. The OpenBMC boot verification logic is
split and a new verify_openbmc_boot_start() helper is introduced to
only wait for the kernel to start.

The vbootrom test now uses this function and the less essential I2C
and PCIe checks have been removed from this test case.

Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20251007141604.761686-6-clg@redhat.com
[ clg: Changed pattern from 'Starting kernel ...' to 'Linux version ' ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index a60dc1259f69..0ced1a25021d 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -37,10 +37,13 @@ def verify_vbootrom_firmware_flow(self):
         wait_for_console_pattern(self, 'done')
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
 
-    def verify_openbmc_boot_and_login(self, name):
+    def verify_openbmc_boot_start(self):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
         wait_for_console_pattern(self, '## Loading kernel from FIT Image')
-        wait_for_console_pattern(self, 'Starting kernel ...')
+        wait_for_console_pattern(self, 'Linux version ')
+
+    def verify_openbmc_boot_and_login(self, name):
+        self.verify_openbmc_boot_start()
 
         wait_for_console_pattern(self, f'{name} login:')
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
@@ -141,9 +144,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
         self.vm.add_args('-netdev', 'user,id=net1')
         self.start_ast2700_test_vbootrom('ast2700-default')
         self.verify_vbootrom_firmware_flow()
-        self.verify_openbmc_boot_and_login('ast2700-default')
-        self.do_ast2700_i2c_test()
-        self.do_ast2700_pcie_test()
+        self.verify_openbmc_boot_start()
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.0


