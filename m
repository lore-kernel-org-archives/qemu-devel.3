Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98786C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtbH3-00086U-TY; Mon, 10 Aug 2026 21:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtbGw-00086B-UJ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 21:27:19 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtbGu-0007uj-VR
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 21:27:18 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-669944f60b3so2820126d50.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 18:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786411636; cv=none;
 d=google.com; s=arc-20260327;
 b=USx6i/+0ZmRCyjuJpL8AXhwPbL0rqweF6Biuiq1A8mBz9miMty3B3SYry4fXiwiYdf
 E7yg8nvX42rNzFlfjPXJpx2MgMqVlMERMHdr5M0gXe6jpEhksKrqosaPCl820ucWEGPl
 xG7R9s3/r/Q/9iIAUeoZqn/iHrJyzTpuBkzVFf8tLX08VDDbaxg6bmJEoOHBZT97ISeK
 IKBcI8jHnW6F6D37CBevqLlJ+5kUhf8NH1Ptd2piUsl+AbliIIaOujtGVi+x4mMV6qfD
 sy1RuNKh4DzTygzDj/gFeqbjsDPBgkNs0BwWMfjpj2mqQMRgqe5Gs3FxVRZJQfjCQWG/
 QVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TBxAmOSUBbNLyw26qtRONWHRSp6bIPFEi6RDZXWF+T4=;
 fh=Tv1hKPs+cXWynI23hL3wQd3MOt1ixTT8ANGq27q0/yE=;
 b=Cdcu8IzTgdooAaY/tPzUz3sJEz8M8nePsYSh+ebgHxqzT12lRfUzgiy2lp+DerWotB
 S51uO2B6xVEO/vqYtb6UQQVGXVc0TAhpmgiUx8RQR2t29nQzfqiohZXnUVEVExVFNxVB
 /OjQSOpRO/PIWiUuVlv/HGHG1EW0EJe/+mHvALVZVLA+zW2/MED/9Ll3uia+LEuZmVlM
 jqPMesS6rnNiB5sSVciJpJI4zKxvcIiV4CR6MRU30aHmuHQlxKQAtKHx1+GjTTwYkbXY
 ijEi5DXFFpc4seN8Ud3XOVCk5GrumYfbVFCWzF9eBmqhPJ/I+6eNz8h65gb8t1Nw1Kky
 460Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786411636; x=1787016436; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TBxAmOSUBbNLyw26qtRONWHRSp6bIPFEi6RDZXWF+T4=;
 b=KdwiDCrGuAFtXtCvhcg9XRWNkrnUAaKa8gdLnoLThIiceZ7x61fOuMcDWojAqQ9eVU
 iwcIvW4+RDqb5ArS/5/8kUeC/Y4BANHkdxC3WfhEh2G0fu2Q2KojUOpoCgQtwQuIuM4p
 O/uNPAzBHzvhQGTxa0BLcCn1N5YgOazdXl87UTuJQim/pxZ8ZCMtfDhnqRt/Qcyqmfp2
 hEwstx22Ui/3zH//v83bmt9MkYMX2S3bjkJqhyO3vGMvuuoZFXDNrQkgwtdKj+3XjxL+
 Y4GGaoe75yd+9P2NNQBg4aPysCHuFUhW8tSQ7SCyj2hKokC4wPrj2VyoDtW0OpnqkSzS
 6fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786411636; x=1787016436;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TBxAmOSUBbNLyw26qtRONWHRSp6bIPFEi6RDZXWF+T4=;
 b=aFTPo8nF1TBi5zn5qx1cCmVDf3kzVcdkS71cpueLLEg/FyCvoreC9gohU4i4gQ46+W
 XyAte53+NdOfRdAqpTHfi+ipZvwIhMuh5ZBT2LBfMA2idnIFaxFUcVlaBDQCGhE2yWdN
 g53BOtjMteiF4cEjmMRKbdSt3BADg6eo3N8uPfL0a3Nu7FT/1c+Pi2Up3HyQyKHCwA1l
 oJ0nOzNcjNS1QFrSCVLkUSYEbZRgfasAHg7ktMwkDLyaGwHwRPc0Fvh9Z4PZS+4RyMzJ
 J5/E2FYu8aN8ksjligLmE/N8hLSypXacWfLVGpcX2hzQZGJ1RVYlLE1sG8nj91j0AFjr
 iwPQ==
