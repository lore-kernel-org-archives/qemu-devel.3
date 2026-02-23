Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466D7EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXa-00071H-PT; Mon, 23 Feb 2026 18:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXY-0006z9-OD
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:36 -0500
Received: from qs-2002g-snip4-11.eps.apple.com ([57.103.87.201]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXV-0004RY-Pr
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:36 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 4062018003A5; Mon, 23 Feb 2026 23:40:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890033; x=1774482033;
 bh=j5paisOQ1VFLkKAryqWQSX7Vkmcjkzogoegd50HGWeA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=b66XbFS5JArAUKkZaOFnKOlFz9UBjPi6qTBsnORyMzqHvtZ+Tq0riq5J+b31AwUtO7AZI9sjRukuKgGozp367uoSm/NNFOsRL3hWyjF7yjH4Mk7g6sxWl9m9Dq9tpUVTvUzXHwXuZgZSJN8PuYlGmyXCTcEc5qM7yQffVmiZQm1UlGFEWYEpzCO7XBc3j3re7/T1HJ/ppCdGdJO6K+Htoh2MhEFrHw0o6iSsJUikFjec8QMkAzFL1GT9gLmBmNcIldITj8Gi1wrwclnAZjQX5YNThSX1e88xPyMqjcP9WAGQKyccPYYP85OdcY0IL+NhgGyZTE3WkjFDzu1wN7L1Lg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 4EA5C18003A8; Mon, 23 Feb 2026 23:40:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 19/28] target/i386: emulate, hvf, mshv: rework MMU code
Date: Tue, 24 Feb 2026 00:39:41 +0100
Message-ID: <20260223233950.96076-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NFf_su9-enqNl0bIDAGyUXkvEK0wor_y
X-Authority-Info-Out: v=2.4 cv=GO0F0+NK c=1 sm=1 tr=0 ts=699ce570
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NZS8YYHO3DlyE-T6x6gA:9
X-Proofpoint-ORIG-GUID: NFf_su9-enqNl0bIDAGyUXkvEK0wor_y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX5alBW34s28OG
 rm2xO9ZIgL9FU9y5FqB/d1Waog6C6d/p0XAMonQ6dTe9oTGPZ7hTDdLEt37g6PSGXxsCwJsyrk4
 UFufuyVVw3GDGhV9hQYjL87L7D6FCloZW8aSFbcTIX3++DrCIg8Xhn95tHGy7yjgePfRIOoSU/N
 WwVB3N3z9vWPnPx9sJzkBlit7VAC+kcrjrAPHtdxQAVOl5K459kqHsBg/8+rjCMsCHM8e9P9QNY
 +ydIRU6bsCwfZVPrhfDI/r5daCY+e9hKw1QBYSRLxZASRspXBRvTAQ6i/R/ag+Mrej9by+lrvrd
 KcrGX05b+6kxMwuVceHtyRc+mqBxnaV51VV90Y5E2fQBbbu9DBg06uL88WvzxM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAAB8klt1Zy12bjbxa1dbPA6/kUrPkLpUTU0IaO7lqT2ZHhP1RBYkU/IE7DEXaIUT5qmcSw9290hF9EWQ6TbZaKtpI++gGzIV4gCtVEv6PXbXcOcbw9iAkVV9jbR3kwLTgaLv1EiBpneC1+j2ES5KTMNhA+pJFh19JaGqpUfv/Gz5wvO7tFXndm/tGYbBd9PqER3DnlYaQr8Ahg5WW/Y0BT8dECbsad/2RDcSn2XY8wjkXzhnoXNW2aw6arVH31mIxJUg2PTHfFSEDb3TGfCpfWQT7Uou8/bCu72+a9Yf8lr7aLsVDoolMPbj08w5N9J89eyi1TtcOgcVAt4lEdLfAFQar2iqZUDA0991Ah8FoyB5wD7Xzf+LzagXPGy43AZDQybgvwRM5dI+NQspKazWBh5FlTM8P+kxxwI1DLNW/OqfNt9piWOrkcAGbCseDpRraI18SmdtxR184QrzabuCzRyR4ZYLhQB/E9Hzhs+30IkNctyvNuHRDiw/MwvLWrurS4iWI5mR+VScEo+oyh0ck7lsDVi0iLB0xfCvhLlfzBuAyoRJ+1vX48YxafmdI68DBaGmTuguQbDPLrokdkPtWnhsIeIfgzlpbAS5nT/gxnn4HXTEB7ZDJxbyACkbVncLoiPZiRypgCIH5MDAyTKrE42mFODAPcDm/umGGPuucewnt5eFZ+x+eAFwjhBcVQvZsJII2Hm19NesrYC/BR441oLdy3b8t6uyYfjhJZHtTVv3aMsdzpx/awlg0wPt7jJyj72ws3yI3wR8iOhzlQH
