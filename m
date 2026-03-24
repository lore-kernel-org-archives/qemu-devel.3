Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F80AFEC102
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57iP-0001QZ-Lk; Tue, 24 Mar 2026 15:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57iJ-0001Ng-C8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:46:55 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57iH-0000Kh-6D
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:46:55 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35a1cc6e478so960132a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774381612; cv=none;
 d=google.com; s=arc-20240605;
 b=G1FpNkZyp3R/phf/lhvhp3OulLLakSlZhITJpyH0whG5fShtUr0aaUqlm1cC2+fFOJ
 g0M+gu4uh1uZBmEasguRivMjim+ENqUAc8pNgzlq6NjTbHSX7xcT2i/TNJwKGbIsg7T2
 O9JfVMst3bF0sNXj+Yl1vVVMJRiQkxa/60HYt/dDmA4FuaB69Po7DbbJnBfoKkx/NQcm
 T7z7i7ypDxVy+B13TLNpHaL3OtmFzWTJSfsBAMgpZqkD8uV+L6UyrTtiYXmE8yWcTfcT
 V/0/2hrqeKKUixizsqmZ7bIyuXB9G+3QcSIQnVd3PIA9lN7ycHbZzmdc2Ti3PUEiiE7y
 /8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a1OFOF77xDCOfi3DoV4nV3Ha1Vww9Uz6tXDEjfqsXHc=;
 fh=+V8Hvb356hko0oUSWIY2sa7V9+Sar45DZIQZO+tNVJA=;
 b=cHw30TsvXiNbHcfrg//pVSSeHZ6BSw0+x5Ahs70f3R4JeznKzKhJ8yebSgtYmXN42Q
 JJ4zvW2Opl+EYD4jqth71pYqyk4HZhSrvBib1I0CsiioD0II7OnGC1c6lXDN4dc11zyj
 ArI7kyIPdhebc9TpVhaq16eIj+b7wz7BijbQxUFNgpCOV8a9lzyAeBBo349kmQhQ9JfT
 EnrFFjGGr3vdNC0yDo9qTQAcjL1cwHCGe5EXvkf+TeyrpzjdtzymbWS4mBmH83XNrD0l
 yw5o5W6qzXie9qsjTJvFMlMoykd5YKh291RURtnvKEhd71giwrZBNXpAkBJnmZoXzt8m
 5ZnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774381612; x=1774986412; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a1OFOF77xDCOfi3DoV4nV3Ha1Vww9Uz6tXDEjfqsXHc=;
 b=QbcGG+1hQ30sLHLRphq2OU+0Njw03ixgIQeGUwuqzSftPKf/u3CKZO4OZBUlGXQ7Vz
 oo1K69fRuH9AoluAVTqP+OmeXrFDJL0Ekr6lxQKF2mwEb+h02dMJ6FXxdOV88pIIhS86
 GU0abUyJ8OHAZwVEfpZzJcLN2GD9nZr/bnn5H7o7t3cpfRwyTGHym30GmCqyhv7MX9sz
 FShIBe0SolfMHSMc+TKnDdIQVA18cyaj0mZFz5B1Ko2RtWAbvE5hkq7f8opmlv1wGjjN
 CygZy7ZzJLrMTWufToNt26jrkoDdUwp/sCN/IPXWuElbkEbuvsjQxyjMACSQ1vcdZTlP
 1K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381612; x=1774986412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1OFOF77xDCOfi3DoV4nV3Ha1Vww9Uz6tXDEjfqsXHc=;
 b=F8Qa+5RuypKi/zXdtsGxuNFbQFbRg/lNkLm8D4Su8y84Zp78tlw7LvraKKNbyKhaPR
 1RX8Jswr/TOirHLq7aA6EwicGq80moF1QWBsv8Vyd/9nvueBq/19w2BDgjwJVBxq/8sD
 VVDZhzei2aTL8D+vbABxVQpj7cRlBcOTd/r/aGd2rADxCi4fxDp6wa8JGEuWZDNFMj49
 Q6G21j0ZupTP+PnGzvUp3Dbt4YAyj/9UOZaeRFWSV6xgXJ6MaSKyf4Zg6bg0snN3H00u
 vfHIbhpCIHJZ1zVq8a119JKd7tm+uw0h59pBad3sdyCOIXZE0RYeTZ8JAosYUPdv5bs5
 TnUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa4ADF0AwJ7xAdzv935bIn3lvkGGGfIg8tyly1f4FdCiCSNJZjseytvO9Q0laU3X1AXFwPqOuDF9ki@nongnu.org
