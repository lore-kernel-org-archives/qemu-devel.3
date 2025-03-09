Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B2C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trHAL-0000BA-QQ; Sun, 09 Mar 2025 09:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1trHAG-0008M0-0v; Sun, 09 Mar 2025 09:58:00 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1trHAD-0004cs-HZ; Sun, 09 Mar 2025 09:57:59 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e686d39ba2so731667a12.2; 
 Sun, 09 Mar 2025 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741528674; x=1742133474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGOFhqq8xZjLJLZpXBpqOLMSlDZOmUGoy6LwPZ9M/0U=;
 b=XBz8bSHSgJ93iKWezQtGnHaBN0N8QVCVbmKe1gqFRpyPkGUTzI5wPeNMRQ7brUvqrP
 U2+LNtZPmaDUNKQqQ+ylR+La3K0ple3mW+turRZA4hZpSn9ug4XZkt7ZQT8JZZ77+UWJ
 +i5XG/wwaTLKhYY0O0qt94pmJtZn4aHgBNEtdGolF2CTb5OUxMO7ZZ2ezHhCz8MN6A5t
 1+2P/N/vAMBPaWlBf9Q3nfWIpbYIafSQxAKGI9ZfSY/PGYVm1WURsiUwBuAXGb2LnMsm
 t4aePKrWbubAo2mBwEsYHhwx562sCHSboozPg6g+pCWCpw7X59Oa6QnWbf4xuwH0O9Vv
 /uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741528674; x=1742133474;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGOFhqq8xZjLJLZpXBpqOLMSlDZOmUGoy6LwPZ9M/0U=;
 b=m3eWChjmwsmn7kh3vwy0zCC9az9Pa0rw2YOdcHkiBbTKNpBZHdjDLh0gfAMMqTxzS0
 atRESesWtsdPEQo+vKxrtAXECGDXoVm94k/8phPQkRoenAQzHUhNeU05rtCv59q9sDu5
 3bqUps4GuuIU3tPTsQ4w83VLJnVpfF/ZlmR07XZTSGo95wFnMdTs8GuCD7zjjcPF4tus
 o1j12l1JFlVLDOW1N6ngYlyQoShcD2NASMpgDPgvvzyE9ObogdiYOxL1ySGUzCn/qLGN
 X5PalPTQVWCQAbecDnd3w3iiIyeMw8omF9gpIDywgP/CyFTNcsuIGod7sAUzHJcVrQ0b
 QiOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Rkt/D2ux4QpYFZImYF5qnLpFkYPHZ9Hs6XIB5SQHgcyDb3cqMYW0L/697HOrN4u5VZX091qCA+nHoQ==@nongnu.org,
 AJvYcCXXE0Dgh4MC0rgs0+EN+7f/HaMk1OK8UO/KQ5e/xpoIGUfjBD/zs1B6f7neFEWNZhIkLDQFi6hQbSk=@nongnu.org,
 AJvYcCXfkA+aRqCRABrcefS8O6JloFZAMp1Dr6A72qC6zMHiFEfq6kZdgmyWPF0nB+duwsrOndJfw3NCIw==@nongnu.org,
 AJvYcCXq/fBfcJRRXPQfNr99c2lmVbCaOaBrmaz9xG4RR/Oa5lhfDigv8hkJOqDXEipGXuKyRbF9n5V9dUyZCQ==@nongnu.org
X-Gm-Message-State: AOJu0YwO0ulRv4hA08bViu9/UrxnMx/AQRtWY2rMt+O+Q8FAyEKYipwH
 eCBkcqDIkO9toZs3dZ9IMeLPY7Y/jqMFGLtdWi4VInn0yaAD5QGS
