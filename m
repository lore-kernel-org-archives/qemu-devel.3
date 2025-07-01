Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44060C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXrD-0003KR-0u; Tue, 01 Jul 2025 06:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWXrB-0003K9-F2; Tue, 01 Jul 2025 06:04:53 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWXr6-0008N4-Sm; Tue, 01 Jul 2025 06:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751364289; x=1782900289;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qa/gTL1PQFxXSd62WV3+sQtGyHAeVwwkiNFkufFufVY=;
 b=mEffLiToSgONHed6nfcVPzAUrXMWfMAgJAsGSrJQRcI0h3+lvKS6gxac
 8XrPSpP1dmhbjte1G+JhBhK88tX7zH1aF2zbRsCjVY1wjQ5oSHNHdeTFF
 8N/tS+s6FWVPD8+E782e9uNTu+L10kkuSSmmoL4pSrqOJSAF0s0uX1eki
 pn6VMHeXj3di5LJ3vnQLYMsNCD4WVnS8Zm2vJKikRSy7J9VwoYKKOSld6
 sx4gP7h+FZiAOEisqyBRR82VW2IKlJbIx6fE+u+F5F6hypUE3sZgB3n8Y
 9fVVpZkicASfis8Z14ao+wJZrBCZhZZzP4jT8XkxkUSVvoAhoqyN8GLUo A==;
X-CSE-ConnectionGUID: f4TvV6FzSECIiST96B4XQg==
X-CSE-MsgGUID: NqikSAhEQSK8aAmcrdBTbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="52853448"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="52853448"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 03:04:42 -0700
X-CSE-ConnectionGUID: AHLNij5AT6m7xTsFjx/rXg==
X-CSE-MsgGUID: lw37YHnxS7qnP7Mv7ZXzrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="153505377"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 01 Jul 2025 03:04:40 -0700
Date: Tue, 1 Jul 2025 18:26:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 qemu-stable@nongnu.org, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <aGO3vOfHUfjgvBQ9@intel.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

(I'd like to CC Sean again to discuss the possibility of user space
 removing arch-capabilities completely for AMD)

On Mon, Jun 30, 2025 at 03:30:25PM +0200, Alexandre Chartre wrote:
> Date: Mon, 30 Jun 2025 15:30:25 +0200
> From: Alexandre Chartre <alexandre.chartre@oracle.com>
> Subject: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on AMD
> X-Mailer: git-send-email 2.43.5
> 
> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
> MSR and it makes no sense to emulate it on AMD.
> 
> As a consequence, VMs created on AMD with qemu -cpu host and using
> KVM will advertise the ARCH_CAPABILITIES feature and provide the
> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
> as the guest OS might not expect this MSR to exist on such cpus (the
> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
> are not defined on the AMD architecture).

This issue looks very similar to this one that others in the community
reported:

https://gitlab.com/qemu-project/qemu/-/issues/3001

But there's a little difference, pls see the below comment...

