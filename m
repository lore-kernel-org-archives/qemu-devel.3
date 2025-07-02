Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBC5C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz6q-0008V6-Om; Wed, 02 Jul 2025 11:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWz6g-0008On-RF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:10:43 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWz6Y-00038k-S3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751469034; x=1783005034;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=gEJswCbw/DntRN2Xr6aRLnAHkTuG9TsG/U4e1jvcWhI=;
 b=GuB/gom8JM/NONYDZNbPZSeYyqB11Qzn8HcXH2H2oqGVoKML/vtw/Nls
 cOpfRS5lTPNsVRr2yLU5XnwVEoxLwTwaxSdhVeqzn16e1lUNrNBh6rmmT
 AXWZTYNtyJg5ADzhMvz+vmk7wmIch1kkqzWLH0AHMrlISTh4YbfPfwwVx
 mE2ifCmmwyiA89qJngxy6fjIbhG7AXC3vHZeiuPspXPsLZPehM5a/gFi7
 AgE2LhHOAUR+/Q32PSLVOrQTA6qptEv9K4xsbYCIS5sQXQHTdseKqsByq
 P+n7y/HqFwfeiCv/jI2TNMtzT/wjPjm02YnF8j0icmjiWHxT+sD3D39q/ g==;
X-CSE-ConnectionGUID: lYIW4gGVSQuy3SfHPMIeyg==
X-CSE-MsgGUID: iX+RR42uQz2korgWoeqsNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64469679"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="64469679"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 08:10:30 -0700
X-CSE-ConnectionGUID: j34XfNg9SOCIGq8Id1Dcng==
X-CSE-MsgGUID: LYxBnQmATAeJggp0AiWGLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153877993"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 08:10:30 -0700
Message-ID: <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
Date: Wed, 2 Jul 2025 23:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Kirill Martynov <stdcalllevi@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
Content-Language: en-US
In-Reply-To: <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
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

On 7/2/2025 10:16 PM, Xiaoyao Li wrote:
> On 5/23/2025 11:44 PM, Kirill Martynov wrote:
>> Certain error conditions can trigger x86_cpu_dump_state() to output 
>> CPU state
>> debug information e.g. KVM emulation failure due to misbehaving guest.
>> However, if the CPU is in System Management Mode (SMM) when the assertion
>> in cpu_asidx_from_attrs failure happens because:
>>
>> 1. In SMM mode (smm=1), the CPU must use multiple address spaces
>>     with a dedicated SMM address space
>> 2. On machine types with softmmu, address spaces are hardcoded to 1
>>     (no multiple address spaces available)
>>
>> The assertion occurs in cpu_asidx_from_attrs() when trying to
>> access memory in SMM mode with insufficient address spaces.
>>
>> Fix this by:
>> 1. If number of address spaces is 1 always use index 0
>> 2. In other cases use attr.secure for identified proper index
>>
>> This prevents the assertion while still providing useful debug
>> output during VM shutdown errors.
> 
> To me,  it's just a workaround to avoid the assertion.
> 
> When attrs.secure is 1, it means it's in SMM mode. As you describe above,
> 
>  > 1. In SMM mode (smm=1), the CPU must use multiple address spaces
>  >     with a dedicated SMM address space
> 
> So I think we need to first figure out why it gets attrs.secure as 1 
> when there is only 1 address space.

Ah, with KVM, QEMU can only support 1 address space.

It's not that

   2. On machine types with softmmu, address spaces are hardcoded to 1
      (no multiple address spaces available)

because TCG does supports 2 address space. So please update the commit 
message with a V2.

>> Stack trace of the original issue:
>> #0  ... in raise () from /lib/x86_64-linux-gnu/libc.so.6
>> #1  ... in abort () from /lib/x86_64-linux-gnu/libc.so.6
>> #2  ... in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #3  ... in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
>> #4  ... in cpu_asidx_from_attrs (cpu=cpu@entry=0x5578ca2eb340, attrs=...)
>>     at ../hw/core/cpu-sysemu.c:76
>> #5  ... in cpu_memory_rw_debug (cpu=cpu@entry=0x5578ca2eb340,
>>     addr=addr@entry=2147258348, ptr=ptr@entry=0x7f5341ca373c, 
>> len=len@entry=1,
>>      is_write=is_write@entry=false) at ../softmmu/physmem.c:3529
>> #6  ... in x86_cpu_dump_state (cs=0x5578ca2eb340,
>>     f=0x7f53434065c0 <_IO_2_1_stderr_>, flags=<optimized out>)
>>     at ../target/i386/cpu-dump.c:560
>> #7  ... in kvm_cpu_exec (cpu=cpu@entry=0x5578ca2eb340)
>>     at ../accel/kvm/kvm-all.c:3000
>> #8  ... in kvm_vcpu_thread_fn (arg=arg@entry=0x5578ca2eb340)
>>     at ../accel/kvm/kvm-accel-ops.c:51
>> #9  ... in qemu_thread_start (args=<optimized out>)
>>     at ../util/qemu-thread-posix.c:505
>> #10 ... in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
>> #11 ... in clone () from /lib/x86_64-linux-gnu/libc.so.6
>>
>> Signed-off-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
>> ---
>>   target/i386/cpu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index c51e0a43d0..2616a61c87 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -2507,7 +2507,7 @@ void cpu_sync_avx_hflag(CPUX86State *env);
>>   #ifndef CONFIG_USER_ONLY
>>   static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
>>   {
>> -    return !!attrs.secure;
>> +    return cs->num_ases == 1 ? 0 : (!!attrs.secure);

I would beg a comment like

	/*
          * For some case, only one address space is supported.
          * e.g., with KVM.
	 */

With it and commit message rectified,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

>>   }
>>   static inline AddressSpace *cpu_addressspace(CPUState *cs, 
>> MemTxAttrs attrs)
> 



