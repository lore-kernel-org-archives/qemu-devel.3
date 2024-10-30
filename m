Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A22D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 03:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5z6T-0007bT-VX; Tue, 29 Oct 2024 23:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5z6R-0007bC-Uq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:10:35 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5z6P-00018a-J7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730257834; x=1761793834;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8EpwmkFImI3e1XkNUJVl3CvS4Bm6xI+t2Vp/geJvKS4=;
 b=BPwSTUvgIAn/CmA57GRafn1cVBXJgBKUavuLeFIja0YprK9xvl03pq91
 QUSL2e/aI8UhU/uXzRpcGZ+JmX/wjAQdHEsqJV03VHct/aAz1vwsFma+3
 cdzhZCZNuqv79eFVbw/QIJBl08Prr3vptVF+uGMVs6mkMCzgE+70r/Sde
 knQk48FWmZwuAUcqlMFccl6AmfbfeLTMG/XyMwxg7yg1z/Z7Rqz211CdO
 2R2MgNRkP0EasIOUlDUB6UrY2iqgzSpOw+V6Vbt4r517apnSh6nInIMka
 3CB3TFfLi66IROFjNz9LUBkLO8CNNReoGrBppOaKATQ+I0Z54sD97pZ6c w==;
X-CSE-ConnectionGUID: AIixHNP1RnG9vuDLh6lxNw==
X-CSE-MsgGUID: ttetuTJ5T9WKoUs6mALWSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52504460"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="52504460"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 20:10:31 -0700
X-CSE-ConnectionGUID: mDgo7/lyRiiAT0DGQdISiA==
X-CSE-MsgGUID: kSU00hZvRBqNLwyI2gyjPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; d="scan'208";a="86727971"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 20:10:29 -0700
Date: Wed, 30 Oct 2024 11:05:23 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyGic6S+/lcuR36v@linux.bj.intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-5-pbonzini@redhat.com>
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 04:18:54PM +0100, Paolo Bonzini wrote:
> From: Tao Su <tao1.su@linux.intel.com>

[ ... ]

>  static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
>  {
>      Object *obj = OBJECT(dev);
> +    X86CPU *cpu = X86_CPU(dev);
> +    CPUX86State *env = &cpu->env;
>  
>      if (!object_property_get_int(obj, "family", &error_abort)) {
>          if (X86_CPU(obj)->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> @@ -5351,6 +5357,14 @@ static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {

CPUID_7_1_EDX_AVX10 is not set now and will be set in x86_cpu_realizefn().
How about just checking !env->avx10_version? Because cpu_x86_cpuid will
also check (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10).

> +        uint32_t eax, ebx, ecx, edx;
> +        x86_cpu_get_supported_cpuid(0x24, 0,
> +                                    &eax, &ebx, &ecx, &edx);
> +
> +        env->avx10_version = ebx & 0xff;
> +    }
> +
>      x86_cpu_realizefn(dev, errp);
>  }
>  
> @@ -6331,6 +6345,9 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
>       */
>      object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
>  
> +    object_property_set_int(OBJECT(cpu), "avx10-version", def->avx10_version,
> +                            &error_abort);

NIT: avx10-version is defined as UINT8, is it better to use object_property_set_uint?

> +
>      x86_cpu_apply_version_props(cpu, model);
>  
>      /*
> @@ -6859,6 +6876,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          break;
>      }
> +    case 0x24: {
> +        *eax = 0;
> +        *ebx = 0;
> +        *ecx = 0;
> +        *edx = 0;
> +        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +            *ebx = env->avx10_version;
> +        }

The CPUIDs of vector lengths are missing here, according to your previous
comment, it should be:

+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
+            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+        }

[ ... ]

