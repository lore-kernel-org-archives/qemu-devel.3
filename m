Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF62CC6B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHaMx-0008Vw-4z; Fri, 16 Oct 2026 01:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHaM5-0008Ku-7N
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:19:47 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHaM2-0000UF-JX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:19:44 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso1024363766b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 22:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792127980; cv=none;
 d=google.com; s=arc-20260327;
 b=glPgjXfiDIeUSmcG2qCK/hAIPR85qgPkNduMuCGykBy13eH/SDflv8pfNh2KCFfclh
 Sqb9swu2E7dsA69RqhCipCGyqPiCc+JmT0VjEU0DSZR0q/1lu+ByU9kWllPAVQKakkVH
 HHh32cGq9thpZ223tVxEJePWryEvXhAQUgsQFhS9InOEkzB7nh0Ox0mHKaLo0qRt9QNY
 p+SRZ4Lv7GUjVCTbz0BYsJGpk6iybaOs/qB7BMpmaf4BUjPW8ymj2mP5INjZbb6HzChn
 RtK6yLEHjdVE41NemguiZEPuyVY7ZoIT6gvciOROmKEFzL60MMq7/cKKU5D6Zio/9ipv
 mCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AVJ1CqkoH2yQSV7YAqFTmJwXnFv7L0XFLCFcyaejwN4=;
 fh=GA76ANjUD361el03lmL6rUbBTLkQP+WPxOJX8sqmvWA=;
 b=qsvXjuRfLQWUCCrzVpoCnMsFhoRG7CUrcqMdD3SKY4GtAtZZJgmXi6uR4NY30D4rXZ
 MO2/84mdPX6+nuYZqrv3UUZ3SL23wP20RUomd92808ap461xk8h8pofop0r+QJcOmnJ3
 5dSLcHGF8xpo1TAqOnQZQqezGV3KCWzgeF3EUya4MDrdQac7jbTfYdUvWiCODl6N7n1g
 ls/UsZceDfgQtOV19ZKsOob5vCJNz5GrPCi9MbHP4Ujh2q9hfpUASjowOXeG7dBTrDRZ
 q2b4NQp/oPEeOexhyYW/+GcXqkIgW0JhBe9cfSjQL5VWmIXiLJyf16VUM1471gsRSu9J
 FQrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792127980; x=1792732780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AVJ1CqkoH2yQSV7YAqFTmJwXnFv7L0XFLCFcyaejwN4=;
 b=ruBdrutMPCQyGPYJmEZyqJJgVNisp1peHo53a82xZWC0tO+7Jjpw2O+JmUJXb1H+8Z
 JRnOD25mmPke0uftmP6y9icy6+ToVvhmj8g69LZaLtliv2qv0Pbc6R597IXVbC+Ebx1S
 ec0P5HgDEVnvh08Utng274piMTxitcJTGheyfpiCRFnCUMl+FoOK4bGoTBglboG5S+2k
 bDYv2+SBxX1KtqHXkFUaLRXQIsSSyR/g57A6ZWrJ2Dpxcv3YEqj9lRgTxKNpu8UeY3CN
 BUCvdTdHLOcovmipmR96AVjYfZcUDU9hDJGB4IeFsPyNy6CxEHJuaMKgEd+CKA5eFZFq
 ym9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792127980; x=1792732780;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AVJ1CqkoH2yQSV7YAqFTmJwXnFv7L0XFLCFcyaejwN4=;
 b=Iyy05wspHnC51Zuc+2hfdGDy7/7+Pn/8drH+2tg1k4uNC21kJqqFBdgl2jEgUIgIvs
 xzZXUTYfImQAys/gB5e5H2/hdv3a0sdYemRtO6InHg8xqFaWK/zqgemb627MaUodAkzf
 Cr3+RlBHYXjlVrHIc/YHFnXzoLsYju4n29LPGMuIjjw2Hi97xl9NhwK6FWwXwVzXvVc2
 QJQUePO22RbYMJZxlKDEY+azz0YJkKCuffcow2/fm1xCxewgQbdiet4hyxEoDgTXYbgO
 Jurc/hvV3k/FUYgBWin1bNzkdCjkMMnfde91PPQbIhy1JGpQsMjWli1O8nrutTBxhDn6
 zTyg==
