Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFD6CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOtH-0001iW-VX; Sun, 04 Oct 2026 12:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOt7-0001gm-Ba
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:16:34 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOt5-0001Fm-B5
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:16:33 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-836c4474028so7660277b3.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130590; cv=none;
 d=google.com; s=arc-20260327;
 b=FU6wDFM114GWg6xLkIl7bstp71UaV+rLcCNobAf7H7Qyl6ws5Al+3zuzPnZ6PKvOQQ
 TuuIfr3sD7Euwm/sG85gUqKA6iSwsScIHUPsAMAZjcAAhsHM7Umnzjd83oEQQspN4vAj
 lTq91mNN6SxBxI/UZdjanVdTESJqjkQh8YOsbQrQtZTXjrwOsqIRCtsfK2dIArN0Tidp
 XKUhBJ7PeJn0DPdxp84gHcXCX4dRvxGwqry1ajvzQn/HM/CtKKpOd4xJuA/CuYKMLZq4
 Ef1OcXS6pIQcEhQ9QhC4WjSix/sfpKIGUZrNXRxmBgQ5m62VntPQy8GT9RnLOt0g0AXW
 RUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LFkBz0kiFGpXIG60naKeN63E33Lv1fvvnIZO4dy6v04=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=H16h/czis0ww6Go7q59TR4INnkL2AWY/WLG6DickxV4BpA3N3irowurCLIS5RqoaWO
 kT2p2GV3fFPMayJlhOLMqghx5XH+UuxANxYxO5ULwXbPQNcTXQzyDI/7+mkrt3PdkS5P
 SlpycvXSRphXs3wDVXuEIczsX1ZCDMlvxx3uVPxqoggz85nbqIWBm8hOAR0FQU6vtF3i
 z7jTVOLb5nmN0RuEf2uT5A1JAgugMI8UXaYqxO8glfuQdfYCkcW0faglmvNOhp8SgYQx
 DtGP2/GNNbtQfH2LXYsOZkotsGRibrFNglTNIYqeGWkxHRonsmPcjKdfUWtsQCpsAaPO
 z+Gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130590; x=1791735390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LFkBz0kiFGpXIG60naKeN63E33Lv1fvvnIZO4dy6v04=;
 b=sTytDdJJ4jGP3HAFylYjaqwwswH6u8touzDRm8N03SMrW5wtq8FB/3yoMslp8s92UL
 MgUYZ6oGDnDG3u26YRXC3eKA+dozd72TMJElgnfukK0kxq99/cts0uSVhdxGBQEb8w+U
 IHOTBqC5u+szK36ssP/LXMkE7A/0OYK9d3RrlwgYiCLBHb0lMgDbzA+PDk2mdwQ78QMz
 5GPAp/GVODMY6CVQbjgbPwvO2vmmWjc9S0BzWFH4SLokT8TfghYqIr9hFCbRbEcm8lcy
 GJsJDQCartTAdgV0L52b3auYJeXC6i3iELvFGgl87e3k+4z0Hyz6vGeUwBfzyCWcuE9/
 /6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130590; x=1791735390;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LFkBz0kiFGpXIG60naKeN63E33Lv1fvvnIZO4dy6v04=;
 b=sKdmc9wO+JSixtoOq240PVma/vrWb65CXt4cdaYMwPaACAg8YBfeJ91dZKGXJTh7c5
 dbYBvZ5BueVIFajPu7A4qvEJqs1XeKwa+jH6zlWI1C/bEW7I9eTqeiM8bgqgJUMFaDWU
 2bP1QYxdbXh3L/8y+fb+43DL0ptjk1l4afpUyRcfV422s+u2Ekzi1RfXwJXyX9lvygNo
 seNtg9rX1CDNHphYcH5BKTkUpOExtcsUeGL2j0P80wr04QRywF1KXev+3uCBQgdhy9Eo
 axPN1cmHMNrb7YDLQUaELdS4Nxes1d4DMOwwYmW+Pk/kPAjBhRqIcAqxtwA8z1WF2n46
 r4sg==
