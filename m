Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D6ACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZB5c-0001ox-1t; Mon, 15 Jun 2026 13:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wZB5a-0001oe-FS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:27:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wZB5Y-00004r-4O
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:27:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so2708931f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781544426; x=1782149226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2rHLzSIGXlCuUR9ZnsAYy2289TpLd/mMk0h6LJx/nM=;
 b=mBlGvKdMeR+F7h1eJuKDpPoEa855nQeU50lOnZmWSUZMpOZzPh533H9WzziOUbO2C8
 KrtIUe1rcWLdPoxOQxTQeZwiYZOOANsIYAuKOFvcvLb64tGyEbT9+bGpBKiuJfn98gSh
 PmD5qfyDwSNztkjegAtJeqYMTRuZWzVMxQaeCJpdfrj5aOdDuvnhvsB2xxOJMmFtfWKO
 WkuRFbcjPqPE1foE488rAXkwwWPTF6Rlrjw7mBZg1qrVGAOGj7qLKEtEi+Pydm8VEBPt
 BKnEXzY6KYIGRNp89DoFErW7Qr14iESnL6K0MbiTlQRXpS0zrp+jmk09AZeykGN+Rgmw
 Kj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781544426; x=1782149226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u2rHLzSIGXlCuUR9ZnsAYy2289TpLd/mMk0h6LJx/nM=;
 b=E0SGzEsA81dJwwqUrx+T+n9Rtrt9K90JQ3jKf+qZXtBGbdl7+v/F1rWW2mvxbw89eh
 qsas/kxsJwMAac3+VuMggsiPmbg4e3HL3GuF/7eePbmscT0bfUkx4lkv6ugI9nL1gdcG
 LDg4g0RXyq1sk1NPIAKLlIoksVo6eV6c9fXnR/3yrPwQ3WWcGUxWOxATtKBhMfAVnoJn
 EYj8FPs02zEytIQBcaYvFgixWS1pOZeZeDCgRAJx+QB2iBFzKKaG0U0vCJ/42XIk+Xo3
 6hKjq5yZ6/80rjDJB6pIduxD4QR1dsFxGHW174MkUE1TgfCtIPhoK/qWuf3C8LfWpg/I
 zfaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/QrcnzsUBUYvzUtVQ7e13/rzuAngXnz26k9vaPax7rViq55EX5R7xnpBDp8Sw8uIt5VJQajjwGblx@nongnu.org
X-Gm-Message-State: AOJu0YxpxENgAitm7tJmoT2cj/g60BMmjuZMaUzm8XSeQwalb55V6nMC
 93lIgyRQ/WBTzedWBdnZTtgTSASQxl9ICHATy/xuef/U3sPNcyebaLwr
X-Gm-Gg: Acq92OHMYxteC9q/pQHbOFftV3X6aP1CTCoOIrM29Cq7ywgYLCtcNjg+ZX1Q1d/SaYT
 vVJLy3tgbxe3WukUNRz2IE4m+7n2voqTlql9SIrnesUaWjws1saCgGHQEdb9JarcMsx/tdbY5fV
 7Nd9mQzg7R8jArovvW686TvAmOdzFyChE9BHIcP3LY6KFAzlQ7HjN86LJVWhEvIqbk59VF9aA78
 aeDj9vfT3I6OGXu2V9sDZ6VN6tVgQPBmuvRynkR056a3+PqjGFHgVzw3kN62oTnyZXDrhkPtnFb
 1nxbLDfa9mdBtBJ0OzFjRnrsOg5o55MCoxGJNVb2qVgT1uoljcdVXkSQj70lULqjLxk0T7U+N2/
 MaOq10/WT7oncqRx+eRatWnnK5R20F9FAFvnB50Q3qtsawMjBvSh1GdjLADEGbImzV2A9meobhf
 vRpe44zugiJaQv+A5QoijxkILycz/ILW0D2c2DVzM9MPPSu0zEAOP9ftNxiJIZzVSXZ2kmAavgs
 wEch74=
X-Received: by 2002:a05:6000:605:b0:45e:f2bd:2b16 with SMTP id
 ffacd0b85a97d-4619f394985mr503102f8f.18.1781544425648; 
 Mon, 15 Jun 2026 10:27:05 -0700 (PDT)
Received: from [192.168.25.24] (176\032-\032141-38-234.abo.bbox.fr.
 [176.141.38.234]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d28sm37363193f8f.20.2026.06.15.10.27.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2026 10:27:05 -0700 (PDT)
From: eblot.ml@gmail.com
To: Alexander Hansen <alexander.hansen@9elements.com>
Cc: Titus Rwantare <titusr@google.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 3/5] hw/sensor: MAX31790 support
Date: Mon, 15 Jun 2026 19:27:00 +0200
X-Mailer: MailMate (2.0r6290)
Message-ID: <866BCB0A-6CC6-41E4-914D-D38826F52550@gmail.com>
In-Reply-To: <20260610122252.349321-4-alexander.hansen@9elements.com>
References: <20260610122252.349321-4-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_E15DB50C-6010-443D-A88B-1FB3A50DA26A_="
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=eblot.ml@gmail.com; helo=mail-wr1-x42f.google.com
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


--=_MailMate_E15DB50C-6010-443D-A88B-1FB3A50DA26A_=
Content-Type: text/plain; charset=UTF-8; format=flowed; markup=markdown
Content-Transfer-Encoding: 8bit


On 10 Jun 2026, at 14:21, Alexander Hansen wrote:

> diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c
> new file mode 100644
> index 0000000000..f0aaff84b5
> --- /dev/null
> +++ b/hw/sensor/max31790.c

> +#define TYPE_MAX31790 "max31790"

Might be nice to define it in a .h so machines can use the constant?

> +
> +#define MAX31790_NUM_FANS 6
> +#define MAX31790_NUM_TACHS 12
> +
> +#define MAX31790_REG_GLOBAL_CONFIG 0x00
> +#define MAX31790_REG_PWM_FREQ 0x01
> +
> +/* 0x02 to 0x07: N = 0 .. 5 */
> +#define MAX31790_REG_FAN_CONFIG(N) (0x02 + N)

Maybe use (0x02 + (N))?

> +    switch (s->pointer) {
> +    case MAX31790_REG_FAN_CONFIG(0):
> +    case MAX31790_REG_FAN_CONFIG(1):
> +    case MAX31790_REG_FAN_CONFIG(2):
> +    case MAX31790_REG_FAN_CONFIG(3):
> +    case MAX31790_REG_FAN_CONFIG(4):
> +    case MAX31790_REG_FAN_CONFIG(5):

Maybe use case ranges?

> +    /* simplified, assuming NP = 2 */
> +    uint64_t tach_count =  (245760ULL * sr) / (uint64_t)rpm;

Maybe use (some) explicit constants?

> +static void max31790_realize(DeviceState *dev, Error **errp)
> +{
> +    MAX31790State *s = MAX31790(dev);
> +
> +    trace_max31790_realize(s->i2c.address);
> +
> +    max31790_reset_enter(s);

Initial reset is usually called from the SoC reset sequence (through 
bus_reset_child_foreach), is this explicit reset required?

> +static void max31790_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +
> +    dc->realize = max31790_realize;
> +    dc->desc = "Maxim MAX31790 6-Channel Fan Controller";
> +    dc->vmsd = &vmstate_max31790;
> +    dc->legacy_reset = max31790_reset;

Maybe favor the “new” Resettable API, rather than the legacy reset 
API?

--=_MailMate_E15DB50C-6010-443D-A88B-1FB3A50DA26A_=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8"=
>
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" sty=
le=3D"white-space: normal;">
<p dir=3D"auto">On 10 Jun 2026, at 14:21, Alexander Hansen wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c<=
br>
new file mode 100644<br>
index 0000000000..f0aaff84b5<br>
--- /dev/null<br>
+++ b/hw/sensor/max31790.c</p>
</blockquote>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+#define TYPE_MAX31790 &quot;max31790&quot;</p>
</blockquote>
<p dir=3D"auto">Might be nice to define it in a .h so machines can use th=
e constant?</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<ul>
<li></li>
</ul>
<p dir=3D"auto">+#define MAX31790_NUM_FANS 6<br>
+#define MAX31790_NUM_TACHS 12<br>
+<br>
+#define MAX31790_REG_GLOBAL_CONFIG 0x00<br>
+#define MAX31790_REG_PWM_FREQ 0x01<br>
+<br>
+/* 0x02 to 0x07: N =3D 0 .. 5 */<br>
+#define MAX31790_REG_FAN_CONFIG(N) (0x02 + N)</p>
</blockquote>
<p dir=3D"auto">Maybe use (0x02 + (N))?</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<ul>
<li>switch (s-&gt;pointer) {</li>
<li>case MAX31790_REG_FAN_CONFIG(0):</li>
<li>case MAX31790_REG_FAN_CONFIG(1):</li>
<li>case MAX31790_REG_FAN_CONFIG(2):</li>
<li>case MAX31790_REG_FAN_CONFIG(3):</li>
<li>case MAX31790_REG_FAN_CONFIG(4):</li>
<li>case MAX31790_REG_FAN_CONFIG(5):</li>
</ul>
</blockquote>
<p dir=3D"auto">Maybe use case ranges?</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<ul>
<li>/* simplified, assuming NP =3D 2 */</li>
<li>uint64_t tach_count =3D  (245760ULL * sr) / (uint64_t)rpm;</li>
</ul>
</blockquote>
<p dir=3D"auto">Maybe use (some) explicit constants?</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+static void max31790_realize(DeviceState *dev, Error **e=
rrp)<br>
+{</p>
<ul>
<li>MAX31790State *s =3D MAX31790(dev);</li>
<li></li>
<li>trace_max31790_realize(s-&gt;i2c.address);</li>
<li></li>
<li>max31790_reset_enter(s);</li>
</ul>
</blockquote>
<p dir=3D"auto">Initial reset is usually called from the SoC reset sequen=
ce (through bus_reset_child_foreach), is this explicit reset required?</p=
>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+static void max31790_class_init(ObjectClass *klass, cons=
t void *data)<br>
+{</p>
<ul>
<li>DeviceClass *dc =3D DEVICE_CLASS(klass);</li>
<li>I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);</li>
<li></li>
<li>dc-&gt;realize =3D max31790_realize;</li>
<li>dc-&gt;desc =3D &quot;Maxim MAX31790 6-Channel Fan Controller&quot;;<=
/li>
<li>dc-&gt;vmsd =3D &amp;vmstate_max31790;</li>
<li>dc-&gt;legacy_reset =3D max31790_reset;</li>
</ul>
</blockquote>
<p dir=3D"auto">Maybe favor the =E2=80=9Cnew=E2=80=9D Resettable API, rat=
her than the legacy reset API?</p>

</div>
</div>
</body>

</html>

--=_MailMate_E15DB50C-6010-443D-A88B-1FB3A50DA26A_=--

