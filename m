Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAC4E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJINS-0002cV-8R; Thu, 05 Dec 2024 15:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJINQ-0002cH-DH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJINN-0001SK-Vm
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733430184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ErVoJSJCg6U/xIq6GjUkreaBbIHsp7ZEDNpvCy8GArc=;
 b=RaYx7szr+E1MUKGsTScfoTbaaBGDNR5L8vsqGNp61Vs8JGgaZe5boGKVOFGyiLyRo5VKWi
 saAMcLFXtGTFpZKBAu3v+V/FTKjLFChBMHYHJaypleMmvF+sPCOnQW2Jw7i1Yp4KM7aWD4
 HNcdRfzzNpkl8jJM1hhbFscWJFH68mU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-wyMKaIF8NJW9cpNO6XY-Iw-1; Thu, 05 Dec 2024 15:23:02 -0500
X-MC-Unique: wyMKaIF8NJW9cpNO6XY-Iw-1
X-Mimecast-MFC-AGG-ID: wyMKaIF8NJW9cpNO6XY-Iw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d89309de06so23337576d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430182; x=1734034982;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErVoJSJCg6U/xIq6GjUkreaBbIHsp7ZEDNpvCy8GArc=;
 b=talLVnHjId83SYuLRzNaa0I4NMUkfrs1FJ9lvEZCT++NU2NoEQqn3Lp3qOK9RmGXAK
 nFgApnSb/HcFecG987k2/gUUDILAfiEyWpgnwPKOSzBaL+GAsiQ6ccfDHeuVA7oNIF9M
 aAR6YboFhZKhxHFYVNt/o0uv7QJRo1qub4XKnOOi+m87UiryKKA0kJAgStzjy/dbNHd4
 8zurBCzd4dJ9jIfMklLtoZmHazISrKNqpXHwTmZPQa4cwkEVjS0mobGt5nxYUVQcgFYs
 6wMBgA9LP5lpBDXquoiqK1H1g5NXBwJLuJRf/p517WEFnFu6Ui2FRNaMRh+OCDYO+cMx
 lKxQ==
X-Gm-Message-State: AOJu0Yw+TTPpzs72exlwcV7y36CEHHjy2zFZJBj0l64kYGMWsbI+UVLK
 MLVStzWYETeakFQ2vrzrVqxBdC6KtIhINJffNi/NqrXnAqkHUKuVexZRE7sfrXZBPgBHq/m24Bx
 BYW+0Z3+CZutxdqC+picQf3WUzXWCtxDNC50ltSqAkaUrRbEKicdg
X-Gm-Gg: ASbGncsmC/oNto8oRvmfns4q7arpyZeQCFovB4kD92Lv6ex5Rjy6LnCZHOZbDwybI9C
 a36hdcN+EMRbA1e7FegwC5JjpZ3TPhQmV3TuWrDl4lsyDR8vvuffOSc68clz5xPcy+zm9clIxal
 mCnN8GsidbuSLKhehZS7XjUMtZM7Ah28W+q/+w3Q9URrPzKM3thddFll9nm9CxVv2SWfFIKlOQ0
 tKXWTJB48h1dlPdjSJwsggdJ/rIr/357nCUtAvGdqrOvTKmvcGsJhu0
X-Received: by 2002:a05:6214:1c4b:b0:6cb:edd7:ac32 with SMTP id
 6a1803df08f44-6d8e7118b40mr4515516d6.12.1733430181652; 
 Thu, 05 Dec 2024 12:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjqVedKC9En89e0cqU9JxXEOxMIx+Hxmcm2fR8G4y7CKZpObKDXqvuEnIL/WfcR03xRlfpJA==
X-Received: by 2002:a05:6214:1c4b:b0:6cb:edd7:ac32 with SMTP id
 6a1803df08f44-6d8e7118b40mr4515226d6.12.1733430181314; 
 Thu, 05 Dec 2024 12:23:01 -0800 (PST)
