Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA12CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdT6-0003Nh-Lh; Wed, 06 May 2026 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wKdT4-0003NL-3B
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:43:18 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wKdT2-0001pM-EA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:43:17 -0400
Received: from example.com (unknown [167.220.208.68])
 by linux.microsoft.com (Postfix) with ESMTPSA id E3CF920B7165;
 Wed,  6 May 2026 07:43:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3CF920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778078592;
 bh=WtkjqwgRPIp+n7EAoPzJrvzmuuKuZz9AF4ANkZCiVA8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aOMIC2HIY4O4uLAlSI6qoBSKwKjW7DMf9/EqOuVWz0tOA+1n3OzOUX9PIEGPHDypw
 +meV0DnhpDSLR0fusbFQy2LtzlJLZZaD4sioPQ+eBpMxAulC8cd6VCUFlFEXJ9lNEj
 AGdx6UxF7WILetfQGA7z/m57PO3CBgHij3Js7Ir4=
Date: Wed, 6 May 2026 16:43:10 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/7] target/i386/mshv: use hv_vp_register_page for
 fast register access
Message-ID: <aftTfjd/l+SgbUXl@example.com>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 05, 2026 at 09:50:21PM +0300, Doru Blânzeanu wrote:
> This series adds support for using the hypervisor's vp register page
> in the mshv accelerator to optimize vcpu register access on mmio and pio
> exits.
> 
> Currently, all register reads and write go through hypercalls (ioctls),
> which adds overhead on every VM exit. The VP register page is a shared
> memory page that the hypervisor populates with vcpu register state,
> allowing Qemu to read and write registers directly without hypercalls.
> 
> The series is structured as follows:
> 1. Remove the duplicate `fetch_guest_state` function, consolidating
>   register loading into `mshv_load_regs`.
> 2. Move `mshv_arch_init_vcpu` after vcpu creation so the vcpu fd is
>   valid when we need it for mmap.
> 3. Define the `hv_vp_register_page` structure in `hvgdk_mini.h`, matching
>   the layout used by the Linux kernel's mshv driver.
> 4. Set up the register page by mmapping the vcpu fd at init time. If the
>   mmap fails, we fall back gracefully to the existing hypercall path.

I think we don't have to fallback gracefully here. If the hypervisor
doesn't support the register page, it's likely that other assumption
don't hold either. I would suggest to abort here and relax that
constraint later, if we encounter a legit scenario where mmaping the
register page would fail.

> 5. Use the register page to read registers on VM exit. General purpose
>   registers, RIP, RFLAGS, segment registers, and control registers
>   (CR0, CR4, CR4, CR8, EFER) are read directly from the page. Registers
>   not present on the page (TR, LDTR, GDTR, IDTR, CR2, APIC_BASE) are still
>   fetched via hypercall.
> 6. Use register page to write registers on vmentry. GP registers,
>   RIP, and RFLAGS are written to the page with the appropriate dirty
>   bits set, avoiding the hypercall for the standard register store.
> 
> The register page is only used when it has been successfully mmapped and
> the hypervisor has marked it as valid (`isvalid != 0`). Otherwise, the
> existing hypercall-based path is used as a fallback.
> 
> Changes since v1:
> - move hv_register_page struct definition to hvhdk.h
> - add a compile time guard around regs_page in CPUArchState
> - modify mshv_get_special_regs_vp_page to only retrieve the special
>   registers present in the register page (removed TR, LDTR, GDTR, IDTR,
>   CR2, APIC_BASE)
>   In local testing this hasn't created any regressions, and it is unlikely
>   that the mmio operations need this registers.
>   We'll want to keep an eye on this in case there are decoded operations
>   that rely on fetching these registers on every VM exit.
> - add commit to fix handle_pio_non_str and handle_pio_str to correctly
>   store modified registers back to the register page after the pio
>   operation, and clear the cpu->accel->dirty flag to avoid the
>   mshv_arch_put_registers from resetting some registers state (fpu).
> - modified register page setup to signal an error instead of a warning
>   in case mmap fails.
>   I am not sure aborting here is fine because it would make some of the
>   fallback logic redundant, and I think that's a bigger refactoring.
> 
> Doru Blânzeanu (7):
>   target/i386/mshv: remove duplicate function for reading vcpu registers
>   accel/mshv: move vcpu arch specific initialization after vcpu creation
>   include/hw/hyperv: add hv_vp_register_page struct definition
>   target/i386/mshv: hv_vp_register_page setup for the vcpu
>   target/i386/mshv: use the register page to get registers
>   target/i386/mshv: use the register page to set registers
>   target/i386/mshv: fix pio handlers clobbering device-modified
>     registers
> 
>  accel/mshv/mshv-all.c       |   3 +-
>  include/hw/hyperv/hvgdk.h   |   2 +
>  include/hw/hyperv/hvhdk.h   | 105 ++++++++++++++
>  target/i386/cpu.h           |   5 +
>  target/i386/mshv/mshv-cpu.c | 269 ++++++++++++++++++++++++++++--------
>  5 files changed, 327 insertions(+), 57 deletions(-)
> 
> -- 
> 2.53.0

