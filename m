Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFE2D2502E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 01:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf6bj-0002tP-Q1; Sun, 11 Jan 2026 20:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vf6bg-0002sU-Ae
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 20:20:32 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vf6bc-00077y-El
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 20:20:32 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxVvBQTGRpSbcHAA--.25393S3;
 Mon, 12 Jan 2026 09:20:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxC8JKTGRpECgaAA--.52449S3;
 Mon, 12 Jan 2026 09:20:13 +0800 (CST)
Subject: Re: [PATCH v2] hw/loongarch/virt: Don't abort on access to
 unimplemented IOCSR
To: Yao Zi <me@ziyao.cc>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20260111105027.8817-1-me@ziyao.cc>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2ac616c6-c594-6c2e-4501-161c6abb79cd@loongson.cn>
Date: Mon, 12 Jan 2026 09:17:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260111105027.8817-1-me@ziyao.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxC8JKTGRpECgaAA--.52449S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur17XF18JryfAr4ruw18CrX_yoW5GrykpF
 ZxCr45Cr48Jry7Wa93Ga43WF1jvwn3Xry2g3Wag348urWDW3Wq9r40k3sIvFW7ArWkKFn5
 Xry8Krn0gF1UW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.075,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/1/11 下午6:50, Yao Zi wrote:
> Since commit f2e61edb2946 ("hw/loongarch/virt: Use MemTxAttrs interface
> for misc ops") which adds a call to g_assert_not_reached() in the path
> of handling unimplemented IOCSRs, QEMU would abort when the guest
> accesses unimplemented IOCSRs.
> 
> This is too serious since there's nothing fatal happening in QEMU
> itself, and the guest could probably continue running if we give zero as
> result for these reads, which also matches the behavior observed on
> 3A5000M real machine.
> 
> Replace the assertion with qemu_log_mask(LOG_UNIMP, ...), it's still
> possible to examine unimplemented IOCSR access through "-d unimp"
> command line arguments.
> 
> Fixes: f2e61edb2946 ("hw/loongarch/virt: Use MemTxAttrs interface for misc ops")
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> 
> Changed from v1
> - Reword the commit message to avoid implying reading/writing
>    unimplemented IOCSRs is guaranteed to result in zero on LoongArch.
> - Don't log writes to read-only {VERSION,FEATURE,VENDOR,CPUNAME}_REG as
>    unimplemented.
> - Link to v1: https://lore.kernel.org/qemu-devel/20251221122511.56544-2-me@ziyao.cc/
> 
>   hw/loongarch/virt.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6efa15da4737..97ea1fb46d00 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -46,6 +46,7 @@
>   #include "hw/block/flash.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "qemu/error-report.h"
> +#include "qemu/log.h"
>   #include "kvm/kvm_loongarch.h"
>   
>   static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
> @@ -621,8 +622,15 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
>                             EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
>                             features, attrs, NULL);
>           break;
> +    case VERSION_REG:
> +    case FEATURE_REG:
> +    case VENDOR_REG:
> +    case CPUNAME_REG:
> +        break;
>       default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        break;
>       }
>   
>       return MEMTX_OK;
> @@ -680,7 +688,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           }
>           break;
>       default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        break;
>       }
>   
>       *data = ret;
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


