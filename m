Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805CCC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCo-0000Tm-Mu; Tue, 20 May 2025 07:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCm-0000Pj-5E
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLCj-0001Mh-US
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:19 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1EA132068323;
 Tue, 20 May 2025 04:32:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EA132068323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740727;
 bh=0wIcMXzdSzy4e8J56u0pRhYsNsApdV7beq21jAMG+mI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aJjtHh6gGgOJbGJ75A0Pjbkfa9Pne4TiSSpTZHXomOwGWq1kwLEqUs8JW/HbS8R9c
 v/m7Mv6gxze31mo0meefwJO7NHMfFFAwn1TieAObJ+eC4Ma2QgvPRCrAM7xFHVu9De
 zX1jkWyTbKZtV2cr6J7ecyMYOKwfWaaUwkRTMpEE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 17/25] target/i386/mshv: Implement mshv_get_special_regs()
Date: Tue, 20 May 2025 13:30:10 +0200
Message-Id: <20250520113018.49569-18-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Retrieve special registers (e.g. segment, control, and descriptor
table registers) from MSHV vCPUs.

Various helper functions to map register state representations between
Qemu and MSHV are introduced.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |   1 +
 target/i386/mshv/mshv-cpu.c | 118 +++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 9b78b66a24..055489a6f3 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -109,6 +109,7 @@ void mshv_init_cpu_logic(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_get_standard_regs(CPUState *cpu);
+int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 41584c3f8e..979ee5b8c3 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -58,6 +58,27 @@ static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
     HV_X64_REGISTER_RFLAGS,
 };
 
+static enum hv_register_name SPECIAL_REGISTER_NAMES[18] = {
+    HV_X64_REGISTER_CS,
+    HV_X64_REGISTER_DS,
+    HV_X64_REGISTER_ES,
+    HV_X64_REGISTER_FS,
+    HV_X64_REGISTER_GS,
+    HV_X64_REGISTER_SS,
+    HV_X64_REGISTER_TR,
+    HV_X64_REGISTER_LDTR,
+    HV_X64_REGISTER_GDTR,
+    HV_X64_REGISTER_IDTR,
+    HV_X64_REGISTER_CR0,
+    HV_X64_REGISTER_CR2,
+    HV_X64_REGISTER_CR3,
+    HV_X64_REGISTER_CR4,
+    HV_X64_REGISTER_CR8,
+    HV_X64_REGISTER_EFER,
+    HV_X64_REGISTER_APIC_BASE,
+    HV_REGISTER_PENDING_INTERRUPTION,
+};
+
 static void add_cpu_guard(int cpu_fd)
 {
     QemuMutex *guard;
@@ -215,6 +236,94 @@ int mshv_get_standard_regs(CPUState *cpu)
     return 0;
 }
 
+static void populate_segment_reg(const hv_x64_segment_register *hv_seg,
+                                 SegmentCache *seg)
+{
+    memset(seg, 0, sizeof(SegmentCache));
+
+    seg->base = hv_seg->base;
+    seg->limit = hv_seg->limit;
+    seg->selector = hv_seg->selector;
+
+    seg->flags = (hv_seg->segment_type << DESC_TYPE_SHIFT)
+                 | (hv_seg->present * DESC_P_MASK)
+                 | (hv_seg->descriptor_privilege_level << DESC_DPL_SHIFT)
+                 | (hv_seg->_default << DESC_B_SHIFT)
+                 | (hv_seg->non_system_segment * DESC_S_MASK)
+                 | (hv_seg->_long << DESC_L_SHIFT)
+                 | (hv_seg->granularity * DESC_G_MASK)
+                 | (hv_seg->available * DESC_AVL_MASK);
+
+}
+
+static void populate_table_reg(const hv_x64_table_register *hv_seg,
+                               SegmentCache *tbl)
+{
+    memset(tbl, 0, sizeof(SegmentCache));
+
+    tbl->base = hv_seg->base;
+    tbl->limit = hv_seg->limit;
+}
+
+static void populate_special_regs(const hv_register_assoc *assocs,
+                                  X86CPU *x86cpu)
+{
+    CPUX86State *env = &x86cpu->env;
+
+    populate_segment_reg(&assocs[0].value.segment, &env->segs[R_CS]);
+    populate_segment_reg(&assocs[1].value.segment, &env->segs[R_DS]);
+    populate_segment_reg(&assocs[2].value.segment, &env->segs[R_ES]);
+    populate_segment_reg(&assocs[3].value.segment, &env->segs[R_FS]);
+    populate_segment_reg(&assocs[4].value.segment, &env->segs[R_GS]);
+    populate_segment_reg(&assocs[5].value.segment, &env->segs[R_SS]);
+
+    /* TODO: should we set TR + LDT? */
+    /* populate_segment_reg(&assocs[6].value.segment, &regs->tr); */
+    /* populate_segment_reg(&assocs[7].value.segment, &regs->ldt); */
+
+    populate_table_reg(&assocs[8].value.table, &env->gdt);
+    populate_table_reg(&assocs[9].value.table, &env->idt);
+
+    env->cr[0] = assocs[10].value.reg64;
+    env->cr[2] = assocs[11].value.reg64;
+    env->cr[3] = assocs[12].value.reg64;
+    env->cr[4] = assocs[13].value.reg64;
+
+    cpu_set_apic_tpr(x86cpu->apic_state, assocs[14].value.reg64);
+    env->efer = assocs[15].value.reg64;
+    cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
+
+    /* TODO: should we set those? */
+    /* pending_reg = assocs[17].value.pending_interruption.as_uint64; */
+    /* populate_interrupt_bitmap(pending_reg, regs->interrupt_bitmap); */
+}
+
+
+int mshv_get_special_regs(CPUState *cpu)
+{
+    size_t n_regs = sizeof(SPECIAL_REGISTER_NAMES) / sizeof(hv_register_name);
+    struct hv_register_assoc *assocs;
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    assocs = g_new0(hv_register_assoc, n_regs);
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = SPECIAL_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu_fd, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get special registers");
+        g_free(assocs);
+        return -errno;
+    }
+
+    populate_special_regs(assocs, x86cpu);
+
+    g_free(assocs);
+    return 0;
+}
+
 int mshv_load_regs(CPUState *cpu)
 {
     int ret;
@@ -225,8 +334,13 @@ int mshv_load_regs(CPUState *cpu)
         return -1;
     }
 
-	error_report("unimplemented");
-	abort();
+    ret = mshv_get_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load special registers");
+        return -1;
+    }
+
+    return 0;
 }
 
 int mshv_arch_put_registers(const CPUState *cpu)
-- 
2.34.1


