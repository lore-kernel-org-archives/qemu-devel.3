Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1CDCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArtc-0002zQ-Ld; Mon, 20 Oct 2025 11:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vArtY-0002yo-5R
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:34:00 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vArtV-0003C0-5g
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:33:59 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64F363F520
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760974432;
 bh=9XIEVV1pj1LnQwNUr1MYMbaN9TF3CykKwSeIUaz/ofg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=m7uf4UgKYPEh//jGMdNoLspV1gAQl89VbhMQDevh3J7a18eoMry+wrRAHsWjXz3ut
 wjgaGMJmyX1jMQO0ptXuw9Nn77Nn6V4nvc25F7ZKcM/wJpf7ub5IcPqnXT7FgUKJJY
 7pRjhd6+06kCLBQITDvD2QTsjuFq1EKB9Jrjf18qtlbwkK4snyRZSITBmHRQHN6E8s
 6FwCrZw5g1L1iyxzjdBkQP1KYuVkaBdBxeUnaV20W2AXgKcw+9WtSWhwy8P+NekCQC
 Ekc+7jOMoTCELjcJYC3j9215Cg+vDvo0i72nOgAwWDVwL1WRp4fL3qQMHU5VFX8Hzc
 ZAOTWkvONQyRZ4HVJ2QJbLU0/O7tqwrAUR2g4uhixq8CzpBThOTPTGfEL/Lw3d/vDj
 Dlt72cUL+5n74paBSjvugSpbeEXazlCiJt32hT5ihSJ9xOW5v5LZCLzhDFOCThxWln
 XpEfdW5XnswpTXfDnly2lGLlne+dwxKrA9oe210zaPXfzsW08VQTIPXrtWGdDEivVh
 L14FdBu5SsicoOp0k7uhiMGdFrr4MEMjkl+CBgTybbI/JNowvbMGq5ecFIid5VYLDt
 lkBEmxUtXKiBp34+fnnKQpkNm6D/iNYo/mlfnDuRZpevhIK2X53r+zS1paavt0H8u5
 NOMSArcXGCeiyXbRALFjSqEs=
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5516e33800so6463793a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760974430; x=1761579230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9XIEVV1pj1LnQwNUr1MYMbaN9TF3CykKwSeIUaz/ofg=;
 b=ZSn1tBvkQQm8yuDieoo/2iC7PkxGoXQ9A9h1NFwqh1fr5+wPQzcQj+ySQoeGTekE2y
 kR0c2gT4wEPGNRrxHXBZfyZBjaqJW+U4WFPBmGaYhQPceWcsWp4bbA/ttj5zAvK+jV0f
 M0C7uKXIwdPwAYZOde1jCRsV8RuM+MEwfJtVqHcesOisIIfE3N0Jk1skfr3JHpFdtg+n
 +j/u1qEWHuZ41DHnhkj4vHrd3mxGXnbf5kXdXlfcWrGlmWBVFaYUZeKcy2BBSdP2mddU
 ec3QqSAAjW/yuj7LcfCe92EQ+398G78jmjqhMgRvV0J40tmpix+SHup07iJz1BtaGFQh
 rbFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLWtSW/hFKVXIudvam5SQvVWVq2j8BIM76fiUkOX8SUe0DXUk73HoS3H1hSyJNYj1krnagp3ETiMJ2@nongnu.org
X-Gm-Message-State: AOJu0YzuCCCrEGwGRB5L/90ZifDluDml3qaybRvBH6trqBJJbfEpjPM5
 tWhRzzkUqHDC2fN4ziDdc3+x8E5sGzm1RT7+rQo9snmCbyayiE+evkVQFeaWSZPszgu6V8zISsf
 6o6ya7rcJLjrtJSlX1qzK0OuAYj6TcHywWdc/XpINFaTIHn/ScGRiQ2ksMSf9RQMaU786qyV0Jw
 wd5ztZbPIO86v655B7jQJFcO8/j0gpQVcE2v9l113VMiNqDrk=
