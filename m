Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60952C982DA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yI1-0006Il-4n; Sat, 19 Sep 2026 12:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x7yGM-0004B7-Hd
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:50:16 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x7yGK-0008TL-PC
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:50:06 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2dd77300825so17829525ad.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789836602; cv=none;
 d=google.com; s=arc-20260327;
 b=cregnLjt+W+K/KICuiZJUX9CNNgsibweNhcH4WKW4maLNNSnf9CgfZDrVd1zBAeEfi
 +3IkSxouBVDWon04K/TpF9Y+1+eLFFY3SMgGktgkD33s9bcOOqTolYzVJtGqaEm5cQrN
 eF3OICkjxCHf7Mc5JsN184QskjIanE/1KI0yAYTtqZiietQM3S1axBqrC4S40hckLWPa
 Cghke2gV/7sxW/YdGYIbAYIncSgENX+iEteyJajFcJD/R0f+K786YkRxgaLsDeRLq3nh
 zWJdkZkRUlTKzBljzoYn5ytC1fdOqECHEWV5TujclX0YBHKXgB6T+htUV5dkP17IPZWM
 Uh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k032ONJdzfO8UzVH2BjndUo9NnG/bvpWEVjrBG9YBWQ=;
 fh=r4/nE9OmcLm5mjOOjCFNN/RpV9Fu521abdkuZPvwWRM=;
 b=UZenDtmwbUENkvLYzs6wXg6znUCMHrNedlB3NNajtYhjZOlJofQpKLbuSpLnwJajEo
 ANR7S4i0k/piSN77Fc5DKL/CAHZpI77rF3tkFO+vMHjxbwZ/wp1l+2U7pdL1fm0vCXzB
 pVwXjw5qrkBeNo/Q15nS5tD+IEXqkCFvKI41zWoZIGcLMme8CJo3Rhp9crgg0OgKBuGJ
 INF9lSw9KB1UE5Vx1/A9hhubRAHD9GEQ3fyRkAJe8LpdJYHgTS8uiJXHSNgNL+EbEMV2
 sxX8h+uV9MmiRYNbd8e4js6fb9aZWp3UdzK1NQQ8bxPA77Z3CEqG6pncgHm4/IijIvv0
 nyzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836602; x=1790441402;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k032ONJdzfO8UzVH2BjndUo9NnG/bvpWEVjrBG9YBWQ=;
 b=erPtQZMkPPCj/t6s3iOwrFcPQIFId/7zqv5ga9kf9EXDay5C45QfHtWsh666QXpmxk
 P/X0tULvtUgjUWxdQJsj7+72mFlyVNLnW3XJE9DbyqsY9QSkUv+c1jCwx9PRmL8qHu5d
 8uMXpn9m5AaTwc84qOd36mcFerzFr2dNf3fjRiAyPOHGsfaUWCqvautLjBnKXbImyO43
 O0q4cmHs2mXN/I5Z2quA2g532Ahsm+ZADt9k5HnNZZ5Yp4SyH7E1hxzSzD3fM7Adu+8H
 5gknhDr6GJRLOMhpEpJubvUUqRlzODQcxZA4qPjXeylyWJBMq17RT17kw2m4cfqaK4zX
 n4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836602; x=1790441402;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k032ONJdzfO8UzVH2BjndUo9NnG/bvpWEVjrBG9YBWQ=;
 b=q1Zmfl5PEJkaDHjiZw3PwguR3IIyFS9LcJaEQJfxPcpgsJW9kLIJOM91Q7zJ3N/yks
 ORSuki9YeKPaR3cwmCHJy9dyvphDye2sKU15bG1Ye4GVO31OuPZLdn4n3Aisln9v++2r
 ZxR4opgfcQxUzIeN7FW2cKhcqdcM4vhseMVAJ41gukCl7IY8aO22JNfJcwq6ZqMfYI+3
 HBw1wT4kZdmjShS7c+aWNdxh61uoLYCJDt45pus9CbVF3Ts2Hv0CnnxfXhYJjDOSPGKq
 p/rAsQMTA6qx+1S1qsRlqQez2uS8f60ulRppCv1ebP7GpQO+WgNFycKGBhYh5dtpLPnq
 GSxg==
X-Gm-Message-State: AFuF++kiiPvevMsQ0CPeRHE63kFj/54nkplHs1+kE8UbP9b7LvMgPSAz
 2putEKI6IPuQhJaBHok/AT4jGMmr0bKmUJnRcGMJ7BXUNclMrMhgMML/YNfcX+N/rJKQf9W0rZD
 a7gwhQim667eWGdulaRmk13t2AbJZjSCKZghXI3LjDQ==
