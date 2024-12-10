Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEE0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 09:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKwZt-0004Bh-UI; Tue, 10 Dec 2024 04:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKwZq-0004As-Em
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:30:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKwZo-00082G-MF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733823038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bxvpAyoQv4maySOZlR3wvgmBty9+4wb1C2ofzAnPcYQ=;
 b=i4+SlyQJivkiGHcGeQF1PJLoFheUQWeUuo+4toEfiiXtckU2SEc+sQ1jQUqgOz/nERxFUj
 95AFoQRVmmAKRLHz0k8FqsnjfhbRRlOZgNj01CQZakZvHBAvzQ2AJDDkOiXGzdjPfdJzar
 ZNDMIyc+SB8++P/d9KacnBFqYy51XnI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-b7F8VkEhMW6I_YI_L9EP6w-1; Tue, 10 Dec 2024 04:30:36 -0500
X-MC-Unique: b7F8VkEhMW6I_YI_L9EP6w-1
X-Mimecast-MFC-AGG-ID: b7F8VkEhMW6I_YI_L9EP6w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434f1d39147so15219965e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 01:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733823035; x=1734427835;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bxvpAyoQv4maySOZlR3wvgmBty9+4wb1C2ofzAnPcYQ=;
 b=c2ek1hrqax/OOk94VXcZt6FeCJeKgsrvhRa+uwzzfgE6SlJjF93l/j0EzTAPZgjTPo
 feHr7Xo/cedBO97Rr0LGi7adjJSRcfSToeMVptqzRTJvveXxyJuNAzypuN3XW1Si5S/S
 KQhg+GIyY69lls/3n+e6SWmP9GkNHK6CddKr0XP75T7XHpZnU7UcUMQchPtQB3NMv98u
 E+h/u9OXuCabKTd0K2Gh6CaE96D+YS5UZqVTfbRNmEBJntwiu6NCgxTCb71aKIOj8dmq
 rs2D4DvVun/G8DOJ5arEyxfMsxTF3dUmnwBbXJESpxrOjNknT5n3Dzb/q+Sj2lK6lkF9
 cR6g==
X-Gm-Message-State: AOJu0YwRy7z1lrLZ36KF85aw2MUatlI6wKjcIQehKlQ3Bu1ik2tMMwpG
 i3NXy91oa+Iu5n/rjGLMG/U+KO0tOBJ6MFmyRtXpnMuJVKVhOtW8Y1yknrhJu1iuBwfASeppwtW
 KEphLc8zlaiLnVBmm4ssEnxYftNWFPFtXwM4/Edxone9/p+kE4wrt
X-Gm-Gg: ASbGncsImzLQ0M9UhmvtwjsBd3ws6PHxPhzDH6LwTcAvS3riAbKeAwRT14vK/T/ZLia
 4qtPMtaZY1Uv63+KPKQZOqHXzS7CLfc/T9fVgxHN0oYZaYvdVIOzHcCEmlAlV+Cn3UWc8Ou0EZv
 EcwCQ2PHmWPFfTpaJ7pvLCtDmOGzC/rBERhPJUHlK4v0eqgIdwI4erfEeBzRzgiqTwElYgC/192
 cCHQkGq2UgnVz+ntT4+WooLDIUpl7mIp37JgT2WU+j4BO1fqLRV78ZT0w==
X-Received: by 2002:a05:600c:1da7:b0:434:f871:1b97 with SMTP id
 5b1f17b1804b1-434fffca42dmr26993865e9.33.1733823035271; 
 Tue, 10 Dec 2024 01:30:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgJfNOP9n6oIx1oYznaiE6hYRWdFdgJdGHx54kswBcXbqdBZ6SAXqFViK7gmCESCzJ8PmQDw==
X-Received: by 2002:a05:600c:1da7:b0:434:f871:1b97 with SMTP id
 5b1f17b1804b1-434fffca42dmr26993665e9.33.1733823034924; 
 Tue, 10 Dec 2024 01:30:34 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3861fc514fcsm15581973f8f.48.2024.12.10.01.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 01:30:34 -0800 (PST)
