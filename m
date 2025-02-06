Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5592C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyie-0004E8-Lg; Thu, 06 Feb 2025 05:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyic-0004Da-Ke
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:02:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyia-0006qY-PG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:02:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361f796586so7227235e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 02:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738836163; x=1739440963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yeaok4WWlYGNgKeHMkGKkK/9rdsvj/4UHjdGDu32Oy8=;
 b=cO/ncsmxaRlah9zFcRLG5VnkYET59yAvsO8Z4PwzUMKGB8TgDirzTUEC7c4AxDSnFT
 sMX8SAsE+clurduuuA+zmMYfwPz9hGLlHZRxrZ1ARvTYz+t9b1GhK7Q711QouzfumYhx
 XB0YFMDh/M6WfhDXoy2+v+N3ZRpsD/nmukQO0CDiXqWTtNzBBEiY/qpzCKdKiRXe+YgS
 nryphywXqvhgEFxfB0INqVfWo0Ou0pHFHJ757HDuC7XtYkpZFCjtKSH3u2GzQkbxC7dY
 dtjaH6H6ZDQG7YME5eYxAv0iRmul9QxiHHz2gUrT9thGj8aLXwzZrYbWq6jZ5cAyweUL
 Orzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738836163; x=1739440963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yeaok4WWlYGNgKeHMkGKkK/9rdsvj/4UHjdGDu32Oy8=;
 b=H3YXOvmIU/mj3SnfzUmI7H3bQL71PMBytNbH/Sq3BTtwo0bYbVm09hPK1XiP/DkLsd
 os6uPsxjOt3gQ7ylepO/1BCWT0Zv269HLGWHi2eAYoyVS5P7N2ivN6dGGGs9UGKHUXfS
 vBz+tNZwfN87infVlze6/Xu9QuUB7cHLaYufSxHPMfDSqMo5uZyo7OJ2BuCsSCpxNe5W
 NE/ivOi9xGCIOdYylrrCfjfcFVogLgIuCo3UFzWdgu7Kh9onAqrS7ZrypRbVeF32k1Yi
 T8yF82k/B9slz0JbLarlYx8lN0p4lHhdTIw8dXckKC4tY6lj23T0BHbms+GN8wQjmL8l
 y7sg==
X-Gm-Message-State: AOJu0YzscFYGiiUDvCQF/rU+pSiHyfRCj4PIXwiyrS6P9Mslz4yqSNqo
 ac6kL3jE3Uu4eCiGiAOnZwy9+jRRI1XsTL7mkSxucyUrytBNqEY2LcXIvJlV+gk=
X-Gm-Gg: ASbGnctbdVQp68h54o12C7Vy2pYguJcMhCtw7JCo3wUi9+MLbszgvj7eFocxQDFDIBK
 L622pOhH40jXkk2hYwb0xxfMsKWqyIynsVeCua2kahaVQFvdVtufURAuUiyUrPrn8lD6wQQ0A5i
 xXWxAvEsdtwoE7Ylv5IsS26RRdhCeMYzqNiy6Nc68EQUuFhZ2WCCT3X/4wDkbyWOO+f/NxqU9v6
 2aQuju8doxvJsPFlfVjjNLregY+ziYFv56r+kmTI3LfRtt4r901ZE1AKLZHlxDJZ1/MAjVncSm2
 k45RpcCUVXejzGZ+gKevvTp/Txo7ldtuVBahtt9ZFMkmqZaJIIGaRF8a/o8=
X-Google-Smtp-Source: AGHT+IG/gEHZ8REiLMok8ShQ3D84gz/1Ju0Z6FbD/3cJgyS2L4S9uHvQnQMCItnrNJmt1kfdcd+5ug==
X-Received: by 2002:a05:600c:4586:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-4390d43e90emr70963515e9.16.1738836162996; 
 Thu, 06 Feb 2025 02:02:42 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1de32sm1266558f8f.83.2025.02.06.02.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 02:02:42 -0800 (PST)
Message-ID: <ad5dcd1b-ae0e-42ac-befe-a33b3f900c71@linaro.org>
Date: Thu, 6 Feb 2025 11:02:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] rust: bindings for MemoryRegionOps
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-11-pbonzini@redhat.com>
 <7e35b5b6-01dd-457b-b36f-507a85300b45@linaro.org>
 <CABgObfbr4yHBJxCVtOk9rQau3Z8M-QUy0+OqTnjecTsKTXrH0Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbr4yHBJxCVtOk9rQau3Z8M-QUy0+OqTnjecTsKTXrH0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 6/2/25 09:46, Paolo Bonzini wrote:
> On Thu, Feb 6, 2025 at 9:40 AM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Paolo,
>>
>> On 17/1/25 20:40, Paolo Bonzini wrote:
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    rust/hw/char/pl011/src/device.rs     |  43 +++---
>>>    rust/hw/char/pl011/src/lib.rs        |   1 -
>>>    rust/hw/char/pl011/src/memory_ops.rs |  36 -----
>>>    rust/qemu-api/meson.build            |   1 +
>>>    rust/qemu-api/src/lib.rs             |   1 +
>>>    rust/qemu-api/src/memory.rs          | 191 +++++++++++++++++++++++++++
>>>    rust/qemu-api/src/sysbus.rs          |   7 +-
>>>    rust/qemu-api/src/zeroable.rs        |  12 ++
>>>    8 files changed, 234 insertions(+), 58 deletions(-)
>>>    delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>>>    create mode 100644 rust/qemu-api/src/memory.rs
>>>
>>> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
>>> index 259efacb046..294394c6e82 100644
>>> --- a/rust/hw/char/pl011/src/device.rs
>>> +++ b/rust/hw/char/pl011/src/device.rs
>>> @@ -2,7 +2,7 @@
>>>    // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>    // SPDX-License-Identifier: GPL-2.0-or-later
>>>
>>> -use core::ptr::{addr_of_mut, NonNull};
>>> +use core::ptr::{addr_of, addr_of_mut, NonNull};
>>>    use std::{
>>>        ffi::CStr,
>>>        os::raw::{c_int, c_void},
>>> @@ -12,14 +12,14 @@
>>>        bindings::{self, *},
>>>        c_str, impl_vmstate_forward,
>>>        irq::InterruptSource,
>>> +    memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
>>>        prelude::*,
>>> -    qdev::{Clock, ClockEvent, DeviceImpl, ResettablePhasesImpl, ResetType},
>>> +    qdev::{Clock, ClockEvent, DeviceImpl, ResetType, ResettablePhasesImpl},
>>>        qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
>>>    };
>>>
>>>    use crate::{
>>>        device_class,
>>> -    memory_ops::PL011_OPS,
>>>        registers::{self, Interrupt},
>>>        RegisterOffset,
>>>    };
>>> @@ -490,20 +490,24 @@ impl PL011State {
>>>        /// location/instance. All its fields are expected to hold unitialized
>>>        /// values with the sole exception of `parent_obj`.
>>>        unsafe fn init(&mut self) {
>>> +        static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
>>> +            .read(&PL011State::read)
>>> +            .write(&PL011State::write)
>>> +            .native_endian()
>>
>> Could we always make .valid_sizes() explicit?
> 
> Yes (for example build() could even fail to compile if you don't have
> impl_sizes/valid_sizes set), but why do you want that? I'm not even
> sure that all cases of .valid.max_access_size=4 are correct...

Exactly for that :) Not have implicit default values, so correct
values are reviewed when models are added.


