Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358BFC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 16:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk33C-00004r-Em; Thu, 07 Aug 2025 12:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uk32p-0008Gh-2M
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 12:00:49 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uk32j-0007sy-CY
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 12:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754582438; x=1786118438;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WUt10lvy3PPEXUjtBFUCvDRZOY3XxNQRtHK5zS1CGK4=;
 b=kcPZQALIYztkBVRmpRm7qNM/K29oBHYTRb3kiFwz3k6NfZPjXPFzTokM
 qalfTqM4g4qZ2kCrEHA0pbXgtJhT36Dewj2Hj6SnzK6Mi2tYIvKN4/UxQ
 E+ZfhQ0DHAW/q0b6wMb77LTiSr4/mAbDWfCVO2dIanNNDF2ZIW+AbqiDM
 EFOaJrSRtkEataxL8iji3RF97Mvun9hDkquXfC2A9cOEiSbHiPGNehlWy
 u2xLBNkinBUad4Eq6aRZCxhfec+US6/7qlEJyDgYxDJpNWfp3jyCbBEhl
 qAJrK8cYwF+z9R5dUQCGQ+zeK0n6PpUgOjKGpT7KsAwDSq1WZH2FJY5Jf w==;
X-CSE-ConnectionGUID: gYWm0qsETBWV6HdJJ9tqCg==
X-CSE-MsgGUID: G8IYlr5DSO+rCf9kBtd5MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67618698"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="67618698"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 09:00:34 -0700
X-CSE-ConnectionGUID: vA6ay6/ITgOS3UKHZdJarg==
X-CSE-MsgGUID: eCnI5OFiSruNpCVFrWpb5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="165891725"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 09:00:32 -0700
Message-ID: <0344ef5a-8c6c-4c21-824e-9506bb4c7600@intel.com>
Date: Fri, 8 Aug 2025 00:00:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: split lock issue in multiboot_dma.bin
To: =?UTF-8?Q?Marcus_H=C3=A4hnel?= <marcus.haehnel@kernkonzept.com>,
 Adam Lackorzynski <adam@l4re.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <eaf7e7bf-9513-49a4-b6a1-fe18f2a1a258@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <eaf7e7bf-9513-49a4-b6a1-fe18f2a1a258@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
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

On 8/7/2025 8:15 PM, Xiaoyao Li wrote:
> When running the kvm-unit-tests on Intel platforms with "split lock 
> disable" feature, every test triggers a kernel warning of
> 
>      x86/split lock detection: #AC: qemu-system-x86_64/373232 took a 
> split_lock trap at address: 0x1e3
> 
> After investigation, it turns out the split lock happens from 
> multiboot_dma.bin:
> 
> Hack KVM by exiting to QEMU on split lock #AC, we get
> 
> KVM: exception 17 exit (error code 0x0)
> EAX=00000001 EBX=00000000 ECX=00000014 EDX=0001fb80
> ESI=00000000 EDI=000000a8 EBP=00000000 ESP=00006f10
> EIP=000001e3 EFL=00010002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0900 00009000 0000ffff 00009300 DPL=0 DS16 [-WA]
> CS =c000 000c0000 0000ffff 00009b00 DPL=0 CS16 [-RA]
> SS =0000 00000000 0000ffff 00009300 DPL=0 DS16 [-WA]
> DS =c000 000c0000 0000ffff 00009300 DPL=0 DS16 [-WA]
> FS =0950 00009500 0000ffff 00009300 DPL=0 DS16 [-WA]
> GS =06f2 00006f20 0000ffff 00009300 DPL=0 DS16 [-WA]
> LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
> TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
> GDT=     000c02b4 00000027
> IDT=     00000000 000003ff
> CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=89 16 08 00 65 66 0f 01 16 06 00 66 b8 01 00 00 00 0f 22 c0 <65> 66 
> ff 2e 00 00 b8 10 00 00 00 8e d0 8e d8 8e c0 8e e0 8e e8 66 b8 08 00 66 
> ba 10 05 66
> 
> And it matches with what disassembled from multiboo_dma.bin:
> 
> #objdump -b binary -m i386 -D pc-bios/multiboot_dma.bin
> 
>   1d1:   08 00                   or     %al,(%eax)
>   1d3:   65 66 0f 01 16          lgdtw  %gs:(%esi)
>   1d8:   06                      push   %es
>   1d9:   00 66 b8                add    %ah,-0x48(%esi)
>   1dc:   01 00                   add    %eax,(%eax)
>   1de:   00 00                   add    %al,(%eax)
>   1e0:   0f 22 c0                mov    %eax,%cr0
>  >1e3:   65 66 ff 2e             ljmpw  *%gs:(%esi)
>   1e7:   00 00                   add    %al,(%eax)
>   1e9:   b8 10 00 00 00          mov    $0x10,%eax
>   1ee:   8e d0                   mov    %eax,%ss
>   1f0:   8e d8                   mov    %eax,%ds
>   1f2:   8e c0                   mov    %eax,%es
>   1f4:   8e e0                   mov    %eax,%fs
>   1f6:   8e e8                   mov    %eax,%gs
>   1f8:   66 b8 08 00             mov    $0x8,%ax
>   1fc:   66 ba 10 05             mov    $0x510,%dx
> 
> I don't know where the multiboot_dma.bin are built from so that I cannot 
> further help resolve the split lock issue.

stupid me. The src code is just pc-bios/optionrom/multiboot.S
But I don't know how to build a bin file from it to test my fix.

