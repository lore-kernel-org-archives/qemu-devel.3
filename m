Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AB4C55174
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wroZi-0001sk-LG; Wed, 05 Aug 2026 23:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wroZf-0001pR-C4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:15:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wroZc-0003SC-4w
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:15:15 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axx+o4_HNqUuAKAA--.35036S3;
 Thu, 06 Aug 2026 11:15:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxTsU4_HNq9VklAA--.5342S2;
 Thu, 06 Aug 2026 11:15:04 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/boot: Check return value of g_strlcpy in
 init_cmdline
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, philmd@oss.qualcomm.com,
 jiaxun.yang@flygoat.com
References: <20260806020410.1869776-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2d844bd4-db05-1d15-4320-11a5e5c067f7@loongson.cn>
Date: Thu, 6 Aug 2026 11:14:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260806020410.1869776-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxTsU4_HNq9VklAA--.5342S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF48CrW5Zw47AF1ktF17XFc_yoW8Gw4xpF
 y7ur15JanYk3WDCrZrZ3s7Ww1UZ3Z7Gw13KFn2qr98CasrXr1vgr1rWFZrZFy0qayrKFyv
 vrn5Ww42v3WDX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.454,
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

The value of COMMAND_LINE_SIZE in QEMU is different with Linux kernel, 
and linux kernel increases it with 4096.

I think COMMAND_LINE_SIZE can be removed here, copy the whole string 
bootrom if it is smaller than bootrom size which is 1MB.


Regards
Bibo Mao

On 2026/8/6 上午10:04, Song Gao wrote:
> From: gaosong <gaosong@loongson.cn>
> 
> If the kernel command line is longer than COMMAND_LINE_SIZE - 1, it
> will be silently truncated. Check the return value of g_strlcpy and
> emit a warning to avoid hard-to-debug kernel misbehavior.
> 
> Fixes: 1234567890ab ("hw/loongarch: Add boot support")
> Resolves: Coverity CID 1550791
> Signed-off-by: gaosong <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index ef8eae237c..d91982fe86 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -212,7 +212,11 @@ static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
>       info->a0 = 1;
>       info->a1 = cmdline_addr;
>   
> -    g_strlcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
> +    if (g_strlcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE)
> +        >= COMMAND_LINE_SIZE) {
> +        warn_report("kernel command line truncated to %d bytes",
> +                    COMMAND_LINE_SIZE);
> +    }
>   }
>   
>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
> 


