Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC1DE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 07:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXsu-0000Ns-Ga; Mon, 09 Dec 2024 02:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKXsk-0000NE-E6; Mon, 09 Dec 2024 02:08:38 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKXsi-0006HX-EV; Mon, 09 Dec 2024 02:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733728116; x=1765264116;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IPpYrrJtMWddig4XgUWv2LjN2byabCvSlfDN2VQRnPw=;
 b=b65J9pn9ZR861OTxc/ThD0PeNhHWLwO2/r6nnF1nl++YXYxQpWab9gOY
 NkwdE9KDMqhcq3tIw9ZaI6o39zPy8+hP3GtVlc/ACzyTQNoSnfoKO3W2x
 mKstlGKAuv+kAIRzZ4/Q8kZbyQIehaEePKP7MhJxe3g4EPCxYlB92+K9n
 cECzqSKCQlA/Q9XXXZxo7rjjzIRnQu3cWYqex5L471OunuhXag+lXFEO4
 ZZ6rJygcHB8dc7gtoiHqwenX4vQgfPf01DOCFGpDDMTqalbswvd/Jhiep
 Rtvc15FBrxJp1xaMukfyaW0TzEkbrkxzBVMqMoHbTnbT2G5lD/whekoTQ A==;
X-CSE-ConnectionGUID: raw/RZ1vTRaDWm9/qYeezg==
X-CSE-MsgGUID: BL2K4nyaShOD44jtbaK+pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45390288"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; d="scan'208";a="45390288"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2024 23:08:28 -0800
X-CSE-ConnectionGUID: S2LMo1buTCK/Mdh1TO7n0A==
X-CSE-MsgGUID: NAP7NNSDRLCc2yYFrvMJFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; d="scan'208";a="95323020"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 08 Dec 2024 23:08:25 -0800
Date: Mon, 9 Dec 2024 15:26:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 11/13] rust/timer/hpet: add basic HPET timer & state
Message-ID: <Z1abr52uM7lHqPVq@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-12-zhao1.liu@intel.com>
 <b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
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

