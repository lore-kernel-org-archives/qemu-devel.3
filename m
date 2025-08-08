Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB768C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 04:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukEMO-0004Mh-GZ; Fri, 08 Aug 2025 00:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ukEM5-0003mB-01
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 00:05:22 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ukEM2-0000Pn-CX
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 00:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754625919; x=1786161919;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=uvOme7opqVFUfpAZe257bGm3qr93mNurSLoQZWyUwaY=;
 b=QDXI+19bISs1vRDYx1pJwS/JoVRR4RsW6odpUDo7bXwD4113Tq9C090B
 VZirKqdA1uIhJY1iTC3LIh4uEaHq5Q/t42fqhwnsWIJH/XQ1/Cmp/xWJa
 N57TPfaECORhD8QkYFdygViQyYUD4sr27iyKBhqJyawsRUWMs6Yf7hofn
 ZWzf9KcUkQyt2Ftve8rAjINrOFeBy4TwU0B/kumne9nRxdgjAZzzY8NLE
 hHGzIBabryKkC8Jo7HRBIOGZAGcCNOnG/cvAgrJdtd9UOUeVEZYkbktXI
 56Pm8nYMLrQA3mC43r2DJwnIoo3zvIC+DTcw5t/Qe49Bo5Tnm9Pocs+Ra g==;
X-CSE-ConnectionGUID: WR1p/1spSNuq7/ewFni0kA==
X-CSE-MsgGUID: nJ+CkvppSyy3DGIrnxeW2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67241529"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67241529"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 21:05:00 -0700
X-CSE-ConnectionGUID: wR1rMv0NR4yQnUNVA7A1PA==
X-CSE-MsgGUID: g8dKih5DSai902xvvj7JGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="169352137"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 21:04:57 -0700
Message-ID: <09cf398f-9469-4778-a458-3a2a87fb7a60@intel.com>
Date: Fri, 8 Aug 2025 12:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: split lock issue in multiboot_dma.bin
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: =?UTF-8?Q?Marcus_H=C3=A4hnel?= <marcus.haehnel@kernkonzept.com>,
 Adam Lackorzynski <adam@l4re.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <eaf7e7bf-9513-49a4-b6a1-fe18f2a1a258@intel.com>
 <0344ef5a-8c6c-4c21-824e-9506bb4c7600@intel.com>
Content-Language: en-US
In-Reply-To: <0344ef5a-8c6c-4c21-824e-9506bb4c7600@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
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

On 8/8/2025 12:00 AM, Xiaoyao Li wrote:
> On 8/7/2025 8:15 PM, Xiaoyao Li wrote:
>> When running the kvm-unit-tests on Intel platforms with "split lock 
>> disable" feature, every test triggers a kernel warning of
>>
>>      x86/split lock detection: #AC: qemu-system-x86_64/373232 took a 
>> split_lock trap at address: 0x1e3
>>
>> After investigation, it turns out the split lock happens from 
>> multiboot_dma.bin:
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
>> #objdump -b binary -m i386 -D pc-bios/multiboot_dma.bin
>>
>>   1d1:   08 00                   or     %al,(%eax)
>>   1d3:   65 66 0f 01 16          lgdtw  %gs:(%esi)
>>   1d8:   06                      push   %es
>>   1d9:   00 66 b8                add    %ah,-0x48(%esi)
>>   1dc:   01 00                   add    %eax,(%eax)
>>   1de:   00 00                   add    %al,(%eax)
>>   1e0:   0f 22 c0                mov    %eax,%cr0
>>  >1e3:   65 66 ff 2e             ljmpw  *%gs:(%esi)
>>   1e7:   00 00                   add    %al,(%eax)
>>   1e9:   b8 10 00 00 00          mov    $0x10,%eax
>>   1ee:   8e d0                   mov    %eax,%ss
>>   1f0:   8e d8                   mov    %eax,%ds
>>   1f2:   8e c0                   mov    %eax,%es
>>   1f4:   8e e0                   mov    %eax,%fs
>>   1f6:   8e e8                   mov    %eax,%gs
>>   1f8:   66 b8 08 00             mov    $0x8,%ax
>>   1fc:   66 ba 10 05             mov    $0x510,%dx
>>
>> I don't know where the multiboot_dma.bin are built from so that I 
>> cannot further help resolve the split lock issue.
> 
> stupid me. The src code is just pc-bios/optionrom/multiboot.S
> But I don't know how to build a bin file from it to test my fix.

I resolve it myself. It turns out my machine lacks some crosscc package.
QEMU can build optionroms after I install g++-multilib．

I then verified my fix and sent it:

https://lore.kernel.org/qemu-devel/20250808035027.2194673-1-xiaoyao.li@intel.com/