X-Gm-Message-State: AOJu0YwUK9hIYpsA3wCEccWRFA+/nbrKZceXWcQ032LGVuiZIhqz66qT
 5GMtdfkANOCHe7TW8Jhc6l/H3c4zdDc8mOkOr6iA1ES1bd58QmoapTQC2XdEspA47GQUZ3frK5C
 XR5KYA3NeFduqL/+BSX73TQPQPsSEH2RE0w2k
X-Gm-Gg: ATEYQzyfo4ksrM4O9uM4epeWvzypzDJyySpL9NPWULvRRSJ5fuogSvttPKME51jg+bE
 OfliiuawowDTK6xZLJ5+1Q1WouPUTlYsudzXiKXFJRguY5McTP2NF6p49U62NC/6CZCsIIY4h04
 6o8e5XGAt42XLx+tyrC0+BvXgQ5sdAbp6GsH9PTYex4UU24MC70KMEJHqO3RLolHVcc3UwP26sc
 Z45oPTywg9wBuJbkheD7IUQM0icKQbh8peM+M76gohFvNSnsMfU6Uhyoh255ZOlPOi90/85OdyV
 0qRvWUlNhiuq+54C5iyXPlEvZm3Rw5qGHBAIA0k=
X-Received: by 2002:a17:90b:4a4f:b0:35c:5d1:1822 with SMTP id
 98e67ed59e1d1-35c0ddb1344mr536730a91.21.1774381611774; Tue, 24 Mar 2026
 12:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrTa3qL1jZew7_3L2mfeK2PT3RFTkTDxQUZ_4NK7wAmAw@mail.gmail.com>
 <CABrGZ+GiQ-KiJVhyCHK4EfG__4=mbJhj1rhpfczASuQ+NT9-BQ@mail.gmail.com>
 <CAATN3Nq+BSfAFrCfFEfsOWaSt2JsHC4hVm+K5hJts-iAF83wTg@mail.gmail.com>
 <CAEqNhNa2ner=c6Zb-TYVTJ7Foa=quSRYG3MVHn6kpmG4OCGfxg@mail.gmail.com>
In-Reply-To: <CAEqNhNa2ner=c6Zb-TYVTJ7Foa=quSRYG3MVHn6kpmG4OCGfxg@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 13:46:40 -0600
X-Gm-Features: AaiRm52dUmW4n5R2RGO4qqBL9baE5xYnxwRQCsUOp3BIXP7ixxlSCzhV067T4xM
Message-ID: <CAATN3NqwCo5D+6SPepoW2h-qwgdRSg9CDW_MRKWejHeSqvBqkA@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/hexagon/cpu: add HVX IEEE FP extension
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000aa7769064dca694f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102a.google.com
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

--000000000000aa7769064dca694f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:21=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

