Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A74DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0bWK-0005qT-PP; Mon, 22 Sep 2025 04:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0bWF-0005pO-8D
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:03:31 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0bWA-0005Yv-BS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:03:31 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-43d2da52291so2019578b6e.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758528203; x=1759133003; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hD6A8XYkT1uvXeBl4CEF0ug6ZDloFCDhrNUshrTmda8=;
 b=HECJjErqT5xrDG04oQtFcuJ6ZXT676oh4Foq1viovBUjA+PxYMuW/9FKhrpTahS1+G
 3RFEjO1uNeMXiDh9rNBjuweAum8EJayJi6RbD3ThJFy2FbMHu1iWvLPyGezC6qdCR/64
 fvnVMYFB0JXStIN1EFz5yq66UO8Bk/D4WPyCC1KfFqusla1vJVtxFTH7UkoW9S9ZTe56
 Izmd7E1QSMdBJKR5Hs10mOvlpTW7f4OBrrx+laV5sObwcvjKh4ayNvMljXE+6WxpeVaB
 AGBa4MyY4P0nFY3hGvii5xShoYWTEKkSVL08NUnZR+izDAQkL2a8s6c+AzZsj9l9F6LS
 TVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758528203; x=1759133003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hD6A8XYkT1uvXeBl4CEF0ug6ZDloFCDhrNUshrTmda8=;
 b=YvBL7LklC1lwA8YUOHmYhfN1kzZ+JJj3BoMAKOTUkH7SzTmMnXyWGfDLE9CzwFAOR/
 RhhoXvLadUHjBiuvuJXmaXqe+FNe3pbngSqJn7n8sSnVrUvOBw+d66npyAkEKHk6S78V
 Ez5//oJR6OBLrB+d7HgKJLqHnTaxjtHSno5DFZ1bw6tCzhKbkml2MnWgwoggKCLLSBh3
 3yMKMAT19AyFppaXSTv889sjyDSG4NvGcZVz6hLs5YMPHbixrj8jI7uQYU3CrUyEWd8K
 NC46AQ1JNfzZf1KMERaxEBnfYojE8ADJD3rm5j2DigrveNjry5ooXn2PXM0iYbpE/k2N
 OPpQ==
X-Gm-Message-State: AOJu0YySEpaT90SAph/ubIEesslUAzm1sFRs3j+9wISWarzHf3UxwC1U
 1PIXyDqVDHByZCIdxL4BHREE9hGajnJZUMwmX4R7HNj2md8e8xBONfq/QtpDs4J8BwuMMv7O2jt
 8oQPMDadHxcYogQJx10Jyut9vaB0toWrQMhtzuSS0XQ==
X-Gm-Gg: ASbGncs8TnbrbN7aAwD9KMZ8j0hFotlo1rQe8sYGaE8AT1UuFL2Ms2mmRcb6F9iPFdZ
 aWga3BFfflfTRC7FIYvm43l63XW73rzg+IzSRWhjn2Kp06nomGzwHjMkP5juAFoC1vA5iVwKLP9
 Gv4sMVjbaLK4QkxSM6oF11xhrk9uYci7Pwh/2QULYLPRT2cRF6rXSxd7VvywnCiCzbh2iqOJT9f
 loqXGvMAw==
X-Google-Smtp-Source: AGHT+IGRo1WMKOau+j+J8s6+F8DnCO/hyr44L7PgnDbmRV89mv1Wk0iNMgiX835u5s1JiMFqJyIMvtQ71x4hXNSt8Zw=
X-Received: by 2002:a05:6808:3994:b0:43d:2ce0:1201 with SMTP id
 5614622812f47-43d6b8468ffmr5488024b6e.24.1758528202881; Mon, 22 Sep 2025
 01:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250915084037.1816893-1-max.chou@sifive.com>
 <20250915084037.1816893-4-max.chou@sifive.com>
 <26d72d8e-5e58-4a04-865c-34f6094e74e9@ventanamicro.com>
