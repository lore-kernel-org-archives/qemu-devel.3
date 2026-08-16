Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC8AC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wveLv-00020h-Jz; Sun, 16 Aug 2026 13:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wveLt-00020O-Re
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:08:54 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wveLs-0003oC-8M
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:08:53 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5aebf96bc89so603610e87.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786900130; cv=none;
 d=google.com; s=arc-20260327;
 b=ETx9QFXhmBbgo1vGxMVqwhdyvGhjPrTy0vX0eHLcN99Rg8sCaI6TRQGQOc3uC0K059
 Ri3IxTm7egUi7f9T3t2/K+vCdbwnDZmRAxXEEvl6W/2fzIMEnutLnmiptKXyp4/rOjLX
 9HJeEyDE7B4IYMBgKnrHHzXVkskqTvkmqt7Dj2+zu8o7shK1ebZcn//6FZbtg6x0hvnS
 T9gAZh7BjaTbobvxzoPIoSrm/Yr1Ngp4EOpVX7VTcF9cD7kIALwim7KE5KZgjpfLRE5t
 dtOcsn5Qjv9d9UtamI90xlboYB7vR5WGkYkBXcAmPfpR4C6pnb2tofL1KRzczL7vkuwm
 /oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SP2wb4V/ypsjOyENnQjhQISPT75bcf+KFoXHsbQSvE4=;
 fh=sKJfdWmlXdbO0ULypAS3MiGzy7Q3ZwsXwppXqdFH4Zs=;
 b=NjOHBKfLqp2XZJ/AtQvTXxvCgRk6K2Zra2Oz+vq7a/CVjZR7lAaZEUybwiLqoGtlg0
 sKw5Chn03nx2jy4lviIt0K847GYRk+eYv63QU275SJylHICBZEFgG0RLKEF/J0PoRUVw
 /63hvz7TCQ0D+8vgeLFPmuovvtR3zWJt1op7EqqcQP2q1q2O6LWUwHMx7sTXzByE3Iua
 f0s84Dc50Y8ZAPOHlu7JnSEEmqlV6cG8kFi4B89tGmERllHCzNX+sRrH/LNz/eiJp0hV
 1fo1ECCc1ECcZRDv6DZGohwUmHXk+4iInW34HX53hP1vmAeSdn7sMtYlm8WGBtOQ2wR7
 ET6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786900130; x=1787504930; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SP2wb4V/ypsjOyENnQjhQISPT75bcf+KFoXHsbQSvE4=;
 b=cZPluhsYRsZG2L6i2zhiXwtfQX1CDwuISCklQyWQCgJ9UWg43n/JWw7PzbAZ66KnG1
 yj3/ymbGUPTNl+lu/ezgCXfgOVQ0akWXEVYo+O2i8udacU/8D6iH+uMUZgOI2SWQdZwO
 vD3TvFAysRK9EfHp7mmn7jXfIJCwOwTSs+Ko6+dwfktNb5gPu2kwugcSxK7ByDs+0pvN
 RsSaxcFdS1XHDFSkCYJ2JIjhU7fMt/stRpfSBsSJXqgfB3uxQCq1DvpGWHpweNmuhsMP
 x5jctY9DbBB24ccdaFzdpN3fHP0UT0tRmh+A/NZC0MDaMpjyRUbRCS9KX5ruHmjbiqgZ
 O/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786900130; x=1787504930;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SP2wb4V/ypsjOyENnQjhQISPT75bcf+KFoXHsbQSvE4=;
 b=APqu5oSD4cs+aRHXzMBTQfQjGZ+OuZimTpERTD/MiF2UZ/OdvsY7eJn+aPFUF+gdic
 pV3yAHMZEeQJIzhS4Vh7rQWF9LyP/wtw+NyQhfLzW2dD1yT2eMDSm6k9SWSQE4HA+bIx
 dfZ5N9njO54ccaFymz+WWAAokfXvD8WF07IwfX7tN1ObZXBS4ZMOTVAuGA+nkVgLF3cZ
 MmIJkSP47e6T4Pd8WbhzQjn3ldPhaVdNdplUGIGVg0c7+rMO7JLlmLeyRrYY8kyGXFqS
 kuNgQUyw8dR7fSrlm+G50sUSfoHw2beifN/G9XEBFjLMeg7/OtPLgO/pUVo+1ryATYgR
 DW0Q==
X-Gm-Message-State: AOJu0YwJ5k/d39pWffcWgYDeh/WdpnVQRN/Aj54ao/EDYoC7HIWsZQpn
 VyY+wqiyohYSaW14UXn4JDsz9hooEb0ejG++/TjvLApLPybIDMgOFjGeE6nNlkk5AmOY3w1uwLH
 rr3GsIo8kA1XQnXgvh3Zl7z2OnOxcCJU=
