Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDE9C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA3Zu-0001oG-TH; Thu, 23 May 2024 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sA3Zs-0001nr-Mv
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:13:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sA3Zn-00018A-CU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:13:32 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxDOui+k5m3PUCAA--.6218S3;
 Thu, 23 May 2024 16:13:22 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMef+k5mS4MGAA--.18204S3; 
 Thu, 23 May 2024 16:13:21 +0800 (CST)
Subject: Re: [PATCH v3 3/3] hw/loongarch/virt: Use MemTxAttrs interface for
 misc ops
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240521123225.231072-1-gaosong@loongson.cn>
 <20240521123225.231072-4-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <aa351d65-88ba-445b-5b8c-6b5dbeae5c55@loongson.cn>
Date: Thu, 23 May 2024 16:13:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240521123225.231072-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDMef+k5mS4MGAA--.18204S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCry8KrW3Xw1fXFyxCF45Arc_yoW5CF4fpr
 y8Jr9xZa15KF4a9a98Gr17WF15C3s7Gay3WF47ury09an8CrnF9ryjy39xJr4DA34DZF45
 WFykCrZrCF4qyrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.89,
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



On 2024/5/21 下午8:32, Song Gao wrote:
> Use MemTxAttrs interface read_with_attrs/write_with_attrs
> for virt_iocsr_misc_ops.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e7edc6c9f9..0ab2b6860a 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -866,8 +866,9 @@ static void virt_firmware_init(LoongArchVirtMachineState *lvms)
>       }
>   }
>   
> -static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
> -                                  uint64_t val, unsigned size)
> +static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
> +                                         uint64_t val, unsigned size,
> +                                         MemTxAttrs attrs)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
>       uint64_t features;
> @@ -875,12 +876,12 @@ static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
>       switch (addr) {
>       case MISC_FUNC_REG:
>           if (!virt_is_veiointc_enabled(lvms)) {
> -            return;
> +            return MEMTX_OK;
>           }
>   
>           features = address_space_ldl(&lvms->as_iocsr,
>                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
> -                                     MEMTXATTRS_UNSPECIFIED, NULL);
> +                                     attrs, NULL);
>           if (val & BIT_ULL(IOCSRM_EXTIOI_EN)) {
>               features |= BIT(EXTIOI_ENABLE);
>           }
> @@ -890,11 +891,15 @@ static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
>   
>           address_space_stl(&lvms->as_iocsr,
>                             EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
> -                          features, MEMTXATTRS_UNSPECIFIED, NULL);
> +                          features, attrs, NULL);
>       }
> +
> +    return MEMTX_OK;
>   }
>   
> -static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
> +static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
> +                                        uint64_t *data,
> +                                        unsigned size, MemTxAttrs attrs)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
>       uint64_t ret = 0;
> @@ -924,7 +929,7 @@ static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
>   
>           features = address_space_ldl(&lvms->as_iocsr,
>                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
> -                                     MEMTXATTRS_UNSPECIFIED, NULL);
> +                                     attrs, NULL);
>           if (features & BIT(EXTIOI_ENABLE)) {
>               ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
>           }
> @@ -933,12 +938,13 @@ static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
>           }
>       }
>   
> -    return ret;
> +    *data = ret;
> +    return MEMTX_OK;
>   }
>   
>   static const MemoryRegionOps virt_iocsr_misc_ops = {
> -    .read  = virt_iocsr_misc_read,
> -    .write = virt_iocsr_misc_write,
> +    .read_with_attrs  = virt_iocsr_misc_read,
> +    .write_with_attrs = virt_iocsr_misc_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 4,
> 
I think patch3 should be put ahead of patch2. Without patch3, there is 
potential problem to access iocsr EXTIOI_VIRT_CONFIG register with 
MEMTXATTRS_UNSPECIFIED attr.

Now extioi is emulated in user space, it will be better if hypervisor 
and VM know whether v-extioi extension is supported.

Regards
Bibo Mao


