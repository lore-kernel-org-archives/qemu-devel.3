Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16F3C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 06:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xALwO-0006UJ-K1; Sat, 26 Sep 2026 02:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xALw8-0006Tv-4D
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 02:31:04 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xALw6-0006Is-8w
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 02:31:03 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-469fdb78b1cso941585fac.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 23:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790404261; cv=none;
 d=google.com; s=arc-20260327;
 b=ZnrSsEV/XZ4/d1fwtwccqbq13pmUTkR/fHO7xIkjz6hRQfx93MPy7w1lG7S8ZsuKVO
 8nKcr0lMjoOPuR6fV9JyrWu+8v+frqcU3Q873ndyMvQMUI1bgxWGQ0u5P+QwgfPlLRZd
 7qx27z2WjFZy1KBOGzFxAcCM4ovsxcrtjZQHvqGIfOfGCg5Ga0Mw0VB8Oaf36IUDwfot
 Doe/U4bZ3e8COilBgCv8UvHhM2UwhCvUdeWosV1gdM3YPAicWYI1mv+wSV5rzTYoPvUk
 VskqnERGiDhCbScRW62lYXjHBKPfN5WrKDFMDI5v7REhP1laF8s/JZNPWemI+yv+0SQm
 FyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PVyCoa0RQNRnTDPW1MYVncaNPCEDnVjEGTy73ev+rS8=;
 fh=6czfcAJfDmmN3XL32rileFAc4KWn6CYOehApDowJF/Q=;
 b=BOz7UmYh/kID6UNFhhI65K7MhhYJ/Z52M4D0IkHFnbDB0otjuzj6ePvjLr810cOh3L
 wFlJA8Xm8vdCkPd7IeUvC8ohZFDWIemV41w/syAvDKPeO5Rmlq2u9BqFfQtHxkBVMOpI
 8qX4maMp0bA4CPo9Sz0WlAeFBSCWBL4n1HoSIkReGcKdFimis9m4mrobU58oZEdOLmwl
 h9StFiRaSC8vz63qhf0PPGhsoK9ZUR0tTBRilAZq+oaYhzzHW+OqmxK7GkVMoHOIBgv6
 QMV5Oath4Gkh5OH0YONkdsx3r2Mj9zy6ka4bkZ786CZ7edUUSjaMoPFHllLaqVCAU+eQ
 0Rrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790404261; x=1791009061; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PVyCoa0RQNRnTDPW1MYVncaNPCEDnVjEGTy73ev+rS8=;
 b=Y/PsS8dm6CRYIsGyYaX++APF0pHtaTEZjizP1dz6Yo7b9kU5d7sg2Le7Unxf8P5rzY
 +OTMMM5rxZETbJGUkki7l4Cz8jDbOUB89bABXh9SYZR3WVW8ydio93zDOIJLM+U5hNac
 l+lW2HzKQacZw9pQmwfCgqEe64/RpqTG50lec6SY3ql5f90MkH9tLwnz8qinKALWpJHC
 GNskny/fnmBei0D/E5aPFQZDixy1RdVTPi9zj7EdoJyiPNqvC8DZ7Sn0Phu3CY1FiucH
 xHhTe0dyncrzsnsX9C0gZkLjqkdz0bJbtn8y3VQusUFbRV3St3VB2T7wxIJlBWlFEbzd
 ZcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790404261; x=1791009061;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PVyCoa0RQNRnTDPW1MYVncaNPCEDnVjEGTy73ev+rS8=;
 b=gxGVuekUbA+xYQK4O5Q3kaGG4kVIEP8gVC+084QYHjF1p5XvRn2Qsa/LkQvWXhOb7u
 Jw6fYTPatvWYjulSzUrIGQ7d6pP1P3UktHVAo/8lXdqX9I4tYmjYvZhKST9+p9FpXfNK
 VUCcCGWCHBZukGEx6jWY7nirzfDDLEplhbI0eSAZXGbYjoyZw4vy9Ze6yN2sSZZf+to/
 HE59/7zZPjpd0KXk9cTOsXyRJLfI05LhaubeYfdLdYbGyMOvvTlIhjjapTpQPkD4uJex
 vulduSo30Okv6N5QzSUnY1NmFpYUQ2e611G6ylz1HR4CbFMWGvl/H6ia2BraEJC7Tl6W
 d5yg==