Received-SPF: pass client-ip=57.103.87.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

target/i386/emulate doesn't currently properly emulate instructions
which might cause a page fault during their execution. Notably, REP STOS/MOVS
from MMIO to an address which is unmapped until a page fault exception is raised
causes an abort() in vmx_write_mem.

Change the interface between the HW accel backend and target/i386/emulate as a first step towards addressing that.

Adapt the page table walker code to give actionable errors,
while leaving a possibility for backends to provide their own walker.

This removes the usage of the Hyper-V page walker in the mshv backend.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_decode.c  |   2 +-
 target/i386/emulate/x86_emu.c     |  14 +--
 target/i386/emulate/x86_emu.h     |   4 +-
 target/i386/emulate/x86_helpers.c |   5 +-
 target/i386/emulate/x86_mmu.c     | 146 +++++++++++++++++++-----------
 target/i386/emulate/x86_mmu.h     |  31 +++++--
 target/i386/hvf/hvf.c             |  31 +++----
 target/i386/hvf/x86.c             |   6 +-
 target/i386/hvf/x86_task.c        |   8 +-
 target/i386/mshv/mshv-cpu.c       |  71 ---------------
 target/i386/whpx/whpx-all.c       |  12 ---
 11 files changed, 146 insertions(+), 184 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 7bbcd2a9a2..9faa65a579 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -80,7 +80,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         if (emul_ops->fetch_instruction) {
             emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
         } else {
-            emul_ops->read_mem(env_cpu(env), &val, va, size);
+            x86_read_mem(env_cpu(env), &val, va, size);
         }
     }
     decode->len += size;
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index bf96fe06b4..cfa35561dd 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -166,7 +166,7 @@ void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
 
 static void write_val_to_mem(CPUX86State *env, target_ulong ptr, target_ulong val, int size)
 {
-    emul_ops->write_mem(env_cpu(env), &val, ptr, size);
+    x86_write_mem(env_cpu(env), &val, ptr, size);
 }
 
 void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
@@ -180,7 +180,7 @@ void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
     return env->emu_mmio_buf;
 }
 
@@ -497,7 +497,7 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
 
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 0,
                         decode->operand_size, 1);
-    emul_ops->write_mem(env_cpu(env), env->emu_mmio_buf, addr,
+    x86_write_mem(env_cpu(env), env->emu_mmio_buf, addr,
                         decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
@@ -518,7 +518,7 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, addr,
+    x86_read_mem(env_cpu(env), env->emu_mmio_buf, addr,
                        decode->operand_size);
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 1,
                         decode->operand_size, 1);
@@ -604,7 +604,7 @@ static void exec_stos_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
-    emul_ops->write_mem(env_cpu(env), &val, addr, decode->operand_size);
+    x86_write_mem(env_cpu(env), &val, addr, decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
@@ -628,7 +628,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    emul_ops->read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
+    x86_read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
@@ -653,7 +653,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
 
     addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    emul_ops->read_mem(env_cpu(env), &val, addr,  decode->operand_size);
+    x86_read_mem(env_cpu(env), &val, addr,  decode->operand_size);
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 05686b162f..3e485b8ca3 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -21,13 +21,13 @@
 
 #include "x86.h"
 #include "x86_decode.h"
+#include "x86_mmu.h"
 #include "cpu.h"
 
 struct x86_emul_ops {
     void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
                               int bytes);
-    void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
-    void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
+    MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 7bdd7e4c2a..024f9a2afc 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
+#include "emulate/x86_mmu.h"
 #include "qemu/error-report.h"
 #include "system/mshv.h"
 
@@ -176,7 +177,7 @@ bool x86_read_segment_descriptor(CPUState *cpu,
     }
 
     gva = base + sel.index * 8;
-    emul_ops->read_mem(cpu, desc, gva, sizeof(*desc));
+    x86_read_mem_priv(cpu, desc, gva, sizeof(*desc));
 
     return true;
 }
@@ -200,7 +201,7 @@ bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
     }
 
     gva = base + gate * 8;
