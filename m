Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F69ECF6498
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 08:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1supOo-0007Jy-Gb; Sun, 29 Sep 2024 04:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1supOd-0006m4-EM
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 04:35:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1supOa-0006SA-8l
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 04:35:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxfWs9Eflm6L0DAA--.3365S3;
 Sun, 29 Sep 2024 16:35:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn+QtEflmFt0UAA--.54891S6;
 Sun, 29 Sep 2024 16:35:07 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 4/7] hw/loongarch/boot: Rework boot code generation
Date: Sun, 29 Sep 2024 16:17:21 +0800
Message-Id: <20240929081724.2139556-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240929081724.2139556-1-gaosong@loongson.cn>
References: <20240929081724.2139556-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+QtEflmFt0UAA--.54891S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Use stl_p to write instructions so that host endian conversion
will be performed.

Replace mailbox read/write on LoongArch32 systems with 32bit IOCSR
instructions to prevent illegal instructions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240914-loongarch-booting-v1-2-1517cae11c10@flygoat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 107 ++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 4d01c01594..5a1cc5b79b 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -22,53 +22,64 @@ unsigned memmap_entries;
 ram_addr_t initrd_offset;
 uint64_t initrd_size;
 
-static const unsigned int slave_boot_code[] = {
-                  /* Configure reset ebase.                    */
-    0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
-
-                  /* Disable interrupt.                        */
-    0x0380100c,   /* ori        $t0, $zero,0x4                 */
-    0x04000180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
-
-                  /* Clear mailbox.                            */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
-    0x06481da0,   /* iocsrwr.d  $zero, $t1                     */
-
-                  /* Enable IPI interrupt.                     */
-    0x1400002c,   /* lu12i.w    $t0, 1(0x1)                    */
-    0x0400118c,   /* csrxchg    $t0, $t0, LOONGARCH_CSR_ECFG   */
-    0x02fffc0c,   /* addi.d     $t0, $r0,-1(0xfff)             */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038011ad,   /* ori        $t1, $t1, CORE_EN_OFF          */
-    0x064819ac,   /* iocsrwr.w  $t0, $t1                       */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
-
-                  /* Wait for wakeup  <.L11>:                  */
-    0x06488000,   /* idle       0x0                            */
-    0x03400000,   /* andi       $zero, $zero, 0x0              */
-    0x064809ac,   /* iocsrrd.w  $t0, $t1                       */
-    0x43fff59f,   /* beqz       $t0, -12(0x7ffff4) # 48 <.L11> */
-
-                  /* Read and clear IPI interrupt.             */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x064809ac,   /* iocsrrd.w  $t0, $t1                       */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038031ad,   /* ori        $t1, $t1, CORE_CLEAR_OFF       */
-    0x064819ac,   /* iocsrwr.w  $t0, $t1                       */
-
-                  /* Disable  IPI interrupt.                   */
-    0x1400002c,   /* lu12i.w    $t0, 1(0x1)                    */
-    0x04001180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_ECFG */
-
-                  /* Read mail buf and jump to specified entry */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
-    0x06480dac,   /* iocsrrd.d  $t0, $t1                       */
-    0x00150181,   /* move       $ra, $t0                       */
-    0x4c000020,   /* jirl       $zero, $ra,0                   */
-};
+static void generate_secondary_boot_code(void *boot_code, bool is_64bit)
+{
+    uint32_t *p = boot_code;
+
+    /* Configure reset ebase. */
+    stl_p(p++, 0x0400302c); /* csrwr      $t0, LOONGARCH_CSR_EENTRY  */
+
+    /* Disable interrupt. */
+    stl_p(p++, 0x0380100c); /* ori        $t0, $zero,0x4             */
+    stl_p(p++, 0x04000180); /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
+
+    /* Clear mailbox. */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
+    if (is_64bit) {
+        stl_p(p++, 0x06481da0); /* iocsrwr.d  $zero, $t1             */
+    } else {
+        stl_p(p++, 0x064819a0); /* iocsrwr.w  $zero, $t1             */
+    }
+
+    /* Enable IPI interrupt. */
+    stl_p(p++, 0x1400002c); /* lu12i.w    $t0, 1(0x1)                */
+    stl_p(p++, 0x0400118c); /* csrxchg    $t0, $t0, LOONGARCH_CSR_ECFG */
+    stl_p(p++, 0x02fffc0c); /* addi.d     $t0, $r0, -1(0xfff)        */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038011ad); /* ori        $t1, $t1, CORE_EN_OFF      */
+    stl_p(p++, 0x064819ac); /* iocsrwr.w  $t0, $t1                   */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
+
+    /* Wait for wakeup <.L11>: */
+    stl_p(p++, 0x06488000); /* idle       0x0                        */
+    stl_p(p++, 0x03400000); /* andi       $zero, $zero, 0x0          */
+    stl_p(p++, 0x064809ac); /* iocsrrd.w  $t0, $t1                   */
+    stl_p(p++, 0x43fff59f); /* beqz       $t0, -12(0x7ffff4) # 48 <.L11> */
+
+    /* Read and clear IPI interrupt. */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x064809ac); /* iocsrrd.w  $t0, $t1                   */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038031ad); /* ori        $t1, $t1, CORE_CLEAR_OFF   */
+    stl_p(p++, 0x064819ac); /* iocsrwr.w  $t0, $t1                   */
+
+    /* Disable IPI interrupt. */
+    stl_p(p++, 0x1400002c); /* lu12i.w    $t0, 1(0x1)                */
+    stl_p(p++, 0x04001180); /* csrxchg    $zero, $t0, LOONGARCH_CSR_ECFG */
+
+    /* Read mail buf and jump to specified entry. */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
+    if (is_64bit) {
+        stl_p(p++, 0x06480dac); /* iocsrrd.d  $t0, $t1               */
+    } else {
+        stl_p(p++, 0x064809ac); /* iocsrrd.w  $t0, $t1               */
+    }
+    stl_p(p++, 0x00150181); /* move       $ra, $t0                   */
+    stl_p(p++, 0x4c000020); /* jirl       $zero, $ra, 0              */
+}
 
 static inline void *guidcpy(void *dst, const void *src)
 {
@@ -379,7 +390,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 
     /* Load slave boot code at pflash0 . */
     void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
-    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
+    generate_secondary_boot_code(boot_code, is_la64(&lacpu->env));
     rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
 
     CPU_FOREACH(cs) {
-- 
2.34.1


