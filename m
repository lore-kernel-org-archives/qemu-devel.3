Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A908EEFCE2A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqkn-0005QY-OW; Wed, 04 Mar 2026 13:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkm-0005Q0-AA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:24 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkk-0004QO-IY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648123; x=1804184123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KbgY7aSfXZn9AVFQetDGs5LlZkWw6p0DhvLVbmUtSCc=;
 b=AA1iyBy++jzVP2fZPJhz6P5FR8u0iRDRg+5YIP+pfXV6Y2YRMh9e8Odv
 xEcD0hIqypiz/0H9UnsX6PU3izXA6mAQVu/MPCmg6TUC6RCG1p6yKeJDs
 aiSRz3VOaFCZfw4YaLnwlqklyksAmiLIEAB1XcPsgTC9oIe0v1K4iOY3X
 KEoh7HfuSFscq1TNPScyi4hscusPFSrfSeqGAYdyZ7G6AewI1dkco3MJk
 rUzNaur0Nx1EvF0vfUJkKECU5kuFgq5ka2zE7mEDJCFTv/1/ecXzN9cUj
 F6ptmsUQHRBqZFgnGMtLr5B3yhk1PubByYJNRlgdGtobQwJrf9ncAfxXS A==;
X-CSE-ConnectionGUID: C/kt7BbYTxmBmkpMm4FujQ==
X-CSE-MsgGUID: d+QFoizMSoeN4qjhX02JGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909374"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909374"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:22 -0800
X-CSE-ConnectionGUID: RUNNrqBJSSeoDpsv2DkdAg==
X-CSE-MsgGUID: XX4oF/bOSXKVEXGO7L2Mpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542840"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:21 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 09/13] target/i386: Clean up LBR format handling
Date: Wed,  4 Mar 2026 10:07:08 -0800
Message-ID: <20260304180713.360471-10-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

Since the lbr-fmt property is masked with PERF_CAP_LBR_FMT in
DEFINE_PROP_UINT64_CHECKMASK(), there is no need to explicitly validate
user-requested lbr-fmt values.

The PMU feature is only supported when running under KVM, so initialize
cpu->lbr_fmt in kvm_cpu_instance_init().  Use -1 as the default lbr-fmt,
rather than initializing it with ~PERF_CAP_LBR_FMT, which is misleading
as it suggests a semantic relationship that does not exist.

Rename requested_lbr_fmt to a more generic guest_fmt.  When lbr-fmt is
not specified and cpu->migratable is false, the guest lbr_fmt value is
not user-requested.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: New patch.
---
 target/i386/cpu.c         | 18 ++++++------------
 target/i386/kvm/kvm-cpu.c |  2 ++
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 89691fba45e1..da2e67ca1faf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9776,7 +9776,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    unsigned requested_lbr_fmt;
+    unsigned guest_fmt;
 
     if (!kvm_enabled())
         cpu->enable_pmu = false;
@@ -9816,11 +9816,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
      * with user-provided setting.
      */
-    if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
-        if ((cpu->lbr_fmt & PERF_CAP_LBR_FMT) != cpu->lbr_fmt) {
-            error_setg(errp, "invalid lbr-fmt");
-            return;
-        }
+    if (cpu->lbr_fmt != -1) {
         env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
         env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
     }
@@ -9829,9 +9825,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * vPMU LBR is supported when 1) KVM is enabled 2) Option pmu=on and
      * 3)vPMU LBR format matches that of host setting.
      */
-    requested_lbr_fmt =
-        env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
-    if (requested_lbr_fmt && kvm_enabled()) {
+    guest_fmt = env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
+    if (guest_fmt) {
         uint64_t host_perf_cap =
             x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
         unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
@@ -9840,10 +9835,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
             return;
         }
-        if (requested_lbr_fmt != host_lbr_fmt) {
+        if (guest_fmt != host_lbr_fmt) {
             error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
                         "the host value (0x%x).",
-                        requested_lbr_fmt, host_lbr_fmt);
+                        guest_fmt, host_lbr_fmt);
             return;
         }
     }
@@ -10264,7 +10259,6 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
 
     object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
-    cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
     object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
 
     if (xcc->model) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index c34d9f15c7e8..1d0047d037c7 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -230,6 +230,8 @@ static void kvm_cpu_instance_init(CPUState *cs)
         kvm_cpu_max_instance_init(cpu);
     }
 
+    cpu->lbr_fmt = -1;
+
     kvm_cpu_xsave_init();
 }
 
-- 
2.53.0


