Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118A5C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl3yl-00049z-2M; Thu, 20 Feb 2025 05:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl3yX-00047N-4Z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:40:14 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl3yT-0007WI-34
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740048009; x=1771584009;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TdzYaPLHZ16bLzvmwwZ5c+AojcvTSJL6pVcmyKLeuvE=;
 b=MyfKFDuql709ZZuEvVk0S2QZxq9+LRvzXP8qjGyUlnKWWmhgDhYHOpib
 qTBSyLuzh6++W9U9bqV4CS/2bkadYR7h1eQamqexoXvH8LPR4i+5Xw+kM
 Y0B0OWL97iPvv2WA4QE7w7wVzhGThwiUGb0nfmKMl0y6zcgXpnb6I3R7b
 9yMykQzUiAz88L7fqMZzB3KrZUZCoVbnuw/iA1F5pMAv6/5wLVdb0yppR
 eM7Sp0Cg0n/SpcDV2xZP69GRr0pKBrzJkE8hr0rEl7elxfyI8CbhpexW6
 p0ECWc46uEAbOOV3/vERsXwS8gGPawkhs7W+zhv3WCIzMeKsHhhfvdz+x w==;
X-CSE-ConnectionGUID: RKCsUKGaS+S/Bt4ct2Xxrw==
X-CSE-MsgGUID: fv2QgriTTl649X66m8K0Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="41076446"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="41076446"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 02:40:02 -0800
X-CSE-ConnectionGUID: 4Io3i1pjTgiuFU3HtpbDOw==
X-CSE-MsgGUID: Yo7MKmgDTMi9F1FsY5heQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114856938"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2025 02:40:00 -0800
Date: Thu, 20 Feb 2025 18:59:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
Subject: Re: [PATCH v5 1/6] target/i386: Update EPYC CPU model for Cache
 property, RAS, SVM feature bits
Message-ID: <Z7cLFrIPmrUGuqp4@intel.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <c777bf763a636c8922164a174685b4f03864452f.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c777bf763a636c8922164a174685b4f03864452f.1738869208.git.babu.moger@amd.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

> +static CPUCaches epyc_v5_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,
> +        .self_init = 1,

For consistency as the below parts, it's better to code `true` for all
boolean types.

> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 64 * KiB,
> +        .line_size = 64,
> +        .associativity = 4,
> +        .partitions = 1,
> +        .sets = 256,
> +        .lines_per_tag = 1,
> +        .self_init = 1,

ditto.

Others are fine for me, so,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


And one more thing :-) ...

>  static const CPUCaches epyc_rome_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
>          .type = DATA_CACHE,
> @@ -5207,6 +5261,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                  },
>                  .cache_info = &epyc_v4_cache_info
>              },
> +            {
> +                .version = 5,
> +                .props = (PropValue[]) {
> +                    { "overflow-recov", "on" },
> +                    { "succor", "on" },

When I checks the "overflow-recov" and "succor" enabling, I find these 2
bits are set unconditionally.

I'm not sure if all AMD platforms support both bits, do you think it's
necessary to check the host support?

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee812..03e463076632 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -555,7 +555,10 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
         ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
     } else if (function == 0x80000007 && reg == R_EBX) {
-        ret |= CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR;
+        uint32_t ebx;
+        host_cpuid(0x80000007, 0, &unused, &ebx, &unused, &unused);
+
+        ret |= ebx & (CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR);
     } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
         /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
          * be enabled without the in-kernel irqchip

Thanks,
Zhao



