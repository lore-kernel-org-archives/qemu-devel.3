Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEBBD46C16
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnS-0000Dr-Uj; Wed, 28 Jan 2026 18:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnR-0000Cl-Ku
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:18:01 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnP-0001ir-55
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642279; x=1801178279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lBhmgOoCeHBQeHkVFHU09ZVdbzQMPRSBW0jjTwRm2OU=;
 b=MBV7VDzaaYuJFIBMLIJfrwa/O7Fs7nSr+exwCW2w+8SdPw+NQnNbEm/t
 1Py/7WzMkzEtJIPoxnxgte3kZbJDlFDEq5XCmIh/G/65rKvcfZ1pJk03N
 ZchkpfA+hIjHRcbb327toAWErD4KQorQ5vuErmyBnnxXxatmJUTHtPNdl
 eX1b5pvY0or+yRXbYl7ZmZbSenUuUT++ksZCRiRpGALVvGiDKp5kg3kNA
 KxLVOC+Sej3SVP49OZRyfb3KJkm82Lbs6Cn0TnFokGdJAFbE7XXAZhmnI
 hHn1WY1U/Ma2/gRl9wv79wgmoHW2CPQO6S6MstabS8Tuz7r8vQiau/bNE Q==;
X-CSE-ConnectionGUID: Xc6TaxecSIKmgh3dmrV2Ig==
X-CSE-MsgGUID: 81v+N9y5QOCbX3vMhsHK/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462350"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:43 -0800
X-CSE-ConnectionGUID: zpxgtPShSSOfhBkhCTjQ/Q==
X-CSE-MsgGUID: CCQLBDU8TNeu5lOAgoME6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001791"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:42 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 10/11] target/i386: Add pebs-fmt CPU option
Date: Wed, 28 Jan 2026 15:09:47 -0800
Message-ID: <20260128231003.268981-11-zide.chen@intel.com>
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

Similar to lbr-fmt, target/i386 does not support multi-bit CPU
properties, so the PEBS record format cannot be exposed as a
user-visible CPU feature.

Add a pebs-fmt option to allow users to specify the PEBS format via the
command line.  Since the PEBS state is part of the vmstate, this option
is considered migratable.

With this option, PEBS can be enabled when migratable=on.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: New patch

 target/i386/cpu.c         | 11 ++++++++++-
 target/i386/cpu.h         |  5 +++++
 target/i386/kvm/kvm-cpu.c |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 54f04adb0b48..ec6f49916de3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9796,7 +9796,9 @@ static bool x86_cpu_apply_lbr_pebs_fmt(X86CPU *cpu, uint64_t host_perf_cap,
         shift = PERF_CAP_LBR_FMT_SHIFT;
         name = "lbr";
     } else {
-        return false;
+        mask = PERF_CAP_PEBS_FMT_MASK;
+        shift = PERF_CAP_PEBS_FMT_SHIFT;
+        name = "pebs";
     }
 
     if (user_req != -1) {
@@ -9838,6 +9840,11 @@ static int x86_cpu_pmu_realize(X86CPU *cpu, Error **errp)
         return -EINVAL;
     }
 
+    if (!x86_cpu_apply_lbr_pebs_fmt(cpu, host_perf_cap,
+                                    cpu->pebs_fmt, false, errp)) {
+        return -EINVAL;
+    }
+
     return 0;
 }
 
@@ -10307,6 +10314,7 @@ static void x86_cpu_initfn(Object *obj)
 
     object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
     object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
+    object_property_add_alias(obj, "pebs_fmt", obj, "pebs-fmt");
 
     if (xcc->model) {
         x86_cpu_load_model(cpu, xcc->model);
@@ -10478,6 +10486,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
     DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT_MASK),
+    DEFINE_PROP_UINT64_CHECKMASK("pebs-fmt", X86CPU, pebs_fmt, PERF_CAP_PEBS_FMT_MASK),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_NOTIFY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index aa3c24e0ba13..5ab107dfa29f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -422,6 +422,8 @@ typedef enum X86Seg {
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT_MASK           0x3f
 #define PERF_CAP_LBR_FMT_SHIFT          0x0
+#define PERF_CAP_PEBS_FMT_MASK          0xf
+#define PERF_CAP_PEBS_FMT_SHIFT         0x8
 #define PERF_CAP_FULL_WRITE             (1U << 13)
 #define PERF_CAP_PEBS_BASELINE          (1U << 14)
 
@@ -2399,6 +2401,9 @@ struct ArchCPU {
      */
     uint64_t lbr_fmt;
 
+    /* PEBS_FMT bits in IA32_PERF_CAPABILITIES MSR. */
+    uint64_t pebs_fmt;
+
     /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
      * disabled by default to avoid breaking migration between QEMU with
      * different LMCE configurations.
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index b4500ab69f82..7029629a9d09 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -232,6 +232,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
     }
 
     cpu->lbr_fmt = -1;
+    cpu->pebs_fmt = -1;
 
     kvm_cpu_xsave_init();
 }
-- 
2.52.0


