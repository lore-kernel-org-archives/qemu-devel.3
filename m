Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40AEC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWneA-0002Hu-Ah; Tue, 01 Jul 2025 22:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWne4-0002Hg-Uc
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:56:24 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWne2-0000sz-DU
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751424982; x=1782960982;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3n75qDWfWW4zlG23AmreWnoG45GlC1J+rYLd738uzVc=;
 b=caaolIL+MknLuAImWozvnKqpS8X6u8w9qLkKn0nJ7GP2nTb7q5I9f9RB
 RQg6T9a9iNGAazghvP5oA2Uc8F2jFVU8d/IbUautR+4GGivUAmujTfCvV
 hiKDR7tPf9GcPne3Whd2yxnQOKMdWdJXvhBxkmP30TgvmzYDoKiUTDTHu
 V8Ye3GMVkkysTy3GWEUxFeKtpZ6RJ+ZAX9HlQUgykExay3dhyB3wim7yX
 ei9rZNYEjnBhtEE0lStC/mXGprVY3E6ALAgFJsFVsUt7ZqNvmuCNg3vww
 s/zUQrOpgd5URH5bj+HoqQbb66JCHxYGrnvXPHBE1tLiAyj4suv1XluDO A==;
X-CSE-ConnectionGUID: RrXh2U00SSKLpKXx9DovSg==
X-CSE-MsgGUID: ORMjD9yHSBmqnFs/KrgIag==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53570247"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="53570247"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 19:56:18 -0700
X-CSE-ConnectionGUID: kQJ144ljQ6W99SeBgVFgBg==
X-CSE-MsgGUID: fztzLU/FTZmS8fgWG+kvMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="154267621"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 01 Jul 2025 19:56:17 -0700
Date: Wed, 2 Jul 2025 11:17:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kirill Martynov <stdcalllevi@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
Message-ID: <aGSk1tiqq7F0+CTr@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, May 23, 2025 at 03:44:31PM +0000, Kirill Martynov wrote:
> Date: Fri, 23 May 2025 15:44:31 +0000
> From: Kirill Martynov <stdcalllevi@yandex-team.ru>
> Subject: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
> X-Mailer: git-send-email 2.43.0
> 
> Certain error conditions can trigger x86_cpu_dump_state() to output CPU state
> debug information e.g. KVM emulation failure due to misbehaving guest.
> However, if the CPU is in System Management Mode (SMM) when the assertion
> in cpu_asidx_from_attrs failure happens because:
> 
> 1. In SMM mode (smm=1), the CPU must use multiple address spaces
>    with a dedicated SMM address space
> 2. On machine types with softmmu, address spaces are hardcoded to 1
>    (no multiple address spaces available)
> 
> The assertion occurs in cpu_asidx_from_attrs() when trying to
> access memory in SMM mode with insufficient address spaces.
> 
> Fix this by:
> 1. If number of address spaces is 1 always use index 0
> 2. In other cases use attr.secure for identified proper index
> 
> This prevents the assertion while still providing useful debug
> output during VM shutdown errors.
> 
> Stack trace of the original issue:
> #0  ... in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #1  ... in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #2  ... in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #3  ... in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
> #4  ... in cpu_asidx_from_attrs (cpu=cpu@entry=0x5578ca2eb340, attrs=...)
>    at ../hw/core/cpu-sysemu.c:76
> #5  ... in cpu_memory_rw_debug (cpu=cpu@entry=0x5578ca2eb340,
>    addr=addr@entry=2147258348, ptr=ptr@entry=0x7f5341ca373c, len=len@entry=1,
>     is_write=is_write@entry=false) at ../softmmu/physmem.c:3529
> #6  ... in x86_cpu_dump_state (cs=0x5578ca2eb340,
>    f=0x7f53434065c0 <_IO_2_1_stderr_>, flags=<optimized out>)
>    at ../target/i386/cpu-dump.c:560
> #7  ... in kvm_cpu_exec (cpu=cpu@entry=0x5578ca2eb340)
>    at ../accel/kvm/kvm-all.c:3000
> #8  ... in kvm_vcpu_thread_fn (arg=arg@entry=0x5578ca2eb340)
>    at ../accel/kvm/kvm-accel-ops.c:51
> #9  ... in qemu_thread_start (args=<optimized out>)
>    at ../util/qemu-thread-posix.c:505
> #10 ... in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
> #11 ... in clone () from /lib/x86_64-linux-gnu/libc.so.6
> 
> Signed-off-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
> ---
>  target/i386/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry for delay. This fix looks good to me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