In-Reply-To: <26d72d8e-5e58-4a04-865c-34f6094e74e9@ventanamicro.com>
From: Max Chou <max.chou@sifive.com>
Date: Mon, 22 Sep 2025 16:03:12 +0800
X-Gm-Features: AS18NWC0sCYhnhyXIaxf8fwmqKK2VhYK6z-s7z2iNOf2GX1l4R7xy8-U6C0qURA
Message-ID: <CANiaA1tzoM+y8vcFUdFaP8Po8Af2AGy_1gyuHzzPo8sG9rJ+Pg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/8] target/riscv: rvv: Add new VTYPE CSR field -
 altfmt
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000dc52ff063f5f4070"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=max.chou@sifive.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000dc52ff063f5f4070
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:57=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Is this correct? The 'reserved' value you're returning when the new
> extension is enabled
> is the original  value from vsetvl:
>
> > +    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> > +        reserved =3D vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> > +                                           xlen - 1 -
> R_VTYPE_RESERVED_SHIFT);
>
> The original val you removed:
>
> > -    target_ulong reserved =3D s2 &
> > -                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> > -                                            xlen - 1 -
> R_VTYPE_RESERVED_SHIFT);
>
>
> To preserve the existing behavior I believe you want to negate the
> conditional:
>
> > +    if (!riscv_cpu_cfg(env)->ext_zvfbfa) {
> > +        reserved =3D vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> > +                                           xlen - 1 -
> R_VTYPE_RESERVED_SHIFT);
> > +    } else {
> > +        reserved =3D vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
> > +                                           xlen - 1 -
> R_VTYPE_ALTFMT_SHIFT);
> > +    }
>
>
> i.e. return the existing 'reserved' val if the new extension is absent,
> otherwise return
> the new val.
>
>
> Thanks,
>
> Daniel
>

Hi Daniel,


Yes, I believe that=E2=80=99s correct. After enabling the Zvfbfa extension,=
 the
reserved field in the VTYPE CSR depends on the extension as follows:

   - When Zvfbfa is enabled:
      - The reserved field in the VTYPE CSR: from bit 9 (VTYPE_RESERVED) to
      XLEN
   - When Zvfbfa is not enabled:
      - The reserved field in the VTYPE CSR: from bit 8 (VTYPE_ALTFMT) to
      XLEN


PS: This commit also modifies the definition of VTYPE_RESERVED.

Because the EDIV extension is not planned to be part of the base V
extension. Therefore, this commit modifies the default RESERVED field
definition.


Reference:
https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc


Thanks,

Max


