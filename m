Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2393EE0AF1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 22:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voqaR-0002gJ-Ea; Sat, 07 Feb 2026 17:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqaQ-0002g6-30
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:15:30 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqaO-00009P-8f
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:15:29 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-354c825dc77so379877a91.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 14:15:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770502527; cv=none;
 d=google.com; s=arc-20240605;
 b=k5uEhGSIABv9i7yDkml0kt3tQPqdpvXD7tzehrfi3ipIYX+rJxBRvboX1OIkGxe3eI
 I9vt6Ck5dhCh+Ia1wEAxURkTBQ3DyMFQZg6NE+FzdrG0Z9v+s0li9YIcgbdb7We6KRhr
 XAacFI+aS4kQkZ1oWZzPNym3gHZ2cxjvhmHPRkz9EaXw4Op1Fi3moqXaCusYTgVTWgqs
 jegl+ziq2eqILIaCUg+/IdvRx+TL+d1aoEK79S2N82RN641zgCFLs7jIzGkWJojXXrkH
 Vc6O9CPDlcR1b5rLNp2RoSpKUiL1EmyTG4wuQjzSKBYyqTGcMI/aadEZJZDwmBHLb26D
 lEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WoIiG2xtv+L/l6mYxvuiH3pJxhgy2Gl0IvUda+MGhzw=;
 fh=3m1aKdVwiiAQeDysI/JPLFyw7hm3fA2/ymZW6NmRwXE=;
 b=Eq48YA29FVBxQ3zLNKl1gX9zy+R9YtlCKi+8gtaDR4dEOtSKgYJP5lDSOD8ErcMpHl
 O5IKmJmOQVxhLmiMH+FDAL7xK+DoUxW+ag54bopwMvKOUwSkhNIKafZWtpdN+iZ2SCgi
 r0TNUlzKL6S8yqhdf3NZ+cyMCqSPwRV/F3wx6waDZZofwdNwmj94+uh5jIVxEq3MyXQ2
 U7JNhaRHBgGMD1oOY11o0NJkj6aqtj3ctBtJssBJaVJYCn8jehmlx5BRd/1gL7i4Ul15
 Eq8K9f7baxUybHE+GgmH+HYIPfIcyvBLPlkS1yMFQGm+gEG+a6CYvudPkTiCqb/fB2kd
 lG7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770502527; x=1771107327; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WoIiG2xtv+L/l6mYxvuiH3pJxhgy2Gl0IvUda+MGhzw=;
 b=I00xkF35sCJyTa8evIliWYvwHwyxVFbfBTtQfXzIzi0R665HkfCDZV/lj8OL7VDhML
 aDmoUdh5Wm73+5Zw4Uz6KejtYJvO+Vsk/hL7BZYBQfUQcVMLhWAoEpw1ntLH3UK/BECC
 6NoVuFoTDtLWhzXGrE1c87d5WSQ6P8zHxEj6JibYgOzeQO9cYbPTtW7qWbdFYU8XHYFt
 nR/ZnuhJR+Zp5ROrbcKByCyCgh1BJPGV8W59fGYmetkfNsd+km4e/sY0HWFtzp8y+ihn
 Ww/K7ifzeyrwJOUdaXB+xn/GgmETWJ1H6+QBTmAFaUX2P9evavFGSxB5l03kxcGR+z21
 W9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770502527; x=1771107327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoIiG2xtv+L/l6mYxvuiH3pJxhgy2Gl0IvUda+MGhzw=;
 b=rVknBNz1ae7NMv+f0NjU/CBlIEc61TYzT/Er57sa/18hBURbj5XMUb4fpyUtozofRJ
 HIszWblpzgWQROXx8pEaZsr61E+2ahGcqmlFb9a0QzV6SQoU0MDOOR9EnC/c8RoTIqli
 nt5qjQJF7eZ/xMjhO7w3e60sPz6Zr4P9MJlSTUDzzecNhBhFYYENws7JaFQ0xROkfaNs
 JxfVwnvi/3o0eq//8H0m0Y+eCYotsReY7844oBTRox0JoJblS43Kfw2IsoslQmdChvRl
 6hRxZMmfTuclw4veSjmc/mLYVEJ9m3Ot1rSOSjhj/FpnKabw8Tf+XJuzR/zKnW4bpWCI
 9ZDA==
