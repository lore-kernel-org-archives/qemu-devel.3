Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911E2CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGFG8-0008CO-0m; Mon, 12 Oct 2026 08:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xGFFY-00089p-IS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:35:31 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xGFFW-0000j5-SX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:35:28 -0400
Received: from example.com (unknown [167.220.208.79])
 by linux.microsoft.com (Postfix) with ESMTPSA id 79F2520B7168;
 Mon, 12 Oct 2026 05:35:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79F2520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791808522;
 bh=ZhqonhY9uPSAg02xzPHr1NulzpFNeLXkkYnYJLyGqBA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W1s5lNERAb56epZ3A2Uekmlzcz/vrOHilFCJ7OySDbx1YrWZ7lNn3RSweotH0H7KH
 1MdbGDHxetbfzqjyUU226mGc+w5IXF6KpmlowfaI1UPSH7nXx4Tu2IgIniPs5Ndrcm
 EC910UMR7TU4DPEahIa6QFYe9B3BKrjbc4fxvf/I=
Date: Mon, 12 Oct 2026 14:35:21 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>
Subject: Re: [PATCH v2 0/4] accel/mshv: add gdbstub guest debugging support
Message-ID: <aszUCUC2xoZhmcMM@example.com>
References: <20260731184643.89604-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731184643.89604-1-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 31, 2026 at 09:46:38PM +0300, Doru Blânzeanu wrote:
> This series brings guest debugging to the MSHV accelerator by
> implementing software breakpoints and single-stepping, so that gdb can
> attach to an MSHV guest through QEMU's gdbstub.
> 
> It follows the KVM gdbstub implementation closely, and borrows the WHPX
> approach where the MSHV interface differs from KVM:
> 
>   - it installs a partition-wide intercept for the #DB exception
>     (HVCALL_INSTALL_INTERCEPT). #BP (INT3) is deliberately left to the
>     guest's own IDT and is never intercepted, as WHPX does.
> 
>   - only software breakpoints are supported. A breakpoint is an INT1
>     (opcode 0xf1) patched into guest memory, which raises a #DB when
>     executed. Hardware breakpoints and watchpoints are not supported.
> 
>   - it never touches the guest debug registers (DR0-DR7), so guest state
>     is not clobbered. The only guest register used is RFLAGS.TF, toggled
>     around the vCPU run for single-stepping and kept out of env->eflags
>     so it cannot be read back and re-armed.
> 
>   - it re-injects the #DB back into the guest (via
>     HV_REGISTER_PENDING_EVENT0) when the faulting RIP does not match a
>     debugger breakpoint, so a guest-owned #DB is delivered through the
>     guest's own IDT.
> 
> When a vCPU is created we register the accel ops that gdb drives once it
> is attached:
> 
>   - mshv_update_guest_debug
>   - mshv_insert_gdbstub_breakpoint
>   - mshv_remove_gdbstub_breakpoint
>   - mshv_remove_all_gdbstub_breakpoints
> 
> For each insert request from gdb the ops save the original byte at the
> target address and patch in 0xf1; on a remove request the saved byte is
> restored, after which gdb single-steps over the original instruction and
> re-inserts the breakpoint. When the vCPU executes the 0xf1 byte a #DB
> vmexits to QEMU. mshv_handle_debug() then checks whether the RIP where
> the vCPU stopped matches a breakpoint installed by gdb, or whether
> single-stepping is active, and if so reports the stop to gdb. If the RIP
> does not match any debugger breakpoint the #DB is assumed to be
> guest-owned and is re-injected so the guest can handle it.
> 
> Known limitations:
> 
>   - Once installed, the #DB intercept stays for the lifetime
>     of the VM and every #DB - including those the guest raises itself -
>     vmexits to QEMU.
> 
>   - Because attribution relies on matching the faulting RIP against the
>     debugger's breakpoint list, a guest that legitimately executes INT1 or
>     raises its own #DB at an address that also holds a debugger breakpoint
>     cannot be disambiguated; such overlaps are not expected in practice.
> 
> The series is organised as:
> 
>   1. include/hw/hyperv: add ABI for exception intercepts and pending
>      events
>   2. accel/mshv: add gdbstub software breakpoint support
>   3. target/i386/mshv: support single-stepping
>   4. accel/mshv: break the vCPU run loop on exit_request
>      This commit fixes a race condition encountered during testing with guests
>      that run infinite loops with some debugging opcodes.
> 
> I have tested this patch series by using both a guest that doesn't use debugging
> and one that triggers the #DB and #BP exceptions (#DB is re-injected and #BP is
> not intercepted at all).
> 
> Changes since v1:
> - refactored the HVMSG_X64_EXCEPTION_INTERCEPT vmexit handle to be contained in
>   a standalone function handle_exception_interrupt
> - add new commit that checks the mshv vcpu run loop for exit requests before
>   re-entering MSHV_RUN_VP. This ensures a busy vCPU doesn't ignore gdb commands.
> 
> Doru Blânzeanu (4):
>   include/hw/hyperv: add ABI for exception intercepts and pending events
>   accel/mshv: add gdbstub software breakpoint support
>   target/i386/mshv: support single-stepping
>   accel/mshv: break the vCPU run loop on exit_request
> 
>  accel/mshv/mshv-all.c          | 175 ++++++++++++++++++++++++++++++++-
>  include/hw/hyperv/hvgdk_mini.h |  56 +++++++++++
>  include/system/mshv_int.h      |  14 +++
>  target/i386/mshv/mshv-cpu.c    | 154 +++++++++++++++++++++++++++++
>  4 files changed, 398 insertions(+), 1 deletion(-)
> 
> -- 
> 2.53.0

included in mkulke-pull-20261006, skipped 4/4


