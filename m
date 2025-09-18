Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768FCCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBBr-0004SA-LT; Thu, 18 Sep 2025 05:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uzBBo-0004OL-Jb
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:44:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uzBBj-0003YK-UC
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:44:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx3tJ11MtovcALAA--.25474S3;
 Thu, 18 Sep 2025 17:44:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxQ+Ry1Mto4ladAA--.45902S3;
 Thu, 18 Sep 2025 17:44:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 1/3] hw/loongarch/virt: Add BSP support with aux boot code
Date: Thu, 18 Sep 2025 17:20:45 +0800
Message-Id: <20250918092047.785269-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250918092047.785269-1-gaosong@loongson.cn>
References: <20250918092047.785269-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+Ry1Mto4ladAA--.45902S3
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

If system boots directly from Linux kernel, BSP core jumps to kernel
entry of Linux kernel image and other APs jump to aux boot code. Instead
BSP and APs can all jump to aux boot code like UEFI bios.

With aux boot code, BSP core is judged from physical cpu id, whose
cpu id is 0. With BSP core, load data to register A0-A2 and PC.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250906070200.3749326-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 14d6c52d4e..4962668e5a 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -35,13 +35,19 @@ struct loongarch_linux_hdr {
     uint32_t pe_header_offset;
 } QEMU_PACKED;
 
-static const unsigned int slave_boot_code[] = {
+static const unsigned int aux_boot_code[] = {
                   /* Configure reset ebase.                    */
     0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
 
                   /* Disable interrupt.                        */
     0x0380100c,   /* ori        $t0, $zero,0x4                 */
     0x04000180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
+    0x03400000,   /* nop                                       */
+
+    0x0400800c,   /* csrrd      $t0, LOONGARCH_CSR_CPUNUM      */
+    0x034ffd8c,   /* andi       $t0, $t0, 0x3ff                */
+    0x0015000d,   /* move       $t1, $zero                     */
+    0x5800718d,   /* beq        $t0, $t1, 112                  */
 
                   /* Clear mailbox.                            */
     0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
@@ -81,6 +87,26 @@ static const unsigned int slave_boot_code[] = {
     0x06480dac,   /* iocsrrd.d  $t0, $t1                       */
     0x00150181,   /* move       $ra, $t0                       */
     0x4c000020,   /* jirl       $zero, $ra,0                   */
+                  /* BSP Core                                  */
+    0x03400000,   /* nop                                       */
+    0x1800000d,   /* pcaddi     $t1, 0                         */
+    0x28c0a1a4,   /* ld.d       $a0, $t1, 40                   */
+    0x1800000d,   /* pcaddi     $t1, 0                         */
+    0x28c0a1a5,   /* ld.d       $a1, $t1, 40                   */
+    0x1800000d,   /* pcaddi     $t1, 0                         */
+    0x28c0a1a6,   /* ld.d       $a2, $t1, 40                   */
+    0x1800000d,   /* pcaddi     $t1, 0                         */
+    0x28c0a1ac,   /* ld.d       $t0, $t1, 40                   */
+    0x00150181,   /* move       $ra, $t0                       */
+    0x4c000020,   /* jirl       $zero, $ra,0                   */
+    0x00000000,   /* .dword 0   A0                             */
+    0x00000000,
+    0x00000000,   /* .dword 0   A1                             */
+    0x00000000,
+    0x00000000,   /* .dword 0   A2                             */
+    0x00000000,
+    0x00000000,   /* .dword 0   PC                             */
+    0x00000000,
 };
 
 static inline void *guidcpy(void *dst, const void *src)
@@ -391,6 +417,7 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
     int64_t kernel_addr = VIRT_FLASH0_BASE;
     LoongArchCPU *lacpu;
     CPUState *cs;
+    uint64_t *data;
 
     if (info->kernel_filename) {
         kernel_addr = load_kernel_info(info);
@@ -408,7 +435,12 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
 
     /* Load slave boot code at pflash0 . */
     void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
-    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
+    memcpy(boot_code, &aux_boot_code, sizeof(aux_boot_code));
+    data = (uint64_t *)(boot_code + sizeof(aux_boot_code));
+    *(data - 4) = cpu_to_le64(info->a0);
+    *(data - 3) = cpu_to_le64(info->a1);
+    *(data - 2) = cpu_to_le64(info->a2);
+    *(data - 1) = cpu_to_le64(kernel_addr);
     rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
 
     CPU_FOREACH(cs) {
-- 
2.47.0


