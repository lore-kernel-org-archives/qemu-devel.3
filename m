Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD71C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 02:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvRt9-0007Db-U0; Thu, 20 Mar 2025 22:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tvRt7-0007DK-Gb
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 22:13:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tvRt4-0003FR-GQ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 22:13:33 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxjaxDy9xn8YafAA--.39868S3;
 Fri, 21 Mar 2025 10:13:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCx7xtAy9xnrh9XAA--.54266S3;
 Fri, 21 Mar 2025 10:13:22 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: fix bad shift in check_ps()
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, stefanha@gmail.com
References: <20250321011358.463630-1-gaosong@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <7f77475c-5752-fc8b-9afd-f1116b176a30@loongson.cn>
Date: Fri, 21 Mar 2025 10:12:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250321011358.463630-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx7xtAy9xnrh9XAA--.54266S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cryftw1UKry7XF18Zr18JFc_yoW8KF18pr
 y7CryxKF48KrWDAa4Igas0g3WDZr1xGw47ua1ft34rCwsxXryIvrWktwsFgF18Ja4UWa1I
 q3W0vw1UZFWxXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.608,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2025/3/21 上午9:13, Song Gao wrote:
>   In expression 1ULL << tlb_ps, left shifting by more than 63 bits has undefined behavior.
> The shift amount, tlb_ps, is as much as 64. check "tlb_ps >=64" to fix.
> 
> Resolves: Coverity CID 1593475
> 
> Fixes: d882c284a3 ("target/loongarch: check tlb_ps")
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
> v2:  define parameter tlb_ps as uint type
> 
>   target/loongarch/internals.h      |  2 +-
>   target/loongarch/tcg/csr_helper.c |  2 +-
>   target/loongarch/tcg/tlb_helper.c | 10 +++++-----
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 1cd959a766..9fdc3059d8 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -43,7 +43,7 @@ enum {
>       TLBRET_PE = 7,
>   };
>   
> -bool check_ps(CPULoongArchState *ent, int ps);
> +bool check_ps(CPULoongArchState *ent, uint8_t ps);
>   
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 379c71e741..6a7a65c860 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -115,7 +115,7 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
>   
>   target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>   {
> -    int shift, ptbase;
> +    uint8_t shift, ptbase;
>       int64_t old_v = env->CSR_PWCL;
>   
>       /*
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 646dbf59de..bd8081e886 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -19,12 +19,12 @@
>   #include "exec/log.h"
>   #include "cpu-csr.h"
>   
> -bool check_ps(CPULoongArchState *env, int tlb_ps)
> +bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
>   {
> -     if (tlb_ps > 64) {
> -         return false;
> -     }
> -     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
> +    if (tlb_ps >= 64) {
> +        return false;
> +    }
> +    return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
>   }
>   
>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> 

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