-    emul_ops->read_mem(cpu, idt_desc, gva, sizeof(*idt_desc));
+    x86_read_mem_priv(cpu, idt_desc, gva, sizeof(*idt_desc));
 
     return true;
 }
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 35987a897a..f9ef1070fb 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -21,7 +21,9 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
+#include "qemu/error-report.h"
 #include "emulate/x86.h"
+#include "emulate/x86_emu.h"
 #include "emulate/x86_mmu.h"
 
 #define pte_present(pte) (pte & PT_PRESENT)
@@ -32,6 +34,11 @@
 #define pte_large_page(pte) (pte & PT_PS)
 #define pte_global_access(pte) (pte & PT_GLOBAL)
 
+#define mmu_validate_write(flags) (flags & MMU_TRANSLATE_VALIDATE_WRITE)
+#define mmu_validate_execute(flags) (flags & MMU_TRANSLATE_VALIDATE_EXECUTE)
+#define mmu_priv_checks_exempt(flags) (flags & MMU_TRANSLATE_PRIV_CHECKS_EXEMPT)
+
+
 #define PAE_CR3_MASK                (~0x1fllu)
 #define LEGACY_CR3_MASK             (0xffffffff)
 
@@ -40,14 +47,16 @@
 #define PAE_PTE_LARGE_PAGE_MASK     ((-1llu << (21)) & ((1llu << 52) - 1))
 #define PAE_PTE_SUPER_PAGE_MASK     ((-1llu << (30)) & ((1llu << 52) - 1))
 
+static bool is_user(CPUState *cpu)
+{
+    return false;
+}
+
+
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    int    err_code;
     uint64_t pte[5];
-    bool write_access;
-    bool user_access;
-    bool exec_access;
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
@@ -99,25 +108,15 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 }
 
 /* test page table entry */
-static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
-                          int level, int *largeness, bool pae)
+static MMUTranslateResult test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
+                          int level, int *largeness, bool pae, MMUTranslateFlags flags)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     uint64_t pte = pt->pte[level];
 
-    if (pt->write_access) {
-        pt->err_code |= MMU_PAGE_WT;
-    }
-    if (pt->user_access) {
-        pt->err_code |= MMU_PAGE_US;
-    }
-    if (pt->exec_access) {
-        pt->err_code |= MMU_PAGE_NX;
-    }
-
     if (!pte_present(pte)) {
-        return false;
+        return MMU_TRANSLATE_PAGE_NOT_MAPPED;
     }
 
     if (pae && !x86_is_long_mode(cpu) && 2 == level) {
@@ -125,32 +124,30 @@ static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
     }
 
     if (level && pte_large_page(pte)) {
-        pt->err_code |= MMU_PAGE_PT;
         *largeness = level;
     }
