Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAF5C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2rG-0002tL-Pc; Thu, 08 May 2025 11:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2rA-0002WB-Pg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:16 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2r6-0007RF-JD
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716892; x=1778252892;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZIFglDB4yB53JZP871G7sJZRYLRIpiHXXyf1wDSdrU0=;
 b=TdKNXybrMwGbabBndcu5uZYJ3LTy3KpOmjNpPD+oDpfodA+ux6FRPuu1
 +mdUW/kVYmBrY8qVlsaHbEHOWcsi1ruN0g+5D6yVIorQLf2i0x7tFv/7P
 sfDwL7L8Nxm22Myn3w94Q8tbJMjajf5nY6iImw9QM9ZfyR1ZGQHA5y/PW
 MerMDAoIKE+q71EB85Arn5L9WmESeBd4Zcvhsgl06r2439jMCzl5ykFD4
 +prIgP+tFdmdkYR0bhsgvx3sMdOdUt4ItoO9iJbW1G8Ups7gK1aZVChcC
 a29iCfnSxb5Q+jil/gTSaLU/MCPmZvVhiw0LZMZc5APH+A0Y2zd20X6Lh A==;
X-CSE-ConnectionGUID: ygdaTa5oTeep26siinvlHw==
X-CSE-MsgGUID: kBqD6lbgTNa0dziwMezw8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888460"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888460"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:11 -0700
X-CSE-ConnectionGUID: yeLjuSc8RMOoyMbW0m5y/w==
X-CSE-MsgGUID: k3g2HRJ0TgG9xbEkWwublQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440401"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:07:08 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 44/55] i386/tdx: Implement adjust_cpuid_features() for TDX
Date: Thu,  8 May 2025 10:59:50 -0400
Message-ID: <20250508150002.689633-45-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Maintain a TDX specific supported CPUID set, and use it to mask the
common supported CPUID value of KVM. It can avoid newly added supported
features (reported via KVM_GET_SUPPORTED_CPUID) for common VMs being
falsely reported as supported for TDX.

As the first step, initialize the TDX supported CPUID set with all the
configurable CPUID bits. It's not complete because there are other CPUID
bits are supported for TDX but not reported as directly configurable.
E.g. the XFAM related bits, attribute related bits and fixed-1 bits.
They will be handled in the future.

Also, what matters are the CPUID bits related to QEMU's feature word.
Only mask the CPUID leafs which are feature word leaf.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c          | 16 ++++++++++++++++
 target/i386/cpu.h          |  1 +
 target/i386/kvm/kvm.c      |  2 +-
 target/i386/kvm/kvm_i386.h |  1 +
 target/i386/kvm/tdx.c      | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a255f4d1b81f..f91502838023 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1655,6 +1655,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     },
 };
 
+bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg)
+{
+    FeatureWordInfo *wi;
+    FeatureWord w;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        wi = &feature_word_info[w];
+        if (wi->type == CPUID_FEATURE_WORD && wi->cpuid.eax == feature &&
+            (!wi->cpuid.needs_ecx || wi->cpuid.ecx == index) &&
+            wi->cpuid.reg == reg) {
+            return true;
+        }
+    }
+    return false;
+}
+
 typedef struct FeatureMask {
     FeatureWord index;
     uint64_t mask;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3910b488f775..42ef77789ded 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2515,6 +2515,7 @@ void cpu_set_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
+bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg);
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fa46edaeac8d..17d7bf6ae9aa 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -393,7 +393,7 @@ static bool host_tsx_broken(void)
 
 /* Returns the value for a specific register on the cpuid entry
  */
-static uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
+uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
 {
     uint32_t ret = 0;
     switch (reg) {
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index dc696cb7238a..484a1de84d51 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -62,6 +62,7 @@ void kvm_update_msi_routes_all(void *private, bool global,
 struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
                                           uint32_t function,
                                           uint32_t index);
+uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg);
 uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                              uint32_t cpuid_i);
 #endif /* CONFIG_KVM */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0e1fd3e3ffa1..91c6295ddd17 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -45,6 +45,7 @@
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
+static struct kvm_cpuid2 *tdx_supported_cpuid;
 
 /* Valid after kvm_arch_init()->confidential_guest_kvm_init()->tdx_kvm_init() */
 bool is_tdx_vm(void)
@@ -373,6 +374,20 @@ static Notifier tdx_machine_done_notify = {
     .notify = tdx_finalize_vm,
 };
 
+static void tdx_setup_supported_cpuid(void)
+{
+    if (tdx_supported_cpuid) {
+        return;
+    }
+
+    tdx_supported_cpuid = g_malloc0(sizeof(*tdx_supported_cpuid) +
+                    KVM_MAX_CPUID_ENTRIES * sizeof(struct kvm_cpuid_entry2));
+
+    memcpy(tdx_supported_cpuid->entries, tdx_caps->cpuid.entries,
+           tdx_caps->cpuid.nent * sizeof(struct kvm_cpuid_entry2));
+    tdx_supported_cpuid->nent = tdx_caps->cpuid.nent;
+}
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -410,6 +425,8 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    tdx_setup_supported_cpuid();
+
     /* TDX relies on KVM_HC_MAP_GPA_RANGE to handle TDG.VP.VMCALL<MapGPA> */
     if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
         return -EOPNOTSUPP;
@@ -447,6 +464,22 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
     x86cpu->enable_cpuid_0x1f = true;
 }
 
+static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
+                                          uint32_t feature, uint32_t index,
+                                          int reg, uint32_t value)
+{
+    struct kvm_cpuid_entry2 *e;
+
+    if (is_feature_word_cpuid(feature, index, reg)) {
+        e = cpuid_find_entry(tdx_supported_cpuid, feature, index);
+        if (e) {
+            value &= cpuid_entry_get_reg(e, reg);
+        }
+    }
+
+    return value;
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -841,4 +874,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
+    x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
 }
-- 
2.43.0


