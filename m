Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E2DCD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 11:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJ8hX-0004OM-4Z; Sat, 02 May 2026 07:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wJ8hN-0004Me-67
 for qemu-devel@nongnu.org; Sat, 02 May 2026 07:39:55 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wJ8hJ-0000h3-UD
 for qemu-devel@nongnu.org; Sat, 02 May 2026 07:39:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-671dad7cac8so3189936a12.0
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 04:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777721987; cv=none;
 d=google.com; s=arc-20240605;
 b=HB0mRjejpPeZzlCMO1Y/nU6jVI+0H9nZ1kthEP6s/yo27kjXLHOqZtrr1kD33t3vLX
 IDQNWcgNHxIHbYdle+DhnpYaL+jy0Ow3oBbB2o9FvrJq91Drb9om6K/cfQkdJpryPDcs
 RsC4xvvWl9uPkYhoexHLuM3XBcxUjT4YAnf6/5pEo2rWJbkA+gVAq+Zgs4QOy4snhq7s
 Y1LD+R0Hi7TqDmUH3E3tRblV1N/9pBeZ+xzSmkcjW53Cd4JAeE3y+OH8OcZfY+p87IEs
 zMio8Sj+KQhFPV9sz0zE5ssO0dJkvcb1rWF38+XaOhcppuKyusiQvI8lDxoIt7gSRUR/
 lzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X3zO2k+rboycdoYRvCQ4v7991yHMREN7cAxyxP/o2PE=;
 fh=8ALIOqkJiX1fWC6TSNGpKXJ3CsfIj9ZQtHINE3WZlR8=;
 b=Prkc9eC1Bl06clbp7Ltt0LYeDVKaOTVcAiszRL9Uo7J7hviRfGRo68dzci+K+TQCYC
 1EJm/MmYkfozp6ihT1MDj6FQ+ojcVWNIiuaqHNCejPNcc8ggncTvbUe8gwCU6N8rNM5Y
 DgZ9b9y/aZV5Y+XvmMOMb5fqjqVnGc1M4/Qe/T1OiBBR8uBO9AKCqhNSHoe/T2ScBInT
 LjUwbCxFylTEX3EKJBe5uitqDPW1qMfoKHwRFwY6spNH8iva24eGyIMumGyYtzX9NBhi
 nzsS9+iuhjQ0WDnqj3TnRF8GYOC34NGzpK9qmJJIhmGsXAahJL9VP5xj1fmbZUnSpLGM
 RUOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777721987; x=1778326787; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X3zO2k+rboycdoYRvCQ4v7991yHMREN7cAxyxP/o2PE=;
 b=P2/X3+dIitsCKfiJDtYmFGCb6uXAZ3FxM9rG6QWBn/EOGvq5lPLZiz/Ud9pLcIXvH7
 5ScCaC7UagUoHBX2EUl/S+upoehM6Q8JMXr2Vbsy9g1z0G+OePQDL8xtHJ3zZF4vIETa
 ZSCGgmq/pPnWTcOCdvGLYmh2p4XuKp1hJAe5LsbOi0tGOnCVYGYMJDBguDQPxV1anEYb
 4G1JWYVwo5wbQo9lu027Q5qthJgx/roeY6AoxrmtwSiZEKErNN9RIIsQ0gxjLhbEOzRq
 8GFZTUaCR43d5Ye4rTLC+POAfIs7bo62EUw+SDS7+hmfSmUB6pz3efWHqZzzaB1bvXgh
 SLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777721987; x=1778326787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3zO2k+rboycdoYRvCQ4v7991yHMREN7cAxyxP/o2PE=;
 b=NgF0SaotFgqH/I7+vySMlzWK8Sj9Do/3iGA4zFSU96DDkYW6AsU6K81ZJ3VqM/Fbpz
 7D5ox6rC15iu4PbeH0y83zoTbKmV4gH8AKZgyZsIdyVKNaOqEZedVVMoZlSkkSmDwDrg
 QalCHfJ6JSWX2+qqOyMZsDhzjgWIKACyB+hlkth0Y43GHknA8sqOfho3Mh2bGSKIWbrn
 l0Su8W124HSAdtlu8YpV8d7sdXhsdqdACUltWaN3AHXKRcSj0JcvuB0RuBeabn38wJ7h
 sB8Jx51eIb5oZ6Di8lVtE8XC7wOVHQrpqTQrujvyuCzxUCDSdOKmkoOajPfbjKKvzN6L
 kVlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9HIabXcl/aD4T1wla5sajvj+HgYXgwRHa2aUZxYJXP/10OCuCjL93brdGFa3G/aDsoHNJvqU4Xp/i@nongnu.org