-    if (!level) {
-        pt->err_code |= MMU_PAGE_PT;
-    }
 
     uint32_t cr0 = env->cr[0];
     /* check protection */
     if (cr0 & CR0_WP_MASK) {
-        if (pt->write_access && !pte_write_access(pte)) {
-            return false;
+        if (mmu_validate_write(flags) && !pte_write_access(pte)) {
+            return MMU_TRANSLATE_PRIV_VIOLATION;
         }
     }
 
-    if (pt->user_access && !pte_user_access(pte)) {
-        return false;
+    if (!mmu_priv_checks_exempt(flags)) {
+        if (is_user(cpu) && !pte_user_access(pte)) {
+            return MMU_TRANSLATE_PRIV_VIOLATION;
+        }
     }
 
-    if (pae && pt->exec_access && !pte_exec_access(pte)) {
-        return false;
+    if (pae && mmu_validate_execute(flags) && !pte_exec_access(pte)) {
+        return MMU_TRANSLATE_PRIV_VIOLATION;
     }
     
 exit:
     /* TODO: check reserved bits */
-    return true;
+    return MMU_TRANSLATE_SUCCESS;
 }
 
 static inline uint64_t pse_pte_to_page(uint64_t pte)
@@ -181,7 +178,7 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
 
 
 
-static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
+static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslateFlags flags,
                      struct gpt_translation *pt, bool pae)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -190,21 +187,20 @@ static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
     int largeness = 0;
     target_ulong cr3 = env->cr[3];
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
+    MMUTranslateResult res;
     
     memset(pt, 0, sizeof(*pt));
     top_level = gpt_top_level(cpu, pae);
 
     pt->pte[top_level] = pae ? (cr3 & PAE_CR3_MASK) : (cr3 & LEGACY_CR3_MASK);
     pt->gva = addr;
-    pt->user_access = (err_code & MMU_PAGE_US);
-    pt->write_access = (err_code & MMU_PAGE_WT);
-    pt->exec_access = (err_code & MMU_PAGE_NX);
     
     for (level = top_level; level > 0; level--) {
         get_pt_entry(cpu, pt, level, pae);
+        res = test_pt_entry(cpu, pt, level - 1, &largeness, pae, flags);
 
-        if (!test_pt_entry(cpu, pt, level - 1, &largeness, pae)) {
-            return false;
+        if (res) {
+            return res;
         }
 
         if (largeness) {
@@ -218,69 +214,111 @@ static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
         pt->gpa = large_page_gpa(pt, pae, largeness);
     }
 
-    return true;
+    return res;
 }
 
 
-bool mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa)
+MMUTranslateResult mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags)
 {
+    if (emul_ops->mmu_gva_to_gpa) {
+        return emul_ops->mmu_gva_to_gpa(cpu, gva, gpa, flags);
+    }
+
     bool res;
     struct gpt_translation pt;
-    int err_code = 0;
 
     if (!x86_is_paging_mode(cpu)) {
         *gpa = gva;
-        return true;
+        return MMU_TRANSLATE_SUCCESS;
     }
 
-    res = walk_gpt(cpu, gva, err_code, &pt, x86_is_pae_enabled(cpu));
-    if (res) {
+    res = walk_gpt(cpu, gva, flags, &pt, x86_is_pae_enabled(cpu));
+    if (res == MMU_TRANSLATE_SUCCESS) {
         *gpa = pt.gpa;
-        return true;
     }
 
-    return false;
+    return res;
 }
 
-void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes)
+static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MemTxResult mem_tx_res;
     uint64_t gpa;
 
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
-                        __func__, gva);
-        } else {
-            address_space_write(&address_space_memory, gpa,
-                                MEMTXATTRS_UNSPECIFIED, data, copy);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, MMU_TRANSLATE_VALIDATE_WRITE);
+        if (translate_res) {
+            return translate_res;
+        }
+
+        mem_tx_res = address_space_write(&address_space_memory, gpa,
+                            MEMTXATTRS_UNSPECIFIED, data, copy);
+
+        if (mem_tx_res == MEMTX_DECODE_ERROR) {
+            warn_report("write to unmapped mmio region gpa=0x%llx size=%i", gpa, bytes);
+            return MMU_TRANSLATE_GPA_UNMAPPED;
+        } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
+            return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
         }
 
         bytes -= copy;
         gva += copy;
         data += copy;
     }
+    return translate_res;
+}
+
+MMUTranslateResult x86_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    return x86_write_mem_ex(cpu, data, gva, bytes, false);
+}
+
+MMUTranslateResult x86_write_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    return x86_write_mem_ex(cpu, data, gva, bytes, true);
 }
 
-void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MemTxResult mem_tx_res;
     uint64_t gpa;
 
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
-                        __func__, gva);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, 0);
+        if (translate_res) {
+            return translate_res;
         }
-        address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+        mem_tx_res = address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
                            data, copy);
 
+        if (mem_tx_res == MEMTX_DECODE_ERROR) {
+            warn_report("read from unmapped mmio region gpa=0x%llx size=%i", gpa, bytes);
+            return MMU_TRANSLATE_GPA_UNMAPPED;
+        } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
+            return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
+        }
+
         bytes -= copy;
         gva += copy;
         data += copy;
     }
+    return translate_res;
+}
+
+MMUTranslateResult x86_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    return x86_read_mem_ex(cpu, data, gva, bytes, false);
+}
+
+MMUTranslateResult x86_read_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    return x86_read_mem_ex(cpu, data, gva, bytes, true);
 }
diff --git a/target/i386/emulate/x86_mmu.h b/target/i386/emulate/x86_mmu.h
index 9447ae072c..190bd272a2 100644
--- a/target/i386/emulate/x86_mmu.h
+++ b/target/i386/emulate/x86_mmu.h
@@ -30,15 +30,30 @@
 #define PT_GLOBAL       (1 << 8)
 #define PT_NX           (1llu << 63)
 
