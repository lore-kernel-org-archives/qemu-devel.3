Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CAAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 03:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLZuS-00078f-Gk; Wed, 11 Dec 2024 22:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLZuQ-00078W-SL
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:30:38 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLZuO-0004o5-MN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733974236; x=1765510236;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UyG6MGQ7868RvHO6Tgdatz58BzrwuwXa+9OxLYIikvQ=;
 b=BgGQS5tQRkxv7wxgk9/1yM9YKmpMY9bn9wS2FJjBkOKSzxJQnt+p+yK9
 x4RNBzc3sdoh/bwwyo0yhj/+1Fo6etbIpdIlJKDezVlx7O5vhEru7HhHD
 mdyetytmsaxZBAAAO1TKlFWD+xQDkEHF6/i/UVhBhZvVP+ErzCTR61iEQ
 SWg9BPtjNRD/U7tw1d/lp9Widfy65VxJgpMqd65ZAYbP/dpp2cO0lYlK1
 csolkVJzAg4bRhEXvY1xOOXsOB1iun5PmPbcMrjsZwqChefx3XDTnC4gF
 R+Xyi+Yi2N96CG7f6QbNx+8r26Iuz4ljI4SA9Jr3JvjKKgS02CGZgee2Y Q==;
X-CSE-ConnectionGUID: FB4qDZvJQWugOb2SUeTDEA==
X-CSE-MsgGUID: /oYvaaodSye9QFxAIDaVEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34619934"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="34619934"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:30:33 -0800
X-CSE-ConnectionGUID: jxYMBjZNTxSHR0gnGMXVkg==
X-CSE-MsgGUID: VNP/Ldg6QzWV7VGaLar4eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="96596099"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 19:30:30 -0800
Message-ID: <6543614b-e6c0-4b74-a71e-c91fe360b2e0@intel.com>
Date: Thu, 12 Dec 2024 11:30:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] i386: Track cores_per_module in CPUX86State
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-4-xiaoyao.li@intel.com>
 <20241210174338.0fb05ecf@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241210174338.0fb05ecf@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
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

On 12/11/2024 12:43 AM, Igor Mammedov wrote:
> On Thu,  5 Dec 2024 09:57:15 -0500
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> x86 is the only user of CPUState::nr_cores.
>>
>> Define cores_per_module in CPUX86State, which can serve as the
>> substitute of CPUState::nr_cores. After x86 switches to use
>> CPUX86State::cores_per_module, CPUState::nr_cores will lose the only
>> user and QEMU can drop it.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   hw/i386/x86-common.c | 2 ++
>>   target/i386/cpu.c    | 2 +-
>>   target/i386/cpu.h    | 9 +++++++--
>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
>> index dc031af66217..f7a20c1da30c 100644
>> --- a/hw/i386/x86-common.c
>> +++ b/hw/i386/x86-common.c
>> @@ -271,6 +271,8 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>   
>>       init_topo_info(&topo_info, x86ms);
>>   
>> +    env->nr_cores = ms->smp.cores;
> this doesn't look like the same as in qemu_init_vcpu(),
> which uses machine_topo_get_cores_per_socket()
> Can you clarify the change?

because env->nr_cores has a different meaning vs. cs->nr_cores.

As the below comments of nr_cores in the diff

+    /* Number of cores within one module. */
+    unsigned nr_cores;

it means the number of cores within one module. It uses the similar 
convention as nr_dies and nr_modules in struct CPUArchState.

However, CPUState::nr_cores means the number of cores in the package.

yes, we can keep the same meaning of nr_cores as "number of cores in the 
package" when define it struct CPUArchState. However, it leads to 
inconsistency with nr_dies and nr_modules already there and confuses people.

>> +
>>       if (ms->smp.modules > 1) {
>>           env->nr_modules = ms->smp.modules;
>>           set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 3725dbbc4b3f..15b50c44ae79 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6503,7 +6503,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>   
>>       topo_info.dies_per_pkg = env->nr_dies;
>>       topo_info.modules_per_die = env->nr_modules;
>> -    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
>> +    topo_info.cores_per_module = env->nr_cores;
>>       topo_info.threads_per_core = cs->nr_threads;
>>   
>>       cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 5795a497e567..c37a49a1a02b 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -2051,6 +2051,9 @@ typedef struct CPUArchState {
>>       /* Number of modules within one die. */
>>       unsigned nr_modules;
>>   
>> +    /* Number of cores within one module. */
>> +    unsigned nr_cores;
>> +
>>       /* Bitmap of available CPU topology levels for this CPU. */
>>       DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
>>   } CPUX86State;
>> @@ -2393,10 +2396,12 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
>>   static inline uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
>>   {
>>       CPUState *cs = CPU(cpu);
>> +    CPUX86State *env = &cpu->env;
>>       uint64_t val;
>> +    uint64_t cores_per_package = env->nr_cores * env->nr_modules * env->nr_dies;
>>   
>> -    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
>> -    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
>> +    val = cs->nr_threads * cores_per_package;  /* thread count, bits 15..0 */
>> +    val |= (cores_per_package << 16); /* core count, bits 31..16 */
>>   
>>       return val;
>>   }
> 


