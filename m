Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D89D609A0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 06:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGBMn-0007sw-4C; Wed, 27 Nov 2024 01:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tGBMl-0007si-B9; Wed, 27 Nov 2024 01:17:35 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tGBMj-00084e-AP; Wed, 27 Nov 2024 01:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732688253; x=1764224253;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cLMxevIKX9YlJD44FQS5ZQrh+RSehuIdUCBvDX3E6NQ=;
 b=b7/37AF0UjbsjICGOxd5X7BS/8DkG5qTxQHwC8Pzu3NIgjZhaC2L/NOE
 670ED/2hPgYsQQNOkzTw4SPIH4L1tzSFlVRMIl4tsm4XAzxvx6FDRki5U
 5uA31E/n+AQMQ+dJLJXE4CVqxVuz3Nr/9F9REyAmbnsr6QOw84WQfyxmt
 3mciqscNVu2pJB/XcnmL7qkbKYwFSY/nGA6/eSREtVWWlwiKphzYcR+lq
 hj3JpTxf7cJ6/IfEo/ivQgw9fCWkhI7F3jnNx1/4IyrV5Ex3zeHLcDWzi
 uS7hIepElNr8LXlwdLReToUtSihac0G0x9+cqJGnzqDMQwzZHBdbLk7tI g==;
X-CSE-ConnectionGUID: ye6fiM28QdKImg+t1TjYuw==
X-CSE-MsgGUID: CEwB/+sMSk2rdgyvT2ztdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32816860"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; d="scan'208";a="32816860"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2024 22:17:29 -0800
X-CSE-ConnectionGUID: 8Z4ynokcQeuu3ePbFtrp4A==
X-CSE-MsgGUID: JaP156PoQtOq4qAHi9nUVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; d="scan'208";a="92159201"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 26 Nov 2024 22:17:27 -0800
Date: Wed, 27 Nov 2024 14:35:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/2] rust: add BQL-enforcing Cell variant
Message-ID: <Z0a9uPLxrGyVJJwB@intel.com>
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-2-pbonzini@redhat.com>
 <Z0XhhB48W4Nqagku@intel.com>
 <1d0e1b5f-36ad-41d4-b526-260fa5cd0b34@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0e1b5f-36ad-41d4-b526-260fa5cd0b34@redhat.com>
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

On Tue, Nov 26, 2024 at 05:11:36PM +0100, Paolo Bonzini wrote:
> Date: Tue, 26 Nov 2024 17:11:36 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 1/2] rust: add BQL-enforcing Cell variant
> 
> On 11/26/24 15:56, Zhao Liu wrote:
> > > > But this actually applies to _all_ of the device struct!  Once a
> > > > pointer to the device has been handed out (for example via
> > > > memory_region_init_io or qdev_init_clock_in), accesses to the device
> > > > struct must not use &mut anymore.
> > 
> > is the final goal to wrap the entire DeviceState into the
> > BQLRefCell as well?
> 
> Not all of it, but certainly parts of it.  For example, the
> properties are not mutable so they don't need to be in the BqlRefCell. The
> parents (SysBusDevice/DeviceState/Object) also manage their mutability on
> their own.
> 
> The registers and FIFO state would be in q BqlRefCell; as an approximation I
> expect that if you migrate a field, it will likely be in a BqlRefCell.
> 
> For PL011, that would be something like
> 
> struct PL011Registers {
>     pub flags: registers::Flags,
>     pub line_control: registers::LineControl,
>     pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
>     pub control: registers::Control,
>     pub dmacr: u32,
>     pub int_enabled: u32,
>     pub int_level: u32,
>     pub read_fifo: [u32; PL011_FIFO_DEPTH],
>     pub ilpr: u32,
>     pub ibrd: u32,
>     pub fbrd: u32,
>     pub ifl: u32,
>     pub read_pos: usize,
>     pub read_count: usize,
>     pub read_trigger: usize,
> }
> 
> and a single "regs: BqlRefCell<PL011Registers>" in PL011State.

Here I have a possibly common question about the choice of BqlCell and
future BqlRefCell. Pls refer my comment below...

