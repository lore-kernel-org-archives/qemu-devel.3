Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ECCE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 03:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLa1F-00087n-Qd; Wed, 11 Dec 2024 22:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLa1D-00087a-Mc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:37:39 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLa1A-0005vX-Uj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733974657; x=1765510657;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5n+dpywLHpvNxd/O+0CMNIlCHWFA+tth+AVGjxU7oRU=;
 b=LVywaZkPunY6Pb/24JENekTWccg6e/rmYz/h5FCaScubsOojyidUCN9Z
 1X+2YARoG3UH04kkI6hklCdL5Sfs5pEjBB7ZSpH4vTCqN8E8k88RC5xWz
 Ze6nTD/z7a59czI+D+HEoiNj53sFVOYP8Wh+Me2LIK/EAppC70oD30cu7
 k0bp/toylptOOlj9kjCSHZpgtRyAmfpYiM9mmEPIZh9g35UUmkR5+zzFN
 tHsWOv0EWYaszln67w9+Sw8qGe+vAsno0xFOoADMirp/jFmM8ttH/Nt/U
 kxCfPYd6j2OSNNq1AGSvsyWCrLn9bhf/szdeiMwlwxRF94bxONkaHW5T4 Q==;
X-CSE-ConnectionGUID: ZEHNtjYjQhSuG7UpcwB+Tg==
X-CSE-MsgGUID: E4fxOAB5T+eo2EovKvSldQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45785458"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="45785458"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:37:34 -0800
X-CSE-ConnectionGUID: yJIMbqbkTfC+6culIZ26dQ==
X-CSE-MsgGUID: /SelTPfaQnyYaaBsjJAdIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="101159944"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:37:26 -0800
Message-ID: <1e093c24-0765-4aa3-951c-daaf00f551b5@intel.com>
Date: Thu, 12 Dec 2024 11:37:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] i386: Track cores_per_module in CPUX86State
To: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-4-xiaoyao.li@intel.com>
 <20241210174338.0fb05ecf@imammedo.users.ipa.redhat.com>
 <Z1j97K+xpgIp6sYc@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z1j97K+xpgIp6sYc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/11/2024 10:50 AM, Zhao Liu wrote:
> On Tue, Dec 10, 2024 at 05:43:38PM +0100, Igor Mammedov wrote:
>> Date: Tue, 10 Dec 2024 17:43:38 +0100
>> From: Igor Mammedov <imammedo@redhat.com>
>> Subject: Re: [RFC PATCH 3/4] i386: Track cores_per_module in CPUX86State
>> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
>>
>> On Thu,  5 Dec 2024 09:57:15 -0500
>> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>>> x86 is the only user of CPUState::nr_cores.
>>>
>>> Define cores_per_module in CPUX86State, which can serve as the
>>> substitute of CPUState::nr_cores. After x86 switches to use
>>> CPUX86State::cores_per_module, CPUState::nr_cores will lose the only
>>> user and QEMU can drop it.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>   hw/i386/x86-common.c | 2 ++
>>>   target/i386/cpu.c    | 2 +-
>>>   target/i386/cpu.h    | 9 +++++++--
>>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
>>> index dc031af66217..f7a20c1da30c 100644
>>> --- a/hw/i386/x86-common.c
>>> +++ b/hw/i386/x86-common.c
>>> @@ -271,6 +271,8 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>>   
>>>       init_topo_info(&topo_info, x86ms);
>>>   
>>> +    env->nr_cores = ms->smp.cores;
>> this doesn't look like the same as in qemu_init_vcpu(),
>> which uses machine_topo_get_cores_per_socket()
>> Can you clarify the change?
> 
> I think Xiaoyao is correct here. CPUState.nr_cores means number of cores
> in socket, and current CPUX86State.nr_cores means number of cores per
> module (or parent container) ...though they have same name. (It's better
> to mention the such difference in commit message.)
> 
> However, I also think that names like nr_cores or nr_* are prone to
> errors. Names like cores_per_module are clearer, similar to the naming
> in X86CPUTopoInfo. This might be an opportunity to clean up the current
> nr_* naming convention.
> 
> And further, we can directly cache two additional items in CPUX86State:
> threads_per_pkg and cores_per_pkg, as these are the most common
> calculations and can help avoid missing any topology levels.
> 
> I think both of these changes can be made on top of the current series.

yes, my plan is to just maintain a "struct X86CPUTopoInfo" in 
CPUX86State. After we clean up the nr_threads and nr_cores in CPUState 
usage.

> @xiaoyao, do you agree?
> 
> Regards,
> Zhao
> 


