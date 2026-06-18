Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D94CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJlw-000102-A8; Thu, 18 Jun 2026 16:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1waJlt-0000zW-Rr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:55:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1waJlr-0004IL-QS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:55:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8453b56ab74so767673b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781816130; cv=none;
 d=google.com; s=arc-20240605;
 b=ds11bXouWX89YXLwyCzOuHaIQ8V6UkdMfVNnN+N1ZnRV81b3S/OhvfQCKe6bThEOdt
 jRxq8ydqBkoYaycQgYD4NOvOhL5DPRnKKyO7zjL0qTNdYYsZUnCF85RBXyfOgNPXRDXX
 M4Z2e2wxPCFzo4g9ytv9BU3fXvddBggmte/XWpp+Pn5FvwbootIgHUis5CIEYvS8ZOmP
 vWoDq6dxePe7B5ar/K0WIS1VTkKXdGGErcIc/MRAHlH/wzqdUsePGp5PHL+O2YN8RQn7
 XcdKdvvX3dyCMSeUjNHz2fv3BSjJWLBwcnObzC5dFhoeY061BZh+EtN+f9wT9AH8QUus
 kctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+meay3P5cR7g3vdPrdoyGmvRduYqLDWZxWl6cyAMvIg=;
 fh=2n/XUCk9Cc2kyN0Kt8GTOrU0oWY/9wedhkiUrAC+b/c=;
 b=GQrBaYO9BOqzQtZK+qD+LsNBOs+3F+l8Nm9YxJgsMkz4xqD6110u4CmkfuiWoW9Wyc
 h8WeqLz4nAQYX/BfDrxM23iOECga2mAgCz2GhmeWYo0V/+Acefcg9Utk3k8BxRx3DY+u
 KSl83CDLpuynZ9jIiymNsV7gXyT0PUS1mck4FXVYk1MH2KcqkA93WFjFFl1p9teWrTa/
 +ZXbLGT1ytPQtCttGAaP0L7NekLppOeTXxGCp/WQwdqpkaMmDfH/U+VfH5im5+medFv0
 4SBcnB4e+QDMRyD9yUK+LR+Wya90W0+Wm631IZ+8bA8m8XnTuLYcBwbeU03YKWAFyJ6W
 znDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781816130; x=1782420930;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+meay3P5cR7g3vdPrdoyGmvRduYqLDWZxWl6cyAMvIg=;
 b=hnRJQoWPOU0bnFf2BFxTGA1lTs1HmLKJWq3rZCxocLefjVM1G18BX1dsbLYncgI0lh
 cZ5Gu3LmPrraofcAkHggZjzlbs9vv+8HUu1CJcTAMbeuG0m9+M/7QfF5JcdcdXifAAdF
 E4VS5Ekfvb+j0i2L9w+yps7Xc5BDE3Yn5LbRUmhHy6N8o3JV0sLcktdUBGe+cjKw4/Qj
 +ubp5Vkk9rDExZ6C5ZO4B4A2CY6bKBdB+9nudoPbeJ7wRqKyVzrazDQo+utST+gObz7X
 YW6zxnA1WRU67kZ/13Xf2r4n6uh8XldQWy46KFDxyFiqK+kMhxQO5KCl7VrXFXalc2+H
 +qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816130; x=1782420930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+meay3P5cR7g3vdPrdoyGmvRduYqLDWZxWl6cyAMvIg=;
 b=Y5gM5pnukO9GdoqPOqKlUa6pci6ubVHdkbO4Jm44+5WaMR5lHqBEsQ6MGDdZHtGNZh
 9qO+1qJfis7o0TNs7V2T4x6fK+4Nia+e2RwShsy44oCjWFvCG7qodQ3PuzLY2+8wXIEh
 TDUlK2DAX2zIuXNI2nGfMNsdShgBvs3+hJMS4SU31Yle2WJhL+T5a82cnVk1pCp5BN2R
 MGtLo0iXl7Ftnb6/nbXtlh3hV+i227nJcUgAb4ev9JVwkpe0COTI4K+VLPk8NDDRJTnP
 gGScDblgAS42XCMdkqSGUH5CJGEVDrg+6BqvESlgOi7aEGcdR3LxhHel4i+wu+YHdvDP
 KIvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GS4V2+daN/J0kgRrh7DfRWbn4Y02pRzMgzp6/bHRdezGGgBKFt56D8ghhqRhdWcBcJH2vuzWbP957@nongnu.org
