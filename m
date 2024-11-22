Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8453FE65D34
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 08:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEP1Z-0001bA-I5; Fri, 22 Nov 2024 03:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEP1X-0001au-QF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:28:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEP1W-0000e3-23
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:28:19 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3823194a879so1258186f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 00:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732264096; x=1732868896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I44exm/KAdLBmQ8me8mXE3lF0QVR1MNMb5Ta44lrJzs=;
 b=CPQZNMxpN+RWwua+2tDjnVVASx0A8WRPDGVM1nqR/jUmdPHLC7D6rvWSAfod1mDR0G
 Vyudv6BiftTsdGnDCto1RIUYA6HUPJVUD23YlIRjvrq5Zn1LBZiLkq3edDOYK9P4JM9x
 wLJ7FU0qTvN5ooz0gueXj9cf2pm+vz8ZTsICif/F+G7M1pPswGWvbeVrrrC2s/EjKCCu
 I8X73KS6CTpGP2OJVgbtC45344LNCmyv3J8KCXUzAvmLpSqdvttB2BE3TLErujhyQOz5
 d2Ogy9COU1MM5kblQN2gURvzEZ2x4lRIo58u8QxSsBVk9I17Inewh+tPNCbN1xhTr0eM
 fW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732264096; x=1732868896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I44exm/KAdLBmQ8me8mXE3lF0QVR1MNMb5Ta44lrJzs=;
 b=WoTAzac8wFXClGqapUCDbidHxBOwM5wuSOzIQvq9WBuvu6nMPy8eSplwkqU6KLIYBX
 o/aqVg61OwPTw8VdisP6NqrQ3IIRcqTfSXz/JDiG80MmxK1+20+2OXNE4+mYwU5LnrDl
 R6xisynFtc21cC+VLI3moRyjMhE9dwwS2Q60LJkszLg0ET4YLqd1kAGFAMO7QJgXZwkP
 pxfjaWFxxNvFoSRLYWUlpnen0stbsaYTIEsxPYIYMytChmiUS3wecjFrOwB13JNpIwra
 TEUw9Eiy1fOfzwIg80nd6LOPukIlbt4JJhMnuTAcp4Kh0qbxHG3NvfhARQgzp+NmvD8b
 1rVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJQ6rjY5pC7/TF3fayWI8y6kZ/TucI1vsBkTeJ9dSQr+wiI3suA7I7K3iW5XeLUb4T+iGZGTq764wM@nongnu.org
X-Gm-Message-State: AOJu0YwSkRgfVLJ99KVq/7VlHVOFY1llxgQ7GbUqZb54AGKf3TJ2WadR
 P8uqwvl06J3VFlSWKMOs6lV6cAhG4ZtlWCGuy086YJvT5l/lbwkKZUj9f/tMiNY=
X-Gm-Gg: ASbGncs8fM9GKGz2It0XK3P0lQfkCGOlelzkQ6WZ4xb46odERq0mEwM8N5CKH6ffv1F
 4JQAxI+gvmhL8osBYX4qKZzr/q1gJC6ufrlGfoh2lED4pmtQAQP3MMXVRxcXZnQyStmnMIx+QtZ
 HokfVyap8hglOkW52Uid9t4A3hDEQzsg6OV46/mFhKnKO4E5zKjSKF5MBGNg1g3Q2p709XhbhYB
 e/vLavd4eN8mpAfpNOUiJOQKyUvCdWeFUyBkSC1SZhGcM0z1sWZEgPTDqcj/rQyl3Bv
X-Google-Smtp-Source: AGHT+IFk0+Nh40l9UOw67AEzyalytC9wmuJHMYjhKdi+5Ps7W+wOr+kGiGWl80b1ycR2xfnsoY0brw==
X-Received: by 2002:a05:6000:2d06:b0:382:4b83:d4c0 with SMTP id
 ffacd0b85a97d-38260b486f8mr1225385f8f.3.1732264096005; 
 Fri, 22 Nov 2024 00:28:16 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9f59sm1739701f8f.34.2024.11.22.00.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 00:28:15 -0800 (PST)
Message-ID: <70f44731-6879-4adf-a71b-a781af48fe99@linaro.org>
Date: Fri, 22 Nov 2024 09:28:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: add bindings for interrupt sources
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: junjie.mao@hotmail.com, zhao1.liu@intel.com, qemu-rust@nongnu.org
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241122074756.282142-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Paolo,

