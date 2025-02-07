Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBF1C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 02:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgEHT-0005He-To; Thu, 06 Feb 2025 21:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tgEHQ-0005Gd-Fe; Thu, 06 Feb 2025 21:39:44 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tgEHO-00005n-AI; Thu, 06 Feb 2025 21:39:44 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5de4c7720bcso15229a12.0; 
 Thu, 06 Feb 2025 18:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738895980; x=1739500780; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8XlNkNs/hW098c9OGj+Y5ih0rxT7wYNs1pxlwpJQjtc=;
 b=A37bkVIIL3XEq7GD0rTixC087rJvEEaFZcRbH87ZFWBkK+tyPTQj7HA+aJVPUeM2bR
 u5RLNIz8qElU1x4TzGlb6yrzA4WcFAb9D728lOJREaC6PvkEV7CmenmFUqRUqod3NB+I
 6T9i9n7BVTXD1+WsX3nIHI31CVJhjup7Prw8lDXBrMi9ryGKxpQeedLHBQx6VPetNLIl
 0BQ+JKoiqegQkP35c3DVm3t7MZ9dBq0jgGmPi3Ao5d21tmxSby38ZDyJuZNwxfbt5ROm
 EcwHq+pPt7Q0RIx/tW6y1kvMVc0aP/7v3dLboNWT6OZrb7X/uhPWNqrUGq6AJgqDaFp+
 hLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738895980; x=1739500780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XlNkNs/hW098c9OGj+Y5ih0rxT7wYNs1pxlwpJQjtc=;
 b=qQ9KFGRWS/+gp+CBYu7eKZWbEeFfnf0UjjLooSZlCRNLIQIrGOdbTBsYe/xWuXpFvd
 8/hpAywAbsuLG5veYTax+/Lc+98znkVnx1+ktYe5ahPURHqaXGYVLyae/5+eOOp0f1ST
 bwiLBy4NGyORWb/jn0r7UajTm6y8gG3HPar6PE5L3NF9jH90Opal/dp1iV2lFIg0SHlW
 k7wEG3u3JmNl2aJFLDfcvR/K/xg1okMXDH362yV2kO9CbIRhru31OQzMu0kntQP9ppSW
 ST6ahqd4Stf/VDGWDfAFKrcuKRdZz539VoFK/FZq/VHylAapUHJ5F5lVp0nvx0RBKC6e
 dBpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9oVgMF30aBE/VTXvcUzTn7XMINHlT/0KDOzNfcT3vry4sjrlt9VFysBVuqUyCin8PlkKvBO5Nn3xf/g==@nongnu.org,
 AJvYcCXpZYWCszq+P9eYBbhF6Oo2Y7iEQHgNtxBiVyxHMa16i2sXb+kXhKGHyNySeYrP7JOSJ/pkefw2Ig==@nongnu.org
X-Gm-Message-State: AOJu0YxsZvI6RJ2Xe8xEEa4p/RpLpqCF1gyreZwgquIs6EteKQDiS+31
 oyyW5POGL7Y6/hKjJvr/5rEJ6mc3SjDxhXWwE9FA8BP4k2YdQo36vVykHJx9re5IJLF9Uovbmbp
 TAyV1nnaFdG6xelNSoSJKT1Xu3SQ=
X-Gm-Gg: ASbGncuMMio9b4Bcac+dNPYO/azg2p26ryI40E0FE0mSE7XAmZGnNcqQFVz3kK//ecb
 nxezsMDeY0ED6eRP4PsxL0I0oRQHGZQtv3ocuvGxLW+H76lbPkkG1rtdKI8wBCZXkxeZY3XFq3b
 I=
X-Google-Smtp-Source: AGHT+IGmwlhq5LdPrG7ZRpTKd8DFRLhqST84b9hDOFtB+Z4Vaw+exobh95fyN7zmY0CPQV4LysXpTCJXFzx5fOPtqVo=
X-Received: by 2002:a05:6402:2186:b0:5dc:db28:6afc with SMTP id
 4fb4d7f45d1cf-5de44e5f09amr1781938a12.0.1738895980288; Thu, 06 Feb 2025
 18:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
 <CAFEAcA96ZLjOhBT9rhNhuk32ve0Qv4hUVuTTtgE=DBApbN98Pg@mail.gmail.com>
 <CAJy5ezovedShKH=HFbK9uRY44no2ijQocs29CHLt2jKoNL+Vpw@mail.gmail.com>
 <CAFEAcA8oaRVs8USMDGHvDW82AtRZGAhRCg189hhWtmRm2Y-YaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8oaRVs8USMDGHvDW82AtRZGAhRCg189hhWtmRm2Y-YaQ@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 6 Feb 2025 20:39:29 -0600
