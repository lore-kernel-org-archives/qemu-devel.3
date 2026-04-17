Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76E7F4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgtk-00036i-4i; Fri, 17 Apr 2026 06:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDgtX-0002es-Pd
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:57:57 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDgtU-0001hK-VB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:57:54 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de
 [80.134.214.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id CAEDA20B7128;
 Fri, 17 Apr 2026 03:57:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAEDA20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776423461;
 bh=y23U10OHhRRPCOKznJ7K98y1+BJGjXnGiGrs7LPC2Jo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iT45tgHu82o/vNt+YxSiFHyX/GkHQw+W6JsL+W0ZLYNQQoE1m2eHqAhuZ86M8rzga
 NtLZiXBNuAfKuxpukA+pRE/n3otCARSNzJ2uvc3gTP/jQdd7jCllPoX56fLMpxmlbY
 9rhH1PkR1zPzq5kT9m/mqAazOIRhDJTpnB1OnSFE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 21/34] target/i386/mshv: migrate MTRR MSRs
Date: Fri, 17 Apr 2026 12:56:05 +0200
Message-Id: <20260417105618.3621-22-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This change roundtrips memory access/caching MSRs. The mapping scheme
is a bit more elaborate on these, so we have added a special handling
instead of individual entries in the MSR mapping table.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/msr.c | 136 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 7 deletions(-)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 0ecd864458..b26375e4c2 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -79,6 +79,10 @@ static const MshvMsrEnvMap msr_env_map[] = {
     { HV_X64_MSR_SIMP,      HV_REGISTER_SIMP,
                             offsetof(CPUX86State, msr_hv_synic_msg_page) },
 
+    /* MTRR default type */
+    { IA32_MSR_MTRR_DEF_TYPE, HV_X64_REGISTER_MSR_MTRR_DEF_TYPE,
+                              offsetof(CPUX86State, mtrr_deftype) },
+
     /* Other */
 
     /* TODO: find out processor features that correlate to unsupported MSRs. */
@@ -90,6 +94,98 @@ static const MshvMsrEnvMap msr_env_map[] = {
                             offsetof(CPUX86State, spec_ctrl) },
 };
 
