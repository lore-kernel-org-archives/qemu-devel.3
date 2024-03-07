Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717B4C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riF6q-0000R9-1L; Thu, 07 Mar 2024 09:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riF6m-0000PZ-H8
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:32 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riF6i-0003QI-Fn
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:32 -0500
Received: from loongson.cn (unknown [43.156.43.207])
 by gateway (Coremail) with SMTP id _____8Dxvuup1Oll4vMVAA--.54047S3;
 Thu, 07 Mar 2024 22:52:25 +0800 (CST)
Received: from VM-4-14-ubuntu.. (unknown [43.156.43.207])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs2Y1OllbElQAA--.15045S7; 
 Thu, 07 Mar 2024 22:52:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 05/17] hw/loongarch: Init efi_system_table
Date: Thu,  7 Mar 2024 22:51:55 +0800
Message-Id: <20240307145207.247913-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307145207.247913-1-gaosong@loongson.cn>
References: <20240307145207.247913-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs2Y1OllbElQAA--.15045S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4DAr1fWFWfZr4UCrWxAFc_yoW5tr1fpF
 WfZr98trs5GFn3W393JFyagrnxArs3Gr13trnrG34Fyr4DJrykZr18GasFvFWkXr4Fy3s0
 vr1vg3yUWFsaywcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU
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

Add init_systab and set boot_info->a2

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240301093839.663947-6-gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 22 +++++++++++++++++
 include/hw/loongarch/boot.h | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 897d4636b6..769212fce2 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -62,6 +62,25 @@ static const unsigned int slave_boot_code[] = {
     0x4c000020,   /* jirl       $r0,$r1,0           */
 };
 
+static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
+{
+    struct efi_system_table *systab = p;
+
+    info->a2 = (uint64_t)p - (uint64_t)start;
+
+    systab->hdr.signature = EFI_SYSTEM_TABLE_SIGNATURE;
+    systab->hdr.revision = EFI_SPECIFICATION_VERSION;
+    systab->hdr.revision = sizeof(struct efi_system_table),
+    systab->fw_revision = FW_VERSION << 16 | FW_PATCHLEVEL << 8;
+    systab->runtime = 0;
+    systab->boottime = 0;
+    systab->nr_tables = 0;
+
+    p += ROUND_UP(sizeof(struct efi_system_table), 64);
+
+    systab->tables = p;
+}
+
 static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
 {
     hwaddr cmdline_addr = (hwaddr)p - (hwaddr)start;
@@ -134,6 +153,7 @@ static void reset_load_elf(void *opaque)
 	if (cpu == LOONGARCH_CPU(first_cpu)) {
             env->gpr[4] = env->boot_info->a0;
             env->gpr[5] = env->boot_info->a1;
+            env->gpr[6] = env->boot_info->a2;
         }
         cpu_set_pc(CPU(cpu), env->elf_address);
     }
@@ -181,6 +201,8 @@ static void init_boot_rom(struct loongarch_boot_info *info, void *p)
 
     init_cmdline(info, p, start);
     p += COMMAND_LINE_SIZE;
+
+    init_systab(info, p, start);
 }
 
 static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 3275c1e295..aa12a60ffb 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -8,6 +8,54 @@
 #ifndef HW_LOONGARCH_BOOT_H
 #define HW_LOONGARCH_BOOT_H
 
+/* UEFI 2.10 */
+#define EFI_SYSTEM_TABLE_SIGNATURE       0x5453595320494249
+#define EFI_2_100_SYSTEM_TABLE_REVISION  ((2<<16) | (100))
+#define EFI_SPECIFICATION_VERSION        EFI_SYSTEM_TABLE_REVISION
+#define EFI_SYSTEM_TABLE_REVISION        EFI_2_100_SYSTEM_TABLE_REVISION
+
+#define FW_VERSION 0x1
+#define FW_PATCHLEVEL 0x0
+
+typedef struct {
+    uint8_t b[16];
+} efi_guid_t __attribute__((aligned(8)));
+
+struct efi_config_table {
+    efi_guid_t guid;
+    uint64_t *ptr;
+    const char name[16];
+};
+
+typedef struct {
+    uint64_t signature;
+    uint32_t revision;
+    uint32_t headersize;
+    uint32_t crc32;
+    uint32_t reserved;
+} efi_table_hdr_t;
+
+struct efi_configuration_table {
+    efi_guid_t guid;
+    void *table;
+};
+
+struct efi_system_table {
+    efi_table_hdr_t hdr;
+    uint64_t fw_vendor;        /* physical addr of CHAR16 vendor string */
+    uint32_t fw_revision;
+    uint64_t con_in_handle;
+    uint64_t *con_in;
+    uint64_t con_out_handle;
+    uint64_t *con_out;
+    uint64_t stderr_handle;
+    uint64_t stderr;
+    uint64_t *runtime;
+    uint64_t *boottime;
+    uint64_t nr_tables;
+    struct efi_configuration_table *tables;
+};
+
 struct loongarch_boot_info {
     uint64_t ram_size;
     const char *kernel_filename;
-- 
2.34.1


