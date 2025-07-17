Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76B6C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFa4-0003bi-2k; Wed, 16 Jul 2025 23:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVp-00048T-QM; Wed, 16 Jul 2025 23:42:37 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVo-0000g2-92; Wed, 16 Jul 2025 23:42:25 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:41:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:41:01 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 20/21] tests/function/aspeed: Replace manual loader with
 vbootrom for ast2700fc test
Date: Thu, 17 Jul 2025 11:40:48 +0800
Message-ID: <20250717034054.1903991-21-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SSP and TSP now boot in a powered-off state by default. Enabling them requires
the PSP (Cortex-A35) to explicitly set SCU control registers at runtime. This
behavior aligns with real hardware.

However, the current functional test framework design does not support switching
the active VM console after launch. For example, when the PSP is launched first
to enable SSP via SCU, the test framework cannot dynamically attach to the SSP
console afterward to verify its behavior.

Due to this limitation, the test case for AST2700FC has been modified to use
vBootROM (`ast27x0_bootrom.bin`) instead of manually loading boot images and
firmwares via `-device loader`. The vBootROM integrates boot sequencing for
PSP, TSP, and SSP and sets up SCU configuration as part of its flow, enabling
more realistic full-system testing without relying on console switching.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../test_aarch64_aspeed_ast2700fc.py          | 47 +------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/tests/functional/test_aarch64_aspeed_ast2700fc.py b/tests/functional/test_aarch64_aspeed_ast2700fc.py
index b85370e182..d7d50eda4d 100755
--- a/tests/functional/test_aarch64_aspeed_ast2700fc.py
+++ b/tests/functional/test_aarch64_aspeed_ast2700fc.py
@@ -72,52 +72,7 @@ def do_ast2700fc_tsp_test(self):
                                           '[72c02000] 06010103')
 
     def start_ast2700fc_test(self, name):
-        ca35_core = 4
-        uboot_size = os.path.getsize(self.scratch_file(name,
-                                                       'u-boot-nodtb.bin'))
-        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
-
-        load_images_list = [
-            {
-                'addr': '0x400000000',
-                'file': self.scratch_file(name,
-                                          'u-boot-nodtb.bin')
-            },
-            {
-                'addr': str(uboot_dtb_load_addr),
-                'file': self.scratch_file(name, 'u-boot.dtb')
-            },
-            {
-                'addr': '0x430000000',
-                'file': self.scratch_file(name, 'bl31.bin')
-            },
-            {
-                'addr': '0x430080000',
-                'file': self.scratch_file(name, 'optee',
-                                          'tee-raw.bin')
-            }
-        ]
-
-        for load_image in load_images_list:
-            addr = load_image['addr']
-            file = load_image['file']
-            self.vm.add_args('-device',
-                             f'loader,force-raw=on,addr={addr},file={file}')
-
-        for i in range(ca35_core):
-            self.vm.add_args('-device',
-                             f'loader,addr=0x430000000,cpu-num={i}')
-
-        load_elf_list = {
-            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),
-            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')
-        }
-
-        for cpu_num, key in enumerate(load_elf_list, start=4):
-            file = load_elf_list[key]
-            self.vm.add_args('-device',
-                             f'loader,file={file},cpu-num={cpu_num}')
-
+        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-- 
2.43.0


