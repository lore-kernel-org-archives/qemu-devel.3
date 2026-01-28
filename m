Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96682D46C15
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnI-0008UP-AL; Wed, 28 Jan 2026 18:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnG-0008Rr-MA
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnE-0001ih-No
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642269; x=1801178269;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pfTHmiu52aVPiOg3YN+F0zjdcLkkAwysFjXGDpbeVVk=;
 b=Y8qKobdNHmaXPY+dndns1cPpZCWrtHdTn5a62YCqjKuieR9LqjCK7M21
 UP4i5Llt+41eMf40Vq8e6RuyYl+KcFUOBSVdugs9o0RZA6rS515STz5Y0
 WieVqh+7G6mUg4tcDlHNh2FfCR76OuiiG7Is3J40Y0cZN1P9KRQ71sqHM
 OuFHwnwGPA+SSedHInKlusZbML4TV0s3xf7MQOR0HNT5GRwcJWIv9W2fL
 njsjDc8dj7/Btfe0Pif2+4iWmD5innjnEm0zh00I/IVTNguT3z83Ufdev
 VGTtR1RzYezijxD55wsb5sb5DyG9ykcckco6adi2EnV/OYi9ykLBua5Na w==;
X-CSE-ConnectionGUID: EDusTFv6RkeqtZD8JCxWDA==
X-CSE-MsgGUID: S6DlrBFoRMC9aP49cIczrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462346"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462346"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:42 -0800
X-CSE-ConnectionGUID: cjfmxDGETm+B3YW3nNcMyg==
X-CSE-MsgGUID: 8dxBRV9GQyaz9By1/G5Ddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001786"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:41 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 09/11] target/i386: Refactor LBR format handling
Date: Wed, 28 Jan 2026 15:09:46 -0800
Message-ID: <20260128231003.268981-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Detach x86_cpu_pmu_realize() from x86_cpu_realizefn() to keep the latter
focused and easier to follow.  Introduce a dedicated helper,
x86_cpu_apply_lbr_pebs_fmt(), in preparation for adding PEBS format
support without duplicating code.

Convert PERF_CAP_LBR_FMT into separate mask and shift macros to allow
x86_cpu_apply_lbr_pebs_fmt() to be shared with PEBS format handling.

No functional change intended

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- New patch.

 target/i386/cpu.c | 94 +++++++++++++++++++++++++++++++----------------
 target/i386/cpu.h |  3 +-
 2 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 09180c718d58..54f04adb0b48 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9781,6 +9781,66 @@ static bool x86_cpu_update_smp_cache_topo(MachineState *ms, X86CPU *cpu,
 }
 #endif
 
+static bool x86_cpu_apply_lbr_pebs_fmt(X86CPU *cpu, uint64_t host_perf_cap,
+                                  uint64_t user_req, bool is_lbr_fmt,
+                                  Error **errp)
+{
+    CPUX86State *env = &cpu->env;
+    uint64_t mask;
+    unsigned shift;
+    unsigned user_fmt;
+    const char *name;
+
+    if (is_lbr_fmt) {
+        mask = PERF_CAP_LBR_FMT_MASK;
+        shift = PERF_CAP_LBR_FMT_SHIFT;
+        name = "lbr";
+    } else {
+        return false;
+    }
+
+    if (user_req != -1) {
+        env->features[FEAT_PERF_CAPABILITIES] &= ~(mask << shift);
+        env->features[FEAT_PERF_CAPABILITIES] |= (user_req << shift);
+    }
+
+    user_fmt = (env->features[FEAT_PERF_CAPABILITIES] >> shift) & mask;
+
+    if (user_fmt) {
+        unsigned host_fmt = (host_perf_cap >> shift) & mask;
+
+        if (!cpu->enable_pmu) {
+            error_setg(errp, "vPMU: %s is unsupported without pmu=on", name);
+            return false;
+        }
+        if (user_fmt != host_fmt) {
+            error_setg(errp, "vPMU: the %s-fmt value (0x%x) does not match "
+                        "the host value (0x%x).",
+                        name, user_fmt, host_fmt);
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static int x86_cpu_pmu_realize(X86CPU *cpu, Error **errp)
+{
+    uint64_t host_perf_cap =
+        x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
+
+    /*
+     * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
+     * with user-provided setting.
+     */
+    if (!x86_cpu_apply_lbr_pebs_fmt(cpu, host_perf_cap,
+                                    cpu->lbr_fmt, true, errp)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -9788,7 +9848,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    unsigned guest_fmt;
 
     if (!kvm_enabled())
         cpu->enable_pmu = false;
@@ -9824,35 +9883,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
-    /*
-     * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
-     * with user-provided setting.
-     */
-    if (cpu->lbr_fmt != -1) {
-        env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
-        env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
-    }
-
-    /*
-     * vPMU LBR is supported when 1) KVM is enabled 2) Option pmu=on and
-     * 3)vPMU LBR format matches that of host setting.
-     */
-    guest_fmt = env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
-    if (guest_fmt) {
-        uint64_t host_perf_cap =
-            x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
-        unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
-
-        if (!cpu->enable_pmu) {
-            error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
-            return;
-        }
-        if (guest_fmt != host_lbr_fmt) {
-            error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
-                        "the host value (0x%x).",
-                        guest_fmt, host_lbr_fmt);
-            return;
-        }
+    if (x86_cpu_pmu_realize(cpu, errp)) {
+        return;
     }
 
     if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
@@ -10445,7 +10477,7 @@ static const Property x86_cpu_properties[] = {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
-    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT),
+    DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT_MASK),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_NOTIFY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3e2222e105bc..aa3c24e0ba13 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -420,7 +420,8 @@ typedef enum X86Seg {
 #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
-#define PERF_CAP_LBR_FMT                0x3f
+#define PERF_CAP_LBR_FMT_MASK           0x3f
+#define PERF_CAP_LBR_FMT_SHIFT          0x0
 #define PERF_CAP_FULL_WRITE             (1U << 13)
 #define PERF_CAP_PEBS_BASELINE          (1U << 14)
 
-- 
2.52.0


