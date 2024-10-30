Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74D6D7497F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 08:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t644L-0004WA-6K; Wed, 30 Oct 2024 04:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t644I-0004Vp-FF
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:28:43 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t644F-0000Cr-Jg
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730276920; x=1761812920;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=plX/QrFmf/4uqIZZhytoOyaYQx0KEJ7GCymIyOfQUPU=;
 b=c14o8rdx0TDIQW46jluw2ZCCchMrBctYd5jo0r2oaLZDxhlxQ74fTso4
 TlIxo7npslxbtbdYVEbYJTKKE0rAEWHIelCuNpLTSXNy01QFGwdToDJfd
 E3gCzsFrPViwLUJ1QfKh6PNZ8Wjea8iSIUqqrbmLcfasrqHHnrgAUOf0M
 Pe2+MG0djf0iYUhbJYXSJCYCd75uOcHmZcnVZ87aHwdrm2OGCOw81uItY
 CyAPk0wnuKI7TeWKNUMkLLw/vIrBIvsljM5WsvEZBVlYwMwW7/s1sTDMT
 oAWkdQ2hwO0hmx5vIBk9D7sZaeR0uggFH+Ce0dUoE5nB5mM3koguRzrKD w==;
X-CSE-ConnectionGUID: FQquSUplRhmalnrtuNzoeQ==
X-CSE-MsgGUID: 7dNq34GZQc+Qj0M3biZYHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="47440691"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="47440691"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 01:28:36 -0700
X-CSE-ConnectionGUID: 3Q259KCGSi2Mba0zv6LIug==
X-CSE-MsgGUID: 8qt8JmReTL2HoLpL3So1nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="87015535"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2024 01:28:34 -0700
Date: Wed, 30 Oct 2024 16:44:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tao1.su@linux.intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyHyBnPvOHsSdh8D@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 04:18:54PM +0100, Paolo Bonzini wrote:
> Date: Tue, 29 Oct 2024 16:18:54 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
>  property
> X-Mailer: git-send-email 2.47.0
> 
> From: Tao Su <tao1.su@linux.intel.com>
> 
> When AVX10 enable bit is set, the 0x24 leaf will be present as "AVX10
> Converged Vector ISA leaf" containing fields for the version number and
> the supported vector bit lengths.
> 
> Introduce avx10-version property so that avx10 version can be controlled
> by user and cpu model. Per spec, avx10 version can never be 0, the default
> value of avx10-version is set to 0 to determine whether it is specified by
> user.

The default value of 0 does not reflect whether the user has set it to 0.
According to the description here, the spec clearly prohibits 0, so
should we report an error when the user sets it to 0?

If so, it might be better to change the default value to -1 and adjust
based on the host's support.

> The default can come from the device model or, for the max model,
> from KVM's reported value.
> 
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
> Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h     |  4 +++
>  target/i386/cpu.c     | 64 ++++++++++++++++++++++++++++++++++++++-----
>  target/i386/kvm/kvm.c |  3 +-
>  3 files changed, 63 insertions(+), 8 deletions(-)

[snip]

> @@ -7611,7 +7644,23 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>          }
>      }
>  
> -    return x86_cpu_have_filtered_features(cpu);
> +    have_filtered_features = x86_cpu_have_filtered_features(cpu);
> +
> +    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +        x86_cpu_get_supported_cpuid(0x24, 0,
> +                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
> +        uint8_t version = ebx_0 & 0xff;
> +
> +        if (version < env->avx10_version) {
> +            if (prefix) {
> +                warn_report("%s: avx10.%d", prefix, env->avx10_version);

Perhaps also tell user about revised version?

warn_report("%s: avx10.%d. Adjust to avx10.%d",
            prefix, env->avx10_version, version);

> +            }
> +            env->avx10_version = version;
> +            have_filtered_features = true;
> +        }
> +    }


Per Tao's comment, perhaps we can check AVX10 and version here (default
version is 0):

@@ -7674,13 +7682,21 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
                                     &eax_0, &ebx_0, &ecx_0, &edx_0);
         uint8_t version = ebx_0 & 0xff;

-        if (version < env->avx10_version) {
+        if (!env->avx10_version) {
+            env->avx10_version = version;
+        } else (version < env->avx10_version) {
             if (prefix) {
-                warn_report("%s: avx10.%d", prefix, env->avx10_version);
+                warn_report("%s: avx10.%d. Adjust to avx10.%d",
+                            prefix, env->avx10_version, version);
             }
             env->avx10_version = version;
             have_filtered_features = true;
         }
+    } else if (env->avx10_version && prefix) {
+        if (prefix) {
+            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        }
+        have_filtered_features = true;
     }

     return have_filtered_features;

> +    return have_filtered_features;
>  }
>  
>  static void x86_cpu_hyperv_realize(X86CPU *cpu)
> @@ -8395,6 +8444,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
>      DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
>      DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
> +    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),

As my first comment, we could consider changing the default value to -1.

Thanks,
Zhao


