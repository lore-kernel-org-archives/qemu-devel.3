Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0014D78788
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9zZ-0001v0-D5; Thu, 21 Nov 2024 11:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tE9zX-0001uh-9m
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:25:15 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tE9zT-0001mh-V2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732206311; x=1763742311;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=k4c0rQTQLU9hPG7mimFrHqPqo7cRSgEt30q3Snwn3pY=;
 b=ivFdVQnATxMACE5IY+DmZLibZpQxG99ZoFikxKn1pPwZ2Cj7lMojzppz
 E8fnpHR3Fn9Idy414WkkT7HAByENZhbrmrbXxVHvy3nBzER6GP8A0hiPc
 i+xpvOtOw7nzFTArlCnucoZAJwKnJPdf5W60A2mhEuC6m2lycJrMdTyme
 Fn/l6rkb6bWwDCfcFIDQRcfKmURbqXIuYvr6ly19kR+u5BHySA5QyvmnS
 /BFqWd5p93ktHDDr8vH3cwHLW554tR7Q0EAjvhx4aJy32wUG8I3RG++/w
 dZy5iWG7khuDZRg5VoMsQ3ffDVxEN2+QzRfEuKHYWkH1esycmmhBze3R8 w==;
X-CSE-ConnectionGUID: o4X1rqURQGetZVJZDIx8pA==
X-CSE-MsgGUID: cugvlee0TcGFdjZsuJiRVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32448119"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; d="scan'208";a="32448119"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2024 08:25:07 -0800
X-CSE-ConnectionGUID: s4X62JbWSKCgMynXRgMjGQ==
X-CSE-MsgGUID: sQ0zilIgRz+fsjHB8qq08A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; d="scan'208";a="90423187"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2024 08:25:04 -0800
Message-ID: <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
Date: Fri, 22 Nov 2024 00:24:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.669, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/11/2024 6:49 PM, David Hildenbrand wrote:
> On 08.11.24 08:06, Xiaoyao Li wrote:
>> This series is extracted from TDX QEMU v6[1] series per Paolo's request.
>>
>> It is originally motivated by x86 TDX to track CPUID_HT in env- 
>> >features[]
>> which requires nr_cores and nr_cores being initialized earlier than in
> 
> "and nr_threads"
> 
>> qemu_init_vcpu().
>>
>> Initialize of nr_cores and nr_threads earlier in x86's cpu_realizefn()
>> can make it work for x86 but it's duplicated with the initialization in
>> qemu_init_vcpu() which are used by all the ARCHes. Since initialize them
>> earlier also work for other ARCHes, introduce qemu_init_early_vcpu() to
>> hold the initialization of nr_cores and nr_threads and call it at the
>> beginning in realizefn() for each ARCH.
>>
>> Note, I only tested it for x86 ARCH. Please help test on other ARCHes.
> 
> [...]
> 
>>   accel/tcg/user-exec-stub.c |  4 +++
>>   hw/core/cpu-common.c       |  2 +-
>>   include/hw/core/cpu.h      |  8 +++++
>>   system/cpus.c              |  6 +++-
>>   target/alpha/cpu.c         |  2 ++
>>   target/arm/cpu.c           |  2 ++
>>   target/avr/cpu.c           |  2 ++
>>   target/hexagon/cpu.c       |  2 ++
>>   target/hppa/cpu.c          |  2 ++
>>   target/i386/cpu.c          | 61 +++++++++++++++++++-------------------
>>   target/loongarch/cpu.c     |  2 ++
>>   target/m68k/cpu.c          |  2 ++
>>   target/microblaze/cpu.c    |  2 ++
>>   target/mips/cpu.c          |  2 ++
>>   target/openrisc/cpu.c      |  2 ++
>>   target/ppc/cpu_init.c      |  2 ++
>>   target/riscv/cpu.c         |  2 ++
>>   target/rx/cpu.c            |  2 ++
>>   target/s390x/cpu.c         |  2 ++
>>   target/sh4/cpu.c           |  2 ++
>>   target/sparc/cpu.c         |  2 ++
>>   target/tricore/cpu.c       |  2 ++
>>   target/xtensa/cpu.c        |  2 ++
>>   23 files changed, 85 insertions(+), 32 deletions(-)
> 
> Hm. It looks like this belongs into the parent realize function. But the 
> "bad thing" is that we call the parent realize function after we try 
> realizing the derived CPU.
> 
> Could it go into cpu_common_initfn()?
> 

It can, I think.

I'll move them into cpu_common_initfn() in v2 to avoid touching all the 
ARCHes.


