Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED132CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDew6-0000Np-Fq; Mon, 05 Oct 2026 05:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDevy-0000N9-JZ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:24:34 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDevw-0004Sk-Ru
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:24:34 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8a87fe69060so8283507b3.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 02:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791192271; cv=none;
 d=google.com; s=arc-20260327;
 b=p8iBmdAtWfeTypxnHmBxSFVhnY1tVB+jAoFBrQ9dxjPLGUDoG02ZJO/otFF/yVVtng
 Df5vcK38o4WJSUg71wqukzqa8ptUX1FR0IpWVm2ERdFirvj90v5Lz5zsJBOgRLErCuGY
 O/FVIM8/JdjNkD7EUnbyZOryAamBar9GWlPMYoDkli1zsADuwWwBQfc3jVnmAGy8AJk+
 uvXudsZvPb+GhrEKw//4Gqf7N60jIo9iI5qD0Yr5xZdobbA+io3WmWqoRFC9D89EVdU3
 1VLNqEEpFmApWOXr3K2o5iEtKuY/t0kVG8vRO6BZxYDHtqx4HB2gE1RY//eJeepXR+Dz
 FzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qgVGpXotW/z6T2Va3uz/csOlxWtkeNwVYCaEx3DKB6A=;
 fh=skaqemkmEYcyFg+X1G92An4ZvipxzcY0utyF4fq/fUc=;
 b=mTazV3kYU5+P8p+xPVFQj6430selseEM0Yw6vNn7zQWHnIxhJy6hipd+yTKluk1p9n
 5MWyQCN/mMebuMt+byrxBlENknF0DLy+KjB8I76PqT8mIGDsTieQNwIBDfyNnJKblqnx
 92XEZ1l4hfF5gDebpSnCLprnxSEVRiDuwab3pI5Rh4aGhgBuvOpyO4T42nbsbGRZc2Qf
 Ca+2BMVBkPMGj1xlZtpbZvwS4b4T74O8IdIcS3ae+grYmKPQfWA8efMdN535CHOEg+f8
 ncoNkf6BWFdaPCW06KIFuyc4H7lgYe6frCImWquhqZ1uk47IBIWjNW6YVeDca5o/WABR
 wdJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791192271; x=1791797071; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qgVGpXotW/z6T2Va3uz/csOlxWtkeNwVYCaEx3DKB6A=;
 b=R2UIrHJL4rkFUJpjwCZ4WhZIcgWt7e4XGvSXNeG5yjLltE0C3NQ+IxInb90E4Wt033
 JySjGYk5A2NXha0ArKVAK/rqd42F1tdYp6hlFsRp+uPTHx/EqKXcr/MoKUHat3ZpzWV9
 GPi+muky999vsMn2PYXzKMlJ4586nM2ahiDs5JSI7j4Lv/zdkTajgMVO7bXSP5PY3W1V
 xB0SgqN6psFV93vEgIRTJdRI16NOCMzsF1VTnEKkPOcrzuNgVGWmp2wCYRvjjxruRTWj
 LEJU+fICclHLX162qQ8LGqptCL42l8LHaw75fNLk9SN2r91Rh15hq9L62odEKyTgAM3c
 g9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192271; x=1791797071;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qgVGpXotW/z6T2Va3uz/csOlxWtkeNwVYCaEx3DKB6A=;
 b=CrHWcmn5VL6RtfRDWajUFl4254q6vUPwKVS1ADDpN/2/4OJZvlQQJHU0LF+s+MyvOU
 dmYKaGJ16c23H5moH8xWHQL52l2puWfIrkcnrLVQBidJRcV4UEvO5IxqqWrEQKAFuODI
 JU28osZ69JA9XptM0cPW9w734ppLUpZsvcBhoSjUfEANbh1U0N8jytciqNCwu6s01ffV
 88FXBGtKzNIHHx+4uE8OgbAE0OtFvUUmDOb3nSHBs5FptCr09ibLr7DR8e4F9SoR7FHX
 k18kWH1vyEIrIT+Q0fOuOh4lcgxtgitiaAMx/AbCEMc4pJ1n51A5fm73mrdB9PRa+ETZ
 1yeA==
X-Gm-Message-State: AFq9FYKgRpmmIEaFOShz5/ANNgLKClyey0CcBTbdYtHMf/nwx68K9v5Z
 N+e7kS0jYfDF+BV7lcemHX0p0dTBo40F0FVQDs7iYTKuAhf8W8SNb2LjWQ2aJUWa5oNg98a7ond
 TYMomk7lA8HoQdqWtTGFd0cTdrc0hvuyQY1Tz2fvBng==
