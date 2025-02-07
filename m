Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD26C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPm6-0004uv-N8; Fri, 07 Feb 2025 09:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgPm1-0004tN-46
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgPlx-0004rI-Vn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738940160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IgzIX2w+eeMvvxb9Co3aD1LBRfY1wQyT9xSooMJ5yRA=;
 b=GCRFijLNaoqyi2saCBRzKVA4crm2wRzdUXZePXV8m9wQGxGhqNW11vtiBfDf9TNlXfBt7B
 cJrGC4pYEGZLICjkxPDzK3LZnq0z6/eo85rONOMhzHGOI7mdpurmqoS6MqFkBbakg+kFF2
 M9FTI+Pv7xnei5S9VHdbonMTJHr81rM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Yhl9PX7DMqK_-NVxObBK1w-1; Fri, 07 Feb 2025 09:55:56 -0500
X-MC-Unique: Yhl9PX7DMqK_-NVxObBK1w-1
X-Mimecast-MFC-AGG-ID: Yhl9PX7DMqK_-NVxObBK1w
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab79858cd31so3037866b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 06:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738940155; x=1739544955;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IgzIX2w+eeMvvxb9Co3aD1LBRfY1wQyT9xSooMJ5yRA=;
 b=L6Mh97VTcA/RcIF4sBcOPWciG8d64budKQDdEiqdL/0Kp+YK+Aonw97tf/vCEwr8yb
 mxzS0YwW99V65k8Ex0XbiXxzXCwrrelo3w2VI/lb7p0TM9GZals3qyGHnvbbqxFmr9fG
 FjnhjR4o8GE0f4Lh5vmuOXSGXlJvBt85Zl9vLFtwv9cBlaI1l1JgRg6UqY7Aq7XYSn6E
 Xyf6uHmsaAp0rNLAiWf7KjL3ELHOv63ZbJf4xC68yto2TnU6woWL8CFREozJXRahMpjF
 IDFtQTt0ntf/UrIlxxbvads92iWZAQ6ffXIxWvg/3IvppoE3TwANb9yGuqIvHfQxqTwe
 UDgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT2yjIoC4ODQfV3AIQrK6Iv8WaPG5OBC9YSm5kGd17yKQrjPVKVYA5kMl3h6N0TyT6UDMxd19qsaVt@nongnu.org
X-Gm-Message-State: AOJu0YznMPHCZDwSQp8cIk92LJ73HTbGpPLm906xQzZN3UfLDL2g9P63
 5iNKUaohit9Fo1vpE8Ge3m5SChLM7uubV+pl7HdhpQwiOJIqHmdpsWTwiq/XKfNvob8mLFIeXeq
 u0Tz+8d0kVEaV/vPc054bcKgSNoTAnIFmoyUcxfNAKy0CqPPjQ/1V
X-Gm-Gg: ASbGnctRjn/PsOaj6AGkgGHqKabyFMkUtW7NLrPpENHmkwZGS0hjhQbjuxHlI/0Wjkz
 0E10Vv3Cy6ZZfOUVoxOit1M3hWDdscC+0RhSWGQMqNDlspgWajSpSHf7gMdcwl9xfvj8sdKPGVu
 qoCJGyvcJTcXUfimeuvtLjTAXhW5xxTXuUtJFbgMU3+4HCxAeV2HbV6aFWONSag5EHknXZYEyW8
 v0wK8rc3nER6LoW889AGSrZUUoV1lnqSfuOVwrsH78JhnWZ0FM98Gv06Wzj2pNCekFT6sL8pDNG
 C3uz4Q==
X-Received: by 2002:a17:907:2d9e:b0:aab:740f:e467 with SMTP id
 a640c23a62f3a-ab789a6b576mr317737066b.8.1738940154950; 
 Fri, 07 Feb 2025 06:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIoIFlcRFVayX5vYNC747k8ip7Y0QEl67zFHQRAlpYauaJEzbmZ/CVT2ciQYvJaM4js/RmOQ==
X-Received: by 2002:a17:907:2d9e:b0:aab:740f:e467 with SMTP id
 a640c23a62f3a-ab789a6b576mr317733866b.8.1738940154466; 
 Fri, 07 Feb 2025 06:55:54 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab772f843b4sm279190566b.42.2025.02.07.06.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 06:55:53 -0800 (PST)
Message-ID: <57c08026-81a2-4643-8c2a-bab1e3299432@redhat.com>
Date: Fri, 7 Feb 2025 15:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] rust: add bindings for timer
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-7-zhao1.liu@intel.com>
 <a30bfa1c-ddb8-4a5b-9f95-7b000c11cd54@redhat.com>
 <Z6YLwAqDGm+9aiaM@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z6YLwAqDGm+9aiaM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/25 14:33, Zhao Liu wrote:
>>> +pub use bindings::QEMUTimer;
>>> +
>>> +use crate::{
>>> +    bindings::{
>>> +        self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
>>> +        QEMUTimerListGroup,
>>> +    },
>>> +    callbacks::FnCall,
>>> +};
>>> +
>>> +impl QEMUTimer {
>>> +    pub fn new() -> Self {
>>> +        Default::default()
>>> +    }
>>> +
>>> +    pub fn timer_init_full<'timer, 'opaque: 'timer, T, F>(
>>
>> General question - should the names:
>>
>> - include the "timer" part, matching QEMU C code, or exclude it to avoid
>> repetition? I would say remove it,
> 
> I agree and I would name it "init()" instead of "init_full()".

Please keep init_full(); init() would be a version without some of the 
arguments (e.g. the TimerListGroup, or the attributes).

> I notice you've picked another way for IRQState, so I could follow that
> like:
> 
> pub type Timer = bindings::QEMUTimer;
> 
> This style make it easy to add doc (timer binding currently lacks
> doc, but I will add it as much as possible).

Good point.

> Another option may be to wrap QEMUTimer as what MemoryRegionOps did, but
> timer has only 1 callback so I think it's not necessary.

Yes, and we actually should do it sooner or later to add a PhantomPinned 
field, because timers can't move in memory!  But no need to do it now.

>>> +        scale: u32,

While at it, can you add constants for the scale, i.e.

     pub const NS: u32 = bindings::SCALE_NS;
     pub const US: u32 = bindings::SCALE_US;
     pub const MS: u32 = bindings::SCALE_MS;

? Using Timer::NS is clear enough and removes the need to import from 
"bindings".  At least in theory, bindings should not even have to be 
"pub" (or at least that's where the code should move towards).

>>> +    pub fn timer_mod(&mut self, expire_time: u64) {
>>> +        unsafe { timer_mod(self as *mut QEMUTimer, expire_time as i64) }
>>> +    }
>>
>> This can take &self, because timers are thread-safe:
>>
>>      pub fn timer_mod(&self, expire_time: u64) {
>>          unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
>>      }
> 
> timer_mod means "modify a timer", so I'd rename this method to "modify"

Yeah, changing mod/del to modify/delete is fine!

Paolo


