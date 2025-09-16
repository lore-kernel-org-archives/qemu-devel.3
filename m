Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A6CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYtR-0002Gx-Iu; Tue, 16 Sep 2025 12:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYt9-0001km-12
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:44 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYt6-0006oP-59
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:42 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 04CEE20154ED;
 Tue, 16 Sep 2025 09:50:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04CEE20154ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041438;
 bh=Mx1xsQgDHMAVHD2jNZ8xPOqdZeGkSU2umVzz7nLSBKI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jS1T/buW/f6tK0OViWoOAXxt8HYIqhiJmHSqb4cJN3U7eMtrdy4ERmcDSYEOaJeN7
 Oalg3pRJMJGa43lVDLtluQ0rOnoUQXPIXdNQYGgAOeusC8LHP9JD4ZEanQ5CgkhHBs
 wNpbE2LPAjnWO2kutz1DzHpd32BEAI89JPGjUfQk=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 15/27] target/i386/mshv: Implement mshv_get_special_regs()
Date: Tue, 16 Sep 2025 18:48:35 +0200
Message-Id: <20250916164847.77883-16-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
 target/i386/mshv/mshv-cpu.c | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index a893caf254..6f3d5ea9d1 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -91,6 +91,7 @@ void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_get_standard_regs(CPUState *cpu);
+int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f51b6461d1..b32bb7070f 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -52,6 +52,26 @@ static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
     HV_X64_REGISTER_RFLAGS,
 };
 
+static enum hv_register_name SPECIAL_REGISTER_NAMES[17] = {
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
+};
+
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs)
 {
@@ -254,6 +274,84 @@ int mshv_get_standard_regs(CPUState *cpu)
     return 0;
 }
 
+static inline void populate_segment_reg(const hv_x64_segment_register *hv_seg,
+                                        SegmentCache *seg)
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
+static inline void populate_table_reg(const hv_x64_table_register *hv_seg,
+                                      SegmentCache *tbl)
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
+    populate_segment_reg(&assocs[6].value.segment, &env->tr);
+    populate_segment_reg(&assocs[7].value.segment, &env->ldt);
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
+}
+
+
+int mshv_get_special_regs(CPUState *cpu)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    size_t n_regs = ARRAY_SIZE(SPECIAL_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = SPECIAL_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get special registers");
+        return -errno;
+    }
+
+    populate_special_regs(assocs, x86cpu);
+    return 0;
+}
+
 int mshv_load_regs(CPUState *cpu)
 {
     int ret;
@@ -264,6 +362,12 @@ int mshv_load_regs(CPUState *cpu)
         return -1;
     }
 
+    ret = mshv_get_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load special registers");
+        return -1;
+    }
+
     return 0;
 }
 
-- 
2.34.1


