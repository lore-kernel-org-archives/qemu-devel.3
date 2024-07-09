Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18D6C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRD88-00079S-GU; Tue, 09 Jul 2024 11:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org>)
 id 1sRD84-0006rH-98; Tue, 09 Jul 2024 11:51:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org>)
 id 1sRD81-0003Ix-Bc; Tue, 09 Jul 2024 11:51:43 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WJQTP21q9z4wny;
 Wed, 10 Jul 2024 01:51:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJQTH5zRLz4w2M;
 Wed, 10 Jul 2024 01:51:31 +1000 (AEST)
Message-ID: <ec4ab51b-6c9e-410f-a2a1-1fa65f6ebb02@kaod.org>
Date: Tue, 9 Jul 2024 17:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Aspeed PATCH v47 16/19] hw/sd/sdcard: Support boot area in emmc
 image
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
References: <20240709152556.52896-1-philmd@linaro.org>
 <20240709152556.52896-17-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240709152556.52896-17-philmd@linaro.org>
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
> From: Joel Stanley <joel@jms.id.au>
> 
> This assumes a specially constructed image:
> 
>    dd if=/dev/zero of=mmc-bootarea.img count=2 bs=1M
>    dd if=u-boot-spl.bin of=mmc-bootarea.img conv=notrunc
>    dd if=u-boot.bin of=mmc-bootarea.img conv=notrunc count=64 bs=1K
>    cat mmc-bootarea.img obmc-phosphor-image.wic > mmc.img
>    truncate --size 16GB mmc.img
>    truncate --size 128MB mmc-bootarea.img
> 
> For now this still requires a mtd image to load the SPL:
> 
>    qemu-system-arm -M tacoma-bmc -nographic \
>     -global driver=sd-card,property=emmc,value=true \
>     -drive file=mmc.img,if=sd,index=2 \
>     -drive file=mmc-bootarea.img,if=mtd,format=raw
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> TODO: Update QEMU command in description

hmm, this patch was also modified since last sent.


Thanks,

C.




> ---
>   include/hw/sd/sd.h |  1 +
>   hw/sd/sd.c         | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index d35a839f5e..07435d2e17 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -132,6 +132,7 @@ struct SDCardClass {
>       bool (*get_readonly)(SDState *sd);
>       void (*set_cid)(SDState *sd);
>       void (*set_csd)(SDState *sd, uint64_t size);
> +    uint32_t (*bootpart_offset)(SDState *sd);
>   
>       const struct SDProto *proto;
>   };
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c7f8ea11c1..5830725629 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -774,6 +774,13 @@ static uint32_t sd_blk_len(SDState *sd)
>       return sd->blk_len;
>   }
>   
> +static uint32_t sd_bootpart_offset(SDState *sd)
> +{
> +    SDCardClass *sc = SDMMC_COMMON_GET_CLASS(sd);
> +
> +    return sc->bootpart_offset ? sc->bootpart_offset(sd) : 0;
> +}
> +
>   static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
>   {
>       uint64_t addr;
> @@ -1026,9 +1033,33 @@ void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
>       qemu_set_irq(insert, sd->blk ? blk_is_inserted(sd->blk) : 0);
>   }
>   
> +/*
> + * This requires a disk image that has two boot partitions inserted at the
> + * beginning of it. The size of the boot partitions are configured in the
> + * ext_csd structure, which is hardcoded in qemu. They are currently set to
> + * 1MB each.
> + */
> +static uint32_t emmc_bootpart_offset(SDState *sd)
> +{
> +    unsigned int access = sd->ext_csd[EXT_CSD_PART_CONFIG]
> +                          & EXT_CSD_PART_CONFIG_ACC_MASK;
> +
> +    switch (access) {
> +    case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
> +        return sd->boot_part_size * 2;
> +    case EXT_CSD_PART_CONFIG_ACC_BOOT0:
> +        return 0;
> +    case EXT_CSD_PART_CONFIG_ACC_BOOT0 + 1:
> +        return sd->boot_part_size * 1;
> +    default:
> +         g_assert_not_reached();
> +    }
> +}
> +
>   static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
>   {
>       trace_sdcard_read_block(addr, len);
> +    addr += sd_bootpart_offset(sd);
>       if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
>           fprintf(stderr, "sd_blk_read: read error on host side\n");
>       }
> @@ -1037,6 +1068,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
>   static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>   {
>       trace_sdcard_write_block(addr, len);
> +    addr += sd_bootpart_offset(sd);
>       if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
>           fprintf(stderr, "sd_blk_write: write error on host side\n");
>       }
> @@ -2871,6 +2903,7 @@ static void emmc_class_init(ObjectClass *klass, void *data)
>   
>       sc->set_cid = emmc_set_cid;
>       sc->set_csd = emmc_set_csd;
> +    sc->bootpart_offset = emmc_bootpart_offset;
>   }
>   
>   static const TypeInfo sd_types[] = {


