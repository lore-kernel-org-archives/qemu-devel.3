Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70B9FEC0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56nr-0002xq-Qj; Tue, 24 Mar 2026 14:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w56np-0002xG-J5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:48:33 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w56nm-0005Ls-2z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:48:33 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so2802369a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774378107; cv=none;
 d=google.com; s=arc-20240605;
 b=QjmXf9zm20DtIwYUqlqJkIetG9zwZ0QZsKYoufyAs272uUqWbkUZ0P5XkrfpQ5fLHz
 /8MrzUBuUkgJkIxp8mK+DArMozfSkrXV4EGO68/orD0NUF6UTwHYrcbUVWbZs12WCZt3
 TRi1OzDcPO6q3ReQJ84qNgEJx48yNlT2mQgyqIbEzEq6K+kySkX5ZYk6sMDOvQIIQc2X
 F9NpAvKw0FwufXxHf/Rhzn1ZIOkGNUY70zwiJPruDDKhEJDqnIX2KCpe24jHY0mPYWJy
 JYzZBKKjNjhzaDAJHBo/XFsDxNo2v9C7vPY5ShAMmOPW04RF8Iu2+x8usEIndyPuhBpq
 cZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SMtu+PT9U1xNjtLQ8Saimav8l/U7UHCC4CwPez3Zgic=;
 fh=fJqGvtWqLDKIzOXW1wAsc3/gnAi5Otjc7uqp16gUscQ=;
 b=ZPib91uMPzfU9o6BYx3tb5cOs5lkXDmlsLrmWQoYvnph41kLgmSjPb5gfNN4/13i8x
 W1Mz6W6gLVyCWuBJiiKlSdCOHjfS9IHt275F6hrg5+n7oxLFKqZKPNTRM6Z68GQL6K9l
 Kq6QlgfSYcU1neMPMBOynlbPKJ863IfFGEzv9OKJ4uxRIWBMFhkVY5+OgQwj+7FojWSz
 iz7b+ToTwOThKOqhyzxg2Wzt+NHStA1MEFdIcO4S0DT78WZj+Hkt7WCqbJec7RNv8jdL
 ZE6BqbxdTSb21Iw/rHTwUn509UXAG6raLojhHivw1TxzQdeGSbkPCyAAQlBfbWJGhm66
 bUAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774378107; x=1774982907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SMtu+PT9U1xNjtLQ8Saimav8l/U7UHCC4CwPez3Zgic=;
 b=AOD3teWVtWPHkRldv8TWKbEc2h0YEsLfl53JjHjApVeHxs67uG2mhPTdjGorXSw8yF
 li2FeAjoP1TDrwKxKxzkniQQX+StxQSoyocsB5d9r4hTX7VFueYhqnupH9oxIN5XLA+B
 tONHaVw3QFmytTQzsaOeuZfl82HRpEbZhto+ioerUWZsRjsBxBA1/w3cEeB4lJzcbYut
 tx4lBoUHOxdzliF39OyyuDk66dvT/EtuC4RMBpU1jdzI78x44k+3JztJh7qkOzTiYkYs
 +ulN2c00Lw1mYUkqI+fP4yJWyz0o/KY5jNxg8BYrJYCyVmmrl+3mSl+pIaH8HzaOojLF
 neHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774378107; x=1774982907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMtu+PT9U1xNjtLQ8Saimav8l/U7UHCC4CwPez3Zgic=;
 b=HKV0Jv7DtmwJS+j/NKZpp2nO8ek8NLvPazDLx/wDl10SrYpOWJpzs4+SWYJIKpPcJm
 yKjKdhUsmAqAlxAdFnWVKegTk5F16T41Ww/95/U9audLf9cbvdZ7VHxHI4wmoG9jKHWX
 JYTH4T3fa96afYrSe4PX2CCejGBzdPP6QhoiDRaadWnwesc2bTQx9k552FwlTWNneQui
 nZ2m5qfzEemWmBldyX5mJmkyIRzpC1xa6m2d7L5hUdaDQ0eJ8axyHXjk+GCLPJ1SRBJP
 sA4OXfxGJ2B/A5+cWNYqGoRVqTR5V1e/uLsKX/22/9C+pDIoa13b9OH0U1LuM7tYIZ+1
 oxbw==
X-Gm-Message-State: AOJu0Yz129EDihAL0oR5D6X35862KIcp9hYIS4f8SXttkV/qpHLoKji2
 dtCxgesAxGfDK7X4ApFdkHu2lH+z0jz0z6KjfwhvI9VicFTd3ksBpYTn3P26aDHMTPWpYyM7akW
 VyXfgEj+Oh6olYo52skOrDBprWRAsRg8=