X-Gm-Message-State: AOJu0Yy465sU9KYj2wWDJX3oK8D8U8tmru3fLKJtOFQ3FyrJT2L2karM
 lku+5dciEqjZz9b8cFJspfzXOvSGLlEjwdJVibtUNm8SiprG7POtcAGCHeszml4xvs+wlVNc/+J
 bENhnCi8q9DMySCr7BtvqMJQGIpYF/mU=
X-Gm-Gg: AeBDietfsuclmx17qV1tR2n+Y7iD4irnYD0+MalgqyMVoQOSQi2mP7Xkp9Xrp2b1GPP
 oyfDiWlL2HezsENKxDiP9uTaQggH3PATXE2XrgT2tdKq02GG4wX1pXZzB0jEKlLslPs3Svune7r
 oCbcLVCFUSqbeT/TM2lqGrqirg+L4GBusggrJ37dkYwbnqCNPv741yWA+aW+4YWIxMMpCVQ4wrc
 2KS0Ux/pALgVYY8l9UWJqKtf+82sV7PL4YmaBDmzPUIgmLkl+jRXXEpHzBTz3ZHqdkQl9lpstYp
 G/YTKpmAisnyE8k54nh+CcLbYV3HbDkbqzktXh0e0sf4/8v0SKly
X-Received: by 2002:a17:907:a02:b0:bae:656b:2953 with SMTP id
 a640c23a62f3a-bbff950b331mr138414666b.11.1777721986364; Sat, 02 May 2026
 04:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260428103645.50617-1-Gautam.Menghani@ibm.com>
 <16a4ce5f-0ba7-41ac-8f78-b0699f10a5ab@tls.msk.ru>
In-Reply-To: <16a4ce5f-0ba7-41ac-8f78-b0699f10a5ab@tls.msk.ru>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Sat, 2 May 2026 17:09:34 +0530
X-Gm-Features: AVHnY4JAHk3rOduI7687iZIt8Mw1yIyWNaiBajq6cvtkfFQ3SKCzDIQsSRnmafc
Message-ID: <CAEuJdmqkJgEMNnGHa6Doc=jCbjXERHDkdcnJGPwmhZ8PpjE-WQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc/xics: Add a check for an invalid server id
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Gautam Menghani <Gautam.Menghani@ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, 
 kiki <Chan9Yan9@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Gautam Menghani <gautam@linux.ibm.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000081b6f90650d4275c"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000081b6f90650d4275c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should be fine. Thanks Michael!

On Sat, 2 May, 2026, 5:07=E2=80=AFpm Michael Tokarev, <mjt@tls.msk.ru> wrot=
e:

> On 28.04.2026 13:36, Gautam Menghani wrote:
> > From: kiki <Chan9Yan9@gmail.com>
> >
> > A malformed IVE value can result in an invalid server field being
> > passed to icp_irq(). The function assumes the server id is valid and
> > may access invalid state otherwise, potentially leading to a crash.
> >
> > Fix this by validating the server id before using it and ignoring
> > invalid values.
> >
> > Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
> > Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
>
> (https://gitlab.com/qemu-project/qemu/-/work_items/3324)
>
> I'm picking this small change to current qemu-stable series.
> The issue seem to be unimportant, but the fix is simple too.
> Please let me know if I shouldn't.
>
> Thanks,
>
> /mjt
>
>

--00000000000081b6f90650d4275c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Should be fine. Thanks Michael!<br><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Sat, 2 May, 2026, 5:07=E2=80=AFpm Michael Tokarev, &lt;<a href=3D"mailto:=
mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">On 28.04.2026 13:36, Gautam Menghani wrote:<br>
&gt; From: kiki &lt;<a href=3D"mailto:Chan9Yan9@gmail.com" target=3D"_blank=
" rel=3D"noreferrer">Chan9Yan9@gmail.com</a>&gt;<br>
&gt; <br>
&gt; A malformed IVE value can result in an invalid server field being<br>
&gt; passed to icp_irq(). The function assumes the server id is valid and<b=
r>
&gt; may access invalid state otherwise, potentially leading to a crash.<br=
>
&gt; <br>
&gt; Fix this by validating the server id before using it and ignoring<br>
&gt; invalid values.<br>
&gt; <br>
&gt; Reported-by: Zexiang Zhang &lt;<a href=3D"mailto:chan9yan9@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">chan9yan9@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Zexiang Zhang &lt;<a href=3D"mailto:chan9yan9@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">chan9yan9@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Gautam Menghani &lt;<a href=3D"mailto:gautam@linux.ibm.=
com" target=3D"_blank" rel=3D"noreferrer">gautam@linux.ibm.com</a>&gt;<br>
<br>
(<a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/3324" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qe=
mu/-/work_items/3324</a>)<br>
<br>
I&#39;m picking this small change to current qemu-stable series.<br>
The issue seem to be unimportant, but the fix is simple too.<br>
Please let me know if I shouldn&#39;t.<br>
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div></div></div>

--00000000000081b6f90650d4275c--

