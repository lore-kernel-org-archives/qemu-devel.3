Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E2CA9EC1
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 20:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFdJd-0007Nm-6w; Sat, 10 Oct 2026 16:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xFdJa-0007N2-Ur
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 16:05:06 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xFdJY-0004wN-Ki
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 16:05:06 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4932b13c4ccso527737fac.3
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 13:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791662703; cv=none;
 d=google.com; s=arc-20260327;
 b=SwwkumS5v/1O8drNCP/Mefa0CTSZj7UE5LoF2Avs2tGRtRy4cTx/3vX82J2DmttvuI
 sEszQdWzM46jDoab7NhGepet4aCDc1bq1Af4vBadbGcfLvrhtoH2o3BgKmruNgZ/C+zZ
 XGImI9bxPnuRjmBTCQXo7taLQRJ4/7yNnYckfEhtc61W8dzsNKK8hxM1kshyVRC8YCJv
 5MBoQ2UtjQYfltNty3lM4b2zb0FHpOAJYey/kO5BVw5a/XRzuCjdvRiC0O9PtjVuPr0h
 2rXW5QUCTKY1xukH2d7pP1umGCopx88PbGD78fKq0WgjjeTNSt228R/4kj1N3Zr1fsZn
 67Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=98ZgHJSzU8wJ1MHjR1hg28VvYxexzd/TMp4IT85S9M8=;
 fh=6czfcAJfDmmN3XL32rileFAc4KWn6CYOehApDowJF/Q=;
 b=j2kUVu2kTlJRsv8UbWvJkTbEN/5I3OZA4uako4dgjbvmZRiBEN/C6ErVTNk3IPBXMn
 el0cEOryVyMP4zokM0i4GvREudlVgxKUakDTRdlWmASLl9Ls0Op0ld+G58EADLfOUmkW
 Kx0BEwuidWHUaea616UYzo/Ko3KjKlTJYigHdXgvy16DZDJxYjHHXipkzGelQ4Bc4TzV
 HOsKMHfQdyX29uraE1phoxnDUei3QIgssdBckRZaNp/a669dPLWrWlU2YqwN5akkd2/B
 0kvU9/suw4VdOhIPOgB0n6u8MT8915j92GUe221S6LNQaVXXz0afSI6DQbn/jsAKsNN7
 RNKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791662703; x=1792267503; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=98ZgHJSzU8wJ1MHjR1hg28VvYxexzd/TMp4IT85S9M8=;
 b=UgIJG0kZ6rj0AZob1cuREnDD+Fn5ck2bVsSnleeKMiWwVCASk4hRerv4MwrnxTUiyZ
 KcNBf7mYIMn0IVa6gsn2tyhp7h3HKBo2pHnR9KbErVI6j/T2mPl7+GRs0uuL6ya5RrSO
 qbNo7cjnJ9HaTlZSNKftH8YjVJOXlXIwjFbJqeY004V311cULZCuJBrHQJwsdx2p+LXm
 45mQpAic+ghDcyD5uPxyXaIeqXoqnl7ry4j41cs/i85xyxDo8wPFqCI/AHmTCAKAvScS
 VLNzfcGI7tqljRmqjOR1KdUAiGG22Jd8e348OCZlCmcYrY4u5x01UmyAJ/8xeYwXjITf
 Xihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791662703; x=1792267503;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=98ZgHJSzU8wJ1MHjR1hg28VvYxexzd/TMp4IT85S9M8=;
 b=IWeDg4r8NkjzhQlb524w/+lOChRbp8DThS8gYDt3pBb9HqoD2omxKO3s1LFWyg2Qkr
 rPMizcVSUSrHFJrV9nV/VeKh0pBQF6HbiE3qIdo5IgfyCCxyXnX1PUfSQfAkO/PwIh/N
 4nWyAJ2nL2Z1sQpGws5OXhY+WbIAFZEuep3Lv2ALPDl9GyYvZRD576ZsZlO5zdtMA1P/
 ottCK9WjBE7Hy3j8R2I0G+2eIT0z2BTtIrjjn/QItDbs6sbbSPYUtQ25l5Y84SIzJ+/0
 w+8Vhv48mQJJ0oXVqmVWNcXT6jf/ahjPTTOLP/u/2pS0ZY+trHsIk4DyLypN3hdInKe9
 /GXA==
