Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB6D4923C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD45P-000219-40; Mon, 18 Nov 2024 10:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD45L-0001y2-Ch
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:54:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD45J-0007lS-38
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731945277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wa1r9aZImSfGgniRWdh7zmJr4Ai6Q7DzylMHq8VWga8=;
 b=C310Zy8twKfX+YT8U/owiDUHCop/7qkgszK3fwTWrb0PD2j7OspqDmUKAlPv00kqZw4KFe
 PQxLhWKw1vEVdC0Pz0SA14F0+DOXuDIJXgHNhv/qB593snMuYtTfbc8fuAXenhRIFtxrF4
 fnRTFU3eFw1HnaG08mDhvKHv3uPdcW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-r4xwb3mQMYqJjIWVqzuFXQ-1; Mon, 18 Nov 2024 10:54:34 -0500
X-MC-Unique: r4xwb3mQMYqJjIWVqzuFXQ-1
X-Mimecast-MFC-AGG-ID: r4xwb3mQMYqJjIWVqzuFXQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38231e6b4cbso1872463f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 07:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731945273; x=1732550073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wa1r9aZImSfGgniRWdh7zmJr4Ai6Q7DzylMHq8VWga8=;
 b=bD6EubTxoSMMh9uxj+IpsfgmKHslEKf9ujvLmw01jwmWWaOX6OikPQMPeFm9uz5OoO
 YdRni+LIr+ahPWGOgQC8JYgi2nv4ICFG8ikuFALlLUVOikHbbH1vFe9u74mvKp6fopDn
 7rqCgZWmTp//7u9xOKitfGpe/9gJ49Lv2Mvo6N6ugt2kCyAKtzBd6TaB9QudAWL1Cul/
 e+zTpmrOnWsRqF+KB7S//x9evcy9X9SiWS6pk1HO/daaSRQn4TX12gvJQvhgM5K2G33g
 X08etfrXjpMQEMN3idjDMEAEKKg+JbOEkDPSTErpTMabz7n88vFcPe+uJE9HoREDp3NC
 FdhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEhRF8B4YetQ+wyWmOOJ7/mb06ZqEPMT0CSeqWYSTrDTuBzzBwdvgVzp01M9nqQ4Y/e/YWULJ739WQ@nongnu.org
X-Gm-Message-State: AOJu0Ywh7y6QbEEmRVCvATCGtvg4+mZ8LmAB9FQjaGU7WBFlVNzVc+N8
 JqcuA06Q09HTOdhKd+nB0mBX3UVNgfokr6kgB6AtUQGH65MTN9xT08TnLodrbiiq715HmXNqC+H
 KbF3yJLdGJJIeNMEknHAKoCAqzLFyUkknTOlWcvI8MAM+bbOOwHc4k9Bt8ZVwr0BH0NMEzpwwf6
 i00Cr2dfyWxfqQHN4NAwbaF0cXth4=
X-Received: by 2002:a05:6000:2ac:b0:382:2f62:bd3c with SMTP id
 ffacd0b85a97d-3822f62bf96mr9747290f8f.19.1731945272379; 
 Mon, 18 Nov 2024 07:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnaUIjxQoGd1kSYOl47NXs3K6BExZ6KPNN+xXAuPqIz0Z9F007IERVdb15oldw17Z5Y+g18yijDY+Be2KdxrQ=
X-Received: by 2002:a05:6000:2ac:b0:382:2f62:bd3c with SMTP id
 ffacd0b85a97d-3822f62bf96mr9747269f8f.19.1731945272025; Mon, 18 Nov 2024
 07:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20241117161039.3758840-1-manos.pitsidianakis@linaro.org>
 <875xoku5vd.fsf@draig.linaro.org> <n5ibr.51opa2z9dha@linaro.org>
In-Reply-To: <n5ibr.51opa2z9dha@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Nov 2024 16:54:19 +0100
Message-ID: <CABgObfaO0eppxerv=VDy7D9dhHJyUtqiQQn0ZWDNsaZpuBXmRQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust/pl011: Fix DeviceID reads
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-rust@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 18, 2024 at 3:46=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> Yep, const fns are evaluated at compile time

This is not correct; "const fn"s *can* be evaluated at compile time.
In this case they won't since "self" is only available at run time.
The match statements persist in the final compiled code.

> >Perhaps this comes down to unfamiliarity with the way macros are working
> >here but in general macros should be eliding boilerplate to allow us to
> >concisely represent the relevant data and functionality. Here it adds an
> >additional indirection when reading the code just to see what is going
> >on.
>
> Well in the previous patch versions the concern was that it was
> "verbose". But even if the registers are available as memory mapped in
> the device it's the wrong abstraction to use here; this is a higher
> level language than C and using indices is a "when you have a hammer
> everything looks like a nail" situation.
>
> We have different programming paradigms in Rust, allowing as to have
> documented code (via rustdoc), so either we take advantage of Rust or we
> don't.

Your usage of macros also is a "when you have a hammer everything
looks like a nail" situation. You're going straight from code that
might be a bit C-like to code that looks like Perl. Rust macros can be
useful to reduce boilerplate, but in this case the macro-based
solution does not make it much easier to see all values at once for
verification purposes, and makes it harder to understand the code's
behavior.

What makes code more "Rusty" would be things like using Result for
error handling, taking advantage of the type system, using traits for
polymorphism, using references to guarantee memory safety. QEMU is
hardly doing any of this, and the rustdoc for qemu_api is also just
starting, so maybe this patch is getting a bit ahead of ourselves?

It's not reasonable to use 50 lines of code just for eight
identification bytes. Even the spec says "The registers can
conceptually be treated as a 32-bit register", which to me suggests
making its contents a u32 const and calling it a day. But if you want
to make it overengineered but sensible, then do this:

const fn getPartNumber(self) -> u12 {0x11}
const fn getDesignerID(self) -> u8 {match ...}
const fn getRevision(self) -> u4 {0x1}
const fn getConfiguration(self) -> u8 {match ...}

and then a getPeriphId(idx: u8) that puts the four together in a u32
and returns ((val32 >> (8 * idx)) & 255) as u8.

For PCellID, the spec itself says the value is 0xB105F00D, so *please*
just hardcode them in the read method. Anything else is a waste of
everybody's time. And since we're in hard freeze, maybe we should
reconsider the one line fix and leave everything for later.

> I had sent patches on a previous patch series that only some patches of
> them were picked up for merging, I plan to send a new revision soon

Cool, thanks.

Paolo


