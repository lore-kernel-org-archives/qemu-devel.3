Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2039CD46C0F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnI-0008UJ-9L; Wed, 28 Jan 2026 18:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnG-0008RX-EV
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnE-0001j1-Nh
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642269; x=1801178269;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tFX4i3T29aS2SR3Yr9A5LhqF7R5HWjkcRb3UIujv1eE=;
 b=Z0wdHi1t1s/kCW0rV9cQSafy8l8eGsYKi17E2tKqP9sdDonLQfIxzO4s
 tNZTyUai6e2neys3U97qAFkaHtbKKD4UZ65K0JdRHgjHZi7IhRsKWH3W8
 vF5BuPR/mR0+9H7koGmhHSGuBEuYebebaywXc3ns2W9/LXoMv2+i0zvoy
 exCtM8t4KkdQ9XLrfhtf+toY8U8YLsHZgSWGUlu6xlgcA45E/q8LI3swP
 4eddfPfYuwFIprdAaGII3wVYFiDeUWWB0hmEJ/XZ1fRv6suqT6AAwwBPf
 Z6Dyvn6jAVgRxzWUTm+POSZo75hzcgwUcyoIJmLyqBOIiteopb7/M+Q64 g==;
X-CSE-ConnectionGUID: CGiKI/MmRBuqlZCEAh30Mw==
X-CSE-MsgGUID: 6Cky4G2xRRa2d5rJujLAhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462339"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462339"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:41 -0800
X-CSE-ConnectionGUID: eFMJHCByREqk9Vkmu5E7eA==
X-CSE-MsgGUID: baSQ/vM4SuSE2jwU1xiMYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001782"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:41 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 08/11] target/i386: Clean up LBR format handling
Date: Wed, 28 Jan 2026 15:09:45 -0800
Message-ID: <20260128231003.268981-9-zide.chen@intel.com>
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

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- New patch.

 target/i386/cpu.c         | 18 ++++++------------
 target/i386/kvm/kvm-cpu.c |  2 ++
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f2c83b4f259c..09180c718d58 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9788,7 +9788,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    unsigned requested_lbr_fmt;
+    unsigned guest_fmt;
 
     if (!kvm_enabled())
         cpu->enable_pmu = false;
@@ -9828,11 +9828,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
@@ -9841,9 +9837,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
@@ -9852,10 +9847,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
@@ -10279,7 +10274,6 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
 
     object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
-    cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
     object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
 
     if (xcc->model) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 33a8c26bc27c..b4500ab69f82 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -231,6 +231,8 @@ static void kvm_cpu_instance_init(CPUState *cs)
         kvm_cpu_max_instance_init(cpu);
     }
 
+    cpu->lbr_fmt = -1;
+
     kvm_cpu_xsave_init();
 }
 
-- 
2.52.0


