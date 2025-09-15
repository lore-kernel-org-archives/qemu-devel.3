Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0D4CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEQe-0000RD-Rf; Mon, 15 Sep 2025 14:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uyEQX-0000Pk-E2
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:59:49 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uyEQL-0005sM-Dl
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:59:46 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-407a4e744ddso31065ab.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757962767; x=1758567567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6BpW+3/ceerZFF507MJg+sFu5DMzXSIPojHnoR4bd0=;
 b=ujye0PrV7NbtlmH5CmpnP/FHBQ/JbRhwKkk+uNd86oyAnt4UeY5ano81GoYWFC7RZI
 pTnCAZd4LekyE5FDTtrj/NftdiCf6pPv8mtzRkQoujwov3imPlHD7a7fsXnsnckgsVnE
 pTSADGBJZ1eb2wimgU0rmlMxz+doxTMkjsL1/75jS0MG7QNS7m+rx/XkPj+J6fbiPwnO
 eP55kZfjvrJdbY8sBPLfMtd5V2wiL7sKiVPGCJ/xWaZn9eDEWGc2ltT3lznE5vC6Zvd4
 V/sof8LDikICNe+lB3nHiZU4WeT1452PC5tUOF066FdZC2tynb4ePMh2Rd7aXGNwv8iL
 wT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757962767; x=1758567567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6BpW+3/ceerZFF507MJg+sFu5DMzXSIPojHnoR4bd0=;
 b=CMBaoRPamSgvPFEwVd70AFxnQz43UZ4QlFlRC4pLBzfAnieWnVYc85DI/0NICrxHRc
 M6uewctt+/E7mePKxDqq811RdteMIhtytCrvHMZ1Ye8DGdfbE/woKbncNX7C3j52k3Gx
 6vRSsm70uIoy5FGvRdLlca2nv6/2I9NdyzBPxNlLMizYzSjr8/8Kr4UESl//xqgZMnTv
 3G8NQw7yxek2LwBp7kc9WYtlc4HDbZFgVD1nRNi87STNrdwLmkVHWK1oN9gZdMVOxHsi
 w+3jtbHgokZAoVEL6Ca955JCb/6C+f2zm5cSIplOM0DOkS5uthIPOkdEILhYGbchfP6B
 bG3g==
X-Gm-Message-State: AOJu0YzioxetPQltYNs0oLEJCbfHZ2BM+8evQufxIsWDdBm1liu38lc1
 2320pxhtyPPEXvmf2cIOR/1Px2Ek4F5bg7gJPXVIDzlfWSPrdYgT/0+7bv6DsuaJUeh6MH6OBFw
 dHyhp933MmAytLyFVG3mal9881FIcInMPVoSzod2avbtrlsD6CAJK6hcXqY7uBQ==
X-Gm-Gg: ASbGncsw3cS/W1tA3n2fXue5ldyPeqE6and6PjiSaUrzt73tuXd+/FaPrm3n58ZEhp4
 g3tgKcX70ww1sWHZVVOHtRjXqKAj6HxFZa0KV07ZheNzHQ8AafJo6zC3pBvMldTCwXk/8mwXiJz
 pnABE+H9qGuxdplSOu38gWLOHZY/Soxks0AR83e/MHlWFV3DFnnUmQb55RtVRip0y9zoZMRH0Yf
 MCZSCvtbQuzLJTTzV6qCssjYigsj6S0pCp9W9QQCQBdj5liNedaAOk=
X-Google-Smtp-Source: AGHT+IFKZ5al5zLt5ajtHmHhPSRZazJ4tdN3DGIJkroBAos+5qs51zoP1FBsmX63Git9fcXfHOPEBEaAgPDbhqUTk1c=
X-Received: by 2002:a05:6e02:3305:b0:423:fabc:67b3 with SMTP id
 e9e14a558f8ab-4240f52e1c7mr1101325ab.17.1757962766771; Mon, 15 Sep 2025
 11:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250903155410.1910145-1-nabihestefan@google.com>
