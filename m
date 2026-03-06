Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03EFF513F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMMt-0003AI-6s; Thu, 05 Mar 2026 23:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vyMMi-00039m-FZ; Thu, 05 Mar 2026 23:00:41 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1vyMMe-0008Mo-VW; Thu, 05 Mar 2026 23:00:40 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxacJUUappEgoYAA--.5655S3;
 Fri, 06 Mar 2026 12:00:21 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxbcJRUappdUFPAA--.17577S3;
 Fri, 06 Mar 2026 12:00:19 +0800 (CST)
Subject: Re: [PATCH 2/2] target/loongarch: Avoid recursive PNX exception on
 CSR_BADI fetch
To: "Andrew S. Rightenburg" <andrew@rail5.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, qemu-stable@nongnu.org
References: <20260305135403.831693-1-andrew@rail5.org>
 <20260305135403.831693-3-andrew@rail5.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e87710ce-4c64-086f-1054-aa3cfba97983@loongson.cn>
Date: Fri, 6 Mar 2026 11:57:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260305135403.831693-3-andrew@rail5.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxbcJRUappdUFPAA--.17577S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4xuw4kKw43Xr43Cw15GFX_yoW8XFy7pF
 WIk34UJrWrtryDA3s5JayYgr15Ww4DC3yIg3W2qa4fGw4ft3sYq3Z5ta90qF13Jay5JrW7
 ZF1Sy348XayUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
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
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.337,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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



On 2026/3/5 下午9:54, Andrew S. Rightenburg via qemu development wrote:
> From: rail5 <andrew@rail5.org>
> 
> loongarch_cpu_do_interrupt() updates CSR_BADI by fetching the faulting
> instruction with cpu_ldl_code_mmu().
> 
> For a PNX exception (instruction fetch prohibited by NX), fetching the
> instruction at env->pc will fault with PNX again. This can lead to an
> infinite exception loop.
> 
> Treat PNX like other instruction-fetch exceptions (PIF/ADEF) and do not
> update CSR_BADI for it.
> 
> Fixes: 410dfbf620a ("target/loongarch: Move TCG specified functions to tcg_cpu.c")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
> ---
>   target/loongarch/tcg/tcg_cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index af92277669..31d3db6e8e 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -109,6 +109,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           }
>           QEMU_FALLTHROUGH;
>       case EXCCODE_PIF:
> +    case EXCCODE_PNX:
>       case EXCCODE_ADEF:
>           cause = cs->exception_index;
>           update_badinstr = 0;
> @@ -129,7 +130,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>       case EXCCODE_PIS:
>       case EXCCODE_PME:
>       case EXCCODE_PNR:
> -    case EXCCODE_PNX:
>       case EXCCODE_PPI:
>           cause = cs->exception_index;
>           break;
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