X-Gm-Gg: AYBFou0vEB+IVv9RISRCD37jTZrVgpR0DTVFRLG9PkPgywrcOOaJtRpAbmSoJ5OcHOd
 sr4X9uEfJsaV/p5ooOh8wuWzKzTsNnDNGR3ASSZiec6pX50P54dn88fNJiM7fnxlTbmkKwPAfEk
 jD+6JYYuSaEB88LNl1DjaXkIYES0L847j5Ewgrun32scJo6zGuEkd1ODm4HbCUDB9r8FuRYbm0D
 2y1Pe8CEPjVtNcXaSEAJkpJMnt7CD4aau240A2chvmDR+1E9H6uGVDNm6aqgztugQLR4N5JNFVh
 m/6tGsZQZXcbgC8JHrYuteApUE4KkI4oOIBKTkjKVLxE48OhLVAWJNyM6pl1RgCoSsTDiGqqg8k
 PN3Hl2/4DcKRWWPPY3nXkP19TYS8RPGmEN5sR3mI=
X-Received: by 2002:a05:690c:f04:b0:8ae:8d28:77df with SMTP id
 00721157ae682-8ae8d2881c1mr32557747b3.9.1791192271448; Mon, 05 Oct 2026
 02:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-31-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-31-ccbef537cbeb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 10:24:20 +0100
X-Gm-Features: AclHuK8y7YgvYPkPRHMpSc2LJjL25fHRQyL6IHFa1ioZfwEKBSz5L_uLSex_6Zs
Message-ID: <CAFEAcA-aQhYCYeZJb=+O-hfJYiiV0w1nauwW+-w4D-UYuYtKxw@mail.gmail.com>
Subject: Re: [PATCH 31/63] hw/char/exynos4210_uart: fix baud rate calculation
 operator precedence
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Pavee Hui <phui@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000108475065d147380"
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000108475065d147380
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Oct 2026 at 11:25, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redha=
t.com>
wrote:
>
> The 0xffff mask was applied to the result of (16 * UBRDIV) instead of
> the register value itself, due to C operator precedence (* binds tighter
> than &). When UBRDIV >=3D 0x1000, the multiplication by 16 pushes bits
> past the 16-bit mask, producing a wrong baud rate calculation.
>
> Reported-by: Pavee Hui <phui@google.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/exynos4210_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index 9d1825150d1c..7240ff7b5c24 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -327,7 +327,7 @@ static void
exynos4210_uart_update_parameters(Exynos4210UartState *s)
>
>      uclk_rate =3D 24000000;
>
> -    speed =3D uclk_rate / ((16 * (s->reg[I_(UBRDIV)]) & 0xffff) +
> +    speed =3D uclk_rate / ((16 * (s->reg[I_(UBRDIV)] & 0xffff)) +
>              (s->reg[I_(UFRACVAL)] & 0x7) + 16);
>
>      ssp.speed     =3D speed;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

--000000000000108475065d147380
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sun, 4 Oct 2026 at 11:25, Marc-Andr=C3=A9 Lurea=
u &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redha=
t.com</a>&gt; wrote:<br>&gt;<br>&gt; The 0xffff mask was applied to the res=
ult of (16 * UBRDIV) instead of<br>&gt; the register value itself, due to C=
 operator precedence (* binds tighter<br>&gt; than &amp;). When UBRDIV &gt;=
=3D 0x1000, the multiplication by 16 pushes bits<br>&gt; past the 16-bit ma=
sk, producing a wrong baud rate calculation.<br>&gt;<br>&gt; Reported-by: P=
avee Hui &lt;<a href=3D"mailto:phui@google.com">phui@google.com</a>&gt;<br>=
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =
=C2=A0hw/char/exynos4210_uart.c | 2 +-<br>&gt; =C2=A01 file changed, 1 inse=
rtion(+), 1 deletion(-)<br>&gt;<br>&gt; diff --git a/hw/char/exynos4210_uar=
t.c b/hw/char/exynos4210_uart.c<br>&gt; index 9d1825150d1c..7240ff7b5c24 10=
0644<br>&gt; --- a/hw/char/exynos4210_uart.c<br>&gt; +++ b/hw/char/exynos42=
10_uart.c<br>&gt; @@ -327,7 +327,7 @@ static void exynos4210_uart_update_pa=
rameters(Exynos4210UartState *s)<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0uclk_r=
ate =3D 24000000;<br>&gt;<br>&gt; - =C2=A0 =C2=A0speed =3D uclk_rate / ((16=
 * (s-&gt;reg[I_(UBRDIV)]) &amp; 0xffff) +<br>&gt; + =C2=A0 =C2=A0speed =3D=
 uclk_rate / ((16 * (s-&gt;reg[I_(UBRDIV)] &amp; 0xffff)) +<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;reg[I_(UFRACVAL)] &amp; 0x7=
) + 16);<br>&gt;<br><div>&gt; =C2=A0 =C2=A0 =C2=A0ssp.speed =C2=A0 =C2=A0 =
=3D speed;</div><div><br></div><div>Reviewed-by: Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
<br></div></div>

--000000000000108475065d147380--