X-Gm-Gg: AR+sD11ThHKTHMvk+ad3gt8bGyC2t0bi4Vl+D8B8KooAd9UQZbObEmBxTIhuTYigG/G
 qfgdhKvBF4Ra2TBM9PfarPn075RbERtZqKTsOTbDubM3ZLF6h+ammyKaPiVzXX0E06QFshB1g1i
 XNzSi3MqvHgZATXK4sf85pslObK5PwaILcd6kl1QPFPZfVn7CvL8gm+j2dxrnKEoFeL1t3wOGkJ
 3g9I9Um83FGcdilTMVADCecANu0uP3f3v8POAKBmwCou8PJQHCYcwTray5mhhoU9Zz646DAlvI9
 XANW1Quq3pqlswkTNTlsXc3UCJjXiNRVnQVcCvpujhREQPRZBUO8ejBd8o1/2u7CwWlEo6uMm2B
 HfXJNMjzbHHI/KxmZ09UU/PPh+CBfgwPb
X-Received: by 2002:a2e:bc24:0:b0:39f:e8a5:2d76 with SMTP id
 38308e7fff4ca-3a1323be4b3mr17539331fa.1.1786900129570; Sun, 16 Aug 2026
 10:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260813005031.518387-1-richard.henderson@linaro.org>
In-Reply-To: <20260813005031.518387-1-richard.henderson@linaro.org>
From: Yogesh Vyas <yvyas1991@gmail.com>
Date: Sun, 16 Aug 2026 22:38:36 +0530
X-Gm-Features: AcwNN1U9-4jHuduYnx1FIZoqPj6-JXtLI5g486J_uC-m9TW1xbPLma85YWpLTb4
Message-ID: <CAJOT6qOr+YL=Z_uVzPNtz5=8+gjLhg0dQ=99pwADZb5XEgKGag@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] tcg: Defer tb_flush when initial thread region
 alloc fails
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rathc@linux.ibm.com, 
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
Content-Type: multipart/alternative; boundary="00000000000078e26e06592d1b8f"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=yvyas1991@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000078e26e06592d1b8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,
Thank you for improvising on the initial patch shared.

On Thu, Aug 13, 2026 at 6:20=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Hi Yogesh,
>
> The main problem with your patch is where you've placed the change:
> tcg_region_initial_alloc__locked is also used by tcg_region_reset_all,
> used by tb_flush.  Along that path, we really can't have a failure.
> The path on which we can defer allocation is via tcg_register_thread.
>
> The second change I made is to use code_buf_ptr =3D=3D NULL to signal
> reallocation is required.  In addition, tcg_tb_alloc doesn't need
> to immediately fail: in the interim since thread creation, we may
> well have performed a tb_flush already.
>
> Please have a try vs your hotplug test case.
>
I tried testing these patches on my x86 host running qemu-system-ppc64 by
initially hotpluging 400 vCPUs.
While the response was relatively slower than the initial patch that I had
shared, I also observed the VM is as slow as stuck when I retried
hotplugging upto 1024.
I will share more feedback if I have any.

Regards,
Yogesh


>
> r~
>
>
> Richard Henderson (3):
>   tcg: Return success from tcg_region_alloc__locked
>   tcg: Return success from tcg_region_alloc
>   tcg: Defer tb_flush when initial thread region alloc fails
>
>  tcg/tcg-internal.h |  2 +-
>  tcg/region.c       | 40 ++++++++++++++++++++++++++++++----------
>  tcg/tcg.c          | 24 +++++++++++++++---------
>  3 files changed, 46 insertions(+), 20 deletions(-)
>
> --
> 2.43.0
>
>

--00000000000078e26e06592d1b8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Richard,</div></div>Thank you for=
 improvising on the initial=C2=A0patch shared.<div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Aug 13, 2026 at 6:20=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailto:ric=
hard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Yogesh,<br>
<br>
The main problem with your patch is where you&#39;ve placed the change:<br>
tcg_region_initial_alloc__locked is also used by tcg_region_reset_all,<br>
used by tb_flush.=C2=A0 Along that path, we really can&#39;t have a failure=
.<br>
The path on which we can defer allocation is via tcg_register_thread.<br>
<br>
The second change I made is to use code_buf_ptr =3D=3D NULL to signal<br>
reallocation is required.=C2=A0 In addition, tcg_tb_alloc doesn&#39;t need<=
br>
to immediately fail: in the interim since thread creation, we may<br>
well have performed a tb_flush already.<br>
<br>
Please have a try vs your hotplug test case.<br></blockquote><div>I tried t=
esting these patches on my x86 host running qemu-system-ppc64 by initially =
hotpluging 400 vCPUs.</div><div>While the response was relatively slower th=
an the initial=C2=A0patch that I had shared, I also observed the VM is as s=
low as=C2=A0stuck when I retried hotplugging=C2=A0upto 1024.</div><div>I wi=
ll share more feedback if I have any.</div><div><br></div><div>Regards,</di=
v><div>Yogesh</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
r~<br>
<br>
<br>
Richard Henderson (3):<br>
=C2=A0 tcg: Return success from tcg_region_alloc__locked<br>
=C2=A0 tcg: Return success from tcg_region_alloc<br>
=C2=A0 tcg: Defer tb_flush when initial thread region alloc fails<br>
<br>
=C2=A0tcg/tcg-internal.h |=C2=A0 2 +-<br>
=C2=A0tcg/region.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 40 +++++++++++++++++++++++++=
+++++----------<br>
=C2=A0tcg/tcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 24 +++++++++++++++-----=
----<br>
=C2=A03 files changed, 46 insertions(+), 20 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div></div>

--00000000000078e26e06592d1b8f--

