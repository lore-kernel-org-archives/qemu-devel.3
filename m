Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF76104891F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6m2-0004B9-RK; Fri, 27 Feb 2026 17:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6m1-0004Ag-5n
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:57:29 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6lz-0005tz-HG
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:57:28 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43991064db8so2601316f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772233046; x=1772837846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DEkCbFaU9ruq+A7JjSkb7tvyWdk5fZ7zg70gzAu9Ri0=;
 b=EvHNBjeJ3JY/hpjXjPljtrQ8HLNR1U3T3Q/pRyIkdLwA+6OU/JGqli/7gB4hWgOHxL
 hBwyYR3RywzwoBwaG/b57SVMXrxBkq9zxYYctM/bI9wnPJfWii0uNgVyBo9Dxe6S08mA
 72wrdbAn9SzGM2EPVQs3T2turHEoxDCWD+XgwaoSf08KsTJBlNPx0vuEPjAZ0fuBRArQ
 /QmOA1IMvzmmILiq0pk2pq6HCFda69oSMt2108vNVamYOWuV4oLHwbRG3hRCGy9LY4YS
 e9UId+Vl/LO364Qhj8PAp5NP0DbuyBYDquFjA7QCh9FhErk/AnUEOpE1UA1SQ9RT5MfH
 9dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772233046; x=1772837846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEkCbFaU9ruq+A7JjSkb7tvyWdk5fZ7zg70gzAu9Ri0=;
 b=ja8nwfsf0IJQx5mWBYiJvaGHv1H5pK3jSEh6i/2eZdwLWHCzTMzU1zL/KnotS0hQS5
 7Ut5ie0CYaBiQG/Krekq5GVK6mcG5ws8X3WbHzz5B/itOloqtYTbGhiMofpr/VfDZdFo
 VHN8RuNkM35U4B5xzVIZ2fEwhRDZZqcMlRmkWHTT6QXdp3yqaP/GDrETI2suXW5w4vlq
 1g1Y3HDxkWKiOwABZw43sBPJDeLoWrmpe4A+gxA4fZKWfIi87afbQV2Q6MrRDk0QYHMk
 GXdvMqpZP3Wa2XWo8DAOvO+T8LhxckhENep+/yr139s4ArARraacrwz2TAtUpIypxUqY
 0pCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqQ45nCQFTHuxX1rh2RwVavrUt/pSTHka7zYjQFFdRBP29Bz5n7HQbNG4lU3WhRzmc7q5bOVn2M9jq@nongnu.org
X-Gm-Message-State: AOJu0Ywm/Z/v5M4v6m2WigDZJbQ6HRIOffvV6jHUvfC1iQJbQqTi9/nJ
 iFBKKsS/Ji7E8NnlKqvN0d5ynzDLTUApnx67rRywsJ/P31wnxpeoNxZaswiAnogvW+W99zzfMdf
 FlJaV8R8=
X-Gm-Gg: ATEYQzxJ9ynmyzY/kfD6UaIZv6qPvIMTCeG1/djEcpkamVjJsZtYGJpoGky29jg9DZE
 sKbAKAtcALI0Gv1jGFyM0jkaO4QvwI1vFkiM3vIDh95ZrbRHkj8blsDs1A584x6T/k9JFWxbdYM
 K0RGZhjcdFzwOQ5SReYWK2Abr25xnY+CIfyrSVhunTXeknwjDxFZXG6WAAv9ttju9pz1hnCBodC
 g1sSchmWEipgnoZG3ALyyeqeelub5g11S0d/KxiR73PRg8FjricKxcIvR0lmRPEdQakYmLHKUSJ
 wzvP27PGqx477QU+lTiuWVBCnhkX+fWs6xEjtp86yS/OqZzT/hVIx5zbf8TRUwPp6ctklK++bQN
 Fat0U95rO4D6KwbdysvoXEDJesdMlUEuOkcbAWuzGt5CKxlquuyXu3HLUvlpFu9x6y/Mh64Ck6D
 /UepsZpa5X0tw5G1+rkrqsJmLmi2IgDGhwjNyl2Fb9vM7bwvlIOQ6C2TnPaOzn24B7FA==
X-Received: by 2002:a05:6000:2c10:b0:439:9225:3378 with SMTP id
 ffacd0b85a97d-4399ddfc322mr7383685f8f.24.1772233045911; 
 Fri, 27 Feb 2026 14:57:25 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70e8dasm9292725f8f.9.2026.02.27.14.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:57:25 -0800 (PST)
Message-ID: <53ad6334-01f6-4c85-95bd-685823e40732@linaro.org>
Date: Fri, 27 Feb 2026 23:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] target/riscv: Use MO_LE for instruction fetch
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-15-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225102016.200654-15-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 25/2/26 11:20, Djordje Todorovic wrote:
> From: djtodoro <djordje.todorovic@htecgroup.com>
> 
> RISC-V instructions are always little-endian. Use translator_ldl_end
> and translator_lduw_end with MO_LE instead of tswap on translator_ldl
> results.

OK, but this contradicts your previous own patch in this series:
[PATCH v2 04/16] target/riscv: Ensure LE instruction fetching

Squash them?

> ---
>   target/riscv/translate.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 67dfb5f1c0..57dfc68220 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -23,8 +23,6 @@
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
>   #include "exec/target_page.h"
> -#include "exec/tswap.h"
> -
>   #include "exec/translator.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/translation-block.h"
> @@ -1255,13 +1253,13 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
>            * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
>            * additional page fault.
>            */
> -        opcode = tswap32(translator_ldl(env, &ctx->base, ctx->base.pc_next));
> +        opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next, MO_LE);
>       } else {
>           /*
>            * For unaligned pc, instruction preload may trigger additional
>            * page fault so we only load 2 bytes here.
>            */
> -        opcode = (uint32_t) tswap16(translator_lduw(env, &ctx->base, ctx->base.pc_next));
> +        opcode = (uint32_t) translator_lduw_end(env, &ctx->base, ctx->base.pc_next, MO_LE);
>       }
>       ctx->ol = ctx->xl;
>   
> @@ -1280,9 +1278,9 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
>       } else {
>           if (!pc_is_4byte_align) {
>               /* Load last 2 bytes of instruction here */
> -            uint16_t opcode_hi = translator_lduw(env, &ctx->base,
> -                                                 ctx->base.pc_next + 2);
> -            opcode = deposit32(opcode, 16, 16, tswap16(opcode_hi));
> +            uint16_t opcode_hi = translator_lduw_end(env, &ctx->base,
> +                                                     ctx->base.pc_next + 2, MO_LE);
> +            opcode = deposit32(opcode, 16, 16, opcode_hi);
>           }
>           ctx->opcode = opcode;
>   
> @@ -1397,8 +1395,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>   
>               if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
>                   uint16_t next_insn =
> -                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
> -                next_insn = tswap16(next_insn);
> +                    translator_lduw_end(env, &ctx->base, ctx->base.pc_next, MO_LE);
>                   int len = insn_len(next_insn);
>   
>                   if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {


