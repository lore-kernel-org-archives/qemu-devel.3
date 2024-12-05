Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B440E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ7KL-0004RZ-Oj; Thu, 05 Dec 2024 03:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJ7KJ-0004PV-Hq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:35:11 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJ7KH-00024u-Dv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733387709; x=1764923709;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6EhgE+cSxBHMQq9DAn0LXtbNeop7oNief4GuRbzxDLA=;
 b=IZYO7RNi96vHL8Y3Gp+NoPX+n5NcjhscOfj+RY6EYLAx+63GfQgwxEeG
 XUPYf0cRDMOqt4fNlKoFuLoHrh/he+OBHhzZWb5kFl7XjyNRwCDbrW4/P
 k1aRhEzIwUpOL+4JvNsQidttWa0ZeK7fYxdO+tqgr8BQxF09bRPxOK299
 09325SSkQP87nBcf7OTLzNF6t8vyHpXM6Krq6UeeTbxccXE182Ucr7TBj
 U9SaI0ZZZCrSduYhgd1jPcccBovCT3TfjAy6RchXOTkGBLkzdO+K5egR2
 ytNJs+sA7qTpct6EcC/0nDpgRoyKr3tfCGxGXkLibHMWd0CIzBR0DhCOe Q==;
X-CSE-ConnectionGUID: oGdoDkdTSzaAkZP41XjZ4A==
X-CSE-MsgGUID: 7eB6NLROR8yqaDmIlMolgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33603478"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33603478"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 00:35:07 -0800
X-CSE-ConnectionGUID: skAed5cDT0+fiy3A67a5gw==
X-CSE-MsgGUID: 4N14x8sMRLu2VERhrawofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="98991646"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 00:35:02 -0800
Message-ID: <be45dbd8-539f-4d79-a708-89fb82bda5b4@intel.com>
Date: Thu, 5 Dec 2024 16:34:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Rolnik
 <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <20241108070609.3653085-3-xiaoyao.li@intel.com> <Z1FUDGnenETEFV6Z@intel.com>
 <e634dbf0-267a-48de-9419-7d978e25c969@intel.com> <Z1Fk1MW7274L/AV5@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z1Fk1MW7274L/AV5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.827, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/5/2024 4:31 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> Thanks for your reply!
> 
> On Thu, Dec 05, 2024 at 03:54:36PM +0800, Xiaoyao Li wrote:
>> Date: Thu, 5 Dec 2024 15:54:36 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v1 2/4] i386/cpu: Set up CPUID_HT in
>>   x86_cpu_expand_features() instead of cpu_x86_cpuid()
>>
>> On 12/5/2024 3:19 PM, Zhao Liu wrote:
>>> Hi Xiaoyao,
>>>
>>> Sorry for late reply.
>>>
>>>> @@ -7490,6 +7489,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>>>>    void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>>>    {
>>>>        CPUX86State *env = &cpu->env;
>>>> +    CPUState *cs = CPU(cpu);
>>>>        FeatureWord w;
>>>>        int i;
>>>>        GList *l;
>>>> @@ -7531,6 +7531,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>>>            }
>>>>        }
>>>> +    if (cs->nr_cores * cs->nr_threads > 1) {
>>>> +        env->features[FEAT_1_EDX] |= CPUID_HT;
>>>> +    }
>>>> +
>>>
>>> We shouldn't place any CLI-configurable features here,
>>> especially after expanding plus_features and minus_features.
>>
>> yah, it needs to be placed before manipulation of plus_features and
>> minus_features.
> 
> Please refer my comment at cover letter, you should do such thing in TDX
> context.

TDX is one of the reasons for this patch, but not the whole reason.

>>> HT has been made configurable since the commit 83629b1 ("target/i386/
>>> cpu: Fix CPUID_HT exposure"), so if you want palce HT here, you
>>> should make it un-configurable first.
>>
>> No, commit 83629b1 doesn't make HT configurable but fix the warning of
>>
>>     warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit
>> 28]
>>
>> when "-cpu *,+ht"
>>
>>> Regarding commit 83629b1, in what cases do we need to actively set HT?
>>
>> when users want to do so. QEMU allows users to so do.
> 
> You haven't told the exact case you are fixing with HT.

just when users try to boot a VM with "-cpu *,+ht -smp n" where n > 1.

This is a valid user configuration. Before commit 83629b1, it got 
warning, and commit 83629b1 tried to fix the warning.

> HT is inherently tied to the topology, and custom modifications to HT
> has already broken this. And I think we shouldn't go any further.

I don't object on this direction.

But it has nothing to do with this patch. This patch is trying to track 
HT in env->features[].

>>> That commit even introduces more issues. Ideally, the hardware being
>>> emulated by setting or masking feature bits should be feature-consistent.
>>>
>>> However, "-cpu *,-ht -smp 2" does not remove the HT flag (which is
>>> unexpected), and "-cpu *,+ht -smp 1" forcibly sets HT (which results in
>>> buggy emulation). :(
>>
>> For the case "-cpu *,-ht -smp 2" we can add some warn like what for AMD:
>>
>>      if (IS_AMD_CPU(env) &&
>>          !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
>>          cs->nr_threads > 1) {
>>              warn_report_once("This family of AMD CPU doesn't support "
>>                               "hyperthreading(%d). Please configure -smp "
>>                               "options properly or try enabling topoext "
>>                               "feature.", cs->nr_threads);
>>      }
>>
>> for the case of "-cpu *,+ht, -smp 1", we can add a dependency between "HT"
>> and "smp > 1", similar as feature_dependencies[]
> 
> So I think the 83629b1 just masked the issue, a thorough fix should be
> to avoid CLI configuration.

Again, I don't object on this direction. But it's another thing against 
this patch.

>>> In fact, HT should not be freely configurable in hardware emulation;
>>> users should configure it in the BIOS.
>>
>> How users configure it in the BIOS? Or do you mean the BIOS will set/clear
>> it based on the actual (v)cpus get activated? Any reference to teh BIOS
>> spec?
> 
> Sorry, I think we should focus more on this issue. Such rhetorical
> questions are not very helpful...

Sorry? it is you said "users should configure it in the BIOS". I was 
curious on it

> Thanks,
> Zhao
> 


