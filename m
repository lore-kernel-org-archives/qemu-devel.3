Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAD8E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ6rl-0004kU-1C; Thu, 05 Dec 2024 03:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJ6ri-0004k6-N8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:05:38 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJ6re-0007x4-UT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733385935; x=1764921935;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yOMa+q4yCOr287o2UtaScr+23PV2/1mm+7jIo7HRL5M=;
 b=XFDpyBvm+TG0HpM9SU+4KtNGLOTB6IDT0VEZT+DfzEjp/wK0uwkWG9LL
 5sxLjmAfYNw7U92SvalVsVxv/9YPAKs4Q+Sgdm7P2pPwliWzKJ0ZD+6aA
 K+Lm4SoqT02vaW9A/faWJT1zK7VYFEX0cS4gQaZNRlSfpd6REzQnha4Ev
 /+CPz6GrtOrdS98W7dKvZrDJo3uAonswCIi+960rbLPwGP3EaJr/4eG2D
 TVZs5jL72HQI7aprLR+tq86fNR6Mk5zHKtUnMoAB238SFZP3FzJsQyz2E
 F41xmyIBr/bIZBtFrqsVclhg+Tn9feyN/ex9u4BoFSM8UWwBzzkfefdjh Q==;
X-CSE-ConnectionGUID: d8REWklzT7Kv6D4uHHlZuA==
X-CSE-MsgGUID: HoDG4+YsS+qc+xyikPPAig==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33927334"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33927334"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 00:05:30 -0800
X-CSE-ConnectionGUID: BGHhY9w+TVKaeP9REOtPrg==
X-CSE-MsgGUID: vGGzU6gfSg61N0czM3jy9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94851426"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 00:05:25 -0800
Message-ID: <e591b02b-253d-4f1e-b59f-122b3eb200eb@intel.com>
Date: Thu, 5 Dec 2024 16:05:22 +0800
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
 <Z1FWpU36ZleXn7c4@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z1FWpU36ZleXn7c4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
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

On 12/5/2024 3:30 PM, Zhao Liu wrote:
> I'm also very sorry, but I have a slightly different opinion...
> 
>>   accel/tcg/user-exec-stub.c |  4 +++
>>   hw/core/cpu-common.c       |  2 +-
>>   include/hw/core/cpu.h      |  8 +++++
>>   system/cpus.c              |  6 +++-
>>   target/alpha/cpu.c         |  2 ++
>>   target/arm/cpu.c           |  2 ++
>>   target/avr/cpu.c           |  2 ++
>>   target/hexagon/cpu.c       |  2 ++
>>   target/hppa/cpu.c          |  2 ++
>>   target/i386/cpu.c          | 61 +++++++++++++++++++-------------------
>>   target/loongarch/cpu.c     |  2 ++
>>   target/m68k/cpu.c          |  2 ++
>>   target/microblaze/cpu.c    |  2 ++
>>   target/mips/cpu.c          |  2 ++
>>   target/openrisc/cpu.c      |  2 ++
>>   target/ppc/cpu_init.c      |  2 ++
>>   target/riscv/cpu.c         |  2 ++
>>   target/rx/cpu.c            |  2 ++
>>   target/s390x/cpu.c         |  2 ++
>>   target/sh4/cpu.c           |  2 ++
>>   target/sparc/cpu.c         |  2 ++
>>   target/tricore/cpu.c       |  2 ++
>>   target/xtensa/cpu.c        |  2 ++
>>   23 files changed, 85 insertions(+), 32 deletions(-)
>>
> 
> I have some doubts about the necessity of changing the initialization of
> nr_cores/nr_threads, because you can access the machine's topology info
> via machine_topo_get_threads_per_socket(), which gives the same result as
> `nr_cores * nr_threads`.

yeah, it works. The goal is to maintain HT in env->features[].

The problem is, as Igor objects, accessing MachineState from CPU 
context. This is what I'm working on to avoid for the next version.

> Especially, the TDX feature check hook is also within the context of
> `current_machine`, so why not check if TDX's HT is consistent with QEMU's
> emulation in the TDX hook?
> 
> For this reason, and based on my comment on patch 2, I think checking HT
> in the TDX hook or even ignoring HT, would be a more straightforward and
> less impactful solution.

Though it's motivated by TDX series, the goal is not TDX specific. The 
goal is to track features in env->features[] instead of manually 
generating a one-off value in cpu_x86_cpuid().

> -Zhao
> 


