Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7CAF506D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29MM-0002lT-Do; Mon, 16 Mar 2026 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w29MK-0002jY-7e; Mon, 16 Mar 2026 10:55:56 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w29MG-0005Bg-Ho; Mon, 16 Mar 2026 10:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773672952; x=1805208952;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=BJZoEpMwSTo1UvAo3RoonQbfkW8gnYuTOP+deW7gfZ0=;
 b=ORPvhH+Z1Q3YklD3kIuWemy6BhGcez/fxVTuG4Y+hxML0HC111VNeIXK
 NSJMEBLNrkH0wbeeX1h9bd0ZnNHpucIuX/AUpIDnTw4Aa9CrcLOI8AyDE
 YPM462z55rorsnvZlO7MZ/iUVCB7Mwckepdpq9mFNS2uYNfGDiskzKNUB
 3BDvwUy1klEXKHwXChMHLaV19pR/gYSbO44hsFjNPsU0H8VBo1RDvd+pi
 aa4oJMNgZ9Ch59/lK/6oqbvDAcyGWIXWOg/e8D4SvkZUBxn2Ynkq+kOmt
 1U5ttNlKK8Pi6ZRbmNta2nwBFnWX4rCc4PKwmtaiipVvzbudGsTVxQNuO g==;
X-CSE-ConnectionGUID: KePQHjO4QjaUTvCKCAR+oQ==
X-CSE-MsgGUID: Y4NIsYgnRQmfl8NzrhnR1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86167182"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86167182"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:55:47 -0700
X-CSE-ConnectionGUID: UBx9dT/tRIGJY+RgTkBTRg==
X-CSE-MsgGUID: MkiUdba8TtGqoh9pacEsVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226921208"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 16 Mar 2026 07:55:46 -0700
Date: Mon, 16 Mar 2026 23:21:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/5] rust/hpet: complete moving state out of HPETTimer
Message-ID: <abggFzbWA2Dfkuvm@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117084752.203219-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Hi,

> I'm leaving out the conversion to Mutex because, as Zhao noticed, it
> has a deadlock - the timer callback tries to grab the HPET mutex inside
> the BQL, where as the vCPU tries to grab the BQL inside the HPET mutex.
> This is not present in the C code only because... it doesn't take the
> lock at all in places where it should.  In particular hpet_timer() reads
> and writes t->cmp and t->cmp64 outside the lock, while hpet_ram_write()
> does so within the lock via hpet_set_timer().

About this issue, I'd like to continue previous discussion and share
some my thoughts.


Review the Current Issue
========================

To better explain the scope of locks and compare different options later,
let me go over the previous issue in more detail.

HPET's timer callback hpet_timer() currently does NOT hold s->lock (the
device mutex). This is a data race bug: it modifies t->cmp64, t->cmp,
t->wrap_flag, and calls update_irq() -- all of which race with
hpet_ram_write().

However, fixing this by adding QEMU_LOCK_GUARD(&s->lock) to hpet_timer()
creates an AB-BA deadlock:

  Path A (timer callback):  BQL ¡ú mutex
    main_loop_wait() holds BQL
    ¡ú qemu_clock_run_all_timers()
      ¡ú timerlist_run_timers() 
        ¡ú hpet_timer()
          ¡ú QEMU_LOCK_GUARD(&s->lock)    // mutex under BQL

  Path B (MMIO write):      mutex ¡ú BQL
    lockless_io = true, so no BQL on entry
    ¡ú hpet_ram_write()
      ¡ú QEMU_LOCK_GUARD(&s->lock)      // mutex first
        ¡ú update_irq()
          ¡ú BQL_LOCK_GUARD()            // BQL under mutex
            ¡ú qemu_set_irq()

I think we could have these 3 options in hand:
 * lockless timer: unlock bql for HPET timer handler - like lockless MMIO did
 * lockless irq: implement lockless ioapic/gic/...
 * defer call: defer BQL related call outside of mutex context.

Since the Rust implementations are currently mirrors of the C code, I'll use
C-side pseudocode as the main examples.


Option 1: Lockless timer attribute
==================================