X-Gm-Message-State: AFq9FYJnWbJVHGr2b+eVz41/KZ3SWnefQfOfj3vHDurNJxLvfkpgkyjL
 PzQLGQ6WEKt/kGJdKrmf9FIJLMS546AYTe2B75muH/sAWSASTUMvBjPw3Mn0LLqw7Hf+MUyfIp5
 rpbQVZpmib34yuO0jBoXNJU99A0jyfyg=
X-Gm-Gg: AYBFou0T1YS91e+85fzTTgNt+NvmLqqKeLHaTf/129rGaKKcuujftdbwbw3/V+wl53t
 i892a/StXR36Lfl+dZzAs5bjXL81CGh79IHTcy9qazYF+UfvNexDfTPa7Yb15YkcFamzD871M4C
 wlZkswa2HE1P3OfuEdTc21lckeqv0xLQU/Io3Y3iROQyW2bDaHih9Jbhk/FRFNkjeTFlTz7qM4d
 a65SN4RuiNwUk5jGqPH6xM8SzEZWGRbZaqZK2zFtGR56AyqF0A28LzYDoRQRb23Ofch1aSg3UPI
 L/RodDpJ5YCQAd+sBfgt80rW3JPFXMQ8R/eFwEOq80P7Izu0YZgaxg==
X-Received: by 2002:a05:6870:70a8:b0:4a2:647d:9233 with SMTP id
 586e51a60fabf-4a2a89dc9b1mr4820863fac.18.1791662702808; Sat, 10 Oct 2026
 13:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260903044626.24453-1-54weasels@gmail.com>
 <CAFWf6u8rjCECp+cdP21kfB7QUYff3crQiE1v5DnHXcMVzWan9w@mail.gmail.com>
 <8310b400-544e-4ed5-8eb6-e0797a924a8d@ilande.co.uk>
 <CAFWf6u86nFtQNfD=NFwUPamRKpt+EJg0vYhc1AALkGHJwtqZ+w@mail.gmail.com>
 <CAFWf6u-WJu6fh_Kc1aFo+fy4ffJzv7u25F8xVo4ZhtOxv2EgmQ@mail.gmail.com>
In-Reply-To: <CAFWf6u-WJu6fh_Kc1aFo+fy4ffJzv7u25F8xVo4ZhtOxv2EgmQ@mail.gmail.com>
From: Purr Box <54weasels@gmail.com>
Date: Sat, 10 Oct 2026 23:04:53 +0300
X-Gm-Features: AclHuK8SLqtewY1CuDBuC8kw2m89mYU5qTPbFrOBU02M50bdhhc6RfHyvagtOpo
Message-ID: <CAFWf6u-XwAdVNg-1Q5EuHQQSJL-h1qsnzhdgeOYTQGciMu9Gzw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement missing functionality and hooks in m68k
 to support upcoming Sun-3 implementation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, 
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000f552ef065d81fa86"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=54weasels@gmail.com; helo=mail-oa1-x2f.google.com
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

--000000000000f552ef065d81fa86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks - gentle ping. After the 68k patches it's all other devices so the
patch train should move easier. I also have SCSI support and others pending=
.

Thank you very much in advance,
Dan.

On Sat, Sep 26, 2026, 09:30 Purr Box <54weasels@gmail.com> wrote:

