Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1DCC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 04:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2jmh-00029r-3B; Thu, 10 Apr 2025 00:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2jmQ-00027g-8T; Thu, 10 Apr 2025 00:44:47 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2jmL-0002My-8h; Thu, 10 Apr 2025 00:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744260282; x=1775796282;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aTdHpc5rDqraycZTf4nOde0tkf7843YMHFrARQ0hu2s=;
 b=l15hMNxjUwQ3vRLclCDGaU9h1fRcMCyNTRMm0GruP4BpQBKFEA2yZGNs
 2fpy6Dv5/d19tmEkaEutUkHWiok19w+GDO0ybSuZsEDf2GllRfGJRqrzu
 5Ok4NyPWKPFhpp5vLLGvPfhkoyVF+YjWP8WzMwgTnClzVs3tLbezWz5yB
 fC+yEzZ1KFF5tAGgD6cMBlNvRNYteHVW6VfwYkAJ7EwCFSDqJn3UmOGbx
 neTymY2is79vzzzuthPdeH0bRH1U6vmH5FS06JRewJAXwVI3fyd2JXBSs
 kU/6ZazWFjkJxx5UnWcGDkJQMQTM69+vGV/0Ke5k7XGXhu5hMSyLLUHzJ A==;
X-CSE-ConnectionGUID: 4brudUYCQlm5sIBfwohjkQ==
X-CSE-MsgGUID: HT+NLh19RYq6nyrYBMk3Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="68245487"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="68245487"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 21:44:36 -0700
X-CSE-ConnectionGUID: qcSZQYFES12pOlD3NIbIBQ==
X-CSE-MsgGUID: RIwOMItmTjud9lN6+3ArRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="129620583"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 09 Apr 2025 21:44:26 -0700
Date: Thu, 10 Apr 2025 13:05:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn,
 chenhuacai@kernel.org, philmd@linaro.org, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, npiggin@gmail.com,
 danielhb413@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, flavra@baylibre.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, louisqi@zhaoxin.com,
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com
Subject: Re: [PATCH v3 07/10] target/i386/kvm: query kvm.enable_pmu parameter
Message-ID: <Z/dRiyGTxb8JBE8v@intel.com>
References: <20250331013307.11937-1-dongli.zhang@oracle.com>
 <20250331013307.11937-8-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331013307.11937-8-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

Hi Dongli,

The logic is fine for me :-) And thank you to take my previous
suggestion. When I revisit here after these few weeks, I have some
thoughts:

> +        if (pmu_cap) {
> +            if ((pmu_cap & KVM_PMU_CAP_DISABLE) &&
> +                !X86_CPU(cpu)->enable_pmu) {
> +                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
> +                                        KVM_PMU_CAP_DISABLE);
> +                if (ret < 0) {
> +                    error_setg_errno(errp, -ret,
> +                                     "Failed to set KVM_PMU_CAP_DISABLE");
> +                    return ret;
> +                }
> +            }

This case enhances vPMU disablement.

> +        } else {
> +            /*
> +             * KVM_CAP_PMU_CAPABILITY is introduced in Linux v5.18. For old
> +             * linux, we have to check enable_pmu parameter for vPMU support.
> +             */
> +            g_autofree char *kvm_enable_pmu;
> +
> +            /*
> +             * The kvm.enable_pmu's permission is 0444. It does not change until
> +             * a reload of the KVM module.
> +             */
> +            if (g_file_get_contents("/sys/module/kvm/parameters/enable_pmu",
> +                                    &kvm_enable_pmu, NULL, NULL)) {
> +                if (*kvm_enable_pmu == 'N' && X86_CPU(cpu)->enable_pmu) {
> +                    error_setg(errp, "Failed to enable PMU since "
> +                               "KVM's enable_pmu parameter is disabled");
> +                    return -EPERM;
> +                }

And this case checks if vPMU could enable.

>              }
>          }
>      }

So I feel it's not good enough to check based on pmu_cap, we can
re-split it into these two cases: enable_pmu and !enable_pmu. Then we
can make the code path more clear!

Just like:

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f68d5a057882..d728fb5eaec6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2041,44 +2041,42 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     if (first) {
         first = false;

-        /*
-         * Since Linux v5.18, KVM provides a VM-level capability to easily
-         * disable PMUs; however, QEMU has been providing PMU property per
-         * CPU since v1.6. In order to accommodate both, have to configure
-         * the VM-level capability here.
-         *
-         * KVM_PMU_CAP_DISABLE doesn't change the PMU
-         * behavior on Intel platform because current "pmu" property works
-         * as expected.
-         */
-        if (pmu_cap) {
-            if ((pmu_cap & KVM_PMU_CAP_DISABLE) &&
-                !X86_CPU(cpu)->enable_pmu) {
-                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
-                                        KVM_PMU_CAP_DISABLE);
-                if (ret < 0) {
-                    error_setg_errno(errp, -ret,
-                                     "Failed to set KVM_PMU_CAP_DISABLE");
-                    return ret;
-                }
-            }
-        } else {
-            /*
-             * KVM_CAP_PMU_CAPABILITY is introduced in Linux v5.18. For old
-             * linux, we have to check enable_pmu parameter for vPMU support.
-             */
+        if (X86_CPU(cpu)->enable_pmu) {
             g_autofree char *kvm_enable_pmu;

             /*
-             * The kvm.enable_pmu's permission is 0444. It does not change until
-             * a reload of the KVM module.
+             * The enable_pmu parameter is introduced since Linux v5.17,
+             * give a chance to provide more information about vPMU
+             * enablement.
+             *
+             * The kvm.enable_pmu's permission is 0444. It does not change
+             * until a reload of the KVM module.
              */
             if (g_file_get_contents("/sys/module/kvm/parameters/enable_pmu",
                                     &kvm_enable_pmu, NULL, NULL)) {
-                if (*kvm_enable_pmu == 'N' && X86_CPU(cpu)->enable_pmu) {
-                    error_setg(errp, "Failed to enable PMU since "
+                if (*kvm_enable_pmu == 'N') {
+                    warn_report("Failed to enable PMU since "
                                "KVM's enable_pmu parameter is disabled");
-                    return -EPERM;
+                }
+            }
+        } else {
+            /*
+             * Since Linux v5.18, KVM provides a VM-level capability to easily
+             * disable PMUs; however, QEMU has been providing PMU property per
+             * CPU since v1.6. In order to accommodate both, have to configure
+             * the VM-level capability here.
+             *
+             * KVM_PMU_CAP_DISABLE doesn't change the PMU
+             * behavior on Intel platform because current "pmu" property works
+             * as expected.
+             */
+            if ((pmu_cap & KVM_PMU_CAP_DISABLE)) {
+                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
+                                        KVM_PMU_CAP_DISABLE);
+                if (ret < 0) {
+                    error_setg_errno(errp, -ret,
+                                     "Failed to set KVM_PMU_CAP_DISABLE");
+                    return ret;
                 }
             }
         }