X-Gm-Gg: ASbGncuTGXOsxd0WB0pI3UJWM/+U2PqDpnxTFkB+N1qB+moXHmJDtaIKO6ewqxqDeh+
 8NGDaYoZFkPu1r8AgKs5JkJqlMnNhx7Tqs0VgODisI9RZxwSKpVK/8ivbJWBRmIHxNDzbHQRVar
 c/M7HXwh6+yyOpvMigshT7OoLZtRsbYiwpKIOfKjCwE3Xxfrxs/Xmf39tnkWUQi7emzqSccKYQU
 Rx7+JZu3n47fHfTx8HC+Icrb6MpK8hyid8UZ1upmkGTJ+D/ucsBwCtDM5nfo0hn8R26cjvd0QVU
 JFJLY+LsgWON4WhvAW25/R9vOlCcLNvGz0HuZS6GfHjS8MhQaQO8BgB7xxI0EvRrdh+gNJhSJEn
 DKtXuqvAIAgTFRQ4AbyYo/duj/OHWYYDDC/pS0tDex+R3OHLT7COP
X-Google-Smtp-Source: AGHT+IF27dKvIUYLn1cWfk2KEpTQjVJ2Y2tC+8dOnB7lxKWEnOJpK6//OFmWsZ8lJEzrHDWZ9WshNQ==
X-Received: by 2002:a17:907:9691:b0:ac2:4db0:1d22 with SMTP id
 a640c23a62f3a-ac252f49992mr1167459366b.42.1741528673533; 
 Sun, 09 Mar 2025 06:57:53 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1a10-8c00-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:1a10:8c00:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23948432dsm594052866b.44.2025.03.09.06.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 06:57:53 -0700 (PDT)
Date: Sun, 09 Mar 2025 13:57:51 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
CC: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_02/14=5D_hw/sd/sdhci=3A_Rem?=
 =?US-ASCII?Q?ove_need_for_SDHCIState=3A=3Avendor_field?=
In-Reply-To: <20250308213640.13138-3-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-3-philmd@linaro.org>
Message-ID: <4587F1C4-D846-4158-9755-2F913B5A0ED9@gmail.com>
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