-/* error codes */
-#define MMU_PAGE_PT             (1 << 0)
-#define MMU_PAGE_WT             (1 << 1)
-#define MMU_PAGE_US             (1 << 2)
-#define MMU_PAGE_NX             (1 << 3)
+typedef enum MMUTranslateFlags {
+    MMU_TRANSLATE_VALIDATE_WRITE = BIT(1),
+    MMU_TRANSLATE_VALIDATE_EXECUTE = BIT(2),
+    MMU_TRANSLATE_PRIV_CHECKS_EXEMPT = BIT(3)
+} MMUTranslateFlags;
 
-bool mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa);
+typedef enum MMUTranslateResult {
+    MMU_TRANSLATE_SUCCESS = 0,
+    MMU_TRANSLATE_PAGE_NOT_MAPPED = 1,
+    MMU_TRANSLATE_PRIV_VIOLATION = 2,
+    MMU_TRANSLATE_INVALID_PT_FLAGS = 3,
+    MMU_TRANSLATE_GPA_UNMAPPED = 4,
+    MMU_TRANSLATE_GPA_NO_READ_ACCESS = 5,
+    MMU_TRANSLATE_GPA_NO_WRITE_ACCESS = 6
+} MMUTranslateResult;
+
+MMUTranslateResult mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
+
+/* Thin wrappers x86_write_mem_ex/x86_read_mem_ex for code readability */
+MMUTranslateResult x86_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes);
+MMUTranslateResult x86_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes);
+
+MMUTranslateResult x86_write_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes);
+MMUTranslateResult x86_read_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes);
 
-void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes);
-void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes);
 
 #endif /* X86_MMU_H */
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 0b3674ad33..fb039ff7bd 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -252,27 +252,7 @@ static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descript
     vmx_segment_to_x86_descriptor(s, &vmx_segment, desc);
 }
 
-static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
-{
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
-    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
-    vmx_read_mem(cpu, data, gva, bytes);
-}
-
-static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
-{
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
-    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
-    vmx_write_mem(cpu, gva, data, bytes);
-}
-
 static const struct x86_emul_ops hvf_x86_emul_ops = {
-    .read_mem = hvf_read_mem,
-    .write_mem = hvf_write_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
     .handle_io = hvf_handle_io,
     .simulate_rdmsr = hvf_simulate_rdmsr,
@@ -490,6 +470,14 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
+static void hvf_load_crs(CPUState *cs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+}
 void hvf_load_regs(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -802,6 +790,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
             struct x86_decode decode;
 
             hvf_load_regs(cpu);
+            hvf_load_crs(cpu);
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
             hvf_store_regs(cpu);
@@ -843,6 +832,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         }
 
         hvf_load_regs(cpu);
+        hvf_load_crs(cpu);
         decode_instruction(env, &decode);
         assert(ins_len == decode.len);
         exec_instruction(env, &decode);
@@ -948,6 +938,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         struct x86_decode decode;
 
         hvf_load_regs(cpu);
+        hvf_load_crs(cpu);
         decode_instruction(env, &decode);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index e98f480f41..7fe710aca3 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -72,7 +72,7 @@ bool x86_read_segment_descriptor(CPUState *cpu,
         return false;
     }
 
-    vmx_read_mem(cpu, desc, base + sel.index * 8, sizeof(*desc));
+    x86_read_mem_priv(cpu, desc, base + sel.index * 8, sizeof(*desc));
     return true;
 }
 
@@ -95,7 +95,7 @@ bool x86_write_segment_descriptor(CPUState *cpu,
         printf("%s: gdt limit\n", __func__);
         return false;
     }
-    vmx_write_mem(cpu, base + sel.index * 8, desc, sizeof(*desc));
+    x86_write_mem_priv(cpu, desc, base + sel.index * 8, sizeof(*desc));
     return true;
 }
 
@@ -111,7 +111,7 @@ bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
         return false;
     }
 
