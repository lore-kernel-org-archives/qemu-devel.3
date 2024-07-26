Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C79C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 07:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXFKz-00080r-3g; Fri, 26 Jul 2024 03:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sXFKx-00080J-RJ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:25:59 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sXFKv-0006JN-Eo
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:25:59 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so152736266b.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721978755; x=1722583555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g7fIqmg8RWpU9kZs5rXHghZd3bAYy4S4DaK6Uab/tTk=;
 b=AKLA9lIvKE/H5/hl4L5w/m+mJBPigA0KwX5u7rCeVktqY4786scDsuV+SLLf+i5GRQ
 NlOn7j0ehSvAnpE7W/007i7ZQjSJLYFn40br79kxuojzIjlK0Aeme07Ri6mGZV2LnruK
 kXHXm3MW07dKcL3FgsN8uHWLwUDEaSTnQayZ1cUEKILuDzzgfkVMmK5HkZdrrXE3tfZR
 5M2pTKahYEIErYyxVcLv6+zfrMK0kcGnJiXJJgv6hZWCMixpsFlmCG//LhviXVFO8e7P
 4DsFyPUbSicNg2orSmPT7ap5LSj1eRyQ5RRrckDRbgMsWvO/TvRUS9sRm3Bioudrk88J
 Y8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721978755; x=1722583555;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g7fIqmg8RWpU9kZs5rXHghZd3bAYy4S4DaK6Uab/tTk=;
 b=ldGgyxAL2npdp2q9c7b7xMhzztUHZXRb8zgXieeu2RdrGUzEWNAkYl+yCPYd+LtX3F
 rqKcL5jKy6Ifp9nlF9ltKD0vfdgXRsB+z3EDveDKnMkLb03v7oOPkDxVWh3cwZcFWJEk
 /jmHQV7+bjlEgkWQsnULeiLTt8JeAZZUYw/zGOlpavGZobuclSO9alOHBsio8sqhjlxl
 dyUVCku3oWTMpFwI0gmxKXzWeJNr0BIIYaA50XkilHG8cw8GhRsICj6SfO5jbRrkEo0j
 i5jdcb0E7QRXUmHYEUlJyJnY3AXBkOy0f8DyPkNGwiW2ReD4gFxGDSpbDia53r1bvw0H
 YMKw==
X-Gm-Message-State: AOJu0YxgatAGGEQfJRX5xladDCUo1ns7EsL3v0sqFihKn5HhyFVyROEI
 l2538B2Rhwv/MqPV3cXq48pToxcB7O8xEYvSSJGjSDPG81NVnyVXvgjc84IIqctVqUOYYqq5ZHv
 3xXA=
X-Google-Smtp-Source: AGHT+IEwqZxvLHcmW0NVg9F05V6ki7PT/rxdl1OIf0i0iZNsJszw+PUa43ZIhRVEXVjlNW5ryildfw==
X-Received: by 2002:a17:906:dc8f:b0:a7a:a6e1:2c60 with SMTP id
 a640c23a62f3a-a7ac506f2dfmr422944266b.61.1721978754965; 
 Fri, 26 Jul 2024 00:25:54 -0700 (PDT)
Received: from meli-email.org (adsl-159.37.6.160.tellas.gr. [37.6.160.159])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de7asm145071266b.66.2024.07.26.00.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 00:25:54 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:12:19 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
 <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
 <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
 <CABgObfb27wbwgErFsMdsuSo1BxQVBoRfbrUmK2k-x5Ya3ez0TA@mail.gmail.com>
In-Reply-To: <CABgObfb27wbwgErFsMdsuSo1BxQVBoRfbrUmK2k-x5Ya3ez0TA@mail.gmail.com>
Message-ID: <h7zb4.aog50x8tfxkp@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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

On Thu, 25 Jul 2024 18:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Thu, Jul 25, 2024 at 4:48 PM Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>> > pl011_receive (called by qemu_chr_fe_accept_input) creates a mutable
>> > reference that *overlaps* the lifetime of the outer reference created
>> > by pl011_read. This is undefined behavior. You're effectively writing:
>>
>> There is no overlap there, sorry. Once qemu_chr_fe_accept_input
>> returns, any references it created do not exist anymore.
>
>read     |-------------|
>receive      |-----|
>
>That's the overlap. Maybe you're thinking that the outer &mut "goes to
>sleep" and is reborn when qemu_chr_fe_accept_input() returns, but
>there's no such thing in the language.

There's no overlap, because the read scope is not live while receive is 
active. References are linear types, when you give `&mut sth` as an 
argument to a function call, you can model it in your mind as "giving 
the mutual reference to the function call" and "receiving it back" when 
it returns.

There'd be an overlap if qemu_chr_fe_accept_input got two mutual 
references of the same memory location, such as calling foo(&mut self, 
&mut self) with foo being `fn foo(a: &mut T, b: &mut T)`.

>
>You can do it within a function:
>

These examples you provide are not really equivalent.

>Honestly I don't see how I can provide a proof or explanation that is
>more definitive than miri. If some specific documentation or
>discussions gives you the perception that there is no undefined
>behavior, I'm happy to check them out and provide an explanation in
>that context. But otherwise, I don't think it's useful to keep
>debating *whether* it is undefined behavior.


Agreed! but thank you for taking the time to discuss this :)

Manos

PS: I will explain why your good/bad example behaves like it does:

>// MIRIFLAGS=-Zmiri-ignore-leaks  cargo +nightly miri run
>use std::mem::MaybeUninit;
>
>struct S {
>    me: *mut S,
>    them: *mut S
>}
>
>impl S {
>    pub fn chardev_receive(&mut self) {
>        println!("in chardev_receive with &mut");
>    }
>
>    pub fn memory_write_good(&mut self) {
>        println!("in memory_write_good, calling qemu_chr_fe_accept_input()");
>        qemu_chr_fe_accept_input_good(self);
>    }
>
>    pub fn memory_write_bad(&mut self) {
>        println!("in memory_write_bad, calling qemu_chr_fe_accept_input()");
>        qemu_chr_fe_accept_input_bad(self);
>    }
>}
>
>fn qemu_chr_fe_accept_input_good(c: &S) {
>    // you can still go from *mut to &mut in _another_ instance of struct S
>    (unsafe { &mut *c.them }).chardev_receive();

`them` is an uninitialized value, so you are dereferencing it and 
passing a mutable reference to it, while

>}
>
>fn qemu_chr_fe_accept_input_bad(c: &S) {
>    // you cannot go from *mut to &mut when it points to _this_ instance;
>    // creating the &mut that is passed to memory_write_bad() has
>    // effectively made that *mut unusable!
>    (unsafe { &mut *c.me }).chardev_receive();
>}

`me` is the same memory location as `c`, which is passed as read only 
(&S) here.

>
>fn main() {
>    let p: &mut MaybeUninit<S> = Box::leak(Box::new(MaybeUninit::uninit()));
>    let q: &mut MaybeUninit<S> = Box::leak(Box::new(MaybeUninit::uninit()));
>
>    unsafe {
>        let p_mut_ptr = p.as_mut_ptr();
>        let q_mut_ptr = q.as_mut_ptr();
>        *(&mut *p_mut_ptr) = S { me: p_mut_ptr, them: q_mut_ptr };
>        (&mut *p_mut_ptr).memory_write_bad();
>        (&mut *p_mut_ptr).memory_write_good();
>   }
>}
>

