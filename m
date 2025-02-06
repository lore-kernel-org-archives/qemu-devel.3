Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB74BC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxQt-0005Yt-NS; Thu, 06 Feb 2025 03:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxQb-0005RP-2K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:40:05 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxQY-0006qp-AI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:40:04 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38da940e689so250664f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 00:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738831199; x=1739435999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RRBCmpXi86GF5fl4sYooUTspcXzwih+sD5Ce9BzWcZA=;
 b=pxVUczfV9W5kobxoU7Dntg64s26xe+NAtPYIaN0LNH23+BWX4yvxUnbq+7fNqJdTZR
 L5Hu6TKRxaTFi/rT/lW7u+CH8uuwBjqpFZIrIkphC/vYE9Vt4Eb5qPlocSb2I4lA8GUV
 KdoZp3Rh3SW87h3MRfFktTA/rFjoXEXEc9EqG9xh8vzGGeLgjo7vlVZfODEXRWKa81z0
 LQZEq9P7eWAntb4nqFRHWjNVUgV0/H96UCzSGwZKOOutd1U1E/7ZEvK8Oss4aY+ucBXy
 e0N59Cpz0OBhGwfClESq8xwfciz2Ys1Leza9JiKL2qkN4bid9N/5s3mYh2Faz3TQLSdn
 b7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738831199; x=1739435999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RRBCmpXi86GF5fl4sYooUTspcXzwih+sD5Ce9BzWcZA=;
 b=iJofUl3BRT8YNcVlQ1S0JNXL1as7lrOXHMRERDZUzPinBfZY36NzpeZeM4Bu4YIcnd
 m1ev2lIvLD3r2bFnH8FReXdqCTUsV4Lvi80+zj68YtstQLnxhd+A9P1+yHqhWKMQL+am
 ZkXtSqUNAgTEQ0RyPwdyul8XoclFKTEj5HUlpPcEf9vlY1JQg86MjgGGfWjC26GKrxFZ
 sHzmvHkpkme3G3rIjp2zqtg7xQkrUWNUJnBoluuprTTxqcw5iPz4pcbI1sAfP85/1ZSh
 5JUfuzc4sReUPVQhreoEpPb26+wyPbiI7UJngjDNuN+bNLLEtyIhEUXB8qNUPt+L1xSX
 vvmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTbXJz0IEpnlMopjm3yqEbZKZwyz4+Dyw0Jqde9L8HF6EuxqVRALkltgddjaLcf0030RPkhsrzk2Pi@nongnu.org
X-Gm-Message-State: AOJu0YxJa8mKpYCvdbfaqnPTglFxQs6KCePXB6awD/VAm6D/OZGFKBb+
 lMTi7maS7WDyy2roHEySiwvZHEeK/vfhciBf8mEQ9IfHRqVXQRnoVT5kA5rA3dtc49EpU6CSMZ9
 a/3w=
X-Gm-Gg: ASbGncthpEkja/+cbR7wmemrCR66xmpf85FzbUMGo58SU+miai0Wwo7pwIdFdQ3+KiY
 MdsTOVhxPDBhTlVkXQ/TXmgo4ZP6vvvSn9+enOiD7cdNt2BSyCTNBcpFzAhIGEjNdxzkoCJdcL0
 v2V172Xivg4pQTKr0LzYOXonjjCbiveM8XMLRTZ2Dt8XfGpy/boE7vRUs+DhGWm33mrCsUOEzyf
 mItn8hqzJyeGPB1Fs8a2iYrbYUIfPUA56uf+mEy4ayuy3AuI2G2x5H3YqUs4wf5i2V9s5ZmUtS4
 ae8zwInwJlRJfW9xNR4JAYA+IMdvwdBTte1ELpmi10Cb+iTkqxtfrswpe1o=
X-Google-Smtp-Source: AGHT+IHou+ssgCD7cHcPG4ExQ3JCnYX8LGVk+AR5k7qkQMftTDZDlOg1us89AHGKgsacb/rIsCNToQ==
X-Received: by 2002:a5d:5f93:0:b0:38d:a90c:d489 with SMTP id
 ffacd0b85a97d-38db491fd30mr4322471f8f.45.1738831199381; 
 Thu, 06 Feb 2025 00:39:59 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4480sm47486765e9.27.2025.02.06.00.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 00:39:58 -0800 (PST)
