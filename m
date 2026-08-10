Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D226CC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXcN-0003GO-3V; Mon, 10 Aug 2026 17:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtXcL-0003GF-04
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:33:09 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtXcJ-0007ai-4j
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:33:08 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1712157a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786397586; cv=none;
 d=google.com; s=arc-20260327;
 b=C4JkfN/59UhfeXVTaaMnsy6W4Hq6zDUM4g0g1UT2eaV37iRT9+BcCi8az/KQZseeDK
 MpR0z4XHV7lo1Ujex+8Fit0bVHSzRCpTCLCOQC2wVK8z+L/svC80WoyNwtuKLG3SwO1g
 VHPtXRyQiY5XXwsq8ZoMueUY6b9zg9VKbau8Uv8Jb200y2UnEU2RH0uDMC2IUC2X057X
 FkO6giY0N6FrQfJU+p1s5gCbV+3KIcGVrnkjuKUyVQHNk67N05FkzOIMUt+6zsk5l6PG
 dWnd2Mgv5McZYCumpcMCuttN4gH3yizyuAvYG7NFKWRgWbUiBwJWTKjEOCI128FTXEqn
 clVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w+sRpfiRi82hJrWsr2fUcTdP3gTZc+38FGy28g5eXyM=;
 fh=Tv1hKPs+cXWynI23hL3wQd3MOt1ixTT8ANGq27q0/yE=;
 b=Y0UrgIbYBuqXfKX9sgu8CK2HF3vJhfCIr4UJTMCSrZfjhxac2C6cod8evE3AMFXfJj
 Ua0KGQUSkkuGFWP8vHBoPl7TvTvpCwSh6SHAqKOZbZ51FjHtibJIkmxCVj4s9a9ojy4A
 K7uzU1e9ar6CDAygEVZ/qU+kS4ztNV8gTX2DvtK7SOtCEC7yMUuRJP4qX7U1Fw0Dr48k
 k/0VLh3BC9MYnJ1Ku5BBjwzIGmftiW02CGIdqZOoERQxGBAhWo0O67Ef77IbgSMHCYVo
 HAH37L1YwojnKbjs5FvIq4TQOnQDDXQJdQmrnb8Na249VXQcuXZMcZKBl/OvxChc/971
 ZkeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786397586; x=1787002386; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w+sRpfiRi82hJrWsr2fUcTdP3gTZc+38FGy28g5eXyM=;
 b=rfigNvf8ZwSupn6cmhmVMA334nsKPVfBC0FWSv0K9uKDfNX3js7IvbekwXQEhAvIt0
 Xvi0DzVrMVOHxr/flsqLXZTsrEMwAtaq3sTVqrBimq+wdOL4Pi659Cfx14aDB/a6juhf
 bD1CjjrVJy0fFoBZo3Pl5TBJ7m57x7dFTTOmdlGfOfE4y1BEIOUDxVjX453RNx2ilaDU
 s7iyde99a7V3VJpx0LEqSaE87nI8pULDZxa4NmRJSz+5pZxa+7Xh3zT+K31CTR7S67OI
 6qT49rtLOk4vi2LBWP9PfonjC7bLdYnEtoEyYS8g0o4PngJpId0fUwegZCvDEZFDkBGh
 n03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786397586; x=1787002386;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w+sRpfiRi82hJrWsr2fUcTdP3gTZc+38FGy28g5eXyM=;
 b=nFFJ55x9NKgPt8SWrft4UWITxCv0Ez+6thkrcEqZQtVcLCpP98e8rZO/voT5NUycOv
 7MH+m1jaz651REHZngV7gN5tV4FwQYapJHbxJyI2DNpTm5pOcOkoq/cnVIdH/1SlJvYN
 chK6Tim16lGhaSaYUSE66Xn32Do83zvP+MnpRR+IZDPZujT6WmjhY0IeAhZpjk2WeFnx
 PKHi5lll/Vg5L9G6WVv/t7aTL2vfiqC6DlAVGFFnTf92NLZNh7fyvR1b/Zi55/ZCBx/M
 PFV5OY5ggm1nbBV2LaUO7TH7TkVMRP8Cb+8A29bi1xnSrQNI9QUu7jSVxc9plSPtd9Qx
 SzCA==
X-Gm-Message-State: AOJu0YzQf6jQHMEvU69gV0kYFVeTlRDJghjN4FRycVrVD3HPzaweyolF
 CCxfAuoPkDlm2bw0bB2KISfjLz5BEGIqq7WRboAb15X6Litxwgwv6fk1w6Gk5Cc107J0Pmosh53
 Ex4Hr8+wZvEODwnUx9EDx1/M6o9EzrU4=
X-Gm-Gg: AR+sD12TneP8RoCRtanBAghXj7wX7hpVYAWnK+Rq7mKNBIQGZsHQnxBY7jdehG9IX4P
 F2yuaGuLa/8lweu26u7yPgxz2pp9dDg7veT7j8//sAFxQ6IpDLjIcZWGCUZuNLhQRA4AzLhVte3
 fDkzcBcIR02zz+QU91NHmM7N06wpBKxUbU582/rYsEKGKffVYYN8JE5lEDk1OZq6Zwjbs0ZlXZX
 EgG+3WkT2g73ShuMHlzO4AwbrBZO3qwiaQPfjHN1lhUNZW2sTLPl4je6HTBKKHoQAoOJ3HAesvc
 rDAlru4sptDGrhHaaArutBZU7HcKmNa5F20mYebkfJd4BafoPHEaxNSvSrxHTHmm05k8IUrpUEf
 U
