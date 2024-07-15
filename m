Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C666DC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 22:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTU1Z-0000sG-M3; Mon, 15 Jul 2024 18:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sTU1M-00008m-T8
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:18:13 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sTU1L-0007Nv-4h
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721081891; x=1752617891;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2YgFoHODqt4L+Pm9WlXpmTOMLOXM6RHzyurXphg1p8Y=;
 b=c0iEBSCVX7eoHFtl3lYFnV706mIDJfNDAW/BrNA7z1v9iTCicjm4kwha
 aDNaK+2Ge+ukQEntzaMzSF5trKJ6BJjYY0/+oMnejMSLDwLDejKq8t3Vo
 W1K8cND3o1dUZtc5WY+C7kde2DdP4tggN1vIz1Y8rv1DTP9J+HSijwCm9
 0+sjOzxfBdN5zwJId9P76SdUlDNwPRFrNGAy/YdbSxR/8e2Q3iHpPVBoS
 iCh3H1d78c1u2cgEzjIBCfaUAgOZ78JaHnWZeuIce62e9S2r5EIHF7b4w
 lcXOQyI428MjQn9XjTXFC+7NWzOhgXnNOukbZIqiBqiV6YjEJzI2FGB59 g==;
X-CSE-ConnectionGUID: u0YAd0QsTaGzhQq/jI0KQw==
X-CSE-MsgGUID: 2tEO/eeJQdKPx6q0RPSChg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18683579"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="18683579"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 15:18:07 -0700
X-CSE-ConnectionGUID: Mas0uYIbTQyIrIQyyRq/3g==
X-CSE-MsgGUID: 8W8PHA3NSL6zfuM+4XgHKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="54313872"
Received: from unknown (HELO [10.124.109.200]) ([10.124.109.200])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 15:18:06 -0700
Message-ID: <f8f2cfb9-1128-4e1f-a152-3f88587927a1@intel.com>
Date: Mon, 15 Jul 2024 15:18:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] target/i386/kvm: Clean up return values of MSR
 filter related functions
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240715044955.3954304-1-zhao1.liu@intel.com>
 <20240715044955.3954304-8-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240715044955.3954304-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 7/14/2024 9:49 PM, Zhao Liu wrote:
> @@ -5274,13 +5272,13 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
>      }
>  }
>  
> -static bool kvm_install_msr_filters(KVMState *s)
> +static int kvm_install_msr_filters(KVMState *s)
>  {
>      uint64_t zero = 0;
>      struct kvm_msr_filter filter = {
>          .flags = KVM_MSR_FILTER_DEFAULT_ALLOW,
>      };
> -    int r, i, j = 0;
> +    int ret, i, j = 0;
>  
>      for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {

Nit: Since it's a clean up patch, how about replace
KVM_MSR_FILTER_MAX_RANGES with ARRAY_SIZE(msr_handlers), to make the
code consistent in other places to refer to the array size of
msr_handlers[].

>          KVMMSRHandlers *handler = &msr_handlers[i];
> @@ -5304,18 +5302,18 @@ static bool kvm_install_msr_filters(KVMState *s)
>          }
>      }
>  
> -    r = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
> -    if (r) {
> -        return false;
> +    ret = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
> +    if (ret) {
> +        return ret;
>      }
>  
> -    return true;
> +    return 0;
>  }

Nit: Seems ret is not needed here, and can directly return kvm_vm_ioctl();

