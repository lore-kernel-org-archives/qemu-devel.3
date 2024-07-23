Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D7BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 12:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWECO-0000i3-2u; Tue, 23 Jul 2024 08:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sWEBx-0007Vu-4L; Tue, 23 Jul 2024 08:00:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1sWEBq-0000Cr-58; Tue, 23 Jul 2024 08:00:28 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxuOlOm59mKoAAAA--.1987S3;
 Tue, 23 Jul 2024 20:00:14 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxQcRLm59mibJVAA--.22134S3; 
 Tue, 23 Jul 2024 20:00:13 +0800 (CST)
Subject: Re: [PATCH 2/2] hw/intc/loongson_ipi: Fix resource leak
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org
References: <20240723111405.14208-1-philmd@linaro.org>
 <20240723111405.14208-3-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <742c17c0-b8a5-12b9-f507-679d11bceaa0@loongson.cn>
Date: Tue, 23 Jul 2024 20:00:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240723111405.14208-3-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxQcRLm59mibJVAA--.22134S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urW3KrW8KFW8KF4rJryfZrc_yoW8ZFyDpF
 9xZa1YgFWfGr1DArs3Ga4DGF13CrZ3Aw17GF43Cw1UCr98Xr1j9a4kGFWfJay7C3y8AF1Y
 qF95KrW8KF4DCwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
 Z7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.04,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2024/7/23 下午7:14, Philippe Mathieu-Daudé 写道:
> Once initialised, QOM objects can be realized and
> unrealized multiple times before being finalized.
> Resources allocated in REALIZE must be deallocated
> in an equivalent UNREALIZE handler.
>
> Free the CPU array in loongson_ipi_unrealize()
> instead of loongson_ipi_finalize().
>
> Cc: qemu-stable@nongnu.org
> Fixes: 5e90b8db382 ("hw/loongarch: Set iocsr address space per-board rather than percpu")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/intc/loongson_ipi.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
> index e7979dbdd8b..4013f81745e 100644
> --- a/hw/intc/loongson_ipi.c
> +++ b/hw/intc/loongson_ipi.c
> @@ -318,6 +318,13 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void loongson_ipi_unrealize(DeviceState *dev)
> +{
> +    LoongsonIPI *s = LOONGSON_IPI(dev);
> +
> +    g_free(s->cpu);
> +}
> +
>   static const VMStateDescription vmstate_ipi_core = {
>       .name = "ipi-single",
>       .version_id = 2,
> @@ -353,23 +360,16 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->realize = loongson_ipi_realize;
> +    dc->unrealize = loongson_ipi_unrealize;
>       device_class_set_props(dc, ipi_properties);
>       dc->vmsd = &vmstate_loongson_ipi;
>   }
>   
> -static void loongson_ipi_finalize(Object *obj)
> -{
> -    LoongsonIPI *s = LOONGSON_IPI(obj);
> -
> -    g_free(s->cpu);
> -}
> -
>   static const TypeInfo loongson_ipi_info = {
>       .name          = TYPE_LOONGSON_IPI,
>       .parent        = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(LoongsonIPI),
>       .class_init    = loongson_ipi_class_init,
> -    .instance_finalize = loongson_ipi_finalize,
>   };
>   
>   static void loongson_ipi_register_types(void)