>
>
> On Tue, Mar 24, 2026 at 1:48=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
>
>>
>>
>> On Tue, Mar 24, 2026 at 10:52=E2=80=AFAM Matheus Bernardino <
>> matheus.bernardino@oss.qualcomm.com> wrote:
>>
>>> On Mon, Mar 23, 2026 at 4:33=E2=80=AFPM Taylor Simpson <ltaylorsimpson@=
gmail.com>
>>> wrote:
>>> >
>>> >
>>> >
>>> > On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
>>> matheus.bernardino@oss.qualcomm.com> wrote:
>>> >>
>>> >> This flag will be used to control the HVX IEEE float instructions,
>>> which
>>> >> are only available at some Hexagon cores. When unavailable, the
>>> >> instruction is essentially treated as a no-op.
>>> >>
>>> >> Signed-off-by: Matheus Tavares Bernardino <
>>> matheus.bernardino@oss.qualcomm.com>
>>> >> ---
>>> >>  target/hexagon/cpu.h             |  1 +
>>> >>  target/hexagon/translate.h       |  1 +
>>> >>  target/hexagon/attribs_def.h.inc |  3 +++
>>> >>  target/hexagon/cpu.c             |  1 +
>>> >>  target/hexagon/decode.c          | 22 ++++++++++++++++++++++
>>> >>  target/hexagon/translate.c       |  1 +
>>> >>  6 files changed, 29 insertions(+)
>>> >>
>>> >>
>>> >> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
>>> >> index dbc9c630e8..d832a64a17 100644
>>> >> --- a/target/hexagon/decode.c
>>> >> +++ b/target/hexagon/decode.c
>>> >> @@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pkt)
>>> >>      return !bitmap_empty(conflict, 32);
>>> >>  }
>>> >>
>>> >> +static void convert_to_nop(Insn *insn)
>>> >> +{
>>> >> +    bool is_endloop =3D insn->is_endloop;
>>> >> +    memset(insn, 0, sizeof(*insn));
>>> >> +    insn->opcode =3D A2_nop;
>>> >> +    insn->new_read_idx =3D -1;
>>> >> +    insn->dest_idx =3D -1;
>>> >> +    insn->generate =3D opcode_genptr[insn->opcode];
>>> >> +    insn->iclass =3D 0b111;
>>> >> +    insn->is_endloop =3D is_endloop;
>>> >> +}
>>> >> +
>>> >>  /*
>>> >>   * decode_packet
>>> >>   * Decodes packet with given words
>>> >> @@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int
>>> max_words, const uint32_t *words,
>>> >>          /* Ran out of words! */
>>> >>          return 0;
>>> >>      }
>>> >> +
>>> >> +    /* Disable HVX IEEE instruction if extension is disabled. */
>>> >> +    if (!ctx->ieee_fp_extension) {
>>> >> +        for (i =3D 0; i < num_insns; i++) {
>>> >> +            if (GET_ATTRIB(pkt->insn[i].opcode, A_HVX_IEEE_FP)) {
>>> >> +                convert_to_nop(&pkt->insn[i]);
>>> >> +            }
>>> >> +        }
>>> >> +    }
>>> >> +
>>> >
>>> >
>>> > Better to leave the instruction alone and turn it into a nop by not
>>> generating any TCG.
>>> >
>>> > That way, the disassembly (-d in_asm) will still show what's actually
>>> in the binary.  You could add the check in gen_tcg_funcs.py.
>>> >
>>> > You could also consider adding some sort of marker in the disassembly
>>> to indicate that the flag is needed for the instruction to do anything.
>>>
>>> Ah, good idea. Will do both for the next round, thanks.
>>>
>>
>> Note that we'll need to be careful with packets that use the result
>> vector in a .new context.  For example
>>     { V0.sf =3D vadd(V1.sf,V2.sf)
>>       vmem(R19+#0x0) =3D V0.new }
>> The problem is that the store wants to read the value from future_VRegs.
>> However, if the vadd is  nop, there is junk in future_VRegs.  So, we'll
>> either have to get the store to read from the real VRegs or have the vad=
d
>> copy the old value of the destination into the future_VRegs value.  The
>> first option will be more efficient because it will avoid the vector cop=
y.
>>
>>
> For the sake of ease-of-verification we'll want to do whatever the ISS
> does.  It's not very obvious to me what it would do in this packet contex=
t
> based on the description of the nop-like behavior, but we'll follow the
> ISS' lead.  In practical terms the garbage in future_VRegs is probably ju=
st
> as bad or good as any other value - if you bothered to execute this packe=
t
> on the target w/o support for this opcode you probably don't care much
> about the result.
>

I'll be interested to know what the ISS and hardware do in this case.

Thanks,
Taylor

--000000000000aa7769064dca694f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 1:21=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><d=
iv style=3D"font-family:monospace"><br></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24, 2026 at 1:48=
=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com" =
target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"=
><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Mar 24, 2026 at 10:52=E2=80=AFAM Matheus Bernardino &lt;<a hre=
f=3D"mailto:matheus.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.=
bernardino@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On Mon, Mar 23, 2026 at 4:33=E2=80=AFPM Taylor S=
impson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com" target=3D"_blank">lt=
aylorsimpson@gmail.com</a>&gt; wrote:<br>
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
 because it will avoid the vector copy.</div><div><br></div></div></div></b=
lockquote><div><br></div><div><div style=3D"font-family:monospace">For the =
sake of ease-of-verification we&#39;ll want to do whatever the ISS does.=C2=
=A0 It&#39;s not very obvious to me what it would do in this packet context=
 based on the description of the nop-like behavior, but we&#39;ll follow th=
e ISS&#39; lead.=C2=A0 In practical terms the garbage in future_VRegs is pr=
obably just as bad or good as any other value - if you bothered to execute =
this packet on the target w/o support for this opcode you probably don&#39;=
t care much about the result.</div></div></div></div></blockquote><div><br>=
</div><div>I&#39;ll be interested to know what the ISS and hardware do in t=
his case.</div><div><br></div><div>Thanks,</div><div>Taylor</div><div><br><=
/div></div></div>

--000000000000aa7769064dca694f--