> > > QEMU's Big Lock (BQL) effectively turns multi-threaded code into
> > > single-threaded code while device code runs, as long as the BQL is not
> > > released while the device is borrowed (because C code could sneak in and
> > > mutate the device).  We can then introduce custom interior mutability primitives
> > > that are semantically similar to the standard library's (single-threaded)
> > > Cell and RefCell, but account for QEMU's threading model.  Accessing
> > > the "BqlCell" or borrowing the "BqlRefCell" requires proving that the
> > > BQL is held, and attempting to access without the BQL is a runtime panic,
> > > similar to RefCell's already-borrowed panic.
> > 
> > This design is very clever and clear!
> > 
> > But I'm a little fuzzy on when to use it. And could you educate me on
> > whether there are any guidelines for determining which bindings should
> > be placed in the BQLCell, such as anything that might be shared?
> 
> It's the same as normal Rust code.  If in Rust you'd use a Cell or a
> RefCell, use a BqlCell or a BqlRefCell.
> 
> Right now it's hard to see it because there are a lot of "bad" casts from
> *mut to &mut.  But once the right bindings are in place, it will be a lot
> clearer.  For example the pl011 receive callback (currently an unsafe fn)
> might look like this:
> 
>     pub fn receive(&mut self, buf: [u8]) {
>         if self.loopback_enabled() {
>             return;
>         }
>         if !buf.is_empty() {
>             debug_assert!(buf.len() == 1);
>             self.put_fifo(buf[0].into());
>         }
>     }
> 
> except that it would not compile because the receiver must be &self. Hence
> the need for the BqlRefCell<PL011Registers>, which lets you change it to
> 
>     pub fn receive(&self, buf: [u8]) {
>         let regs = self.regs.borrow_mut();
>         if regs.loopback_enabled() {
>             return;
>         }
>         if !buf.is_empty() {
>             debug_assert!(buf.len() == 1);
>             regs.put_fifo(buf[0].into());
>         }
>     }
> 
> Likewise for the MemoryRegionOps.  Right now you have
> 
>     pub fn write(&mut self, offset: hwaddr, value: u64) {
>         ...
>     }
> 
> but it will become
> 
>     pub fn write(&self, offset: hwaddr, value: u64) {
>         let regs = self.regs.borrow_mut();
>         ...
>     }

I understand we need BqlRefCell instead of BqlCell for registers since
there may be more than one reference, e.g., callbacks from CharBackend
and MemoryRegion may hold multiple references at the same time, right?

If right, like HPET, with only MemoryRegion callbacks, reads and writes
I guess which should not be able to happen at the same time, so BqlCell
is also feasible, as is Irq?

(This piece of the thread model is a bit more complex, and I'm fully
aware that the right TYPE relies a lot on understanding the underlying
mechanism, which I'm not yet familiar enough with :-) ).

However, all in all, using BqlRefCell for register fields looks to be
always better than BqlCell.

> Or who knows---perhaps the body of PL011State::write could become
> PL011Registers::write, and PL011State will do just
> 
>     pub fn write(&self, offset: hwaddr, value: u64) {
>         self.regs.borrow_mut().write(offset, value);
>         self.update()
>     }
> 
> You can already apply this technique to your HPET port using a "normal"
> RefCell.  You'd lose the BQL assertion check and your object will not be
> Sync/Send (this is technically incorrect, because the code *does* run in
> multiple threads, but with the current state of Rust in QEMU it's not a bad
> option), but apart from this it will work.

Thank you! I'll change the current code to support this. Instead of
implementing a register space like PL011, I continue to handle registers
with u64 variables and bit macro definitions like the C version. Also
related to the above question, I'm a bit hesitant to use BqlCell directly
or RefCell for such u64 fields...

> However if you have already written a vmstate, you'll have to disable the
> vmstate temporarily because the vmstate macros cannot (yet) accept fields
> within a BqlRefCell.  Personally I believe that disabling vmstate and
> experimenting with interior mutability is a good compromise.

Sure, I'll drop current VMState support.

> Plus, speaking in general, "it does something in a different way than the
> pl011 device model" is a good reason to merge the HPET model earlier too. :)

There must be a lot more opens :-(, such as the memattrs/timer binding,
which I hope to discuss with you at the later RFC!

> > > +    #[inline]
> > > +    pub fn replace(&self, val: T) -> T {
> > > +        debug_assert!(bql_locked());
> > 
> > Could debug_assert() work? IIUC, it requires to pass `-C debug-assertions` to
> > compiler, but currently we don't support this flag in meson...
> 
> Meson automatically adds -C debug-assertions unless you configure with
> -Db_ndebug=off, which we never do.  So debug_assert!() is always on in QEMU;
> whether to use it or assert!() is more of a documentation choice.

Thank you! I see.

Regards,
Zhao