X-Gm-Gg: ASbGncunploTaGNl9FaqzhZA7OQKPmNNoOeEw8XpdzNh0z+JwT1pNQxfEKxY6SnTgJ5
 E5XcvLJ7LalUGiGDq6PL2LrsUQ5I/uh49PVBCW1JwZJNLe4xnUqTXeURoIg6A1CRfSyEfshsykH
 njmv92GE75DP34kyvPPbDOgTFErjhVz70fbnXPVu2hLWjYHH8+mTeh
X-Received: by 2002:a17:902:e546:b0:269:91b2:e9d6 with SMTP id
 d9443c01a7336-290cb65c529mr177402915ad.46.1760974430331; 
 Mon, 20 Oct 2025 08:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNThXnFmh94o4SmP939+cR9q7DMPbb8SuByENcAI0z/jIb0hlWas2bkkumw47ktsfyWKhC4I0Sjpob4o3wPWU=
X-Received: by 2002:a17:902:e546:b0:269:91b2:e9d6 with SMTP id
 d9443c01a7336-290cb65c529mr177402635ad.46.1760974429853; Mon, 20 Oct 2025
 08:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-4-sean.anderson@linux.dev>
 <4d1a679a-f1c2-487b-bddb-eaf7dd56fd0e@canonical.com>
 <56d70072-67ee-471a-9b9a-c3257886d668@linux.dev>
In-Reply-To: <56d70072-67ee-471a-9b9a-c3257886d668@linux.dev>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Mon, 20 Oct 2025 17:33:37 +0200
X-Gm-Features: AS18NWAIXQXq1aOXOWPXvFkoruAR-1lxP6HUNmCkxuYSVHu5YFldzNK-UbI-QJ8
Message-ID: <CAM=mAOn0vTDhaW3fYKK+E2t6R18+KA0ZgwantE5+9PwGCMPFKg@mail.gmail.com>
Subject: Re: [PATCH 3/3] semihosting: Check for overflow in FLEN on 32-bit
 systems
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000059ac17064198cf79"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000059ac17064198cf79
Content-Type: text/plain; charset="UTF-8"

Sean Anderson <sean.anderson@linux.dev> schrieb am Mo., 20. Okt. 2025,
16:21:

> On 10/18/25 03:21, Heinrich Schuchardt wrote:
> > On 10/17/25 23:35, Sean Anderson wrote:
> >> When semihosting 32-bit systems, the return value of FLEN will be stored
> >> in a 32-bit integer. To prevent wraparound, return -1 and set EOVERFLOW.

