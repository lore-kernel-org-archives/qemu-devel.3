Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE31CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXhQF-0005pa-Bu; Thu, 11 Jun 2026 11:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXhPy-0005od-E1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:34:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXhPv-0006L0-4Q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:34:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso92310295e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781192041; cv=none;
 d=google.com; s=arc-20240605;
 b=askqQ0FV5kD4fm/4ajgYiI7JdN637DYXzz2XdP1a5moWOT/6mrL8A58hRbKpfDAgd3
 U4R+DSSmZ4it8/ZWoNfsh+2hypQ7OgRlxbRQmWlFe6NfPU4resbHuuN0wYDbpgP4RF4q
 N6K8o3cga1cgYKhypd32glEZm9A67SSKNr10FA+H1VR5Y4lBoill+u/HKhzMXcVWeLqA
 Wlnz/xy8hqFjJD2CkPSQWba/b5A57BckAX8wjmeHc2p7/jFr/MOm1rlBkqDVW9Vq49aP
 3FgJDqYark/MKMs7FdzFSLDBKxlTsul3C0J+t+IaHbeHziu6ZZPIT0wyMReVAqLV7ofm
 wOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vm4uLmChCILXYymCmAdVicUbOclpL26dmji3XQcB/Rw=;
 fh=UEKgBE33Ck/Z89po9fj7tcBdQoC69MT9RaW0VN0ctiQ=;
 b=QJxk0jItr/Xpm+hxT79eHKLXW5J1EBMNY8FloWOBlSuOPbWKK8dIcM7NUlRvFecPYW
 r4MfpFKZFOVMKvM8JTskZcy5zAfsj75TbDHPMhXQr11ZIArKHbuUsh/fl22TeCXWYlmY
 bWoEckJDhpzAoKX3pwltCpuyqyg5tuwbuZ/BU+8FvKxLFhRfbMsZ/kaZkeBPBQ6Z6WrU
 wDFw/UyfAk37souAD/Lkhd+jA15WXdOqsE7WbGYEh4itUQsKRyoNgMxtUWmxnjJefkRX
 Ldfhxfw2cKBnP4LAf1IwDMgrQMjyHy5+M+3Q7pAgSYFn3+qCuO7sQPNmX0tQn4+A/2Vc
 7NKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781192041; x=1781796841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vm4uLmChCILXYymCmAdVicUbOclpL26dmji3XQcB/Rw=;
 b=McLbwcOAeFvP8jKyKC5hS8rLhimwoS4an40u/NwlqJj7oH8yxqMfHKcuwM1EPZhiT1
 pazc+P6uMSRP0yG8fj28tPrLNG0qtB/Bx8drDLEmr9zodIHbcj+vC63JyzJzSVsVgLdo
 +h6ymvLLRQJ6iyJNwqLzHueiFBM/FuwkYjtGoqtmuaNJAix8bBd6GuiiZqdliwuIsDWh
 Kb/jElfoiA/BVhiqTBQ7OTN+qYX7hNsSFWLNYv48+XraJYbuEa0RAa3L2yb4t2q1SgXR
 IN+XrKey3xFE/m0/xXaLXs1ktYLUr+1Sk+aXHld2hjHkSP5D1IG0dN6JI7atZ/zpOZ5j
 JuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781192041; x=1781796841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vm4uLmChCILXYymCmAdVicUbOclpL26dmji3XQcB/Rw=;
 b=iVibLRhPFPLD8dm6D5zuxRsNZj9EkY44ChTgbhLg+ruxcfFV5i9rZlhycLtOJb8zH2
 AP59dM/sMmA45u79azf1XND42EVqkkfs8U5o2s390pjj7JZ54v065VBRYs+EjNO3RwRW
 2uH5YZfrvl0rcrPEL6nsx4qLbpjOTg9mH3bFYn5lH0HmOpcGnJEsvGlwfx/AeIT6GgLl
 uExujcWyzy7scAEBFw2b/g/sBlNAkJSmTl7po+IZfAAtwXVxAZ08VXT2p4HZyCKwDpTv
 2pVkV0L+M43IGuguQPvmOZW8lTdNpQjgXFX3zuNsRX/gY7z9aDv7bBb299ryxFCZa9GT
 1HZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sartyJ3LbmhTHPmj2YuPTg2y/iFE1Q7964VVogEjTxLWcwK8iXgYzKAnbwdbkkZY4KpSxxzj1kGD0@nongnu.org
