Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E5CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwex-00052e-Kt; Fri, 12 Sep 2025 01:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwev-00052N-KP
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:49:21 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwes-0002CW-Lk
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757656159; x=1789192159;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=g2nG2172bTqHeocdY6f/gF8eYlZ/TDpqJEG20VLrz/4=;
 b=buHI8lSQccvxOulASfz4twBNeaWkLkyx3QAHgk421llnULc+SSVoO7A6
 Ckw7tQybT5VGadgVQ1+s54OF862G93BG9kHAo3jfu7zai7/nA7JD0mHml
 rtOrwThgfSrx2pv9hKnSv0xgJSdi0T5kWj1+bLrTN8NTllG+wUlzfpek5
 CRaOtcgrNg1Rw3U6TUUac1h61hrcc+q6O/O4fssTWWAxlOiQkugtoEz1g
 jPz6jIEP6XK2sg/xpTKRuaEMTPsmc7ZdKga6yWdWYwbihV58C4Lg4H0Fa
 UFa5FmQEawvJcr3As6l7wdICq7Twrn/35M9IhdlKrxHr/KFpFk2H/gTM4 w==;
X-CSE-ConnectionGUID: Zfza75MLQFqy8L/CmbHs5g==
X-CSE-MsgGUID: qAmYe577TDujzsvoMIPWQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="85434389"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="85434389"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:49:16 -0700
X-CSE-ConnectionGUID: O16Z6151SymOaFvr4Eq3iA==
X-CSE-MsgGUID: 2v1fBqcSR5q+VfDQihyk7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="204877954"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:49:15 -0700
Message-ID: <589b6c9b-9d83-4137-a9b0-16a7516cdb0a@intel.com>
Date: Fri, 12 Sep 2025 13:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] multiboot: Fix the split lock
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20250808035027.2194673-1-xiaoyao.li@intel.com>
 <d480bd1f-535c-4001-b489-4a0d8b62a80b@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d480bd1f-535c-4001-b489-4a0d8b62a80b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/8/2025 6:54 PM, Philippe Mathieu-Daudé wrote:
> On 8/8/25 05:50, Xiaoyao Li wrote:
>> While running the kvm-unit-tests on Intel platforms with "split lock
>> disable" feature, every test triggers a kernel warning of
>>
>>    x86/split lock detection: #AC: qemu-system-x86_64/373232 took a 
>> split_lock trap at address: 0x1e3
>>
>> Hack KVM by exiting to QEMU on split lock #AC, we get
>>
>> KVM: exception 17 exit (error code 0x0)
>> EAX=00000001 EBX=00000000 ECX=00000014 EDX=0001fb80
>> ESI=00000000 EDI=000000a8 EBP=00000000 ESP=00006f10
>> EIP=000001e3 EFL=00010002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
>> ES =0900 00009000 0000ffff 00009300 DPL=0 DS16 [-WA]
>> CS =c000 000c0000 0000ffff 00009b00 DPL=0 CS16 [-RA]
>> SS =0000 00000000 0000ffff 00009300 DPL=0 DS16 [-WA]
>> DS =c000 000c0000 0000ffff 00009300 DPL=0 DS16 [-WA]
>> FS =0950 00009500 0000ffff 00009300 DPL=0 DS16 [-WA]
>> GS =06f2 00006f20 0000ffff 00009300 DPL=0 DS16 [-WA]
>> LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
>> TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
>> GDT=     000c02b4 00000027
>> IDT=     00000000 000003ff
>> CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
>> DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000000000
>> Code=89 16 08 00 65 66 0f 01 16 06 00 66 b8 01 00 00 00 0f 22 c0 <65> 
>> 66 ff 2e 00 00 b8 10 00 00 00 8e d0 8e d8 8e c0 8e e0 8e e8 66 b8 08 
>> 00 66 ba 10 05 66
>>
>> And it matches with what disassembled from multiboo_dma.bin:
>>
>>   #objdump -b binary -m i386 -D pc-bios/multiboot_dma.bin
>>
>>    1d1:   08 00                   or     %al,(%eax)
>>    1d3:   65 66 0f 01 16          lgdtw  %gs:(%esi)
>>    1d8:   06                      push   %es
>>    1d9:   00 66 b8                add    %ah,-0x48(%esi)
>>    1dc:   01 00                   add    %eax,(%eax)
>>    1de:   00 00                   add    %al,(%eax)
>>    1e0:   0f 22 c0                mov    %eax,%cr0
>>> 1e3:   65 66 ff 2e             ljmpw  *%gs:(%esi)
>>    1e7:   00 00                   add    %al,(%eax)
>>    1e9:   b8 10 00 00 00          mov    $0x10,%eax
>>    1ee:   8e d0                   mov    %eax,%ss
>>    1f0:   8e d8                   mov    %eax,%ds
>>    1f2:   8e c0                   mov    %eax,%es
>>    1f4:   8e e0                   mov    %eax,%fs
>>    1f6:   8e e8                   mov    %eax,%gs
>>    1f8:   66 b8 08 00             mov    $0x8,%ax
>>    1fc:   66 ba 10 05             mov    $0x510,%dx
>>
>> We can see that the instruction at 0x1e3 is a far jmp through the GDT.
>> However, the GDT is not 8 byte aligned, the base is 0xc02b4.
>>
>> Intel processors follow the LOCK semantics to set the accessed flag of 
>> the
>> segment descriptor when loading a segment descriptor. If the the segment
>> descriptor crosses two cache line, it causes split lock.
>>
>> Fix it by aligning the GDT on 8 bytes, so that segment descriptor cannot
>> span two cache lines.
>>
> 
> Cc: qemu-stable@nongnu.org
> Fixes: f16408dfb0e ("Multiboot support")
> 
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   pc-bios/multiboot_dma.bin     | Bin 1024 -> 1024 bytes
>>   pc-bios/optionrom/multiboot.S |   2 +-
>>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Ping on this.

Paolo, will you take it or leave it to someone else?


