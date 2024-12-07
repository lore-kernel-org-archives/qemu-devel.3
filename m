Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48524E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 16:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJxmq-00040a-5J; Sat, 07 Dec 2024 11:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJxmn-00040I-32; Sat, 07 Dec 2024 11:36:05 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJxmi-0007xZ-M7; Sat, 07 Dec 2024 11:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733589361; x=1765125361;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8i8Q1U2qBdH3wChDFOQ0RJF5k5tRcQWbkpah4sAGWjE=;
 b=A+hbtUiPOwlBJASxR5cKsHnrYcKPBG4aQb6+xWyfK+DPunRqPMbBPjVB
 QEXnkJcaoxd9qNliA+9J258Uv/xEhqqYdjacL4bmsxCFrQ4JbqmA5vs2v
 u24VT3iZ0RtGZe67mP1HTjHlUAD6X4OJmGUNDkC/gR8UY8EyGshtHYWVc
 bzlLQfU5AP3mzjOmyPH5E6b4CbN3cMfarzupO4Wc6DBVkYo50sxO5wZOd
 CwZgloSfshAGsoq7N4Hq2jhj1Z9sMaWPQNPvswkg7fQW6PhYDoDjLVKMx
 mQb1ysVhxlz1ONx+irga1VOVoNxaD2PXf47kHKPVpeScup//VF8c2aj8R Q==;
X-CSE-ConnectionGUID: EwiizWehSoCnXRJ8Xg5+Lw==
X-CSE-MsgGUID: fySpms9XTESfwjclT1Zu3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="44535350"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="44535350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2024 08:35:57 -0800
X-CSE-ConnectionGUID: mdJOrMV8Q9iOe4kMbEm4wQ==
X-CSE-MsgGUID: vG/WOqPXQbmvefDGtfzPng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="94528166"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 07 Dec 2024 08:35:54 -0800
Date: Sun, 8 Dec 2024 00:54:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 07/13] rust: add bindings for timer
Message-ID: <Z1R9rxvzyJXKk1ly@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-8-zhao1.liu@intel.com>
 <9cb123e2-5237-46e7-b6fe-ce8f813cc43c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb123e2-5237-46e7-b6fe-ce8f813cc43c@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Thu, Dec 05, 2024 at 07:46:52PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 19:46:52 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 07/13] rust: add bindings for timer
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > +impl QEMUTimer {
> > +    fn new() -> Self {
> > +        QEMUTimer {
> > +            expire_time: 0,
> > +            timer_list: ::core::ptr::null_mut(),
> > +            cb: None,
> > +            opaque: ::core::ptr::null_mut(),
> > +            next: ::core::ptr::null_mut(),
> > +            attributes: 0,
> > +            scale: 0,
> > +        }
> > +    }
> 
> Please implement Zeroable instead and make this just Self::ZERO.

Sure, will do.

> > +    // TODO: Consider how to avoid passing in C style callbacks directly.
> > +    fn timer_new_full<T: QEMUTimerImpl>(
> > +        timer_list_group: Option<&mut QEMUTimerListGroup>,
> > +        clk_type: QEMUClockType,
> > +        scale: u32,
> > +        attributes: u32,
> > +        opaque: &mut T::Opaque,
> 
> This gets tricky when you have more than one timer per device.  With the right
> infrastructure we can make this something like
> 
>     fn timer_init_full<'a, 'b: 'a, T, F: 'b Fn(&'b T)>(
>         &'a mut self,
>         timer_list_group: Option<&mut QEMUTimerListGroup>,
>         clk_type: QEMUClockType,
>         scale: u32,
>         attributes: u32,
>         f: &F,
>         opaque: &'b T) {
>         // SAFETY: the opaque outlives the timer
>         unsafe {
>             timer_init_full(...)
>         }
>     }
> 
> So I guess that's another thing I have to extract and post. :)

Thank you so much for your help! I'm happy to help test and review.

(if you feel you don't have enough time, I'm also willing to try this
way.. and if there's any issue, I'll let you know...)

whichever way you think is solid, I'm both happy with it.

> BTW don't bother with timer_new, only do the non-pointer timer_init.

Do you mean timer_init is enough, and timer_new and its variants are not
necessary?

> > +    pub fn timer_del(&mut self) {
> > +        unsafe { timer_del(self as *mut QEMUTimer) };
> > +    }
> > +}
> 
> Please also add a Drop implementation that calls timer_del.

Sure!

> > +pub fn qemu_clock_get_virtual_ns() -> u64 {
> > +    // SAFETY:
> > +    // Valid parameter.
> > +    (unsafe { qemu_clock_get_ns(QEMUClockType::QEMU_CLOCK_VIRTUAL) }) as u64
> > +}
> 
> Maybe something like
> 
> pub struct Clock {
>     id: QEMUClockType
> }
> 
> impl Clock {
>     pub fn get_ns() -> u64 {
>         // SAFETY: cannot be created outside this module, therefore id
>         // is valid
>         (unsafe { qemu_clock_get_ns(self.id) }) as u64
>     }
> }
> 
> pub static CLOCK_VIRTUAL: Clock = Clock { id: QEMUClockType::QEMU_CLOCK_VIRTUAL };
> // etc.
> 
> and then the user can do timer::CLOCK_VIRTUAL::get_ns().

More idiomatic, thank you! (I feel like I need to switch my mindset even
more from current C style.)

Regards,
Zhao