X-Received: by 2002:a17:90b:2684:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-392821f55abmr24159962a91.1.1786397585527; Mon, 10 Aug 2026
 14:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
 <57bf1075-cf49-4ccd-8893-94d32d4be313@oss.qualcomm.com>
 <CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com>
 <b6f8c765-4e17-4aa1-990c-5518224971ef@oss.qualcomm.com>
In-Reply-To: <b6f8c765-4e17-4aa1-990c-5518224971ef@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 10 Aug 2026 15:32:54 -0600
X-Gm-Features: AUfX_mwENci2YVktpTH8GstpIomY2YBozB4zjuoEiDtZH9BZ3kKsLfkhCJG_EEw
Message-ID: <CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com>
Subject: Re: [PATCH] Hexagon (target/hexagon) Clean up disassembly of control
 and system regs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="00000000000083794c0658b81940"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1030.google.com
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

--00000000000083794c0658b81940
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:12=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

>
> On 8/10/2026 3:53 PM, Taylor Simpson wrote:
>
>
>
> On Mon, Aug 10, 2026 at 1:34=E2=80=AFPM Brian Cain <brian.cain@oss.qualco=
mm.com>
> wrote:
>
>>
>> On 8/10/2026 1:28 PM, Taylor Simpson wrote:
>> > Change disassembly of control regs from C{num}/{name} to {name}
>> > Change disassembly of system regs from S{num}/r{num} to {name}
>> >
>> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> > ---
>> >   target/hexagon/printinsn.c      | 22 ++++++++++++++++++----
>> >   target/hexagon/gen_printinsn.py | 14 ++++++++------
>> >   2 files changed, 26 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
>> > index a7e46f4bcd..b55d3b0b35 100644
>> > --- a/target/hexagon/printinsn.c
>> > +++ b/target/hexagon/printinsn.c
>> > @@ -23,18 +23,32 @@
>> >   #include "internal.h"
>> >   #include "decode.h"
>> >
>> > +static char regstr[10];
>> > +
>> >   static const char *sreg2str(unsigned int reg)
>> >   {
>> > -    if (reg < TOTAL_PER_THREAD_REGS) {
>> > -        return hexagon_regnames[reg];
>> > +#ifndef CONFIG_USER_ONLY
>> > +    if (reg < NUM_SREGS) {
>> > +        return hexagon_sregnames[reg];
>> >       } else {
>> > -        return "???";
>> > +        snprintf(regstr, sizeof(regstr), "S%d", reg);
>> > +        return regstr;
>> >       }
>> > +#else
>> > +    snprintf(regstr, sizeof(regstr), "S%d", reg);
>> > +    return regstr;
>> > +#endif
>> >   }
>> >
>> >   static const char *creg2str(unsigned int reg)
>> >   {
>> > -    return sreg2str(reg + HEX_REG_SA0);
>> > +    unsigned int gpr =3D reg + HEX_REG_SA0;
>> > +    if (gpr < TOTAL_PER_THREAD_REGS) {
>> > +        return hexagon_regnames[gpr];
>> > +    } else {
>> > +        snprintf(regstr, sizeof(regstr), "C%d", reg);
>> > +        return regstr;
>> > +    }
>> >   }
>> >
>>
>>
>> Seems like this change also depends on some kind of mutex around
>> regstr[] so that we know it's not being used concurrently by multiple
>> threads.  Translation is single-threaded but if we gained another caller
>> we wouldn't remember to come back and remediate this.
>>
>> I suppose we could take an input buffer/length.  Or maybe we just add
>> another static _regnames[] array to solve the lifetime/race problems?
>>
>>
> How about putting a regstr field in the Insn struct (and pass Insn* to
> these two functions)?
>
>
> A character array?  Sure: seems like that should work.
>
> But if we have a static array for the others why not leverage that here
> too?  We can statically fill these values, right?
>

These are for cases where there is some sort of error and the reg number is
larger than NUM_SREGS/TOTAL_PER_THREAD_REGS.  So, we wouldn't know how to
size these without looking at the number of bits in the encoding of each
instruction that has one of these.  However, that could change over time if
the architecture adds new instructions.

The regno field in the Insn struct is a uint8_t, so we could create static
arrays with 256 entries and

We could revert back to returning "???".  Alternatively, S<unknown> or
C<unknown> would be more readable.

Thoughts?

--00000000000083794c0658b81940
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10,=
 2026 at 3:12=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 8/10/2026 3:53 PM, Taylor Simpson
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr"><br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10, 2026 at
            1:34=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss=
.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
            On 8/10/2026 1:28 PM, Taylor Simpson wrote:<br>
            &gt; Change disassembly of control regs from C{num}/{name}
            to {name}<br>
            &gt; Change disassembly of system regs from S{num}/r{num} to
            {name}<br>
            &gt;<br>
            &gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylo=
rsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
            &gt; ---<br>
            &gt;=C2=A0 =C2=A0target/hexagon/printinsn.c=C2=A0 =C2=A0 =C2=A0=
 | 22
            ++++++++++++++++++----<br>
            &gt;=C2=A0 =C2=A0target/hexagon/gen_printinsn.py | 14 ++++++++-=
-----<br>
            &gt;=C2=A0 =C2=A02 files changed, 26 insertions(+), 10 deletion=
s(-)<br>
            &gt;<br>
            &gt; diff --git a/target/hexagon/printinsn.c
            b/target/hexagon/printinsn.c<br>
            &gt; index a7e46f4bcd..b55d3b0b35 100644<br>
            &gt; --- a/target/hexagon/printinsn.c<br>
            &gt; +++ b/target/hexagon/printinsn.c<br>
            &gt; @@ -23,18 +23,32 @@<br>
            &gt;=C2=A0 =C2=A0#include &quot;internal.h&quot;<br>
            &gt;=C2=A0 =C2=A0#include &quot;decode.h&quot;<br>
            &gt;=C2=A0 =C2=A0<br>
            &gt; +static char regstr[10];<br>
            &gt; +<br>
            &gt;=C2=A0 =C2=A0static const char *sreg2str(unsigned int reg)<=
br>
            &gt;=C2=A0 =C2=A0{<br>
            &gt; -=C2=A0 =C2=A0 if (reg &lt; TOTAL_PER_THREAD_REGS) {<br>
            &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_regnames[reg];=
<br>
            &gt; +#ifndef CONFIG_USER_ONLY<br>
            &gt; +=C2=A0 =C2=A0 if (reg &lt; NUM_SREGS) {<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_sregnames[reg]=
;<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
            &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;???&quot;;<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(regstr, sizeof(regst=
r), &quot;S%d&quot;, reg);<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return regstr;<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            &gt; +#else<br>
            &gt; +=C2=A0 =C2=A0 snprintf(regstr, sizeof(regstr), &quot;S%d&=
quot;, reg);<br>
            &gt; +=C2=A0 =C2=A0 return regstr;<br>
            &gt; +#endif<br>
            &gt;=C2=A0 =C2=A0}<br>
            &gt;=C2=A0 =C2=A0<br>
            &gt;=C2=A0 =C2=A0static const char *creg2str(unsigned int reg)<=
br>
            &gt;=C2=A0 =C2=A0{<br>
            &gt; -=C2=A0 =C2=A0 return sreg2str(reg + HEX_REG_SA0);<br>
            &gt; +=C2=A0 =C2=A0 unsigned int gpr =3D reg + HEX_REG_SA0;<br>
            &gt; +=C2=A0 =C2=A0 if (gpr &lt; TOTAL_PER_THREAD_REGS) {<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_regnames[gpr];=
<br>
            &gt; +=C2=A0 =C2=A0 } else {<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(regstr, sizeof(regst=
r), &quot;C%d&quot;, reg);<br>
            &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return regstr;<br>
            &gt; +=C2=A0 =C2=A0 }<br>
            &gt;=C2=A0 =C2=A0}<br>
            &gt;=C2=A0 =C2=A0<br>
            <br>
            <br>
            Seems like this change also depends on some kind of mutex
            around <br>
            regstr[] so that we know it&#39;s not being used concurrently b=
y
            multiple <br>
            threads.=C2=A0 Translation is single-threaded but if we gained
            another caller <br>
            we wouldn&#39;t remember to come back and remediate this.<br>
            <br>
            I suppose we could take an input buffer/length.=C2=A0 Or maybe =
we
            just add <br>
            another static _regnames[] array to solve the lifetime/race
            problems?<br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>How about putting a=C2=A0regstr=C2=A0field in the Insn struc=
t (and
            pass Insn* to these two functions)?</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>A character array?=C2=A0 Sure: seems like that should work.=C2=A0=C2=
=A0<br>
      <br>
    </p>
    <p>But if we have a static array for the others why not leverage
      that here too?=C2=A0 We can statically fill these values, right?</p><=
/div></blockquote><div><br></div><div>These are for cases where there is so=
me sort of error and the reg number is larger than NUM_SREGS/TOTAL_PER_THRE=
AD_REGS.=C2=A0 So, we wouldn&#39;t know how to size these without looking a=
t the number of bits in the encoding of each instruction that has one of th=
ese.=C2=A0 However, that could change over time if the architecture adds ne=
w instructions.</div><div><br></div><div>The regno field in the Insn struct=
 is a uint8_t, so we could create static arrays with 256 entries and=C2=A0<=
/div><div><br></div><div>We could revert back to returning &quot;???&quot;.=
=C2=A0 Alternatively, S&lt;unknown&gt; or C&lt;unknown&gt; would be more re=
adable.</div><div><br></div><div>Thoughts?</div><div><br></div><div><br></d=
iv><div><br></div></div></div>

--00000000000083794c0658b81940--

