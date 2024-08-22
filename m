Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A08C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 06:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh1gr-0005sq-8t; Thu, 22 Aug 2024 02:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sh1go-0005sM-4m
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 02:52:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sh1gk-00067P-Mr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 02:52:57 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxHutA4MZmMO4bAA--.60311S3;
 Thu, 22 Aug 2024 14:52:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxnWc+4MZmapMdAA--.36056S2;
 Thu, 22 Aug 2024 14:52:46 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Support QMP dump-guest-memory
Date: Thu, 22 Aug 2024 14:52:45 +0800
Message-Id: <20240822065245.2286214-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxnWc+4MZmapMdAA--.36056S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add the support needed for creating prstatus elf notes. This allows
us to use QMP dump-guest-memory.

Now ELF notes of LoongArch only supports general elf notes, LSX and
LASX is not supported, since it is mainly used to dump guest memory.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/arch_dump.c | 167 +++++++++++++++++++++++++++++++++++
 target/loongarch/cpu.c       |   1 +
 target/loongarch/internals.h |   2 +
 target/loongarch/meson.build |   1 +
 4 files changed, 171 insertions(+)
 create mode 100644 target/loongarch/arch_dump.c

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
new file mode 100644
index 0000000000..4986db970e
--- /dev/null
+++ b/target/loongarch/arch_dump.c
@@ -0,0 +1,167 @@
+/*
+ * Support for writing ELF notes for LoongArch architectures
+ *
+ * Copyright (c) 2023 Loongarch Technology
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "elf.h"
+#include "sysemu/dump.h"
+#include "internals.h"
+
+/* struct user_pt_regs from arch/loongarch/include/uapi/asm/ptrace.h */
+struct loongarch_user_regs {
+    uint64_t gpr[32];
+    uint64_t pad1[1];
+    /* Special CSR registers. */
+    uint64_t csr_era;
+    uint64_t csr_badv;
+    uint64_t pad2[10];
+} QEMU_PACKED;
+
+QEMU_BUILD_BUG_ON(sizeof(struct loongarch_user_regs) != 360);
+
+/* struct elf_prstatus from include/uapi/linux/elfcore.h */
+struct loongarch_elf_prstatus {
+    char pad1[32]; /* 32 == offsetof(struct elf_prstatus, pr_pid) */
+    uint32_t pr_pid;
+    /*
+     * 76 == offsetof(struct elf_prstatus, pr_reg) -
+     * offsetof(struct elf_prstatus, pr_ppid)
+     */
+    char pad2[76];
+    struct loongarch_user_regs pr_reg;
+    uint32_t pr_fpvalid;
+    char pad3[4];
+} QEMU_PACKED;
+
+QEMU_BUILD_BUG_ON(sizeof(struct loongarch_elf_prstatus) != 480);
+
+/* struct user_fp_state from arch/loongarch/include/uapi/asm/ptrace.h */
+struct loongarch_fpu_struct {
+    uint64_t fpr[32];
+    uint64_t fcc;
+    unsigned int fcsr;
+} QEMU_PACKED;
+
+QEMU_BUILD_BUG_ON(sizeof(struct loongarch_fpu_struct) != 268);
+
+struct loongarch_note {
+    Elf64_Nhdr hdr;
+    char name[8]; /* align_up(sizeof("CORE"), 4) */
+    union {
+        struct loongarch_elf_prstatus prstatus;
+        struct loongarch_fpu_struct fpu;
+    };
+} QEMU_PACKED;
+
+#define LOONGARCH_NOTE_HEADER_SIZE offsetof(struct loongarch_note, prstatus)
+#define LOONGARCH_PRSTATUS_NOTE_SIZE                                          \
+    (LOONGARCH_NOTE_HEADER_SIZE + sizeof(struct loongarch_elf_prstatus))
+#define LOONGARCH_PRFPREG_NOTE_SIZE                                           \
+    (LOONGARCH_NOTE_HEADER_SIZE + sizeof(struct loongarch_fpu_struct))
+
+static void loongarch_note_init(struct loongarch_note *note, DumpState *s,
+                                const char *name, Elf64_Word namesz,
+                                Elf64_Word type, Elf64_Word descsz)
+{
+    memset(note, 0, sizeof(*note));
+
+    note->hdr.n_namesz = cpu_to_dump32(s, namesz);
+    note->hdr.n_descsz = cpu_to_dump32(s, descsz);
+    note->hdr.n_type = cpu_to_dump32(s, type);
+
+    memcpy(note->name, name, namesz);
+}
+
+static int loongarch_write_elf64_fprpreg(WriteCoreDumpFunction f,
+                                         CPULoongArchState *env, int cpuid,
+                                         DumpState *s)
+{
+    struct loongarch_note note;
+    int ret, i;
+
+    loongarch_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.fpu));
+    note.fpu.fcsr = cpu_to_dump64(s, env->fcsr0);
+
+    for (i = 0; i < 8; i++) {
+        note.fpu.fcc |= env->cf[i] << (8 * i);
+    }
+    note.fpu.fcc = cpu_to_dump64(s, note.fpu.fcc);
+
+    for (i = 0; i < 32; ++i) {
+        note.fpu.fpr[i] = cpu_to_dump64(s, env->fpr[i].vreg.UD[0]);
+    }
+
+    ret = f(&note, LOONGARCH_PRFPREG_NOTE_SIZE, s);
+    if (ret < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
+                                   int cpuid, DumpState *s)
+{
+    struct loongarch_note note;
+    CPULoongArchState *env = &LOONGARCH_CPU(cs)->env;
+    int ret, i;
+
+    loongarch_note_init(&note, s, "CORE", 5, NT_PRSTATUS,
+                        sizeof(note.prstatus));
+    note.prstatus.pr_pid = cpu_to_dump32(s, cpuid);
+    note.prstatus.pr_fpvalid = cpu_to_dump32(s, 1);
+
+    for (i = 0; i < 32; ++i) {
+        note.prstatus.pr_reg.gpr[i] = cpu_to_dump64(s, env->gpr[i]);
+    }
+    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, env->CSR_ERA);
+    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, env->CSR_BADV);
+    ret = f(&note, LOONGARCH_PRSTATUS_NOTE_SIZE, s);
+    if (ret < 0) {
+        return -1;
+    }
+
+    ret = loongarch_write_elf64_fprpreg(f, env, cpuid, s);
+    if (ret < 0) {
+        return -1;
+    }
+
+    return ret;
+}
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    info->d_machine = EM_LOONGARCH;
+    info->d_endian = ELFDATA2LSB;
+    info->d_class = ELFCLASS64;
+
+    return 0;
+}
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    size_t note_size = 0;
+
+    if (class == ELFCLASS64) {
+        note_size = LOONGARCH_PRSTATUS_NOTE_SIZE + LOONGARCH_PRFPREG_NOTE_SIZE;
+    }
+
+    return note_size * nr_cpus;
+}
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5e85b9dbef..63da4a8e64 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -754,6 +754,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+    .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
 };
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 944153b180..1a02427627 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -72,5 +72,7 @@ void write_fcc(CPULoongArchState *env, uint64_t val);
 int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
 int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
 void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs);
+int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
+                                   int cpuid, DumpState *s);
 
 #endif
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index e002e9aaf6..7817318287 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -8,6 +8,7 @@ loongarch_ss.add(files(
 
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
+  'arch_dump.c',
   'cpu_helper.c',
   'loongarch-qmp-cmds.c',
   'machine.c',
-- 
2.39.3


