Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43218C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCupP-0005m7-66; Thu, 08 May 2025 02:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCupN-0005lg-PQ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:33:53 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCupM-0001KY-2E
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746686032; x=1778222032;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GtxDtzHgwEWqiIpd79ApQM6mnGimUGvG06ovc2XOKA0=;
 b=ASUdV0Ll9mncd/jQacEkQfaG7m8U/0zOQF5xHZzOav7OSFzAUYYy3bqL
 VMRuhbQ2gtJvDPpO0p21FShiPEiD1W7PMC9PBmQN1k7Q798HkZ/1nFVG2
 2/JaiBf+1WodVIWpC11VsQcvr2u5r9Fu3CjQC7+TSm4ZmSK1hZVzm0ki7
 Huf7BemYACdaes4A81uBgp7YDuGgQ+JgSWu9itCc3Exq1dHhBMaHvRNGV
 mSmXKWnY7uuR25cQb3TDclxIGlzcvpQXqanTioTPpA7X6j1ZoHtwe+wt+
 eIbEHzC/5yPvObZJ29mZOyP13yjt5nsMVRVTy9V1n86co+prq4/OEndCb g==;
X-CSE-ConnectionGUID: i+SdGelZTCysIQvYQMOkEA==
X-CSE-MsgGUID: 6AQG/dp1RmWCXLMH3eu9ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="70959291"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="70959291"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 23:33:50 -0700
X-CSE-ConnectionGUID: OBC7Gb/1Quy2rpiG87GGAg==
X-CSE-MsgGUID: pbcY7piYT+WDfK+cAjuVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="136695093"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 23:33:47 -0700
Message-ID: <7a2d57be-a0cf-416f-bc46-f757454f5a21@intel.com>
Date: Thu, 8 May 2025 14:33:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 54/55] i386/tdx: Validate phys_bits against host value
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-55-xiaoyao.li@intel.com> <aBjZRsgEkDFc9JgE@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aBjZRsgEkDFc9JgE@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/5/2025 11:29 PM, Zhao Liu wrote:
>> @e -875,6 +876,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>>           return -1;
> 
> Here you has already used "return -1", so...
> 
>>       }
>>   
>> +    if (cpu->phys_bits != host_cpu_phys_bits()) {
>> +        error_report("TDX requires guest CPU physical bits (%u) "
>> +                     "to match host CPU physical bits (%u)",
>> +                     cpu->phys_bits, host_cpu_phys_bits());
>> +        exit(1);
> 
> ...what about "return -1"?

I will change it to return -EINVAL and as well for the above. Since ...

> kvm_init_vcpu() missed a "goto err", but it is not a big deal:
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9862d8ff1d38..05034f622f20 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -595,6 +595,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>           error_setg_errno(errp, -ret,
>                            "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
>                            kvm_arch_vcpu_id(cpu));

... the handling here expects the @ret is a errno.

> +        goto err;
>       }
>       cpu->kvm_vcpu_stats_fd = kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NULL);
> ---
> 
> Overall, LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
>> +    }
>> +
>>       return 0;
>>   }
>>   
>> -- 
>> 2.34.1
>>
>>


