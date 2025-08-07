Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCA1C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 08:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujvgt-0003Qd-9r; Thu, 07 Aug 2025 04:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ujvgg-0003MJ-J9
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 04:09:25 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ujvgb-0003Ug-MN
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 04:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754554158; x=1786090158;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VxPwqOrbI3ZDR9D/N1QjtZUQZOTlIko4QFgglkb9ZHA=;
 b=Hu7CsWIxj3dvuWNKBK6hT1twDQ7cvNAWuhKFVgrtglwq5ecdLXbrxURY
 LMkRJwdOjVacsDhsLEZg9j4J0Eh3WihMHqMG0tQfMPa8J+k3X4euei0xi
 e8XABe69coqZ8wzlpaLR//6r0dX/OXGiuM4sVIxS5fQ9FhwIfCAwNH/06
 5Phixikc5ZsM5yyO/83n6zJBA+LPNQfwnU8ez4wEgBcmmNFjQFRNd8U63
 M8iGkkNk9hswf+sOtpbhz0Pz5rXWtoBZZY+rCBbYv1GTdBY7uNHwdoKzz
 oqgXve6+HNEBAzoi8CE66YfPzs5Bo5uJ3vygfGLd1x3vh3j1tT8vpIRuJ A==;
X-CSE-ConnectionGUID: GdgWlc6mT0+CylSBG7TFpg==
X-CSE-MsgGUID: 8hc1eZTwT4eBWKgQc+NmaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60722122"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="60722122"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 01:09:14 -0700
X-CSE-ConnectionGUID: 1xwLEUuWS6mL763aOizkiw==
X-CSE-MsgGUID: scvFOpu1QkmMGQ4eSpts1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="170258873"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 01:09:12 -0700
Message-ID: <da824dc2-c241-4858-a233-6253b6b62926@intel.com>
Date: Thu, 7 Aug 2025 16:09:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com>
 <2dbe2da9-895a-45ca-9f41-7ec273e0bb80@intel.com>
 <CAATJJ0Jpn8VMRDOFuk7VaV5jC3tj0V1817OiRa6tH3x1OtYFSQ@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAATJJ0Jpn8VMRDOFuk7VaV5jC3tj0V1817OiRa6tH3x1OtYFSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/7/2025 2:37 PM, Christian Ehrhardt wrote:
