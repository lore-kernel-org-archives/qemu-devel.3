Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6D5EE0AEC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 22:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voqLJ-0007Zw-Ht; Sat, 07 Feb 2026 16:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqLC-0007Z3-8v
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:59:47 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqL9-0005lN-8h
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:59:46 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35480b0827bso1981404a91.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 13:59:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770501579; cv=none;
 d=google.com; s=arc-20240605;
 b=A3M5eUT9ns+pcL33H+FoR8a/dDsHwYadlWYY24tMo13JNjRZHI+/VUX7J2r4suShXy
 XI+FCG+okyDAysGKhmUmdD+2SMmbkdwXl7LsorV0cObgm0XS7gqWM+Wf6krt3gV02SR7
 feiCfnQd+WIEjNIqPeYYV8yPS4APgHdTKSbqXB3JohwrALM56XO3cD1cKg2qJUMbexOX
 5kgj6QsLrjh2CeIfoRgAhxdLmOKda2IQRnGmhIv3gJnTrlI8914W4+LkjMo+QiTP0hFY
 8jCUyI8/AJ4ZYHVBqFxzy/LbMEe147qR16IL6ycDxiLUh8dvi1v8MUlLzSo/9tfH0XcQ
 eAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A+UGwmjIwBtPXi13f16eNkQx5JSadaU6qWDyX16udsw=;
 fh=3m1aKdVwiiAQeDysI/JPLFyw7hm3fA2/ymZW6NmRwXE=;
 b=U9BSCp5cpTXSMVRwBaNicPYwTN9zyFRU/hy+t5izzRt7/A7b7kAkQOeK/CzLhM0tTP
 vAqR+m5LuLitP4iLGRpa+TC4evQPC/1sklvqrNnk8UMIBeDP46OjBjfSwuHe/cdiicVZ
 Ck6N2n0/apCTdqufDZqb1LzouBziXdcspx8Yz4UD1iU/8GKruKq4cPpQ6LzTqWpauVhA
 F3a8QjpKUqbK8j/SaBpUV+h37ijtXw87n6x55K8cn0ru+Y7clca5JdJTadP1G92Vd6V7
 7lc2Y+SbevtIjYyHuRzB6m+mYB9Xg2THN7kZMVVRviLd0XVrbmGW5dfoammOj+Q7B5vp
 nykQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770501579; x=1771106379; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A+UGwmjIwBtPXi13f16eNkQx5JSadaU6qWDyX16udsw=;
 b=hDOylNX6N0qvk4i0ehYQbJimXypptKhfYiPAAAe1vWWkS1XDpUP0S9rfMur0HT3+eW
 cWd9UvBNRfrkJvWy5kW5cpYOCjYiGU/AHCjUEfqh184d6Uv7VplqNiX+IaD+XbQq32k+
 gzmfsuwRQMXKJCbNyt1yGUoOHfNBdB4ieO0y3a/u1aBKcc9DwFaM+SO4YXeacS/CmwzC
 xi7AggkjqMc6WBosFh4ZN5s51hDwQ+EG3Jq6XsfAtFfYyYb3EsBibTOgomq1Zoy+m0HS
 SXZYQKn8AX7H27zfrWs1Hmp/gY5GRrIkctV6icn8uW1hM2B2A1Uw53+LtCYLF9Jxi8j+
 yNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770501579; x=1771106379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+UGwmjIwBtPXi13f16eNkQx5JSadaU6qWDyX16udsw=;
 b=C2k+5/hDQsBJ4BYjmcI3qns9nFfsL3ikljC3v9PdS5YEhOvDQAc/ph+OBp2Pqn6PX0
 kNnkDZfyHHBSFGGJcIwYAi1AbyVg3jEUlYH5NDTESRKn3LZzxi2xgons7tbN53wdBQze
 KnC5aPncZ8jVZ+1Rcr3/LcPPRbzXnECTIUU4XvDVnsZWgBXvAbTVeR2xhtfTWpj0+q8Y
 pa2gUWjJGNuCHnbLG9STf1Xw2Y5VcDpTx5aigNwI777SAhLHsBw000s+L3jsDcNfPFAq
 EfhnDw3qiiOWVPPgUzMgQmmxul1oNxqnjDxd9ShdqgI0f60feOFBZR9ZdGHBqLxck7DT
 WgOQ==
X-Gm-Message-State: AOJu0YyFHb1DFPBistUCI8oniy54UI/6uzdBApkC/FVD8Hlz70i5pVLH
 7yTC0Dk0FEWA3dJavvvvnOjxdnhLxxrUZ+RFXPily/wwT2NRIGjIUUI4v6kgw1LijbakpxRbECl
 sDxAAGGp/y8sFlSUQlrNvMMRhAUXrXUw=
X-Gm-Gg: AZuq6aJEL5jZch2H+a2wCOQNAungQGvV+mZUy0eYtPYA+LINFLJfBvqxVIEbACNGz6w
 vegyy/lYPhi8EWXUvIG9ozhugyBriuiIUxy3dkZJ1VUIj8HNz56/x4av4thqYgO3pMML6Yrfrlq
 /nvCPWE6icaSsJkoHEedEhfmIbnBX+S0o1sMBB9OvMxxYRYQrXUTzpwJjPWQUAteCiLcifdS5Tp
 bHACLO9ptxpjgJIujymCz+F4Tv9/22SN1hLSXlme2ZtlAfkazAri2UzMhGY/mOwniUSIGqD9M5c
 lRVdzZkXHDF+w3JN9T9hQM/xV7w=
X-Received: by 2002:a17:90b:2b4f:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-354b2f616fdmr6915353a91.1.1770501578762; Sat, 07 Feb 2026
 13:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
 <20260207180632.1042754-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260207180632.1042754-4-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 7 Feb 2026 14:59:27 -0700
X-Gm-Features: AZwV_Qh4BvgOzW61PelI8C9nOo1z1NPLS8pnbLLuz-pTAabTYDCNk-hBlVk4JXM
Message-ID: <CAATN3Nq-Kxhzq_WVwiBsXJjNWC0BQApxCNinahnrua8CVMyvEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] target/hexagon: Return decode failure for invalid
 non-duplex encodings
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ad2d5c064a4305e8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102c.google.com
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

--000000000000ad2d5c064a4305e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 11:06=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> When a non-duplex encoding (parse_bits !=3D 0) fails both decode_normal()
> and decode_hvx(), the decoder hit an unreachable.  Instead, handle
> the decode failure and raise an exception.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target/hexagon/decode.c              |  3 ++-
>  tests/tcg/hexagon/invalid-encoding.c | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000ad2d5c064a4305e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Feb 7, =
2026 at 11:06=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">When a non-duplex encoding (parse_bi=
ts !=3D 0) fails both decode_normal()<br>
and decode_hvx(), the decoder hit an unreachable.=C2=A0 Instead, handle<br>
the decode failure and raise an exception.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 3 ++-<br>
=C2=A0tests/tcg/hexagon/invalid-encoding.c | 25 +++++++++++++++++++++++++<b=
r>
=C2=A02 files changed, 27 insertions(+), 1 deletion(-)<br></blockquote><div=
><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsi=
mpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></d=
iv></div>

--000000000000ad2d5c064a4305e8--