In-Reply-To: <20250903155410.1910145-1-nabihestefan@google.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 15 Sep 2025 11:59:15 -0700
X-Gm-Features: Ac12FXzlpfXVACqv5nb3A8qL3EPxorjaZvO4w9CeBbPTlqsJmebEHEOoneOeI6I
Message-ID: <CA+QoejWUN0Pe5ff2HpYDirRDMWnv2mLRn9+BX51ZT80Kb6FyTw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/sensor: added MAX16600 device model
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org, 
 farosas@suse.de, lvivier@redhat.com, qemu-arm@nongnu.org, 
 Shengtan Mao <stmao@google.com>, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x134.google.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, FUZZY_MILLION=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Friendly ping on the review!

Thanks,
Nabih

On Wed, Sep 3, 2025 at 8:54=E2=80=AFAM Nabih Estefan <nabihestefan@google.c=
om> wrote:
>
> From: Shengtan Mao <stmao@google.com>
>
> Signed-off-by: Shengtan Mao <stmao@google.com>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  hw/arm/Kconfig               |   1 +
>  hw/sensor/Kconfig            |   4 +
>  hw/sensor/max16600.c         | 197 ++++++++++++++++++++++++++++
>  hw/sensor/meson.build        |   1 +
>  include/hw/sensor/max16600.h |  46 +++++++
>  tests/qtest/max16600-test.c  | 241 +++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build      |   1 +
>  7 files changed, 491 insertions(+)
>  create mode 100644 hw/sensor/max16600.c
>  create mode 100644 include/hw/sensor/max16600.h
>  create mode 100644 tests/qtest/max16600-test.c
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 2aa4b5d778..4ab0a93ba6 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -480,6 +480,7 @@ config NPCM7XX
>      select AT24C  # EEPROM
>      select MAX34451
>      select ISL_PMBUS_VR
> +    select MAX_16600
>      select PL310  # cache controller
>      select PMBUS
>      select SERIAL_MM
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index bc6331b4ab..ef7b3262a8 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -43,3 +43,7 @@ config ISL_PMBUS_VR
>  config MAX31785
>      bool
>      depends on PMBUS
> +
> +config MAX_16600
> +    bool
> +    depends on I2C
> diff --git a/hw/sensor/max16600.c b/hw/sensor/max16600.c
> new file mode 100644
> index 0000000000..1941391dab
> --- /dev/null
> +++ b/hw/sensor/max16600.c
> @@ -0,0 +1,197 @@
> +/*
> + * MAX16600 VR13.HC Dual-Output Voltage Regulator Chipset
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2025 Google LLC
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/pmbus_device.h"
> +#include "qapi/visitor.h"
> +#include "qemu/log.h"
> +#include "hw/sensor/max16600.h"
> +
> +static uint8_t max16600_read_byte(PMBusDevice *pmdev)
> +{
> +    MAX16600State *s =3D MAX16600(pmdev);
> +
> +    switch (pmdev->code) {
> +    case PMBUS_IC_DEVICE_ID:
> +        pmbus_send_string(pmdev, s->ic_device_id);
> +        break;
> +
> +    case MAX16600_PHASE_ID:
> +        pmbus_send8(pmdev, s->phase_id);
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: reading from unsupported register: 0x%02x\n",
> +                      __func__, pmdev->code);
> +        break;
> +    }
> +    return 0xFF;
> +}
> +
> +static int max16600_write_data(PMBusDevice *pmdev, const uint8_t *buf,
> +                               uint8_t len)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "%s: write to unsupported register: 0x%02x\n", __func_=
_,
> +                  pmdev->code);
> +    return 0xFF;
> +}
> +
> +static void max16600_exit_reset(Object *obj, ResetType type)
> +{
> +    PMBusDevice *pmdev =3D PMBUS_DEVICE(obj);
> +    MAX16600State *s =3D MAX16600(obj);
> +
> +    pmdev->capability =3D MAX16600_CAPABILITY_DEFAULT;
> +    pmdev->page =3D 0;
> +
> +    pmdev->pages[0].operation =3D MAX16600_OPERATION_DEFAULT;
> +    pmdev->pages[0].on_off_config =3D MAX16600_ON_OFF_CONFIG_DEFAULT;
> +    pmdev->pages[0].vout_mode =3D MAX16600_VOUT_MODE_DEFAULT;
> +
> +    pmdev->pages[0].read_vin =3D
> +        pmbus_data2linear_mode(MAX16600_READ_VIN_DEFAULT, max16600_exp.v=
in);
> +    pmdev->pages[0].read_iin =3D
> +        pmbus_data2linear_mode(MAX16600_READ_IIN_DEFAULT, max16600_exp.i=
in);
> +    pmdev->pages[0].read_pin =3D
> +        pmbus_data2linear_mode(MAX16600_READ_PIN_DEFAULT, max16600_exp.p=
in);
> +    pmdev->pages[0].read_vout =3D MAX16600_READ_VOUT_DEFAULT;
> +    pmdev->pages[0].read_iout =3D
> +        pmbus_data2linear_mode(MAX16600_READ_IOUT_DEFAULT, max16600_exp.=
iout);
> +    pmdev->pages[0].read_pout =3D
> +        pmbus_data2linear_mode(MAX16600_READ_PIN_DEFAULT, max16600_exp.p=
out);
> +    pmdev->pages[0].read_temperature_1 =3D
> +        pmbus_data2linear_mode(MAX16600_READ_TEMP_DEFAULT, max16600_exp.=
temp);
> +
> +    s->ic_device_id =3D "MAX16601";
> +    s->phase_id =3D MAX16600_PHASE_ID_DEFAULT;
> +}
> +
> +static void max16600_get(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    uint16_t value;
> +
> +    if (strcmp(name, "vin") =3D=3D 0) {
> +        value =3D pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_e=
xp.vin);
> +    } else if (strcmp(name, "iin") =3D=3D 0) {
> +        value =3D pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_e=
xp.iin);
> +    } else if (strcmp(name, "pin") =3D=3D 0) {
> +        value =3D pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_e=
xp.pin);
> +    } else if (strcmp(name, "iout") =3D=3D 0) {
> +        value =3D pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_e=
xp.iout);
> +    } else if (strcmp(name, "pout") =3D=3D 0) {
> +        value =3D pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_e=
xp.pout);
> +    } else if (strcmp(name, "temperature") =3D=3D 0) {
> +        value =3D pmbus_linear_mode2data(*(uint16_t *)opaque, max16600_e=
xp.temp);
> +    } else {
> +        value =3D *(uint16_t *)opaque;
> +    }
> +
> +    /* scale to milli-units */
> +    if (strcmp(name, "pout") !=3D 0 && strcmp(name, "pin") !=3D 0) {
> +        value *=3D 1000;
> +    }
> +
> +    visit_type_uint16(v, name, &value, errp);
> +}
> +
> +static void max16600_set(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    PMBusDevice *pmdev =3D PMBUS_DEVICE(obj);
> +    uint16_t *internal =3D opaque;
> +    uint16_t value;
> +    if (!visit_type_uint16(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    /* inputs match kernel driver which scales to milliunits except powe=
r */
> +    if (strcmp(name, "pout") !=3D 0 && strcmp(name, "pin") !=3D 0) {
> +        value /=3D 1000;
> +    }
> +
> +    if (strcmp(name, "vin") =3D=3D 0) {
> +        *internal =3D pmbus_data2linear_mode(value, max16600_exp.vin);
> +    } else if (strcmp(name, "iin") =3D=3D 0) {
> +        *internal =3D pmbus_data2linear_mode(value, max16600_exp.iin);
> +    } else if (strcmp(name, "pin") =3D=3D 0) {
> +        *internal =3D pmbus_data2linear_mode(value, max16600_exp.pin);
> +    } else if (strcmp(name, "iout") =3D=3D 0) {
> +        *internal =3D pmbus_data2linear_mode(value, max16600_exp.iout);
> +    } else if (strcmp(name, "pout") =3D=3D 0) {
> +        *internal =3D pmbus_data2linear_mode(value, max16600_exp.pout);
> +    } else if (strcmp(name, "temperature") =3D=3D 0) {
> +        *internal =3D pmbus_data2linear_mode(value, max16600_exp.temp);
> +    } else {
> +        *internal =3D value;
> +    }
> +
> +    pmbus_check_limits(pmdev);
> +}
> +
> +static void max16600_init(Object *obj)
> +{
> +    PMBusDevice *pmdev =3D PMBUS_DEVICE(obj);
> +    uint64_t flags =3D PB_HAS_VOUT_MODE | PB_HAS_VIN | PB_HAS_IIN | PB_H=
AS_PIN |
> +                     PB_HAS_IOUT | PB_HAS_POUT | PB_HAS_VOUT |
> +                     PB_HAS_TEMPERATURE | PB_HAS_MFR_INFO;
> +    pmbus_page_config(pmdev, 0, flags);
> +
> +    object_property_add(obj, "vin", "uint16", max16600_get, max16600_set=
, NULL,
> +                        &pmdev->pages[0].read_vin);
> +
> +    object_property_add(obj, "iin", "uint16", max16600_get, max16600_set=
, NULL,
> +                        &pmdev->pages[0].read_iin);
> +
> +    object_property_add(obj, "pin", "uint16", max16600_get, max16600_set=
, NULL,
> +                        &pmdev->pages[0].read_pin);
> +
> +    object_property_add(obj, "vout", "uint16", max16600_get, max16600_se=
t,
> +                        NULL, &pmdev->pages[0].read_vout);
> +
> +    object_property_add(obj, "iout", "uint16", max16600_get, max16600_se=
t,
> +                        NULL, &pmdev->pages[0].read_iout);
> +
> +    object_property_add(obj, "pout", "uint16", max16600_get, max16600_se=
t,
> +                        NULL, &pmdev->pages[0].read_pout);
> +
> +    object_property_add(obj, "temperature", "uint16",
> +                        max16600_get, max16600_set,
> +                        NULL, &pmdev->pages[0].read_temperature_1);
> +}
> +
> +static void max16600_class_init(ObjectClass *klass, const void *data)
> +{
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PMBusDeviceClass *k =3D PMBUS_DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "MAX16600 Dual-Output Voltage Regulator";
> +    k->write_data =3D max16600_write_data;
> +    k->receive_byte =3D max16600_read_byte;
> +    k->device_num_pages =3D 1;
> +
> +    rc->phases.exit =3D max16600_exit_reset;
> +}
> +
> +static const TypeInfo max16600_info =3D {
> +    .name =3D TYPE_MAX16600,
> +    .parent =3D TYPE_PMBUS_DEVICE,
> +    .instance_size =3D sizeof(MAX16600State),
> +    .instance_init =3D max16600_init,
> +    .class_init =3D max16600_class_init,
> +};
> +
> +static void max16600_register_types(void)
> +{
> +    type_register_static(&max16600_info);
> +}
> +
> +type_init(max16600_register_types)
> diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
> index 420fdc3359..85c2c73c99 100644
> --- a/hw/sensor/meson.build
> +++ b/hw/sensor/meson.build
> @@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('ma=
x34451.c'))
>  system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_=
mag.c'))
>  system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.=
c'))
>  system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
> +system_ss.add(when: 'CONFIG_MAX_16600', if_true: files('max16600.c'))
> diff --git a/include/hw/sensor/max16600.h b/include/hw/sensor/max16600.h
> new file mode 100644
> index 0000000000..a8cd0a5d4b
> --- /dev/null
> +++ b/include/hw/sensor/max16600.h
> @@ -0,0 +1,46 @@
> +/*
> + * MAX16600 VR13.HC Dual-Output Voltage Regulator Chipset
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2025 Google LLC
> + */
> +
> +#include "hw/i2c/pmbus_device.h"
> +
> +#define TYPE_MAX16600 "max16600"
> +#define MAX16600(obj) OBJECT_CHECK(MAX16600State, (obj), TYPE_MAX16600)
> +
> +#define MAX16600_PHASE_ID       0xF3
> +/*
> + * Packet error checking capability is disabled.
> + * Pending QEMU support
> + */
> +#define MAX16600_CAPABILITY_DEFAULT 0x30
> +#define MAX16600_OPERATION_DEFAULT 0x88
> +#define MAX16600_ON_OFF_CONFIG_DEFAULT 0x17
> +#define MAX16600_VOUT_MODE_DEFAULT 0x22
> +#define MAX16600_PHASE_ID_DEFAULT 0x80
> +
> +#define MAX16600_READ_VIN_DEFAULT 5    /* Volts */
> +#define MAX16600_READ_IIN_DEFAULT 3    /* Amps */
> +#define MAX16600_READ_PIN_DEFAULT 100  /* Watts */
> +#define MAX16600_READ_VOUT_DEFAULT 5   /* Volts */
> +#define MAX16600_READ_IOUT_DEFAULT 3   /* Amps */
> +#define MAX16600_READ_POUT_DEFAULT 100 /* Watts */
> +#define MAX16600_READ_TEMP_DEFAULT 40  /* Celsius */
> +
> +typedef struct MAX16600State {
> +    PMBusDevice parent;
> +    const char *ic_device_id;
> +    uint8_t phase_id;
> +} MAX16600State;
> +
> +/*
> + * determines the exponents used in linear conversion for CORE
> + * (iin, pin) may be (-4, 0) or (-3, 1)
> + * iout may be -2, -1, 0, 1
> + */
> +static const struct {
> +    int vin, iin, pin, iout, pout, temp;
> +} max16600_exp =3D {-6, -4, 0, -2, -1, 0};
> diff --git a/tests/qtest/max16600-test.c b/tests/qtest/max16600-test.c
> new file mode 100644
> index 0000000000..bad5da7989
> --- /dev/null
> +++ b/tests/qtest/max16600-test.c
> @@ -0,0 +1,241 @@
> +/*
> + * QTest for the MAX16600 VR13.HC Dual-Output Voltage Regulator Chipset
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2025 Google LLC
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/pmbus_device.h"
> +#include "hw/sensor/max16600.h"
> +#include "libqtest-single.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/i2c.h"
> +#include "qobject/qdict.h"
> +#include "qobject/qnum.h"
> +#include "qemu/bitops.h"
> +
> +#define TEST_ID "max16600-test"
> +#define TEST_ADDR (0x61)
> +
> +uint16_t pmbus_linear_mode2data(uint16_t value, int exp)
> +{
> +    /* D =3D L * 2^e */
> +    if (exp < 0) {
> +        return value >> (-exp);
> +    }
> +    return value << exp;
> +}
> +
> +static uint16_t qmp_max16600_get(const char *id, const char *property)
> +{
> +    QDict *response;
> +    uint64_t ret;
> +
> +    response =3D qmp("{ 'execute': 'qom-get', 'arguments': { 'path': %s,=
 "
> +                   "'property': %s } }",
> +                   id, property);
> +    g_assert(qdict_haskey(response, "return"));
> +    ret =3D qnum_get_uint(qobject_to(QNum, qdict_get(response, "return")=
));
> +    qobject_unref(response);
> +    return ret;
> +}
> +
> +static void qmp_max16600_set(const char *id, const char *property,
> +                             uint16_t value)
> +{
> +    QDict *response;
> +
> +    response =3D qmp("{ 'execute': 'qom-set', 'arguments': { 'path': %s,=
 "
> +                   "'property': %s, 'value': %u } }",
> +                   id, property, value);
> +    g_assert(qdict_haskey(response, "return"));
> +    qobject_unref(response);
> +}
> +
> +static uint16_t max16600_i2c_get16(QI2CDevice *i2cdev, uint8_t reg)
> +{
> +    uint8_t resp[2];
> +    i2c_read_block(i2cdev, reg, resp, sizeof(resp));
> +    return (resp[1] << 8) | resp[0];
> +}
> +
> +static void max16600_i2c_set16(QI2CDevice *i2cdev, uint8_t reg, uint16_t=
 value)
> +{
> +    uint8_t data[2];
> +
> +    data[0] =3D value & 255;
> +    data[1] =3D value >> 8;
> +    i2c_write_block(i2cdev, reg, data, sizeof(data));
> +}
> +
> +/* test default values */
> +static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    uint16_t i2c_value, value;
> +    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
> +
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_CAPABILITY);
> +    g_assert_cmphex(i2c_value, =3D=3D, MAX16600_CAPABILITY_DEFAULT);
> +
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_OPERATION);
> +    g_assert_cmphex(i2c_value, =3D=3D, MAX16600_OPERATION_DEFAULT);
> +
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_ON_OFF_CONFIG);
> +    g_assert_cmphex(i2c_value, =3D=3D, MAX16600_ON_OFF_CONFIG_DEFAULT);
> +
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_VOUT_MODE);
> +    g_assert_cmphex(i2c_value, =3D=3D, MAX16600_VOUT_MODE_DEFAULT);
> +
> +    value =3D qmp_max16600_get(TEST_ID, "vin") / 1000;
> +    g_assert_cmpuint(value, =3D=3D, MAX16600_READ_VIN_DEFAULT);
> +
> +    value =3D qmp_max16600_get(TEST_ID, "iin") / 1000;
> +    g_assert_cmpuint(value, =3D=3D, MAX16600_READ_IIN_DEFAULT);
> +
> +    value =3D qmp_max16600_get(TEST_ID, "pin");
> +    g_assert_cmpuint(value, =3D=3D, MAX16600_READ_PIN_DEFAULT);
> +
> +    value =3D qmp_max16600_get(TEST_ID, "vout") / 1000;
> +    g_assert_cmpuint(value, =3D=3D, MAX16600_READ_VOUT_DEFAULT);
> +
> +    value =3D qmp_max16600_get(TEST_ID, "iout") / 1000;
> +    g_assert_cmpuint(value, =3D=3D, MAX16600_READ_IOUT_DEFAULT);
> +
> +    value =3D qmp_max16600_get(TEST_ID, "pout");
> +    g_assert_cmpuint(value, =3D=3D, MAX16600_READ_POUT_DEFAULT);
> +
> +    value =3D qmp_max16600_get(TEST_ID, "temperature") / 1000;
> +    g_assert_cmpuint(value, =3D=3D, MAX16600_READ_TEMP_DEFAULT);
> +}
> +
> +/* test qmp access */
> +static void test_tx_rx(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    uint16_t value, i2c_value;
> +    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
> +
> +    qmp_max16600_set(TEST_ID, "vin", 2000);
> +    value =3D qmp_max16600_get(TEST_ID, "vin") / 1000;
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_VIN);
> +    i2c_value =3D pmbus_linear_mode2data(i2c_value, max16600_exp.vin);
> +    g_assert_cmpuint(value, =3D=3D, i2c_value);
> +
> +    qmp_max16600_set(TEST_ID, "iin", 3000);
> +    value =3D qmp_max16600_get(TEST_ID, "iin") / 1000;
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_IIN);
> +    i2c_value =3D pmbus_linear_mode2data(i2c_value, max16600_exp.iin);
> +    g_assert_cmpuint(value, =3D=3D, i2c_value);
> +
> +    qmp_max16600_set(TEST_ID, "pin", 4);
> +    value =3D qmp_max16600_get(TEST_ID, "pin");
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_PIN);
> +    i2c_value =3D pmbus_linear_mode2data(i2c_value, max16600_exp.pin);
> +    g_assert_cmpuint(value, =3D=3D, i2c_value);
> +
> +    qmp_max16600_set(TEST_ID, "vout", 5000);
> +    value =3D qmp_max16600_get(TEST_ID, "vout") / 1000;
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_VOUT);
> +    g_assert_cmpuint(value, =3D=3D, i2c_value);
> +
> +    qmp_max16600_set(TEST_ID, "iout", 6000);
> +    value =3D qmp_max16600_get(TEST_ID, "iout") / 1000;
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_IOUT);
> +    i2c_value =3D pmbus_linear_mode2data(i2c_value, max16600_exp.iout);
> +    g_assert_cmpuint(value, =3D=3D, i2c_value);
> +
> +    qmp_max16600_set(TEST_ID, "pout", 7);
> +    value =3D qmp_max16600_get(TEST_ID, "pout");
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_POUT);
> +    i2c_value =3D pmbus_linear_mode2data(i2c_value, max16600_exp.pout);
> +    g_assert_cmpuint(value, =3D=3D, i2c_value);
> +
> +    qmp_max16600_set(TEST_ID, "temperature", 8000);
> +    value =3D qmp_max16600_get(TEST_ID, "temperature") / 1000;
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_TEMPERATURE_1);
> +    i2c_value =3D pmbus_linear_mode2data(i2c_value, max16600_exp.temp);
> +    g_assert_cmpuint(value, =3D=3D, i2c_value);
> +}
> +
> +/* test r/w registers */
> +static void test_rw_regs(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    uint16_t i2c_value;
> +    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
> +
> +    max16600_i2c_set16(i2cdev, PMBUS_OPERATION, 0xA);
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_OPERATION);
> +    g_assert_cmphex(i2c_value, =3D=3D, 0xA);
> +
> +    max16600_i2c_set16(i2cdev, PMBUS_ON_OFF_CONFIG, 0xB);
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_ON_OFF_CONFIG);
> +    g_assert_cmphex(i2c_value, =3D=3D, 0xB);
> +
> +    max16600_i2c_set16(i2cdev, PMBUS_VOUT_MODE, 0xC);
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_VOUT_MODE);
> +    g_assert_cmphex(i2c_value, =3D=3D, 0xC);
> +}
> +
> +/* test read-only registers */
> +static void test_ro_regs(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    uint16_t i2c_init_value, i2c_value;
> +    QI2CDevice *i2cdev =3D (QI2CDevice *)obj;
> +
> +    i2c_init_value =3D i2c_get8(i2cdev, PMBUS_CAPABILITY);
> +    max16600_i2c_set16(i2cdev, PMBUS_CAPABILITY, 0xD);
> +    i2c_value =3D i2c_get8(i2cdev, PMBUS_CAPABILITY);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +
> +    i2c_init_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_VIN);
> +    max16600_i2c_set16(i2cdev, PMBUS_READ_VIN, 0x1234);
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_VIN);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +
> +    i2c_init_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_IIN);
> +    max16600_i2c_set16(i2cdev, PMBUS_READ_IIN, 0x2234);
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_IIN);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +
> +    i2c_init_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_PIN);
> +    max16600_i2c_set16(i2cdev, PMBUS_READ_PIN, 0x3234);
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_PIN);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +
> +    i2c_init_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_VOUT);
> +    max16600_i2c_set16(i2cdev, PMBUS_READ_VOUT, 0x4234);
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_VOUT);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +
> +    i2c_init_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_IOUT);
> +    max16600_i2c_set16(i2cdev, PMBUS_READ_IOUT, 0x5235);
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_IOUT);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +
> +    i2c_init_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_POUT);
> +    max16600_i2c_set16(i2cdev, PMBUS_READ_POUT, 0x6234);
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_POUT);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +
> +    i2c_init_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_TEMPERATURE=
_1);
> +    max16600_i2c_set16(i2cdev, PMBUS_READ_TEMPERATURE_1, 0x7236);
> +    i2c_value =3D max16600_i2c_get16(i2cdev, PMBUS_READ_TEMPERATURE_1);
> +    g_assert_cmphex(i2c_init_value, =3D=3D, i2c_value);
> +}
> +
> +static void max16600_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions opts =3D {.extra_device_opts =3D
> +                                    "id=3D" TEST_ID ",address=3D0x61"};
> +    add_qi2c_address(&opts, &(QI2CAddress){TEST_ADDR});
> +
> +    qos_node_create_driver("max16600", i2c_device_create);
> +    qos_node_consumes("max16600", "i2c-bus", &opts);
> +
> +    qos_add_test("test_defaults", "max16600", test_defaults, NULL);
> +    qos_add_test("test_tx_rx", "max16600", test_tx_rx, NULL);
> +    qos_add_test("test_rw_regs", "max16600", test_rw_regs, NULL);
> +    qos_add_test("test_ro_regs", "max16600", test_ro_regs, NULL);
> +}
> +libqos_init(max16600_register_nodes);
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..459cf41985 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -295,6 +295,7 @@ qos_test_ss.add(
>    'es1370-test.c',
>    'lsm303dlhc-mag-test.c',
>    'isl_pmbus_vr-test.c',
> +  'max16600-test.c',
>    'max34451-test.c',
>    'megasas-test.c',
>    'ne2000-test.c',
> --
> 2.51.0.355.g5224444f11-goog
>