X-Gm-Features: AWEUYZkTuMwuyatggAhCHe9X5WWgRk7lvGsuQ_A2TDqn4rCZLv0zKPA6IRCcFbg
Message-ID: <CAJy5ezpS+wMdXSZU4SH+DoGr2jd4k4gAj3NJXcWKAHa4a6dpjw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, philmd@linaro.org,
 alistair@alistair23.me, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000034df7e062d844527"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000034df7e062d844527
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 at 08:37, Peter Maydell <peter.maydell@linaro.org> wrote=
:

> On Thu, 30 Jan 2025 at 22:31, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
> > On Mon, Jan 27, 2025 at 8:40=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> >> On Thu, 19 Dec 2024 at 06:17, Andrew.Yuan <andrew.yuan@jaguarmicro.com=
>
> wrote:
> >> > -            rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
> >> > -            mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0,
> MASK_VALUE);
> >> > -            compare =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0,
> COMPARE_VALUE);
> >> > +            disable_mask =3D
> >> > +                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1,
> DISABLE_MASK);
> >> > +            if (disable_mask) {
> >> > +                /*
> >> > +                 * If disable_mask is set,
> >> > +                 * mask_value is used as an additional 2 byte
> Compare Value.
> >> > +                 * To simple, set mask =3D 0xFFFFFFFF, if disable_m=
ask
> is set.
> >> > +                 */
> >> > +                rx_cmp =3D ldl_le_p(rxbuf_ptr + offset);
> >> > +                mask =3D 0xFFFFFFFF;
> >> > +                compare =3D cr0;
> >> > +            } else {
> >> > +                rx_cmp =3D lduw_le_p(rxbuf_ptr + offset);
> >>
> >> Is the change in behaviour in the !disable_mask codepath here
> >> intentional? Previously we use one byte from rxbuf_ptr[offset],
> >> duplicated into both halves of rx_cmp; now we will load two
> >> different bytes from rxbuf_ptr[offset] and rxbuf_ptr[offset + 1].
> >>
> >> If this is intended, we should say so in the commit message.
> >>
> >
> > I agree that it should be mentioned (looks like a correct bugfix).
>
> Thanks. I've expanded the commit message:
>
>     hw/net/cadence_gem:  Fix the mask/compare/disable-mask logic
>
>     Our current handling of the mask/compare logic in the Cadence
>     GEM ethernet device is wrong:
>      (1) we load the same byte twice from rx_buf when
>          creating the compare value
>      (2) we ignore the DISABLE_MASK flag
>
>     The "Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev:
>     R1p12 - Doc Rev: 1.3 User Guide" states that if the DISABLE_MASK bit
>     in type2_compare_x_word_1 is set, the mask_value field in
>     type2_compare_x_word_0 is used as an additional 2 byte Compare Value.
>
>     Correct these bugs:
>      * in the !disable_mask codepath, use lduw_le_p() so we
>        correctly load a 16-bit value for comparison
>      * in the disable_mask codepath, we load a full 4-byte value
>        from rx_buf for the comparison, set the compare value to
>        the whole of the cr0 register (i.e. the concatenation of
>        the mask and compare fields), and set mask to 0xffffffff
>        to force a 32-bit comparison
>
> and also tweaked the comment a bit:
>
> +                /*
> +                 * If disable_mask is set, mask_value is used as an
> +                 * additional 2 byte Compare Value; that is equivalent
> +                 * to using the whole cr0 register as the comparison
> value.
> +                 * Load 32 bits of data from rx_buf, and set mask to
> +                 * all-ones so we compare all 32 bits.
> +                 */
>
> and applied this to target-arm.next.
>
> > Other than that this patch looks good to me!
>
> Can I call that a Reviewed-by (with the above changes)?


Yes, thanks!!



>
> thanks
> -- PMM
>

--00000000000034df7e062d844527
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br></div><div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 4 Feb 2025 at 08:3=
7, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;padding-left:1ex;border-left-color:rgb(204,204,204)">On Thu, 30 Jan 2025=
 at 22:31, Edgar E. Iglesias<br>
&lt;<a href=3D"mailto:edgar.iglesias@gmail.com" target=3D"_blank">edgar.igl=
esias@gmail.com</a>&gt; wrote:<br>
&gt; On Mon, Jan 27, 2025 at 8:40=E2=80=AFAM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt; On Thu, 19 Dec 2024 at 06:17, Andrew.Yuan &lt;<a href=3D"mailto:an=
drew.yuan@jaguarmicro.com" target=3D"_blank">andrew.yuan@jaguarmicro.com</a=
>&gt; wrote:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D rxbuf_p=
tr[offset] &lt;&lt; 8 | rxbuf_ptr[offset];<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D FIELD_EX3=
2(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compare =3D FIELD_=
EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_mask =3D<b=
r>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FIEL=
D_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (disable_mask) =
{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<b=
r>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* If disable_mask is set,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* mask_value is used as an additional 2 byte Compare Value.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* To simple, set mask =3D 0xFFFFFFFF, if disable_mask is set.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_c=
mp =3D ldl_le_p(rxbuf_ptr + offset);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask=
 =3D 0xFFFFFFFF;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 comp=
are =3D cr0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_c=
mp =3D lduw_le_p(rxbuf_ptr + offset);<br>
&gt;&gt;<br>
&gt;&gt; Is the change in behaviour in the !disable_mask codepath here<br>
&gt;&gt; intentional? Previously we use one byte from rxbuf_ptr[offset],<br=
>
&gt;&gt; duplicated into both halves of rx_cmp; now we will load two<br>
&gt;&gt; different bytes from rxbuf_ptr[offset] and rxbuf_ptr[offset + 1].<=
br>
&gt;&gt;<br>
&gt;&gt; If this is intended, we should say so in the commit message.<br>
&gt;&gt;<br>
&gt;<br>
&gt; I agree that it should be mentioned (looks like a correct bugfix).<br>
<br>
Thanks. I&#39;ve expanded the commit message:<br>
<br>
=C2=A0 =C2=A0 hw/net/cadence_gem:=C2=A0 Fix the mask/compare/disable-mask l=
ogic<br>
<br>
=C2=A0 =C2=A0 Our current handling of the mask/compare logic in the Cadence=
<br>
=C2=A0 =C2=A0 GEM ethernet device is wrong:<br>
=C2=A0 =C2=A0 =C2=A0(1) we load the same byte twice from rx_buf when<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creating the compare value<br>
=C2=A0 =C2=A0 =C2=A0(2) we ignore the DISABLE_MASK flag<br>
<br>
=C2=A0 =C2=A0 The &quot;Cadence IP for Gigabit Ethernet MAC Part Number: IP=
7014 IP Rev:<br>
=C2=A0 =C2=A0 R1p12 - Doc Rev: 1.3 User Guide&quot; states that if the DISA=
BLE_MASK bit<br>
=C2=A0 =C2=A0 in type2_compare_x_word_1 is set, the mask_value field in<br>
=C2=A0 =C2=A0 type2_compare_x_word_0 is used as an additional 2 byte Compar=
e Value.<br>
<br>
=C2=A0 =C2=A0 Correct these bugs:<br>
=C2=A0 =C2=A0 =C2=A0* in the !disable_mask codepath, use lduw_le_p() so we<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0correctly load a 16-bit value for comparison<br>
=C2=A0 =C2=A0 =C2=A0* in the disable_mask codepath, we load a full 4-byte v=
alue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0from rx_buf for the comparison, set the compare =
value to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0the whole of the cr0 register (i.e. the concaten=
ation of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0the mask and compare fields), and set mask to 0x=
ffffffff<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0to force a 32-bit comparison<br>
<br>
and also tweaked the comment a bit:<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If disable=
_mask is set, mask_value is used as an<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* additional=
 2 byte Compare Value; that is equivalent<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to using t=
he whole cr0 register as the comparison value.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Load 32 bi=
ts of data from rx_buf, and set mask to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* all-ones s=
o we compare all 32 bits.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
<br>
and applied this to target-arm.next.<br>
<br>
&gt; Other than that this patch looks good to me!<br>
<br>
Can I call that a Reviewed-by (with the above changes)?</blockquote><div di=
r=3D"auto"><br></div><div dir=3D"auto">Yes, thanks!!</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;padding-left:1ex;border-left-color:rgb(204,204,204)" dir=3D"auto"><br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--00000000000034df7e062d844527--