X-Gm-Message-State: AFq9FYLvX3kUPycOBTb1WwHLgsCz2ZdRSU3xoHCtokEdx9ApCRQJAV3a
 tKfrqO1mK8Uiui2SBFDbxVq46ykMboHHNEu32wNbbgVxdQKVZbmCheBpOEMSiri/vTctfa7kN6G
 PyeWGNisQO6Vqg52KUFF3jtfpg66W9x4=
X-Gm-Gg: AYBFou3KAgrS8NMYm8ijn+cwTDUa5DTzj02AC7SN11qCZaVrLskED7UMOcKu+uEFT2W
 P+Pw2W3kVbExkw6EdoGrWGkrAw3SB9ybl4gWBckxigPHibZ6Xq0x0ui6lWvvVBI+N34iTm42kaC
 +P3O4XzNOHXQKaqgtdMfgUNbJXxK7J3iMLM3jbfGBkgmUefOl7ZRunsug/p8E5YxVLzcO0BPiFK
 /ur0dtaKf71vRnc7FP1vI5gRB8gqYaIdQzoRtswWQs8V839ytUoJ0fR3XXuzEkJtyy7nFe+7E7F
 0MHlNz10ZUS1zw7NwMlkeuvnVh9GpaIOYYsDWUQAntCjOTGBqTRQEXCF
X-Received: by 2002:a17:907:970b:b0:c40:cee7:3917 with SMTP id
 a640c23a62f3a-c40cee73cf0mr31123666b.42.1792127979464; Thu, 15 Oct 2026
 22:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
 <20261015-bmc-clemente-v1-11-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-11-bf591886b5b6@free.fr>
From: =?UTF-8?B?5p6X5bu65piO?= <jaminlin1207@gmail.com>
Date: Fri, 16 Oct 2026 13:19:27 +0800
X-Gm-Features: AclHuK80cgbUGlWdorA_FjblWMtD9i_voKemJuppr1CAYGkRKW3FuBVPHiBhfN4
Message-ID: <CA+8rw5zOT1D+1JMYL5Wz-No_xpUq1spSgdKp2Oc42uS9vs3ABQ@mail.gmail.com>
Subject: Re: [PATCH 11/22] hw/arm/aspeed: use the TMP421 type-name macros
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=jaminlin1207@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Emmanuel Blot via qemu development <qemu-devel@nongnu.org> =E6=96=BC
2026=E5=B9=B410=E6=9C=8815=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:=
12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Include the new tmp421.h and refer to the sensor variants through
> TYPE_TMP421/TYPE_TMP422/TYPE_TMP423 instead of open-coded string
> literals and per-board local defines.
>
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/arm/aspeed_ast2400_palmetto.c          |  3 ++-
>  hw/arm/aspeed_ast2400_supermicrox11.c     |  3 ++-
>  hw/arm/aspeed_ast2500_supermicro-x11spi.c |  3 ++-
>  hw/arm/aspeed_ast2500_tiogapass.c         | 10 +++++++---
>  hw/arm/aspeed_ast2500_witherspoon.c       |  7 +++++--
>  hw/arm/aspeed_ast2500_yosemitev2.c        | 10 +++++++---
>  hw/arm/aspeed_ast2600_bletchley.c         |  3 +--
>  hw/arm/aspeed_ast2600_catalina.c          |  3 +--
>  hw/arm/aspeed_ast2600_fby35.c             |  2 +-
>  hw/arm/aspeed_ast2600_fuji.c              |  3 +--
>  hw/arm/aspeed_ast2600_rainier.c           | 13 +++++++++----
>  11 files changed, 38 insertions(+), 22 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_pal=
metto.c
> index 185185f0bb..7b165394c2 100644
> --- a/hw/arm/aspeed_ast2400_palmetto.c
> +++ b/hw/arm/aspeed_ast2400_palmetto.c
> @@ -12,6 +12,7 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/rtc/ds1338.h"
> +#include "hw/sensor/tmp421.h"
>
>  /* Palmetto hardware value: 0x120CE416 */
>  #define PALMETTO_BMC_HW_STRAP1 (                                        =
\
> @@ -45,7 +46,7 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *b=
mc)
>
>      /* add a TMP423 temperature sensor */
>      dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,=
 2),