X-Gm-Message-State: AOJu0Yy3t31eaEA8XbQ2o4zTck6KqarlTXRxmrTK2pt4yBlgEBNyr/z0
 2nd01+NzYtYCTaBHxHIIgbz8yGdFUD87Y1kABeoigo+JK6KB/rxce1zLbma53uRJ92e2/hKZzmc
 B0IT0cVYOPt49tGZrsKvih+g37Geo3tyqFtr1/7StdA==
X-Gm-Gg: Acq92OGbQsyTHm9tghmgc0QDziMoYY4zTK9aGbPMdMtRsugvamihqD9j+TbKG1KkRRG
 3zcN5pWCEEloDFHf2JfqYu3K624EL5zDQxYJQ4yrrMUQVydqWs1J9/PapJiGc0mxtZNNmYBmbDk
 YoW/uJTvtIi2RbfBI/w/w5Y1wtNqdVwmbOJsbfqTNvpGqsVG4ksaNprlp/c5GBicAQJVfUAPRsR
 Lgj/xaXawGb/l4MKLR198pG5WM/wvwSbCY03f/ps0kgXUS4WGRz13G+wTVc5kKcWa4laEPSsSLu
 ytya4hg4pWtD2Q1gBpN73y2/QoLk80XBraqe7W4RGDM+076Q0vy7l9iOZ3o2U50hSA2TmTgS8Mp
 Spx+UCMHGa/G65OqjglJMqzQfR+ByLzWQHJL9XAI=
X-Received: by 2002:a05:600c:c8a:b0:490:b072:1be6 with SMTP id
 5b1f17b1804b1-490e5639bffmr48613105e9.25.1781192040590; Thu, 11 Jun 2026
 08:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260526175618.227743-1-pbonzini@redhat.com>
 <20260526175618.227743-16-pbonzini@redhat.com>
 <airS4hj5u/9T2T2H@intel.com>