X-Gm-Gg: AYBFou0Hbkh+UMJjLrEiaA8Sk0wD3o1QH/2V9Z+plwR+hNor8gElwLxasP+LQBfGnif
 t4zKmnY5PNPhSt76B3nFzaNwphZo8FHLfHQEbiue2pwRtz5CAvNL1yJntvaBTf6zGK1H7VNWGPW
 hkqKg8DuaG9935T1jAou9/WZGz4nx7e4yMxKYii0sSVbGprijkos1mFcn6jPE35MEZCt6cjSx4j
 zjQ9DB3y2pw/6zEjcmAoRpqmAqM0lZdZ5cmJOr1AuXy76+w5QRpRSIIdbSrWO2qnEVHB3Bm94T8
 Sk4Oe7QPwicec+GJMMAYEnv6Hf7/8e2TP6VC+TBohnJdVUCaGpyOgWzzm0AlnuO1YQBBBgNo9hy
 0VCqMR2iCtg==
X-Received: by 2002:a17:903:3c05:b0:2dd:4070:8eb with SMTP id
 d9443c01a7336-2ddb1b97f0amr107832335ad.20.1789836601581; Sat, 19 Sep 2026
 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260918042422.38713-1-imp@bsdimp.com>
 <590a4134-dea2-418c-8613-4209369828f7@linaro.org>
In-Reply-To: <590a4134-dea2-418c-8613-4209369828f7@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 10:49:49 -0600
X-Gm-Features: AcwNN1U2RrIGKA47IJah-czk_pR1R_tFXZjXJclpvYUrh8X0ZVrLjgxa5k4BG-U
Message-ID: <CANCZdfqeL6pT8gN36qdSr+Ev7nX8uU0Fzv088_az-FjskOT74g@mail.gmail.com>
Subject: Re: [PULL 00/41] Misc 2026q2 v4 patches
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000d7f352065bd8ce9c"
Received-SPF: none client-ip=2607:f8b0:4864:39::10;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj2-x10.google.com
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

--000000000000d7f352065bd8ce9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:19=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/17/26 18:23, Warner Losh wrote:
> > The following changes since commit
> 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7:
> >
> >    Merge tag 'pull-ufs-20260918' ofhttps://gitlab.com/jeuk20.kim/qemu
> into staging (2026-09-17 15:18:09 -1000)
> >
> > are available in the Git repository at:
> >
> >    git@gitlab.com:bsdimp/qemu-from-official.git
> tags/misc-2026q2-v4-pull-request
> >
> > for you to fetch changes up to 1f71ada86d7ad43c7241a6ae96912139ec3a6a7e=
:
> >
> >    bsd-user Update random_seed on thread creation (2026-09-17 22:07:42
> -0600)
> >
> > ----------------------------------------------------------------
> > bsd-user: Upstream most of the remaining system calls
>
> Applied, thanks.


I missed this and just resent it with a tiny tweak. Ignore it. I'll include
the tiny tweak in my next pull request which should be quicker now... My
apologies for the extra email. No need to revert or anything.

Warner

--000000000000d7f352065bd8ce9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 18,=
 2026 at 1:19=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 9/17/26 18:23, Warner Lo=
sh wrote:<br>
&gt; The following changes since commit 3b5d71cc3652fa7f5ecc449f05dae3ead2b=
718d7:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Merge tag &#39;pull-ufs-20260918&#39; ofhttps://<a href=
=3D"http://gitlab.com/jeuk20.kim/qemu" rel=3D"noreferrer" target=3D"_blank"=
>gitlab.com/jeuk20.kim/qemu</a> into staging (2026-09-17 15:18:09 -1000)<br=
>
&gt; <br>
&gt; are available in the Git repository at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 git@gitlab.com:bsdimp/qemu-from-official.git tags/misc-20=
26q2-v4-pull-request<br>
&gt; <br>
&gt; for you to fetch changes up to 1f71ada86d7ad43c7241a6ae96912139ec3a6a7=
e:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 bsd-user Update random_seed on thread creation (2026-09-1=
7 22:07:42 -0600)<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; bsd-user: Upstream most of the remaining system calls<br>
<br>
Applied, thanks.</blockquote><div><br></div><div>I missed this and just res=
ent it with a tiny tweak. Ignore it. I&#39;ll include the tiny tweak in my =
next pull request which should be quicker now... My apologies for the extra=
 email. No need to revert or anything.</div><div><br></div><div>Warner=C2=
=A0</div></div></div>

--000000000000d7f352065bd8ce9c--

