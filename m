Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F940CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYth-0002jl-8V; Tue, 16 Sep 2025 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYtP-0002IL-TN
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:01 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYtM-0006qi-GX
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:58 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id B23EB201551D;
 Tue, 16 Sep 2025 09:50:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B23EB201551D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041454;
 bh=+Q/G6oBPcAz/NsYtv5GdYxMdgdVn+iCcKC3nXkDG4OU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jwt8U/kGNzddquEcO03qf8g/Eua3UXJl469eo+Rc5roO0T82KhsZLYbtcsvJmu5++
 dEJ0kmk3jdU+SWh7gBsQGr1kCSiia62oVlnl+18tlXsJwLBQGropCakuslQri4mMYW
 LdplVI09heXpzXZBwSJDwfWiCID7QjALQJT1Sv00=
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
Subject: [PATCH v4 18/27] target/i386/mshv: Register CPUID entries with MSHV
Date: Tue, 16 Sep 2025 18:48:38 +0200
Message-Id: <20250916164847.77883-19-magnuskulke@linux.microsoft.com>
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

Convert the guest CPU's CPUID model into MSHV's format and register it
with the hypervisor. This ensures that the guest observes the correct
CPU feature set during CPUID instructions.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 206 ++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index daa41b92c9..54ab36e76a 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -402,6 +402,206 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
+static void add_cpuid_entry(GList *cpuid_entries,
+                            uint32_t function, uint32_t index,
+                            uint32_t eax, uint32_t ebx,
+                            uint32_t ecx, uint32_t edx)
+{
+    struct hv_cpuid_entry *entry;
+
+    entry = g_malloc0(sizeof(struct hv_cpuid_entry));
+    entry->function = function;
+    entry->index = index;
+    entry->eax = eax;
+    entry->ebx = ebx;
+    entry->ecx = ecx;
+    entry->edx = edx;
+
+    cpuid_entries = g_list_append(cpuid_entries, entry);
+}
+
+static void collect_cpuid_entries(const CPUState *cpu, GList *cpuid_entries)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t leaf, subleaf;
+    size_t max_leaf = 0x1F;
+    size_t max_subleaf = 0x20;
+
+    uint32_t leaves_with_subleaves[] = {0x4, 0x7, 0xD, 0xF, 0x10};
+    int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
+
+    /* Regular leaves without subleaves */
+    for (leaf = 0; leaf <= max_leaf; leaf++) {
+        bool has_subleaves = false;
+        for (int i = 0; i < n_subleaf_leaves; i++) {
+            if (leaf == leaves_with_subleaves[i]) {
+                has_subleaves = true;
+                break;
+            }
+        }
+
+        if (!has_subleaves) {
+            cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
+            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
+                /* all zeroes indicates no more leaves */
+                continue;
+            }
+
+            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            continue;
+        }
+
+        subleaf = 0;
+        while (subleaf < max_subleaf) {
+            cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
+
+            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
+                /* all zeroes indicates no more leaves */
+                break;
+            }
+            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            subleaf++;
+        }
+    }
+}
+
+static int register_intercept_result_cpuid_entry(const CPUState *cpu,
+                                                 uint8_t subleaf_specific,
+                                                 uint8_t always_override,
+                                                 struct hv_cpuid_entry *entry)
+{
+    int ret;
+    int vp_index = cpu->cpu_index;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    struct hv_register_x64_cpuid_result_parameters cpuid_params = {
+        .input.eax = entry->function,
+        .input.ecx = entry->index,
+        .input.subleaf_specific = subleaf_specific,
+        .input.always_override = always_override,
+        .input.padding = 0,
+        /*
+         * With regard to masks - these are to specify bits to be overwritten
+         * The current CpuidEntry structure wouldn't allow to carry the masks
+         * in addition to the actual register values. For this reason, the
+         * masks are set to the exact values of the corresponding register bits
+         * to be registered for an overwrite. To view resulting values the
+         * hypervisor would return, HvCallGetVpCpuidValues hypercall can be
+         * used.
+         */
+        .result.eax = entry->eax,
+        .result.eax_mask = entry->eax,
+        .result.ebx = entry->ebx,
+        .result.ebx_mask = entry->ebx,
+        .result.ecx = entry->ecx,
+        .result.ecx_mask = entry->ecx,
+        .result.edx = entry->edx,
+        .result.edx_mask = entry->edx,
+    };
+    union hv_register_intercept_result_parameters parameters = {
+        .cpuid = cpuid_params,
+    };
+
+    hv_input_register_intercept_result in = {0};
+    in.vp_index = vp_index;
+    in.intercept_type = HV_INTERCEPT_TYPE_X64_CPUID;
+    in.parameters = parameters;
+
+    struct mshv_root_hvcall args = {0};
+    args.code   = HVCALL_REGISTER_INTERCEPT_RESULT;
+    args.in_sz  = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(cpu_fd, &args);
+    if (ret < 0) {
+        error_report("failed to register intercept result for cpuid");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int register_intercept_result_cpuid(const CPUState *cpu,
+                                           struct hv_cpuid *cpuid)
+{
+    int ret = 0, entry_ret;
+    struct hv_cpuid_entry *entry;
+    uint8_t subleaf_specific, always_override;
+
+    for (size_t i = 0; i < cpuid->nent; i++) {
+        entry = &cpuid->entries[i];
+
+        /* set defaults */
+        subleaf_specific = 0;
+        always_override = 1;
+
+        /* Intel */
+        /* 0xb - Extended Topology Enumeration Leaf */
+        /* 0x1f - V2 Extended Topology Enumeration Leaf */
+        /* AMD */
+        /* 0x8000_001e - Processor Topology Information */
+        /* 0x8000_0026 - Extended CPU Topology */
+        if (entry->function == 0xb
+            || entry->function == 0x1f
+            || entry->function == 0x8000001e
+            || entry->function == 0x80000026) {
+            subleaf_specific = 1;
+            always_override = 1;
+        } else if (entry->function == 0x00000001
+            || entry->function == 0x80000000
+            || entry->function == 0x80000001
+            || entry->function == 0x80000008) {
+            subleaf_specific = 0;
+            always_override = 1;
+        }
+
+        entry_ret = register_intercept_result_cpuid_entry(cpu, subleaf_specific,
+                                                          always_override,
+                                                          entry);
+        if ((entry_ret < 0) && (ret == 0)) {
+            ret = entry_ret;
+        }
+    }
+
+    return ret;
+}
+
+static int set_cpuid2(const CPUState *cpu)
+{
+    int ret;
+    size_t n_entries, cpuid_size;
+    struct hv_cpuid *cpuid;
+    struct hv_cpuid_entry *entry;
+    GList *entries = NULL;
+
+    collect_cpuid_entries(cpu, entries);
+    n_entries = g_list_length(entries);
+
+    cpuid_size = sizeof(struct hv_cpuid)
+        + n_entries * sizeof(struct hv_cpuid_entry);
+
+    cpuid = g_malloc0(cpuid_size);
+    cpuid->nent = n_entries;
+    cpuid->padding = 0;
+
+    for (size_t i = 0; i < n_entries; i++) {
+        entry = g_list_nth_data(entries, i);
+        cpuid->entries[i] = *entry;
+        g_free(entry);
+    }
+    g_list_free(entries);
+
+    ret = register_intercept_result_cpuid(cpu, cpuid);
+    g_free(cpuid);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static inline void populate_hv_segment_reg(SegmentCache *seg,
                                            hv_x64_segment_register *hv_reg)
 {
@@ -684,6 +884,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
     int ret;
     int cpu_fd = mshv_vcpufd(cpu);
 
+    ret = set_cpuid2(cpu);
+    if (ret < 0) {
+        error_report("failed to set cpuid");
+        return -1;
+    }
+
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
         error_report("failed to set cpu state");
-- 
2.34.1


