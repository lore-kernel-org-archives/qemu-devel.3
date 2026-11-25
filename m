Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F88606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW30a-0006tx-Pf; Tue, 24 Nov 2026 21:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xW30W-0006q6-S7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:45:17 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xW30U-0003Zy-De
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:45:16 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cxf9OtSwZrasgiAA--.33394S3;
 Wed, 25 Nov 2026 10:45:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxFs2rSwZrmi43AA--.52414S2;
 Wed, 25 Nov 2026 10:45:01 +0800 (CST)
Subject: Re: [PATCH v6 11/26] target/loongarch: add host TLBRet and handle
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <23c435596b199c9d3531aa29cfdc5b3bd5c5d726.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2c54bbbb-2f38-f1ac-d3e4-9f699615aee2@loongson.cn>
Date: Wed, 25 Nov 2026 10:46:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <23c435596b199c9d3531aa29cfdc5b3bd5c5d726.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxFs2rSwZrmi43AA--.52414S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArWfWr1kWryxAr1rAryruFX_yoW5uw1xpr
 ZxZr12kFy0gr9FywnFqa13GFy5uw43Gr4Ikw1Iga4Sg3yFqr4v9r4vg39FqF18A3W8Zw48
 ZF9Yvr18Gay8ZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZU
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
> Add host value in enum TLBRet, and use it in raise_mmu_exception().
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu-mmu.h        |  8 ++++++++
>   target/loongarch/tcg/tlb_helper.c | 18 ++++++++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
> index 491eb514d9..17fb92a213 100644
> --- a/target/loongarch/cpu-mmu.h
> +++ b/target/loongarch/cpu-mmu.h
> @@ -17,6 +17,14 @@ typedef enum TLBRet {
>       TLBRET_RI,
>       TLBRET_XI,
>       TLBRET_PE,
> +    TLBRET_HOST_MATCH,
> +    TLBRET_HOST_BADADDR,
> +    TLBRET_HOST_NOMATCH,
> +    TLBRET_HOST_INVALID,
> +    TLBRET_HOST_DIRTY,
> +    TLBRET_HOST_RI,
> +    TLBRET_HOST_XI,
> +    TLBRET_HOST_PE,
>   } TLBRet;
>   
>   typedef struct MMUContext {
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 5662b2c49a..33d5e04eb4 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -48,15 +48,24 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>                                   MMUAccessType access_type, TLBRet tlb_error)
>   {
if one additional parameter target_vm_level is added in 
raise_mmu_exception(), I think that it is not necessary to add 
TLBRET_HOST_xxx.

Regards
Bibo Mao
>       CPUState *cs = env_cpu(env);
> -    CPUSysState *sys = env_sys(env);
> +    bool real_guest;
> +
> +    if (env_vm_level(env) == VM_LEVEL1 && tlb_error > TLBRET_HOST_MATCH) {
> +        trigger_vm_exit(env);
> +    }
> +
> +    real_guest = !env->vm_exit && env_vm_level(env);
> +    CPUSysState *sys = get_sys(env, real_guest);
>   
>       switch (tlb_error) {
>       default:
>       case TLBRET_BADADDR:
> +    case TLBRET_HOST_BADADDR:
>           cs->exception_index = access_type == MMU_INST_FETCH
>                                 ? EXCCODE_ADEF : EXCCODE_ADEM;
>           break;
>       case TLBRET_NOMATCH:
> +    case TLBRET_HOST_NOMATCH:
>           /* No TLB match for a mapped address */
>           if (access_type == MMU_DATA_LOAD) {
>               cs->exception_index = EXCCODE_PIL;
> @@ -68,6 +77,7 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>           sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
>           break;
>       case TLBRET_INVALID:
> +    case TLBRET_HOST_INVALID:
>           /* TLB match with no valid bit */
>           if (access_type == MMU_DATA_LOAD) {
>               cs->exception_index = EXCCODE_PIL;
> @@ -78,24 +88,28 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>           }
>           break;
>       case TLBRET_DIRTY:
> +    case TLBRET_HOST_DIRTY:
>           /* TLB match but 'D' bit is cleared */
>           cs->exception_index = EXCCODE_PME;
>           break;
>       case TLBRET_XI:
> +    case TLBRET_HOST_XI:
>           /* Execute-Inhibit Exception */
>           cs->exception_index = EXCCODE_PNX;
>           break;
>       case TLBRET_RI:
> +    case TLBRET_HOST_RI:
>           /* Read-Inhibit Exception */
>           cs->exception_index = EXCCODE_PNR;
>           break;
>       case TLBRET_PE:
> +    case TLBRET_HOST_PE:
>           /* Privileged Exception */
>           cs->exception_index = EXCCODE_PPI;
>           break;
>       }
>   
> -    if (tlb_error == TLBRET_NOMATCH) {
> +    if (tlb_error == TLBRET_NOMATCH || tlb_error == TLBRET_HOST_NOMATCH) {
>           sys->CSR_TLBRBADV = address;
>           if (is_la64(env)) {
>               sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_64,
> 