X-Gm-Message-State: AOJu0YwLByaHn2Fv/Uu5NiSBGS+h5GEX4gErHve7NzE8SlhSzovP5vjO
 NxJFJMnKKbv/ZuKfViTWsNr3Jow/7G2vW5EmzMBvW2WeMip7QYYBHHq9LFRJ339llyUH+hytFXm
 RwzQ5BBWwkt7lSVZJ4gTwLVvkAp1Wy8C80hB32GoEhAEWJ21uRibJeRuKBA==
X-Gm-Gg: AfdE7cl9a+aHyrRMEiPl91moz+lXeMYeAHOAfkYe8BzpezYkMbEk8ynmTeUoi0lhlQG
 SxkWwUCZuvFkDiG4hztR+yka30D8rGXyMYJvCUPCKVkDYzvwVAs6sKPPHbZq0vLIcuVX7YpTQbN
 99bpDWDqldmYJMV4foGViJg3PGjSYOhIzsvGFRMIeXt5L0+xXo0xSI2ZZMoZFlEgDoE3bkc9yAk
 1pEr0MVEzeKNW1/5w2rZeO6F318oPRc+rOxDfd92dnWfNb82V48MMhTL2IWeJ1Heqra4LSgntM=
X-Received: by 2002:aa7:88d0:0:b0:842:7992:bdc5 with SMTP id
 d2e1a72fcca58-84550b1dd71mr504098b3a.41.1781816129918; Thu, 18 Jun 2026
 13:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260618195829.590072-1-richard.henderson@linaro.org>
 <20260618195829.590072-2-richard.henderson@linaro.org>
 <0d4023d1-461c-4102-866e-cd825b5a53c9@oss.qualcomm.com>
In-Reply-To: <0d4023d1-461c-4102-866e-cd825b5a53c9@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 18 Jun 2026 16:55:18 -0400
X-Gm-Features: AVVi8CeB8XLMjL8-WxyGBPHouCwE4QRQhud-OxKg7KxABhLqKJ4FzoLdratKrGM
Message-ID: <CANCZdfpS5-i_nA2XHnZb21guNj2+mHps3AWBDeg5LNgwg+w+fA@mail.gmail.com>
Subject: Re: [PATCH v4 10/13] common-user: Implement read_self_maps for FreeBSD
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007aaae306548d65a8"
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000007aaae306548d65a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 4:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> On 18/6/26 21:58, Richard Henderson wrote:
> > Use sysctl to fetch the vm map of the current process.
> >
>
> Co-developed with Warner?
>

I'm good with whatever we do here... I'm easy.


> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   common-user/selfmap.c | 45 ++++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 44 insertions(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>
>
>

--0000000000007aaae306548d65a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 18,=
 2026 at 4:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 18/6/26 21:58, Richard H=
enderson wrote:<br>
&gt; Use sysctl to fetch the vm map of the current process.<br>
&gt; <br>
<br>
Co-developed with Warner?<br></blockquote><div><br></div><div>I&#39;m good =
with whatever we do here... I&#39;m easy.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0common-user/selfmap.c | 45 +++++++++++++++++++++++++++++++=
+++++++++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 44 insertions(+), 1 deletion(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.q=
ualcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt;<br>
<br>
<br>
</blockquote></div></div>

--0000000000007aaae306548d65a8--

