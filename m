Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E3DCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvVH-0008PP-DI; Fri, 29 May 2026 07:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey@volkov.fr>)
 id 1wSvVF-0008Ob-E7; Fri, 29 May 2026 07:35:49 -0400
Received: from 102.0.133.77.rev.sfr.net ([77.133.0.102] helo=gate.volkov.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey@volkov.fr>)
 id 1wSvVC-00052p-VO; Fri, 29 May 2026 07:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=volkov.fr; s=mail;
 t=1780054541; bh=V+eIzMUsR4WfWvLNpTA2+A+GMYJflzugrSTgDrED9tc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KtYLo8EBoXM2PB9qRQtkggeqjBMsWlhyDW0t3lhuiwyJ6/WSAjT6BR3hobDGbsVvM
 7r/J7JaItTM8VMQAIjCLLIArViqjSxdvatNgU8yjTnrKgsLo5bhL20rSdjJljvIX1X
 m3DFdT1lsuE6SCEJbmJKNivrWoCRujKFgSwmZ/bduqoQBFUOq3+u5We+sHGzb6I70x
 bvkwiXYlWOnngWDUETAlUOqKocYXfRaigmgy0e92XsNCSMI7LKhTVi6xWtByc5F35l
 O/SggSHyoKtctc7HeTVhA5zT2QmLmfP50JcmWc+fJ8G0xgtL80vFjUYuP58H6aTYNm
 N4AlRlyWLXyNg==
X-Virus-Scanned: Debian amavisd-new at volkov.fr
Authentication-Results: gate.volkov.fr;
 dmarc=fail (p=reject dis=none) header.from=volkov.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=volkov.fr; s=mail;
 t=1780054539; bh=V+eIzMUsR4WfWvLNpTA2+A+GMYJflzugrSTgDrED9tc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cr/GobdYu0w9SKiGoqhjQNMkZ3y9YwqQipFRZ57yTD7oobZnj5CIZ55cnh/WqymNn
 liJMeBb3r467/uLEBCQOiPIZmPC51+hCm0RoFdpGRd3pPbikUXOFVGWqYPi1R1ZyLN
 HroG46h0hIKXPEtd5qjkhiceUr3nuwHweaoYKGTW5nYTuQGkpf97MTlDo40CytPk63
 0t/+ORlZsT2J4/PyVg6n8WAEJ2ffQQi/Y2wkdxoujAk7DkKwsOmiQ9ijZIZMm2c2fL
 wt6qC76B6ngKzEMnvJFN0FEp8pl7uxBMYeBC3luE+8Er9SqswhP+itq9TCuw/QdcqK
 kfIM0wweJXOgg==
Message-ID: <dca6513c-5494-4eee-a0bb-bce64ffa3934@volkov.fr>
Date: Fri, 29 May 2026 13:35:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/7] hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
Content-Language: en-US
To: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1779986496.git.matyas.bobek@gmail.com>
 <9b0a0ffeeeff5ca0ec9525659bb2296850a88c62.1779986496.git.matyas.bobek@gmail.com>
From: Andrey VOLKOV <andrey@volkov.fr>
In-Reply-To: <9b0a0ffeeeff5ca0ec9525659bb2296850a88c62.1779986496.git.matyas.bobek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=77.133.0.102; envelope-from=andrey@volkov.fr;
 helo=gate.volkov.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

Hi Matyáš, Pavel,

Some small remarks regarding the use of hard-coded constants such as 
FSL_IMX6_NUM_WDTS in loops, IMHO, it would be better to use 
|ARRAY_SIZE()|instead:

