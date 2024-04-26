Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C85C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Hwu-00054d-7r; Fri, 26 Apr 2024 05:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s0Hwr-0004uA-9f
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:32:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s0Hwm-0001CX-O6
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:32:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxFvC7dCtm7mUDAA--.14282S3;
 Fri, 26 Apr 2024 17:32:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxU1a2dCtm+yUGAA--.2929S5; 
 Fri, 26 Apr 2024 17:32:43 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 zltjiangshi@gmail.com
Subject: [PATCH v7 03/17] hw/loongarch: Add slave cpu boot_code
Date: Fri, 26 Apr 2024 17:15:37 +0800
Message-Id: <20240426091551.2397867-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240426091551.2397867-1-gaosong@loongson.cn>
References: <20240426091551.2397867-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxU1a2dCtm+yUGAA--.2929S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240307164835.300412-4-gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index a9522d6912..d1a8434127 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -15,6 +15,54 @@
 #include "sysemu/reset.h"
 #include "sysemu/qtest.h"
 
+static const unsigned int slave_boot_code[] = {
+                  /* Configure reset ebase.                    */
+    0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
+
+                  /* Disable interrupt.                        */
+    0x0380100c,   /* ori        $t0, $zero,0x4                 */
+    0x04000180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
+
+                  /* Clear mailbox.                            */
+    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
+    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20  */
+    0x06481da0,   /* iocsrwr.d  $zero, $t1                     */
+
+                  /* Enable IPI interrupt.                     */
+    0x1400002c,   /* lu12i.w    $t0, 1(0x1)                    */
+    0x0400118c,   /* csrxchg    $t0, $t0, LOONGARCH_CSR_ECFG   */
+    0x02fffc0c,   /* addi.d     $t0, $r0,-1(0xfff)             */
+    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
+    0x038011ad,   /* ori        $t1, $t1, CORE_EN_OFF          */
+    0x064819ac,   /* iocsrwr.w  $t0, $t1                       */
+    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
+    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
+
+                  /* Wait for wakeup  <.L11>:                  */
+    0x06488000,   /* idle       0x0                            */
+    0x03400000,   /* andi       $zero, $zero, 0x0              */
+    0x064809ac,   /* iocsrrd.w  $t0, $t1                       */
+    0x43fff59f,   /* beqz       $t0, -12(0x7ffff4) # 48 <.L11> */
+
+                  /* Read and clear IPI interrupt.             */
+    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
+    0x064809ac,   /* iocsrrd.w  $t0, $t1                       */
+    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
+    0x038031ad,   /* ori        $t1, $t1, CORE_CLEAR_OFF       */
+    0x064819ac,   /* iocsrwr.w  $t0, $t1                       */
+
+                  /* Disable  IPI interrupt.                   */
+    0x1400002c,   /* lu12i.w    $t0, 1(0x1)                    */
+    0x04001180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_ECFG */
+
+                  /* Read mail buf and jump to specified entry */
+    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
+    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
+    0x06480dac,   /* iocsrrd.d  $t0, $t1                       */
+    0x00150181,   /* move       $ra, $t0                       */
+    0x4c000020,   /* jirl       $zero, $ra,0                   */
+};
+
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
@@ -126,11 +174,23 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
         }
     }
 
+    /* Load slave boot code at pflash0 . */
+    void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
+    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
+    rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
+
     CPU_FOREACH(cs) {
         lacpu = LOONGARCH_CPU(cs);
         lacpu->env.load_elf = true;
-        lacpu->env.elf_address = kernel_addr;
+        if (cs == first_cpu) {
+            lacpu->env.elf_address = kernel_addr;
+        } else {
+            lacpu->env.elf_address = VIRT_FLASH0_BASE;
+        }
+        lacpu->env.boot_info = info;
     }
+
+    g_free(boot_code);
 }
 
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
-- 
2.25.1