> -                                         "tmp423", 0x4c));
> +                                         TYPE_TMP423, 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_a=
bort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_a=
bort);
>      object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_a=
bort);
> diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast240=
0_supermicrox11.c
> index 051e072c5a..fd2fda9290 100644
> --- a/hw/arm/aspeed_ast2400_supermicrox11.c
> +++ b/hw/arm/aspeed_ast2400_supermicrox11.c
> @@ -12,6 +12,7 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/rtc/ds1338.h"
> +#include "hw/sensor/tmp421.h"
>
>  /* TODO: Find the actual hardware value */
>  #define SUPERMICROX11_BMC_HW_STRAP1 (                                   =
\
> @@ -45,7 +46,7 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineSta=
te *bmc)
>
>      /* add a TMP423 temperature sensor */
>      dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,=
 2),
> -                                         "tmp423", 0x4c));
> +                                         TYPE_TMP423, 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_a=
bort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_a=
bort);
>      object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_a=
bort);
> diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_as=
t2500_supermicro-x11spi.c
> index dc0248422d..1ea61348f6 100644
> --- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> +++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> @@ -12,6 +12,7 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/rtc/ds1338.h"
> +#include "hw/sensor/tmp421.h"
>
>  /* TODO: Find the actual hardware value */
>  #define SUPERMICRO_X11SPI_BMC_HW_STRAP1 (                               =
\
> @@ -41,7 +42,7 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachin=
eState *bmc)
>
>      /* add a TMP423 temperature sensor */
>      dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,=
 2),
> -                                         "tmp423", 0x4c));
> +                                         TYPE_TMP423, 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_a=
bort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_a=
bort);
>      object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_a=
bort);
> diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_ti=
ogapass.c
> index 6cb567526c..5433198abd 100644
> --- a/hw/arm/aspeed_ast2500_tiogapass.c
> +++ b/hw/arm/aspeed_ast2500_tiogapass.c
> @@ -11,6 +11,7 @@
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/sensor/tmp421.h"
>
>  /* value: 0xF100C2E6 */
>  #define TIOGAPASS_BMC_HW_STRAP1 ((                                      =
  \
> @@ -54,9 +55,12 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState =
*bmc)
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 * =
KiB,
>                            tiogapass_bmc_fruid, tiogapass_bmc_fruid_len);
>      /* TMP421 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421", =
0x1f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", =
0x4f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421", =
0x4e);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +                            TYPE_TMP421, 0x1f);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +                            TYPE_TMP421, 0x4f);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +                            TYPE_TMP421, 0x4e);
>  }
>
>  static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
> diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_=
witherspoon.c
> index c69065846c..385deb2154 100644
> --- a/hw/arm/aspeed_ast2500_witherspoon.c
> +++ b/hw/arm/aspeed_ast2500_witherspoon.c
> @@ -12,6 +12,7 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/misc/led.h"
>  #include "hw/sensor/tmp105.h"
> +#include "hw/sensor/tmp421.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/gpio/pca9552.h"
>  #include "hw/rtc/ds1338.h"
> @@ -60,8 +61,10 @@ static void witherspoon_bmc_i2c_init(AspeedMachineStat=
e *bmc)
>      }
>      i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", =
0x76);
>      i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785"=
, 0x52);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", =
0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", =
0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +                            TYPE_TMP423, 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +                            TYPE_TMP423, 0x4c);
>
>      /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
>      i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP10=
5,
> diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_y=
osemitev2.c
> index 3ba1ed5f6f..3dd0d37175 100644
> --- a/hw/arm/aspeed_ast2500_yosemitev2.c
> +++ b/hw/arm/aspeed_ast2500_yosemitev2.c
> @@ -11,6 +11,7 @@
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/sensor/tmp421.h"
>
>  /* value: 0xF100C2E6 */
>  #define YOSEMITEV2_BMC_HW_STRAP1 ((                                     =
   \
