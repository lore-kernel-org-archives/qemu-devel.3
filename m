Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEE1C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXaG-0006xx-6k; Tue, 01 Jul 2025 05:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWXaD-0006xb-9i; Tue, 01 Jul 2025 05:47:21 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWXa9-0008TB-Vw; Tue, 01 Jul 2025 05:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751363238; x=1782899238;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wRi38XEn3lG16EwLgOcpScq87jgyYmhJBiymSis23qA=;
 b=Nx+DyAaA5cvduHVS0frfwgN4HTQ2CJNBQX6BpZqdsJ0aX7gXzrJUq23v
 1PwvLfasmy9OgFYHRenLPu3vYa7lKccipJf/Mb5/hodY7u6/3avd5ra6Z
 q2oKMD33kxjBIylGC49CzfBFfOpODt5BEkuMOVuMrI/eJB9ePPzjqkBRO
 NiB7u28bRNs0krhz74ft17VN2gORHUlg7PrCJiiZqSQt3oKZQrfuHytna
 8UJlGxtJYtMNvx7BomPR3Vw4YAxZMJPEeGe8TgCyE9CGKX9oNUByRJFc/
 c6Ar5uegogsIGZfIaOwFNejelkgx16nWUMhmIPntu9bz6x15h1Xf5OIWP Q==;
X-CSE-ConnectionGUID: uY747rTiTd27hw9giXqY2Q==
X-CSE-MsgGUID: rYOs0HglSjmtyoHTe9x4FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="41252422"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="41252422"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 02:47:12 -0700
X-CSE-ConnectionGUID: zREfzJeYQ6KZtv/vPGFnYA==
X-CSE-MsgGUID: miUAP0VdShuL/uDYFnuSWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="177388589"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 02:47:08 -0700
Message-ID: <c8a0bd48-3f48-4f3b-b3ee-93a14e84a70a@intel.com>
Date: Tue, 1 Jul 2025 17:47:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
To: Alexandre Chartre <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Cc: qemu-stable@nongnu.org, zhao1.liu@intel.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <3a9c8152-3202-4962-a1fe-a2d7fdc33b76@intel.com>
 <abdf31e3-2ada-47d8-9c9d-d875491537b2@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <abdf31e3-2ada-47d8-9c9d-d875491537b2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/1/2025 5:22 PM, Alexandre Chartre wrote:
> 
> On 7/1/25 10:23, Xiaoyao Li wrote:
>> On 6/30/2025 9:30 PM, Alexandre Chartre wrote:
>>> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
>>> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
>>> MSR and it makes no sense to emulate it on AMD.
>>>
>>> As a consequence, VMs created on AMD with qemu -cpu host and using
>>> KVM will advertise the ARCH_CAPABILITIES feature and provide the
>>> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
>>> as the guest OS might not expect this MSR to exist on such cpus (the
>>> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
>>> are not defined on the AMD architecture).
>>>
>>> A fix was proposed in KVM code, however KVM maintainers don't want to
>>> change this behavior that exists for 6+ years and suggest changes to be
>>> done in qemu instead.
>>>
>>> So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
>>> is not provided by default on AMD cpus when the hypervisor emulates it,
>>> but it can still be provided by explicitly setting arch-capabilities=on.
>>>
>>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>>> ---
>>>   target/i386/cpu.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 0d35e95430..7e136c48df 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu, 
>>> Error **errp)
>>>           }
>>>       }
>>> +    /*
>>> +     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
>>> +     * MSR on AMD although this is an Intel-specific MSR; and KVM will
>>> +     * continue doing so to not change its ABI for existing setups.
>>> +     *
>>> +     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
>>> +     * to prevent providing a cpu with an MSR which is not supposed to
>>> +     * be there, unless it was explicitly requested by the user.
>>> +     */
>>> +    if (IS_AMD_CPU(env) &&
>>> +        !(env->user_features[FEAT_7_0_EDX] & 
>>> CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
>>> +        env->features[FEAT_7_0_EDX] &= 
>>> ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
>>> +    }
>>
>> This changes the result for the existing usage of "-cpu host" on
>> AMD. So it will need a compat_prop to keep the old behavior for old
>> machine.
> 
> Right, I will look at that.
> 
>>
>> But I would like discuss if we really want to do it in QEMU.
>> ARCH_CAPABILITIES is not the only one KVM emulates unconditionally.
>> We have TSC_DEADLINE_TIMER as well. So why to treat them
>> differently? just because some Windows cannot boot? To me, it looks
>> just the bug of Windows. So please fix Windows. And to run with the
>> buggy Windows, we have the workaround: "-cpu host,-arch-capabilities"
> 
> Well, the Windows behavior is not that wrong as it conforms to the AMD 
> Manual
> which specifies that ARCH_CAPABILITIES feature and MSR are not defined 
> on AMD
> cpus; while QEMU/KVM are providing an hybrid kind of AMD cpu with Intel 
> feature/MSR.

It is currently reserved bit in AMD's manual. But it doesn't mean it 
will be reserved forever. Nothing prevents AMD to implement it in the 
future.

Software shouldn't set any expectation on the reserved bit.

> Microsoft is fixing that behavior anyway and has provided a preview fix 
> (OS Build
> 26100.4484), so that's good news. But the goal here is also to prevent 
> such future
> misbehavior. So if other features (like TSC_DEADLINE_TIMER) are exposed 
> while they
> shouldn't then they should probably be fixed as well.
 > > "-cpu host,-arch-capabilities" is indeed a workaround, but it defeats
> the purpose
> of the "-cpu host" option which is to provide a guest with the same 
> features as the
> host. And this workaround basically says: "provide a guest with the same 
> cpu as
> the host but disable this feature that the host doesn't provide"; this 
> doesn't make
> sense. Also this workaround doesn't integrate well in heterogeneous 
> environments
> (with Intel,  AMD, ARM or other cpus) where you just want to use "-cpu 
> host" whatever
> the platform is, and not have a special case for AMD cpus.

As I said, it's just the workaround for users who want to run a specific 
version of Windows with "-cpu host" on AMD. That's why it's called 
workaround.

The root-cause is the wrong behavior of the specific version of Windows. 
If you don't use the buggy Windows, you don't need the workaround.

> Thanks,
> 
> alex.
> 