X-Gm-Message-State: AOJu0Yw7Li16EntWXk2ExDdTQOhzyhCqK+F/bddQwjcJRjvo0CX/dUaI
 IwzZQ6foGFL2wzeH6oARzkBkQaWmhdKixbk4+FfZiZ6PU/r4E8l/+3lhXcmK+s027stKPQsuy6u
 63wPZ4hABeX/ParbhqnpjCcbHp/tla78=
X-Gm-Gg: AR+sD10lVotEdUt3nSE+lMH3ZIQxUhivsKj+4uLr5Txg5biIH50/E2DTHTc5nvSQHjN
 mPIq/tPyOz7ncgpElNV1BtZbMYFchzwHmIooBGc8MIqqXqWDvhQ8yttWLsUsOcKeEVRTUPK4GLC
 vViyuejubwpxgZ7DCRuM8O82546BojMWE4w27ZX+bFUfnCcE5lsuMH7xqfAMWG6MDk334rOlYMZ
 Z6YFSf4EzgsjXUgvw1QeiBu1DsVMYg1YWr7Pwjwj1XKKRVjRfrgcj3GpLRd/ujIBXr10MSb3tKi
 TQq9gOHkGYgjAV2nPVVGVLV678w/Oz9QeMZgvP+66FQvsDpSNjRPXpmMjvWRO/WPaj2rlbnE/kj
 s
X-Received: by 2002:a05:690e:1913:b0:668:8b5b:75ab with SMTP id
 956f58d0204a3-6699ac6d3d6mr26974547d50.49.1786411635592; Mon, 10 Aug 2026
 18:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
 <57bf1075-cf49-4ccd-8893-94d32d4be313@oss.qualcomm.com>
 <CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com>
 <b6f8c765-4e17-4aa1-990c-5518224971ef@oss.qualcomm.com>
 <CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com>
 <9db1ef83-7c05-4327-a6f3-539d1769df9d@oss.qualcomm.com>
In-Reply-To: <9db1ef83-7c05-4327-a6f3-539d1769df9d@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 10 Aug 2026 19:27:02 -0600
X-Gm-Features: AUfX_my9rAKBBVmRgWNCrgRAasMhdu90zM4pKLAHlOS3AUjQpmb-CzH8q3WXReE
Message-ID: <CAATN3NqQ4Tz5AnVBg5OAtgBv_A4sCoFP375ZcbDMoPN2ZxDggA@mail.gmail.com>
Subject: Re: [PATCH] Hexagon (target/hexagon) Clean up disassembly of control
 and system regs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000f6538c0658bb5e04"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-yx1-xb132.google.com
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

--000000000000f6538c0658bb5e04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 4:54=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

