Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68045C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWG9-0003UZ-DF; Mon, 24 Feb 2025 06:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmWG2-0003U9-6T; Mon, 24 Feb 2025 06:04:19 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmWG0-00072E-G5; Mon, 24 Feb 2025 06:04:17 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e0452f859cso6609077a12.2; 
 Mon, 24 Feb 2025 03:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740395052; x=1740999852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3gq1Sc9H5Ms95u4WWh16tH/o7ku03Ter1r8qA1KKf4=;
 b=STyW8UildNPcVZD8FN+zBlt4ZUSg7Bi3zkGtDooR08JmdFP6TlpNVk25HhYQe6Q86x
 8Ic8YAkzNqEhJgta3LWzm4hMpJnVtCQnj5ka/o961lFloIqEe7h1eGVmEWMLlIiK6qz2
 6jSYuligDU5nw/52wTaRon7Sh3wZyAczwHdC5l4mEz/NWxoEdv7/PchSt3m5jJSXy+pW
 BY3JGFf7AvHHNRCAdIdc3mcS7cmfp2NZVCdpt9DJGzTS5DsVpNvJP3Gb0SEIkkktUZck
 z0oWNpyPRF8FzVVzXkqDkVAN5qlhN1SRbSuauIdigfXD0v/At8wAqTc//xODeTQndAs/
 2ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395052; x=1740999852;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3gq1Sc9H5Ms95u4WWh16tH/o7ku03Ter1r8qA1KKf4=;
 b=tw0RR88hWCKKzhaaZfMx7Zs3e8SflT+jSNuAYTWXDUFw4roig+8ilKwlVsqmiKjTSb
 /qLTYTzjkMXImK9KJ8xaAL66xWP1ojzab28uZdR1+pQraAXRlGtUx58AuzvKbiAIa5e/
 QIdV86AE/QmKSGhXtPBHT7Bf7fy1RyZC36MeWm9VgehTONwRe6X1e+QyznhmgsLR1291
 cbPFYlHtdwkbM1aX7qC5SLB0lfuWUciCWap6cy5Q2YS8oLkPQT7x0epcwIpLJ2RFeEeZ
 gFT4e4psRjoe+T8O6jjLbUdhhAyAU8i5AZ199MiiD1Qmw+U4MwKV6SjGPKsUatxCc5IJ
 dHgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHgAGi70XCgRULuDilycBOpUvqpA1+p1R9AyMTYFJfTVQZljUm8NCAebgkyccOF7xJYa8UIzOYug==@nongnu.org
X-Gm-Message-State: AOJu0YzvpWWScGNHXrrcTipz0d9QKzfMPTcL4Sm+8aJ78xuQPjARo1bN
 zS0encqX8Ykj994Z51FQCsIT7O5fBRGFry30E6pCPKTWTnEsErI0ZjV8FQ==
X-Gm-Gg: ASbGnctmkL1MkYkSMF9GMUwJXW1SpqgKfpWlwH5tjU4HpkqA7fbbXcuJupqFtMN4/uG
 QDdpFEzLZ4pAklFm3D5rf97sqbWFXQ7BBFVo3UUUPFSnTiSwaenw0wecjavRHz5ybLAylqwV2Bw
 IXdcw50EQgihSQX0bPnTeCQd0li9Bm68syAhebBWfRIcfXBg0P99L2JgVHR9ovHE1WzgDG+nbmn
 D2UJFjE/IAz3nvPMls8U33gRG6vGsNspLhpZQPdTpB2CHtiC2xQUz6kI5FfbbCjh+lDE6urzwvJ
 6tu0LGRxxDwX3NEvQFFvpQ/mYHQN336AyUBRtBcoc4/scvup+ia4g9oPGzUBJo2Nf3yY4+dQ
X-Google-Smtp-Source: AGHT+IGBqHFtFUDRN/LntORiN4opnGqygXBjVh7tMBshQu6ejUrmysMTXNDU2NxJ35ZxDhbPtkpTvw==
X-Received: by 2002:a05:6402:3554:b0:5dc:5a34:1296 with SMTP id
 4fb4d7f45d1cf-5e0b70ef77dmr12639263a12.16.1740395051628; 
 Mon, 24 Feb 2025 03:04:11 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e09072247esm8696740a12.51.2025.02.24.03.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 03:04:11 -0800 (PST)
Date: Mon, 24 Feb 2025 11:04:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
CC: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 6/9] hw/char/imx_serial: Really use RX FIFO depth
In-Reply-To: <20250220092903.3726-7-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-7-philmd@linaro.org>
Message-ID: <82869227-447B-4B71-BBD4-6C4E1038D69E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 20=2E Februar 2025 09:28:59 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>While we model a 32-elements RX FIFO since the IMX serial
>model was introduced in commit 988f2442971 ("hw/char/imx_serial:
>Implement receive FIFO and ageing timer") we only read 1 char
>at a time!
>
>Have the IOCanReadHandler handler return how many elements are
>available, and use that in the IOReadHandler handler=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>Reviewed-by: Luc Michel <luc=2Emichel@amd=2Ecom>

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/char/imx_serial=2Ec | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/hw/char/imx_serial=2Ec b/hw/char/imx_serial=2Ec
>index 38b4865157e=2E=2E6f14f8403a9 100644
>--- a/hw/char/imx_serial=2Ec
>+++ b/hw/char/imx_serial=2Ec
>@@ -386,7 +386,8 @@ static void imx_serial_write(void *opaque, hwaddr off=
set,
> static int imx_can_receive(void *opaque)
> {
>     IMXSerialState *s =3D (IMXSerialState *)opaque;
>-    return s->ucr2 & UCR2_RXEN && fifo32_num_used(&s->rx_fifo) < FIFO_SI=
ZE;
>+
>+    return s->ucr2 & UCR2_RXEN ? fifo32_num_free(&s->rx_fifo) : 0;
> }
>=20
> static void imx_put_data(void *opaque, uint32_t value)
>@@ -417,7 +418,10 @@ static void imx_receive(void *opaque, const uint8_t =
*buf, int size)
>     IMXSerialState *s =3D (IMXSerialState *)opaque;
>=20
>     s->usr2 |=3D USR2_WAKE;
>-    imx_put_data(opaque, *buf);
>+
>+    for (int i =3D 0; i < size; i++) {
>+        imx_put_data(opaque, buf[i]);
>+    }
> }
>=20
> static void imx_event(void *opaque, QEMUChrEvent event)

