Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A420C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6V5g-0004hi-BX; Mon, 13 May 2024 08:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6V5e-0004hI-CF; Mon, 13 May 2024 08:47:38 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6V5U-0006lH-3c; Mon, 13 May 2024 08:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715604440; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=4uNNqOQC4qCFF2yr+xZ+Z9IAK0bjjqNw3fAVyiqld64=;
 b=BqqYsGsgn/oIuPovze8z1F+GDA9SsTCPCL2W9uQOv9hlu+vmYbXAPGN5qBWexVJPT1K50pq4dJdjlxHaOJOzZIkpdK3xd17m3Sghicj1JbI+2ITr5ITRhUhj6l9bt7OVCY7arxeTCHJzEDFnCuIaJshGOIBoaMkFqgmXuuBs7lk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W6QF019_1715604436; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6QF019_1715604436) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 20:47:18 +0800
Message-ID: <d9b393bb-55df-4280-a98d-3877fe52c947@linux.alibaba.com>
Date: Mon, 13 May 2024 20:46:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] target/riscv: Update address modify functions to
 take into account pointer masking
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <20240511101053.1875596-6-me@deliversmonkey.space>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240511101053.1875596-6-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/5/11 18:10, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/translate.c     | 22 ++++++++++++++++------
>   target/riscv/vector_helper.c | 13 +++++++++++++
>   2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 3f578d6dd8..da46e636f8 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -580,8 +580,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
>       TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
>   
>       tcg_gen_addi_tl(addr, src1, imm);
> -    if (get_address_xl(ctx) == MXL_RV32) {
> -        tcg_gen_ext32u_tl(addr, addr);
> +    if (ctx->addr_signed) {
> +        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
> +    } else {
> +        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
>       }
>   
>       return addr;
> @@ -594,8 +596,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
>       TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
>   
>       tcg_gen_add_tl(addr, src1, offs);
> -    if (get_xl(ctx) == MXL_RV32) {
> -        tcg_gen_ext32u_tl(addr, addr);
> +    if (ctx->addr_signed) {
> +        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
> +    } else {
> +        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
>       }
>       return addr;
>   }
> @@ -1188,8 +1192,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
>       ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
>       ctx->cs = cs;
> -    ctx->addr_width = 0;
> -    ctx->addr_signed = false;
> +    if (get_xl(ctx) == MXL_RV32) {
Maybe ctx->address_xl?
> +        ctx->addr_width = 32;
> +        ctx->addr_signed = false;
In tcg inline code, we have considered the XL. But
> +    } else {
> +        int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
> +        ctx->addr_width = 64 - riscv_pm_get_pmlen(pm_pmm);
> +        ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
> +    }
>       ctx->ztso = cpu->cfg.ext_ztso;
>       ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>       ctx->zero = tcg_constant_tl(0);
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 39ba2a09dd..28861cc509 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -104,6 +104,19 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
>   
>   static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
>   {

here, we don't process the MXL_RV32. We should process it explicitly here.

Zhiwei

> +    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
> +    if (pmm == PMM_FIELD_DISABLED) {
> +        return addr;
> +    }
> +    int pmlen = riscv_pm_get_pmlen(pmm);
> +    bool signext = riscv_cpu_virt_mem_enabled(env);
> +    addr = addr << pmlen;
> +    /* sign/zero extend masked address by N-1 bit */
> +    if (signext) {
> +        addr = (target_long)addr >> pmlen;
> +    } else {
> +        addr = addr >> pmlen;
> +    }
>       return addr;
>   }
>   

