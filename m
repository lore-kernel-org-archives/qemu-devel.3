Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC825C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp88G-0002jE-I7; Mon, 03 Mar 2025 10:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp88D-0002fv-Co; Mon, 03 Mar 2025 10:55:01 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp88A-0000Y3-FL; Mon, 03 Mar 2025 10:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741017298; x=1772553298;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=z1UjXqVzct7YFVuffMJy4c7g4hR0HfuRxWzJ/Y2nCX8=;
 b=CcduDqsyOhkqZ/UOOD8gt5A98VfSftsSLkxkNg/V4uh/3I5okoOOQThK
 +04UduYwa0BTDjDTdWfTJ5SRiVKJOoHrhW/OLssGmk46ChLrfhAcdgYLh
 htVa4UNuW4Q5/J9G6L9f9MfB4BlBEczClKVo+k/d3q6Wtvx/1LcXY8DpH
 N4Yxj8Zi4LE892athbXbUhv5nbtdqDo19VfAsYt9n8bY8VxVQw8vEBahD
 N52czfPIrbKMznjAfg8c24IBYGVOR29Rks+NYTyLsqsJopEaVa7ekXT8s
 T3EB8sza5iwOtRFSB2nJAlwu95LIwJ6Uh1/YSb45nNMTKzCSAGdewxxQG A==;
X-CSE-ConnectionGUID: RFQxZ6FDRJigUDTTIJkxnQ==
X-CSE-MsgGUID: ywDZx6mlRKu1XYx7dMTMGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41073319"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="41073319"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 07:54:55 -0800
X-CSE-ConnectionGUID: BTpT3DXDRuqOUTasSSaPVw==
X-CSE-MsgGUID: HWaGq3ogT9WqNWYK/CgaBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="118552939"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 07:54:54 -0800
Date: Tue, 4 Mar 2025 00:15:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
 express pinning requirements
Message-ID: <Z8XVhUu5Sjaus4Hi@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-5-pbonzini@redhat.com>
 <Z8W8hzFO9HU3IujQ@intel.com>
 <4b4ca8d8-662f-409c-96dd-11c5075252e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4ca8d8-662f-409c-96dd-11c5075252e2@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Mon, Mar 03, 2025 at 03:51:25PM +0100, Paolo Bonzini wrote:
> Date: Mon, 3 Mar 2025 15:51:25 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
>  express pinning requirements
> 
> On 3/3/25 15:28, Zhao Liu wrote:
> > > -    pub fn init_full<'timer, 'opaque: 'timer, T, F>(
> > > -        &'timer mut self,
> > > +    pub fn new_full<'opaque, T, F>(
> > >           timer_list_group: Option<&TimerListGroup>,
> > >           clk_type: ClockType,
> > >           scale: u32,
> > >           attributes: u32,
> > >           _cb: F,
> > >           opaque: &'opaque T,
> > > -    ) where
> > > +    ) -> Pin<Box<Self>>
> > >           F: for<'a> FnCall<(&'a T,)>,
> > >       {
> > 
> > Ah, the lifetime here isn't effectively bound... However, I also
> > referred to your latest code [1] :), and it seems that this issue
> > has already been fixed. (Nit: The code still has a complaint from
> > `cargo fmt`)
> 
> I am not sure if the change I have in that commit actually does anything,
> unfortunately... :( which is why I wanted to use init_full instead of
> new_full.

EMM, I tried with the below case...

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index a440c9f4cb98..c167d69eef4c 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -190,14 +190,17 @@ fn init(&mut self, index: usize, state_ptr: *mut HPETState) -> &mut Self {
     }

     fn init_timer_with_state(&mut self) {
-        self.qemu_timer = Some(Timer::new_full(
-            None,
-            CLOCK_VIRTUAL,
-            Timer::NS,
-            0,
-            timer_handler,
-            &self.get_state().timers[self.index],
-        ));
+        {
+            let tmp = &self.get_state().timers[self.index];
+            self.qemu_timer = Some(Timer::new_full(
+                None,
+                CLOCK_VIRTUAL,
+                Timer::NS,
+                0,
+                timer_handler,
+                tmp,
+            ));
+        }
     }

     fn get_state(&self) -> &HPETState {

---

It can compile and seems lifetime doesn't work... I think if we want the
lifetime check, it would be necessary to store &opaque in Rust's Timer
wrapper and specify a lifetime for Timer.

Maybe we need something like (similar to MemoryRegionOps):

pub struct Timer<'timer, T> {
    Opaque<bindings::QEMUTimer>,
    PhantomData<&'timer T>,
}

> It's easiest to marked new_full() unsafe for now.

Yes, I agree.

Thanks,
Zhao


