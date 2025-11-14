Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D741CDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 06:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJn7Q-0004Yr-Hy; Fri, 14 Nov 2025 01:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJn7M-0004Xk-ES; Fri, 14 Nov 2025 01:17:08 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJn7J-0006oi-D0; Fri, 14 Nov 2025 01:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763101026; x=1794637026;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VV0UpawImWFH3xZGjVbej/CWiDter091wmFQqpUYUr8=;
 b=mmLWVo4iYnF9xAAtF+XGkqlgRXKuuFlHu4PgAqRSiqP+a2/IgxpljQM1
 1c+SPUSdeR5IjDa1tuc3sDuSKAb+UAossmvh1s/ndCOxQ00Y7lyAVxUdq
 QXBLTSyL4ytrkd9a7WP2t958brNVUbuSDH+0ru6HCk7cvdXP2o6oyprZQ
 h4Ok+8OMco2pzi75G5MbQMjc6qWLlIScfXC7a8FoGObku43wiMv/cEqh6
 xnn4BGWgX48WKEp6QTTBt3nKfi29IFq0HVX2OivUhY9vuZtMjd5qppRve
 X/KoY3j/rFAFl1ilu4OgrbK32LQBHuh8PbGZlTMgAObyMipld7Wt2qifd A==;
X-CSE-ConnectionGUID: +ay4EyeJScil0eSmDl+PMw==
X-CSE-MsgGUID: lzMxUFUsS6OWGDpvwMPYfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65351054"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; d="scan'208";a="65351054"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 22:16:55 -0800
X-CSE-ConnectionGUID: 0u2Ct5K/RtKPc/lRIdcFDA==
X-CSE-MsgGUID: OPxAToSFQEKeHRcC+goM3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; d="scan'208";a="188987084"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 13 Nov 2025 22:16:53 -0800
Date: Fri, 14 Nov 2025 14:39:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 22/22] rust/hpet: Enable lockless IO
Message-ID: <aRbOjuDk3USq2RLK@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
 <20251113051937.4017675-23-zhao1.liu@intel.com>
 <6ed6a959-fe49-4635-9051-b9bbc91dd2e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed6a959-fe49-4635-9051-b9bbc91dd2e4@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

> >   * BqlCell/BqlRefCell access.
> > 
> >     Except InterruptSource, HPETState has other BqlCell and BqlRefCell:
> >     hpet_offset (BqlCell<u64>), rtc_irq_level (BqlCell<u32>) and timers
> >     ([BqlRefCell<HPETTimer>; HPET_MAX_TIMERS]).
> > 
> >     Their data may change during runtime, so the atomic context is
> >     required.
> 
> I have already mentioned HPETTimer in the other email, but I would also move
> hpet_offset to HPETRegisters if possible.  It doesn't seem hard.

Yeah, it can.

> And as an aside, I wonder if you really need to pass MutexGuard and not &mut
> HPETRegisters.  Once you don't have BQL dependencies, you can just remove
> the assert!(bql::is_locked()) without switching to MutexGuard<>.

The main reason for using MutexGuard at present is to explicitly
indicate that it is protected by a Mutex. Because I considered that
get_mut() in the timer handler could bypass the lock(). But get_mut
depends on the unsafe code `unsafe { t.state.as_mut() }` which always
needs careful check and review.

So yes, we can use &mut HPETRegisters directly.

> In the meanwhile, even if they are not perfect (especially due to
> migration), I think touching patches 1-19 further is too messy, so I'll
> rebase on top of Stefan's tracing patches and push them to rust-next. Let's
> start from there and I'll take a look tomorrow maybe on how to fix
> migration.  Migratable<HPETTimer> looks like a powerful tool for that.

Thank you! 

> Then the new problem is that we have to figure out a way to handle IRQs.
> They are also messy for PL011 compared to the C version, and that will make
> it possible to enable lockless IO.
>
> The crazy idea that just came to mind, is a Latched<u32> that is something
> like an (AtomicU32, BqlCell<u32>) tuple.  Then we set the individual bits
> outside the BQL and update IRQs at the end of the MMIO in a
> bql::with_guard() block.

This is an interesting idea and sounds like a "RCU" (write-copy-update)?

HMM, what does u32 mean, irq number? I understand the bql::with_guard()
is after Muext locking, i.e., after writing registers.

At that point, we need to know which irq should be operated (this is the
u32 but we also have pit_enabled), and what operation should we do now.

I'm not sure whether a tuple is enough... because there may be multiple
IRQ operations during Mutex locking:

fn set_cfg_reg(&self, regs: &mut MutexGuard<HPETRegisters>, shift: u32, len: u32, val: u64) {
    ...
    // i8254 and RTC output pins are disabled when HPET is in legacy mode
    if activating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
        bql::with_guard(|| {
            self.pit_enabled.set(false);
            self.irqs[0].lower();
            self.irqs[RTC_ISA_IRQ].lower();
        });
    } else if deactivating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
        bql::with_guard(|| {
            // TODO: Add irq binding: qemu_irq_lower(s->irqs[0])
            self.irqs[0].lower();
            self.pit_enabled.set(true);
            self.irqs[RTC_ISA_IRQ].set(self.rtc_irq_level.get() != 0);
        });
    }
}

So do we need a lockless queue to store IrqOps during Mutex locking?

pub enum HPETIrqOp {
    Lower(usize), // usize is index in HPETState::irqs[]
    Pulse(usize),
    Raise(usize),
    Set(usize, bool),
    PitSet(bool), // HPETState::pit_enabled
}

Another point I'm considerring is: the IRQ ops is cached in MMIO Mutex,
while its execution occurs in the MMIO BQL. If a timer handler (which
acquires BQL and then Mutex) is present between MMIO Mutex and MMIO BQL,
and also performs an IRQ op, this seems possible a "reordering" issue
for IRQ ops. Is this ok?

I guess it's ok, since even hardware may also can't guarantee that
register operation and irq operation is atomic...

Then with your idea, this could fix deadlock I mentioned in patch 21 and
we don't need the fix to unlock bql in timer handler anymore...

BTW, but, shouldn't C HPET also lock the mutex in the timer handler?

> Maybe if you have some time you can prototype that
> for PL011 (even without generics, you could just do LatchedU32 for a start)?

I guess you mean HPET? PL011 is also Ok but it hasn't reached the
lockless stage yet.

Thanks,
Zhao