X-Gm-Message-State: AFuF++n1Hb5aTfK5T3+nFcEiVhi+Un9E2q97UmUG8jWtBvy1129i5YJO
 egLJOoOO/w0utUmqJTq3ubT9hdZjoBE7I112NcBYOotw8GQZ2DidGBF6hfWPwm9ngADa9Mwn4wO
 98+TKnmB3vT1CDGZrzYjcoYZtFoPZ1wQ=
X-Gm-Gg: AYBFou1pnD3+UkUYrzU3x2306sehxAIsOV5JxmbdccZExBGGYROelr2+PKG1Wzj2C9U
 F0sSrUzuDKRb7UMPj7F4olcsy8W5j6MuxAsfcAXVFHdE5w8H2z9SRYSzBGMxSF82rGiIS6l3+2v
 sb3QYrQ4xVzqOKdN1cngzLHCN+uDGSACILgutv5mR4/hgao2NlCCKIG90FCUdNNzIU6DmwuPnzl
 sZCFqwHlxVyG5JyNaRK90Hnn+RD8B65ml9Zt6qJn00jGsGh2mkT1d+x5DfX1adTrNml3l9XIBqu
 0c4PNZthTBBeAj+yyKRCqQNNndUxqAn4i/0bY5c9v0c0y5LssF/oa9+7
X-Received: by 2002:a05:687c:4282:10b0:493:a703:8da5 with SMTP id
 586e51a60fabf-493a7038ea1mr2302437fac.3.1790404260739; Fri, 25 Sep 2026
 23:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260903044626.24453-1-54weasels@gmail.com>
 <CAFWf6u8rjCECp+cdP21kfB7QUYff3crQiE1v5DnHXcMVzWan9w@mail.gmail.com>
 <8310b400-544e-4ed5-8eb6-e0797a924a8d@ilande.co.uk>
 <CAFWf6u86nFtQNfD=NFwUPamRKpt+EJg0vYhc1AALkGHJwtqZ+w@mail.gmail.com>
In-Reply-To: <CAFWf6u86nFtQNfD=NFwUPamRKpt+EJg0vYhc1AALkGHJwtqZ+w@mail.gmail.com>
From: Purr Box <54weasels@gmail.com>
Date: Fri, 25 Sep 2026 23:30:50 -0700
X-Gm-Features: AclHuK-sGJp83nbmk1vLAa-ZenVjlIipF7zGSJVMjfvvC2qxw8-V1B5f4CXU_Jw
Message-ID: <CAFWf6u-WJu6fh_Kc1aFo+fy4ffJzv7u25F8xVo4ZhtOxv2EgmQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement missing functionality and hooks in m68k
 to support upcoming Sun-3 implementation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, 
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000f73d86065c5cf9d3"
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=54weasels@gmail.com; helo=mail-oa2-x10.google.com
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

--000000000000f73d86065c5cf9d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi and quick ping if you could take a look at the series.

Thanks,
Dan.

On Fri, Sep 18, 2026 at 8:11=E2=80=AFAM Purr Box <54weasels@gmail.com> wrot=
e:

