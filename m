Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E910C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGvI-00079A-4C; Thu, 07 Mar 2024 11:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riGvG-00078y-8c
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:48:46 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riGvC-0002Uz-80
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:48:45 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxbevl7+llEAEWAA--.54198S3;
 Fri, 08 Mar 2024 00:48:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnhPj7+llNmpQAA--.27604S6; 
 Fri, 08 Mar 2024 00:48:37 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 04/17] hw/loongarch: Add init_cmdline
Date: Fri,  8 Mar 2024 00:48:22 +0800
Message-Id: <20240307164835.300412-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240307164835.300412-1-gaosong@loongson.cn>
References: <20240307164835.300412-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnhPj7+llNmpQAA--.27604S6
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

Add init_cmline and set boot_info->a0, a1

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240301093839.663947-5-gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 19 +++++++++++++++++++
 include/hw/loongarch/virt.h |  2 ++
 target/loongarch/cpu.h      |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index e560ac178a..ca65dfde07 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -63,6 +63,16 @@ static const unsigned int slave_boot_code[] = {
     0x4c000020,   /* jirl       $r0,$r1,0           */
 };
 
+static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
+{
+    hwaddr cmdline_addr = (hwaddr)p - (hwaddr)start;
+
+    info->a0 = 1;
+    info->a1 = cmdline_addr;
+
+    memcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
+}
+
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
@@ -122,6 +132,10 @@ static void reset_load_elf(void *opaque)
 
     cpu_reset(CPU(cpu));
     if (env->load_elf) {
+	if (cpu == LOONGARCH_CPU(first_cpu)) {
+            env->gpr[4] = env->boot_info->a0;
+            env->gpr[5] = env->boot_info->a1;
+        }
         cpu_set_pc(CPU(cpu), env->elf_address);
     }
 }
@@ -161,8 +175,13 @@ static void loongarch_firmware_boot(LoongArchMachineState *lams,
 
 static void init_boot_rom(struct loongarch_boot_info *info, void *p)
 {
+    void *start = p;
+
     memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
     p += sizeof(slave_boot_code);
+
+    init_cmdline(info, p, start);
+    p += COMMAND_LINE_SIZE;
 }
 
 static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index cf2f2bfb19..d7a074d69f 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -33,6 +33,8 @@
 #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
 #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
 
+#define COMMAND_LINE_SIZE       512
+
 struct LoongArchMachineState {
     /*< private >*/
     MachineState parent_obj;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ec37579fd6..ce02ef3979 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -361,6 +361,8 @@ typedef struct CPUArchState {
     uint32_t mp_state;
     /* Store ipistate to access from this struct */
     DeviceState *ipistate;
+
+    struct loongarch_boot_info *boot_info;
 #endif
 } CPULoongArchState;
 
-- 
2.34.1