> Hi and quick ping if you could take a look at the series.
>
> Thanks,
> Dan.
>
> On Fri, Sep 18, 2026 at 8:11=E2=80=AFAM Purr Box <54weasels@gmail.com> wr=
ote:
>
>> Thank you very much in advance! I'm looking forward to getting sun3
>> supported.
>>
>> Dan.
>>
>> On Fri, Sep 18, 2026 at 6:32=E2=80=AFAM Mark Cave-Ayland <
>> mark.cave-ayland@ilande.co.uk> wrote:
>>
>>> On 09/09/2026 19:54, Purr Box wrote:
>>>
>>> > Gentle ping on this series. v5 addresses Zoltan's review feedback fro=
m
>>> v4 (fsave
>>> > simplification, NMI edge-trigger rationale, added Signed-off-by).
>>> Would appreciate
>>> > any review when you have a chance.
>>>
>>> Apologies for the delay: I will have quick look through the series over
>>> the next few
>>> days, although I suspect I'd need to defer to Laurent's greater 68k
>>> knowledge here.
>>>
>>> > Dan.
>>> >
>>> > On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels <54weasels@gmail.com
>>> > <mailto:54weasels@gmail.com>> wrote:
>>> >
>>> >     This series adds M68020/030-specific features to the m68k target
>>> that
>>> >     are required by the Sun-3 machine (series C) and its PROM/SunOS
>>> guests:
>>> >
>>> >        1/6: CAAR register stub for 68020/030 cache control
>>> >        2/6: fsave/frestore fix for 68881 (non-68040) FPU frames
>>> >        3/6: Edge-triggered NMI semantics for Level 7 interrupts
>>> >        4/6: Function code extraction during TLB fills
>>> >        5/6: Custom MMU intercept hook for Sun-3 transparent translati=
on
>>> >        6/6: Physical Bus Error and M68020 Format 0xB stack frames
>>> >
>>> >     Changes since v4:
>>> >        - Added Signed-off-by to all patches.
>>> >        - Patch 2/6 (fsave): Addressed Zoltan's review =E2=80=94 repla=
ced
>>> redundant
>>> >          M68040||FPU check with just M68K_FEATURE_FPU, removed
>>> unnecessary
>>> >          if/else in frestore, moved Context: below --- separator.
>>> >        - Patch 3/6 (NMI): Addressed Zoltan's review =E2=80=94 nmi_pen=
ding
>>> cannot be
>>> >          replaced by testing pending_level =3D=3D 7. The flag capture=
s the
>>> edge
>>> >          transition (level < 7 =E2=86=92 7) required by Motorola's NM=
I
>>> specification,
>>> >          while pending_level only reflects the current interrupt leve=
l.
>>> >          Testing pending_level alone would produce level-triggered
>>> behavior,
>>> >          firing on every interrupt check rather than once per edge.
>>> >        - Rebased on current master.
>>> >
>>> >     54weasels (6):
>>> >        target/m68k: Add dummy CAAR register
>>> >        target/m68k: Fix fsave/frestore for 68881 FPU
>>> >        target/m68k: Fix NMI pending for Level 7 interrupts
>>> >        target/m68k: Extract Function Codes during TLB fills
>>> >        target/m68k: Implement custom MMU intercept hook
>>> >        target/m68k: Implement Physical Bus Error and Stack
>>> >
>>> >       target/m68k/cpu.c       |   4 +-
>>> >       target/m68k/cpu.h       |  21 ++++-
>>> >       target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
>>> >       target/m68k/op_helper.c | 175
>>> ++++++++++++++++++++++++++--------------
>>> >       target/m68k/translate.c |  30 ++++---
>>> >       5 files changed, 280 insertions(+), 80 deletions(-)
>>> >
>>> >     --
>>> >     2.50.1 (Apple Git-155)
>>>
>>>
>>> ATB,
>>>
>>> Mark.
>>>
>>>

