Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95635C982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 06:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8BMd-0001iA-0G; Sun, 20 Sep 2026 02:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x8BMT-0001hw-K3
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 02:49:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x8BMO-0002U2-Mg
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 02:49:15 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxYdHfga9qjdwNAA--.41016S3;
 Sun, 20 Sep 2026 14:49:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx1czXga9qheciAA--.46492S2;
 Sun, 20 Sep 2026 14:48:57 +0800 (CST)
Subject: Re: [PATCH] linux-user/loongarch64: Detect vector stores in
 host_signal_write()
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Felix Yan <felixonmars@archlinux.org>
References: <20260918103733.86966-1-prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <eff6c44e-695e-f8ec-1215-c96477f5c43c@loongson.cn>
Date: Sun, 20 Sep 2026 14:48:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260918103733.86966-1-prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx1czXga9qheciAA--.46492S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5ZFyDXw1DWFW8Cw4UGFX_yoW8WF4fpF
 n3AFWxKrWkJF9rJrZrG34Yqry8Wan7CF109FWrKa1kuF1jg3Z5Xr98GrWUKFn8Xr4vvFyF
 gFyIqr1rWF4UtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oG
 QDUUUUU==
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

On 2026/9/18 下午6:37, SignKirigami wrote:
> Recognize LSX/LASX stores in the LoongArch host signal handler to fix
> internal QEMU crashes when RISC-V vector stores hit write-protected code
> pages through host memcpy.
> 
> Signed-off-by: Felix Yan <felixonmars@archlinux.org>
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> ---
>   linux-user/include/host/loongarch64/host-signal.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/linux-user/include/host/loongarch64/host-signal.h b/linux-user/include/host/loongarch64/host-signal.h
> index d33c3fc03e..eb4308cf09 100644
> --- a/linux-user/include/host/loongarch64/host-signal.h
> +++ b/linux-user/include/host/loongarch64/host-signal.h
> @@ -61,6 +61,10 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
>               return true;
>           }
>           break;
> +    case 0b001011: /* v{ld,st}, xv{ld,st} */
> +        return (insn >> 22) & 1;
> +    case 0b001100: /* v{ldrepl,stelm}, xv{ldrepl,stelm} */
> +        return (insn >> 24) & 1;
>       case 0b001110: /* indexed, atomic, bounds-checking memory operations */
>           switch ((insn >> 15) & 0b11111111111) {
>           case 0b00000100000: /* stx.b */
> @@ -69,6 +73,8 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
>           case 0b00000111000: /* stx.d */
>           case 0b00001110000: /* fstx.s */
>           case 0b00001111000: /* fstx.d */
> +        case 0b00010001000: /* vstx */
> +        case 0b00010011000: /* xvstx */
>           case 0b00011101100: /* fstgt.s */
>           case 0b00011101101: /* fstgt.d */
>           case 0b00011101110: /* fstle.s */
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