Am 8=2E M=C3=A4rz 2025 21:36:28 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>All instances of TYPE_IMX_USDHC set vendor=3DSDHCI_VENDOR_IMX=2E
>No need to special-case it=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/sd/sdhci-internal=2Eh |  1 -
> include/hw/sd/sdhci=2Eh  |  4 ----
> hw/arm/fsl-imx25=2Ec     |  2 --
> hw/arm/fsl-imx6=2Ec      |  2 --
> hw/arm/fsl-imx6ul=2Ec    |  2 --
> hw/arm/fsl-imx7=2Ec      |  2 --
> hw/arm/fsl-imx8mp=2Ec    |  2 --
> hw/sd/sdhci=2Ec          | 14 ++++----------
> 8 files changed, 4 insertions(+), 25 deletions(-)
>
>diff --git a/hw/sd/sdhci-internal=2Eh b/hw/sd/sdhci-internal=2Eh
>index 9f768c418e0=2E=2E9072b06bdde 100644
>--- a/hw/sd/sdhci-internal=2Eh
>+++ b/hw/sd/sdhci-internal=2Eh
>@@ -311,7 +311,6 @@ extern const VMStateDescription sdhci_vmstate;
>     DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_EN=
DIAN), \
>     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
>     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
>-    DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
>     \
>     /* Capabilities registers provide information on supported
>      * features of this specific host controller implementation */ \
>diff --git a/include/hw/sd/sdhci=2Eh b/include/hw/sd/sdhci=2Eh
>index 38c08e28598=2E=2E48247e9a20f 100644
>--- a/include/hw/sd/sdhci=2Eh
>+++ b/include/hw/sd/sdhci=2Eh
>@@ -99,7 +99,6 @@ struct SDHCIState {
>     uint8_t endianness;
>     uint8_t sd_spec_version;
>     uint8_t uhs_mode;
>-    uint8_t vendor;        /* For vendor specific functionality */
>     /*
>      * Write Protect pin default active low for detecting SD card
>      * to be protected=2E Set wp_inverted to invert the signal=2E
>@@ -108,9 +107,6 @@ struct SDHCIState {
> };
> typedef struct SDHCIState SDHCIState;
>=20
>-#define SDHCI_VENDOR_NONE       0
>-#define SDHCI_VENDOR_IMX        1
>-
> /*
>  * Controller does not provide transfer-complete interrupt when not
>  * busy=2E
>diff --git a/hw/arm/fsl-imx25=2Ec b/hw/arm/fsl-imx25=2Ec
>index 5359a6d8d3b=2E=2E02214ca1a1c 100644
>--- a/hw/arm/fsl-imx25=2Ec
>+++ b/hw/arm/fsl-imx25=2Ec
>@@ -243,8 +243,6 @@ static void fsl_imx25_realize(DeviceState *dev, Error=
 **errp)
>                                  &error_abort);
>         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
>                                  IMX25_ESDHC_CAPABILITIES, &error_abort)=
;
>-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
>-                                 SDHCI_VENDOR_IMX, &error_abort);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
>             return;
>         }
>diff --git a/hw/arm/fsl-imx6=2Ec b/hw/arm/fsl-imx6=2Ec
>index dc86338b3a5=2E=2Ea114dc0d63d 100644
>--- a/hw/arm/fsl-imx6=2Ec
>+++ b/hw/arm/fsl-imx6=2Ec
>@@ -327,8 +327,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error =
**errp)
>                                  &error_abort);
>         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
>                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
>-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
>-                                 SDHCI_VENDOR_IMX, &error_abort);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
>             return;
>         }
>diff --git a/hw/arm/fsl-imx6ul=2Ec b/hw/arm/fsl-imx6ul=2Ec
>index 34c4aa15cd0=2E=2Ece8d3ef535f 100644
>--- a/hw/arm/fsl-imx6ul=2Ec
>+++ b/hw/arm/fsl-imx6ul=2Ec
>@@ -531,8 +531,6 @@ static void fsl_imx6ul_realize(DeviceState *dev, Erro=
r **errp)
>             FSL_IMX6UL_USDHC2_IRQ,
>         };
>=20
>-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
>-                                 SDHCI_VENDOR_IMX, &error_abort);
>         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
>=20
>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
>diff --git a/hw/arm/fsl-imx7=2Ec b/hw/arm/fsl-imx7=2Ec
>index 3374018cde0=2E=2Eed1f10bca26 100644
>--- a/hw/arm/fsl-imx7=2Ec
>+++ b/hw/arm/fsl-imx7=2Ec
>@@ -471,8 +471,6 @@ static void fsl_imx7_realize(DeviceState *dev, Error =
**errp)
>             FSL_IMX7_USDHC3_IRQ,
>         };
>=20
>-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
>-                                 SDHCI_VENDOR_IMX, &error_abort);
>         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
>=20
>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
>diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>index 1ea98e14635=2E=2Ec3f6da63220 100644
>--- a/hw/arm/fsl-imx8mp=2Ec
>+++ b/hw/arm/fsl-imx8mp=2Ec
>@@ -524,8 +524,6 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
r **errp)
>             { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3]=2Eaddr, FSL_IMX8MP_US=
DHC3_IRQ },
>         };
>=20
>-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
>-                                 SDHCI_VENDOR_IMX, &error_abort);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
>             return;
>         }
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index 1f45a77566c=2E=2E149b748cbee 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -1731,16 +1731,10 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t=
 val, unsigned size)
>=20
>     case USDHC_VENDOR_SPEC:
>         s->vendor_spec =3D value;
>-        switch (s->vendor) {
>-        case SDHCI_VENDOR_IMX:
>-            if (value & USDHC_IMX_FRC_SDCLK_ON) {
>-                s->prnsts &=3D ~SDHC_IMX_CLOCK_GATE_OFF;
>-            } else {
>-                s->prnsts |=3D SDHC_IMX_CLOCK_GATE_OFF;
>-            }
>-            break;
>-        default:
>-            break;
>+        if (value & USDHC_IMX_FRC_SDCLK_ON) {
>+            s->prnsts &=3D ~SDHC_IMX_CLOCK_GATE_OFF;
>+        } else {
>+            s->prnsts |=3D SDHC_IMX_CLOCK_GATE_OFF;
>         }
>         break;
>=20

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

