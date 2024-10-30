Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D067D74962
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 05:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t60r4-0006AI-AW; Wed, 30 Oct 2024 01:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t60r3-0006A9-3R
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 01:02:49 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t60r0-0003UP-S1
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 01:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730264567; x=1761800567;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zAf/zWoKGkfr+BCM09VBwFQQ6XnLx2Fc/Cft5W4uFW4=;
 b=JS20ynHzTpp66FumdoU7ac/ppapG4kVvEX43WXnH1lOAnG7O+vH5s2Cl
 hwo3BTb6leoPX+p+nQ3XDck7ooSV/Y2iHTVrH3NpjDt4YnUPMWGhyl1TA
 UPIgP3VWsz+hsCHh6vc/1BzX6YYd82Gc0r9iiCjUa8uNMmzZATmp8j/jx
 YSTt+MUL60eivBT6qVJssJlXU01RNFsnclUZX89AagMuveID0BXBZZhfM
 dQ/vOmcnaUEAglS+2WncAhmvLyp1c96B+OKN+SRFh+JoI0+YN47Lqtug3
 aRsXMk+RaI5ZR71SXw5NKQs/gpkTUWV5WQ5oIanwciqsLljTTMAdK2raU A==;
X-CSE-ConnectionGUID: Z64+CPWeTa2pIvbVIh33Nw==
X-CSE-MsgGUID: VZsauNXQSW+RY0720e3Ygg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33873695"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="33873695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 22:02:43 -0700
X-CSE-ConnectionGUID: UeS7uvp3Td2y1K+ByRGnUw==
X-CSE-MsgGUID: JbISFIS8T3ymBPXdmc2F9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="82610086"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 29 Oct 2024 22:02:42 -0700
Date: Wed, 30 Oct 2024 13:19:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tao1.su@linux.intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 3/8] target/i386: return bool from x86_cpu_filter_features
Message-ID: <ZyHBxSqZVfDtT4q9@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

[snip]

> @@ -7558,7 +7558,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>   *
>   * Returns: 0 if all flags are supported by the host, non-zero otherwise.

Comment can be updated as well. :-)

Returns: true if any flag is not supported by the host, false otherwise.

>   */
> -static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> +static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>  {
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
> @@ -7610,6 +7610,8 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>              mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
>          }
>      }
> +
> +    return x86_cpu_have_filtered_features(cpu);
>  }
>  
>  static void x86_cpu_hyperv_realize(X86CPU *cpu)
> @@ -7707,14 +7709,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
> -
> -    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
> -        error_setg(&local_err,
> -                   accel_uses_host_cpuid() ?
> +    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
> +        if (cpu->enforce_cpuid) {
> +            error_setg(&local_err,

It seems that we don't need local_err here, as this function already has
an errp parameter. I will clean up the error handling of this function
later.

> +                       accel_uses_host_cpuid() ?
>                         "Host doesn't support requested features" :
>                         "TCG doesn't support requested features");
> -        goto out;
> +            goto out;
> +        }
>      }

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


