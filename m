Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5D3FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKr7-0000gZ-2y; Tue, 05 May 2026 14:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wKKr5-0000fp-Le
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:50:51 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wKKr2-0006jT-OO
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:50:51 -0400
Received: from laptop.localdomain (unknown [86.121.140.248])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4B23120B7168;
 Tue,  5 May 2026 11:50:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B23120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778007044;
 bh=hJxydqpkaxAkHgGCUh/fsgKB/bQh6BDju7BvGawDrFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JQMjRLm4xmFoZenodmwBneojEJoWS9XVrugZBK6hLPl0+bIIA6Tm1hx7eGrq0Mi7g
 0o55AQ7pNJVIb0uZGMsEtcLCrDYmR8fYu4wTg3hKOzoVeVtVEH5os7OlmXtHsnOoZc
 4WNd5oeJ9mbihetNaSTb8Q+bBFNdrHf65oWHpra0=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 5/7] target/i386/mshv: use the register page to get
 registers
Date: Tue,  5 May 2026 21:50:26 +0300
Message-ID: <20260505185028.237207-6-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Change the mshv_load_regs to use the register page when it is mmapped
and is valid.
Otherwise use the existing logic that uses ioctls to fetch registers.

When retrieving the special registers, there are some registers that are
not present in the register page: TR, LDTR, GDTR, IDTR, CR2, APIC_BASE.
As this registers are not likely to be used in an MMIO/PIO operation,
and to avoid a hypercall overhead we do not retrieve them.

Local testing showed no regression when using this logic. To properly
retrieve all the necessary registers for each decoded operation implies
having a mechanism that tracks the state of each register, which is
beyond the scope of this patch series.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 99 +++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 9 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 3a3c269c33..c84d3f76de 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -401,6 +401,80 @@ static void populate_special_regs(const hv_register_assoc *assocs,
     cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
 }
 
+static void mshv_get_standard_regs_vp_page(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+
+    /* General Purpose Registers  */
+    env->regs[R_EAX] = env->regs_page->rax;
+    env->regs[R_EBX] = env->regs_page->rbx;
+    env->regs[R_ECX] = env->regs_page->rcx;
+    env->regs[R_EDX] = env->regs_page->rdx;
+    env->regs[R_ESI] = env->regs_page->rsi;
+    env->regs[R_EDI] = env->regs_page->rdi;
+    env->regs[R_ESP] = env->regs_page->rsp;
+    env->regs[R_EBP] = env->regs_page->rbp;
+    env->regs[R_R8]  = env->regs_page->r8;
+    env->regs[R_R9]  = env->regs_page->r9;
+    env->regs[R_R10] = env->regs_page->r10;
+    env->regs[R_R11] = env->regs_page->r11;
+    env->regs[R_R12] = env->regs_page->r12;
+    env->regs[R_R13] = env->regs_page->r13;
+    env->regs[R_R14] = env->regs_page->r14;
+    env->regs[R_R15] = env->regs_page->r15;
+
+    env->eip = env->regs_page->rip;
+    env->eflags = env->regs_page->rflags;
+    rflags_to_lflags(env);
+}
+
+/*
+ * This function synchronizes the special registers present in the
+ * register vp page, which are not all the special registers.
+ * The rest of the special registers (LD, TR, GDT, IDT, CR2, APIC_BASE)
+ * are not synchronized to avoid the overhead of a hypercall.
+ *
+ * These special registers are not normally used by the guest,
+ * and are only used in some specific cases.
+ */
+static void mshv_get_special_regs_vp_page(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    hv_x64_segment_register seg;
+
+    /* Populate special registers that are in the VP register page */
+    env->cr[0] = env->regs_page->cr0;
+    env->cr[3] = env->regs_page->cr3;
+    env->cr[4] = env->regs_page->cr4;
+    env->efer = env->regs_page->efer;
+    cpu_set_apic_tpr(x86cpu->apic_state, env->regs_page->cr8);
+
+    /* Segment Registers - copy from packed struct to avoid unaligned access */
+    memcpy(&seg, &env->regs_page->es, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_ES]);
+    memcpy(&seg, &env->regs_page->cs, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_CS]);
+    memcpy(&seg, &env->regs_page->ss, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_SS]);
+    memcpy(&seg, &env->regs_page->ds, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_DS]);
+    memcpy(&seg, &env->regs_page->fs, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_FS]);
+    memcpy(&seg, &env->regs_page->gs, sizeof(hv_x64_segment_register));
+    populate_segment_reg(&seg, &env->segs[R_GS]);
+}
+
+static void mshv_get_registers_vp_page(CPUState *cpu)
+{
+    /* General Purpose Registers  */
+    mshv_get_standard_regs_vp_page(cpu);
+
+    /* Special Registers */
+    mshv_get_special_regs_vp_page(cpu);
+}
+
 
 int mshv_get_special_regs(CPUState *cpu)
 {
@@ -424,18 +498,25 @@ int mshv_get_special_regs(CPUState *cpu)
 
 int mshv_load_regs(CPUState *cpu)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     int ret;
 
-    ret = mshv_get_standard_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to load standard registers");
-        return -1;
-    }
+    /* Use register vp page to optimize registers access */
+    if (env->regs_page && env->regs_page->isvalid != 0) {
+        mshv_get_registers_vp_page(cpu);
+    } else {
+        ret = mshv_get_standard_regs(cpu);
+        if (ret < 0) {
+            error_report("Failed to load standard registers");
+            return -1;
+        }
 
-    ret = mshv_get_special_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to load special registers");
-        return -1;
+        ret = mshv_get_special_regs(cpu);
+        if (ret < 0) {
+            error_report("Failed to load special registers");
+            return -1;
+        }
     }
 
     return 0;
-- 
2.53.0