In-Reply-To: <airS4hj5u/9T2T2H@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 11 Jun 2026 18:33:34 +0300
X-Gm-Features: AVVi8CeVW1MNitgtId1dt2ASjDM3W7m4AMH9_58aHVJTOr9BSJk4WsjTaly9TOc
Message-ID: <CAAjaMXbBOpiy1PUPy+VWC7i0LDC4Vht95T5A9goWGFHeBbO9-A@mail.gmail.com>
Subject: Re: [PATCH v3 15/19] scripts/qapi: generate high-level Rust bindings
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, armbru@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 5:56=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> On Tue, May 26, 2026 at 07:56:14PM +0200, Paolo Bonzini wrote:
> > Date: Tue, 26 May 2026 19:56:14 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH v3 15/19] scripts/qapi: generate high-level Rust bindin=
gs
> > X-Mailer: git-send-email 2.54.0
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Generate high-level native Rust declarations for the QAPI types.
> >
> > - char* is mapped to String, scalars to there corresponding Rust types
> >
> > - enums use #[repr(u32)] and can be transmuted to their C counterparts
> >
> > - has_foo/foo members are mapped to Option<T>
> >
> > - lists are represented as Vec<T>
> >
> > - structures map fields 1:1 to Rust
> >
> > - alternate are represented as Rust enum, each variant being a 1-elemen=
t
> >   tuple
> >
> > - unions are represented in a similar way as in C: a struct S with a "u=
"
> >   member (since S may have extra 'base' fields). The discriminant
> >   isn't a member of S, since Rust enum already include it, but it can b=
e
> >   recovered with "mystruct.u.into()"
> >
> > Anything that includes a recursive struct puts it in a Box.  Lists are
> > not considered recursive, because Vec breaks the recursion (it's possib=
le
> > to construct an object containing an empty Vec of its own type).
> >
> > Given the experimental nature of Rust, and the incompleteness of the
> > backend (it lacks commands and events), QAPIRsBackend is not modular
> > and is not built together with the C and trace-event files.  It can
> > be used by specifying "-B qapi.backend.QAPIRsBackend" on the qapi-gen
> > command line.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lur=
eau@redhat.com
> > [Paolo: rewrite conversion of leaf types]
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  meson.build              |   4 +-
> >  scripts/qapi/backend.py  |  25 +++
> >  scripts/qapi/common.py   |  49 ++++++
> >  scripts/qapi/rs.py       |  50 ++++++
> >  scripts/qapi/rs_types.py | 372 +++++++++++++++++++++++++++++++++++++++
> >  scripts/qapi/schema.py   |  59 +++++--
> >  6 files changed, 540 insertions(+), 19 deletions(-)
> >  create mode 100644 scripts/qapi/rs.py
> >  create mode 100644 scripts/qapi/rs_types.py
>
> [snip]
>
> > +def rs_name(name: str) -> str:
> > +    """
> > +    Map @name to a valid, possibly raw Rust identifier.
> > +    """
> > +    name =3D re.sub(r'[^A-Za-z0-9_]', '_', name)
> > +    if name[0].isnumeric():
> > +        name =3D '_' + name
> > +    # based from the list:
> > +    # https://doc.rust-lang.org/reference/keywords.html
> > +    if name in ('Self', 'abstract', 'as', 'async',
>                     ^^^^
> > +                'await', 'become', 'box', 'break',
> > +                'const', 'continue', 'crate', 'do',
>                                          ^^^^^
> > +                'dyn', 'else', 'enum', 'extern',
> > +                'false', 'final', 'fn', 'for',
> > +                'if', 'impl', 'in', 'let',
> > +                'loop', 'macro', 'match', 'mod',
> > +                'move', 'mut', 'override', 'priv',
> > +                'pub', 'ref', 'return', 'self',
>                                             ^^^^
> > +                'static', 'struct', 'super', 'trait',
>                                         ^^^^^
> > +                'true', 'try', 'type', 'typeof',
> > +                'union', 'unsafe', 'unsized', 'use',
> > +                'virtual', 'where', 'while', 'yield'):
> > +        name =3D 'r#' + name
>
> EMM, r#self, r#Self, r#crate and r#super are "RESERVED_RAW_IDENTIFIER",
> and "It is an error to use the RESERVED_RAW_IDENTIFIER token". [*]
>
> [*]: https://doc.rust-lang.org/reference/identifiers.html#grammar-RESERVE=
D_RAW_IDENTIFIER
>
> We can't use 'q_' prefix for these special case, or what about
> name + '_'?

This is what bindgen does also:

https://github.com/rust-lang/rust-bindgen/blob/2048231f45c87cd65d7891f55090=
aac81cc0d66b/bindgen-tests/tests/headers/keywords.h

becomes:

https://github.com/rust-lang/rust-bindgen/blob/2048231f45c87cd65d7891f55090=
aac81cc0d66b/bindgen-tests/tests/expectations/tests/keywords.rs

>
> e.g.,
>
> if name in ('self', 'Self', 'crate', 'super'):
>    name =3D name + '_'
> elif name in (...)
>    name =3D 'r#' + name
>
> > +
> > +    return name
> > +
>
> [snip]
>
> > @@ -502,6 +515,9 @@ def is_implicit(self) -> bool:
> >      def c_type(self) -> str:
> >          return c_name(self.name) + POINTER_SUFFIX
> >
> > +    def rs_type(self) -> str:
>
> Only a nit, it's better to check _checked before accessing element_type
> (just refer Markus' suggestion in v2)
>
> assert self._checked
>
> > +        return 'Vec<%s>' % self.element_type.rs_type()
> > +
>
> Regards,
> Zhao
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