> @@ -54,9 +55,12 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState=
 *bmc)
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * =
KiB,
>                            yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len=
);
>      /* TMP421 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421",=
 0x1f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", =
0x4e);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421", =
0x4f);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +                            TYPE_TMP421, 0x1f);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            TYPE_TMP421, 0x4e);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            TYPE_TMP421, 0x4f);
>
>  }
>
> diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bl=
etchley.c
> index 0e746055a2..536e910229 100644
> --- a/hw/arm/aspeed_ast2600_bletchley.c
> +++ b/hw/arm/aspeed_ast2600_bletchley.c
> @@ -13,8 +13,7 @@
>  #include "hw/gpio/pca9552.h"
>  #include "hw/nvram/eeprom_at24c.h"
>  #include "hw/rtc/ds1338.h"
> -
> -#define TYPE_TMP421 "tmp421"
> +#include "hw/sensor/tmp421.h"
>  /* Bletchley hardware value */
>  #define BLETCHLEY_BMC_HW_STRAP1 0x00002000
>  #define BLETCHLEY_BMC_HW_STRAP2 0x00000801
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_cat=
alina.c
> index b15d932086..13dca7a846 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -16,14 +16,13 @@
>  #include "hw/nvram/eeprom_at24c.h"
>  #include "hw/rtc/ds1338.h"
>  #include "hw/sensor/tmp105.h"
> +#include "hw/sensor/tmp421.h"
>
>  /* Catalina hardware value */
>  #define CATALINA_BMC_HW_STRAP1 0x00002002
>  #define CATALINA_BMC_HW_STRAP2 0x00000800
>  #define CATALINA_BMC_RAM_SIZE (2 * GiB)
>
> -#define TYPE_TMP421 "tmp421"
> -
>  /*
>   * "BMC Storage Module" FRU data.  Generated with frugen.
>   *
> diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.=
c
> index 28c9c143d8..25f39d5135 100644
> --- a/hw/arm/aspeed_ast2600_fby35.c
> +++ b/hw/arm/aspeed_ast2600_fby35.c
> @@ -12,10 +12,10 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/nvram/eeprom_at24c.h"
>  #include "hw/sensor/tmp105.h"
> +#include "hw/sensor/tmp421.h"
>  #include "system/reset.h"
>
>  #define TYPE_LM75 TYPE_TMP105
> -#define TYPE_TMP421 "tmp421"
>  #define FBY35_BMC_RAM_SIZE (2 * GiB)
>
>  static const uint8_t fby35_nic_fruid[] =3D {
> diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
> index 08d809b2fd..526494ecfe 100644
> --- a/hw/arm/aspeed_ast2600_fuji.c
> +++ b/hw/arm/aspeed_ast2600_fuji.c
> @@ -12,10 +12,9 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/i2c/i2c_mux_pca954x.h"
>  #include "hw/sensor/tmp105.h"
> +#include "hw/sensor/tmp421.h"
>  #include "hw/nvram/eeprom_at24c.h"
>
> -#define TYPE_TMP422 "tmp422"
> -
>  /* Fuji hardware value */
>  #define FUJI_BMC_HW_STRAP1    0x00000000
>  #define FUJI_BMC_HW_STRAP2    0x00000000
> diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rain=
ier.c
> index 43a8f01a9e..bdbc78aee7 100644
> --- a/hw/arm/aspeed_ast2600_rainier.c
> +++ b/hw/arm/aspeed_ast2600_rainier.c
> @@ -13,6 +13,7 @@
>  #include "hw/nvram/eeprom_at24c.h"
>  #include "hw/i2c/i2c_mux_pca954x.h"
>  #include "hw/sensor/tmp105.h"
> +#include "hw/sensor/tmp421.h"
>
>  /* Rainier hardware value: (QEMU prototype) */
>  #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SR=
C_EMMC)
> @@ -137,12 +138,16 @@ static void rainier_bmc_i2c_init(AspeedMachineState=
 *bmc)
>      /* Bus 8: ucd90320@b */
>      /* Bus 8: ucd90320@c */
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", =
0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", =
0x4d);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            TYPE_TMP423, 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            TYPE_TMP423, 0x4d);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB)=
;
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423",=
 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423",=
 0x4d);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +                            TYPE_TMP423, 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +                            TYPE_TMP423, 0x4d);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB=
);
>
>      i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP1=
05,
>
> --
> 2.53.0-Meta
>
>

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