>> This matches the behavior of stat(2). Static files don't need to be
> >> checked, since are always small.
> >>
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >>
> >>   semihosting/arm-compat-semi.c | 17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/semihosting/arm-compat-semi.c
> b/semihosting/arm-compat-semi.c
> >> index c5a07cb947..57453ca6be 100644
> >> --- a/semihosting/arm-compat-semi.c
> >> +++ b/semihosting/arm-compat-semi.c
> >> @@ -305,8 +305,19 @@ static uint64_t common_semi_flen_buf(CPUState *cs)
> >>       return sp - 64;
> >>   }
> >>   +static void common_semi_flen_cb(CPUState *cs, uint64_t ret, int err)
> >> +{
> >> +    CPUArchState *env = cpu_env(cs);
> >> +
> >> +    if (!err && !is_64bit_semihosting(env) && ret > INT32_MAX) {
> >
> >
> > The issue with the current implementation is that files with file sizes
> over 4 GiB will be reported as file size < 4 -GiB on 32bit systems. Thanks
> for addressing this.
> >
> > But unfortunately with your change you are additionally dropping support
> for file sizes 2 GiB to 4 GiB on 32bit devices. This should be avoided.
> >
> > The semihosting specification specifies that the value returned in r0
> should be -1 if an error occurs. So on 32 bit systems 0xffffffff should be
> returned.
> >
> > As file sizes cannot be negative there is not reason to assume that the
> value in r0 has to be interpreted by semihosting clients as signed.
> >
> > Please, change your commit to check against 0xffffffff.
> >
> > It might make sense to contact ARM to make their specification clearer.
>
> stat(2) will return -1/EOVERFLOW on 32-bit hosts for files over 2 GiB. I
> believe we should be consistent.
>

That may have been true historically.

Current 32-bit Linux supports 64-bit file systems and reports the length of
files beyond 2 GiB without error.

Best regards

Heinrich

--00000000000059ac17064198cf79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Sean Anderson &lt;<a href=3D"mai=
lto:sean.anderson@linux.dev">sean.anderson@linux.dev</a>&gt; schrieb am Mo.=
, 20. Okt. 2025, 16:21:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 10/18/25=
 03:21, Heinrich Schuchardt wrote:<br>
&gt; On 10/17/25 23:35, Sean Anderson wrote:<br>
&gt;&gt; When semihosting 32-bit systems, the return value of FLEN will be =
stored<br>
&gt;&gt; in a 32-bit integer. To prevent wraparound, return -1 and set EOVE=
RFLOW.</blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;&gt; This matches the behavior of stat(2). Static files don&#39;t need =
to be<br>
&gt;&gt; checked, since are always small.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Sean Anderson &lt;<a href=3D"mailto:sean.anderson@l=
inux.dev" target=3D"_blank" rel=3D"noreferrer">sean.anderson@linux.dev</a>&=
gt;<br>
&gt;&gt; ---<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 semihosting/arm-compat-semi.c | 17 ++++++++++++++---<br>
&gt;&gt; =C2=A0 1 file changed, 14 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compa=
t-semi.c<br>
&gt;&gt; index c5a07cb947..57453ca6be 100644<br>
&gt;&gt; --- a/semihosting/arm-compat-semi.c<br>
&gt;&gt; +++ b/semihosting/arm-compat-semi.c<br>
&gt;&gt; @@ -305,8 +305,19 @@ static uint64_t common_semi_flen_buf(CPUState=
 *cs)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sp - 64;<br>
&gt;&gt; =C2=A0 }<br>
&gt;&gt; =C2=A0 +static void common_semi_flen_cb(CPUState *cs, uint64_t ret=
, int err)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 CPUArchState *env =3D cpu_env(cs);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (!err &amp;&amp; !is_64bit_semihosting(env)=
 &amp;&amp; ret &gt; INT32_MAX) {<br>
&gt; <br>
&gt; <br>
&gt; The issue with the current implementation is that files with file size=
s over 4 GiB will be reported as file size &lt; 4 -GiB on 32bit systems. Th=
anks for addressing this.<br>
&gt; <br>
&gt; But unfortunately with your change you are additionally dropping suppo=
rt for file sizes 2 GiB to 4 GiB on 32bit devices. This should be avoided.<=
br>
&gt; <br>
&gt; The semihosting specification specifies that the value returned in r0 =
should be -1 if an error occurs. So on 32 bit systems 0xffffffff should be =
returned.<br>
&gt; <br>
&gt; As file sizes cannot be negative there is not reason to assume that th=
e value in r0 has to be interpreted by semihosting clients as signed.<br>
&gt; <br>
&gt; Please, change your commit to check against 0xffffffff.<br>
&gt; <br>
&gt; It might make sense to contact ARM to make their specification clearer=
.<br>
<br>
stat(2) will return -1/EOVERFLOW on 32-bit hosts for files over 2 GiB. I be=
lieve we should be consistent.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">That may have been true historically.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Current 32-bit Linux supports 6=
4-bit file systems and reports the length of files beyond 2 GiB without err=
or.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Heinrich</div></div>

--00000000000059ac17064198cf79--

