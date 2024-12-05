Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D343CE77171
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ7ZE-0007FN-TH; Thu, 05 Dec 2024 03:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJ7ZD-0007Ex-Lx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:50:35 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJ7ZB-0000Af-Fg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733388633; x=1764924633;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CPGm9ge8yIA2v66yL/WAdZf3MHTp9tkWEdUyIfYHs5M=;
 b=SCGP6J/sBMGP/Fu1y0bQLWDRsz2ilA7ii7wK6cxpX8Yy+vwB1U0SioiA
 qXanQPzhWzJYZMzyKyytvNvBr/YUaKK+Jg8Llpj+QEV8CBBUYVH/HTYgA
 cgfOaKOoWLU/vnAwS2NKyd9hzUVI7fKQfSCfEq65C50yQBVHGTDBigxXS
 E/Q6AbsHR8E/OdSF+8+KHlZe5Mmod8/QvQha1AecTqyXNnvVRnVw+T3FX
 PJmGPhG2NNzJ8/KPboLtPF0zPL5uMhMGMBodLlPKEke9X/wFw72J5UmU6
 z8gEKg0NQ6vEoNgcdHCf/zW2FAjL2XAd05ob1DrPitQNsVbJnkSTygYKG w==;
X-CSE-ConnectionGUID: mO5vmgiVTamQvFghTfEwwQ==
X-CSE-MsgGUID: KhytKjLkRLarGF72InzBNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37624157"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="37624157"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 00:50:30 -0800
X-CSE-ConnectionGUID: RDHvZK6USqG23hAgQ2ylwA==
X-CSE-MsgGUID: t1m/pn7tSdCjIPlQM9Hmig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="99108959"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 00:50:25 -0800
Message-ID: <074ccf0a-e97d-4a24-ad02-34ae20ba79d3@intel.com>
Date: Thu, 5 Dec 2024 16:50:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
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
 <Z1FWpU36ZleXn7c4@intel.com> <e591b02b-253d-4f1e-b59f-122b3eb200eb@intel.com>
 <Z1Foz1X0Sm7TpbpU@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z1Foz1X0Sm7TpbpU@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
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

On 12/5/2024 4:48 PM, Zhao Liu wrote:
> On Thu, Dec 05, 2024 at 04:05:22PM +0800, Xiaoyao Li wrote:
>> Date: Thu, 5 Dec 2024 16:05:22 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
>>   related clearup
>>
>> On 12/5/2024 3:30 PM, Zhao Liu wrote:
>>> I'm also very sorry, but I have a slightly different opinion...
>>>
>>>>    accel/tcg/user-exec-stub.c |  4 +++
>>>>    hw/core/cpu-common.c       |  2 +-
>>>>    include/hw/core/cpu.h      |  8 +++++
>>>>    system/cpus.c              |  6 +++-
>>>>    target/alpha/cpu.c         |  2 ++
>>>>    target/arm/cpu.c           |  2 ++
>>>>    target/avr/cpu.c           |  2 ++
>>>>    target/hexagon/cpu.c       |  2 ++
>>>>    target/hppa/cpu.c          |  2 ++
>>>>    target/i386/cpu.c          | 61 +++++++++++++++++++-------------------
>>>>    target/loongarch/cpu.c     |  2 ++
>>>>    target/m68k/cpu.c          |  2 ++
>>>>    target/microblaze/cpu.c    |  2 ++
>>>>    target/mips/cpu.c          |  2 ++
>>>>    target/openrisc/cpu.c      |  2 ++
>>>>    target/ppc/cpu_init.c      |  2 ++
>>>>    target/riscv/cpu.c         |  2 ++
>>>>    target/rx/cpu.c            |  2 ++
>>>>    target/s390x/cpu.c         |  2 ++
>>>>    target/sh4/cpu.c           |  2 ++
>>>>    target/sparc/cpu.c         |  2 ++
>>>>    target/tricore/cpu.c       |  2 ++
>>>>    target/xtensa/cpu.c        |  2 ++
>>>>    23 files changed, 85 insertions(+), 32 deletions(-)
>>>>
>>>
>>> I have some doubts about the necessity of changing the initialization of
>>> nr_cores/nr_threads, because you can access the machine's topology info
>>> via machine_topo_get_threads_per_socket(), which gives the same result as
>>> `nr_cores * nr_threads`.
>>
>> yeah, it works. The goal is to maintain HT in env->features[].
>>
>> The problem is, as Igor objects, accessing MachineState from CPU context.
>> This is what I'm working on to avoid for the next version.
> 
> :( I also noticed that patch. Adding #ifndef CONFIG_USER_ONLY is not
> optimal there, so that approach is not general enough.
> 
> But your TDX case is different, TDX hook has been already under
> `current_machine` context. So you can directly access any topo info
> without CONFIG_USER_ONLY.
> 
>>> Especially, the TDX feature check hook is also within the context of
>>> `current_machine`, so why not check if TDX's HT is consistent with QEMU's
>>> emulation in the TDX hook?
>>>
>>> For this reason, and based on my comment on patch 2, I think checking HT
>>> in the TDX hook or even ignoring HT, would be a more straightforward and
>>> less impactful solution.
>>
>> Though it's motivated by TDX series, the goal is not TDX specific. The goal
>> is to track features in env->features[] instead of manually generating a
>> one-off value in cpu_x86_cpuid().
> 
> I agree, the principle of designing code should be like this. HT already
> has some issues, and adding this check in x86_cpu_expand_features() is
> also a one-off approach with very much effort. Checking HT in TDX is a
> less costly and less impactful one-off solution.

Please disconnect it from TDX. Even without TDX, it's reasonable enough 
to make the change to track HT in env->features[].

> Even, why not ignore HT in the TDX check? Isn't placing the TDX feature
> check before build_cpuid() implicitly assuming that any subsequent
> updates to CPUID by QEMU are valid?

Why choose to ignore HT in the TDX check? HT isn't special. The problem 
is just HT is not tracked in env->features[], which is a incorrect design.

It assumes the env->features[] is finalized.

> Based on this, why can't TDX trust that QEMU will set HT correctly?
> (However, this assumes that HT cannot be arbitrarily set by the user.)

It's not TDX can't trust QEMU. It's all QEMU's business that QEMU to 
ensure what it is going to set for TD guest is consistent with what TD 
guest sees.

You are suggesting that when QEMU checks the features, it makes HT a 
special case that HT's value is finalized later than the check so please 
ignore HT.

What I want to achieve is to get rid of the special case, because HT 
isn't special. It can be tracked in env->features[] and finalized earlier.

> I'm not sure how the next version will be, but it would definitely be
> better if it helps with generalization.

The goal of this series is exactly generalization to make HT not special.

> Based on the current approach, affecting all architectures, it would be
> better to directly obtain the topology information from current_machine
> in TDX.

Imagine why Paolo suggested to post it separately? IIUC, because it's 
not TDX specific thing.

> -Zhao
> 
> 


