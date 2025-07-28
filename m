Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F48C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugQEV-0005um-Jo; Mon, 28 Jul 2025 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ugQEP-0005m0-Ih
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:57:42 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ugQEN-0003xn-72
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753718259; x=1785254259;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=I8gff45/W5TflvaYK/Lm8fWhEeXEU71edEixO5sOySM=;
 b=hp5MeGZsGWojnVpM0yH0NntRG5EyjNOkTZLCLH6odI5ZjTDMWSXw61mk
 T3ndgWdELA1hzhS7cECtGZje+YLIDqDRZEsQFrRZ6nCeX6OYH4n9T71Xc
 21bY4NdKXcdkffHDrLIthvvjZZCBm/FtEsyPh/bxyuGMJ5IKtDHHftt8L
 MyWaLQSblzG9K7Qu18YdBRl8yBY1mGfq5pA12AsOkxuSJn9KhwnBtYmg2
 lkURUNljbihK1i3JaE+OqcaV8WSjVMwknXXagBOXYEbV3Se4Ct974hjoa
 04HNmsrnWlzgToRZnAw3cz58aqSI5kbAR2O1Pdce+TBxRmd559TOlpe3x Q==;
X-CSE-ConnectionGUID: q+4Gvg1aQKKx6D40qEJNrg==
X-CSE-MsgGUID: WnoQWZA+Q866G6SLRWd4Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="66539105"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66539105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 08:57:37 -0700
X-CSE-ConnectionGUID: eD9hOWRwTr20UShibzwOYw==
X-CSE-MsgGUID: LsdKPezaToWnwyBGy2AvEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="162917450"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 28 Jul 2025 08:57:35 -0700
Date: Tue, 29 Jul 2025 00:19:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kirill Martynov <stdcalllevi@yandex-team.ru>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
Message-ID: <aIei/i7+MHM2s3EZ@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
 <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
 <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
 <09AD44D6-E381-46B0-9B86-B248EB9582D7@yandex-team.ru>
 <4985e648-6505-4321-8e3a-f987b9d03bde@intel.com>
 <aGeO2zCKep7StDA8@intel.com>
 <cf64058e-e5a2-4cf2-9851-92925553e72c@intel.com>
 <6C44AD09-0675-4277-93C2-DB3647EC54C2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C44AD09-0675-4277-93C2-DB3647EC54C2@yandex-team.ru>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Kirill,

On Mon, Jul 28, 2025 at 05:44:25PM +0300, Kirill Martynov wrote:
> Date: Mon, 28 Jul 2025 17:44:25 +0300
> From: Kirill Martynov <stdcalllevi@yandex-team.ru>
> Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for
>  softmmu
> X-Mailer: Apple Mail (2.3826.600.51.1.1)
> 
> Hi Xiaoyao!
> Hi Zhao!
> 
> Xiaoyao,
> I tested the patch you provided, it works smoothly, easy to apply. Nothing to complain about.
> 
> Zhao, 
> I also tried your approach (extend cpu_address_space_init with AddressSpace parameter)
> First, it crashed in malloc with error:
> malloc(): unaligned tcache chunk detected
> After a little investigation I resized cpu->cpu_ases array, so it can fit second element and
> it started working. However, it looks like that function cpu_address_space_destroy needs
> some adjustment, because now it treats cpu->cpu_ases elements as dynamically allocated and
> destroys them with g_free() and passing &smram_address_space to cpu_address_space_init()
> in register_smram_listener() could lead to a problem since it is statically allocated in binary.

Thanks for testing. Yes, resize related details are needed, which were
I missed. These 2 patches essentially are all about adding SMM CPU
address space for KVM, like TCG did.

> So, my question now, what should I do?

I still believe we should update cpu_address_space_init() and remove its
outdated assumptions about KVM first.

Moreover, users should have control over the added address spaces (I
think this is why num_ases should be set before
cpu_address_space_init()), and quietly updating num_ases is not a good
idea.

The question of whether to reuse smram_address_space for the CPU is
flexible. At least TCG doesn't reuse the same SMM space, and there's
already cpu_as_root (and cpu_as_mem!) in X86CPU. There are also some
cleanup things worth considering, such as how to better handle the TCG
memory listener in cpu_address_space_init() - KVM also has the similar
logic. If possible, I can help you further refine this fix and clean up
other related stuff in one goes as well.

Thanks,
Zhao