Add a QEMU_TIMER_ATTR_LOCKLESS flag. In timerlist_run_timers(), release
BQL before invoking a timer callback marked with this attribute, and
re-acquire it afterward:

    /* in timerlist_run_timers(), around cb(opaque) call: */
    bool release_bql = (ts->attributes & QEMU_TIMER_ATTR_LOCKLESS)
                       && bql_locked();
    if (release_bql) {
        bql_unlock();
    }
    cb(opaque);
    if (release_bql) {
        bql_lock();
    }

With this, HPET's timer callback runs without BQL, and can do:

    hpet_timer() {
        QEMU_LOCK_GUARD(&s->lock);   // mutex first, no BQL held
        ...
        update_irq(t, 1);            // takes BQL inside ¡ú mutex¡úBQL
    }

Both paths become mutex¡úBQL. Deadlock eliminated.

This option has minimal change, and it also aligns well with the concept
of lockless devices - its approach is consistent with lockless MMIO, i.e,
transferring the lock-protected implementation and responsibility to the
device itself.

But I'm not sure if modifying the timer is a sufficiently general and
thorough approach: if other types of devices also implement lockless,
would we need to convert more callbacks to bql-free? More bql-free
callbacks sounds a bit messy?


Option 2: Lockless interrupt controllers (IOAPIC/PIC/GSI)
---------------------------------------------------------

Make the entire GSI¡úIOAPIC/PIC path BQL-free by converting interrupt
controller state to atomic operations or fine-grained locks. Then
update_irq() would never need BQL, eliminating the mutex¡úBQL nesting
in the MMIO path entirely.

This refers Paolo's previous idea:

https://lore.kernel.org/qemu-devel/ac058be3-274a-4896-b01d-f433d036b5d0@redhat.com/

This is the most thorough solution: IRQ path becomes fully BQL-free and
all lockless_io devices benefit automatically.

I find the first blocking issue is gsi_handler() under CONFIG_XEN_EMU
calls xen_evtchn_set_gsi() which has assert(bql_locked()). The Xen
event channel's callback_gsi logic uses a synchronous recursive flag
(setting_callback_gsi) that deeply depends on BQL's mutual exclusion
semantics. This looks like it needs refactoring?

I think PIC and IOAPIC also need device locks or atomic operations for
protection, but their lockless implementations all have complexity.


Option 3: defer_call to reorder lock acquisition in MMIO path
=============================================================

Previously, I had a POC (in Rust) to defer IRQ injection after Mutex
context:
https://gitlab.com/zhao.liu/qemu/-/tree/rust-hpet-lockless-v0-01-04-2026

I hold it in hand and didn't post it since I thought it's not easy to
make C side apply this method. Until I realized that QEMU actually
already has defer call! Although what I need is still somewhat different
(like allowing repeated calls, BQL context), the thread-local handling
is more concise and elegant than my POC.

So it's possible to use QEMU's defer_call mechanism (with some
additional minor enhancements: allowing repeated calls, BQL context) to
defer qemu_set_irq() calls to after the device mutex is released in the
MMIO write path:

    hpet_ram_write() {
        defer_call_begin();
        QEMU_LOCK_GUARD(&s->lock);
        // state updates under mutex, record pending IRQ actions
        defer_call(hpet_flush_irqs, s);
        // mutex released here
        defer_call_end();
        // hpet_flush_irqs runs here: BQL_LOCK_GUARD() + qemu_set_irq()
        // mutex and BQL are never nested
    }

A problem is, then the MMIO is not atomic: With lockless_io, multiple
vCPUs can concurrently enter MMIO handlers. Between mutex release and
defer_call_end(), another vCPU could modify state, causing the deferred
IRQ action to operate on stale decisions.

This situation is relatively rare, and I think the delayed updates in a
few cases of state are also acceptable?

This option is more complex than option 1, since for Rust side, we will
need a defer call binding. But this option doesn't need to justify
whether other callbacks (like timer) could or should support BQL-free.


Discussion
==========

Overall, I think option 1 or 3 are general lockless infrastructure
enhancements, while option 2 is an i386-specific lockless feature. So
maybe we could choose one from options 1 and 3, decouple it from option
2, meaning both could proceed in parallel? What do you think?

Thanks and Best Regards,
Zhao




