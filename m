Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ED3C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thOmN-0001Wz-Uk; Mon, 10 Feb 2025 03:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1thOmM-0001Wl-CN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:04:30 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1thOmJ-0006oE-3r
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739174668; x=1770710668;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bnws4m/cgsYVSJVmsCZ/sWjxAsmEtJj8WLVAn6Evxao=;
 b=AS0pM88ur+nGQwR5cY5JTlVVhq2jbv91hNhDENxWNEdm0LczsW0XRfVC
 k3q7kKUjI38xoebAE7JwO3hYN8M51M2ovhivd7OzKoO8s9JW6ohvu06iQ
 8kFnXwHsSvnoy4gYVmy3ygB5kG44HJLrQ2ItJ5/kdwqE7A4p/quZjmy/o
 x8HE/lOBTusga/dfvLLe0zzFx/one5ItndV6Q+r2pdyM+JWAStBB4KzvK
 BMImDMkrCbpnVF0QcrrYc75sRjqcnU59rgkszgr/TNgI1bdMM4pwNKtF4
 /XYHxzpIghKmComM9dJYtC/+/jPvHef3JHzjHztrNaPvd/dEd3hX/qQvn g==;
X-CSE-ConnectionGUID: 7IpYEfFNSoeaFkv7dqU8Bg==
X-CSE-MsgGUID: ygKD6bL8SlqCyEKnT3gujQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39654250"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="39654250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 00:04:08 -0800
X-CSE-ConnectionGUID: CAzXRT3sTcmw4z9x6jPYeA==
X-CSE-MsgGUID: ExSnojCPTAOWmnvW9GKjOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="112345679"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128])
 ([10.124.245.128])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 00:04:03 -0800
Message-ID: <8618eac7-80ae-4533-9b05-17323955d1b5@linux.intel.com>
Date: Mon, 10 Feb 2025 16:04:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/i386/kvm: introduce 'pmu-cap-disabled' to set
 KVM_PMU_CAP_DISABLE
To: dongli.zhang@oracle.com, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, zhenyuw@linux.intel.com,
 groug@kaod.org, lyan@digitalocean.com, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com, joe.jin@oracle.com,
 davydov-max@yandex-team.ru, zide.chen@intel.com
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-3-dongli.zhang@oracle.com> <ZyxxygVaufOntpZJ@intel.com>
 <57b4b74d-67d2-4fcf-aa59-c788afc93619@oracle.com>
 <f4a2f801-9f82-424e-aee4-8b18add34aa6@linux.intel.com>
 <6aefa9df-10e3-4001-a509-a4bc3850d65a@linux.intel.com>
 <bf41c97a-b5e2-4cfd-90ef-89f12f1b384a@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <bf41c97a-b5e2-4cfd-90ef-89f12f1b384a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 2/10/2025 4:12 AM, dongli.zhang@oracle.com wrote:
