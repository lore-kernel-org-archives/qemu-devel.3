Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40863CC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWZn-0003Ai-E0; Tue, 13 Oct 2026 03:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWZV-000395-Au
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:05:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWZQ-0006b6-Rx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:05:11 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2e7496f947so411128866b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 00:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791875107; cv=none;
 d=google.com; s=arc-20260327;
 b=lsx4VCYU0YnVBIxhUmE6/Xgq0Y7Ij+rsoViE9BtIAsMds4CkReI2twua9/6FqqMEBr
 ooov/hP2SDloQD5AHIQFOPx/EzbQH1Z9GS4JYbAz6d0qRhjK5usmsWVqvyMIhGPfNpDn
 1BI0m/MyolqB1UJy/BRhp2iJnMS0ZtMhpjTfS2jIejwlNoEgHJQyJ0tmOHDx12ffFVWh
 5/7C80SG2ZKprfflHjHeJiOac+KEuIQZyWV1jdtojAfxsfrUk/F3zTwUpM2XbyrSgOQi
 1MEkHp6DT4EWEbXKQO15iVl7wRVi7BMgA4gVbCX4sF/oLpHwYVuosvrnoGetihTe+Ghb
 9Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QKTLzq9CdpA1mNZAPgqz2tucfLdbTZz5at+EsA2M9eQ=;
 fh=GM/I2I6fEf5qvJbdhgjZMuNCECIEwt8XqdRDAWXnLqc=;
 b=dtnwXWfn0J5wNZHla6gi8hK+BOur9Ze42Y98OlZ/yhcsT9JuKnMNiYX6Fb/v1N7Mpt
 0zvFbtFAoGSntoftoqfSy/+xb8SkS2+zft8fCv+5mn0KS1S68tbMOSf0/s1u9jtWom2j
 nKLBqaaQhoLBIeYgNWp3oOeQ+9a1nYImQ8kqvI5+bSjzwO8hOsvbLeNZZmoDthH3tzpy
 VJbw4jxEwCNQuBTRH8ztVKnqspj8eqP263Ef1vpssVlU+h4QQaQ9Gi+zijcgUr8Ni1jP
 0NHwfivlT2C4SlhRRVbGJ16Mx/I4n1iqW7omRE3bDwCkJsQd1GoWlQuV7S9SVYiCU0w/
 Mgzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791875107; x=1792479907; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QKTLzq9CdpA1mNZAPgqz2tucfLdbTZz5at+EsA2M9eQ=;
 b=ks9bwDcgOB5Ewq9I15ll95AgCTsf2mSl6mGQSUi68pNg9h+ksg9v9WcGqmk0Tk0xHp
 eN1SzODgoUL7T8pIOibCbOi1JaNETH0MVCD3+/hXh/Bcj1JjKogoGOS2evGyij5obV+j
 e8ljvFXngqbJdJitm4fwIaZsV9kD3ozdFD/ia/Ml36EuHifUjcAvAOINmsidpuZRuDn4
 nHAFZTBd0AAvCsjKjm6UbNMQKJAenCc9GBJ0v7U40H6nmX/gw6Te1vw1JVvJZZgo1zlA
 grCnHwSJz3tkd9LGl+ozWr52rZQGejsWCGhNXN8YHlr1zGhN1N+DIljYJ/a4jknUFuSg
 IGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791875107; x=1792479907;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QKTLzq9CdpA1mNZAPgqz2tucfLdbTZz5at+EsA2M9eQ=;
 b=qnAkoi3gOg4/oV2gWPXTzK6DFFH6F8HdNOgdGYgco8HXoNX87Ui2LPD7cwsdIdh+VT
 O81VetWIdRsZYcNj7LBDmqzmORZelJgm3wxSKSfUeOpdZ5w6f1FrhvR4ZmV0AJ50hcOg
 RatChz4jYbSEDL4t8Q6/LjLuO1sl1lssSv8pkYNOIPUWMi4HZEE6yHPSqrxjzosSXLZn
 KcHjsjS0Onoo32jBS4y9WE4tHtQ7DLb0aa+pd969PH9MDG2vqzBgkABPPTXiOeJC3ID1
 HoQnEsYrqOeLwUrafZf2PWIsTAJ+Em84867lACKvRsaV93hXgKaCR8sw7VfNQg3I7ouU
 HYAw==
X-Gm-Message-State: AFq9FYLgZ2XRs0DHJ61xDY1AUj0h2f6khZVDZ2IjZRZleIAs/Z9AMpSZ
 SR3ay7mbcNkZGB5G6POaj4C9jcNz7GOmX5dHCQmyY9Efl3UOP0Lt29JkqCEemdLGk8NzmCWEHfx
 DHMX1aMbkbP6O5wIQ9VAu1top01cdbdM=