-    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+    for (i = 0; i < ARRAY_SIZE(s->can); i++) {

BTW, it would be also more logical to combine |CanBusState|and 
|FlexcanState|into a single structure (possibly anonymous), for 
example:struct FslIMX6State { ...

  struct {
     CanBusState       *state;
     FlexcanState       flexcan;
  } can[FSL_IMX6_NUM_CANS];

...
};

As a matter of personal preference, I would also rename "|can"|to 
"|flexcan"/"fcan"|, since these objects represent FlexCAN controllers 
rather than CAN2.0 ones.

Regards,
Andrey VOLKOV

Le 28/05/2026 à 19:17, Matyáš Bobek a écrit :
> FlexcanState is added to the FslIMX6State struct like other peripherals.
>
> Add two new machine properties to Sabrelite machine for linking
> the embedded FlexCAN instances to QEMU CAN buses by name.
> No other machine uses FslIMX6State.
>
> Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
> Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
> Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
> ---
>   hw/arm/Kconfig            |  1 +
>   hw/arm/fsl-imx6.c         | 29 +++++++++++++++++++++++++++++
>   hw/arm/sabrelite.c        | 24 ++++++++++++++++++++++++
>   include/hw/arm/fsl-imx6.h |  6 ++++++
>   4 files changed, 60 insertions(+)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 5b198402d5..c44fc562e1 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -519,6 +519,7 @@ config FSL_IMX6
>       select IMX_FEC
>       select IMX_I2C
>       select IMX_USBPHY
> +    select CAN_FLEXCAN
>       select WDT_IMX2
>       select PL310  # cache controller
>       select PCI_EXPRESS_DESIGNWARE
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index f663ddbf0a..337921d17d 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -90,6 +90,10 @@ static void fsl_imx6_init(Object *obj)
>           snprintf(name, NAME_SIZE, "spi%d", i + 1);
>           object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
>       }
> +    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
> +        snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
> +        object_initialize_child(obj, name, &s->can[i], TYPE_CAN_FLEXCAN);
> +    }
>       for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
>           snprintf(name, NAME_SIZE, "wdt%d", i);
>           object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
> @@ -377,6 +381,27 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>                              qdev_get_gpio_in(gic, spi_table[i].irq));
>       }
>   
> +    /* Initialize all FLEXCANs */
> +    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
> +        static const struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } flexcan_table[FSL_IMX6_NUM_CANS] = {
> +            { FSL_IMX6_CAN1_ADDR, FSL_IMX6_FLEXCAN1_IRQ },
> +            { FSL_IMX6_CAN2_ADDR, FSL_IMX6_FLEXCAN2_IRQ },
> +        };
> +
> +        s->can[i].ccm = IMX_CCM(&s->ccm);
> +        object_property_set_link(OBJECT(&s->can[i]), "canbus",
> +                                 OBJECT(s->canbus[i]), &error_abort);
> +
> +        sysbus_realize(SYS_BUS_DEVICE(&s->can[i]), &error_abort);
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, flexcan_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
> +                           qdev_get_gpio_in(gic, flexcan_table[i].irq));
> +    }
> +
>       object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
>                                &error_abort);
>       qemu_configure_nic_device(DEVICE(&s->eth), true, NULL);
> @@ -480,6 +505,10 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>   
>   static const Property fsl_imx6_properties[] = {
>       DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
> +    DEFINE_PROP_LINK("canbus0", FslIMX6State, canbus[0], TYPE_CAN_BUS,
> +                     CanBusState *),
> +    DEFINE_PROP_LINK("canbus1", FslIMX6State, canbus[1], TYPE_CAN_BUS,
> +                     CanBusState *),
>   };
>   
>   static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
> index 7e036e6388..84bbc2f979 100644
> --- a/hw/arm/sabrelite.c
> +++ b/hw/arm/sabrelite.c
> @@ -24,6 +24,7 @@ struct SabreliteMachineState {
>       MachineState parent_obj;
>   
>       FslIMX6State soc;
> +    CanBusState *canbus[FSL_IMX6_NUM_CANS];
>   };
>   
>   #define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
> @@ -64,6 +65,13 @@ static void sabrelite_init(MachineState *machine)
>       /* Ethernet PHY address is 6 */
>       object_property_set_int(OBJECT(&s->soc), "fec-phy-num", 6, &error_fatal);
>   
> +    for (int i = 0; i < FSL_IMX6_NUM_CANS; i++) {
> +        g_autofree char *bus_name = g_strdup_printf("canbus%d", i);
> +
> +        object_property_set_link(OBJECT(&s->soc), bus_name,
> +                                 OBJECT(s->canbus[i]), &error_fatal);
> +    }
> +
>       qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
>   
>       memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
> @@ -112,6 +120,21 @@ static void sabrelite_init(MachineState *machine)
>       }
>   }
>   
> +static void sabrelite_machine_instance_init(Object *obj)
> +{
> +    SabreliteMachineState *s = SABRELITE_MACHINE(obj);
> +
> +    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
> +                             (Object **)&s->canbus[0],
> +                             object_property_allow_set_link,
> +                             0);
> +
> +    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
> +                             (Object **)&s->canbus[1],
> +                             object_property_allow_set_link,
> +                             0);
> +}
> +
>   static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -128,6 +151,7 @@ static const TypeInfo sabrelite_machine_init_typeinfo = {
>       .name          = TYPE_SABRELITE_MACHINE,
>       .parent        = TYPE_MACHINE,
>       .class_init    = sabrelite_machine_class_init,
> +    .instance_init = sabrelite_machine_instance_init,
>       .instance_size = sizeof(SabreliteMachineState),
>       .abstract      = false,
>       .interfaces    = arm_machine_interfaces,
> diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
> index cddd100dd6..8ea1677e86 100644
> --- a/include/hw/arm/fsl-imx6.h
> +++ b/include/hw/arm/fsl-imx6.h
> @@ -30,12 +30,14 @@
>   #include "hw/sd/sdhci.h"
>   #include "hw/ssi/imx_spi.h"
>   #include "hw/net/imx_fec.h"
> +#include "hw/net/flexcan.h"
>   #include "hw/usb/chipidea.h"
>   #include "hw/usb/imx-usb-phy.h"
>   #include "hw/pci-host/designware.h"
>   #include "hw/core/or-irq.h"
>   #include "system/memory.h"
>   #include "target/arm/cpu.h"
> +#include "net/can_emu.h"
>   #include "qom/object.h"
>   
>   #define TYPE_FSL_IMX6 "fsl-imx6"
> @@ -51,6 +53,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
>   #define FSL_IMX6_NUM_WDTS 2
>   #define FSL_IMX6_NUM_USB_PHYS 2
>   #define FSL_IMX6_NUM_USBS 4
> +#define FSL_IMX6_NUM_CANS 2
>   
>   struct FslIMX6State {
>       /*< private >*/
> @@ -73,6 +76,7 @@ struct FslIMX6State {
>       IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
>       ChipideaState      usb[FSL_IMX6_NUM_USBS];
>       IMXFECState        eth;
> +    FlexcanState       can[FSL_IMX6_NUM_CANS];
>       DesignwarePCIEHost pcie;
>       OrIRQState         pcie4_msi_irq;
>       MemoryRegion       rom;
> @@ -80,6 +84,8 @@ struct FslIMX6State {
>       MemoryRegion       ocram;
>       MemoryRegion       ocram_alias;
>       uint32_t           phy_num;
> +
> +    CanBusState       *canbus[FSL_IMX6_NUM_CANS];
>   };
>   
>   

