Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18948E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 15:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXigC-0004pl-BS; Tue, 14 Jan 2025 10:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXig9-0004pY-Nz; Tue, 14 Jan 2025 10:18:06 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXig7-0001oe-AI; Tue, 14 Jan 2025 10:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736867884; x=1768403884;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=d/z2DwCxBGVBY51txIi6qB8VTsRbvxop0EHIbG+p9Z0=;
 b=ei+uodQPZyPq6ltN9tubMA9lm5Wcj6CIe7mmRHYc4mdF7d169XL1pvGM
 HM8b9ur0K0DkOM9tptQE30XAXw8JcbLkRXc0S4b7qqLP2yVTaFN6Mh+Ic
 J3ERLhkwg7XOPmmlAQKhKqIs3edk0HKlHKkd3MEw4ugjdc5kHEWnUa3Lg
 Mzn6YRF5j3wQQjQDo+g0C77wRHw7drSdDbUWEFVcIxEf7uIcWicbKyf/L
 SN/9z94hgzUffY4zYWnlUiu3i3DonkVqGCQywcrpQVpRm34mmGGhXu65E
 4CBgQNNx2CDLD2Jgc4jHUZFO89p/DNBLUfCpf4+JT0pY3SX5awF7kd/bp g==;
X-CSE-ConnectionGUID: rn9laQ2hS7aHDe1Tev8BvQ==
X-CSE-MsgGUID: zYy4WXdgSTizQ+S/tRYF/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41107874"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="41107874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 07:18:00 -0800
X-CSE-ConnectionGUID: UnywE3kPROC0+fc1oWvQXw==
X-CSE-MsgGUID: EAWxKbY5TAOBzMUJb6Evpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="135705024"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 Jan 2025 07:17:57 -0800
Date: Tue, 14 Jan 2025 23:36:48 +0800
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
Message-ID: <Z4aEkLhcGVbXX82O@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-8-zhao1.liu@intel.com>
 <9cb123e2-5237-46e7-b6fe-ce8f813cc43c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb123e2-5237-46e7-b6fe-ce8f813cc43c@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.794,
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

Hi Paolo,

Thanks for your FnCall and the guidance below...

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

...

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
>

...Now I have a draft for timer binding:

* timer binding:

impl QEMUTimer {
    pub fn new() -> Self {
        Zeroable::ZERO
    }

    pub fn timer_init_full<'a, 'b: 'a, T, F>(
        &'a mut self,
        timer_list_group: Option<&mut QEMUTimerListGroup>,
        clk_type: QEMUClockType,
        scale: u32,
        attributes: u32,
        _f: &F,
        opaque: &'b T,
    ) where
        F: for<'c> FnCall<(&'c T,)> + 'b,
    {
        let timer_cb: unsafe extern "C" fn(*mut c_void) = rust_timer_handler::<T, F>;

        // SAFETY: the opaque outlives the timer
        unsafe {
            timer_init_full(
                self,
                if let Some(g) = timer_list_group {
                    g
                } else {
                    ::core::ptr::null_mut()
                },
                clk_type,
                scale as c_int,
                attributes as c_int,
                Some(timer_cb),
                opaque as *const T as *const c_void as *mut c_void,
            )
        }
    }

    pub fn timer_mod(&mut self, expire_time: u64) {
        unsafe { timer_mod(self as *mut QEMUTimer, expire_time as i64) }
    }
}


* use of timer binding:

fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
    timer_cell.borrow_mut().callback()
}

impl HPETTimer {
    ...

    fn init_timer_with_state(&mut self) {
        let index = self.index;
        let cb = |cell: &BqlRefCell<HPETTimer>| {
            timer_handler(cell);
        };

        self.qemu_timer = Some(Box::new({
            let mut t = QEMUTimer::new();
            t.timer_init_full(
                None,
                CLOCK_VIRTUAL.id,
                SCALE_NS,
                0,
                &cb,
                &self.get_state().timer[index],
            );
            t
        }));
    }
    ...
}

---

Is this timer binding as you expected? Hope I am on the right track. :-)

Thanks,
Zhao