X-Gm-Gg: AYBFou0/vxJp/77PKGVULLEdFJd9bked9r4+kuxJgH9kN1mTTlT1gXOuMmv+AyaqMBi
 PZZIYewpy4BRt7J4qXXKLG0f2bkIWi3f1hQ8GypLDY/jA75I9k32mRRelevTT9qsgttTTMO0qHI
 j2phNq2xoXFQINQ66G0+Bec0hEWAxmvXWTeGZRkIJF1AaCAwrJ20ymFFwUmJ/YnCRTZfz90ZX7a
 rqME3bbMCUHaD53047lBwOXEd8NRpyzjR5ly10F04aeKOhKahhJMh3TjoViVqsLWXy89wsABoJC
 kmEnBjfSbZGJ49qApN1Pj+ZCEjFSuR735+hnXSSzE2peAbrR53GAZh0+
X-Received: by 2002:a17:907:7ba3:b0:c29:f159:ddd4 with SMTP id
 a640c23a62f3a-c31a9d31be3mr1100236966b.26.1791875106885; Tue, 13 Oct 2026
 00:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-9-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-9-4c3dff084ec9@free.fr>
From: =?UTF-8?B?5p6X5bu65piO?= <jaminlin1207@gmail.com>
Date: Tue, 13 Oct 2026 15:04:55 +0800
X-Gm-Features: AclHuK8coclgDeThXGmkHOFxtILQgKeaj-WDn9niqMexZefc_tm5zBMdr7652PE
Message-ID: <CA+8rw5yxXGq6MZRHygm4iooNVoCt1abD9WtojnSnAnnddfkzOA@mail.gmail.com>
Subject: Re: [PATCH v2 09/50] hw: ds1338: use the TYPE_DS1338 constant instead
 of the "ds1338" string
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
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

