Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC267D711D5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 06:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXZNq-0001YP-9c; Mon, 22 Dec 2025 01:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vXZNm-0001Xs-JL
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 01:27:03 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vXZNj-0004MY-91
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 01:27:02 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxfcOp5EhpatYBAA--.6223S3;
 Mon, 22 Dec 2025 14:26:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxfcKm5EhpqUEDAA--.7336S3;
 Mon, 22 Dec 2025 14:26:49 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Don't abort on access to unimplemented
 IOCSR
To: Yao Zi <me@ziyao.cc>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org
References: <20251221122511.56544-2-me@ziyao.cc>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7c793846-c681-3cd4-598c-bb92a1f225f6@loongson.cn>
Date: Mon, 22 Dec 2025 14:24:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251221122511.56544-2-me@ziyao.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxfcKm5EhpqUEDAA--.7336S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFy3tr15uryxtw43CrWUKFX_yoW5GFyUpF
 Z8Cr98Cr48J347ua9Yya9rXr1j9wn3XrWjga4fK3y8CrWDWFnYkr10k3sIvFy8ArW8tw1F
 qryjgw1jqa4DuagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.354,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/12/21 下午8:25, Yao Zi wrote:
> Reading/writing unimplemented IOCSR on real LoongArch hardware doesn't
> trigger any exceptions, instead, reading always results in zero and
> writing is simply ignored.
 From my memories, I have communicated with HW guys about IOCSR. They 
said that IOCSR is different with CPUCFG, the undocumented IOCSR 
registers may be used by UEFI BIOS or other firmwares. So we cannot 
suppose reading always results in zero and writing is simply ignored.

However g_assert_not_reached() is actually too serious here, QEMU should 
not crash anyway.
> 
> Real-world applications, like memtest86plus, depend on the behavior to
> run. However, since commit f2e61edb2946 ("hw/loongarch/virt: Use
> MemTxAttrs interface for misc ops") which adds a call to
> g_assert_not_reached() in the path of handling unimplemented IOCSRs,
> QEMU would abort in the case.
> 
> Replace the assertion with qemu_log_mask(LOG_UNIMP, ...), so these
> applications could run. It's still possible to examine unimplemented
> IOCSR access through "-d unimp" command line arguments.
> 
> Fixes: f2e61edb2946 ("hw/loongarch/virt: Use MemTxAttrs interface for misc ops")
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>   hw/loongarch/virt.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 49434ad1828b..8d7da5fac550 100644
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
> @@ -622,7 +623,9 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
>                             features, attrs, NULL);
>           break;
>       default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        break;
>       }
IOCSR address VERSION_REG/VENDOR_REG/CPUNAME_REG is read-only rather 
than unimplemented, the others are unimplemented.

The others look good to me.

Regards
Bibo Mao
>   
>       return MEMTX_OK;
> @@ -680,7 +683,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           }
>           break;
>       default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        break;
Replacing g_assert_not_reached() with with qemu_log_mask() is ok for me.
>       }
>   
>       *data = ret;
> 


