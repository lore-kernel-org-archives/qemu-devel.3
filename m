Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A63EC982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 03:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x88YT-00057o-RY; Sat, 19 Sep 2026 23:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x88YR-00057Q-B5
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 23:49:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x88YO-0002MQ-Jg
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 23:49:27 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxC9K_V69qsNUNAA--.40538S3;
 Sun, 20 Sep 2026 11:49:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxFs28V69qTNwiAA--.16955S2;
 Sun, 20 Sep 2026 11:49:18 +0800 (CST)
Subject: Re: [PATCH v2 RESEND] tcg/loongarch: strip flag bits in lddir/ldpte
 address calculation
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 numpy1314 <xzj13@mail.ustc.edu.cn>
References: <20260920024217.18116-1-prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7c9246fb-3a0d-268c-1540-ddc05a71a927@loongson.cn>
Date: Sun, 20 Sep 2026 11:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260920024217.18116-1-prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxFs28V69qTNwiAA--.16955S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry3CrWDWryDAr1rWrW8Zrc_yoW8tFyUpF
 W7Cw43K3WrKryDAa4v9a4YvF1Uua4DGa1UXws2kryrCw15XFyxZr48t39xtF18Jw4fZr47
 ZFsIv34UAFyUX3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5
 r7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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



On 2026/9/20 上午10:42, SignKirigami wrote:
> helper_lddir and helper_ldpte used TARGET_PHYS_MASK (bits 0-47) when
> extracting the base address from a directory entry.  This retained flag
> bits (V, D, PLV, MAT, etc.) at positions 0-11, which were then OR'd
For LoongArch, what is scenery with DIR/PTE entry where bit0-bit11 such 
as (V, D, PLV, MAT, etc.) is used, except Huge bit?

Regards
Bibo Mao
> with the next-level index, producing a wrong physical address whenever
> the directory entry carried non-zero flags.
> 
> Fix both helpers to extract only the PPN field (bits 12-47) before
> computing the address of the next-level page table entry.
> 
> Signed-off-by: numpy1314 <xzj13@mail.ustc.edu.cn>
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> ---
> This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
>   
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05581.html.
>   
>   target/loongarch/tcg/tlb_helper.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 40cc076424..529b22347d 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -750,7 +750,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>       }
>   
>       badvaddr = sys->CSR_TLBRBADV;
> -    base = base & palen_mask;
> +    base = base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
>       get_dir_base_width(env, &dir_base, &dir_width, level);
>       index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>       phys = base | index << 3;
> @@ -773,7 +773,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>       uint64_t dir_base, dir_width;
>       uint8_t  ps;
>   
> -
>       /*
>        * The parameter "base" has only two types,
>        * one is the page table base address,
> @@ -815,9 +814,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>           }
>       } else {
>           badv = sys->CSR_TLBRBADV;
> -
> -        base = base & palen_mask;
> -
> +        base = base & palen_mask & ~MAKE_64BIT_MASK(0, 12);
>           ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
>           ptindex = ptindex & ~0x1;   /* clear bit 0 */
>           ptoffset0 = ptindex << 3;
> 


