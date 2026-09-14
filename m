Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2330AC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5vKd-0008N2-33; Sun, 13 Sep 2026 21:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vKX-0008Ms-Ag
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:17:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vKT-0006x0-P0
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:17:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso25885765ad.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789348672; x=1789953472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rJwWQ1B0UNmdXzQP/tsP3RtcBA4w+0PuGKVtndws6Xg=;
 b=rX5tnempLkPOcGFoiGm7LulRsTLkpLp7DBeLtM/a9Ujfk1PEA5zbVsu3IL6BIIZLT3
 CBEYvLuiyFxtbDldc7za6eZOQMl23JrT6DQNqizEfXCGALC0bhQnvXRqyFXACx3TdAFj
 qiB3CkDpAlAleWmmROBd13I96u78k2G1E9zFOOnLeJKaBVi2+yBLVYe31JmnvvQKyRYa
 j5LvXtcN9gdF9R1cnG9a3JLTNRylHenJBENv+zXmLpBm9lcCKUVlYVyiUBcNnPAh0Afu
 AI3py7o/kkhp5QjQufVZntwY85mkz+TyfO62SE9Zmiw+pfBjLPYHEqvz5JABMhaXc2ck
 qqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789348672; x=1789953472;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rJwWQ1B0UNmdXzQP/tsP3RtcBA4w+0PuGKVtndws6Xg=;
 b=aEE8RJYzfAORYtUGtzq+fsIfqAG2YmbfNmjG4dBbb+krAOz5eJzkHfIOWJFJVBfg63
 LM0YCbzs3Nh6ezPpeAzU3bsStjzho9F8d8voLCjYXanOLc34ESlTCPM/KUddl8hV0M8v
 7XRDEHxtnFLjjzp3Xz83gDv7mSTfI3/39Mt7uwbkotpWI+ttzj5mnuKAjvDeXb2L0yG0
 cMz5U/FjR+zAGZT/eiAitNeTdKWMo/lEk6siCu7DeWHeJwcdvAgy4uRat6w/wKlRjzJ+
 i3FHyOBeL+Hg2xUKsbFaMv4EZRa4+lb10ADKlMSvnMT+sZmVPwow15NPB3YGJtElJdS1
 mhKQ==
X-Gm-Message-State: AFuF++k0ymb41o2lAOC1lK+gNRCakF9rbJKt14k+FKxhQC9N66sjCnuS
 srOo//Yrjs6I7d8UCZ/0pvfwyarJkPMjLRycV03b+C9R1nj4vcqvzHTI7556ImpNjeKGY3RqL1i
 BLGiUCZA=
X-Gm-Gg: AYBFou2rVwqL9LHeGVNymIbD34PJdi1/dqBDP48LRg+tnU28RonpSCOajri4ht/a7//
 MZiLWttiFwVcbEoFyg8+iJQnbiyNo0gWGD7fzdv1Vb4wXGlfBhjpDi4s2vsTtrFNw52S/z24hkW
 wSKzL43IKVyO3CWt28g0phw7OxLBexdLjHIJ+3ZvkIdN9gXpDXlDsbF9wN8RJ0MuVMU7vLqvuk7
 BUtt56tVTsSCjQew8f6Bhj/SRK4ekT9n6ETL7dQRD/yfdaNY4+cw7MfU76OBrhgJ+wCjLtF8noV
 KSQQAdQpla8Mif85+umDXG2Hxy+rjp2YPtGxXrkCyIezDV0CLtqcNDCV+KAC7TCFO6MEJO5WjBD
 FI+qwGxcO84EBbgeQHACQQbHtT6BXCCzkgCTrGxEf0lu/+ht7OkzExhvTtdLPXRAPkWVfftRwu9
 auWAOv6t0haucLKto630w+10mwUDHQIR9LdEW+2EP5SlZM9ETAqi7mzOrvi7/vtNd/TYE1HOxMS
 ahgeZdB4vR7ElTydPlLNqJsHqphvQizff0RW9LpHGCgK6nVzAwEp59ZoN3e/w==
X-Received: by 2002:a17:90b:2712:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-39dec122218mr881758a91.21.1789348671013; 
 Sun, 13 Sep 2026 18:17:51 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bc03ac1ecsm10334940eec.10.2026.09.13.18.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 18:17:50 -0700 (PDT)
Message-ID: <b11c9b27-8ec0-49d9-8cad-9f04b1ad3641@linaro.org>
Date: Sun, 13 Sep 2026 15:17:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use for
 sfence.vma with vaddr operand
To: qemu-devel@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/4/26 08:43, Trevor Gamblin wrote:
> sfence.vma unconditionally called helper_tlb_flush(), regardless of the
> rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
> next access. Create a page-level counterpart to helper_tlb_flush()
> called helper_tlb_flush_page(), and use it whenever rs1 != 0, falling
> back to the existing full flush for rs1 == 0. This makes RISC-V
> behaviour more similar to ARM's equivalent (tlbi_aa64_vae1_write), which
> already does tlb_flush_page_by_mmuidx() instead of a full flush.
> 
> Pass get_address(ctx, a->rs1, 0) to gen_helper_tlb_flush_page() rather
> than get_gpr(), so that the address being passed matches the current
> addr_xl width regardless of '-cpu' input. Otherwise, the raw register
> value can carry garbage above that width and never match the address the
> TLB entry was actually filled under, so the flush silently misses and a
> stale mapping survives.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   target/riscv/helper.h                              | 1 +
>   target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
>   target/riscv/tcg/op_helper.c                       | 6 ++++++
>   3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 4fc2d3a155..652f85a5c7 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -137,6 +137,7 @@ DEF_HELPER_1(ctr_clear, void, env)
>   DEF_HELPER_1(wfi, void, env)
>   DEF_HELPER_1(wrs_nto, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
> +DEF_HELPER_2(tlb_flush_page, void, env, tl)
>   DEF_HELPER_1(tlb_flush_all, void, env)
>   DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>   /* Native Debug */
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index a8eaccef67..8655fa332e 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -155,7 +155,11 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>   {
>   #ifndef CONFIG_USER_ONLY
>       decode_save_opc(ctx, 0);
> -    gen_helper_tlb_flush(tcg_env);
> +    if (a->rs1 == 0) {
> +        gen_helper_tlb_flush(tcg_env);
> +    } else {
> +        gen_helper_tlb_flush_page(tcg_env, get_address(ctx, a->rs1, 0));
> +    }
>       return true;
>   #endif
>       return false;
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 7f63f3ada5..178b4d271b 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -607,6 +607,12 @@ void helper_tlb_flush(CPURISCVState *env)
>       tlb_flush(cs);
>   }
>   
> +void helper_tlb_flush_page(CPURISCVState *env, target_ulong addr)
> +{
> +    check_sfence_vma(env, GETPC());
> +    tlb_flush_page(env_cpu(env), addr);
> +}
> +
>   void helper_tlb_flush_all(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);
> 

You're missing the similar changes to sinval.vma and hinval.*


r~