Received: from [10.195.154.128] ([144.121.20.163])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6d8e3c1bd72sm4465706d6.121.2024.12.05.12.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 12:23:00 -0800 (PST)
Message-ID: <b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com>
Date: Thu, 5 Dec 2024 21:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 11/13] rust/timer/hpet: add basic HPET timer & state
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-12-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241205060714.256270-12-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/5/24 07:07, Zhao Liu wrote:
> Add the HPETTimer and HPETState (HPET timer block), along with their
> basic methods and register definitions.
> 
> This is in preparation for supporting the QAPI interfaces.
> 
> Note, wrap all items in HPETState that may be changed in the callback
> called by C code into the BqlCell/BqlRefCell.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   rust/hw/timer/hpet/src/hpet.rs | 638 +++++++++++++++++++++++++++++++++
>   rust/hw/timer/hpet/src/lib.rs  |   1 +
>   rust/wrapper.h                 |   1 +
>   3 files changed, 640 insertions(+)
>   create mode 100644 rust/hw/timer/hpet/src/hpet.rs
> 
> diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
> new file mode 100644
> index 000000000000..9550d8fe438a
> --- /dev/null
> +++ b/rust/hw/timer/hpet/src/hpet.rs
> @@ -0,0 +1,638 @@
> +// Copyright (C) 2024 Intel Corporation.
> +// Author(s): Zhao Liu <zhai1.liu@intel.com>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#![allow(dead_code)]
> +
> +use core::ptr::{null_mut, NonNull};
> +use std::os::raw::c_int;
> +
> +use qemu_api::{
> +    bindings::*,

Let's avoid bindings::*.

> +        self.qemu_timer = Box::new(HPETState::timer_new_ns(

Oh! I noticed now that while your API is called timer_new_ns, it is 
actually the same as timer_init_full.  Let's call it init_full() then.

> +    fn get_state_ref(&self) -> &HPETState {
> +        // SAFETY:
> +        // the pointer is convertible to a reference
> +        unsafe { self.state.unwrap().as_ref() }
> +    }
> +
> +    fn get_state_mut(&mut self) -> &mut HPETState {
> +        // SAFETY:
> +        // the pointer is convertible to a reference
> +        unsafe { self.state.unwrap().as_mut() }
> +    }

You should not need get_state_mut(), which also has the advantage of 
shortening get_state_ref() to get_state().

> +
> +    fn is_int_active(&self) -> bool {
> +        self.get_state_ref().int_status.get() & (1 << self.index) != 0
> +    }
> +
> +    fn is_fsb_route_enabled(&self) -> bool {
> +        self.config & 1 << HPET_TN_CFG_FSB_ENABLE_SHIFT != 0
> +    }
> +
> +    fn is_periodic(&self) -> bool {
> +        self.config & 1 << HPET_TN_CFG_PERIODIC_SHIFT != 0
> +    }
> +
> +    fn is_int_enabled(&self) -> bool {
> +        self.config & 1 << HPET_TN_CFG_INT_ENABLE_SHIFT != 0
> +    }
> +
> +    fn is_32bit_mod(&self) -> bool {
> +        self.config & 1 << HPET_TN_CFG_32BIT_SHIFT != 0
> +    }
> +
> +    fn is_valset_enabled(&self) -> bool {
> +        self.config & 1 << HPET_TN_CFG_SETVAL_SHIFT != 0
> +    }
> +
> +    fn clear_valset(&mut self) {
> +        self.config &= !(1 << HPET_TN_CFG_SETVAL_SHIFT);
> +    }
> +
> +    /// True if timer interrupt is level triggered; otherwise, edge triggered.
> +    fn is_int_level_triggered(&self) -> bool {
> +        self.config & 1 << HPET_TN_CFG_INT_TYPE_SHIFT != 0
> +    }

PL011 is using bilge here.  I think it's fair to show the two ways to do 
it.  If we have devices showing two different things:

- PL011 shows higher-level abstractions for registers

- HPET has a good approach to interior mutability from the beginning

Then it gives a clearer view of the options.


> +    fn update_int_status(&mut self, set: bool) -> &mut Self {
> +        let mask: u64 = 1 << self.index;
> +
> +        if set && self.is_int_level_triggered() {
> +            // If Timer N Interrupt Enable bit is 0, "the timer will
> +            // still operate and generate appropriate status bits, but
> +            // will not cause an interrupt"
> +            *self.get_state_mut().int_status.get_mut() |= mask;
> +        } else {
> +            *self.get_state_mut().int_status.get_mut() &= !mask;
> +        }
> +        self
> +    }

See remarks elsewhere on update_int_status(), and how it uses 
get_state_mut() and get_mut().

> +                unsafe {
> +                    address_space_stl_le(
> +                        &mut address_space_memory,
> +                        self.fsb >> 32,  // Timer N FSB int addr
> +                        self.fsb as u32, // Timer N FSB int value, truncate!
> +                        *MEMTXATTRS_UNSPECIFIED,
> +                        null_mut(),
> +                    );
> +                }

This is the only use of unsafe, whic is not bad at all.  Not urgent, but 
we should think about the AddressSpace bindings, and whether it makes 
sense to use (or steal APIs from) rust-vmm's vm-memory.

> +    fn arm_timer(&mut self, tick: u64) {
> +        let mut ns = self.get_state_ref().get_ns(tick);
> +
> +        // Clamp period to reasonable min value (1 us)
> +        if self.is_periodic() && ns - self.last < 1000 {
> +            ns = self.last + 1000;
> +        }
> +
> +        self.last = ns;
> +        self.qemu_timer.as_mut().timer_mod(self.last);
> +    }

No as_mut(), timer_mod is thread safe.  timer_mod() need to take &self.

> +    fn del_timer(&mut self) {
> +        self.qemu_timer.as_mut().timer_del();

Same as above.

> +#[derive(Debug)]
> +pub struct HPETTimerInstance(BqlRefCell<HPETTimer>);
> +
> +impl HPETTimerInstance {
> +    fn timer_handler(timer: &mut HPETTimerInstance) {
> +        timer.0.borrow_mut().callback()
> +    }
> +}

Also not "&mut" - you don't need it, as "timer.0" is only used to borrow 
from the BqlRefCell.  Also with a more refined timer abstraction this 
doesn't need HPETTimerInstance, it can probably be a global function like

fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
     timer_cell.borrow_mut().callback()
}

> +    /// General Capabilities and ID Register
> +    capability: BqlCell<u64>,
> +    ///  General Configuration Register
> +    config: BqlCell<u64>,
> +    /// General Interrupt Status Register
> +    int_status: BqlCell<u64>,
> +    /// Main Counter Value Register
> +    counter: BqlCell<u64>,
> +
> +    /// Internal state
> +
> +    /// Capabilities that QEMU HPET supports.
> +    /// bit 0: MSI (or FSB) support.
> +    pub(crate) flags: BqlCell<u32>,

flags doesn't need to be a cell (it's just a property).  I'll send a 
patch for the C code.

> +    /// Offset of main counter relative to qemu clock.
> +    hpet_offset: BqlCell<u64>,
> +    pub(crate) hpet_offset_saved: bool,
> +
> +    irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
> +    rtc_irq_level: BqlCell<u8>,
> +    pit_enabled: InterruptSource,
> +
> +    /// Interrupt Routing Capability.
> +    /// This field indicates to which interrupts in the I/O (x) APIC
> +    /// the timers' interrupt can be routed, and is encoded in the
> +    /// bits 32:64 of timer N's config register:
> +    pub(crate) int_route_cap: u32,
> +
> +    /// HPET timer array managed by this timer block.
> +    timer: [HPETTimerInstance; HPET_MAX_TIMERS],
> +    pub(crate) num_timers: BqlCell<usize>,

Ah, this needs to be a BqlCell because it can be clamped to 
MIN_TIMERS..MAX_TIMERS by realize.  Fair enough.

> +    /// Instance id (HPET timer block ID).
> +    hpet_id: BqlCell<usize>,
> +}
> +
Like flags this does not need to be a cell.

Paolo