Message-ID: <4ced3c93-32de-4c81-b19c-947c27c4ec50@redhat.com>
Date: Tue, 10 Dec 2024 10:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/26] rust: add a bit operation module
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-7-pbonzini@redhat.com> <Z1f4IN3mfYB/jq8G@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z1f4IN3mfYB/jq8G@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/10/24 09:13, Zhao Liu wrote:
>> diff --git a/rust/qemu-api/src/bitops.rs b/rust/qemu-api/src/bitops.rs
>> new file mode 100644
>> index 00000000000..5acd6642d1a
>> --- /dev/null
>> +++ b/rust/qemu-api/src/bitops.rs
>> @@ -0,0 +1,119 @@
>> +// Copyright (C) 2024 Intel Corporation.
>> +// Author(s): Zhao Liu <zhai1.liu@intel.com>
> 
> You deserve to be the author!

I'll add both of us.  At this stage even identifying a need is an 
important step.

>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +//! This module provides bit operation extensions to integer types.
>> +//! It is usually included via the `qemu_api` prelude.
>> +
>> +use std::ops::{
>> +    Add, AddAssign, BitAnd, BitAndAssign, BitOr, BitOrAssign, BitXor, BitXorAssign, Div, DivAssign,
>> +    Mul, MulAssign, Not, Rem, RemAssign, Shl, ShlAssign, Shr, ShrAssign,
>> +};
>> +
>> +/// Trait for extensions to integer types
>> +pub trait IntegerExt:
>> +    Add<Self, Output = Self> + AddAssign<Self> +
>> +    BitAnd<Self, Output = Self> + BitAndAssign<Self> +
>> +    BitOr<Self, Output = Self> + BitOrAssign<Self> +
>> +    BitXor<Self, Output = Self> + BitXorAssign<Self> +
>> +    Copy +
>> +    Div<Self, Output = Self> + DivAssign<Self> +
>> +    Eq +
>> +    Mul<Self, Output = Self> + MulAssign<Self> +
>> +    Not<Output = Self> + Ord + PartialOrd +
>> +    Rem<Self, Output = Self> + RemAssign<Self> +
>> +    Shl<Self, Output = Self> + ShlAssign<Self> +
>> +    Shl<u32, Output = Self> + ShlAssign<u32> + // add more as needed
> 
> Ah, I used to define shift bits as usize. I can change the bit shift
> type back to u32 in HPET.

I used u32 because BITS is u32 in the standard library, so probably 
better to change it in HPET.

>> +    Shr<Self, Output = Self> + ShrAssign<Self> +
>> +    Shr<u32, Output = Self> + ShrAssign<u32> // add more as needed
>> +{
>> +    const BITS: u32;
>> +    const MAX: Self;
>> +    const MIN: Self;
>> +    const ONE: Self;
>> +    const ZERO: Self;
>> +
>> +    #[inline]
>> +    #[must_use]
>> +    fn bit(start: u32) -> Self
>> +    {
>> +        assert!(start <= Self::BITS);
>> +
>> +        Self::ONE << start
>> +    }
> 
> I think with this helper, I can add activating_bit() and deactivating_bit()
> bindings, as they are also commonly used operations.
> 
> I will rename them to activate_bit and deactivate_bit, if no one has any
> objections.

I think "-ing" is correct because it looks at a change between two 
values.  Or another possibility is putting the mask as "self":

     fn bits_activated(from: Self, to: Self) -> bool {
         (to & !from & self) != 0
     }

     fn bits_deactivated(from: Self, to: Self) -> bool {
         (from & !to & self) != 0
     }

Anyhow feel free to pick something you like and add it to IntegerExt.

>> +    #[inline]
>> +    #[must_use]
>> +    fn deposit<U: IntegerExt>(self, start: u32, length: u32,
>> +                          fieldval: U) -> Self
>> +        where Self: From<U>
>> +    {
>> +        debug_assert!(length <= U::BITS);
> 
> assert? as you've already replaced debug_assert with assert in BqlCell.

No, not this time :) Rust has checks for overflow in debug mode but not 
in release mode, so (independent of how Meson handles debug assertions) 
debug_assert is the right one here.

Paolo

>> +        let mask = Self::mask(start, length);
>> +        (self & !mask) | ((Self::from(fieldval) << start) & mask)
>> +    }
>> +
> 
> Very useful for HPET! Thanks.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 
> 