> Thank you very much in advance! I'm looking forward to getting sun3
> supported.
>
> Dan.
>
> On Fri, Sep 18, 2026 at 6:32=E2=80=AFAM Mark Cave-Ayland <
> mark.cave-ayland@ilande.co.uk> wrote:
>
>> On 09/09/2026 19:54, Purr Box wrote:
>>
>> > Gentle ping on this series. v5 addresses Zoltan's review feedback from
>> v4 (fsave
>> > simplification, NMI edge-trigger rationale, added Signed-off-by). Woul=
d
>> appreciate
>> > any review when you have a chance.
>>
>> Apologies for the delay: I will have quick look through the series over
>> the next few
>> days, although I suspect I'd need to defer to Laurent's greater 68k
>> knowledge here.
>>
>> > Dan.
>> >
>> > On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels <54weasels@gmail.com
>> > <mailto:54weasels@gmail.com>> wrote:
>> >
>> >     This series adds M68020/030-specific features to the m68k target
>> that
>> >     are required by the Sun-3 machine (series C) and its PROM/SunOS
>> guests:
>> >
>> >        1/6: CAAR register stub for 68020/030 cache control
>> >        2/6: fsave/frestore fix for 68881 (non-68040) FPU frames
>> >        3/6: Edge-triggered NMI semantics for Level 7 interrupts
>> >        4/6: Function code extraction during TLB fills
>> >        5/6: Custom MMU intercept hook for Sun-3 transparent translatio=
n
>> >        6/6: Physical Bus Error and M68020 Format 0xB stack frames
>> >
>> >     Changes since v4:
>> >        - Added Signed-off-by to all patches.
>> >        - Patch 2/6 (fsave): Addressed Zoltan's review =E2=80=94 replac=
ed
>> redundant
>> >          M68040||FPU check with just M68K_FEATURE_FPU, removed
>> unnecessary
>> >          if/else in frestore, moved Context: below --- separator.
>> >        - Patch 3/6 (NMI): Addressed Zoltan's review =E2=80=94 nmi_pend=
ing
>> cannot be
>> >          replaced by testing pending_level =3D=3D 7. The flag captures=
 the
>> edge
>> >          transition (level < 7 =E2=86=92 7) required by Motorola's NMI
>> specification,
>> >          while pending_level only reflects the current interrupt level=
.
>> >          Testing pending_level alone would produce level-triggered
>> behavior,
>> >          firing on every interrupt check rather than once per edge.
>> >        - Rebased on current master.
>> >
>> >     54weasels (6):
>> >        target/m68k: Add dummy CAAR register
>> >        target/m68k: Fix fsave/frestore for 68881 FPU
>> >        target/m68k: Fix NMI pending for Level 7 interrupts
>> >        target/m68k: Extract Function Codes during TLB fills
>> >        target/m68k: Implement custom MMU intercept hook
>> >        target/m68k: Implement Physical Bus Error and Stack
>> >
>> >       target/m68k/cpu.c       |   4 +-
>> >       target/m68k/cpu.h       |  21 ++++-
>> >       target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
>> >       target/m68k/op_helper.c | 175
>> ++++++++++++++++++++++++++--------------
>> >       target/m68k/translate.c |  30 ++++---
>> >       5 files changed, 280 insertions(+), 80 deletions(-)
>> >
>> >     --
>> >     2.50.1 (Apple Git-155)
>>
>>
>> ATB,
>>
>> Mark.
>>
>>

--000000000000f73d86065c5cf9d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi and quick ping if you could take a look at the series.<=
div><br></div><div>Thanks,</div><div>Dan.</div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Sep 18, 2026 at 8:11=E2=80=AFAM Purr Box &lt;<a href=3D"mailto:54weasels@=
gmail.com">54weasels@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr">Thank you very much in advan=
ce! I&#39;m looking forward to getting sun3 supported.<div><br></div><div>D=
an.</div><div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Fri, Sep 18, 2026 at 6:32=E2=80=AFAM Mark Cave-Aylan=
d &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"_blank">ma=
rk.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 09/09/2026 19:54, Purr Box wrote:<br>
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
:54weasels@gmail.com" target=3D"_blank">54weasels@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:54weasels@gmail.com" target=3D"_blank">54=
weasels@gmail.com</a>&gt;&gt; wrote:<br>
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

--000000000000f73d86065c5cf9d3--

