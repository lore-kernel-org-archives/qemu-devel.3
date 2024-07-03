Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFB7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0Zg-00005q-Oy; Wed, 03 Jul 2024 10:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0Ze-0008WG-C9; Wed, 03 Jul 2024 10:03:06 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0Zb-00040O-Vz; Wed, 03 Jul 2024 10:03:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDhLq21F3z4wcJ;
 Thu,  4 Jul 2024 00:02:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDhLl6fcDz4w2M;
 Thu,  4 Jul 2024 00:02:55 +1000 (AEST)
Message-ID: <ab8de479-fc85-4e00-8fac-c49dde0a03bc@kaod.org>
Date: Wed, 3 Jul 2024 16:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 5/5] hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from
 TYPE_SD_CARD
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
 <20240703134356.85972-6-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703134356.85972-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/3/24 3:43 PM, Philippe Mathieu-Daudé wrote:
> In order to keep eMMC model simpler to maintain,
> extract common properties and the common code from
> class_init to the (internal) TYPE_SDMMC_COMMON.
> 
> Update the corresponding QOM cast macros.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sdmmc-internal.h |  3 +++
>   hw/sd/core.c           | 29 ++++++++++++------------
>   hw/sd/sd.c             | 50 ++++++++++++++++++++++++++++--------------
>   3 files changed, 52 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
> index cc0b69e834..91eb5b6b2f 100644
> --- a/hw/sd/sdmmc-internal.h
> +++ b/hw/sd/sdmmc-internal.h
> @@ -11,6 +11,9 @@
>   #ifndef SDMMC_INTERNAL_H
>   #define SDMMC_INTERNAL_H
>   
> +#define TYPE_SDMMC_COMMON "sdmmc-common"
> +DECLARE_OBJ_CHECKERS(SDState, SDCardClass, SDMMC_COMMON, TYPE_SDMMC_COMMON)
> +
>   /*
>    * EXT_CSD Modes segment
>    *
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 52d5d90045..4b30218b52 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -24,6 +24,7 @@
>   #include "hw/sd/sd.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> +#include "sdmmc-internal.h"
>   #include "trace.h"
>   
>   static inline const char *sdbus_name(SDBus *sdbus)
> @@ -39,7 +40,7 @@ static SDState *get_card(SDBus *sdbus)
>       if (!kid) {
>           return NULL;
>       }
> -    return SD_CARD(kid->child);
> +    return SDMMC_COMMON(kid->child);
>   }
>   
>   uint8_t sdbus_get_dat_lines(SDBus *sdbus)
> @@ -48,7 +49,7 @@ uint8_t sdbus_get_dat_lines(SDBus *sdbus)
>       uint8_t dat_lines = 0b1111; /* 4 bit bus width */
>   
>       if (slave) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(slave);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(slave);
>   
>           if (sc->get_dat_lines) {
>               dat_lines = sc->get_dat_lines(slave);
> @@ -65,7 +66,7 @@ bool sdbus_get_cmd_line(SDBus *sdbus)
>       bool cmd_line = true;
>   
>       if (slave) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(slave);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(slave);
>   
>           if (sc->get_cmd_line) {
>               cmd_line = sc->get_cmd_line(slave);
> @@ -82,7 +83,7 @@ void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts)
>   
>       trace_sdbus_set_voltage(sdbus_name(sdbus), millivolts);
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           assert(sc->set_voltage);
>           sc->set_voltage(card, millivolts);
> @@ -95,7 +96,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
>   
>       trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg);
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           return sc->do_command(card, req, response);
>       }
> @@ -109,7 +110,7 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
>   
>       trace_sdbus_write(sdbus_name(sdbus), value);
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           sc->write_byte(card, value);
>       }
> @@ -121,7 +122,7 @@ void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length)
>       const uint8_t *data = buf;
>   
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           for (size_t i = 0; i < length; i++) {
>               trace_sdbus_write(sdbus_name(sdbus), data[i]);
> @@ -136,7 +137,7 @@ uint8_t sdbus_read_byte(SDBus *sdbus)
>       uint8_t value = 0;
>   
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           value = sc->read_byte(card);
>       }
> @@ -151,7 +152,7 @@ void sdbus_read_data(SDBus *sdbus, void *buf, size_t length)
>       uint8_t *data = buf;
>   
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           for (size_t i = 0; i < length; i++) {
>               data[i] = sc->read_byte(card);
> @@ -165,7 +166,7 @@ bool sdbus_receive_ready(SDBus *sdbus)
>       SDState *card = get_card(sdbus);
>   
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           return sc->receive_ready(card);
>       }
> @@ -178,7 +179,7 @@ bool sdbus_data_ready(SDBus *sdbus)
>       SDState *card = get_card(sdbus);
>   
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           return sc->data_ready(card);
>       }
> @@ -191,7 +192,7 @@ bool sdbus_get_inserted(SDBus *sdbus)
>       SDState *card = get_card(sdbus);
>   
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           return sc->get_inserted(card);
>       }
> @@ -204,7 +205,7 @@ bool sdbus_get_readonly(SDBus *sdbus)
>       SDState *card = get_card(sdbus);
>   
>       if (card) {
> -        SDCardClass *sc = SD_CARD_GET_CLASS(card);
> +        SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
>   
>           return sc->get_readonly(card);
>       }
> @@ -250,7 +251,7 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
>           return;
>       }
>   
> -    sc = SD_CARD_GET_CLASS(card);
> +    sc = SDMMC_COMMON_GET_CLASS(card);
>       readonly = sc->get_readonly(card);
>   
>       sdbus_set_inserted(from, false);
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d46be50760..9fcb2b9e89 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -688,8 +688,8 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
>   
>   static void sd_reset(DeviceState *dev)
>   {
> -    SDState *sd = SD_CARD(dev);
> -    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
> +    SDState *sd = SDMMC_COMMON(dev);
> +    SDCardClass *sc = SDMMC_COMMON_GET_CLASS(sd);
>       uint64_t size;
>       uint64_t sect;
>   
> @@ -2387,8 +2387,8 @@ static const SDProto sd_proto_sd = {
>   
>   static void sd_instance_init(Object *obj)
>   {
> -    SDState *sd = SD_CARD(obj);
> -    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
> +    SDState *sd = SDMMC_COMMON(obj);
> +    SDCardClass *sc = SDMMC_COMMON_GET_CLASS(sd);
>   
>       sd->proto = sc->proto;
>       sd->last_cmd_name = "UNSET";
> @@ -2398,14 +2398,14 @@ static void sd_instance_init(Object *obj)
>   
>   static void sd_instance_finalize(Object *obj)
>   {
> -    SDState *sd = SD_CARD(obj);
> +    SDState *sd = SDMMC_COMMON(obj);
>   
>       timer_free(sd->ocr_power_timer);
>   }
>   
>   static void sd_realize(DeviceState *dev, Error **errp)
>   {
> -    SDState *sd = SD_CARD(dev);
> +    SDState *sd = SDMMC_COMMON(dev);
>       int ret;
>   
>       switch (sd->spec_version) {
> @@ -2456,20 +2456,23 @@ static void sd_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> -static Property sd_properties[] = {
> -    DEFINE_PROP_UINT8("spec_version", SDState,
> -                      spec_version, SD_PHY_SPECv3_01_VERS),
> +static Property sdmmc_common_properties[] = {
>       DEFINE_PROP_DRIVE("drive", SDState, blk),
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> -static void sd_class_init(ObjectClass *klass, void *data)
> +static Property sd_properties[] = {
> +    DEFINE_PROP_UINT8("spec_version", SDState,
> +                      spec_version, SD_PHY_SPECv3_01_VERS),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void sdmmc_common_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> -    SDCardClass *sc = SD_CARD_CLASS(klass);
> +    SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
>   
> -    dc->realize = sd_realize;
> -    device_class_set_props(dc, sd_properties);
> +    device_class_set_props(dc, sdmmc_common_properties);
>       dc->vmsd = &sd_vmstate;
>       dc->reset = sd_reset;
>       dc->bus_type = TYPE_SD_BUS;
> @@ -2486,6 +2489,16 @@ static void sd_class_init(ObjectClass *klass, void *data)
>       sc->enable = sd_enable;
>       sc->get_inserted = sd_get_inserted;
>       sc->get_readonly = sd_get_readonly;
> +}
> +
> +static void sd_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
> +
> +    dc->realize = sd_realize;
> +    device_class_set_props(dc, sd_properties);
> +
>       sc->set_cid = sd_set_cid;
>       sc->set_csd = sd_set_csd;
>       sc->proto = &sd_proto_sd;
> @@ -2500,7 +2513,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
>   static void sd_spi_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> -    SDCardClass *sc = SD_CARD_CLASS(klass);
> +    SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
>   
>       dc->desc = "SD SPI";
>       sc->proto = &sd_proto_spi;
> @@ -2508,14 +2521,19 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
>   
>   static const TypeInfo sd_types[] = {
>       {
> -        .name           = TYPE_SD_CARD,
> +        .name           = TYPE_SDMMC_COMMON,
>           .parent         = TYPE_DEVICE,
>           .instance_size  = sizeof(SDState),
>           .class_size     = sizeof(SDCardClass),
> -        .class_init     = sd_class_init,
> +        .class_init     = sdmmc_common_class_init,
>           .instance_init  = sd_instance_init,
>           .instance_finalize = sd_instance_finalize,
>       },

Shouldn't it be an abstract class ?


Thanks,

C.


> +    {
> +        .name           = TYPE_SD_CARD,
> +        .parent         = TYPE_SDMMC_COMMON,
> +        .class_init     = sd_class_init,
> +    },
>       {
>           .name           = TYPE_SD_CARD_SPI,
>           .parent         = TYPE_SD_CARD,