--000000000000f552ef065d81fa86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi folks - gentle ping. After the 68k patches it&#39;s al=
l other devices so the patch train should move easier. I also have SCSI sup=
port and others pending.<div dir=3D"auto"><br></div><div dir=3D"auto">Thank=
 you very much in advance,</div><div dir=3D"auto">Dan.</div></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Sat, Sep 26, 2026, 09:30 Purr Box &lt;<a href=3D"mailto:54weasels=
@gmail.com">54weasels@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi and quick ping if you could take a look a=
t the series.<div><br></div><div>Thanks,</div><div>Dan.</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 18=
, 2026 at 8:11=E2=80=AFAM Purr Box &lt;<a href=3D"mailto:54weasels@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">54weasels@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
>Thank you very much in advance! I&#39;m looking forward to getting sun3 su=
pported.<div><br></div><div>Dan.</div><div></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 18, 2026 at 6:=
32=E2=80=AFAM Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@iland=
e.co.uk" target=3D"_blank" rel=3D"noreferrer">mark.cave-ayland@ilande.co.uk=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On 09/09/2026 19:54, Purr Box wrote:<br>
<br>
&gt; Gentle ping on this series. v5 addresses Zoltan&#39;s review feedback =
from v4 (fsave <br>
&gt; simplification, NMI edge-trigger rationale, added Signed-off-by). Woul=
d appreciate <br>
&gt; any review when you have a chance.<br>
<br>
Apologies for the delay: I will have quick look through the series over the=
 next few <br>
days, although I suspect I&#39;d need to defer to Laurent&#39;s greater 68k=
 knowledge here.<br>
<br>
&gt; Dan.<br>
&gt; <br>
&gt; On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels &lt;<a href=3D"mailto=
:54weasels@gmail.com" target=3D"_blank" rel=3D"noreferrer">54weasels@gmail.=
com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:54weasels@gmail.com" target=3D"_blank" re=
l=3D"noreferrer">54weasels@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This series adds M68020/030-specific features to th=
e m68k target that<br>
&gt;=C2=A0 =C2=A0 =C2=A0are required by the Sun-3 machine (series C) and it=
s PROM/SunOS guests:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 1/6: CAAR register stub for 68020/030 cache=
 control<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 2/6: fsave/frestore fix for 68881 (non-6804=
0) FPU frames<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 3/6: Edge-triggered NMI semantics for Level=
 7 interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 4/6: Function code extraction during TLB fi=
lls<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 5/6: Custom MMU intercept hook for Sun-3 tr=
ansparent translation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 6/6: Physical Bus Error and M68020 Format 0=
xB stack frames<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Changes since v4:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Added Signed-off-by to all patches.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Patch 2/6 (fsave): Addressed Zoltan&#39;s=
 review =E2=80=94 replaced redundant<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 M68040||FPU check with just M68K_FEA=
TURE_FPU, removed unnecessary<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if/else in frestore, moved Context: =
below --- separator.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Patch 3/6 (NMI): Addressed Zoltan&#39;s r=
eview =E2=80=94 nmi_pending cannot be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replaced by testing pending_level =
=3D=3D 7. The flag captures the edge<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transition (level &lt; 7 =E2=86=92 7=
) required by Motorola&#39;s NMI specification,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while pending_level only reflects th=
e current interrupt level.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Testing pending_level alone would pr=
oduce level-triggered behavior,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firing on every interrupt check rath=
er than once per edge.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Rebased on current master.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A054weasels (6):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Add dummy CAAR register<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Fix fsave/frestore for 68881 F=
PU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Fix NMI pending for Level 7 in=
terrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Extract Function Codes during =
TLB fills<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Implement custom MMU intercept=
 hook<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Implement Physical Bus Error a=
nd Stack<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 21 ++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/helper.c=C2=A0 =C2=A0 | 130 ++++=
++++++++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/op_helper.c | 175 ++++++++++++++=
++++++++++++--------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/translate.c |=C2=A0 30 ++++---<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A05 files changed, 280 insertions(+), 80 delet=
ions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.50.1 (Apple Git-155)<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--000000000000f552ef065d81fa86--

