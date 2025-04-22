Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CD7C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KsI-0008Uv-4c; Tue, 22 Apr 2025 17:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1u7KsD-0008T8-M9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:09:48 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1u7KsA-00005G-Si
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:09:45 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54d689c0741so820e87.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745356179; x=1745960979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hk9RDMhi7WYw+3x5hMC3ThCnGXyUY9r4sBfUbQExpbw=;
 b=oA2xBvuklA59epJsbvaZXNc8iI6acUbNEw+xaWMBevX08AVhKvLsXczHW+NRQ8lXVc
 F2klG+SpLio9gxeoVcSWUBVdCLTUd6dD+5HUUNlbde35e5T0mQlhWBlYm9ozfG2CS9Va
 RG5MrDJ0tBLuCOg/KSGKCz8rkcKMPoSkBiixeMqcA+lZ2ZefMVYo+UJzsc1q3WiusqHq
 QYzvwuVTyYdvIpLhMK5nmUPIc7HMm+uWoWPclzao50KVpn14lQA7yTwKCzFKOEwGGZb4
 VFyjz2DAFVZD5Vv/Hiv1Y5EPTbSStAz7/iEin4YOTAf+Ig+xavpzLWm9aXIG1+HHnFpe
 lS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356179; x=1745960979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hk9RDMhi7WYw+3x5hMC3ThCnGXyUY9r4sBfUbQExpbw=;
 b=O2WZ1xRWZCMGyAWGTmGjxmTO7wfbam62/3EH0HHGj5Sfln1CjJ1990iamfc2Cg9fOZ
 RC5qagArm+nVmV2NIN5hlxDBVDl80IN+9YCS7/saL5By9PUQXD/a0wJqvaE+jkflUW52
 qDPZBRlPx1yZs+Ig1oTMAFLh3d91MyAmPTk29FsGXYpAeYuXiYEHEpDtz7pnxFzrRLV5
 VaWP3h9zvfoyCN9cZFsnuJgxowUChRH7MjJEoMfo/vwR/z16aiBjWmJRR7XYv5nr4xZL
 0X0ksrRGp9om4UO325cQXa9eadwPH25dMWPOeSljTbSKpeL1hYZK9wFCfTYuL/Jvu8zX
 Gn2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4mkCCc/w/F5C7KHXlAj/3d6evPvKhikpm2xolNKOIZj7YvfFfKEWbBwekeeJURZxMUqzScJO9PmH0@nongnu.org
X-Gm-Message-State: AOJu0YyUbVlF8TC/k/8X9P92znZG1xfT5K3hkcuzQygOEqCcxxLYZGd8
 OfjtLO0QlI+Qrb/VudgD7J51R6XnwUrATWX7dS4UHR/UxT4Jm0KKJ86sinG+UEOLYtLlLcEorbF
 cDrFeNvFu1r7octD0bNHzmxHq13c3uIt/VYNC
X-Gm-Gg: ASbGnctKypagPQENCSBuSPfGAoKgIcjZHYoFt6wj730YQfKjdIaiqptx3uhzp/7rLqI
 QIappueAlEGtBm5/ehUPWXvnCT1z7nuKyOyJ/YB8IxsxGnfEjpLNYgMQeXg2CU1GnssVV28fKqI
 IznfSppl0ibXE5Rg+pafXtMqPf/TUWIMKsLDZfuh2/bxtwXh3P7Tz7
X-Google-Smtp-Source: AGHT+IHq1wnhFgZrNxe8Qg444MJyn9LsplrdC1zbtV8xyApQURgg2oRU/XAFDmQjpblpUCs7SKLfTioxDz161SNyrh4=
X-Received: by 2002:ac2:4ec4:0:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-54e772a46e6mr21514e87.3.1745356178623; Tue, 22 Apr 2025
 14:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250414020629.1867106-1-timlee660101@gmail.com>
 <834ad4b1-9dac-4559-b4da-bec6e6d4a945@linaro.org>
In-Reply-To: <834ad4b1-9dac-4559-b4da-bec6e6d4a945@linaro.org>
From: Hao Wu <wuhaotsh@google.com>
Date: Tue, 22 Apr 2025 14:09:25 -0700
X-Gm-Features: ATxdqUEfXo-cZovlZiBuDdh5i0Jfr1_8_Znn7gkgdghHI27YKLuk_wFQaWpKlfs
Message-ID: <CAGcCb107LRZR4=cso9VzN_54mpc2GJGsuM3q9k+1Z18X_rf_kA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Attach PSPI module to NPCM8XX SoC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Tim Lee <timlee660101@gmail.com>, peter.maydell@linaro.org,
 kfting@nuvoton.com, 
 chli30@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000008f6fb0633646757"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=wuhaotsh@google.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
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

--00000000000008f6fb0633646757
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 3:43=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 14/4/25 04:06, Tim Lee wrote:
> > Nuvoton's PSPI is a general purpose SPI module which enables
> > connections to SPI-based peripheral devices. Attach it to the NPCM8XX.
> >
> > Tested:
> > NPCM8XX PSPI driver probed successfully from dmesg log.
> >
> > Signed-off-by: Tim Lee <timlee660101@gmail.com>
> > ---
> >   hw/arm/npcm8xx.c         | 11 ++++++++++-
> >   include/hw/arm/npcm8xx.h |  2 ++
> >   2 files changed, 12 insertions(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
Reviewed-by: Hao Wu < wuhaotsh@google.com>

--00000000000008f6fb0633646757
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 14,=
 2025 at 3:43=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 14/4/25 04:06, Tim Lee wrote:<br>
&gt; Nuvoton&#39;s PSPI is a general purpose SPI module which enables<br>
&gt; connections to SPI-based peripheral devices. Attach it to the NPCM8XX.=
<br>
&gt; <br>
&gt; Tested:<br>
&gt; NPCM8XX PSPI driver probed successfully from dmesg log.<br>
&gt; <br>
&gt; Signed-off-by: Tim Lee &lt;<a href=3D"mailto:timlee660101@gmail.com" t=
arget=3D"_blank">timlee660101@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/npcm8xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++=
+++++++-<br>
&gt;=C2=A0 =C2=A0include/hw/arm/npcm8xx.h |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A02 files changed, 12 insertions(+), 1 deletion(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div>Rev=
iewed-by: Hao Wu &lt; <a href=3D"mailto:wuhaotsh@google.com">wuhaotsh@googl=
e.com</a>&gt;=C2=A0</div></div></div>

--00000000000008f6fb0633646757--

