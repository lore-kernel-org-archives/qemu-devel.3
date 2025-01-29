Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B7C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5mL-0002TV-8A; Wed, 29 Jan 2025 05:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5mJ-0002TK-VT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5mH-0001Qd-UM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738148317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zYyFaiw5RYqEPTsuc0zEVoccThPEdlpcW/A8Wdk4WxM=;
 b=JyZ+oAYMzwXbPaaXRD348HW0ZNZSlSqePZXXJa8B2x5JP1+xFdHYPBMRpR8VaC2xshINS7
 YGi4VgiiiZbohV5GUy+HRdHhCXFXbpC/nTiKydh3iBj4bqiyZXbH4GFAXp+N6+w0F1cKea
 kCr9B9OUsAm6Ue5KNtd4IwjrFe7ID1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-MK1vdiT7Mti00-2hmA6GKA-1; Wed, 29 Jan 2025 05:58:35 -0500
X-MC-Unique: MK1vdiT7Mti00-2hmA6GKA-1
X-Mimecast-MFC-AGG-ID: MK1vdiT7Mti00-2hmA6GKA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso36132475e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738148314; x=1738753114;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYyFaiw5RYqEPTsuc0zEVoccThPEdlpcW/A8Wdk4WxM=;
 b=fxD9lobIYbn/IjxVFswJFDehshnxjrea/wGOQs/6pwr7A1qoyJKLmB0u7uduOZJlAS
 blCkZZDnRQtBktr+xxjNe9UMEBCsEGFnRrBx3KacNFAq0i7RLJOgkWHkA/h5xYQjyCqq
 fXnBudUmqxkTEIUbRwsAy/QPe5RE4Fj9WqOYLgyrkKMVtHsOU7BSNgkVQvj8nr4svnEf
 GhKVnq73/zU61a30Gb6GNpt1l/GTWvZqN5gS7/BKlqgvLHVM5PGKpUmrS1mwYZKu12Pp
 cR0bP7FNJw3yFPzI0BEQHFHeTRy3d8otxAFgSdTpua+zvZtu/EQHPamWn0zNYWQzbQ3N
 msNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk+4OCihrGlasPLbg19bbbUpoDBShiDLJku3lNvlTXTOP7/PmPUbRP6l9v8c9cIsOYLa0T3c5FFm64@nongnu.org
X-Gm-Message-State: AOJu0Yyg/HWLZFSLeh6CLCXwXEerPrXCjDn6do91U1vrz/OENcgyZ+tJ
 ePyrwgjKC5Oq7pXTzYm2llIHMFRld3RuakavcfrywTRJVh2hESzg5wIlrd5iVHdqTK4l9LwupPB
 QVw0xQBzZHajg6S3c/BDBZ3yfpvmTnV+j3bOH5CVmk454aZJny8mL
X-Gm-Gg: ASbGncts36fbzquNMX4Ms9JvsOZ6z3ewScCT9nTuDWUjeMAPnfIatB1WaoCVNc7AxQ0
 S+YlSlgi6rhJj9MF0KAPEC+ARd4ANKNI60pu6Lijf7BwtAi+ULXS3Mvn+okNeAOxnqWbri+TcqX
 KieksJqDlouj3bhzLaPPzF3a3Fl5azExe3ni+h+3qyyaLNjhh6Es37nHibQX+ffoNaKrV+rH1hl
 GEBfHLZVy4pWNsJBxjI/1eyN7t8aCAgKfaXtLG9gy8SRPSw2gmF+uPZRMaPfUGqzsd6XSh0wuJe
 me46Pg==
X-Received: by 2002:a5d:6d88:0:b0:38a:4b8b:c57a with SMTP id
 ffacd0b85a97d-38c5209351bmr2871669f8f.44.1738148314205; 
 Wed, 29 Jan 2025 02:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF19I6ObrUzo4ap8AX8sAx9fzxfkxp24VTBV2ROz4h+yVI4C1tNhQfZWbIjOUe6Sr4LM8EeSg==
X-Received: by 2002:a5d:6d88:0:b0:38a:4b8b:c57a with SMTP id
 ffacd0b85a97d-38c5209351bmr2871632f8f.44.1738148313777; 
 Wed, 29 Jan 2025 02:58:33 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176519sm16468875f8f.2.2025.01.29.02.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 02:58:33 -0800 (PST)
Message-ID: <a30bfa1c-ddb8-4a5b-9f95-7b000c11cd54@redhat.com>
Date: Wed, 29 Jan 2025 11:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/10] rust: add bindings for timer
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-7-zhao1.liu@intel.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250125125137.1223277-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> +  c_nocopy = [
> +    'QEMUTimer',
> +  ]
> +  # Used to customize Drop trait
> +  foreach struct : c_nocopy
> +    bindgen_args += ['--no-copy', struct]
> +  endforeach

