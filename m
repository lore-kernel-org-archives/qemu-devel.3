Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F5C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh17m-0000Lc-8y; Tue, 07 Jul 2026 04:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wh17k-0000L6-95
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:25:48 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wh17i-0001St-Gp
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:25:48 -0400
Received: from laptop.localdomain (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 433E520B7166;
 Tue,  7 Jul 2026 01:25:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 433E520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783412741;
 bh=HKh3udJGRc2A5Y0o6FzBqN4QJ7N4TboBz3L3b0Nkqw8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YAPeHM/MG8wXaUBWd4WW+UIqI+z8tPKviQoMSpVzoZteK26V8Ii1RKFghF5Rf7RT8
 97DSTxbjZtBLa5IRibj88EpI0rw4T/Fl6PZgfXaSgWTwF0K4yWng5Kysho/dKwaX9v
 +5TbRtLiJfdE5BPC1uHiAb+4RjuTlD838MBMx5M0=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 3/5] target/i386/mshv: remove fallback for register page get
 registers
Date: Tue,  7 Jul 2026 11:25:29 +0300
Message-ID: <20260707082531.178539-4-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707082531.178539-1-dblanzeanu@linux.microsoft.com>
References: <20260707082531.178539-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Change `load_regs` to use the register page when it is mmapped
and is valid.
Eliminate the hypercall based logic and fail in case the register page
is found in an unexpected state.

When retrieving the special registers, there are some registers that are
not present in the register page: TR, LDTR, GDTR, IDTR, CR2, APIC_BASE.
As this registers are not likely to be used in an MMIO/PIO operation,
and to avoid a hypercall overhead we do not retrieve them.

Local testing showed no regression when using this logic. To properly
retrieve all the necessary registers for each decoded operation implies
having a mechanism that tracks the state of each register, which is
beyond the scope of this patch series.

Fixes: 40072a7391
Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 107 +++++++++++-------------------------
 1 file changed, 31 insertions(+), 76 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 3d92d4dbad..619cab05ae 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -270,15 +270,6 @@ static int get_xc_reg(CPUState *cpu)
     return 0;
 }
 
-static enum hv_register_name NON_VP_PAGE_REGISTER_NAMES[6] = {
-    HV_X64_REGISTER_TR,
-    HV_X64_REGISTER_LDTR,
-    HV_X64_REGISTER_GDTR,
-    HV_X64_REGISTER_IDTR,
-    HV_X64_REGISTER_CR2,
-    HV_X64_REGISTER_APIC_BASE,
-};
-
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
 {
@@ -615,7 +606,7 @@ static void populate_special_regs(const hv_register_assoc *assocs,
     cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
 }
 
-static void mshv_get_standard_regs_vp_page(CPUState *cpu)
+static void get_standard_regs_vp_page(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
@@ -643,13 +634,19 @@ static void mshv_get_standard_regs_vp_page(CPUState *cpu)
     rflags_to_lflags(env);
 }
 
-static int mshv_get_special_regs_vp_page(CPUState *cpu)
+/*
+ * This function synchronizes the special registers present in the
+ * register vp page, which are not all the special registers.
+ * The rest of the special registers (LD, TR, GDT, IDT, CR2, APIC_BASE)
+ * are not synchronized to avoid the overhead of a hypercall.
+ *
+ * These special registers are not normally used by the guest,
+ * and are only used in some specific cases.
+ */
+static void get_special_regs_vp_page(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
-    struct hv_register_assoc assocs[ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES)];
-    int ret;
-    size_t n_regs = ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES);
     hv_x64_segment_register seg;
 
     /* Populate special registers that are in the VP register page */
@@ -672,46 +669,15 @@ static int mshv_get_special_regs_vp_page(CPUState *cpu)
     populate_segment_reg(&seg, &env->segs[R_FS]);
     memcpy(&seg, &env->regs_page->gs, sizeof(hv_x64_segment_register));
     populate_segment_reg(&seg, &env->segs[R_GS]);
-
-    /* The rest of the special registers that are not in the VP register page */
-    for (size_t i = 0; i < n_regs; i++) {
-        assocs[i].name = NON_VP_PAGE_REGISTER_NAMES[i];
-    }
-
-    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
-    if (ret < 0) {
-        error_report("failed to get non-vp-page special registers");
-        return -1;
-    }
-
-    /* Non-VP page registers - TR, LDTR, GDTR, IDTR, CR2, APIC_BASE */
-    populate_segment_reg(&assocs[0].value.segment, &env->tr);
-    populate_segment_reg(&assocs[1].value.segment, &env->ldt);
-
-    populate_table_reg(&assocs[2].value.table, &env->gdt);
-    populate_table_reg(&assocs[3].value.table, &env->idt);
-    env->cr[2] = assocs[4].value.reg64;
-
-    cpu_set_apic_base(x86cpu->apic_state, assocs[5].value.reg64);
-
-    return ret;
 }
 
-static int mshv_get_registers_vp_page(CPUState *cpu)
+static void get_registers_vp_page(CPUState *cpu)
 {
-    int ret;
-
     /* General Purpose Registers  */
-    mshv_get_standard_regs_vp_page(cpu);
+    get_standard_regs_vp_page(cpu);
 
-    /* Special Registers - makes a hypercall */
-    ret = mshv_get_special_regs_vp_page(cpu);
-    if (ret < 0) {
-        error_report("failed to get special registers for vp page");
-        return -1;
-    }
-
-    return 0;
+    /* Special Registers */
+    get_special_regs_vp_page(cpu);
 }
 
 
@@ -735,29 +701,26 @@ static int get_special_regs(CPUState *cpu)
     return 0;
 }
 
-static int load_regs(CPUState *cpu)
+static void load_regs(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-    int ret;
-
-    /* Use register vp page to optimize registers access */
-    if (env->regs_page && env->regs_page->isvalid != 0) {
-        ret = mshv_get_registers_vp_page(cpu);
-        return ret;
-    }
 
-    ret = get_standard_regs(cpu);
-    if (ret < 0) {
-        return ret;
+    /* Check register page pointer and abort if in unexpected state */
+    if (!env->regs_page) {
+        error_report(
+                "load regs: register page not set for vcpu %d",
+                cpu->cpu_index);
+        abort();
     }
-
-    ret = get_special_regs(cpu);
-    if (ret < 0) {
-        return ret;
+    if (env->regs_page->isvalid == 0) {
+        error_report(
+                "load regs: register page invalid for vcpu %d",
+                cpu->cpu_index);
+        abort();
     }
 
-    return 0;
+    get_registers_vp_page(cpu);
 }
 
 static int get_vcpu_events(CPUState *cpu)
@@ -1565,11 +1528,7 @@ static int emulate_instruction(CPUState *cpu,
     int ret;
     x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-    ret = load_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to load registers");
-        return -1;
-    }
+    load_regs(cpu);
 
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
@@ -1872,11 +1831,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    ret = load_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to load registers");
-        return -1;
-    }
+    load_regs(cpu);
 
     direction_flag = (env->eflags & DESC_E_MASK) != 0;
 
@@ -2013,7 +1968,7 @@ static void read_segment_descriptor(CPUState *cpu,
 
     /*
      * SegmentCache stores the hypervisor-provided value verbatim (populated by
-     * mshv_load_regs). We need to convert it to format expected by the
+     * load_regs). We need to convert it to format expected by the
      * instruction emulator. We can have a limit value > 0xfffff with
      * granularity of 0 (byte granularity), which is not representable
      * in real x86_segment_descriptor. In this case we set granularity to 1
-- 
2.53.0


