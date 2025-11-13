Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B18BCD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVIA-0003YV-N3; Thu, 13 Nov 2025 06:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJVHh-0003QL-Fk; Thu, 13 Nov 2025 06:14:41 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJVHe-0007Tn-PH; Thu, 13 Nov 2025 06:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763032475; x=1794568475;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=E15EvPAB9mcWDFyZnYUCrN4uc2YHoLzwasy+C5WvUdw=;
 b=P7t2pOYZdgKRiFfOrn0hD+bhIpXZbwTxnpmpKa+qAcG2tNBwy0YyS8KY
 idXrc2CieYbhaCPV2rw9/CFou3IinixpdfrxfGJJtoU9RXApsSnUtcg7V
 v+FuoL9vKGjP6YrHLRTIuRSX35S2Fy9uJLJGHdVhWxmaG/7mRRPD52OrO
 nKxtM8fFcXYnKpsfRICh51ZhQh5Y1+hVmjEuhTJOw1RXQLwrDVAP4kIfM
 nBvX2UgNF/a6lmR4b4V60WoBM9VK1qIGEsttvhKeJ1E5CZ9vIuTLAK2WI
 9Gk4S9jFB+1TR6fk4Zvql3GoLsNbF1pnJpbOtoPWGCFLbSLzEE5oX5ZGG g==;
X-CSE-ConnectionGUID: aiqaZ2zdRUWvIK/RFPZjMg==
X-CSE-MsgGUID: evXVPTTlQCer5Zj9HmyGfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52672491"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="52672491"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 03:14:30 -0800
X-CSE-ConnectionGUID: txyJsHcgQXGWOv6/h9W/zw==
X-CSE-MsgGUID: H8srIgstSeWnboVpOLXKUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="189276762"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 13 Nov 2025 03:14:28 -0800
Date: Thu, 13 Nov 2025 19:36:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?B?TWFyYy1BbmRy77+9?= Lureau <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 21/22] rust/hpet: Replace BqlRefCell<HPETRegisters> with
 Mutex<HPETRegisters>
Message-ID: <aRXCzNrv9d7vZHzN@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
 <20251113051937.4017675-22-zhao1.liu@intel.com>
 <aRWlfgShnpNbiLAP@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRWlfgShnpNbiLAP@intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Nov 13, 2025 at 05:31:42PM +0800, Zhao Liu wrote:
> Date: Thu, 13 Nov 2025 17:31:42 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 21/22] rust/hpet: Replace BqlRefCell<HPETRegisters>
>  with Mutex<HPETRegisters>
> 
> > @@ -179,8 +180,8 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
> >  fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
> >      let mut t = timer_cell.borrow_mut();
> >      // SFAETY: state field is valid after timer initialization.
> > -    let regs = &mut unsafe { t.state.as_mut() }.regs.borrow_mut();
> > -    t.callback(regs)
> > +    let mut regs = unsafe { t.state.as_ref() }.regs.lock().unwrap();
> > +    t.callback(&mut regs)
> >  }
> 
> callback()
>  -> arm_timer(): access timer N register
>  -> update_irq(): modify global register (int_status or "isr" in C code)
> 
> So timer handler needs to lock Mutex. But this may cause deadlock:
> 
> timer_hanlder -> lock BQL   -> try to lock Mutex
> MMIO access   -> lock Mutex -> try to lock BQL
> 
> C HPET doesn't have such deadlock issue since it doesn't lock Mutex in
> timer handler.
> 
> I think it seems necessay to lock Mutex in timer handler since there's
> no guarantee to avoid data race...

One possible way may be to introduce lockless timer callback, but at
Rust side, this needs to extract timers from BqlRefCell and add extra
Muetx to protect timer state.

So a simple way is to just unlock bql before acquiring Mutex in timer
handler, which give a chance for MMIO to acquire BQL. And this way could
fix locking order in timer handler.

Code example:

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index f96dfe1ebd06..389eb9b49eb6 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -178,10 +178,35 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
 }

 fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
-    let mut t = timer_cell.borrow_mut();
-    // SFAETY: state field is valid after timer initialization.
-    let mut regs = unsafe { t.state.as_ref() }.regs.lock().unwrap();
-    t.callback(&mut regs)
+    let state_p = {
+        let t = timer_cell.borrow();
+        t.state
+    };
+
+    // Release BQL first and acquire Mutex instead. This avoids deadlock
+    // since lockless IO will lock Mutex first and then try to acquire
+    // BQL.
+    //
+    // SAFETY: BQL free context only locks Mutex and will do nothing else.
+    unsafe {
+        bql::unlock();
+    }
+
+    // SAFETY: state_p is valid and we just access Mutex and don't touch
+    // other fields. Mutex could guarantee the registers access is safe
+    // during BQL is unlocked.
+    let mut regs = unsafe { state_p.as_ref() }.regs.lock().unwrap();
+
+    // After Mutex is locked, lock BQL again. This ensures both timer
+    // handler and MMIO have the same locking order.
+    //
+    // SAFETY: BQL context is expected for timer handler and now the
+    // correct locking order eliminates deadlock.
+    unsafe {
+        bql::lock();
+    }
+
+    timer_cell.borrow_mut().callback(&mut regs);
 }

 #[repr(C)]


Thanks,
Zhao



