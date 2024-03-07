Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27430C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riF6n-0000QH-Oh; Thu, 07 Mar 2024 09:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riF6l-0000Op-LM
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riF6h-0003Or-FU
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:31 -0500
Received: from loongson.cn (unknown [43.156.43.207])
 by gateway (Coremail) with SMTP id _____8Cxbeuk1Oll1_MVAA--.54098S3;
 Thu, 07 Mar 2024 22:52:20 +0800 (CST)
Received: from VM-4-14-ubuntu.. (unknown [43.156.43.207])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs2Y1OllbElQAA--.15045S5; 
 Thu, 07 Mar 2024 22:52:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 03/17] hw/loongarch: Add slave cpu boot_code
Date: Thu,  7 Mar 2024 22:51:53 +0800
Message-Id: <20240307145207.247913-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307145207.247913-1-gaosong@loongson.cn>
References: <20240307145207.247913-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs2Y1OllbElQAA--.15045S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF17Kr1UAFWUZFWxWr4rZwc_yoW5uF1rpr
 W3Zwn0vrs5XrW3Zwsxt34UZrs8Ja4FgrWagF93Kryjya1Yqr1DXw1kAr9avFWUKr1rXF1I
 vFn5A342gFWDJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1LvtUUUUU=
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


