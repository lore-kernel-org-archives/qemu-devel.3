Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FC1C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trW6N-0008Br-6w; Mon, 10 Mar 2025 01:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trW6H-0008BW-Gc
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 01:54:53 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trW6E-0002PI-VZ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 01:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741586091; x=1773122091;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1if8kCzFykxRHlFQsVAw9s4TMtD6YxgLSUGTBrtLggo=;
 b=X43KfKx1Aqp8nBSErF2vJWiSZdaYZhYnae3D+OocvspaJBKQ9ld7C5X1
 0Ol1D1E22znkcgUAYZdFoLqDzx4C0kQSVvTzTbgt5fZ3hur4SgeSCiTp3
 pbRj3PXliV38a5uAT+Z9cKNNb1NsMWujE6y5bFWJLh3Yssd63zsmePAgX
 1WIZ/PFfh3cJTJT4fSxdQG9H/vBWlU7lvV1DGI06ScgA/YVVVpjx8VXg4
 aemm/A0W9tQ/PNh+SNv+zRKwN1RDVp9iKeqlunrwcY16tX6AVdJkYv824
 SEVC3lFTt9xJ9pyZJBFKmLkNea70LUm6lKAdtl2xx54MKWCqJw17CgxPf g==;
X-CSE-ConnectionGUID: aqQFr6lXTDe1l1puVNrGFg==
X-CSE-MsgGUID: QZzgvhcYTaS2a8VKj1i1Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="59974677"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="59974677"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2025 22:54:47 -0700
X-CSE-ConnectionGUID: KBvqclvjRFqWgIt2V7Es1w==
X-CSE-MsgGUID: WqZ6P5YMQxCmvukuV2rF9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="150828926"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Mar 2025 22:54:43 -0700
Date: Mon, 10 Mar 2025 14:14:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 07/10] target/i386/kvm: query kvm.enable_pmu parameter
Message-ID: <Z86DXK0MAuC+mP/Y@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-8-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302220112.17653-8-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, Mar 02, 2025 at 02:00:15PM -0800, Dongli Zhang wrote:
> Date: Sun,  2 Mar 2025 14:00:15 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v2 07/10] target/i386/kvm: query kvm.enable_pmu parameter
> X-Mailer: git-send-email 2.43.5
> 
> There is no way to distinguish between the following scenarios:
> 
> (1) KVM_CAP_PMU_CAPABILITY is not supported.
> (2) KVM_CAP_PMU_CAPABILITY is supported but disabled via the module
> parameter kvm.enable_pmu=N.
> 
> In scenario (1), there is no way to fully disable AMD PMU virtualization.
> 
> In scenario (2), PMU virtualization is completely disabled by the KVM
> module.

KVM_CAP_PMU_CAPABILITY is introduced since ba7bb663f554 ("KVM: x86:
Provide per VM capability for disabling PMU virtualization") in v5.18,
so I understand you want to handle the old linux before v5.18.

Let's sort out all the cases:

1) v5.18 and after, if the parameter "enable_pmu" is Y and then
   KVM_CAP_PMU_CAPABILITY exists, so everything could work.

2) v5.18 and after, "enable_pmu" is N and then KVM_CAP_PMU_CAPABILITY
   doesn't exist, QEMU needs to helpe user disable vPMU.

3) v5.17 (since "enable_pmu" is introduced in v5.17 since 4732f2444acd
   ("KVM: x86: Making the module parameter of vPMU more common")),
   there's no KVM_CAP_PMU_CAPABILITY and vPMU enablement depends on
   "enable_pmu". QEMU's enable_pmu option should depend on kvm
   parameter.

4) before v5.17, there's no "enable_pmu" so that there's no way to
   fully disable AMD PMU.

IIUC, you want to distinguish 2) and 3). And your current codes won't
break old kernels on 4) because "kvm_pmu_disabled" defaults false.
Therefore, overall the idea of this patch is good for me.

But IMO, the logics all above can be compatible by:

 * First check the KVM_CAP_PMU_CAPABILITY,
 * Only if KVM_CAP_PMU_CAPABILITY doesn't exist, then check the kvm parameter

...instead of always checking the parameter as you are currently doing.

What about this change? :-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4902694129f9..9a6044e41a82 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2055,13 +2055,34 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
          * behavior on Intel platform because current "pmu" property works
          * as expected.
          */
-        if (has_pmu_cap && !X86_CPU(cpu)->enable_pmu) {
-            ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
-                                    KVM_PMU_CAP_DISABLE);
-            if (ret < 0) {
-                error_setg_errno(errp, -ret,
-                                 "Failed to set KVM_PMU_CAP_DISABLE");
-                return ret;
+        if (has_pmu_cap) {
+            if (!X86_CPU(cpu)->enable_pmu) {
+                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
+                                        KVM_PMU_CAP_DISABLE);
+                if (ret < 0) {
+                    error_setg_errno(errp, -ret,
+                                     "Failed to set KVM_PMU_CAP_DISABLE");
+                    return ret;
+                }
+            }
+        } else {
+            /*
+             * KVM_CAP_PMU_CAPABILITY is introduced in Linux v5.18. For old linux,
+             * we have to check enable_pmu parameter for vPMU support.
+             */
+            g_autofree char *kvm_enable_pmu;
+
+            /*
+             * The kvm.enable_pmu's permission is 0444. It does not change until a
+             * reload of the KVM module.
+             */
+            if (g_file_get_contents("/sys/module/kvm/parameters/enable_pmu",
+                &kvm_enable_pmu, NULL, NULL)) {
+                if (*kvm_enable_pmu == 'N' && !X86_CPU(cpu)->enable_pmu) {
+                    error_setg(errp, "Failed to enable PMU since "
+                               "KVM's enable_pmu parameter is disabled");
+                    return -1;
+                }
             }
         }
     }

---

This example not only eliminates the static variable ¡°kvm_pmu_disabled¡±,
but also explicitly informs the user that vPMU is not available and
QEMU's "pmu" option doesn't work.

As a comparison, your patch 8 actually "silently" disables PMU (in the
kvm_init_pmu_info()) and user can only find it in Guest through PMU
exceptions.

Thanks,
Zhao



