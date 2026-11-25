Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149B606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2vr-0003Je-Ag; Tue, 24 Nov 2026 21:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xW2vT-0002kz-Jm
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:40:05 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xW2vP-0002XC-E7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:40:03 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxFbVzSgZr5cciAA--.5513S3;
 Wed, 25 Nov 2026 10:39:47 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxFs1uSgZrTy43AA--.52413S2;
 Wed, 25 Nov 2026 10:39:44 +0800 (CST)
Subject: Re: [PATCH v6 10/26] target/loongarch: handle LVZ exception and
 vm_exit
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <a8014816e260cfa6c241599205f87fc93c67436e.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <90bac581-aa3e-a14a-e77a-eb11642a9ee9@loongson.cn>
Date: Wed, 25 Nov 2026 10:40:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a8014816e260cfa6c241599205f87fc93c67436e.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxFs1uSgZrTy43AA--.52413S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArWfGF18XryUGF1xArWkuFX_yoWrXw15pF
 WI9Fy7K34rKFWDA34xJay5Jr15Ww4xGw4Ik3srtw1SkrsYqFWFqF4vq398KF9rJ34rAF4U
 XFnayryUWFsrGacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/13 下午4:45, SignKirigami wrote:
> Add EXCCODE_GSPR and EXCCODE_HVC macros. Execute real vm exit at end of
> loongarch_cpu_do_interrupt().
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.h         |  2 ++
>   target/loongarch/tcg/tcg_cpu.c | 26 ++++++++++++++++++--------
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 3c21b7633e..42305e4b05 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -95,6 +95,8 @@ FIELD(FCSR0, CAUSE, 24, 5)
>   #define  EXCCODE_WPEM                EXCODE(19, 1)
>   #define  EXCCODE_BTD                 EXCODE(20, 0)
>   #define  EXCCODE_BTE                 EXCODE(21, 0)
> +#define  EXCCODE_GSPR                EXCODE(22, 0)
> +#define  EXCCODE_HVC                 EXCODE(23, 0)
>   #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode used for debug */
>   
>   /* cpucfg[0] bits */
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 8765bda0d1..1301a9c6ad 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -37,9 +37,11 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
>   static void loongarch_cpu_do_interrupt(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> -    CPUSysState *sys = env_sys(env);
>       bool update_badinstr = 1;
>       int cause = -1;
> +    bool real_guest = !env->vm_exit && env_vm_level(env);
> +    CPUSysState *sys = get_sys(env, real_guest);
> +    CPUSysState *host = get_sys(env, VM_LEVEL0);

I just submit one patch located at:
 
https://lore.kernel.org/qemu-devel/20261124073321.3015041-5-maobibo@loongson.cn/

Field target_vm_level can be added when raising exception.
There will be VM exit if target_vm_level < current_vm_level.
     struct {
         uint64_t badv;
         uint32_t flags;
+       uint32_t target_vm_level;
     } exception;

>       bool tlbfill = FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
>       uint32_t vec_size = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS);
>       uint64_t last_pc = env->pc;
> @@ -55,17 +57,17 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>   
>       switch (cs->exception_index) {
>       case EXCCODE_DBP:
> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
> +        host->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
> +        host->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
>           goto set_DERA;
>       set_DERA:
> -        sys->CSR_DERA = env->pc;
> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
> -        set_pc(env, sys->CSR_EENTRY + 0x480);
> +        host->CSR_DERA = env->pc;
> +        host->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
> +        set_pc(env, host->CSR_EENTRY + 0x480);
>           break;
>       case EXCCODE_INT:
> -        if (FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
> -            sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DEI, 1);
> +        if (FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)) {
> +            host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DEI, 1);
>               goto set_DERA;
>           }
>           QEMU_FALLTHROUGH;
> @@ -76,6 +78,8 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           update_badinstr = 0;
>           break;
>       case EXCCODE_BCE:
> +    case EXCCODE_GSPR:
> +    case EXCCODE_HVC:
With EXCCODE_GSPR/EXCCODE_HVC exception type, CSR_BADV is not necessary.

Regards
Bibo Mao
>           sys->CSR_BADV = env->pc;
>           QEMU_FALLTHROUGH;
>       case EXCCODE_SYS:
> @@ -178,6 +182,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           qemu_plugin_vcpu_exception_cb(cs, last_pc);
>       }
>       cs->exception_index = -1;
> +    if (env->vm_exit) {
> +        host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM, 0);
> +        set_sys(env, VM_LEVEL0);
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
> +    }
> +    env->vm_exit = false;
>   }
>   
>   static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> 


