Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D1AE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 04:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV1Fh-0008O5-Br; Mon, 06 Jan 2025 23:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV1Ff-0008NB-0L
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 23:31:35 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV1Fb-0004rI-NW
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 23:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736224292; x=1767760292;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EgfUnfi3B6wHzzpaWZy67DMUoPrQG5yuYtQSPT15bwE=;
 b=DaSBrUsGbkwJP9ZCTqcdv1wFiFkxekGUrUmKsbaay/8VzsSrX7O/P4Bl
 WdU8Dqg7p6j+eMNZ4IuB6Z+kXCkw5IdE95s3O2C2vgE2KdgPtb3Y9nGiB
 /FYKFg3ods8jSCNwehzjEivtKoylPdIqJAXiNOWr5vpXEI0VMxD4LJguK
 d9Vi5qJ5iBf6u7TKbbYnW8PLdrn59gdOhpB2qu1OxMYGc0cySLhxKperL
 +hG+QkdqjZ4uJtCaHRzyR8WC5wotuIioZFaiWJWHZqg1LX10/2VOP/6yQ
 rrfkm2pIPuRMs/XWE7iAU+QwxEgeUVl7lECBAP+VG10aQs8gpidWRTLGb Q==;
X-CSE-ConnectionGUID: jIWNhjXjSSi53aft8ld6pw==
X-CSE-MsgGUID: 0Mx3H+uvSgySMTTWdEFKtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="35688516"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; d="scan'208";a="35688516"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 20:31:27 -0800
X-CSE-ConnectionGUID: 8Jbc/QSnQFKjyJ71E+KIxw==
X-CSE-MsgGUID: FNec55lvRWu91mTu7brDAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; d="scan'208";a="133504458"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 20:31:24 -0800
Message-ID: <bf435f2e-5cfb-411d-937a-6c686a0530dd@intel.com>
Date: Tue, 7 Jan 2025 12:31:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] i386/cpu: Extract a common fucntion to setup
 value of MSR_CORE_THREAD_COUNT
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-2-xiaoyao.li@intel.com>
 <018cfbde-96be-4d95-bb29-95cdf708187e@linaro.org>
 <902568a2-8160-4265-9e2c-c4465eaa62d4@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <902568a2-8160-4265-9e2c-c4465eaa62d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 1/3/2025 4:52 PM, Philippe Mathieu-Daudé wrote:
> On 28/12/24 18:37, Philippe Mathieu-Daudé wrote:
>> On 19/12/24 12:01, Xiaoyao Li wrote:
>>> There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
>>> Extract a common function for it.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>> Changes in v2:
>>> - move the implementation of cpu_x86_get_msr_core_thread_count() to
>>>    target/i386/cpu-sysemu.c;
>>> ---
>>>   target/i386/cpu-sysemu.c             | 11 +++++++++++
>>>   target/i386/cpu.h                    |  2 ++
>>>   target/i386/hvf/x86_emu.c            |  3 +--
>>>   target/i386/kvm/kvm.c                |  5 +----
>>>   target/i386/tcg/sysemu/misc_helper.c |  3 +--
>>>   5 files changed, 16 insertions(+), 8 deletions(-)
>>
>>
>>> +uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
>>> +{
>>> +    CPUState *cs = CPU(cpu);
>>> +    uint64_t val;
>>> +
>>> +    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 
>>> 15..0 */
>>> +    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 
>>> 31..16 */
>>> +
>>> +    return val;
>>
>> Alternatively:
>>
>>         return deposit64(cs->nr_threads * cs->nr_cores, 16, 16,
>>                          cs->nr_cores);

I would rather keep it as-is as suguested by Philippe[1].

(deposit64() is really a new thing for i386)

[1] 
https://lore.kernel.org/qemu-devel/20241210173524.48e203a3@imammedo.users.ipa.redhat.com/

>>> +}
>>
> 
> Typo "function" in patch subject.

thanks for catching it!