> > +use qemu_api::{
> > +    bindings::*,
> 
> Let's avoid bindings::*.

Sure.

> > +        self.qemu_timer = Box::new(HPETState::timer_new_ns(
> 
> Oh! I noticed now that while your API is called timer_new_ns, it is actually
> the same as timer_init_full.  Let's call it init_full() then.

Sure, will use init_full() directly.

> > +    fn get_state_ref(&self) -> &HPETState {
> > +        // SAFETY:
> > +        // the pointer is convertible to a reference
> > +        unsafe { self.state.unwrap().as_ref() }
> > +    }
> > +
> > +    fn get_state_mut(&mut self) -> &mut HPETState {
> > +        // SAFETY:
> > +        // the pointer is convertible to a reference
> > +        unsafe { self.state.unwrap().as_mut() }
> > +    }
> 
> You should not need get_state_mut(), which also has the advantage of
> shortening get_state_ref() to get_state().

I see now, internal mutability requires using immutable references
as much as possible!

...

> > +    /// True if timer interrupt is level triggered; otherwise, edge triggered.
> > +    fn is_int_level_triggered(&self) -> bool {
> > +        self.config & 1 << HPET_TN_CFG_INT_TYPE_SHIFT != 0
> > +    }
> 
> PL011 is using bilge here.  I think it's fair to show the two ways to do it.
> If we have devices showing two different things:
> 
> - PL011 shows higher-level abstractions for registers
> 
> - HPET has a good approach to interior mutability from the beginning
> 
> Then it gives a clearer view of the options.

Yes, I am used to handling registers in a C-style way, which is more
straightforward and easier for me to use. However, compared to PL011, it
has less abstraction so that it might look a bit messier. The choice of
different options is basically a trade-off between different styles. :-)

> > +    fn update_int_status(&mut self, set: bool) -> &mut Self {
> > +        let mask: u64 = 1 << self.index;
> > +
> > +        if set && self.is_int_level_triggered() {
> > +            // If Timer N Interrupt Enable bit is 0, "the timer will
> > +            // still operate and generate appropriate status bits, but
> > +            // will not cause an interrupt"
> > +            *self.get_state_mut().int_status.get_mut() |= mask;
> > +        } else {
> > +            *self.get_state_mut().int_status.get_mut() &= !mask;
> > +        }
> > +        self
> > +    }
> 
> See remarks elsewhere on update_int_status(), and how it uses
> get_state_mut() and get_mut().

Thank you! Will change as your example.

> > +                unsafe {
> > +                    address_space_stl_le(
> > +                        &mut address_space_memory,
> > +                        self.fsb >> 32,  // Timer N FSB int addr
> > +                        self.fsb as u32, // Timer N FSB int value, truncate!
> > +                        *MEMTXATTRS_UNSPECIFIED,
> > +                        null_mut(),
> > +                    );
> > +                }
> 
> This is the only use of unsafe, whic is not bad at all.  Not urgent, but we
> should think about the AddressSpace bindings, and whether it makes sense to
> use (or steal APIs from) rust-vmm's vm-memory.

Good idea, I agree that this is a good "starting" point to consider
introducing rust-vmm to QEMU. I'll add it to my TODO list and consider
it. Once I have some ideas, I'll share them.

> > +    fn arm_timer(&mut self, tick: u64) {
> > +        let mut ns = self.get_state_ref().get_ns(tick);
> > +
> > +        // Clamp period to reasonable min value (1 us)
> > +        if self.is_periodic() && ns - self.last < 1000 {
> > +            ns = self.last + 1000;
> > +        }
> > +
> > +        self.last = ns;
> > +        self.qemu_timer.as_mut().timer_mod(self.last);
> > +    }
> 
> No as_mut(), timer_mod is thread safe.  timer_mod() need to take &self.

Ok, I understand then I need to implement a as_mut_ptr to convert
`&self` to `* mut QEMUTimer`, as you did for SysBusDevice.

> > +    fn del_timer(&mut self) {
> > +        self.qemu_timer.as_mut().timer_del();
> 
> Same as above.

I see, thanks.

> > +#[derive(Debug)]
> > +pub struct HPETTimerInstance(BqlRefCell<HPETTimer>);
> > +
> > +impl HPETTimerInstance {
> > +    fn timer_handler(timer: &mut HPETTimerInstance) {
> > +        timer.0.borrow_mut().callback()
> > +    }
> > +}
> 
> Also not "&mut" - you don't need it, as "timer.0" is only used to borrow
> from the BqlRefCell.  Also with a more refined timer abstraction this
> doesn't need HPETTimerInstance, it can probably be a global function like
> 
> fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
>     timer_cell.borrow_mut().callback()
> }

I see, it's clearer!

> > +    /// General Capabilities and ID Register
> > +    capability: BqlCell<u64>,
> > +    ///  General Configuration Register
> > +    config: BqlCell<u64>,
> > +    /// General Interrupt Status Register
> > +    int_status: BqlCell<u64>,
> > +    /// Main Counter Value Register
> > +    counter: BqlCell<u64>,
> > +
> > +    /// Internal state
> > +
> > +    /// Capabilities that QEMU HPET supports.
> > +    /// bit 0: MSI (or FSB) support.
> > +    pub(crate) flags: BqlCell<u32>,
> 
> flags doesn't need to be a cell (it's just a property).  I'll send a patch
> for the C code.

Thank you! I've reviewed that patch.

> > +    /// Offset of main counter relative to qemu clock.
> > +    hpet_offset: BqlCell<u64>,
> > +    pub(crate) hpet_offset_saved: bool,
> > +
> > +    irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
> > +    rtc_irq_level: BqlCell<u8>,
> > +    pit_enabled: InterruptSource,
> > +
> > +    /// Interrupt Routing Capability.
> > +    /// This field indicates to which interrupts in the I/O (x) APIC
> > +    /// the timers' interrupt can be routed, and is encoded in the
> > +    /// bits 32:64 of timer N's config register:
> > +    pub(crate) int_route_cap: u32,
> > +
> > +    /// HPET timer array managed by this timer block.
> > +    timer: [HPETTimerInstance; HPET_MAX_TIMERS],
> > +    pub(crate) num_timers: BqlCell<usize>,
> 
> Ah, this needs to be a BqlCell because it can be clamped to
> MIN_TIMERS..MAX_TIMERS by realize.  Fair enough.

Yes, it's a corner case.

Regards,
Zhao