>
>
> +
> > +    return reserved;
> > +}
> > +
> >   target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> >                               target_ulong s2, target_ulong x0)
> >   {
> > @@ -41,12 +57,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env,
> target_ulong s1,
> >       uint64_t vlmul =3D FIELD_EX64(s2, VTYPE, VLMUL);
> >       uint8_t vsew =3D FIELD_EX64(s2, VTYPE, VSEW);
> >       uint16_t sew =3D 8 << vsew;
> > -    uint8_t ediv =3D FIELD_EX64(s2, VTYPE, VEDIV);
> > +    uint8_t altfmt =3D FIELD_EX64(s2, VTYPE, ALTFMT);
> >       int xlen =3D riscv_cpu_xlen(env);
> >       bool vill =3D (s2 >> (xlen - 1)) & 0x1;
> > -    target_ulong reserved =3D s2 &
> > -                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> > -                                            xlen - 1 -
> R_VTYPE_RESERVED_SHIFT);
> >       uint16_t vlen =3D cpu->cfg.vlenb << 3;
> >       int8_t lmul;
> >
> > @@ -63,7 +76,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env,
> target_ulong s1,
> >           }
> >       }
> >
> > -    if ((sew > cpu->cfg.elen) || vill || (ediv !=3D 0) || (reserved !=
=3D
> 0)) {
> > +    if (cpu->cfg.ext_zvfbfa) {
> > +        if (altfmt =3D=3D 1 && vsew >=3D MO_32) {
> > +            vill =3D true;
> > +        }
> > +    }
> > +
> > +    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) !=3D
> 0)) {
> >           /* only set vill bit. */
> >           env->vill =3D 1;
> >           env->vtype =3D 0;
>
>

--000000000000dc52ff063f5f4070
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 17, 2025 at=
 9:57=E2=80=AFPM Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ven=
tanamicro.com">dbarboza@ventanamicro.com</a>&gt; wrote: =C2=A0=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">
Is this correct? The &#39;reserved&#39; value you&#39;re returning when the=
 new extension is enabled<br>
is the original=C2=A0 value from vsetvl:<br>
<br>
&gt; +=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_zvfbfa) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reserved =3D vtype &amp; MAKE_64BIT_MASK(=
R_VTYPE_RESERVED_SHIFT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xlen - 1 - R_VTYPE_RESERVED_SHIFT);<br>
<br>
The original val you removed:<br>
<br>
&gt; -=C2=A0 =C2=A0 target_ulong reserved =3D s2 &amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 xlen - 1 - R_VTYPE_RESERVED_SHIFT);<br>
<br>
<br>
To preserve the existing behavior I believe you want to negate the conditio=
nal:<br>
<br>
&gt; +=C2=A0 =C2=A0 if (!riscv_cpu_cfg(env)-&gt;ext_zvfbfa) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reserved =3D vtype &amp; MAKE_64BIT_MASK(=
R_VTYPE_RESERVED_SHIFT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xlen - 1 - R_VTYPE_RESERVED_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reserved =3D vtype &amp; MAKE_64BIT_MASK(=
R_VTYPE_ALTFMT_SHIFT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xlen - 1 - R_VTYPE_ALTFMT_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
<br>
i.e. return the existing &#39;reserved&#39; val if the new extension is abs=
ent, otherwise return<br>
the new val.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>=C2=A0</blockquote><p style=3D"margin:0px;font-size:13px;line-hei=
ght:normal;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;fon=
t-kerning:auto;font-variant-alternates:normal;font-variant-ligatures:normal=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-feature-se=
ttings:normal">Hi Daniel,</p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal;min-height:15px=
"><br></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal">Yes, I believe=
 that=E2=80=99s correct. After enabling the Zvfbfa extension, the reserved =
field in the VTYPE CSR depends on the extension as follows:</p>
<ul style=3D"list-style-type:&quot;\002014\0000a0\0000a0&quot;">
<li style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot=
;Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-=
alternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-feature-settings:normal"><span style=
=3D"font-size:12px;line-height:normal;font-size-adjust:none;font-kerning:au=
to;font-variant-alternates:normal;font-variant-ligatures:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-feature-settings:norma=
l"></span>When Zvfbfa is enabled:</li>
<ul style=3D"list-style-type:&quot;\002014\0000a0\0000a0&quot;">
<li style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot=
;Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-=
alternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-feature-settings:normal"><span style=
=3D"font-size:12px;line-height:normal;font-size-adjust:none;font-kerning:au=
to;font-variant-alternates:normal;font-variant-ligatures:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-feature-settings:norma=
l"></span>The reserved field in the VTYPE CSR: from bit 9 (VTYPE_RESERVED) =
to XLEN</li>
</ul>
<li style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot=
;Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-=
alternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-feature-settings:normal"><span style=
=3D"font-size:12px;line-height:normal;font-size-adjust:none;font-kerning:au=
to;font-variant-alternates:normal;font-variant-ligatures:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-feature-settings:norma=
l"></span>When Zvfbfa is not enabled:</li>
<ul style=3D"list-style-type:&quot;\002014\0000a0\0000a0&quot;">
<li style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot=
;Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-=
alternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-feature-settings:normal"><span style=
=3D"font-size:12px;line-height:normal;font-size-adjust:none;font-kerning:au=
to;font-variant-alternates:normal;font-variant-ligatures:normal;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-feature-settings:norma=
l"></span>The reserved field in the VTYPE CSR: from bit 8 (VTYPE_ALTFMT) to=
 XLEN</li>
</ul>
</ul>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal;min-height:15px=
"><br></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal">PS: This commi=
t also modifies the definition of VTYPE_RESERVED.</p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal">Because the ED=
IV extension is not planned to be part of the base V extension. Therefore, =
this commit modifies the default RESERVED field definition.</p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal;min-height:15px=
"><br></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal">Reference: <a =
href=3D"https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc"=
>https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc</a></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal;min-height:15px=
"><br></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal">Thanks,</p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-a=
lternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-feature-settings:normal">Max</p>
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex">=C2=A0<br></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return reserved;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulo=
ng s1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong s2, target_ulong x0)<=
br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -41,12 +57,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, tar=
get_ulong s1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t vlmul =3D FIELD_EX64(s2, VTYPE, VLM=
UL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t vsew =3D FIELD_EX64(s2, VTYPE, VSEW)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t sew =3D 8 &lt;&lt; vsew;<br>
&gt; -=C2=A0 =C2=A0 uint8_t ediv =3D FIELD_EX64(s2, VTYPE, VEDIV);<br>
&gt; +=C2=A0 =C2=A0 uint8_t altfmt =3D FIELD_EX64(s2, VTYPE, ALTFMT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int xlen =3D riscv_cpu_xlen(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool vill =3D (s2 &gt;&gt; (xlen - 1)) &amp;=
 0x1;<br>
&gt; -=C2=A0 =C2=A0 target_ulong reserved =3D s2 &amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 xlen - 1 - R_VTYPE_RESERVED_SHIFT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t vlen =3D cpu-&gt;cfg.vlenb &lt;&lt;=
 3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int8_t lmul;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -63,7 +76,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, tar=
get_ulong s1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if ((sew &gt; cpu-&gt;cfg.elen) || vill || (ediv !=3D 0=
) || (reserved !=3D 0)) {<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zvfbfa) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (altfmt =3D=3D 1 &amp;&amp; vsew &gt;=
=3D MO_32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vill =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((sew &gt; cpu-&gt;cfg.elen) || vill || (vtype_reser=
ved(env, s2) !=3D 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* only set vill bit. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;vill =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;vtype =3D 0;<br>
<br>
</blockquote></div></div>

--000000000000dc52ff063f5f4070--

