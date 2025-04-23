Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E4BC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7V7Z-0005CW-Vj; Wed, 23 Apr 2025 04:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7V7V-000505-FO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:06:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7V7T-0006WJ-4M
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:06:13 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxCGptnwhowoTEAA--.63611S3;
 Wed, 23 Apr 2025 16:06:05 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxrhtqnwhoRWeRAA--.49136S3;
 Wed, 23 Apr 2025 16:06:04 +0800 (CST)
Subject: Re: [PATCH] linux-user/loongarch64: Decode BRK break codes for FPE
 signals
To: WANG Rui <wangrui@loongson.cn>
Cc: qemu-devel@nongnu.org, qemu@hev.cc,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250414074952.6253-1-wangrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <9b05ad0b-398f-1bba-4996-78d9475c79be@loongson.cn>
Date: Wed, 23 Apr 2025 16:08:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250414074952.6253-1-wangrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxrhtqnwhoRWeRAA--.49136S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zry7Xr1UWrWrXw4fGF15trc_yoW8Zr4xpF
 ykCF1xCryUGry7twnxX34kZF45WF1v9r47Gry3Ka18J3yxJw18ur1q9Fsxu347XrW7ury7
 ZryUX3ZruF4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.292, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2025/4/14 ÏÂÎç3:49, WANG Rui Ð´µÀ:
> Handle specific LoongArch BRK break codes in user-mode emulation
> to deliver accurate floating-point exception signals. Specifically,
> BRK_OVERFLOW (6) triggers TARGET_FPE_INTOVF, and BRK_DIVZERO (7)
> triggers TARGET_FPE_INTDIV. Other BRK codes fall back to a generic
> SIGTRAP.
>
> This improves correctness for programs that rely on BRK to signal
> overflow or divide-by-zero conditions.
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   linux-user/loongarch64/cpu_loop.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
Acked-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
> diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
> index 0614d3de22..ec8a06c88c 100644
> --- a/linux-user/loongarch64/cpu_loop.c
> +++ b/linux-user/loongarch64/cpu_loop.c
> @@ -11,6 +11,12 @@
>   #include "user/cpu_loop.h"
>   #include "signal-common.h"
>   
> +/* Break codes */
> +enum {
> +    BRK_OVERFLOW = 6,
> +    BRK_DIVZERO = 7
> +};
> +
>   void cpu_loop(CPULoongArchState *env)
>   {
>       CPUState *cs = env_cpu(env);
> @@ -66,9 +72,26 @@ void cpu_loop(CPULoongArchState *env)
>               force_sig_fault(TARGET_SIGFPE, si_code, env->pc);
>               break;
>           case EXCP_DEBUG:
> -        case EXCCODE_BRK:
>               force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->pc);
>               break;
> +        case EXCCODE_BRK:
> +            {
> +                unsigned int opcode;
> +
> +                get_user_u32(opcode, env->pc);
> +
> +                switch (opcode & 0x7fff) {
> +                case BRK_OVERFLOW:
> +                    force_sig_fault(TARGET_SIGFPE, TARGET_FPE_INTOVF, env->pc);
> +                    break;
> +                case BRK_DIVZERO:
> +                    force_sig_fault(TARGET_SIGFPE, TARGET_FPE_INTDIV, env->pc);
> +                    break;
> +                default:
> +                    force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->pc);
> +                }
> +            }
> +            break;
>           case EXCCODE_BCE:
>               force_sig_fault(TARGET_SIGSYS, TARGET_SI_KERNEL, env->pc);
>               break;


