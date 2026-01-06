Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92611CEFD10
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 21:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdEEl-0005fw-2m; Tue, 06 Jan 2026 16:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vdEEe-0005RD-5w
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 16:05:00 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vdEEa-0002WO-DN
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 16:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767733496; x=1799269496;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7FjH30EBifRZDfjY8+GQqpYxitypc9EU+MXhWqBXiss=;
 b=NksJsvyZXIpgLhrRPsO/+/BaX/u7FhvNh8piv3iHXJsbFOOrd5EpiXmk
 oXrCrZh0ct7rcdFRUpooOHBDdSr6ZbiWHV79R1+2Ku7bo/7cp0DGxWLIq
 wNxtrU1tYaPH253mwaWXbaWsYKHyN9aYd50tjvmKx7978BlCXX7N7q836
 OGtXMA0aQfl6yIaWk96BInSg6fmFuE7IdJVIbTpqQUV3f7+11yJ5q6hSH
 rG1oHaqzcmUD5M+5ty+rI60W8Ofyi/+O/XBnCJqZOfGkboQ86kzliJRGq
 TXmKvjD+tQoc6cHwkXOXLawDllQdjDQn78SNqIuWiNcGHlXgphTMLFQq/ Q==;
X-CSE-ConnectionGUID: msreMyXxSaOcegfqxJf3Rw==
X-CSE-MsgGUID: 3+vjacWzTXiCFuAcw6CopA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69179233"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; d="scan'208";a="69179233"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 13:04:53 -0800
X-CSE-ConnectionGUID: 9jmfNKjOTNqq/qS0Ed1qnQ==
X-CSE-MsgGUID: TrDlblHGS/mgYUzshSfHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; d="scan'208";a="202651843"
Received: from unknown (HELO [10.241.241.119]) ([10.241.241.119])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 13:04:52 -0800
Message-ID: <d043ff42-9604-4acd-8341-830b30cba951@intel.com>
Date: Tue, 6 Jan 2026 13:04:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] target/i386/kvm: don't stop Intel PMU counters
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-8-dongli.zhang@oracle.com>
 <de20e04a-bfeb-4737-9e30-15d117e796e8@intel.com>
 <0f9f360c-b9a8-4379-9a02-c4b6dd5840a3@oracle.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <0f9f360c-b9a8-4379-9a02-c4b6dd5840a3@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 1/5/2026 12:24 PM, Dongli Zhang wrote:
> Hi Zide,
> 
> On 1/2/26 4:27 PM, Chen, Zide wrote:
>>
>>
>> On 12/29/2025 11:42 PM, Dongli Zhang wrote:
>>> PMU MSRs are set by QEMU only at levels >= KVM_PUT_RESET_STATE,
>>> excluding runtime. Therefore, updating these MSRs without stopping events
>>> should be acceptable.
>>
>> It seems preferable to keep the existing logic. The sequence of
>> disabling -> setting new counters -> re-enabling is complete and
>> reasonable. Re-enabling the PMU implicitly tell KVM to do whatever
>> actions are needed to make the new counters take effect.
>>
>> If the purpose of this patch to improve performance, given that this is
>> a non-critical path, trading this clear and robust logic for a minor
>> performance gain does not seem necessary.
>>
>>
>>> In addition, KVM creates kernel perf events with host mode excluded
>>> (exclude_host = 1). While the events remain active, they don't increment
>>> the counter during QEMU vCPU userspace mode.
>>>
>>> Finally, The kvm_put_msrs() sets the MSRs using KVM_SET_MSRS. The x86 KVM
>>> processes these MSRs one by one in a loop, only saving the config and
>>> triggering the KVM_REQ_PMU request. This approach does not immediately stop
>>> the event before updating PMC. This approach is true since Linux kernel
>>> commit 68fb4757e867 ("KVM: x86/pmu: Defer reprogram_counter() to
>>> kvm_pmu_handle_event"), that is, v6.2.
>>
>> This seems to assume KVM's internal behavior. While that is true today
>> (and possibly in the future), it’s not necessary for QEMU to  make such
>> assumptions, as that could unnecessarily limit KVM’s flexibility to
>> change its behavior later.
>>
> 
> To "assume KVM's internal behavior" is only one of the two reasons. The first
> reason is that QEMU controls the state of the vCPU to ensure this action only
> occurs when "levels >= KVM_PUT_RESET_STATE."
> 
> Thanks to "(level >= KVM_PUT_RESET_STATE)", QEMU is able to avoid unnecessary
> updates to many MSR registers during runtime.
> 
> 
> The main objective is to sync the implementation for Intel and AMD.
> 
> Both MSR_CORE_PERF_FIXED_CTR_CTRL and MSR_CORE_PERF_GLOBAL_CTRL are reset to
> zero only in the case where "has_pmu_version > 1." Otherwise, we may need to
> reset the MSR_P6_PERFCTR_N registers before writing to the counter registers.
> Without PATCH 7/7, an additional patch will be required to fix the workflow for
> handling PMU registers to reset control registers before counter registers.

I might be missing something here, but since this is not for runtime,
I don’t quite understand the need to reset the control registers.

> If the plan is to maintain the current logic, we may need to adjust the logic
> for the AMD registers as well. In PATCH 6/7, we never reset global registers
> before writing to control and counter registers.
> 
> Would you mine sharing your thoughts on it?

Personally, I would lean towards keeping the current logic and instead
adjusting patch 6/7 to reset the global registers.  This is just my
view, and please don’t feel obligated to follow it.


> Thank you very much!
> 
> Dongli Zhang


