Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9638CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq984-00028X-77; Fri, 29 Mar 2024 06:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97v-000262-If
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:24 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97t-00017E-U5
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711706782; x=1743242782;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UcXLu1O/drx9QFOgVCmPf+BlIYW0CAl3F27Dh66GxMI=;
 b=iogve1bM+Lp77JnRIE20WJQO288rF8TT0vyreI1OOUIrpm/hKyp23jjE
 z0cM8bAsO32qrm5uB8hlo8sv2Z+EbqRabfsE61nTEdiT1wi9nzeStc7HN
 tyA1PdzvZFnN0jtUFEkom93BnE+sVKXOeIjmOShkEXLBVu7AnmEfCPuMF
 PPFy+0k5HKQNBro0zYB2EKZFgcMqYWdzT3zeQp4KCp1iVpIQwKx/qnhvo
 OtbEbf1RenpwBLV4amjrGcjtVArYvulf5Ja742OGLrwyddTaxA5ejFweg
 LzP4jov5TYY1bLgM7apTkOhk2sxeXM/iBQys2WbxyksJ3HEJL8wv6XJYM g==;
X-CSE-ConnectionGUID: 9qAqpmpHQEWGk/BKgUFQCw==
X-CSE-MsgGUID: pwgK1xUZREeHVletxidvhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17519233"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="17519233"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 03:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="21441978"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2024 03:06:18 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-9.1 5/7] target/i386/kvm: Add legacy_kvmclock cpu property
Date: Fri, 29 Mar 2024 18:19:52 +0800
Message-Id: <20240329101954.3954987-6-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, the old kvmclock (KVM_FEATURE_CLOCKSOURCE) and the new
(KVM_FEATURE_CLOCKSOURCE2) are always set/unset together since they have
the same feature name "kvmclock" since the commit 642258c6c7 ("kvm: add
kvmclock to its second bit").

Before renaming the new kvmclock, introduce legacy_kvmclock to inherit
the behavior of both old and new kvmclocks being enabled/disabled at the
same time.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/pc.c              |  1 +
 target/i386/cpu.c         |  1 +
 target/i386/cpu.h         |  7 +++++++
 target/i386/kvm/kvm-cpu.c | 19 +++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9c4b3969cc8a..a452da0a45a1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -80,6 +80,7 @@
 
 GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
+    { TYPE_X86_CPU, "legacy-kvmclock", "true" },
 };
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eef3d08473ed..1b6caf071a6d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7941,6 +7941,7 @@ static Property x86_cpu_properties[] = {
      */
     DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
     DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
+    DEFINE_PROP_BOOL("legacy-kvmclock", X86CPU, legacy_kvmclock, false),
 
     /*
      * From "Requirements for Implementing the Microsoft
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b339f9ce454f..b3ee2a35f2c1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2070,6 +2070,13 @@ struct ArchCPU {
     int32_t hv_max_vps;
 
     bool xen_vapic;
+
+    /*
+     * Compatibility bits for old machine types.
+     * If true, always set/unset KVM_FEATURE_CLOCKSOURCE and
+     * KVM_FEATURE_CLOCKSOURCE2 at the same time.
+     */
+    bool legacy_kvmclock;
 };
 
 typedef struct X86CPUModel X86CPUModel;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index e6b7a46743b5..ae3cb27c8aa8 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -18,6 +18,8 @@
 #include "kvm_i386.h"
 #include "hw/core/accel-cpu.h"
 
+#include "standard-headers/asm-x86/kvm_para.h"
+
 static void kvm_set_guest_phys_bits(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -72,6 +74,23 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
                                                    MSR_IA32_UCODE_REV);
         }
     }
+
+    if (cpu->legacy_kvmclock) {
+        /*
+         * The old and new kvmclock are both set by default from the
+         * oldest KVM supported (v4.5, see "OS requirements" section at
+         * docs/system/target-i386.rst). So when one of them is missing,
+         * it is only possible that the user is actively masking it.
+         * Then, mask both at the same time for compatibility with v9.0
+         * and older QEMU's kvmclock behavior.
+         */
+        if (!(env->features[FEAT_KVM] & CPUID_FEAT_KVM_CLOCK) ||
+            !(env->features[FEAT_KVM] & CPUID_FEAT_KVM_CLOCK2)) {
+            env->features[FEAT_KVM] &= ~(CPUID_FEAT_KVM_CLOCK |
+                                         CPUID_FEAT_KVM_CLOCK2);
+        }
+    }
+
     ret = host_cpu_realizefn(cs, errp);
     if (!ret) {
         return ret;
-- 
2.34.1