Nice.

> +pub use bindings::QEMUTimer;
> +
> +use crate::{
> +    bindings::{
> +        self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
> +        QEMUTimerListGroup,
> +    },
> +    callbacks::FnCall,
> +};
> +
> +impl QEMUTimer {
> +    pub fn new() -> Self {
> +        Default::default()
> +    }
> +
> +    pub fn timer_init_full<'timer, 'opaque: 'timer, T, F>(

General question - should the names:

- include the "timer" part, matching QEMU C code, or exclude it to avoid 
repetition? I would say remove it, but I'm open to suggestions and other 
opinions

- include the "QEMU" part? I'd say remove it, similar to ClockType below 
that is:

-pub use bindings::QEMUTimer;
+pub use bindings::QEMUTimer as Timer;
+pub use bindings::QEMUTimerList as TimerList;
+pub use bindings::QEMUTimerListGroup as TimerListGroup;

> +        &'timer mut self,
> +        timer_list_group: Option<&QEMUTimerListGroup>,
> +        clk_type: QEMUClockType,

Please take a ClockType instead.

> +        scale: u32,
> +        attributes: u32,
> +        _f: F,
> +        opaque: &'opaque T,
> +    ) where
> +        F: for<'a> FnCall<(&'a T,)>,
> +    {
> +        /// timer expiration callback
> +        unsafe extern "C" fn rust_timer_handler<T, F: for<'a> FnCall<(&'a T,)>>(
> +            opaque: *mut c_void,
> +        ) {
> +            // SAFETY: the opaque was passed as a reference to `T`.
> +            F::call((unsafe { &*(opaque.cast::<T>()) },))
> +        }

Please add "let _: () = F::ASSERT_IS_SOME;", which is added by the 
qdev_init_clock_in() patch.

> +        let timer_cb: unsafe extern "C" fn(*mut c_void) = rust_timer_handler::<T, F>;
> +
> +        // SAFETY: the opaque outlives the timer
> +        unsafe {
> +            timer_init_full(
> +                self,
> +                if let Some(g) = timer_list_group {
> +                    g as *const QEMUTimerListGroup as *mut QEMUTimerListGroup
> +                } else {
> +                    ::core::ptr::null_mut()
> +                },
> +                clk_type,
> +                scale as c_int,
> +                attributes as c_int,
> +                Some(timer_cb),
> +                (opaque as *const T).cast::<c_void>() as *mut c_void,
> +            )
> +        }
> +    }
> +
> +    pub fn timer_mod(&mut self, expire_time: u64) {
> +        unsafe { timer_mod(self as *mut QEMUTimer, expire_time as i64) }
> +    }

This can take &self, because timers are thread-safe:

     pub fn timer_mod(&self, expire_time: u64) {
         unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
     }

     const fn as_mut_ptr(&self) -> *mut Self {
         self as *const QEMUTimer as *mut _
     }

> +}
> +
> +impl Drop for QEMUTimer {
> +    fn drop(&mut self) {
> +        unsafe { timer_del(self as *mut QEMUTimer) }
> +    }

timer_del() can be useful even outside Drop, so

     pub fn timer_del(&self) {
         unsafe { timer_del(self.as_mut_ptr()) }
     }

and just use self.timer_del() here.

> +}
> +
> +pub fn qemu_clock_get_virtual_ns() -> u64 {
> +    // SAFETY:
> +    // Valid parameter.
> +    (unsafe { qemu_clock_get_ns(QEMUClockType::QEMU_CLOCK_VIRTUAL) }) as u64
> +}

Not needed.

> +pub struct ClockType {
> +    pub id: QEMUClockType,
> +}

The field does not have to be "pub" (maybe "pub(self)", I'm not sure 
offhand).

Paolo

> +impl ClockType {
> +    pub fn get_ns(&self) -> u64 {
> +        // SAFETY: cannot be created outside this module, therefore id
> +        // is valid
> +        (unsafe { qemu_clock_get_ns(self.id) }) as u64
> +    }
> +}
> +
> +pub const CLOCK_VIRTUAL: ClockType = ClockType {
> +    id: QEMUClockType::QEMU_CLOCK_VIRTUAL,
> +};
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> index 54839ce0f510..a35bfbd1760d 100644
> --- a/rust/wrapper.h
> +++ b/rust/wrapper.h
> @@ -63,3 +63,4 @@ typedef enum memory_order {
>  #include "migration/vmstate.h"
>  #include "chardev/char-serial.h"
>  #include "exec/memattrs.h"
> +#include "qemu/timer.h"
> --
> 2.34.1
>


