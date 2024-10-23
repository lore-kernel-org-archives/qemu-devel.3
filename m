Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B6CCDDE6E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ZSf-0005Dk-St; Wed, 23 Oct 2024 07:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3ZSW-0005DN-8o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3ZST-0001VY-MU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729682600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DOKosa6OrJwS7eDB+xkj3leGrSSZaQg+wsKSYyYLrmY=;
 b=VNbzwLwHEYMb2k8imHDpx9oA4g6kvX0js4EnKkWDegk5HN61KA/wyhELjhTmMvIckGNrqA
 SC5/CP6M0HZ2tmSjhXugtV/hAT0A5giUQPiPj0W1mUXKfIM/BUES7NUprkIeA2y6+dSzB5
 Y7KQ5w9Zx0+lV4k7vWk0pYcpQZaJALs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-JLRhNJ9APtCTUsFz_x8KpQ-1; Wed, 23 Oct 2024 07:23:18 -0400
X-MC-Unique: JLRhNJ9APtCTUsFz_x8KpQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so3278477f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729682597; x=1730287397;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DOKosa6OrJwS7eDB+xkj3leGrSSZaQg+wsKSYyYLrmY=;
 b=jQopR/Wd/2TdGSQyPnhjiahUF2c668j5EvtKYLnmDb5O7ciCy/Sd7o7vWf+6gwcuXQ
 3wnbufZA0gzXhILvkctun4zAy7n0/0zjKcPVgaY5DhmTSDl3izYHjmYmjFkT2W1uPLwh
 fsvAGi4dr1upxLt3iUmQzIXIK5vLuPM2qYeJE49wCKb1gwTEaDkAl8rYTBg+JBVhujHE
 d0BgfxLYujCEYb3UPVDpN/u1390lo1HwlQWQPyZ9P/6ubvaiBzJmweVeg/8Cvl/D15t7
 SdG2vphptUbMWLf27AKAlwyBNabAFtn04Tu+cTxkjbTM1PHZf4ymcp1LmVJWkpia15Qt
 FLZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHaavpETH87oL2EsLs+9CtiP6nZkaifNqwXOLB+sw2vEyeWz+JhUkZpy6PvWq/hXQeUmsGs1YvOk7m@nongnu.org
X-Gm-Message-State: AOJu0YydwWcphu+bs1i3SSjAifPeg51Ew0KNUkIGDzxoLrQ7Ny+lR20M
 JXWuI1E54rBE0y1NHjFMUemfw+QN2KHZrE/hAOk7veFOjHOu75dfxwAWwoO297qPcaYD5ydXe79
 DPX/0nd1GJK2CH4Ao4fqhzfKe7kWOdZ+RCt9V+B23gVLJbXHANOvApXUEosqVtq4=
X-Received: by 2002:a5d:69d0:0:b0:37d:43d2:d894 with SMTP id
 ffacd0b85a97d-37efcf77570mr1278438f8f.37.1729682597095; 
 Wed, 23 Oct 2024 04:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4h88QkylkF86bEYCMpeOAJ6B5O+IGDGnyGgb3MHMJE5kJxom7ohCuMd0LVGOG9Oofp/BWgQ==
X-Received: by 2002:a5d:69d0:0:b0:37d:43d2:d894 with SMTP id
 ffacd0b85a97d-37efcf77570mr1278423f8f.37.1729682596671; 
 Wed, 23 Oct 2024 04:23:16 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9413fsm8724357f8f.74.2024.10.23.04.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 04:23:16 -0700 (PDT)
Message-ID: <c9f8b621-bc68-44a9-b89a-fb2ebca6fb84@redhat.com>
Date: Wed, 23 Oct 2024 13:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] rust: clean up define_property macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-10-pbonzini@redhat.com>
 <lt261.tyno4xdeejj0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <lt261.tyno4xdeejj0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/23/24 12:38, Manos Pitsidianakis wrote:
> Hello Paolo,
> 
> On Mon, 21 Oct 2024 19:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Use the "struct update" syntax to initialize most of the fields to zero,
>> and simplify the handmade type-checking of $name.
> 
> Note: It wasn't meant for type checking but for making sure the linker
> doesn't strip the symbol (hence the #[used] attribute). These were left
> over when I was debugging linker issues and slapped #[used] everywhere
> but they are not needed in this case indeed.

Well, it does do type checking as well, :) otherwise you end up 
duck-typing on whether $name as as_ptr().  I guess you are okay with the 
change below and the comment:

>> -            name: {
>> -                #[used]
>> -                static _TEMP: &::core::ffi::CStr = $name;
>> -                _TEMP.as_ptr()
>> -            },
>> +            // use associated function syntax for type checking
>> +            name: ::core::ffi::CStr::as_ptr($name),

?

>>              info: $prop,
>>              offset: ::core::mem::offset_of!($state, $field)
>>                  .try_into()
>>                  .expect("Could not fit offset value to type"),
>> -            bitnr: 0,
>> -            bitmask: 0,
>>              set_default: true,
>>              defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
>> -            arrayoffset: 0,
>> -            arrayinfo: ::core::ptr::null(),
>> -            arrayfieldsize: 0,
>> -            link_type: ::core::ptr::null(),
>> +            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
> 
> Call it personal taste but I don't like emulating C's zero initializer
> syntax in Rust :) Is it that much trouble to explicitly write down every
> field in a macro, anyway? No strong preference here though.

Rust does make generous use of "..Default::default()", so I think it's 
more idiomatic to use the struct update syntax.  We just cannot use it 
here because it's not const-ified.

I'm okay with switching from Zeroable::ZERO to something like 
ConstDefault::CONST_DEFAULT; it's basically just a rename.  On the other 
hand you do rely on "zero-ness" in PL011State::init()... so I thought I 
was actually following your style. :)

Paolo