Message-ID: <7e35b5b6-01dd-457b-b36f-507a85300b45@linaro.org>
Date: Thu, 6 Feb 2025 09:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] rust: bindings for MemoryRegionOps
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-11-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117194003.1173231-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/1/25 20:40, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs     |  43 +++---
>   rust/hw/char/pl011/src/lib.rs        |   1 -
>   rust/hw/char/pl011/src/memory_ops.rs |  36 -----
>   rust/qemu-api/meson.build            |   1 +
>   rust/qemu-api/src/lib.rs             |   1 +
>   rust/qemu-api/src/memory.rs          | 191 +++++++++++++++++++++++++++
>   rust/qemu-api/src/sysbus.rs          |   7 +-
>   rust/qemu-api/src/zeroable.rs        |  12 ++
>   8 files changed, 234 insertions(+), 58 deletions(-)
>   delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>   create mode 100644 rust/qemu-api/src/memory.rs
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 259efacb046..294394c6e82 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -2,7 +2,7 @@
>   // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
> -use core::ptr::{addr_of_mut, NonNull};
> +use core::ptr::{addr_of, addr_of_mut, NonNull};
>   use std::{
>       ffi::CStr,
>       os::raw::{c_int, c_void},
> @@ -12,14 +12,14 @@
>       bindings::{self, *},
>       c_str, impl_vmstate_forward,
>       irq::InterruptSource,
> +    memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
>       prelude::*,
> -    qdev::{Clock, ClockEvent, DeviceImpl, ResettablePhasesImpl, ResetType},
> +    qdev::{Clock, ClockEvent, DeviceImpl, ResetType, ResettablePhasesImpl},
>       qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
>   };
>   
>   use crate::{
>       device_class,
> -    memory_ops::PL011_OPS,
>       registers::{self, Interrupt},
>       RegisterOffset,
>   };
> @@ -490,20 +490,24 @@ impl PL011State {
>       /// location/instance. All its fields are expected to hold unitialized
>       /// values with the sole exception of `parent_obj`.
>       unsafe fn init(&mut self) {
> +        static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
> +            .read(&PL011State::read)
> +            .write(&PL011State::write)
> +            .native_endian()

Could we always make .valid_sizes() explicit?

> +            .impl_sizes(4, 4)
> +            .build();
> +
>           // SAFETY:
>           //
>           // self and self.iomem are guaranteed to be valid at this point since callers
>           // must make sure the `self` reference is valid.
> -        unsafe {
> -            memory_region_init_io(
> -                addr_of_mut!(self.iomem),
> -                addr_of_mut!(*self).cast::<Object>(),
> -                &PL011_OPS,
> -                addr_of_mut!(*self).cast::<c_void>(),
> -                Self::TYPE_NAME.as_ptr(),
> -                0x1000,
> -            );
> -        }
> +        MemoryRegion::init_io(
> +            unsafe { &mut *addr_of_mut!(self.iomem) },
> +            addr_of_mut!(*self),
> +            &PL011_OPS,
> +            "pl011",
> +            0x1000,
> +        );


> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
> index 300c732ae1d..5622e974cbc 100644
> --- a/rust/hw/char/pl011/src/lib.rs
> +++ b/rust/hw/char/pl011/src/lib.rs
> @@ -29,7 +29,6 @@
>   
>   mod device;
>   mod device_class;
> -mod memory_ops;
>   
>   pub use device::pl011_create;
>   
> diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
> deleted file mode 100644
> index 95b4df794e4..00000000000
> --- a/rust/hw/char/pl011/src/memory_ops.rs
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -// Copyright 2024, Linaro Limited
> -// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -
> -use core::ptr::NonNull;
> -use std::os::raw::{c_uint, c_void};
> -
> -use qemu_api::{bindings::*, zeroable::Zeroable};
> -
> -use crate::device::PL011State;
> -
> -pub static PL011_OPS: MemoryRegionOps = MemoryRegionOps {
> -    read: Some(pl011_read),
> -    write: Some(pl011_write),
> -    read_with_attrs: None,
> -    write_with_attrs: None,
> -    endianness: device_endian::DEVICE_NATIVE_ENDIAN,
> -    valid: Zeroable::ZERO,
> -    impl_: MemoryRegionOps__bindgen_ty_2 {
> -        min_access_size: 4,
> -        max_access_size: 4,
> -        ..Zeroable::ZERO
> -    },
> -};