> Hi Dapeng,
>
> On 2/7/25 1:52 AM, Mi, Dapeng wrote:
>> On 11/21/2024 6:06 PM, Mi, Dapeng wrote:
>>> On 11/8/2024 7:44 AM, dongli.zhang@oracle.com wrote:
>>>> Hi Zhao,
>>>>
>>>>
>>>> On 11/6/24 11:52 PM, Zhao Liu wrote:
>>>>> (+Dapang & Zide)
>>>>>
>>>>> Hi Dongli,
>>>>>
>>>>> On Mon, Nov 04, 2024 at 01:40:17AM -0800, Dongli Zhang wrote:
>>>>>> Date: Mon,  4 Nov 2024 01:40:17 -0800
>>>>>> From: Dongli Zhang <dongli.zhang@oracle.com>
>>>>>> Subject: [PATCH 2/7] target/i386/kvm: introduce 'pmu-cap-disabled' to set
>>>>>>  KVM_PMU_CAP_DISABLE
>>>>>> X-Mailer: git-send-email 2.43.5
>>>>>>
>>>>>> The AMD PMU virtualization is not disabled when configuring
>>>>>> "-cpu host,-pmu" in the QEMU command line on an AMD server. Neither
>>>>>> "-cpu host,-pmu" nor "-cpu EPYC" effectively disables AMD PMU
>>>>>> virtualization in such an environment.
>>>>>>
>>>>>> As a result, VM logs typically show:
>>>>>>
>>>>>> [    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
>>>>>>
>>>>>> whereas the expected logs should be:
>>>>>>
>>>>>> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
>>>>>> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
>>>>>>
>>>>>> This discrepancy occurs because AMD PMU does not use CPUID to determine
>>>>>> whether PMU virtualization is supported.
>>>>> Intel platform doesn't have this issue since Linux kernel fails to check
>>>>> the CPU family & model when "-cpu *,-pmu" option clears PMU version.
>>>>>
>>>>> The difference between Intel and AMD platforms, however, is that it seems
>>>>> Intel hardly ever reaches the “...due virtualization” message, but
>>>>> instead reports an error because it recognizes a mismatched family/model.
>>>>>
>>>>> This may be a drawback of the PMU driver's print message, but the result
>>>>> is the same, it prevents the PMU driver from enabling.
>>>>>
>>>>> So, please mention that KVM_PMU_CAP_DISABLE doesn't change the PMU
>>>>> behavior on Intel platform because current "pmu" property works as
>>>>> expected.
>>>> Sure. I will mention this in v2.
>>>>
>>>>>> To address this, we introduce a new property, 'pmu-cap-disabled', for KVM
>>>>>> acceleration. This property sets KVM_PMU_CAP_DISABLE if
>>>>>> KVM_CAP_PMU_CAPABILITY is supported. Note that this feature currently
>>>>>> supports only x86 hosts, as KVM_CAP_PMU_CAPABILITY is used exclusively for
>>>>>> x86 systems.
>>>>>>
>>>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>>>> ---
>>>>>> Another previous solution to re-use '-cpu host,-pmu':
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/all/20221119122901.2469-1-dongli.zhang@oracle.com/__;!!ACWV5N9M2RV99hQ!Nm8Db-mwBoMIwKkRqzC9kgNi5uZ7SCIf43zUBn92Ar_NEbLXq-ZkrDDvpvDQ4cnS2i4VyKAp6CRVE12bRkMF$ 
>>>>> IMO, I prefer the previous version. This VM-level KVM property is
>>>>> difficult to integrate with the existing CPU properties. Pls refer later
>>>>> comments for reasons.
>>>>>
>>>>>>  accel/kvm/kvm-all.c        |  1 +
>>>>>>  include/sysemu/kvm_int.h   |  1 +
>>>>>>  qemu-options.hx            |  9 ++++++-
>>>>>>  target/i386/cpu.c          |  2 +-
>>>>>>  target/i386/kvm/kvm.c      | 52 ++++++++++++++++++++++++++++++++++++++
>>>>>>  target/i386/kvm/kvm_i386.h |  2 ++
>>>>>>  6 files changed, 65 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>>>> index 801cff16a5..8b5ba45cf7 100644
>>>>>> --- a/accel/kvm/kvm-all.c
>>>>>> +++ b/accel/kvm/kvm-all.c
>>>>>> @@ -3933,6 +3933,7 @@ static void kvm_accel_instance_init(Object *obj)
>>>>>>      s->xen_evtchn_max_pirq = 256;
>>>>>>      s->device = NULL;
>>>>>>      s->msr_energy.enable = false;
>>>>>> +    s->pmu_cap_disabled = false;
>>>>>>  }
>>>>> The CPU property "pmu" also defaults to "false"...but:
>>>>>
>>>>>  * max CPU would override this and try to enable PMU by default in
>>>>>    max_x86_cpu_initfn().
>>>>>
>>>>>  * Other named CPU models keep the default setting to avoid affecting
>>>>>    the migration.
>>>>>
>>>>> The pmu_cap_disabled and “pmu” property look unbound and unassociated,
>>>>> so this can cause the conflict when they are not synchronized. For
>>>>> example,
>>>>>
>>>>> -cpu host -accel kvm,pmu-cap-disabled=on
>>>>>
>>>>> The above options will fail to launch a VM (on Intel platform).
>>>>>
>>>>> Ideally, the “pmu” property and pmu-cap-disabled should be bound to each
>>>>> other and be consistent. But it's not easy because:
>>>>>  - There is no proper way to have pmu_cap_disabled set different default
>>>>>    values (e.g., "false" for max CPU and "true" for named CPU models)
>>>>>    based on different CPU models.
>>>>>  - And, no proper place to check the consistency of pmu_cap_disabled and
>>>>>    enable_pmu.
>>>>>
>>>>> Therefore, I prefer your previous approach, to reuse current CPU "pmu"
>>>>> property.
>>>> Thank you very much for the suggestion and reasons.
>>>>
>>>> I am going to follow your suggestion to switch back to the previous solution in v2.
>>> +1.
>>>
>>>  I also prefer to leverage current exist "+/-pmu" option instead of adding
>>> a new option. More options, more complexity. When they are not
>>> inconsistent, which has higher priority? all these are issues.
>>>
>>> Although KVM_CAP_PMU_CAPABILITY is a VM-level PMU capability, but all CPUs
>>> in a same VM should always share same PMU configuration (Don't consider
>>> hybrid platforms which have many issues need to be handled specifically).
>>>
>>>
>>>>> Further, considering that this is currently the only case that needs to
>>>>> to set the VM level's capability in the CPU context, there is no need to
>>>>> introduce a new kvm interface (in your previous patch), which can instead
>>>>> be set in kvm_cpu_realizefn(), like:
>>>>>
>>>>>
>>>>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>>>>> index 99d1941cf51c..05e9c9a1a0cf 100644
>>>>> --- a/target/i386/kvm/kvm-cpu.c
>>>>> +++ b/target/i386/kvm/kvm-cpu.c
>>>>> @@ -42,6 +42,8 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>>>>>  {
>>>>>      X86CPU *cpu = X86_CPU(cs);
>>>>>      CPUX86State *env = &cpu->env;
>>>>> +    KVMState *s = kvm_state;
>>>>> +    static bool first = true;
>>>>>      bool ret;
>>>>>
>>>>>      /*
>>>>> @@ -63,6 +65,29 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>>>>>       *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
>>>>>       *   cpu_common_realizefn() (via xcc->parent_realize)
>>>>>       */
>>>>> +
>>>>> +    if (first) {
>>>>> +        first = false;
>>>>> +
>>>>> +        /*
>>>>> +         * Since Linux v5.18, KVM provides a VM-level capability to easily
>>>>> +         * disable PMUs; however, QEMU has been providing PMU property per
>>>>> +         * CPU since v1.6. In order to accommodate both, have to configure
>>>>> +         * the VM-level capability here.
>>>>> +         */
>>>>> +        if (!cpu->enable_pmu &&
>>>>> +            kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY)) {
>>>>> +            int r = kvm_vm_enable_cap(s, KVM_CAP_PMU_CAPABILITY, 0,
>>>>> +                                      KVM_PMU_CAP_DISABLE);
>>>>> +
>>>>> +            if (r < 0) {
>>>>> +                error_setg(errp, "kvm: Failed to disable pmu cap: %s",
>>>>> +                           strerror(-r));
>>>>> +                return false;
>>>>> +            }
>>>>> +        }
>>> It seems KVM_CAP_PMU_CAPABILITY is called to only disable PMU here. From
>>> point view of logic completeness,  KVM_CAP_PMU_CAPABILITY should be called
>>> to enabled PMU as well when user wants to enable PMU.
>>>
>>> I know currently we only need to disable PMU, but we may need to enable PMU
>>> via KVM_CAP_PMU_CAPABILITY soon.
>>>
>>> We are working on the new KVM mediated vPMU framework, Sean suggest to
>>> leverage KVM_CAP_PMU_CAPABILITY to enable mediated vPMU dynamically
>>> (https://urldefense.com/v3/__https://lore.kernel.org/all/Zz4uhmuPcZl9vJVr@google.com/__;!!ACWV5N9M2RV99hQ!JQx8CdjEI-J6WbzbvB7vHcZ0nJPkzUhvl6TvWvDorAal1XAC17dwpRa6b6Xlva--pK-4ej3Ota0k9SJl3BUWXKTew70$ ). So It would be
>>> better if the enable logic can be added here as well.
>>>
>>> Thanks.
>> Hi Dongli,
>>
>> May I know if you have plan to continue to update this patch recently? As
>> previous comment said, our KVM mediated vPMU solution needs qemu to
>> explicitly call KVM_CAP_PMU_CAPABILITY to enable mediated vPMU as well. If
>> you have no plan to update this patch recently, would you mind me to pick
>> up this patch
>> (https://urldefense.com/v3/__https://lore.kernel.org/all/20221119122901.2469-2-dongli.zhang@oracle.com/__;!!ACWV5N9M2RV99hQ!JQx8CdjEI-J6WbzbvB7vHcZ0nJPkzUhvl6TvWvDorAal1XAC17dwpRa6b6Xlva--pK-4ej3Ota0k9SJl3BUWzQmZ_yA$ )
>> and post with other our mediated vPMU related patches to enable mediated vPMU?
>>
>> Thanks!
>>
>> Dapeng Mi
>
> Sorry for the delay — it took some effort to learn about mediated vPMU (as
> you suggested) to adapt this patch accordingly.
>
> Yes, feel free to pick up this patch for mediated vPMU, as I don’t want to
> block your work, although, I do plan to continue updating it.
>
> I am continuing working on it, but my primary objective is to reset the AMD
> PMU during QEMU reset, which depends on KVM_PMU_CAP_DISABLE.
>
> [PATCH 5/7] target/i386/kvm: Reset AMD PMU registers during VM reset
> [PATCH 6/7] target/i386/kvm: Support perfmon-v2 for reset
>
> Would you mind keeping me updated on any changes/discussions you make to
> QEMU on KVM_PMU_CAP_DISABLE for mediated vPMU? That way, I can adjust my
> code accordingly once your QEMU patch for KVM_PMU_CAP_DISABLE is finalized.
>
> In the meantime, I am continuing working on the entire patchset and I can
> change the code when you post the relevant QEMU changes on
> KVM_PMU_CAP_DISABLE soon.
>
> Would that work for you?

Dongli,

Thanks for your feedback. Sure, I would add you into the mail loop when
sending the qemu mediated vPMU patches.

BTW, I found Xiaoyao ever sent a quite familiar patch
(https://lore.kernel.org/qemu-devel/20220317135913.2166202-10-xiaoyao.li@intel.com/)
and he has updated the patch to latest qemu code base, I would pick up his
patch directly.

Thanks,

Dapeng Mi


>
> Thank you very much!
>
> Dongli Zhang

