Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5C1D1266F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Fwa-0001PD-Bq; Tue, 05 Nov 2024 04:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8FwW-0001Ol-A7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:33:44 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8FwU-00056d-AL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730799222; x=1762335222;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=w64hPHh98IYSd/WCdWEVevsIAclFSM5mXCV/+w34kIQ=;
 b=gd3WrvbPgRPaTvDMpcdL7VkISlmAI+UWS8p8cNh8e+5nMPH+9c5WnHRH
 krHmqk4Egpbn2rfjANs2ZhKgdeGLRRsT533HJCVg7QKGB45niWof+jw1e
 smJ7qU/WAYBP65Jlo5nRiB7fL5NKkM9DeQpFTQKrHZw9k97IJpvJunQkw
 nkJ8pR5c1SIjFZZLX4Q/el7wFbKv2o05iMpL1E5ANo3a0BcDmxaydStGq
 yEvbmNr/aZnRopkZAJwcPjSWFhpXXCqYG3cw6noTvubAIqY6pvJa08HpQ
 1vwDJ5Pbjfz6/Gt8t3svfiPtzHQJOxUsi5Sp+0mvZ9oCE5iGWT92L9XYH A==;
X-CSE-ConnectionGUID: ou2xSJI+SYehz6kIMT6CKA==
X-CSE-MsgGUID: gIc7c/Y8R4+/9MlufCctrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29956339"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="29956339"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 01:33:38 -0800
X-CSE-ConnectionGUID: qG0qnis7R5qNFTMbQjiHsQ==
X-CSE-MsgGUID: GaN+Cy+ZQxmtfI+cSd+6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="89083274"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 01:33:33 -0800
Message-ID: <08939cf7-f27b-44c2-93cf-d0951d2d2141@intel.com>
Date: Tue, 5 Nov 2024 17:33:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 59/60] i386/cpu: Set up CPUID_HT in x86_cpu_realizefn()
 instead of cpu_x86_cpuid()
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-60-xiaoyao.li@intel.com>
 <9601f5a1-f1f1-47ab-a240-30331946b584@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <9601f5a1-f1f1-47ab-a240-30331946b584@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/5/2024 5:12 PM, Paolo Bonzini wrote:
> On 11/5/24 07:24, Xiaoyao Li wrote:
>> Otherwise, it gets warnings like below when number of vcpus > 1:
>>
>>    warning: TDX enforces set the feature: CPUID.01H:EDX.ht [bit 28]
>>
>> This is because x86_confidential_guest_check_features() checks
>> env->features[] instead of the cpuid date set up by cpu_x86_cpuid()
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/cpu.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 472ab206d8fe..214a1b00a815 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6571,7 +6571,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>           *edx = env->features[FEAT_1_EDX];
>>           if (threads_per_pkg > 1) {
>>               *ebx |= threads_per_pkg << 16;
>> -            *edx |= CPUID_HT;
>>           }
>>           if (!cpu->enable_pmu) {
>>               *ecx &= ~CPUID_EXT_PDCM;
>> @@ -7784,6 +7783,8 @@ static void x86_cpu_realizefn(DeviceState *dev, 
>> Error **errp)
>>       Error *local_err = NULL;
>>       unsigned requested_lbr_fmt;
>> +    qemu_early_init_vcpu(cs);
>> +
>>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>       /* Use pc-relative instructions in system-mode */
>>       tcg_cflags_set(cs, CF_PCREL);
>> @@ -7851,6 +7852,14 @@ static void x86_cpu_realizefn(DeviceState *dev, 
>> Error **errp)
>>           }
>>       }
>> +    /*
>> +     * It needs to called after feature filter because KVM doesn't 
>> report HT
>> +     * as supported
> 
> Does it, since kvm_arch_get_supported_cpuid() has the following line?
> 
>      if (function == 1 && reg == R_EDX) {
>          ...
>          /* KVM never reports CPUID_HT but QEMU can support when vcpus > 
> 1 */
>          ret |= CPUID_HT;
> 
> ?

It seems I mixed it up with no_autoenable_flags. /faceplam

CPUID_HT doesn't get enabled by x86_cpu_expand_features() for "-cpu 
host/max". It won't be filtered by x86_cpu_filter_features() either 
because QEMU sets it in kvm_arch_get_supported_cpuid().

yes, the comment is wrong and comment needs to be dropped. The code can 
be move up to just below x86_cpu_expand_features() or inside it?

> Paolo
> 
>> +     */
>> +    if (cs->nr_cores * cs->nr_threads > 1) {
>> +        env->features[FEAT_1_EDX] |= CPUID_HT;
>> +    }
> 