-    vmx_read_mem(cpu, idt_desc, base + gate * 8, sizeof(*idt_desc));
+    x86_read_mem_priv(cpu, idt_desc, base + gate * 8, sizeof(*idt_desc));
     return true;
 }
 
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index b1e541a642..64e30e970d 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -93,16 +93,16 @@ static int task_switch_32(CPUState *cpu, x86_segment_selector tss_sel, x86_segme
     uint32_t eip_offset = offsetof(struct x86_tss_segment32, eip);
     uint32_t ldt_sel_offset = offsetof(struct x86_tss_segment32, ldt);
 
-    vmx_read_mem(cpu, &tss_seg, old_tss_base, sizeof(tss_seg));
+    x86_read_mem_priv(cpu, &tss_seg, old_tss_base, sizeof(tss_seg));
     save_state_to_tss32(cpu, &tss_seg);
 
-    vmx_write_mem(cpu, old_tss_base + eip_offset, &tss_seg.eip, ldt_sel_offset - eip_offset);
-    vmx_read_mem(cpu, &tss_seg, new_tss_base, sizeof(tss_seg));
+    x86_write_mem_priv(cpu, &tss_seg.eip, old_tss_base + eip_offset, ldt_sel_offset - eip_offset);
+    x86_read_mem_priv(cpu, &tss_seg, new_tss_base, sizeof(tss_seg));
 
     if (old_tss_sel.sel != 0xffff) {
         tss_seg.prev_tss = old_tss_sel.sel;
 
-        vmx_write_mem(cpu, new_tss_base, &tss_seg.prev_tss, sizeof(tss_seg.prev_tss));
+        x86_write_mem_priv(cpu, &tss_seg.prev_tss, new_tss_base, sizeof(tss_seg.prev_tss));
     }
     load_state_from_tss32(cpu, &tss_seg);
     return 0;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f190e83bd1..2bc978deb2 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1548,74 +1548,6 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
     return 0;
 }
 
-static int guest_mem_read_with_gva(const CPUState *cpu, uint64_t gva,
-                                   uint8_t *data, uintptr_t size,
-                                   bool fetch_instruction)
-{
-    int ret;
-    uint64_t gpa, flags;
-
-    flags = HV_TRANSLATE_GVA_VALIDATE_READ;
-    ret = translate_gva(cpu, gva, &gpa, flags);
-    if (ret < 0) {
-        error_report("failed to translate gva to gpa");
-        return -1;
-    }
-
-    ret = mshv_guest_mem_read(gpa, data, size, false, fetch_instruction);
-    if (ret < 0) {
-        error_report("failed to read from guest memory");
-        return -1;
-    }
-
-    return 0;
-}
-
-static int guest_mem_write_with_gva(const CPUState *cpu, uint64_t gva,
-                                    const uint8_t *data, uintptr_t size)
-{
-    int ret;
-    uint64_t gpa, flags;
-
-    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
-    ret = translate_gva(cpu, gva, &gpa, flags);
-    if (ret < 0) {
-        error_report("failed to translate gva to gpa");
-        return -1;
-    }
-    ret = mshv_guest_mem_write(gpa, data, size, false);
-    if (ret < 0) {
-        error_report("failed to write to guest memory");
-        return -1;
-    }
-    return 0;
-}
-
-static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    if (guest_mem_write_with_gva(cpu, addr, data, bytes) < 0) {
-        error_report("failed to write memory");
-        abort();
-    }
-}
-
-static void fetch_instruction(CPUState *cpu, void *data,
-                              target_ulong addr, int bytes)
-{
-    if (guest_mem_read_with_gva(cpu, addr, data, bytes, true) < 0) {
-        error_report("failed to fetch instruction");
-        abort();
-    }
-}
-
-static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    if (guest_mem_read_with_gva(cpu, addr, data, bytes, false) < 0) {
-        error_report("failed to read memory");
-        abort();
-    }
-}
-
 static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
@@ -1634,9 +1566,6 @@ static void read_segment_descriptor(CPUState *cpu,
 }
 
 static const struct x86_emul_ops mshv_x86_emul_ops = {
-    .fetch_instruction = fetch_instruction,
-    .read_mem = read_mem,
-    .write_mem = write_mem,
     .read_segment_descriptor = read_segment_descriptor,
 };
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ab583e922d..561a48206c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -862,16 +862,6 @@ static int whpx_handle_portio(CPUState *cpu,
     return 0;
 }
 
-static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    vmx_write_mem(cpu, addr, data, bytes);
-}
-
-static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    vmx_read_mem(cpu, data, addr, bytes);
-}
-
 static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
@@ -891,8 +881,6 @@ static void read_segment_descriptor(CPUState *cpu,
 
 
 static const struct x86_emul_ops whpx_x86_emul_ops = {
-    .read_mem = read_mem,
-    .write_mem = write_mem,
     .read_segment_descriptor = read_segment_descriptor,
     .handle_io = handle_io
 };
-- 
2.50.1 (Apple Git-155)


