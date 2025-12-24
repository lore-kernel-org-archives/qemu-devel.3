Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CEBE75446
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 09:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYLQ9-0001tc-OH; Wed, 24 Dec 2025 04:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vYLQ8-0001tT-M6
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 04:44:40 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vYLQ6-00083D-Tw
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 04:44:40 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxKMIDtktpfLcCAA--.8557S3;
 Wed, 24 Dec 2025 17:44:35 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxGOAAtktpKTcEAA--.12721S3;
 Wed, 24 Dec 2025 17:44:34 +0800 (CST)
Subject: Re: [PATCH v2 3/3] target/loongarch: Fix exception ADEF/ADEM missing
 update CSR_BADV
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20251224031929.2371837-1-gaosong@loongson.cn>
 <20251224031929.2371837-4-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <06436084-251e-a233-490d-7944ed0f8f41@loongson.cn>
Date: Wed, 24 Dec 2025 17:42:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251224031929.2371837-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxGOAAtktpKTcEAA--.12721S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWDtr47KryDJw45KryrKrX_yoW8Jw1rpF
 97ua4jya4rtrZ8A3yxJ390qF1Durs5Cw4Ig3W2qa4fKr1Sqry0gr1kt3yqqF47Xay5G3y7
 ZFnavrW3XayUWagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
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



On 2025/12/24 上午11:19, Song Gao wrote:
> Exception ADEM/ADEF need update CSR_BADV, ADEF value from env->pc,
> ADEM value from the virtual address.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/tcg_cpu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index c05a06eeb5..53e0970797 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -109,10 +109,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           }
>           QEMU_FALLTHROUGH;
>       case EXCCODE_PIF:
> -    case EXCCODE_ADEF:
>           cause = cs->exception_index;
>           update_badinstr = 0;
>           break;
> +    case EXCCODE_ADEF:
> +        update_badinstr = 0;
> +        QEMU_FALLTHROUGH;
I think this modification is unnecessary. CSR_BADV is already set with 
exception EXCCODE_ADEF/EXCCODE_ADEM.

Regards
Bibo Mao
>       case EXCCODE_BCE:
>           env->CSR_BADV = env->pc;
>           QEMU_FALLTHROUGH;
> @@ -225,6 +227,7 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>   {
>       CPULoongArchState *env = cpu_env(cs);
>   
> +    env->CSR_BADV = addr;
>       if (access_type == MMU_INST_FETCH) {
>           do_raise_exception(env, EXCCODE_ADEF, retaddr);
>       } else {
> 