> On Thu, Aug 7, 2025 at 5:38 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> On 8/7/2025 3:18 AM, Daniel P. Berrangé wrote:
>>> On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
>>>> On Wed, Aug 6, 2025 at 2:00 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>
>>>>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
>>>>>> Hi,
>>>>>> I was unsure if this would be better sent to libvirt or qemu - the
>>>>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
>>>>>> behaving differently. I did not want to double post and gladly most of
>>>>>> the people are on both lists - since the switch in/out of the problem
>>>>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not yet
>>>>>> having all the answers, I'm sure I could find more with debugging, but
>>>>>> I also wanted to report early for your awareness while we are still in
>>>>>> the RC phase.
>>>>>>
>>>>>>
>>>>>> # Problem
>>>>>>
>>>>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc1 was:
>>>>>>     error: operation failed: guest CPU doesn't match specification:
>>>>>> missing features: pdcm
>>>>>>
>>>>>> This is behaving the same with libvirt 11.4 or the more recent 11.6.
>>>>>> But switching back to qemu 10.0 confirmed that this behavior is new
>>>>>> with qemu 10.1-rc.
>>>>>
>>>>>
>>>>>> Without yet having any hard evidence against them I found a few pdcm
>>>>>> related commits between 10.0 and 10.1-rc1:
>>>>>>     7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
>>>>>>     00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not available
>>>>>>     e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
>>>>>> feature_dependencies[] check
>>>>>>     0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
>>>>>>
>>>>>>
>>>>>> # Caveat
>>>>>>
>>>>>> My test environment is in LXD system containers, that gives me issues
>>>>>> in the power management detection
>>>>>>     libvirtd[406]: error from service: GDBus.Error:System.Error.EROFS:
>>>>>> Read-only file system
>>>>>>     libvirtd[406]: Failed to get host power management capabilities
>>>>>
>>>>> That's harmless.
>>>>
>>>> Yeah, it always was for me - thanks for confirming.
>>>>
>>>>>> And the resulting host-model on a  rather old test server will therefore have:
>>>>>>     <cpu mode='custom' match='exact' check='full'>
>>>>>>       <model fallback='forbid'>Haswell-noTSX-IBRS</model>
>>>>>>       <vendor>Intel</vendor>
>>>>>>       <feature policy='require' name='vmx'/>
>>>>>>       <feature policy='disable' name='pdcm'/>
>>>>>>        ...
>>>>>>
>>>>>> But that was fine in the past, and the behavior started to break
>>>>>> save/restore or migrations just now with the new qemu 10.1-rc.
>>>>>>
>>>>>> # Next steps
>>>>>>
>>>>>> I'm soon overwhelmed by meetings for the rest of the day, but would be
>>>>>> curious if one has a suggestion about what to look at next for
>>>>>> debugging or a theory about what might go wrong. If nothing else comes
>>>>>> up I'll try to set up a bisect run tomorrow.
>>>>>
>>>>> Yeah, git bisect is what I'd start with.
>>>>
>>>> Bisect complete, identified this commit
>>>>
>>>> commit 00268e00027459abede448662f8794d78eb4b0a4
>>>> Author: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Date:   Tue Mar 4 00:24:50 2025 -0500
>>>>
>>>>       i386/cpu: Warn about why CPUID_EXT_PDCM is not available
>>>>
>>>>       When user requests PDCM explicitly via "+pdcm" without PMU enabled, emit
>>>>       a warning to inform the user.
>>>>
>>>>       Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>       Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>>>       Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.li@intel.com
>>>>       Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>
>>>>    target/i386/cpu.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>>
>>>>
>>>> Which is odd as it should only add a warning right?
>>>
>>> No, that commit message is misleading.
>>>
>>> IIUC mark_unavailable_features() actively blocks usage of the feature,
>>> so it is a functional change, not merely a emitting warning.
>>>
>>> It makes me wonder if that commit was actually intended to block the
>>> feature or not, vs merely warning ?  CC'ing those involved in the
>>> commit.
>>
>> The intention was to print a warning to tell users PDCM cannot be
>> enabled if pmu is not enabled. While mark_unavailable_features() does
>> has the effect of setting the bit in cpu->filtered_features[].
>>
>> But the feature is masked off anyway
> 
> Right - it was disabled right from the beginning.
> As I reported libvirt detected it as not available and constructed the
> CPU as with it disabled.
> Which translated it into -cpu ...,pdcm=off,...
> 
> The new and bad aspect we need to overcome is that in these conditions
> this now somehow breaks save/restore and migration operations.

The commit 00268e0002 makes a difference only for the case "-cpu 
xxx,pdcm=on" without "pmu=on", and it emits a warning and sets the PDCM 
in cpu->filtered_features[].

So libvirt must first request with "-cpu xxx,pdcm=on" without "pmu=on" 
and gets the result that PDCM is filtered (set in cpu->filtered_features[]).

This indeed introduces the behavior change that before the commit, "-cpu 
xxx,pdcm=on" without "pmu=on" doesn't get warning nor PDCM is set in 
cpu->filtered_features[], but PDCM is just not set in guest's CPUID.

I couldn't understand how the warning or PDCM is set in 
cpu->filtered_features[] breaks save/restore and migration.

> As a cross-check I reverted just and only 00268e0002 on top of
> 10.1-rc2 and these use cases work again.
> 
>> even without the
>> mark_unavailable_features():
>>
>>       env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>
>> So is it that PDCM is set in cpu->filtered_features[] causing the problem?
>>
>>> With regards,
>>> Daniel
>>
> 
> 