X-Gm-Gg: ATEYQzyV4gVyX+PfbE1Y7Gp/7gZhKW6Doo/prqV1wWIqoEN54Yzd4A5hphxcIyFvebL
 D0Z1ya2rTLGpJHSmegD709BYmE5mVTDI1kM+ADXD4bqTlcENf64taN43IIc0SKd+AmYSrlLE2KX
 abGVelu+LuppXhom0nnMDmF0nmN1ypZbZEHmlvtU9m04zn1aUzI8qE57Rmgsnmr3+tFi3h4lN6I
 h3AWZ635W4qM/AANKYrdXXZJC/7/U7x5Xr3pM6k97yDUAI41IFQQbs2//LJyTXvQJGSGLi9AGom
 T3khmHJm2gXfcUG3WQwVQ3k7puwQ/I2ih9tb5CY=
X-Received: by 2002:a17:90b:1b43:b0:35b:e4d5:dc71 with SMTP id
 98e67ed59e1d1-35c0dcd49e6mr416442a91.14.1774378107194; Tue, 24 Mar 2026
 11:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrTa3qL1jZew7_3L2mfeK2PT3RFTkTDxQUZ_4NK7wAmAw@mail.gmail.com>
 <CABrGZ+GiQ-KiJVhyCHK4EfG__4=mbJhj1rhpfczASuQ+NT9-BQ@mail.gmail.com>
In-Reply-To: <CABrGZ+GiQ-KiJVhyCHK4EfG__4=mbJhj1rhpfczASuQ+NT9-BQ@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 12:48:16 -0600
X-Gm-Features: AaiRm516I1a9ZtUtxk5TSceG2lxXIs1vUYJMftU3zywIgSK8el46VBfI8CaWsAo
Message-ID: <CAATN3Nq+BSfAFrCfFEfsOWaSt2JsHC4hVm+K5hJts-iAF83wTg@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/hexagon/cpu: add HVX IEEE FP extension
To: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000c6cfe9064dc99837"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1032.google.com
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

--000000000000c6cfe9064dc99837
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:52=E2=80=AFAM Matheus Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> On Mon, Mar 23, 2026 at 4:33=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
> >
> >
> >
> > On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com> wrote:
> >>
> >> This flag will be used to control the HVX IEEE float instructions, whi=
ch
> >> are only available at some Hexagon cores. When unavailable, the
> >> instruction is essentially treated as a no-op.
> >>
> >> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> >> ---
> >>  target/hexagon/cpu.h             |  1 +
> >>  target/hexagon/translate.h       |  1 +
> >>  target/hexagon/attribs_def.h.inc |  3 +++
> >>  target/hexagon/cpu.c             |  1 +
> >>  target/hexagon/decode.c          | 22 ++++++++++++++++++++++
> >>  target/hexagon/translate.c       |  1 +
> >>  6 files changed, 29 insertions(+)
> >>
> >>
> >> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> >> index dbc9c630e8..d832a64a17 100644
> >> --- a/target/hexagon/decode.c
> >> +++ b/target/hexagon/decode.c
> >> @@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pkt)
> >>      return !bitmap_empty(conflict, 32);
> >>  }
> >>
> >> +static void convert_to_nop(Insn *insn)
> >> +{
> >> +    bool is_endloop =3D insn->is_endloop;
> >> +    memset(insn, 0, sizeof(*insn));
> >> +    insn->opcode =3D A2_nop;
> >> +    insn->new_read_idx =3D -1;
> >> +    insn->dest_idx =3D -1;
> >> +    insn->generate =3D opcode_genptr[insn->opcode];
> >> +    insn->iclass =3D 0b111;
> >> +    insn->is_endloop =3D is_endloop;
> >> +}
> >> +
> >>  /*
> >>   * decode_packet
> >>   * Decodes packet with given words
> >> @@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int
> max_words, const uint32_t *words,
> >>          /* Ran out of words! */
> >>          return 0;
> >>      }
> >> +
> >> +    /* Disable HVX IEEE instruction if extension is disabled. */
> >> +    if (!ctx->ieee_fp_extension) {
> >> +        for (i =3D 0; i < num_insns; i++) {
> >> +            if (GET_ATTRIB(pkt->insn[i].opcode, A_HVX_IEEE_FP)) {
> >> +                convert_to_nop(&pkt->insn[i]);
> >> +            }
> >> +        }
> >> +    }
> >> +
> >
> >
> > Better to leave the instruction alone and turn it into a nop by not
> generating any TCG.
> >
> > That way, the disassembly (-d in_asm) will still show what's actually i=
n
> the binary.  You could add the check in gen_tcg_funcs.py.
> >
> > You could also consider adding some sort of marker in the disassembly t=
o
> indicate that the flag is needed for the instruction to do anything.
>
> Ah, good idea. Will do both for the next round, thanks.
>