> A fix was proposed in KVM code, however KVM maintainers don't want to
> change this behavior that exists for 6+ years and suggest changes to be
> done in qemu instead.
>
> So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
> is not provided by default on AMD cpus when the hypervisor emulates it,
> but it can still be provided by explicitly setting arch-capabilities=on.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>  target/i386/cpu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d35e95430..7e136c48df 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          }
>      }
>  
> +    /*
> +     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
> +     * MSR on AMD although this is an Intel-specific MSR; and KVM will
> +     * continue doing so to not change its ABI for existing setups.
> +     *
> +     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
> +     * to prevent providing a cpu with an MSR which is not supposed to
> +     * be there,

Yes, disabling this feature bit makes sense on AMD platform. It's fine
for -cpu host.

> unless it was explicitly requested by the user.

But this could still break Windows, just like issue #3001, which enables
arch-capabilities for EPYC-Genoa. This fact shows that even explicitly
turning on arch-capabilities in AMD Guest and utilizing KVM's emulated
value would even break something.

So even for named CPUs, arch-capabilities=on doesn't reflect the fact
that it is purely emulated, and is (maybe?) harmful.

> +     */
> +    if (IS_AMD_CPU(env) &&
> +        !(env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
> +        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
> +    }
> +

I was considering whether we should tweak it in kvm_arch_get_supported_cpuid()
until I saw this:

else if (function == 7 && index == 0 && reg == R_EDX) {
        /* Not new instructions, just an optimization.  */
        uint32_t edx;
        host_cpuid(7, 0, &unused, &unused, &unused, &edx);
        ret |= edx & CPUID_7_0_EDX_FSRM;

        /*
         * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
         * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
         * returned by KVM_GET_MSR_INDEX_LIST.
         */
        if (!has_msr_arch_capabs) {
            ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
        }
}

What a pity! QEMU had previously workedaround CPUID_7_0_EDX_ARCH_CAPABILITIES
correctly, but since then kvm's commit 0cf9135b773b("KVM: x86: Emulate
MSR_IA32_ARCH_CAPABILITIES on AMD hosts") breaks the balance once again. 
I understand the commit, and it makes up for the mismatch between the
emulated feature bit and the MSR. Now the Windows exposes the problem of
such emulation.

So, to avoid endless workaround thereafter, I think it's time to just
disable arch-capabilities for AMD Guest (after all, closer to the real
hardware environment is better).

Further, it helps to eliminate kernel/kvm concerns when user space resolves
the legacy issues first. At least, IMO, pushing ABI changes in kernel/kvm
needs to show that there is no destruction of pre-existing user space, so
I believe a complete cleanup of QEMU is the appropriate approach.

The attached code is just some simple example to show what I think:
Starting with QEMU v10.1 for AMD Guest, to disable arch-capabilties
feature bit and MSR.

I don't have an AMD CPU, so it's untested. You can feel free to squash
it in your patch. If so, it's better to add a "Resolves" tag in your
commit message:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3001

Thanks,
Zhao
---
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b2116335752d..c175e7d9e7b8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,7 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },

-GlobalProperty pc_compat_10_0[] = {};
+GlobalProperty pc_compat_10_0[] = {
+    { TYPE_X86_CPU, "x-amd-disable-arch-capabs", "false" },
+};
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);

 GlobalProperty pc_compat_9_2[] = {};
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9aa0ea447860..a8e83efd83f6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8336,10 +8336,12 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      *
      * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
      * to prevent providing a cpu with an MSR which is not supposed to
-     * be there, unless it was explicitly requested by the user.
+     * be there.
      */
-    if (IS_AMD_CPU(env) &&
-        !(env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
+    if (cpu->amd_disable_arch_capabs && IS_AMD_CPU(env)) {
+        mark_unavailable_features(cpu, FEAT_7_0_EDX,
+            env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES,
+            "This feature is not available for AMD Guest");
         env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
     }

@@ -9414,6 +9416,8 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
+    DEFINE_PROP_BOOL("x-amd-disable-arch-capabs", X86CPU, amd_disable_arch_capabs,
+                     true),
 };

 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfdf..a3fc80de3a75 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2306,6 +2306,13 @@ struct ArchCPU {
      */
     uint32_t guest_phys_bits;

+    /*
+     * Compatibility bits for old machine types.
+     * If true disable CPUID_7_0_EDX_ARCH_CAPABILITIES and
+     * MSR_IA32_ARCH_CAPABILITIES for AMD Guest.
+     */
+    bool amd_disable_arch_capabs;
+
     /* in order to simplify APIC support, we leave this pointer to the
        user */
     struct DeviceState *apic_state;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 234878c613f6..40a50ae193c7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2368,6 +2368,11 @@ int kvm_arch_init_vcpu(CPUState *cs)

     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);

+    if (cpu->amd_disable_arch_capabs &&
+        !(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
+        has_msr_arch_capabs = false;
+    }
+
     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
         has_msr_tsc_aux = false;
     }





