Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E540F433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDFaC-0003Pc-52; Thu, 16 Apr 2026 01:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFa8-0003PC-Di
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFa6-00012X-7r
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:03 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso4676128f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776318480; cv=none;
 d=google.com; s=arc-20240605;
 b=L8w9aV+oEO0mxlS9HQGp7z+IG7riKAHv+TQ4JXloIem4FWSNlTbcVy1FxdNKoqyE3n
 4yrxsMCCS2uyJNIwkqNyUewggavg1S3nqy6pJfTZCD7CA6DGAbRfxBrZ70UckuYKrGd3
 hLr2172r+va3W4l0uM0egbr1Zug5GU+P1M7/zXjsgg9YHLo472z1GxPjbP5FlM3QOOPe
 /8wsIfBYK9fRusYX1NRJrrXh01EMMN5BwpxvsuFgAA5GP4photHT2qMQL+A0JMgvwcVl
 ZFTDDtATdWZvcVheeoB+EpvtVdJpKXnD0dGxrNLipHTQ3QSi0ZTcWmh5si3ObK80BGgM
 tr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LLqmLtj1pRSQwnVYDNjMsn5HrX1UjuLoqZ/pvgXZ80c=;
 fh=O3O9NeKkwyWJwznoxF0c1lE2QtLH3V0uNLWxdOBrHXE=;
 b=ARFnOSqnB3Vp/L1GwkOn4um+2lVP7j/dPd6eYReip2hjrTS3i8CqDHwfuWVlUCvM28
 eFLmRUw/I0++WFxMpCi/+dMnVQeoPMkYlE/KsTteS+87SabvGVMNs1nwP6HkCYcrWFYy
 rECy4ooM/Gf2vXCz3xhZsLrVau5VE5g+pLTaBvZ3b0Aul9uWPMsPtSwr1jL+m3My2V1u
 KOMHb3yEWQrZ1VX9bMOabRCTsjMcR8pLk+y3zWc355mQ6Ih9VB/iu3rPGI6qaPIJsSqt
 nvvR+oOKRehPEJhaSmvsHRN3GMiC557xQMRE3Cuj/H8i2MASN3sHXHRxh/s+AyUALvOp
 cBbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776318480; x=1776923280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LLqmLtj1pRSQwnVYDNjMsn5HrX1UjuLoqZ/pvgXZ80c=;
 b=EbwdG5yMQ2G06FWAhQ1RM8qh/jPDjSEeBGSn0SOPiXMUgINdDPjE+cyPrfHDjw6fBb
 0FhXEGWTfOHOlAy31D20VczQj0p5NmI2gf7sdugIzzmbSUK0MygxNFKqNtcwMfZhkmVE
 eLkIrO/y7nfik9Z1PQzTxf2qFIPSsr3z2weMBl6ha3t7BgjseOg39vgS1nWzZhoF+iSq
 oXduaUmd9whddXvIjc0w/f1/F1wllsguOm4kFS2HiWd+zCdgQmhfBKak1QVmX0yrfMUf
 TlhkeGeuxnr1mjl9c0V6YRi+UXg+VNW160NLiP3hfKV7w6Jf0cYAAQBnGaJpaY+1l34B
 gjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318480; x=1776923280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLqmLtj1pRSQwnVYDNjMsn5HrX1UjuLoqZ/pvgXZ80c=;
 b=Tq0PHvHHk8FsCSY/wU73DJbPz7pOpcGFtigZjAuOR79VVoQNaKSEpSJqomuzoXBlPz
 qqalOBWto/X/KYjgHFXXTxiQiAZ/BCotKeyuwYQjTjgwrthHGdSmKHdFq4HSDyOI9viY
 /tqOniGcIEFwLh8xH2nlVTmISXp4+hLZ5W9Zt3nP7uaUDGgS4iko4OjzRIuXflPBbpM7
 bavaB7YJmxqB70ihmLKuHWemNrIuHqo7XH/U/WJRKleHcfBuSOjylUMafwZT1CONMYyK
 vfw0ZjBbh2HKhAXLGvMSW47xvoQDR6NVNX1sD6FvZpF3Vc/vzAQ+WU32R+eA2lVLsIAA
 jHcg==
X-Gm-Message-State: AOJu0YwAlBT38m/XcJNZ0D4J+FINkkS09AMhUUAZ0la8Edf2H+v8AUpF
 jpQ+ghnmk9IgYmLxGsd59GwJr3OiadGB1GDCcW82QO8NLSaPjs9jzmLJGl6n1B0/Lv3c+3jSVYv
 hjLzJxK/U+IkVbWS9bX+ZyPkfUjRPKtAgdBXif9lamg==
X-Gm-Gg: AeBDiet6FtuI2+n6DhuHxGbroIH/4fN6TWwpKKmh8rmmtwOX7LAhmymeeJ/wSgOfm4k
 lJya+VL1DS2ZFnI9upeUKnXRC6ywmO3on0E4eypIXl/9vbOHwge+Ff4UeVBgk+n2zgJfmjnAGRE
 fc0gbR6Uha2T/eLNc3yIWvHzlX+eKmwnSSFtR7IldGB48GRGHZ1cOdi9o9CwHb0HfFIQHGgMRWQ
 bKTupxFpca1gelkfgUHpACbEXGFwL6GxyGLnEfY/PKFHJrCTFsDIQLYXNkRjai26duY43KGyPgf
 ovMyN3eBk6RoSO7rUicHRRnXumySVmvHNm225c/v9D9a/hoG2+Kj
X-Received: by 2002:a05:6000:2912:b0:43d:a37f:8d5e with SMTP id
 ffacd0b85a97d-43da37f8e7bmr15565961f8f.18.1776318479798; Wed, 15 Apr 2026
 22:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 16 Apr 2026 08:47:33 +0300
X-Gm-Features: AQROBzDm0xwftibG2p9vzxLhonmSfLz13nSP0_gF8Rk-OleGo9EAry66FHmdiOQ
Message-ID: <CAAjaMXbupsQzscL+cs2R2Vn4R9Ar2jgu4xq0xaX07drYfDcSTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: update address and add Hexagon reviewer
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mark Burton <mburton@qti.qualcomm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ff2595064f8d5fde"
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000ff2595064f8d5fde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierrick, you should update .mailmap as well.

On Wed, Apr 15, 2026 at 1:36=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> This series updates my address for areas I was reviewing and maintaining.
> As well, I would like to help review Hexagon target.
>
> For top maintainers: I'll send my updated GPG key later.
>
> Pierrick Bouvier (2):
>   MAINTAINERS: update address
>   MAINTAINERS: add new reviewer for Hexagon target
>
>  MAINTAINERS | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> --
> 2.47.3
>
>
>

--000000000000ff2595064f8d5fde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Pierrick, you should update .mailmap as well.</div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Apr 15, 2026 at 1:36=E2=80=AFAM Pierrick Bouvier &lt;<a=
 href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouvier@oss.qua=
lcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This series updates my address for areas I was reviewing and mai=
ntaining.<br>
As well, I would like to help review Hexagon target.<br>
<br>
For top maintainers: I&#39;ll send my updated GPG key later.<br>
<br>
Pierrick Bouvier (2):<br>
=C2=A0 MAINTAINERS: update address<br>
=C2=A0 MAINTAINERS: add new reviewer for Hexagon target<br>
<br>
=C2=A0MAINTAINERS | 9 +++++----<br>
=C2=A01 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
-- <br>
2.47.3<br>
<br>
<br>
</blockquote></div>

--000000000000ff2595064f8d5fde--