>
> On 8/10/2026 4:32 PM, Taylor Simpson wrote:
>
>
>
> On Mon, Aug 10, 2026 at 3:12=E2=80=AFPM Brian Cain <brian.cain@oss.qualco=
mm.com>
> wrote:
>
>>
>> On 8/10/2026 3:53 PM, Taylor Simpson wrote:
>>
>>
>>
>> On Mon, Aug 10, 2026 at 1:34=E2=80=AFPM Brian Cain <brian.cain@oss.qualc=
omm.com>
>> wrote:
>>
>>>
>>> On 8/10/2026 1:28 PM, Taylor Simpson wrote:
>>> > Change disassembly of control regs from C{num}/{name} to {name}
>>> > Change disassembly of system regs from S{num}/r{num} to {name}
>>> >
>>> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> > ---
>>> >   target/hexagon/printinsn.c      | 22 ++++++++++++++++++----
>>> >   target/hexagon/gen_printinsn.py | 14 ++++++++------
>>> >   2 files changed, 26 insertions(+), 10 deletions(-)
>>> >
>>> > diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
>>> > index a7e46f4bcd..b55d3b0b35 100644
>>> > --- a/target/hexagon/printinsn.c
>>> > +++ b/target/hexagon/printinsn.c
>>> > @@ -23,18 +23,32 @@
>>> >   #include "internal.h"
>>> >   #include "decode.h"
>>> >
>>> > +static char regstr[10];
>>> > +
>>> >   static const char *sreg2str(unsigned int reg)
>>> >   {
>>> > -    if (reg < TOTAL_PER_THREAD_REGS) {
>>> > -        return hexagon_regnames[reg];
>>> > +#ifndef CONFIG_USER_ONLY
>>> > +    if (reg < NUM_SREGS) {
>>> > +        return hexagon_sregnames[reg];
>>> >       } else {
>>> > -        return "???";
>>> > +        snprintf(regstr, sizeof(regstr), "S%d", reg);
>>> > +        return regstr;
>>> >       }
>>> > +#else
>>> > +    snprintf(regstr, sizeof(regstr), "S%d", reg);
>>> > +    return regstr;
>>> > +#endif
>>> >   }
>>> >
>>> >   static const char *creg2str(unsigned int reg)
>>> >   {
>>> > -    return sreg2str(reg + HEX_REG_SA0);
>>> > +    unsigned int gpr =3D reg + HEX_REG_SA0;
>>> > +    if (gpr < TOTAL_PER_THREAD_REGS) {
>>> > +        return hexagon_regnames[gpr];
>>> > +    } else {
>>> > +        snprintf(regstr, sizeof(regstr), "C%d", reg);
>>> > +        return regstr;
>>> > +    }
>>> >   }
>>> >
>>>
>>>
>>> Seems like this change also depends on some kind of mutex around
>>> regstr[] so that we know it's not being used concurrently by multiple
>>> threads.  Translation is single-threaded but if we gained another calle=
r
>>> we wouldn't remember to come back and remediate this.
>>>
>>> I suppose we could take an input buffer/length.  Or maybe we just add
>>> another static _regnames[] array to solve the lifetime/race problems?
>>>
>>>
>> How about putting a regstr field in the Insn struct (and pass Insn* to
>> these two functions)?
>>
>>
>> A character array?  Sure: seems like that should work.
>>
>> But if we have a static array for the others why not leverage that here
>> too?  We can statically fill these values, right?
>>
>
> These are for cases where there is some sort of error and the reg number
> is larger than NUM_SREGS/TOTAL_PER_THREAD_REGS.  So, we wouldn't know how
> to size these without looking at the number of bits in the encoding of ea=
ch
> instruction that has one of these.  However, that could change over time =
if
> the architecture adds new instructions.
>
> Ah, okay, right.
>
> Okay - any solution that mitigates the race should suffice, then.
>

I'll go with static arrays with 256 entries.  Stand by for v2 of the patch.

--000000000000f6538c0658bb5e04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10,=
 2026 at 4:54=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 8/10/2026 4:32 PM, Taylor Simpson
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
            3:12=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss=
.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p><br>
              </p>
              <div>On 8/10/2026 3:53 PM, Taylor Simpson wrote:<br>
              </div>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div dir=3D"ltr"><br>
                  </div>
                  <br>
                  <div class=3D"gmail_quote">
                    <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10,
                      2026 at 1:34=E2=80=AFPM Brian Cain &lt;<a href=3D"mai=
lto:brian.cain@oss.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.=
com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
                      On 8/10/2026 1:28 PM, Taylor Simpson wrote:<br>
                      &gt; Change disassembly of control regs from
                      C{num}/{name} to {name}<br>
                      &gt; Change disassembly of system regs from
                      S{num}/r{num} to {name}<br>
                      &gt;<br>
                      &gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mai=
lto:ltaylorsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a=
>&gt;<br>
                      &gt; ---<br>
                      &gt;=C2=A0 =C2=A0target/hexagon/printinsn.c=C2=A0 =C2=
=A0 =C2=A0 | 22
                      ++++++++++++++++++----<br>
                      &gt;=C2=A0 =C2=A0target/hexagon/gen_printinsn.py | 14
                      ++++++++------<br>
                      &gt;=C2=A0 =C2=A02 files changed, 26 insertions(+), 1=
0
                      deletions(-)<br>
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
                      &gt;=C2=A0 =C2=A0static const char *sreg2str(unsigned=
 int
                      reg)<br>
                      &gt;=C2=A0 =C2=A0{<br>
                      &gt; -=C2=A0 =C2=A0 if (reg &lt; TOTAL_PER_THREAD_REG=
S) {<br>
                      &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_regn=
ames[reg];<br>
                      &gt; +#ifndef CONFIG_USER_ONLY<br>
                      &gt; +=C2=A0 =C2=A0 if (reg &lt; NUM_SREGS) {<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_sreg=
names[reg];<br>
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
                      &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;???&qu=
ot;;<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(regstr, si=
zeof(regstr),
                      &quot;S%d&quot;, reg);<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return regstr;<br>
                      &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                      &gt; +#else<br>
                      &gt; +=C2=A0 =C2=A0 snprintf(regstr, sizeof(regstr), =
&quot;S%d&quot;,
                      reg);<br>
                      &gt; +=C2=A0 =C2=A0 return regstr;<br>
                      &gt; +#endif<br>
                      &gt;=C2=A0 =C2=A0}<br>
                      &gt;=C2=A0 =C2=A0<br>
                      &gt;=C2=A0 =C2=A0static const char *creg2str(unsigned=
 int
                      reg)<br>
                      &gt;=C2=A0 =C2=A0{<br>
                      &gt; -=C2=A0 =C2=A0 return sreg2str(reg + HEX_REG_SA0=
);<br>
                      &gt; +=C2=A0 =C2=A0 unsigned int gpr =3D reg + HEX_RE=
G_SA0;<br>
                      &gt; +=C2=A0 =C2=A0 if (gpr &lt; TOTAL_PER_THREAD_REG=
S) {<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_regn=
ames[gpr];<br>
                      &gt; +=C2=A0 =C2=A0 } else {<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(regstr, si=
zeof(regstr),
                      &quot;C%d&quot;, reg);<br>
                      &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return regstr;<br>
                      &gt; +=C2=A0 =C2=A0 }<br>
                      &gt;=C2=A0 =C2=A0}<br>
                      &gt;=C2=A0 =C2=A0<br>
                      <br>
                      <br>
                      Seems like this change also depends on some kind
                      of mutex around <br>
                      regstr[] so that we know it&#39;s not being used
                      concurrently by multiple <br>
                      threads.=C2=A0 Translation is single-threaded but if =
we
                      gained another caller <br>
                      we wouldn&#39;t remember to come back and remediate
                      this.<br>
                      <br>
                      I suppose we could take an input buffer/length.=C2=A0
                      Or maybe we just add <br>
                      another static _regnames[] array to solve the
                      lifetime/race problems?<br>
                      <br>
                    </blockquote>
                    <div><br>
                    </div>
                    <div>How about putting a=C2=A0regstr=C2=A0field in the =
Insn
                      struct (and pass Insn* to these two functions)?</div>
                    <div><br>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p><br>
              </p>
              <p>A character array?=C2=A0 Sure: seems like that should
                work.=C2=A0=C2=A0<br>
                <br>
              </p>
              <p>But if we have a static array for the others why not
                leverage that here too?=C2=A0 We can statically fill these
                values, right?</p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>These are for cases where there is some sort of error and
            the reg number is larger than
            NUM_SREGS/TOTAL_PER_THREAD_REGS.=C2=A0 So, we wouldn&#39;t know=
 how
            to size these without looking at the number of bits in the
            encoding of each instruction that has one of these.=C2=A0
            However, that could change over time if the architecture
            adds new instructions.</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Ah, okay, right.</p>
    <p>Okay - any solution that mitigates the race should suffice, then.</p=
></div></blockquote><div><br></div><div>I&#39;ll go with static arrays with=
 256 entries.=C2=A0 Stand by for v2 of the patch.</div><div><br></div><div>=
=C2=A0</div></div></div>

--000000000000f6538c0658bb5e04--

