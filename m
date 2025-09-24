Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D479ECAC5B6
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 11:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1O0u-0004cW-PE; Wed, 24 Sep 2025 07:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v1O0k-0004b0-UR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 07:50:15 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v1O0g-0003dQ-0A
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 07:50:14 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-62fc0b7bf62so7927117a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758714603; x=1759319403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rpr3iRDxVtuyglgoTruNPTjGuVTQsaYML/7tSgdB2c=;
 b=Yfp3vPbE8PTdbCqwfrAPLNFlWiPK0DH5NJuyJqYkNzuWaYtA6mAk/ctMKxj1tD6Fov
 y4mlrlU460DIVhqvXEoo/4stvoWox91Tm/OmygYnuZ/+XS9RnMrfcviDmJ9Ng9KJT9qF
 ZHDkRTfwmpEJRtHP2zQRc0vJfRyKtSGWPEaCZnlyaG9D6dZqYBe6WyxrqSNgMtHSfxaL
 v2/v573Aa7vcdxwnMctvjnmSaHJeGA+07l5kn1EDp0nRSqeq/6V0JSngqFv+DEotOqo0
 XCUrTJSeXuKxZNauXuRdQnyl/NGXCgekwbXao4Koh+NooqH5CMNOrhJ6YKmQCy8avZ9o
 qBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758714603; x=1759319403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rpr3iRDxVtuyglgoTruNPTjGuVTQsaYML/7tSgdB2c=;
 b=LMmBtc9b0kkKeBifMEnc4aiuETUM0CrZKu08e/eMvbUu4I2PwROPWfXlZ2xxoSDfVd
 NGkRuxAESOr5BcfJP+SoOtoYnI13ucujTbM3aByOy6J1tJ5gTlpWCPPZ3bLmK0DpaEsH
 XpBLz+1F68La2J3BcH2QxPExqvLYjMYHOqlAFHzZVSvmX3+nuoRd+sjW3W9kCYwr88X0
 Kyaby2ZQ/6hgB5HcYhF63DrjyQwC+qG5hPegf3gKW3ZWr9EUZ0o27yaXPCGNEudE0Zg0
 EroOTGezQ/zZAi3Dgx5LS0c9Po7LIOD+Jx3/R9dq8bsTkuX2Kz8zAnvpnIEsczsbwYH4
 LXUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsuvLFxLGhhAmCsmQFvIZpffTBk5awYvQrYY26DdnyjwA0Qly9Au5X6cEO8a3xbi05DKuhD35JlRtw@nongnu.org
X-Gm-Message-State: AOJu0YxMNRx7q0cbnUpeRov/jtpS8Vx15d2OJcC/KFzxWXbCwC/Sc7sN
 rm9gGptUlWvMeBXn7nPtfqC3Q7haR07xpzLgXINEvuF58ovNzHOjkQN4/D6t3242Ztx3Z1eio4W
 8YrAW5tbuJ5Hb9OyF+cVtxHpW5PrLc9M=
X-Gm-Gg: ASbGncsvnKkZGZTJefbKajrPV48hv/DrS08mIEvQnCI6Zc+fPGM6ZLn9gzq2wEdMWPC
 IeMP0QRpErQm8JzGv9JDTHCt+wgaKm7eCuhV8t/ddOxIBCB085f6hFIxuw2hY37kmy0dwABxhir
 TI2N58RtoOCMwy8zJw8S9VRRWm6XvE2wdI5sVjoL/IyqJcjZfxIsbgHL1J3gFxFrqvUgbaNFVv6
 Qapew==
X-Google-Smtp-Source: AGHT+IHgiVhOGJJVGHpYl/qZa7I7BD7GxmouBuZ7nACq/wrDhRRknqbJ7xHAzR6CwSWCLw4hmFlOovux0i4cnAByiIY=
X-Received: by 2002:a05:6402:2182:20b0:634:1516:416b with SMTP id
 4fb4d7f45d1cf-63467812c62mr4691777a12.24.1758714602700; Wed, 24 Sep 2025
 04:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
 <aNOi40MRaGEL0df3@redhat.com>
