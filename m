Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D9E68961
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R0g-0000i6-LJ; Thu, 31 Oct 2024 04:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0f-0000hi-55
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:29 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0d-0003DC-C0
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365107; x=1761901107;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z19p8e9e9XND5Q1ITuGrozBRS19cwjl+L4Bn8F62g48=;
 b=dX+/FIiTvkRsmMtjnZB+pZj4W2NH5L+j0d4iBg0Y/5iX9aRkHtKIhZtf
 mom+xUYor+2HYcPBsqjcX+ad3mmBvy7VttR9V0BvpOC0LjLeV4cgotGuF
 hZ3TS9U/wEmVBfVeAU2/hrYyBDrPxSZgROXHoq1U+0pUf327fKnUi3/Bl
 H/Xcmler+OGVJXroarzj9+w0ldew1meGyvd9PEq4+U6dRBFKKh81bY9Qf
 VwrWHJ1jRiG+1ho3TcjqqNPpvjNnx2p9WPigWKiQVy6Cz6uIU/UW238rQ
 M6xeuy5j8GDwcO2mPeevHBmhDLAWEORJ9n3qq1L00c3QA4/7ycXNY5wkc g==;
X-CSE-ConnectionGUID: UFVokdjaT8OQl1tnSbhKyw==
X-CSE-MsgGUID: gWWqRkkiRbm1RFS8Tsk5zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492674"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492674"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:25 -0700
X-CSE-ConnectionGUID: qXq2jr3zR7yEwDd5vURq2Q==
X-CSE-MsgGUID: Y6TKblfERNu78hWSJ7SQNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489504"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:23 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 2/8] target/i386: do not rely on ExtSaveArea for
 accelerator-supported XCR0 bits
Date: Thu, 31 Oct 2024 16:52:27 +0800
Message-Id: <20241031085233.425388-3-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031085233.425388-1-tao1.su@linux.intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Right now, QEMU is using the "feature" and "bits" fields of ExtSaveArea
to query the accelerator for the support status of extended save areas.
This is a problem for AVX10, which attaches two feature bits (AVX512F
and AVX10) to the same extended save states.

To keep the AVX10 hacks to the minimum, limit usage of esa->features
and esa->bits.  Instead, just query the accelerator for the 0xD leaf.
Do it in common code and clear esa->size if an extended save state is
unsupported.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c         | 33 +++++++++++++++++++++++++++++++--
 target/i386/kvm/kvm-cpu.c |  4 ----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b912dba2e5..f8b5c28caf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7069,6 +7069,15 @@ static void x86_cpu_set_sgxlepubkeyhash(CPUX86State *env)
 #endif
 }
 
+static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
+{
+    if (!esa->size) {
+        return false;
+    }
+
+    return (env->features[esa->feature] & esa->bits);
+}
+
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -7177,7 +7186,7 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
         if (!((1 << i) & CPUID_XSTATE_XCR0_MASK)) {
             continue;
         }
-        if (env->features[esa->feature] & esa->bits) {
+        if (cpuid_has_xsave_feature(env, esa)) {
             xcr0 |= 1ull << i;
         }
     }
@@ -7315,7 +7324,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     mask = 0;
     for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
-        if (env->features[esa->feature] & esa->bits) {
+        if (cpuid_has_xsave_feature(env, esa)) {
             mask |= (1ULL << i);
         }
     }
@@ -7987,6 +7996,26 @@ static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
 
 static void x86_cpu_post_initfn(Object *obj)
 {
+    static bool first = true;
+    uint64_t supported_xcr0;
+    int i;
+
+    if (first) {
+        first = false;
+
+        supported_xcr0 =
+            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_LO);
+
+        for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+            ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+            if (!(supported_xcr0 & (1 << i))) {
+                esa->size = 0;
+            }
+        }
+    }
+
     accel_cpu_instance_init(CPU(obj));
 }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 6bf8dcfc60..99d1941cf5 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -143,10 +143,6 @@ static void kvm_cpu_xsave_init(void)
         if (!esa->size) {
             continue;
         }
-        if ((x86_cpu_get_supported_feature_word(NULL, esa->feature) & esa->bits)
-            != esa->bits) {
-            continue;
-        }
         host_cpuid(0xd, i, &eax, &ebx, &ecx, &edx);
         if (eax != 0) {
             assert(esa->size == eax);
-- 
2.34.1


