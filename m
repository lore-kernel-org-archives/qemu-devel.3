Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02084C35FF3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 03:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tujmc-00007f-B5; Tue, 18 Mar 2025 23:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tujma-000072-90
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tujmT-0003qc-Pz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:51 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLGv_NNpnHY+cAA--.2515S3;
 Wed, 19 Mar 2025 11:07:43 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxb8f_NNpnlu1SAA--.42382S3;
 Wed, 19 Mar 2025 11:07:43 +0800 (CST)
Subject: Re: [PATCH 4/5] hw/intc/loongarch_pch: Add reset support
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250307071346.2260062-1-maobibo@loongson.cn>
 <20250307071346.2260062-5-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <84a3a8fd-97ca-4f46-b43b-b05addd3dfd6@loongson.cn>
Date: Wed, 19 Mar 2025 11:10:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250307071346.2260062-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxb8f_NNpnlu1SAA--.42382S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw43WF15WFWxAw1xAr4xAFc_yoW5XrWxpF
 WUZF13tF4UGrsrWrn3ZasxZr43GFna9F129F1akryxCrsxJry8Xw1UK3ZFvF1UK3y5Jr90
 v39ak3Wjga1UJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.526, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/3/7 ÏÂÎç3:13, Bibo Mao Ð´µÀ:
> Add reset support with LoongArch pci irqchip, and register reset
> callback support with new API resettable_class_set_parent_phases().
> Clear internal HW registers and SW state when virt machine resets.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pic_common.c         | 25 +++++++++++++++++++++++++
>   include/hw/intc/loongarch_pic_common.h |  1 +
>   2 files changed, 26 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
> index e7f541db4b..08ef97fcc4 100644
> --- a/hw/intc/loongarch_pic_common.c
> +++ b/hw/intc/loongarch_pic_common.c
> @@ -44,6 +44,27 @@ static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void loongarch_pic_common_reset_hold(Object *obj, ResetType type)
> +{
> +    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(obj);
> +    int i;
> +
> +    s->int_mask = -1;
> +    s->htmsi_en = 0x0;
> +    s->intedge  = 0x0;
> +    s->intclr   = 0x0;
> +    s->auto_crtl0 = 0x0;
> +    s->auto_crtl1 = 0x0;
> +    for (i = 0; i < 64; i++) {
> +        s->route_entry[i] = 0x1;
> +        s->htmsi_vector[i] = 0x0;
> +    }
> +    s->intirr = 0x0;
> +    s->intisr = 0x0;
> +    s->last_intirr = 0x0;
> +    s->int_polarity = 0x0;
> +}
> +
>   static const Property loongarch_pic_common_properties[] = {
>       DEFINE_PROP_UINT32("pch_pic_irq_num", LoongArchPICCommonState, irq_num, 0),
>   };
> @@ -75,9 +96,13 @@ static void loongarch_pic_common_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       device_class_set_parent_realize(dc, loongarch_pic_common_realize,
>                                       &lpcc->parent_realize);
> +    resettable_class_set_parent_phases(rc, NULL,
> +                                       loongarch_pic_common_reset_hold,
> +                                       NULL, &lpcc->parent_phases);
>       device_class_set_props(dc, loongarch_pic_common_properties);
>       dc->vmsd = &vmstate_loongarch_pic_common;
>   }
> diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
> index 43cce48978..d301377cd7 100644
> --- a/include/hw/intc/loongarch_pic_common.h
> +++ b/include/hw/intc/loongarch_pic_common.h
> @@ -76,6 +76,7 @@ struct LoongArchPICCommonClass {
>       SysBusDeviceClass parent_class;
>   
>       DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
>       int (*pre_save)(LoongArchPICCommonState *s);
>       int (*post_load)(LoongArchPICCommonState *s, int version_id);
>   };


