Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A36C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFOm-0002EL-JJ; Thu, 03 Jul 2025 04:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFOk-0002E0-N6; Thu, 03 Jul 2025 04:34:26 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFOj-0008H1-2R; Thu, 03 Jul 2025 04:34:26 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e73e9e18556so808708276.0; 
 Thu, 03 Jul 2025 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751531663; x=1752136463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cINP96Jss7SibUBcY2updt34RZUNeJOb6caC2VmRQxc=;
 b=mLesQo+2StO8c/XUN3y7gFNzMLaDO4nBG9PWjKMrUU8ArcZf3G9BZHBfp8atIVj153
 OxqIdb8bLkauXrXzzCXlTofWsa0e2fDrI8V9DFFeTk3Pq1/lw4B3HIY6VUvVqBtbUonr
 uRlPK5GFFfFBAgtqSpAFsMo41MDfVgNxVAtKSfv3imoiUHQuXT4yOwulALcUcHxZZMu1
 yy1KdbsGkJzQZyqt4riZ8DBZNHrstwj6l+ciko+3vFljNSeXNk2iJkGpxiFvD2xGPnML
 4aMDDrUzwx4ymR++W7jYLMYNTriM250DS04Kkg/79NraacgPqRhSHecDT1k4OI8lf82l
 NAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751531663; x=1752136463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cINP96Jss7SibUBcY2updt34RZUNeJOb6caC2VmRQxc=;
 b=rrMVY86XYiNybDAnZAF6FU8X7zodstrEni72qlnn4+xR1c6NXwhripcQMRNt76a7at
 nBTyZucaxPu3WMguYLBIUImF5Vf/Q7sR0F3VAOVLqU8+2bWjeSxsRTQjDQpgasYWobsL
 I3u6IUGz+DXFbKsHVPRy4SKLf01Lt08BWKuSpMMfdV3FV5iXaAZirPGhhM/m0XBm1/eI
 1jpJ5WEDKbqRUMcvbiy0shrxC7Drbl3sUXqhPxbOCGTa1dzZAPmqTETkLx7nfa4DKQON
 TsQDW9Z+6wCScp1/U10xHeyi/M9MT/bsiclF5LASQ4nPWKBecj/hh/QtHjC5U9IWf2gb
 0Vdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7mbbPBiGRk4VO+JAZV5Xwve0g+hxyD7+7vXMwWjrvAmLyyz56cOHwXtMzW9c8Xmqr2zcJSTS/wQ==@nongnu.org
X-Gm-Message-State: AOJu0Yy8vm0cxgPE+kRI5wlkvX40ar1MZ61rHtQrElQd8PFU3GT896wZ
 kFOFdKPafNMLhTiy3UC2kEf2hx36Hb/+TSFKmPJv/8cP/Yvyl+aXZRvtiKkT4cLmPi1YNoUxr+H
 7KUflK+ZIHXDF+HtblVwO37ljcBarbBc=
X-Gm-Gg: ASbGncvyv7b0yesMiGWuUBFwbUlLqq3o9MxSQmI5pIkPYsc8sXRBpWqbLvxYy3QSjbi
 SHL7y0drUnp4n9In5RWGyOkyhT1u1LQFlGkjYr8C9UFsZpSXsIU6KtFY9l6SN3QuW7McpAv5ppl
 KhM+cgCAc1OBlAtF3f6++gfLsSI2A4JRbwFQDcmVxONtI=
X-Google-Smtp-Source: AGHT+IHKAOTQkVgWfGIeNTlLrY7fZRfJ1YNn3dmOBlggxslMB6Q2OzBz3kjxfd826WqRVXAnkTNVBLVcW7kxxpdUbxM=
X-Received: by 2002:a05:6902:1021:b0:e7d:9de6:810e with SMTP id
 3f1490d57ef6-e89936d5e5emr1467514276.21.1751531663071; Thu, 03 Jul 2025
 01:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-13-kosasihwilliam4@gmail.com>
 <7847dd0b-271c-4e1d-93ba-605630464ef7@linaro.org>
In-Reply-To: <7847dd0b-271c-4e1d-93ba-605630464ef7@linaro.org>
From: William Kosasih <kosasihwilliam4@gmail.com>
Date: Thu, 3 Jul 2025 18:04:10 +0930
X-Gm-Features: Ac12FXzqkF4uE0Lp4Ljp5Tg5hePys4P7ExTONYQOqZIDZwCq-cfQzzdT6PzTV6c
Message-ID: <CAG66A_d=dpc9eevUTB0DN5EC8ed-M7i1ZJuULg4S8Bp5ou75Dg@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] target/arm: Fix helper macros indentation in
 mve_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000971dcd0639023e06"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000971dcd0639023e06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah okay cool. I'll leave them as they are for now :-)

Many thanks,
William

On Thu, Jul 3, 2025 at 12:23=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/2/25 05:19, William Kosasih wrote:
> > Recent helper function load and store alignment fix caused the
> continuation
> > backslashes in those macro definitions to shift out of alignment.
> > This patch restores a uniform indentation for those trailing backslashe=
s,
> > making them consistent.
> >
> > Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> > ---
> >   target/arm/tcg/mve_helper.c | 268 ++++++++++++++++++-----------------=
-
> >   1 file changed, 134 insertions(+), 134 deletions(-)
>
> I'd fix these within the patch that breaks the alignment or not at all.
>
>
> r~
>

--000000000000971dcd0639023e06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ah okay cool. I&#39;ll leave them as they are for now :-)<=
div><br></div><div>Many=C2=A0thanks,</div><div>William</div></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Jul 3, 2025 at 12:23=E2=80=AFAM Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/=
2/25 05:19, William Kosasih wrote:<br>
&gt; Recent helper function load and store alignment fix caused the continu=
ation<br>
&gt; backslashes in those macro definitions to shift out of alignment.<br>
&gt; This patch restores a uniform indentation for those trailing backslash=
es,<br>
&gt; making them consistent.<br>
&gt; <br>
&gt; Signed-off-by: William Kosasih &lt;<a href=3D"mailto:kosasihwilliam4@g=
mail.com" target=3D"_blank">kosasihwilliam4@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/arm/tcg/mve_helper.c | 268 ++++++++++++++++++------=
------------<br>
&gt;=C2=A0 =C2=A01 file changed, 134 insertions(+), 134 deletions(-)<br>
<br>
I&#39;d fix these within the patch that breaks the alignment or not at all.=
<br>
<br>
<br>
r~<br>
</blockquote></div>

--000000000000971dcd0639023e06--