In-Reply-To: <aNOi40MRaGEL0df3@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 24 Sep 2025 07:49:49 -0400
X-Gm-Features: AS18NWD0t7eJOGu5Kh87r0PpqGQWMC7xKj7Pxr8Qmble8ELEiPWK_CEalPRyMSY
Message-ID: <CAJSP0QXL1fXebRRtRTjQOzArtX0a-8q1wWDVb3WdU=Z5DYqaJQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, 
 Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Sep 24, 2025 at 3:51=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Sep 24, 2025 at 09:13:15AM +0200, Paolo Bonzini wrote:
> > On 9/23/25 21:23, Stefan Hajnoczi wrote:
> > > > +    out('// SPDX-License-Identifier: GPL-2.0-or-later',
> > > > +        '// This file is @generated by tracetool, do not edit.',
> > > > +        '',
> > > > +        '#[allow(unused_imports)]',
> > > > +        'use std::ffi::c_char;',
> > > > +        '#[allow(unused_imports)]',
> > > > +        'use util::bindings;',
> > > > +        '',
> > > > +        '#[inline(always)]',
> > > > +        'fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool =
{',
> > > > +        '    unsafe { (trace_events_enabled_count !=3D 0) && (_id =
!=3D 0) }',
> > > > +        '}',
> > >
> > > This was translated to Rust from:
> > >
> > >    /* it's on fast path, avoid consistency checks (asserts) */
> > >    #define trace_event_get_state_dynamic_by_id(id) \
> > >        (unlikely(trace_events_enabled_count) && _ ## id ## _DSTATE)
> > >
> > > The _id !=3D 0 expression is incorrect. The purpose was to check whet=
her
> > > the trace event is currently enabled (i.e. dynamically at runtime).
> >
> > The expression is correct, but the function and argument names are not.=
 It
> > should be
> >
> > fn trace_event_state_is_enabled(dstate: u16) -> bool {
> >      unsafe { trace_events_enabled_count } !=3D 0 && dstate !=3D 0
> > }
> >
> > > > +    # static state
> > > > +    for e in events:
> > > > +        if 'disable' in e.properties:
> > > > +            enabled =3D "false"
> > > > +        else:
> > > > +            enabled =3D "true"
> > >
> > > What is the purpose of this loop? The variable enabled is unused so I
> > > think it can be deleted.
> >
> > The Rust code generator is not emitting any code for disabled tracepoin=
ts.
> > Unlike C, where the disabled tracepoints can produce e.g. -Wformat warn=
ings,
> > there's no real benefit here.
> >
> > In the RFC the "enabled" variable was used to produce a const for the s=
tatic
> > state; it had no user so I removed it, but I left behind this dead Pyth=
on
> > code.  Sorry about that!
>
> Is the concept of build time 'disabled' tracepoints actually useful to
> still support ? AFAICT we use it in only places, which doesn't make it
> sound too compelling:
>
> $ find -name trace-events | xargs grep '^disable'
> ./target/hppa/trace-events:disable hppa_tlb_flush_ent(void *env, void *en=
t, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=3D%p ent=3D%p va_b=3D0x%=
lx va_e=3D0x%lx pa=3D0x%lx"
> ./target/hppa/trace-events:disable hppa_tlb_find_entry(void *env, void *e=
nt, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=3D%p ent=3D%=
p valid=3D%d va_b=3D0x%lx va_e=3D0x%lx pa=3D0x%lx"
> ./target/hppa/trace-events:disable hppa_tlb_find_entry_not_found(void *en=
v, uint64_t addr) "env=3D%p addr=3D%08lx"
> ...snip...
> ./target/hppa/trace-events:disable hppa_tlb_lpa_success(void *env, uint64=
_t addr, uint64_t phys) "env=3D%p addr=3D0x%lx phys=3D0x%lx"
> ./target/hppa/trace-events:disable hppa_tlb_lpa_failed(void *env, uint64_=
t addr) "env=3D%p addr=3D0x%lx"
> ./target/hppa/trace-events:disable hppa_tlb_probe(uint64_t addr, int leve=
l, int want) "addr=3D0x%lx level=3D%d want=3D%d"
> ./hw/display/trace-events:disable qxl_io_write_vga(int qid, const char *m=
ode, uint32_t addr, uint32_t val) "%d %s addr=3D%u val=3D%u"

My recollection is that disabled events were supposed to eliminate the
cost of trace events. Downstreams could disable trace events that they
didn't need.

I'm not aware of any users besides the ones that your grep identified.
We could probably remove the disable keyword without any real impact
on users.

Stefan