> Now that TYPE_DS1338 is exposed by include/hw/rtc/ds1338.h, use it in
> the machines that instantiate the RTC by its raw type name string.
>
> No functional change.
>
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/arm/aspeed_ast2400_palmetto.c          | 4 +++-
>  hw/arm/aspeed_ast2400_supermicrox11.c     | 4 +++-
>  hw/arm/aspeed_ast2500_romulus.c           | 4 +++-
>  hw/arm/aspeed_ast2500_supermicro-x11spi.c | 4 +++-
>  hw/arm/aspeed_ast2500_witherspoon.c       | 4 +++-
>  hw/arm/aspeed_ast2600_bletchley.c         | 3 ++-
>  hw/arm/aspeed_ast2600_catalina.c          | 2 +-
>  hw/arm/aspeed_ast2600_sanmiguel.c         | 3 +--
>  hw/arm/realview.c                         | 3 ++-
>  hw/arm/versatilepb.c                      | 3 ++-
>  hw/ppc/e500.c                             | 3 ++-
>  hw/riscv/tt_atlantis.c                    | 3 ++-
>  12 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
> index e2350e5b6c..185185f0bb 100644
> --- a/hw/arm/aspeed_ast2400_palmetto.c
> +++ b/hw/arm/aspeed_ast2400_palmetto.c
> @@ -11,6 +11,7 @@
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/rtc/ds1338.h"
>
>  /* Palmetto hardware value: 0x120CE416 */
>  #define PALMETTO_BMC_HW_STRAP1 (                                        \
> @@ -36,7 +37,8 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
>       * The palmetto platform expects a ds3231 RTC but a ds1338 is
>       * enough to provide basic RTC features. Alarms will be missing
>       */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
> +                            0x68);
>
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                            eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
> index c75898cc6d..051e072c5a 100644
> --- a/hw/arm/aspeed_ast2400_supermicrox11.c
> +++ b/hw/arm/aspeed_ast2400_supermicrox11.c
> @@ -11,6 +11,7 @@
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/rtc/ds1338.h"
>
>  /* TODO: Find the actual hardware value */
>  #define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
> @@ -36,7 +37,8 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
>       * The palmetto platform expects a ds3231 RTC but a ds1338 is
>       * enough to provide basic RTC features. Alarms will be missing
>       */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
> +                            0x68);
>
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                            eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
> index 340a74408b..87f90ed361 100644
> --- a/hw/arm/aspeed_ast2500_romulus.c
> +++ b/hw/arm/aspeed_ast2500_romulus.c
> @@ -10,6 +10,7 @@
>  #include "qapi/error.h"
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
> +#include "hw/rtc/ds1338.h"
>
>  /* Romulus hardware value: 0xF10AD206 */
>  #define ROMULUS_BMC_HW_STRAP1 (                                         \
> @@ -29,7 +30,8 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
>       * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
>       * good enough
>       */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS1338,
> +                            0x32);
>  }
>
>  static void aspeed_machine_romulus_class_init(ObjectClass *oc,
> diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> index 5a7e49d6cc..dc0248422d 100644
> --- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> +++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
> @@ -11,6 +11,7 @@
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/rtc/ds1338.h"
>
>  /* TODO: Find the actual hardware value */
>  #define SUPERMICRO_X11SPI_BMC_HW_STRAP1 (                               \
> @@ -32,7 +33,8 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
>       * The palmetto platform expects a ds3231 RTC but a ds1338 is
>       * enough to provide basic RTC features. Alarms will be missing
>       */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), TYPE_DS1338,
> +                            0x68);
>
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                            eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
> index 26ddb67347..c69065846c 100644
> --- a/hw/arm/aspeed_ast2500_witherspoon.c
> +++ b/hw/arm/aspeed_ast2500_witherspoon.c
> @@ -14,6 +14,7 @@
>  #include "hw/sensor/tmp105.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/gpio/pca9552.h"
> +#include "hw/rtc/ds1338.h"
>
>  /* Witherspoon hardware value: 0xF10AD216 */
>  #define WITHERSPOON_BMC_HW_STRAP1 (                                     \
> @@ -70,7 +71,8 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>       * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
>       * good enough
>       */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_DS1338,
> +                            0x32);
>
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                            eeprom_buf);
> diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
> index 6fa606c047..0e746055a2 100644
> --- a/hw/arm/aspeed_ast2600_bletchley.c
> +++ b/hw/arm/aspeed_ast2600_bletchley.c
> @@ -12,6 +12,7 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/gpio/pca9552.h"
>  #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
>
>  #define TYPE_TMP421 "tmp421"
>  /* Bletchley hardware value */
> @@ -44,7 +45,7 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
>      /* Bus 6 */
>      at24c_eeprom_init(i2c[6], 0x56, 65536);
>      /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
> -    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
> +    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x51);
>
>
>      /* Bus 7 */
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index 4f2b396f6f..b15d932086 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -14,6 +14,7 @@
>  #include "hw/gpio/pca9552.h"
>  #include "hw/gpio/pca9554.h"
>  #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
>  #include "hw/sensor/tmp105.h"
>
>  /* Catalina hardware value */
> @@ -22,7 +23,6 @@
>  #define CATALINA_BMC_RAM_SIZE (2 * GiB)
>
>  #define TYPE_TMP421 "tmp421"
> -#define TYPE_DS1338 "ds1338"
>
>  /*
>   * "BMC Storage Module" FRU data.  Generated with frugen.
> diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
> index ac2aef740a..b0935683e2 100644
> --- a/hw/arm/aspeed_ast2600_sanmiguel.c
> +++ b/hw/arm/aspeed_ast2600_sanmiguel.c
> @@ -13,6 +13,7 @@
>  #include "hw/gpio/pca9552.h"
>  #include "hw/gpio/pca9554.h"
>  #include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
>  #include "hw/sensor/tmp105.h"
>
>  /* SanMiguel hardware values */
> @@ -20,8 +21,6 @@
>  #define SANMIGUEL_BMC_HW_STRAP2 0x00000000
>  #define SANMIGUEL_BMC_RAM_SIZE (2 * GiB)
>
> -#define TYPE_DS1338 "ds1338"
> -
>  /*
>   * "Front IO" FRU data. Generated with frugen.
>   *
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index ceba0331b0..4cdf939511 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -28,6 +28,7 @@
>  #include "hw/intc/realview_gic.h"
>  #include "hw/core/irq.h"
>  #include "hw/i2c/arm_sbcon_i2c.h"
> +#include "hw/rtc/ds1338.h"
>  #include "hw/sd/sd.h"
>  #include "target/arm/cpu-qom.h"
>
> @@ -323,7 +324,7 @@ static void realview_init(MachineState *machine,
>
>      dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>      i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
>
>      /* Memory map for RealView Emulation Baseboard:  */
>      /* 0x10000000 System registers.  */
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index f94bf96599..737cd21c27 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -18,6 +18,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/i2c/arm_sbcon_i2c.h"
> +#include "hw/rtc/ds1338.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/boards.h"
>  #include "hw/block/flash.h"
> @@ -346,7 +347,7 @@ static void versatile_init(MachineState *machine, int board_id)
>
>      dev = sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>      i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_slave_create_simple(i2c, TYPE_DS1338, 0x68);
>
>      /* Add PL041 AACI Interface to the LM4549 codec */
>      pl041 = qdev_new("pl041");
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 1876882a04..469cef9d2f 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -50,6 +50,7 @@
>  #include "hw/core/platform-bus.h"
>  #include "hw/net/fsl_etsec/etsec.h"
>  #include "hw/i2c/i2c.h"
> +#include "hw/rtc/ds1338.h"
>  #include "hw/core/irq.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/misc/unimp.h"
> @@ -1025,7 +1026,7 @@ void ppce500_init(MachineState *machine)
>      memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
>                                  sysbus_mmio_get_region(s, 0));
>      i2c = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
> -    i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
> +    i2c_slave_create_simple(i2c, TYPE_DS1338, RTC_REGS_OFFSET);
>
>      /* eSDHC */
>      if (pmc->has_esdhc) {
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 8a219afef7..910713c6bb 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -27,6 +27,7 @@
>  #include "hw/char/serial-mm.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/misc/unimp.h"
> +#include "hw/rtc/ds1338.h"
>
>  #include "system/system.h"
>  #include "system/device_tree.h"
> @@ -657,7 +658,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
>      qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>
>      /* I2C peripherals: qemu specific */
> -    i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
> +    i2c_slave_create_simple(i2c_get_bus(s, 0), TYPE_DS1338, 0x6f);
>      i2c_slave_create_simple(i2c_get_bus(s, 4), "tmp105", 0x48);
>
>      /* Load or create device tree */
>
> --
> 2.50.1
>
>

LGTM
Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

