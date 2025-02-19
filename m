Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18D8C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkkuV-0004qc-Mx; Wed, 19 Feb 2025 09:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkkuT-0004qE-Rr
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 09:18:46 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkkuJ-0001C2-CJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 09:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739974716; x=1771510716;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1CgbRqwKlEUn0YFPkdHtlDXQOLpmF8plxtoIIaQx2VQ=;
 b=GcNJnb8s4dmJKqhQlQBQ85VUbLGS5L3ZaTJUawtToNYVvuPTpQ20k8Px
 YlN8+uJMZ2NuoevurUT5poZmc3DXbwiWSeNebW+lJOqY+wtJr2TgCgFWE
 tcGcjs0LWUsmqcZT+FHx6X9mDz+uWDvCd5dPT/uMiJ/oyGwjhRVEZEATK
 adAl9KlOmSigIc9CmhhUzWMyOo6djcJLLkmbL2FiitREIauIOfsOH9MMW
 H73474/2lDGARPDEf/EH4GvRve662fe3FkNu11j+0ZLXXIxnCAE0tQwcT
 YmsAXE0f6Vxt1Ued3VQ2SgeGzk+cwYkBkxkeFluNWK9B94FqjUn33REU7 g==;
X-CSE-ConnectionGUID: MUscvP37QA+IFNSRzX17ig==
X-CSE-MsgGUID: GmWNpLUBSsy2kb6ry5Yhfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40852019"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; d="scan'208";a="40852019"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 06:18:32 -0800
X-CSE-ConnectionGUID: H+KxmmHCRvKhAskGquSz3w==
X-CSE-MsgGUID: rrUwWvbaTQCwtnMaOVeGgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="119659994"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2025 06:18:31 -0800
Date: Wed, 19 Feb 2025 22:38:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
Message-ID: <Z7XszUvZVIXcwnVa@intel.com>
References: <20250218073702.3299300-1-zhao1.liu@intel.com>
 <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
 <cf10367d-90da-48d4-8440-7afb8b083883@linaro.org>
 <a4bbbcc3-5edd-4438-b5b3-738463bea840@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4bbbcc3-5edd-4438-b5b3-738463bea840@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

