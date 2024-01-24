Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A9C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 06:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXDE-0007uc-9W; Wed, 24 Jan 2024 01:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rIgd=JC=kaod.org=clg@ozlabs.org>)
 id 1rSXDC-0007uK-RH; Wed, 24 Jan 2024 01:58:14 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rIgd=JC=kaod.org=clg@ozlabs.org>)
 id 1rSXDA-0004cv-HN; Wed, 24 Jan 2024 01:58:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TKZXy1qCMz4x2T;
 Wed, 24 Jan 2024 17:58:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKZXv3qGLz4wcK;
 Wed, 24 Jan 2024 17:58:07 +1100 (AEDT)
Message-ID: <eec675ff-141d-4fc8-8976-1c4a3dd13151@kaod.org>
Date: Wed, 24 Jan 2024 07:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/arm/aspeed: Init CPU defaults in a common helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-4-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240123224842.18485-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rIgd=JC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/23/24 23:48, Philippe Mathieu-Daudé wrote:
> Rework aspeed_soc_num_cpus() as a new init_cpus_defaults()
> helper to reduce code duplication.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed.c | 71 +++++++++++++++++++------------------------------
>   1 file changed, 28 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 5b01a4dd28..636a6269aa 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1141,10 +1141,14 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
>                                             "Change the SPI Flash model");
>   }
>   
> -static int aspeed_soc_num_cpus(const char *soc_name)
> +static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
>
>   {
> -   AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(soc_name));
> -   return sc->num_cpus;
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(mc);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
> +
> +    mc->default_cpus = mc->min_cpus
> +                     = mc->max_cpus
> +                     = sc->num_cpus;
>   }
>   
>   static void aspeed_machine_class_init(ObjectClass *oc, void *data)
> @@ -1176,8 +1180,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 1;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
>       mc->default_ram_size       = 256 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
> @@ -1193,8 +1196,7 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 1;
>       amc->i2c_init  = quanta_q71l_bmc_i2c_init;
>       mc->default_ram_size       = 128 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
> @@ -1212,8 +1214,7 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
>       mc->default_ram_size = 256 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
> @@ -1231,8 +1232,7 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
>       mc->default_ram_size = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
> @@ -1248,8 +1248,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 1;
>       amc->i2c_init  = ast2500_evb_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
> @@ -1266,8 +1265,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = yosemitev2_bmc_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
> @@ -1283,8 +1281,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = romulus_bmc_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
> @@ -1301,8 +1298,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = tiogapass_bmc_i2c_init;
>       mc->default_ram_size       = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
> @@ -1318,8 +1314,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = sonorapass_bmc_i2c_init;
>       mc->default_ram_size       = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
> @@ -1335,8 +1330,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->i2c_init  = witherspoon_bmc_i2c_init;
>       mc->default_ram_size = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
> @@ -1355,8 +1349,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
>                        ASPEED_MAC3_ON;
>       amc->i2c_init  = ast2600_evb_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
> @@ -1374,8 +1367,7 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC2_ON;
>       amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
> @@ -1392,8 +1384,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = g220a_bmc_i2c_init;
>       mc->default_ram_size = 1024 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
> @@ -1410,8 +1401,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = fp5280g2_bmc_i2c_init;
>       mc->default_ram_size = 512 * MiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
> @@ -1429,8 +1419,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
>       amc->i2c_init  = rainier_bmc_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   #define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> @@ -1451,8 +1440,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>       amc->i2c_init = fuji_bmc_i2c_init;
>       amc->uart_default = ASPEED_DEV_UART1;
>       mc->default_ram_size = FUJI_BMC_RAM_SIZE;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   #define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> @@ -1472,8 +1460,7 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask = ASPEED_MAC2_ON;
>       amc->i2c_init  = bletchley_bmc_i2c_init;
>       mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void fby35_reset(MachineState *state, ShutdownCause reason)
> @@ -1515,6 +1502,7 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, void *data)
>       amc->i2c_init  = fby35_i2c_init;
>       /* FIXME: Replace this macro with something more general */
>       mc->default_ram_size = FUJI_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc); //

please remove the extra //, with that

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


>   }
>   
>   #define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
> @@ -1592,8 +1580,7 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
>       amc->spi_model = "sst25vf032b";
>       amc->num_cs = 2;
>       amc->macs_mask = 0;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
>   static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
> @@ -1612,8 +1599,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
>       amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
> @@ -1632,8 +1618,7 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
>       amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
>       amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
>       mc->default_ram_size = 1 * GiB;
> -    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> -        aspeed_soc_num_cpus(amc->soc_name);
> +    aspeed_machine_class_init_cpus_defaults(mc);
>   };
>   
>   static const TypeInfo aspeed_machine_types[] = {


