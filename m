Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69286C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMP2g-0001ak-Lh; Wed, 26 Jun 2024 05:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMP2f-0001a9-68
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 05:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMP2d-0001xK-8B
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 05:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719394454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WGr0H6VEyjLW8BaocjywV1wFZaE1KvGK2dBci3Uq1jk=;
 b=IsOJ8zaSUXMHJpyl83KLykJXzilXqFJr07asCuIJ68HS3YfXeXjHQUSGQZcl44nGaEuBde
 iqWVH6hcchJ/7RgYpf8X/7bMHKpbEByvu6JpcVVRmcgtaley+e40zVhN7o+hlfQd2AB/Vx
 ALIKnWPWVl+SfrrU+od2jHTKnJVMf2Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-EW9uItuTP9aTGuhgrP1E1g-1; Wed, 26 Jun 2024 05:34:12 -0400
X-MC-Unique: EW9uItuTP9aTGuhgrP1E1g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d0f3455ceso1393547a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 02:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719394451; x=1719999251;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGr0H6VEyjLW8BaocjywV1wFZaE1KvGK2dBci3Uq1jk=;
 b=i6MOBLvulkW663x/hYHxBvjdSgRUUoNWHOHsUrj3XA5igdd5M7D2wbY/9z0/CevOUZ
 w5JbQwRUv5IvvCdqoWlNm1WYrq6M9URti8SnscPeloiJg1h/AjYQ3Vw5W3e5fuhQdz31
 aGMgIT9h8GMhB9RO9+4W1YdylmyGQ4SXtgUkpmZMfNJxVjjfv3moYpyp44G1JilVzCsl
 6tG8LwgNVxZt8mBd0bFy2wlw1I9LxnTw/qXZYm4yCNjySCO6G3YpZ2dnNVoJji742nGE
 pUUNPIQiB7KOQuVMUMmgBP67oTATGuDZRSJlwymF0zsaQm+S1D878xXeyZRjl9yVCTBX
 rm5w==
X-Gm-Message-State: AOJu0YwCCLK+vJgc0k3puiNJv12tYDuKYxqVjEicf+XsuptjegHi0dVG
 DMk+YudhYW1scIx0hqfYdW8BiEnKkzwMB/rlrqE7ZHYc6o2sbuSOLfmhBW+4XUPXIcyio+0rbvf
 8I/bCBfexSZUgCMl7izthBJjQUDAMCdIEYIN0teXlAFmq289XjKSX
X-Received: by 2002:a50:d79e:0:b0:57d:1696:fd14 with SMTP id
 4fb4d7f45d1cf-57d4bd59807mr8623415a12.8.1719394451360; 
 Wed, 26 Jun 2024 02:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRTGmZK4sBC86qkUV+s1dr+PrKf+Pi86ege6bA1WEefZMxkz0gzsfW5d1jt5z00ZMIwo/f7g==
X-Received: by 2002:a50:d79e:0:b0:57d:1696:fd14 with SMTP id
 4fb4d7f45d1cf-57d4bd59807mr8623389a12.8.1719394450934; 
 Wed, 26 Jun 2024 02:34:10 -0700 (PDT)
Received: from [192.168.10.47] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d033sm6991294a12.39.2024.06.26.02.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 02:34:10 -0700 (PDT)
Message-ID: <99c32ec8-f1c4-45f8-b19b-6487e1b6ec61@redhat.com>
Date: Wed, 26 Jun 2024 11:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnmkN2PL3r-2sxqe@redhat.com>
 <CABgObfbH4KpFv+eKr3BLpk0S9TOkQNiyQN5q6JAFGsMrWmSGnA@mail.gmail.com>
 <fnopq.orjfjqf36hxp@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <fnopq.orjfjqf36hxp@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/25/24 23:47, Manos Pitsidianakis wrote:
> On Mon, 24 Jun 2024 20:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Yes, I agree. However, considering we haven't even checked the situation
>> with what language features are required by any idiomatic bindings vs the
>> 1.63 version that we need to support for Debian, I think it's a bit
>> premature to make it mandatory.
>>
> 
> FWIW, I just ran
> 
> `cargo msrv -- cargo check --target x86_64-unknown-linux-gnu`
> 
> And the result was `The MSRV is: 1.77.2`
> 
> and the most important issue was that the mem::offset_of! macro was 
> unstable till then.

I looked for a way to avoid it and the most promising is 
https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=10a22a9b8393abd7b541d8fc844bc0df

Basically, you replace

     pub struct Foo {
         foo: i32,
         bar: i32
     }

with

     with_offsets! {
         #[repr(C)]  // mandatory
         pub struct Foo {
             foo: i32,
             bar: i32,
         }
     }

The macro walks the struct twice, once to actually declare it and once 
to determine the offsets using mem::size_of and mem::align_of.  The 
result is something like

         #[repr(C)]  // mandatory
         pub struct Foo {
             foo: i32,
             bar: i32,
         }

         pub struct FooOffsets {
             foo: usize,
             bar: usize,
         }

         impl Foo {
             pub const offset_to: FooOffsets = FooOffsets {
                 foo: 0,
                 bar: 4,
             }
         }

(where 0 and 4 are actually the aforementioned computation based on 
size_of and align_of).

There are some limitations but the trick is really well done; the need 
for #[repr(C)] is not a problem for us (C<->Rust interoperability needs 
it anyway), and the implementation is fully "const".  And though it only 
works for structs that use "with_offsets!", and with just one level of 
fields, the implementation of offset_of is trivial:

     macro_rules! offset_of {
         ($Container:ty, $field:ident) => {
             <$Container>::offset_to.$field
         };
     }

Anyhow, this should _not_ be in the first version that is 
committed---which, as you remarked in the v2, should focus on working 
build system integration.  As long as we know it is doable, it can be 
left for later.

Paolo


