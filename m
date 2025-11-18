Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5560CED247
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCGp-0001L9-23; Mon, 17 Nov 2025 22:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGm-0001Kf-GO
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:40 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGk-0004Cz-Ey
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436039; x=1794972039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=itRs9sDLTa1KpZpW5WfGEJxQx/1ikIuO3q3OzD0yhqQ=;
 b=V75okEjy3q5bmUGMeLMMkajCYUMqvhJAURW54iPsoWATZVvTj6LaVyHW
 UAqknduuOiDJvnxYCTM+HUmalqOR1KD090+matzIkggfPZFGFcE/Y3VYc
 qPOoC9lIwevXaS+xLHvL4QUFnyW58vDZcZJ8lQyHTwmtmcuu7Y7MYTemD
 K1f70PNh5fBenz74mlFFdt93rbj4YF6KlAkKSzKPkqiWX2AWQcrgZrrYS
 y92XHVb7qaFuyjLFdDzER8IPkmSeNZFvrXBdekmhRKvRIRNPE2EzwMAQ1
 ddmeiL7mfPLFSuowP1U7wgl7ORnPoQ0ityjAYKyEBRQ313IGi2sDUd1Jt g==;
X-CSE-ConnectionGUID: 1IaNTNTXQs6UEVI+hO7j9w==
X-CSE-MsgGUID: ZEDydnCPTPWs7HUG1wGsjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053779"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053779"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:38 -0800
X-CSE-ConnectionGUID: +RhnrtYQTviyFlq2NTlZug==
X-CSE-MsgGUID: 2T4g6T12T0uBMeJ7MFDFzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537175"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:34 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 06/23] i386/kvm: Initialize x86_ext_save_areas[] based on
 KVM support
Date: Tue, 18 Nov 2025 11:42:14 +0800
Message-Id: <20251118034231.704240-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

At present, in KVM, x86_ext_save_areas[] is initialized based on Host
CPUIDs.

Except AMX xstates, both user & supervisor xstates have their
information exposed in KVM_GET_SUPPORTED_CPUID. Therefore, their entries
in x86_ext_save_areas[] should be filled based on KVM support.

For AMX xstates (XFEATURE_MASK_XTILE_DATA and XFEATURE_MASK_XTILE_CFG),
KVM doesn't report their details before they (mainly
XSTATE_XTILE_DATA_MASK) get permission on host. But this happens within
the function kvm_request_xsave_components(), after the current
initialization. So still fill AMX entries with Host CPUIDs.

In addition, drop a check: "if (eax != 0)" when assert the assert the
size of xstate. In fact, this check is incorrect, since any valid
xstate should have non-zero size of xstate area.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - New commit.
---
 target/i386/cpu.h         |  3 +++
 target/i386/kvm/kvm-cpu.c | 23 +++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3d74afc5a8e7..f065527757c4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -609,6 +609,9 @@ typedef enum X86Seg {
 
 #define XSTATE_DYNAMIC_MASK             (XSTATE_XTILE_DATA_MASK)
 
+#define XSTATE_XTILE_MASK               (XSTATE_XTILE_DATA_MASK | \
+                                         XSTATE_XTILE_CFG_MASK)
+
 #define ESA_FEATURE_ALIGN64_BIT         1
 #define ESA_FEATURE_XFD_BIT             2
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c25b5583955..2e2d47d2948a 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -136,7 +136,7 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
 static void kvm_cpu_xsave_init(void)
 {
     static bool first = true;
-    uint32_t eax, ebx, ecx, edx;
+    uint32_t eax, ebx, ecx, unused;
     int i;
 
     if (!first) {
@@ -154,12 +154,23 @@ static void kvm_cpu_xsave_init(void)
         if (!esa->size) {
             continue;
         }
-        host_cpuid(0xd, i, &eax, &ebx, &ecx, &edx);
-        if (eax != 0) {
-            assert(esa->size == eax);
-            esa->offset = ebx;
-            esa->ecx = ecx;
+
+        /*
+         * AMX xstates are supported in KVM_GET_SUPPORTED_CPUID only when
+         * XSTATE_XTILE_DATA_MASK gets guest permission in
+         * kvm_request_xsave_components().
+         */
+        if (!((1 << i) & XSTATE_XTILE_MASK)) {
+            eax = kvm_arch_get_supported_cpuid(kvm_state, 0xd, i, R_EAX);
+            ebx = kvm_arch_get_supported_cpuid(kvm_state, 0xd, i, R_EBX);
+            ecx = kvm_arch_get_supported_cpuid(kvm_state, 0xd, i, R_ECX);
+        } else {
+            host_cpuid(0xd, i, &eax, &ebx, &ecx, &unused);
         }
+
+        assert(esa->size == eax);
+        esa->offset = ebx;
+        esa->ecx = ecx;
     }
 }
 
-- 
2.34.1