X-Gm-Message-State: AOJu0Yx68g7GTsJU/o221xHTX1Gq+i5QnWMtFOUFhp+SJDZ4fSvnRmBB
 iyR6nqkAVr5UowmqRtQ/W3vZjjefQSPcgqu5dwCFdtmV+v8VkuADACAq131+qNHzfzqUqteRE88
 g9TyV5vRMC9TmfOzgPqW7vBEi6424xok=
X-Gm-Gg: AZuq6aKExsHIF9Y8JxqeRBUfHd9sLlUS/zasrKlfIsfK5GAHQ4QtFwvJLE4Htcc49mi
 Wkkace7ZIExAwnF36+YSPm+IHix1Evy8n1RZr4b4FwcVhATZVuNZx6L6Sc658gQcTEDC9foQ35p
 VYJ1dNTRUBK6n4k4uX3alV5YUw4kkXqRjenG/659n6tS7egpNfH7i1C3nzPRSDiaLeHH9UIwVfP
 VQ96H8G4NjGasytS5zdxegWcGHV0ggwLc9XvWoT+FYFJb7trphERzWOOyVI7beA64wKC92nC8jh
 9R5qnnhLyzoUOjSFEoq4C1Xt0/s=
X-Received: by 2002:a17:90b:4f49:b0:34c:2f3f:d27e with SMTP id
 98e67ed59e1d1-354b3c52e02mr5575414a91.3.1770502526600; Sat, 07 Feb 2026
 14:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
 <20260207180632.1042754-3-brian.cain@oss.qualcomm.com>
 <CAATN3Noay=pVLA5-d8MMYMLq=QDSwX2zQZwdt1mzA-cjdCV0Eg@mail.gmail.com>
 <CAEqNhNZDSCdVKOTJVWBv7=z3O0a4p-hy1z+GJQn9GJ4hZ8BJkg@mail.gmail.com>
In-Reply-To: <CAEqNhNZDSCdVKOTJVWBv7=z3O0a4p-hy1z+GJQn9GJ4hZ8BJkg@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 7 Feb 2026 15:15:14 -0700
X-Gm-Features: AZwV_QggEQIpmGcQdh1_Ar6vPR6VKvchyvFiehZmVzrwO5m27f6n9DAEVldyUHM
Message-ID: <CAATN3NoO4hdSnb_PseA7WvdD=eL48_K-ispBFm5iwc8VzN2Oiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] target/hexagon: Reject duplex encodings with
 duplicate dest registers
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002c0a72064a433eb4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102b.google.com
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

