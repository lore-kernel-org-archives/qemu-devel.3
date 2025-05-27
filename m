Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E5EC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 04:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJlWK-0005SE-C2; Tue, 27 May 2025 00:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uJlWE-0005Rj-Mh
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:02:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uJlWA-0003nT-Vp
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:02:25 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axz3M_OTVoH8_9AA--.15013S3;
 Tue, 27 May 2025 12:02:08 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxDcU9OTVouWP0AA--.36975S3;
 Tue, 27 May 2025 12:02:07 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_extioi: Move unrealize function to
 common code
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250523095144.2273861-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <be01e9cf-86ca-9e35-68c4-850e25c80198@loongson.cn>
Date: Tue, 27 May 2025 12:04:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250523095144.2273861-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxDcU9OTVouWP0AA--.36975S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4fZF1xuF4UZw4kZr4xuFX_yoWrXrW3pF
 y7ZF13Wr4UXw1DXrsrK3Z8XFW8Xrsa9F12qF13K34fCw45Gryvg34vq3s3XF1DG395A34q
 v3ZYq3W5XF17ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.385, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/5/23 ÏÂÎç5:51, Bibo Mao Ð´µÀ:
> Memory about LoongArchExtIOICommonState::cpu is allocated in common
> code, it had better be freed in common code also.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_extioi.c                | 9 ---------
>   hw/intc/loongarch_extioi_common.c         | 9 +++++++++
>   include/hw/intc/loongarch_extioi.h        | 1 -
>   include/hw/intc/loongarch_extioi_common.h | 1 +
>   4 files changed, 10 insertions(+), 10 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index 7c38c4c9b7..4ec0b2bcff 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -370,13 +370,6 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> -static void loongarch_extioi_unrealize(DeviceState *dev)
> -{
> -    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
> -
> -    g_free(s->cpu);
> -}
> -
>   static void loongarch_extioi_reset_hold(Object *obj, ResetType type)
>   {
>       LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(obj);
> @@ -412,8 +405,6 @@ static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
>   
>       device_class_set_parent_realize(dc, loongarch_extioi_realize,
>                                       &lec->parent_realize);
> -    device_class_set_parent_unrealize(dc, loongarch_extioi_unrealize,
> -                                      &lec->parent_unrealize);
>       resettable_class_set_parent_phases(rc, NULL, loongarch_extioi_reset_hold,
>                                          NULL, &lec->parent_phases);
>       lecc->post_load = vmstate_extioi_post_load;
> diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
> index 4a904b3bc1..ba03383ed1 100644
> --- a/hw/intc/loongarch_extioi_common.c
> +++ b/hw/intc/loongarch_extioi_common.c
> @@ -108,6 +108,13 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void loongarch_extioi_common_unrealize(DeviceState *dev)
> +{
> +    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
> +
> +    g_free(s->cpu);
> +}
> +
>   static void loongarch_extioi_common_reset_hold(Object *obj, ResetType type)
>   {
>       LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_GET_CLASS(obj);
> @@ -221,6 +228,8 @@ static void loongarch_extioi_common_class_init(ObjectClass *klass,
>   
>       device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
>                                       &lecc->parent_realize);
> +    device_class_set_parent_unrealize(dc, loongarch_extioi_common_unrealize,
> +                                      &lecc->parent_unrealize);
>       resettable_class_set_parent_phases(rc, NULL,
>                                          loongarch_extioi_common_reset_hold,
>                                          NULL, &lecc->parent_phases);
> diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
> index 4a6ae903e9..7744e1bf07 100644
> --- a/include/hw/intc/loongarch_extioi.h
> +++ b/include/hw/intc/loongarch_extioi.h
> @@ -21,7 +21,6 @@ struct LoongArchExtIOIClass {
>       LoongArchExtIOICommonClass parent_class;
>   
>       DeviceRealize parent_realize;
> -    DeviceUnrealize parent_unrealize;
>       ResettablePhases parent_phases;
>   };
>   
> diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
> index 735bfee80a..74d5dc87df 100644
> --- a/include/hw/intc/loongarch_extioi_common.h
> +++ b/include/hw/intc/loongarch_extioi_common.h
> @@ -94,6 +94,7 @@ struct LoongArchExtIOICommonClass {
>       SysBusDeviceClass parent_class;
>   
>       DeviceRealize parent_realize;
> +    DeviceUnrealize parent_unrealize;
>       ResettablePhases parent_phases;
>       int (*pre_save)(void *s);
>       int (*post_load)(void *s, int version_id);
>
> base-commit: 2af4a82ab2cce3412ffc92cd4c96bd870e33bc8e