+/*
+ * The assocs have to be set according to this schema:
+ *      8  entries for 0-7 mtrr_base
+ *      8  entries for mtrr_mask 0-7
+ *      11 entries for 1 x 64k, 2 x 16k, 8 x 4k fixed MTRR
+ *      27 total entries
+ */
+
+#define MSHV_MTRR_MSR_COUNT 27
+#define MSHV_MSR_TOTAL_COUNT (ARRAY_SIZE(msr_env_map) + MSHV_MTRR_MSR_COUNT)
+
+static void store_in_env_mtrr_phys(CPUState *cpu,
+                                   const struct hv_register_assoc *assocs,
+                                   size_t n_assocs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, fixed_offset;
+    hv_register_name hv_name;
+    uint64_t base, mask;
+
+    assert(n_assocs == MSHV_MTRR_MSR_COUNT);
+
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        assert(assocs[i].name == hv_name);
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+        assert(assocs[i + MSR_MTRRcap_VCNT].name == hv_name);
+
+        base = assocs[i].value.reg64;
+        mask = assocs[i + MSR_MTRRcap_VCNT].value.reg64;
+        env->mtrr_var[i].base = base;
+        env->mtrr_var[i].mask = mask;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    fixed_offset = MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        assert(assocs[fixed_offset + i].name == hv_name);
+        env->mtrr_fixed[i] = assocs[fixed_offset + i].value.reg64;
+    }
+}
+
+/*
+ * The assocs have to be set according to this schema:
+ *      8  entries for 0-7 mtrr_base
+ *      8  entries for mtrr_mask 0-7
+ *      11 entries for 1 x 64k, 2 x 16k, 8 x 4k fixed MTRR
+ *      27 total entries
+ */
+static void load_from_env_mtrr_phys(const CPUState *cpu,
+                                    struct hv_register_assoc *assocs,
+                                    size_t n_assocs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, fixed_offset;
+    uint64_t base, mask, fixed_value;
+    hv_register_name base_name, mask_name, fixed_name;
+    hv_register_assoc *assoc;
+
+    assert(n_assocs == MSHV_MTRR_MSR_COUNT);
+
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        base = env->mtrr_var[i].base;
+        mask = env->mtrr_var[i].mask;
+
+        base_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        mask_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+
+        assoc = &assocs[i];
+        assoc->name = base_name;
+        assoc->value.reg64 = base;
+
+        assoc = &assocs[i + MSR_MTRRcap_VCNT];
+        assoc->name = mask_name;
+        assoc->value.reg64 = mask;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    fixed_offset = MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        fixed_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        fixed_value = env->mtrr_fixed[i];
+
+        assoc = &assocs[fixed_offset + i];
+        assoc->name = fixed_name;
+        assoc->value.reg64 = fixed_value;
+    }
+}
+
 int mshv_init_msrs(const CPUState *cpu)
 {
     int ret;
@@ -131,8 +227,9 @@ static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
     union hv_register_value hv_value;
     ptrdiff_t offset;
     uint32_t hv_name;
+    size_t mtrr_index;
 
-    assert(n_assocs <= (ARRAY_SIZE(msr_env_map)));
+    assert(n_assocs <= MSHV_MSR_TOTAL_COUNT);
 
     for (i = 0, j = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         hv_name = assocs[j].name;
@@ -146,17 +243,38 @@ static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
         MSHV_ENV_FIELD(env, offset) = hv_value.reg64;
         j++;
     }
+
+    mtrr_index = j;
+    store_in_env_mtrr_phys(cpu, &assocs[mtrr_index], MSHV_MTRR_MSR_COUNT);
 }
 
 static void set_hv_name_in_assocs(struct hv_register_assoc *assocs,
                                   size_t n_assocs)
 {
     size_t i;
+    size_t mtrr_offset, mtrr_fixed_offset;
+    hv_register_name hv_name;
+
+    assert(n_assocs == MSHV_MSR_TOTAL_COUNT);
 
-    assert(n_assocs == ARRAY_SIZE(msr_env_map));
     for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         assocs[i].name = msr_env_map[i].hv_name;
     }
+
+    mtrr_offset = ARRAY_SIZE(msr_env_map);
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        assocs[mtrr_offset + i].name = hv_name;
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+        assocs[mtrr_offset + MSR_MTRRcap_VCNT + i].name = hv_name;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    mtrr_fixed_offset = mtrr_offset + MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        assocs[mtrr_fixed_offset + i].name = hv_name;
+    }
 }
 
 static bool msr_supported(uint32_t name)
@@ -181,8 +299,8 @@ static bool msr_supported(uint32_t name)
 int mshv_get_msrs(CPUState *cpu)
 {
     int ret = 0;
-    size_t n_assocs = ARRAY_SIZE(msr_env_map);
-    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
+    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     size_t i, j;
     uint32_t name;
 
@@ -223,8 +341,9 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
     CPUX86State *env = &x86_cpu->env;
     ptrdiff_t offset;
     union hv_register_value *hv_value;
+    size_t mtrr_offset;
 
-    assert(n_assocs == ARRAY_SIZE(msr_env_map));
+    assert(n_assocs == MSHV_MSR_TOTAL_COUNT);
 
     for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         mapping = &msr_env_map[i];
@@ -233,12 +352,15 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
         hv_value = &assocs[i].value;
         hv_value->reg64 = MSHV_ENV_FIELD(env, offset);
     }
+
+    mtrr_offset = ARRAY_SIZE(msr_env_map);
+    load_from_env_mtrr_phys(cpu, &assocs[mtrr_offset], MSHV_MTRR_MSR_COUNT);
 }
 
 int mshv_set_msrs(const CPUState *cpu)
 {
-    size_t n_assocs = ARRAY_SIZE(msr_env_map);
-    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
+    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     int ret;
     size_t i, j;
 
-- 
2.34.1