On Wed, Feb 19, 2025 at 10:25:40AM +0100, Paolo Bonzini wrote:
> Date: Wed, 19 Feb 2025 10:25:40 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
> 
> On 2/18/25 10:07, Philippe Mathieu-Daudé wrote:
> > On 18/2/25 09:53, Paolo Bonzini wrote:
> > > On 2/18/25 08:37, Zhao Liu wrote:
> > > > "addr & 0x18" ignores invalid address, so that the trace in default
> > > > branch (trace_hpet_ram_{read|write}_invalid()) doesn't work.
> > > > 
> > > > Mask addr by "0x1f & ~4", in which 0x1f means to get the complete TN
> > > > registers access and ~4 means to keep any invalid address offset.
> > > 
> > > I think this is less readable.
> > > 
> > > The reason to use !4 in the Rust code is because the initial AND is done
> > > in a separate function, timer_and_addr().
> > 
> > Having a quick look at the model without looking at the specs:
> > 
> > include/hw/timer/hpet.h:20:#define HPET_LEN                0x400
> > 
> > hw/timer/hpet.c:439:static uint64_t hpet_ram_read(...,
> > hw/timer/hpet.c-441-{
> > hw/timer/hpet.c-448-    /*address range of all TN regs*/
> > hw/timer/hpet.c-449-    if (addr >= 0x100 && addr <= 0x3ff) {
> > hw/timer/hpet.c-450-        uint8_t timer_id = (addr - 0x100) / 0x20;
> >                              ...
> > hw/timer/hpet.c-469-    } else {
> > hw/timer/hpet.c-470-        switch (addr & ~4) {
> >                                   ...
> > hw/timer/hpet.c-488-        }
> > hw/timer/hpet.c-489-    }
> > hw/timer/hpet.c-490-    return 0;
> > hw/timer/hpet.c-491-}
> > 
> > hw/timer/hpet.c:699:    memory_region_init_io(&s->iomem, obj,
> >                                                &hpet_ram_ops, s,
> >                                                "hpet", HPET_LEN);
> > 
> > I suppose we want to register multiple timers of I/O size 0x20 at 0x100,
> > and the I/O size of 0x20 at 0x000 is a generic control region.
> > 
> > Maybe split hpet_ram_ops in 2 (hpet_cfg_ops and hpet_tmr_ops), mapping
> > the first one once at 0x000 and the other 24 times at 0x100-0x3ff?
> 
> You would have to come up with a way to get the index though.  It seems to
> be adding churn for no particular reason.
> 
> I'd rather look into how to make decoding code *easy* without making
> everything MemoryRegions.

I aslo met an register space implementation [1] which stores registers
with range (I guess for QEMU, it could map each register to a memory
region) and register specific callbacks.

I didn't choose this way since it's too complex to quickly develop...

[1]: https://github.com/google/crosvm/blob/main/devices/src/register_space/mod.rs

> As I explained yesterday, while I'm not yet sure
> that Rust is going to stay in QEMU, I'd like to have as many examples as
> possible to help tilting the balance one way or the other. And indeed in the
> Rust version of HPET, timer_and_addr() could be extended to something like
> this:
> 
> // Start with the same "enum for registers" pattern that PL011 uses:
> #[derive(qemu_api_macros::TryInto)]
> #[repr(u64)]
> enum TimerRegister {
>     CFG = 0,
>     CMP = 8,
>     ROUTE = 16,
> }
> 
> #[derive(qemu_api_macros::TryInto)]
> #[repr(u64)]
> enum GlobalRegister {
>     CAP = 0,
>     CFG = 0x10,
>     INT_STATUS = 0x20,
>     COUNTER = 0xF0,
> }
> 
> // Go one step further and define types for all possible outcomes:
> #[derive(Copy)]
> enum HPETRegister {
>     Timer(&BqlRefCell<HPETTimer>, TimerRegister),
>     Global(GlobalRegister),
>     Unknown(hwaddr),
> }
> 
> struct HPETAddrDecode {
>     u32 shift,
>     u32 len,
>     HPETRegister reg,
> }
> 
> fn decode(&self, addr: hwaddr, size: u32) -> HPETAddrDecode {
>     let shift = ((addr & 4) * 8) as u32;
>     let len = std::cmp::min(size * 8, 64 - shift);
> 
>     addr &= !4;
>     let reg = if (0x100..=0x3ff).contains(&addr) {
>         let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
>         TimerRegister::try_from(addr)
>             .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
>     } else {
>         GlobalRegister::try_from(addr)
>             .map(HPETRegister::Global)
>     }
> 
>     // reg is now a Result<HPETRegister, hwaddr>
>     // convert the Err case into HPETRegister as well
>     let reg = reg.unwrap_or_else(HPETRegister::Unknown);
>     HPETAddrDecode { shift, len, reg }
> }
> 
> (untested).  The read and write functions then can do something like
> 
>     let val = match decoded.reg {
>         Timer(timer, reg) => timer.borrow_mut().read(decoded),
>         Global(GlobalRegister::CAP) => self.capability.get(),
>         Global(GlobalRegister::CFG) => self.config.get(),
>         ...
>     }
>     val >> decoded.shift
> 
> and for write:
> 
>     match decoded.reg {
>         Timer(timer, reg) => timer.borrow_mut().write(decoded, value),
>         Global(GlobalRegister::CAP) => {}, // read-only
>         Global(GlobalRegister::CFG) => self.set_cfg_reg(decoded, value),
>         ...
>     }
> 
> 
> The above could be a scheme that new devices could copy.  Overall I think it
> would be shorter code than what is there in rust/hw/timer/hpet (which is IMO
> already better than C, mind!).

Yes, I also like your way. It's a bit more abstract than current hpet,
but is also more simple than pl011 without bilge.

I also found that there's another example to abstract register fields
without bilge [2]. However, examples such as hpet without any abstraction
also exit [3].

From the experiences of other Rust VMMs, the handling of registers varies
greatly :-(, and there doesn't seem to be a unified approach. Developers
create abstractions according to their preferences, which I think is quite
different from C devices (in C, most people will hardcode everything
like hpet).

[2]: https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/devices/src/tpm.rs
[3]: https://github.com/google/crosvm/blob/main/devices/src/cmos.rs

> The honest question for people with less experience is whether this is
> readable at all; whether seeing it helps you learn the language or
> discourages you.

If you think this conversion is not urgent, perhaps this case could
become as a "good first issue" to encourage people practice and get
familiar with RustInQemu.

Regards,
Zhao


