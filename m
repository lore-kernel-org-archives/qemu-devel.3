Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80EECCD195
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 01:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAeos-00016I-6w; Sun, 19 Oct 2025 21:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vAeop-00015h-R2
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 21:36:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vAeon-0007Nw-6L
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 21:36:15 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxndL+kfVoiBoYAA--.51215S3;
 Mon, 20 Oct 2025 09:35:59 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxysD7kfVooyj3AA--.61913S3;
 Mon, 20 Oct 2025 09:35:57 +0800 (CST)
Subject: Re: [PATCH v8 10/25] target/loongarch: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <cover.1760884672.git.neither@nut.email>
 <deadf813e00387bbcf59e93be411ba44d3c915c8.1760884672.git.neither@nut.email>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e020ec26-ab0d-db79-94ba-626178e123b8@loongson.cn>
Date: Mon, 20 Oct 2025 09:36:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <deadf813e00387bbcf59e93be411ba44d3c915c8.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxysD7kfVooyj3AA--.61913S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFW3Jw13tryUKry5WFW3urX_yoW8uF4Dpa
 n2kr90yrWrtrWDAasrJ3sIqr1DurnrGan29a4xua4Skr1Yqr10g3yvq34DKFyxC3y5Ar4j
 vFnIyryqvF4UJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.37, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/10/19 ÏÂÎç11:14, Julian Ganz Ð´µÀ:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for loongarch targets. This architecture
> has one special "exception" for interrupts and no host calls.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/loongarch/tcg/tcg_cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 82b54e6dc3..9d077c56d9 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -8,6 +8,7 @@
>   #include "qemu/accel.h"
>   #include "qemu/error-report.h"
>   #include "qemu/log.h"
> +#include "qemu/plugin.h"
>   #include "accel/accel-cpu-target.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/cpu-ops.h"
> @@ -80,6 +81,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>       int cause = -1;
>       bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
>       uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
> +    uint64_t last_pc = env->pc;
>   
>       if (cs->exception_index != EXCCODE_INT) {
>           qemu_log_mask(CPU_LOG_INT,
> @@ -190,6 +192,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>                         __func__, env->pc, env->CSR_ERA,
>                         cause, env->CSR_BADV, env->CSR_DERA, vector,
>                         env->CSR_ECFG, env->CSR_ESTAT);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>       } else {
>           if (tlbfill) {
>               set_pc(env, env->CSR_TLBRENTRY);
> @@ -208,6 +211,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>                         tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
>                         env->CSR_BADI, env->gpr[11], cs->cpu_index,
>                         env->CSR_ASID);
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>       }
>       cs->exception_index = -1;
>   }