--0000000000002c0a72064a433eb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 3:04=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> On Sat, Feb 7, 2026 at 3:58=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gma=
il.com>
> wrote:
> >
> >
> >
> > On Sat, Feb 7, 2026 at 11:06=E2=80=AFAM Brian Cain <brian.cain@oss.qual=
comm.com>
> wrote:
> >>
> >> A duplex encoding like 0x00000000 decodes as two loads that both write
> r0.
> >>
> >> Add a check in decode_insns() after both sub-instructions decode
> >> successfully to verify they don't write the same destination register.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2696
> >> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> ---
> >>  target/hexagon/decode.c              | 12 ++++++++++++
> >>  tests/tcg/hexagon/invalid-encoding.c | 29 +++++++++++++++++++++++++++=
+
> >>  2 files changed, 41 insertions(+)
> >>
> >> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> >> index 69ba1ec96c..90499fc320 100644
> >> --- a/target/hexagon/decode.c
> >> +++ b/target/hexagon/decode.c
> >> @@ -501,12 +501,24 @@ decode_insns(DisasContext *ctx, Insn *insn,
> uint32_t encoding)
> >>
> >>          /* The slot1 subinsn needs to be in the packet first */
> >>          if (decode_slot1_subinsn(ctx, slot1_subinsn)) {
> >> +            Insn *slot1_insn =3D insn;
> >>              insn->generate =3D opcode_genptr[insn->opcode];
> >>              insn->iclass =3D iclass_bits(encoding);
> >>              ctx->insn =3D ++insn;
> >>              if (decode_slot0_subinsn(ctx, slot0_subinsn)) {
> >>                  insn->generate =3D opcode_genptr[insn->opcode];
> >>                  insn->iclass =3D iclass_bits(encoding);
> >> +                /*
> >> +                 * Check that the two sub-instructions don't write th=
e
> same
> >> +                 * destination register (e.g., encoding 0x0 decodes a=
s
> two
> >> +                 * loads both writing R0, which is an invalid packet)=
.
> >> +                 */
> >> +                if (insn->dest_idx >=3D 0 && slot1_insn->dest_idx >=
=3D 0 &&
> >> +                    insn->regno[insn->dest_idx] =3D=3D
> >> +                        slot1_insn->regno[slot1_insn->dest_idx]) {
> >> +                    ctx->insn =3D --insn;
> >> +                    return 0;
> >> +                }
> >>
> > Isn't this a more general problem than what is checked here?  What if
> two non-duplex instructions write the same register?  What if an
> instruction writes more than one register (e.g., post-increment load)?
>
> It is, yeah.  I mentioned in the cover letter that I planned to land that
> later.
>
> But ok -- I can move it here into this series.
>

Sorry, I missed that comment in the cover letter.

Taylor

--0000000000002c0a72064a433eb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Feb 7, =
2026 at 3:04=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Sat, Feb 7, 2026 at 3:58=E2=80=AFP=
M Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com" target=3D"=
_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Sat, Feb 7, 2026 at 11:06=E2=80=AFAM Brian Cain &lt;<a href=3D"mail=
to:brian.cain@oss.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.c=
om</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; A duplex encoding like 0x00000000 decodes as two loads that both w=
rite r0.<br>
&gt;&gt;<br>
&gt;&gt; Add a check in decode_insns() after both sub-instructions decode<b=
r>
&gt;&gt; successfully to verify they don&#39;t write the same destination r=
egister.<br>
&gt;&gt;<br>
&gt;&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues=
/2696" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/issues/2696</a><br>
&gt;&gt; Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt;&gt; Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvi=
er@linaro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 12 ++++++++++++<br>
&gt;&gt;=C2=A0 tests/tcg/hexagon/invalid-encoding.c | 29 ++++++++++++++++++=
++++++++++<br>
&gt;&gt;=C2=A0 2 files changed, 41 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
&gt;&gt; index 69ba1ec96c..90499fc320 100644<br>
&gt;&gt; --- a/target/hexagon/decode.c<br>
&gt;&gt; +++ b/target/hexagon/decode.c<br>
&gt;&gt; @@ -501,12 +501,24 @@ decode_insns(DisasContext *ctx, Insn *insn, =
uint32_t encoding)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The slot1 subinsn needs to be=
 in the packet first */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (decode_slot1_subinsn(ctx, sl=
ot1_subinsn)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *slot1_insn =3D in=
sn;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insn-&gt;generate =
=3D opcode_genptr[insn-&gt;opcode];<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insn-&gt;iclass =
=3D iclass_bits(encoding);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;insn =3D +=
+insn;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (decode_slot0_s=
ubinsn(ctx, slot0_subinsn)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insn=
-&gt;generate =3D opcode_genptr[insn-&gt;opcode];<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insn=
-&gt;iclass =3D iclass_bits(encoding);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* C=
heck that the two sub-instructions don&#39;t write the same<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* d=
estination register (e.g., encoding 0x0 decodes as two<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* l=
oads both writing R0, which is an invalid packet).<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-=
&gt;dest_idx &gt;=3D 0 &amp;&amp; slot1_insn-&gt;dest_idx &gt;=3D 0 &amp;&a=
mp;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 insn-&gt;regno[insn-&gt;dest_idx] =3D=3D<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 slot1_insn-&gt;regno[slot1_insn-&gt;dest_idx]) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ctx-&gt;insn =3D --insn;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt; Isn&#39;t this a more general problem than what is checked here?=C2=A0=
 What if two non-duplex instructions write the same register?=C2=A0 What if=
 an instruction writes more than one register (e.g., post-increment load)?<=
br>
<br>
It is, yeah.=C2=A0 I mentioned in the cover letter that I planned to land t=
hat later.<br>
<br>
But ok -- I can move it here into this series.<br></blockquote><div><br></d=
iv><div>Sorry, I missed that comment in the cover letter.</div><div><br></d=
iv><div>Taylor</div><div>=C2=A0</div></div></div>

--0000000000002c0a72064a433eb4--

