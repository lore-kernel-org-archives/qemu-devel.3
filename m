Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AB9C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnK6J-00071G-Uh; Wed, 26 Feb 2025 11:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1tnK5U-0006Hq-V3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:16:55 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1tnK5P-000833-6r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:16:44 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4be68eadf2fso2078153137.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740586597; x=1741191397; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rfd8ez1be281m0pXL4wTzICVX5fPl02NDM2agZxbJKM=;
 b=MG//cePcg7nL1AdG5hYu9C02HvMv7hCicAesWmNCdQpmXi4tOhXlwKAF+XDqL49v1E
 hsOM+ylB6bc1VGJ9kqxybSa8rEjmWOar9nzBIbDFs56PY0PBkbzHBpbJJGS4ye4j3Q9r
 sOQcSIA1ePHvvZqtEonLNCWJQciH5x3nm/woU5YFurCzTTDVoM5X/Syfpk/QwSgcDYmQ
 ZckayEWdEEESlkvxygEf6gwmBSHFKf+CPXuFtMyJHmsoa6cNNTJzdT2Cr84OBJVyAeby
 /wQP0BPiCzvS0CcmpqZGyQ8dm4Z6Yh7GkG9ngkkXw3IkwI+wn5CTlz6iWvfy5Unpu77B
 oZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740586597; x=1741191397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rfd8ez1be281m0pXL4wTzICVX5fPl02NDM2agZxbJKM=;
 b=XTKuTnS48ErONaT7qDHqkAwUdUEV6brg9w1ZCjsM2wDQp0bIW1rqZgeR7drZ6agm7x
 CbNNfj3AeZ2YcdrxnSoNG4fAbk2SNEENazfTUIcQ4P8YcM/5BPbKYVMmTU8Ydoy4Jl7f
 0vr10KKXEKWC4/LHHkmmCgXKZF3M4GtEm7Yk1zavHSHa/2m2Ty4o9adODuhQZEDFtj7v
 SGkH9F+nFAekUr5tLEooAnPVDI2VV5J5FDsvcpin8E2O4W3zPJWscXTA9wXNWsNf9fXi
 L2ZPNKsJnjyzEyNo98y04jzujHp/dazNtCRgr+Sdo3g5HTbloUiXTyUE9Jp9xoriZmOp
 YREw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk7wz/BTLgrLlNna/Kir7mJUtCCXUMcdcfC0sVv/bFJsolXpW/vJ13F/G2+sqsaFTJ8n8BD1BmuyQb@nongnu.org
X-Gm-Message-State: AOJu0YyvrzMQ5625o+lMbH172vBEmYtblnl/Vpo/YJ7mlPi9Mwr+Mk9J
 5afFYc+9MH+1saOuQ7UhtoT71ezqiyYY8JScm+mNsmibIDwheAlu9oiXBUB1uCwvlvcrjvatUFo
 XU+QXsnAUxsm7qtEqK6KOGd7rzt9nNgpzAQoV
X-Gm-Gg: ASbGnctNKwu087gRf6GKgDgUV7dXhqC65hnXm7+ZhJl6nnkCMnHUAFziEq1dPrEnQlU
 NiEqSy+91u0+sWENpJbGz/GT107WMplVFHHE5ET8ythRNhTMfPwM0yef3qPpcE3Sea97sOrZj9h
 oWjc2Ooh5jWoDnd6QKIM7Mw1S6hT0Jdwjit+hp8w==
X-Google-Smtp-Source: AGHT+IHCVrSadeVNcNXkBapqLnSYk0g40Bj/Cy1fUD2WRaAdRIObeTfGuRxN1dqKALV1bLvf9h/9Ls+KtCHhe9lOgGQ=
X-Received: by 2002:a05:6102:290c:b0:4bb:ecb9:b34d with SMTP id
 ada2fe7eead31-4c00ae577ccmr4852728137.18.1740586596984; Wed, 26 Feb 2025
 08:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20250226024603.493148-1-venture@google.com>
 <f4b1dfc6-5265-400b-8842-349668c8e972@linaro.org>
In-Reply-To: <f4b1dfc6-5265-400b-8842-349668c8e972@linaro.org>
From: Patrick Venture <venture@google.com>
Date: Wed, 26 Feb 2025 08:16:25 -0800
X-Gm-Features: AQ5f1JoZdt_B4TYWgbuiZqSvXwVfKomIu2XSllZ52u2dg_6mWC3lJW3JqxhxPgc
Message-ID: <CAO=notzbY3wR+=gKeCS70ZpMAzhPZ-M4MHTF0MBP-GKMWXf_UQ@mail.gmail.com>
Subject: Re: [PATCH] hw/gpio: npcm7xx: fixup out-of-bounds access
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 kfting@nuvoton.com, wuhaotsh@google.com
Content-Type: multipart/alternative; boundary="000000000000d10ccb062f0de537"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=venture@google.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--000000000000d10ccb062f0de537
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:04=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 26/2/25 03:46, Patrick Venture wrote:
> > The reg isn't validated to be a possible register before
> > it's dereferenced for one case.  The mmio space registered
> > for the gpio device is 4KiB but there aren't that many
> > registers in the struct.
> >
> > Google-Bug-Id: 397469048
> > Change-Id: I2fb8d0d3d41422baab22e8fc7e9fadd0f2ee7068
>
> ^ Both lines are irrelevant on mainstream git history, otherwise:
>

Thanks, sorry, I was in a hurry last night to send this out and forgot to
strip them.


>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Cc: qemu-stable@nongnu.org
> Fixes: 526dbbe0874 ("hw/gpio: Add GPIO model for Nuvoton NPCM7xx")
>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >   hw/gpio/npcm7xx_gpio.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
>
>

--000000000000d10ccb062f0de537
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 25,=
 2025 at 11:04=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On 26/2/25 03:46, Patrick Venture wrot=
e:<br>
&gt; The reg isn&#39;t validated to be a possible register before<br>
&gt; it&#39;s dereferenced for one case.=C2=A0 The mmio space registered<br=
>
&gt; for the gpio device is 4KiB but there aren&#39;t that many<br>
&gt; registers in the struct.<br>
&gt; <br>
&gt; Google-Bug-Id: 397469048<br>
&gt; Change-Id: I2fb8d0d3d41422baab22e8fc7e9fadd0f2ee7068<br>
<br>
^ Both lines are irrelevant on mainstream git history, otherwise:<br></bloc=
kquote><div><br></div><div>Thanks, sorry, I was in a hurry last night to se=
nd this out and forgot to strip them.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Fixes: 526dbbe0874 (&quot;hw/gpio: Add GPIO model for Nuvoton NPCM7xx&quot;=
)<br>
<br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/gpio/npcm7xx_gpio.c | 3 +--<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
</blockquote></div></div>

--000000000000d10ccb062f0de537--

