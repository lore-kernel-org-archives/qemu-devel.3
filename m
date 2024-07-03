Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E59C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP1IQ-0005Ok-T1; Wed, 03 Jul 2024 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sP1IP-0005NV-Qw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:49:21 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sP1IN-0007R5-Rc
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720018160; x=1751554160;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JVrueHNNOhvhCKSazgdeZv0/MMlgdnfaeeMIbJ7htxI=;
 b=jeQ5gwEBxvwxhRoEZT22DVQfuDDpnTmY99sW1zwuY0aZsQfNdY4wWNaO
 5bXPZy6OeIGuC1R0NsAB+dj7/QlIo55dT5dYoKs3BWmuCubKivn6Q17Qg
 jEer/je35iwzDrwDwCp++cEprc4Lr5JLCFOmVz9My96QpkoEF2omuz3V2
 C5IIW2wSMT8N3AWlWGdDCYAFn+kysq4EFr3JXTsfif6WWHaVxyy66UobD
 45t9wHphmOAD7vanoiPzGe0spEJkBpRAgvM7nD+/qdinWcAq7/KVyXWTr
 vp3vl1b6bPK2NCo1Qn78j38Kw49hFIbV0wQ/j0FLsNbt6pOxqEiyOUpqn g==;
X-CSE-ConnectionGUID: TNTW+i35Rt69HeE2f2dKgA==
X-CSE-MsgGUID: p98n1IVLQBKObtXNMa7ExA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17075909"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="17075909"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 07:49:17 -0700
X-CSE-ConnectionGUID: vWrv+PNgRAyNZEzP7WYFuQ==
X-CSE-MsgGUID: 5x3dQNyoTAWyi3Uu9jOrZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="51464871"
Received: from unknown (HELO tdx-lm.sh.intel.com) ([10.239.53.27])
 by orviesa004.jf.intel.com with ESMTP; 03 Jul 2024 07:49:15 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: pbonzini@redhat.com, peterx@redhat.com, mtosatti@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>,
	Lei Wang <lei4.wang@intel.com>
Subject: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid is set
 to false
Date: Wed,  3 Jul 2024 22:49:12 +0800
Message-Id: <20240703144912.130988-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

When enforce_cpuid is set to false, the guest is launched with a filtered
set of features, meaning that unsupported features by the host are removed
from the guest's vCPU model. This could cause issues for live migration.
For example, a guest on the source is running with features A and B. If
the destination host does not support feature B, the stub guest can still
be launched on the destination with feature A only if enforce_cpuid=false.
Live migration can start in this case, though it may fail later when the
states of feature B are put to the destination side. This failure occurs
in the late stage (i.e., stop&copy phase) of the migration flow, where the
source guest has already been paused. Tests show that in such cases the
source guest does not recover, and the destination is unable to resume to
run.

Make "enfore_cpuid=true" a hard requirement for a guest to be migratable,
and change the default value of "enforce_cpuid" to true, making the guest
vCPUs migratable by default. If the destination stub guest has inconsistent
CPUIDs (i.e., destination host cannot support the features defined by the
guest's vCPU model), it fails to boot (with enfore_cpuid=true by default),
thereby preventing migration from occuring. If enfore_cpuid=false is
explicitly added for the guest, the guest is deemed as non-migratable
(via the migration blocker), so the above issue won't occur as the guest
won't be migrated.

Tested-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 target/i386/cpu.c     |  2 +-
 target/i386/kvm/kvm.c | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c2e6f3a71..7db4fe4ead 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8258,7 +8258,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn, 0),
 
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
-    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
+    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, true),
     DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index dd8b0f3313..aee717c1cf 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1741,7 +1741,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
     return 0;
 }
 
-static Error *invtsc_mig_blocker;
+static Error *cpu_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -2012,6 +2012,15 @@ full:
     abort();
 }
 
+static bool kvm_vcpu_need_block_migration(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    return !cpu->enforce_cpuid ||
+           (!env->user_tsc_khz && (env->features[FEAT_8000_0007_EDX] &
+                                   CPUID_APM_INVTSC));
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
@@ -2248,18 +2257,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
 
-    if (!env->user_tsc_khz) {
-        if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
-            invtsc_mig_blocker == NULL) {
-            error_setg(&invtsc_mig_blocker,
-                       "State blocked by non-migratable CPU device"
-                       " (invtsc flag)");
-            r = migrate_add_blocker(&invtsc_mig_blocker, &local_err);
+    if (!cpu_mig_blocker &&  kvm_vcpu_need_block_migration(cpu)) {
+            error_setg(&cpu_mig_blocker,
+                       "State blocked by non-migratable CPU device");
+            r = migrate_add_blocker(&cpu_mig_blocker, &local_err);
             if (r < 0) {
                 error_report_err(local_err);
                 return r;
             }
-        }
     }
 
     if (cpu->vmware_cpuid_freq
@@ -2312,7 +2317,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return 0;
 
  fail:
-    migrate_del_blocker(&invtsc_mig_blocker);
+    migrate_del_blocker(&cpu_mig_blocker);
 
     return r;
 }
-- 
2.27.0


