Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F988C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFg4-0006Bt-5O; Thu, 07 Mar 2024 10:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riFfv-00068I-DD
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:28:52 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riFfn-0005ds-1p
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:28:51 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxfesn3ellC_gVAA--.54053S3;
 Thu, 07 Mar 2024 23:28:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxdMwk3ellNlBQAA--.33344S5; 
 Thu, 07 Mar 2024 23:28:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL v2 03/17] hw/loongarch: Add slave cpu boot_code
Date: Thu,  7 Mar 2024 23:28:21 +0800
Message-Id: <20240307152835.299233-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240307152835.299233-1-gaosong@loongson.cn>
References: <20240307152835.299233-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxdMwk3ellNlBQAA--.33344S5
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20240301093839.663947-4-gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 70 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 3075c276d4..2f398260af 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -14,6 +14,54 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 
+static const unsigned int slave_boot_code[] = {
+                  /* Configure reset ebase.         */
+    0x0400302c,   /* csrwr      $r12,0xc            */
+
+                  /* Disable interrupt.             */
+    0x0380100c,   /* ori        $r12,$r0,0x4        */
+    0x04000180,   /* csrxchg    $r0,$r12,0x0        */
+
+                  /* Clear mailbox.                 */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038081ad,   /* ori        $r13,$r13,0x20      */
+    0x06481da0,   /* iocsrwr.d  $r0,$r13            */
+
+                  /* Enable IPI interrupt.          */
+    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
+    0x0400118c,   /* csrxchg    $r12,$r12,0x4       */
+    0x02fffc0c,   /* addi.d     $r12,$r0,-1(0xfff)  */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038011ad,   /* ori        $r13,$r13,0x4       */
+    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038081ad,   /* ori        $r13,$r13,0x20      */
+
+                  /* Wait for wakeup  <.L11>:       */
+    0x06488000,   /* idle       0x0                 */
+    0x03400000,   /* andi       $r0,$r0,0x0         */
+    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
+    0x43fff59f,   /* beqz       $r12,-12(0x7ffff4) # 48 <.L11> */
+
+                  /* Read and clear IPI interrupt.  */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038031ad,   /* ori        $r13,$r13,0xc       */
+    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
+
+                  /* Disable  IPI interrupt.        */
+    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
+    0x04001180,   /* csrxchg    $r0,$r12,0x4        */
+
+                  /* Read mail buf and jump to specified entry */
+    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
+    0x038081ad,   /* ori        $r13,$r13,0x20      */
+    0x06480dac,   /* iocsrrd.d  $r12,$r13           */
+    0x00150181,   /* move       $r1,$r12            */
+    0x4c000020,   /* jirl       $r0,$r1,0           */
+};
+
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
@@ -110,8 +158,15 @@ static void loongarch_firmware_boot(LoongArchMachineState *lams,
     fw_cfg_add_kernel_info(info, lams->fw_cfg);
 }
 
+static void init_boot_rom(struct loongarch_boot_info *info, void *p)
+{
+    memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
+    p += sizeof(slave_boot_code);
+}
+
 static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 {
+    void  *p, *bp;
     int64_t kernel_addr = 0;
     LoongArchCPU *lacpu;
     CPUState *cs;
@@ -123,11 +178,24 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
         exit(1);
     }
 
+    /* Load 'boot_rom' at [0 - 1MiB] */
+    p = g_malloc0(1 * MiB);
+    bp = p;
+    init_boot_rom(info, p);
+    rom_add_blob_fixed("boot_rom", bp, 1 * MiB, 0);
+
     CPU_FOREACH(cs) {
         lacpu = LOONGARCH_CPU(cs);
         lacpu->env.load_elf = true;
-        lacpu->env.elf_address = kernel_addr;
+        if (cs == first_cpu) {
+            lacpu->env.elf_address = kernel_addr;
+        } else {
+            lacpu->env.elf_address = 0;
+        }
+        lacpu->env.boot_info = info;
     }
+
+    g_free(bp);
 }
 
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
-- 
2.34.1