X-Gm-Message-State: AFq9FYIgi405rSxc90X4u+DpPwF1nLqfrjhaWQOW9Dr3hOpRenFUvTMs
 8TIJM+jYI83tYIdivqHt3uEQHU14DUJhzRp/LMK2G9GXhtEAGiM1KjMCQ7s/UdzDWcyLX/TAX4y
 LcDgD+stoGlwQYqY+I2hTha9wV/o5APM=
X-Gm-Gg: AYBFou1yaiMV2HxUXhAtpw08r/OZHCpIq7NQiaY/j6YSZpeO44ChlKxciHFJmwaOPKo
 PMIX/fwsR/BSg+jrhfFQ/6f/m3vSRefItJzpaC2xIYlTqPTM2CQZEi4CRmGs+0z1niPC9zjjqXB
 FAG1mG3JQQx6uz8jNWVA+pjWaWU5SuBMw7tzpsPJ6xG4/xlASJd+WkIDBcxPsGYejiPky6Kr+Et
 ESGEiEwHz1qL8VFB4oI6c0sj083EAfSJdNNraZXG0aETe/pNj9g1HMyFD1fT0Z5N9ZBvd3QDfpd
 JrlnKTln4UhWWUiKIJKqmML0fKdvYYb4BeNfSZfkxbFLOmdhHTbqWoAIc9Vm9nv5nwhfyve/QRQ
 m3NYC6q0AeXaXwng=
X-Received: by 2002:a05:690c:e682:20b0:847:d0cd:11eb with SMTP id
 00721157ae682-8ae948c7516mr15054557b3.9.1791130589783; Sun, 04 Oct 2026
 09:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-12-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-12-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:16:18 +0800
X-Gm-Features: AclHuK_3UeOHEHMVBGCcGgTyQWZR-K20t_lkFpDiy-bQlsEyh42eCjrCI2KJf-0
Message-ID: <CAEUhbmWY=JkH+H1vO7J_xMuxTpwHqpKjF79ZTzN2Rgs-iLdo-A@mail.gmail.com>
Subject: Re: [PATCH v2 11/30] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1133.google.com
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

Hi Bernhard,

On Sun, Oct 4, 2026 at 8:35=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx25.h | 5 ++---
>  hw/arm/fsl-imx25.c         | 7 +------
>  hw/arm/imx25_pdk.c         | 2 +-
>  3 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
> index b68d4334a0..4bb4d5b3e5 100644
> --- a/include/hw/arm/fsl-imx25.h
> +++ b/include/hw/arm/fsl-imx25.h
> @@ -29,6 +29,7 @@
>  #include "hw/sd/sdhci.h"
>  #include "hw/usb/chipidea.h"
>  #include "hw/watchdog/wdt_imx2.h"
> +#include "hw/core/sysbus.h"
>  #include "system/memory.h"
>  #include "target/arm/cpu.h"
>  #include "qom/object.h"
> @@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
>  #define FSL_IMX25_NUM_USBS 2
>
>  struct FslIMX25State {
> -    /*< private >*/
> -    DeviceState parent_obj;
> +    SysBusDevice parent_obj;
>
> -    /*< public >*/
>      ARMCPU         cpu;
>      IMXAVICState   avic;
>      IMX25CCMState  ccm;
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 7f65f4ca4b..efb22359c5 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, c=
onst void *data)
>      device_class_set_props(dc, fsl_imx25_properties);
>      dc->realize =3D fsl_imx25_realize;
>      dc->desc =3D "i.MX25 SOC";
> -    /*
> -     * Reason: uses serial_hds in realize and the imx25 board does not
> -     * support multiple CPUs
> -     */
> -    dc->user_creatable =3D false;
>  }
>
>  static const TypeInfo fsl_imx25_type_info =3D {
>      .name =3D TYPE_FSL_IMX25,
> -    .parent =3D TYPE_DEVICE,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(FslIMX25State),
>      .instance_init =3D fsl_imx25_init,
>      .class_init =3D fsl_imx25_class_init,
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index 243c30a67e..6ce3e35ee3 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -72,7 +72,7 @@ static void imx25_pdk_init(MachineState *machine)
>
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IM=
X25);
>
> -    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);

This should use sysbus_realize(), as object_initialize_child() already
decreased the ref cnt on success. The same for patch 12 & 13.

>
>      /* We need to initialize our memory */
>      if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SI=
ZE)) {

Regards,
Bin