On 22/11/24 08:47, Paolo Bonzini wrote:
> The InterruptSource bindings let us call qemu_set_irq() and sysbus_init_irq()
> as safe code.
> 
> Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
> They are QOM link properties and can be written to outside the control
> of the device (i.e. from a shared reference); therefore they must be
> interior-mutable in Rust.  Since thread-safety is provided by the BQL,
> what we want here is the newly-introduced BqlCell.  A pointer to the
> contents of the BqlCell (an IRQState**, or equivalently qemu_irq*)
> is then passed to the C sysbus_init_irq function.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 22 ++++++-----
>   rust/qemu-api/meson.build        |  2 +
>   rust/qemu-api/src/irq.rs         | 66 ++++++++++++++++++++++++++++++++
>   rust/qemu-api/src/lib.rs         |  2 +
>   rust/qemu-api/src/sysbus.rs      | 26 +++++++++++++
>   5 files changed, 108 insertions(+), 10 deletions(-)
>   create mode 100644 rust/qemu-api/src/irq.rs
>   create mode 100644 rust/qemu-api/src/sysbus.rs


> diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
> new file mode 100644
> index 00000000000..7dbff007995
> --- /dev/null
> +++ b/rust/qemu-api/src/irq.rs
> @@ -0,0 +1,66 @@
> +// Copyright 2024 Red Hat, Inc.
> +// Author(s): Paolo Bonzini <pbonzini@redhat.com>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Bindings for interrupt sources
> +
> +use core::ptr;
> +
> +use crate::{
> +    bindings::{qemu_set_irq, IRQState},
> +    cell::BqlCell,
> +};
> +
> +/// Interrupt sources are used by devices to pass changes to a boolean value to
> +/// other devices (typically interrupt or GPIO controllers).  QEMU interrupt
> +/// sources are always active-high.

So 'always active-high' = true below? (Wondering about pulsation, if the
true -> false transition is always correct).

I understand polarity is not part of this interrupt description, so for
GPIO it has to be modelled elsewhere.

Note the C API allows using qemu_set_irq() for vectored interrupts,
which is why the prototype takes an integer argument and not a boolean.
Is this deliberate to restrict the Rust binding to boolean? (Maybe you
envision a VectoredInterruptSource implementation for that).

> +///
> +/// Interrupts are implemented as a pointer to the interrupt "sink", which has
> +/// type [`IRQState`].  A device exposes its source as a QOM link property using
> +/// a function such as
> +/// [`SysBusDevice::init_irq`](crate::sysbus::SysBusDevice::init_irq), and
> +/// initially leaves the pointer to a NULL value, representing an unconnected
> +/// interrupt. To connect it, whoever creates the device fills the pointer with
> +/// the sink's `IRQState *`, for example using `sysbus_connect_irq`.  Because
> +/// devices are generally shared objects, interrupt sources are an example of
> +/// the interior mutability pattern.
> +///
> +/// Interrupt sources can only be triggered under the Big QEMU Lock; they are
> +/// neither `Send` nor `Sync`.
> +#[derive(Debug)]
> +pub struct InterruptSource(BqlCell<*mut IRQState>);
> +
> +impl InterruptSource {
> +    /// Send a low (`false`) value to the interrupt sink.
> +    pub fn lower(&self) {
> +        self.set(false);
> +    }
> +
> +    /// Send a high-low pulse to the interrupt sink.
> +    pub fn pulse(&self) {
> +        self.set(true);
> +        self.set(false);
> +    }
> +
> +    /// Send a high (`true`) value to the interrupt sink.
> +    pub fn raise(&self) {
> +        self.set(true);
> +    }
> +
> +    /// Send `level` to the interrupt sink.
> +    pub fn set(&self, level: bool) {
> +        unsafe {
> +            qemu_set_irq(self.0.get(), level.into());
> +        }
> +    }
> +
> +    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
> +        self.0.as_ptr()
> +    }
> +}
> +
> +impl Default for InterruptSource {
> +    fn default() -> Self {
> +        InterruptSource(BqlCell::new(ptr::null_mut()))
> +    }
> +}