Note that we'll need to be careful with packets that use the result vector
in a .new context.  For example
    { V0.sf =3D vadd(V1.sf,V2.sf)
      vmem(R19+#0x0) =3D V0.new }
The problem is that the store wants to read the value from future_VRegs.
However, if the vadd is  nop, there is junk in future_VRegs.  So, we'll
either have to get the store to read from the real VRegs or have the vadd
copy the old value of the destination into the future_VRegs value.  The
first option will be more efficient because it will avoid the vector copy.

We should also add a test to fp_hvx_disabled for this case.

HTH,
Taylor

--000000000000c6cfe9064dc99837
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 10:52=E2=80=AFAM Matheus Bernardino &lt;<a href=3D"mailto:matheus.=
bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Mar=
 23, 2026 at 4:33=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsi=
mpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino &lt=
;<a href=3D"mailto:matheus.bernardino@oss.qualcomm.com" target=3D"_blank">m=
atheus.bernardino@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; This flag will be used to control the HVX IEEE float instructions,=
 which<br>
&gt;&gt; are only available at some Hexagon cores. When unavailable, the<br=
>
&gt;&gt; instruction is essentially treated as a no-op.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:ma=
theus.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss=
.qualcomm.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 1 +<br>
&gt;&gt;=C2=A0 target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 1 +<br>
&gt;&gt;=C2=A0 target/hexagon/attribs_def.h.inc |=C2=A0 3 +++<br>
&gt;&gt;=C2=A0 target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 1 +<br>
&gt;&gt;=C2=A0 target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
22 ++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 1 +<br>
&gt;&gt;=C2=A0 6 files changed, 29 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
&gt;&gt; index dbc9c630e8..d832a64a17 100644<br>
&gt;&gt; --- a/target/hexagon/decode.c<br>
&gt;&gt; +++ b/target/hexagon/decode.c<br>
&gt;&gt; @@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pk=
t)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return !bitmap_empty(conflict, 32);<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +static void convert_to_nop(Insn *insn)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 bool is_endloop =3D insn-&gt;is_endloop;<br>
&gt;&gt; +=C2=A0 =C2=A0 memset(insn, 0, sizeof(*insn));<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;opcode =3D A2_nop;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;new_read_idx =3D -1;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;dest_idx =3D -1;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;generate =3D opcode_genptr[insn-&gt;opcode=
];<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;iclass =3D 0b111;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;is_endloop =3D is_endloop;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 /*<br>
&gt;&gt;=C2=A0 =C2=A0* decode_packet<br>
&gt;&gt;=C2=A0 =C2=A0* Decodes packet with given words<br>
&gt;&gt; @@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int max_=
words, const uint32_t *words,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ran out of words! */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Disable HVX IEEE instruction if extension is dis=
abled. */<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!ctx-&gt;ieee_fp_extension) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; num_insns; i++) =
{<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GET_ATTRIB(pkt-&gt;=
insn[i].opcode, A_HVX_IEEE_FP)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 convert_t=
o_nop(&amp;pkt-&gt;insn[i]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;<br>
&gt;<br>
&gt; Better to leave the instruction alone and turn it into a nop by not ge=
nerating any TCG.<br>
&gt;<br>
&gt; That way, the disassembly (-d in_asm) will still show what&#39;s actua=
lly in the binary.=C2=A0 You could add the check in gen_tcg_funcs.py.<br>
&gt;<br>
&gt; You could also consider adding some sort of marker in the disassembly =
to indicate that the flag is needed for the instruction to do anything.<br>
<br>
Ah, good idea. Will do both for the next round, thanks.<br></blockquote><di=
v><br></div><div>Note that we&#39;ll need to be careful with packets that u=
se the result vector in a .new context.=C2=A0 For example</div><div>=C2=A0 =
=C2=A0 {	V0.sf =3D vadd(V1.sf,V2.sf)<br>=C2=A0 =C2=A0 =C2=A0 vmem(R19+#0x0)=
 =3D V0.new }</div><div>The problem is that the store wants to read the val=
ue from future_VRegs.=C2=A0 However, if the vadd is=C2=A0 nop, there is jun=
k in future_VRegs.=C2=A0 So, we&#39;ll either have to get the store to read=
 from the real VRegs or have the vadd copy the old value of the destination=
 into the future_VRegs value.=C2=A0 The first option will be more efficient=
 because it will avoid the vector copy.</div><div><br></div><div>We should =
also add a test to fp_hvx_disabled for this case.</div><div><br></div><div>=
HTH,</div><div>Taylor</div></div></div>

--000000000000c6cfe9064dc99837--

