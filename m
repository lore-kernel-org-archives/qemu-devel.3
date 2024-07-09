Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED9DC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRD0b-0008II-Lr; Tue, 09 Jul 2024 11:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org>)
 id 1sRD0Z-00087i-F8; Tue, 09 Jul 2024 11:43:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org>)
 id 1sRD0X-0001hI-AY; Tue, 09 Jul 2024 11:43:59 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WJQJR6TZBz4x1P;
 Wed, 10 Jul 2024 01:43:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJQJL44h3z4wny;
 Wed, 10 Jul 2024 01:43:46 +1000 (AEST)
Message-ID: <04d15252-0b94-473f-8db2-02e221ea80ec@kaod.org>
Date: Tue, 9 Jul 2024 17:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v47 12/19] hw/sd/sdcard: Simplify EXT_CSD values for spec
 v4.3
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
References: <20240709152556.52896-1-philmd@linaro.org>
 <20240709152556.52896-13-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240709152556.52896-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/9/24 5:25 PM, Philippe Mathieu-Daudé wrote:
> - Set some keys to not defined / implemented:
>    . EXT_CSD_HPI_FEATURES
>    . EXT_CSD_BKOPS_SUPPORT
>    . EXT_CSD_SEC_FEATURE_SUPPORT
>    . EXT_CSD_ERASE_TIMEOUT_MULT
>    . EXT_CSD_PART_SWITCH_TIME
>    . EXT_CSD_OUT_OF_INTERRUPT_TIME
> 
> - Simplify:
>    . EXT_CSD_ACC_SIZE (6 -> 1)
>        16KB of super_page_size -> 512B (BDRV_SECTOR_SIZE)
>    . EXT_CSD_HC_ERASE_GRP_SIZE (4 -> 1)
>    . EXT_CSD_HC_WP_GRP_SIZE (4 -> 1)
>    . EXT_CSD_S_C_VCC[Q] (8 -> 1)
>    . EXT_CSD_S_A_TIMEOUT (17 -> 1)
>    . EXT_CSD_CARD_TYPE (7 -> 3)
>        Dual data rate -> High-Speed mode
> 
> - Update:
>    . EXT_CSD_CARD_TYPE (7 -> 3)
>        High-Speed MultiMediaCard @ 26MHz & 52MHz
>    . Performances (0xa -> 0x46)
>        Class B at 3MB/s. -> Class J at 21MB/s
>    . EXT_CSD_REV (5 -> 3)
>        Rev 1.5 (spec v4.41) -> Rev 1.3 (spec v4.3)
> 
> - Use load/store API to set EXT_CSD_SEC_CNT
> 
> - Remove R/W keys, normally zeroed at reset
>    . EXT_CSD_BOOT_INFO
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

This should be merged in patch 10.

Thanks,

C.



> ---
>   hw/sd/sd.c | 50 ++++++++++++++++++--------------------------------
>   1 file changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index df0e2345c0..2a687977d1 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -484,43 +484,29 @@ static void mmc_set_ext_csd(SDState *sd, uint64_t size)
>   
>       memset(sd->ext_csd, 0, sizeof(sd->ext_csd));
>   
> +    /* Properties segment (RO) */
>       sd->ext_csd[EXT_CSD_S_CMD_SET] = 0b1; /* supported command sets */
> -    sd->ext_csd[EXT_CSD_HPI_FEATURES] = 0x3; /* HPI features  */
> -    sd->ext_csd[EXT_CSD_BKOPS_SUPPORT] = 0x1; /* Background operations */
> -    sd->ext_csd[241] = 0xA; /* 1st initialization time after partitioning */
> -    sd->ext_csd[EXT_CSD_TRIM_MULT] = 0x1; /* Trim multiplier */
> -    sd->ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] = 0x15; /* Secure feature */
> -    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x7; /* Boot information */
> +    sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x0; /* Boot information */
>                                        /* Boot partition size. 128KB unit */
>       sd->ext_csd[EXT_CSD_BOOT_MULT] = sd->boot_part_size / (128 * KiB);
> -    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x6; /* Access size */
> -    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x4; /* HC Erase unit size */
> +    sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x1; /* Access size */
> +    sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x01; /* HC Erase unit size */
>       sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x01; /* HC erase timeout */
>       sd->ext_csd[EXT_CSD_REL_WR_SEC_C] = 0x1; /* Reliable write sector count */
> -    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x4; /* HC write protect group size */
> -    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x8; /* Sleep current VCC  */
> -    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x7; /* Sleep current VCCQ */
> -    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x11; /* Sleep/Awake timeout */
> -    sd->ext_csd[215] = (sectcount >> 24) & 0xff; /* Sector count */
> -    sd->ext_csd[214] = (sectcount >> 16) & 0xff; /* ... */
> -    sd->ext_csd[213] = (sectcount >> 8) & 0xff;  /* ... */
> -    sd->ext_csd[EXT_CSD_SEC_CNT] = (sectcount & 0xff);       /* ... */
> -    sd->ext_csd[210] = 0xa; /* Min write perf for 8bit@52Mhz */
> -    sd->ext_csd[209] = 0xa; /* Min read perf for 8bit@52Mhz  */
> -    sd->ext_csd[208] = 0xa; /* Min write perf for 4bit@52Mhz */
> -    sd->ext_csd[207] = 0xa; /* Min read perf for 4bit@52Mhz */
> -    sd->ext_csd[206] = 0xa; /* Min write perf for 4bit@26Mhz */
> -    sd->ext_csd[205] = 0xa; /* Min read perf for 4bit@26Mhz */
> -    sd->ext_csd[EXT_CSD_PART_SWITCH_TIME] = 0x1;
> -    sd->ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] = 0x1;
> -    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0x7;
> -    sd->ext_csd[EXT_CSD_STRUCTURE] = 0x2;
> -    sd->ext_csd[EXT_CSD_REV] = 0x5;
> -    sd->ext_csd[EXT_CSD_RPMB_MULT] = 0x1; /* RPMB size */
> -    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0x3;
> -    sd->ext_csd[159] = 0x00; /* Max enhanced area size */
> -    sd->ext_csd[158] = 0x00; /* ... */
> -    sd->ext_csd[157] = 0xEC; /* ... */
> +    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x01; /* HC write protect group size */
> +    sd->ext_csd[EXT_CSD_S_C_VCC] = 0x01; /* Sleep current VCC  */
> +    sd->ext_csd[EXT_CSD_S_C_VCCQ] = 0x01; /* Sleep current VCCQ */
> +    sd->ext_csd[EXT_CSD_S_A_TIMEOUT] = 0x01; /* Sleep/Awake timeout */
> +    stl_le_p(&sd->ext_csd[EXT_CSD_SEC_CNT], sectcount); /* Sector count */
> +    sd->ext_csd[210] = 0x46; /* Min write perf for 8bit@52Mhz */
> +    sd->ext_csd[209] = 0x46; /* Min read perf for 8bit@52Mhz  */
> +    sd->ext_csd[208] = 0x46; /* Min write perf for 4bit@52Mhz */
> +    sd->ext_csd[207] = 0x46; /* Min read perf for 4bit@52Mhz */
> +    sd->ext_csd[206] = 0x46; /* Min write perf for 4bit@26Mhz */
> +    sd->ext_csd[205] = 0x46; /* Min read perf for 4bit@26Mhz */
> +    sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
> +    sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
> +    sd->ext_csd[EXT_CSD_REV] = 3;
>   }
>   
>   static void emmc_set_csd(SDState *sd, uint64_t size)


