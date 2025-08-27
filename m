Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473C5CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urGo5-00011H-R3; Wed, 27 Aug 2025 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urGnz-0000yC-N4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:07:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urGnx-0003w4-MO
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:07:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a1b001f55so37285845e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756303630; x=1756908430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5tuF2+iVfrnm3Gv0vD720/zsDDKn0hjk7M+x9BdszY=;
 b=D6EBeas2uw6eALxqnPgGjedUNQs/xDqjrf0Ov4ePKtR1MguIfe4IXxrrHHpUhnKiwy
 /gc/DlWRqzBWXhbMfxp/BGjueuXbebdn3/zxSWtIipUPbzSYkf3NfiP3rMbzgQ7sFOXB
 sjO8NvU/lXU0XrioAx4PM2zQMGh6HhYRg5l7EjSfoAvkJqcrGzc/6vvD/l2b+5pWHW9Y
 DuUt4+rDQQ57CGuqClApuLVSDe2Zt/y+NY4yJoUaifufm1X2yu60PW5jOX5jR6s9ntBx
 lyrkDbWxOrzcatqlyyatrbWXUCfyhFjUe5CDtPM5Dm0NY1zTkcqsCs/Xmfxo9RnimAEK
 8PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756303630; x=1756908430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5tuF2+iVfrnm3Gv0vD720/zsDDKn0hjk7M+x9BdszY=;
 b=EMExUTFgRTFBjqIeFn0VTNW2MWm/jUvQ3itmdGwUhuzEYt895mkfxM0iRLkuOpMPQR
 wzCsBlM/XTtLEHGgHH65iiUg7RhjuWHWZoL+1uV/ln1SG9rxQYe+RNB9pGFYzfxND9t9
 rgDauEUhrf+jZoKW3yyVnKS5sJ1dnyDqFp8E+diTkJRaEJHEYTJ/OkpXnUQP+7qA9Hfy
 Yjp2kEhStiP1zRC7OMFvNS6AbuKbEVopVs0l+c8qwaJr7kWJqPGA+D7WBGLylHWwQ2kR
 GkSlk+VP1J6BOAfc0sz3ImgqOxKOV84bH4hOC8Wsh+zbSAFfGvOcdvRS5UOeJFRp+dGE
 KwbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKOa+9xfRbfaNdEAUBWHzyDLpiwP2hZG+q2It6uLwkqM3tAvmxX1g3mTbUhRfxa3kvwoa8diEzU3vQ@nongnu.org
X-Gm-Message-State: AOJu0Yz+A9/OJwx8e5PDIooXFIRp3oGZ31f+aAkfRgaXLhvw9mtjO+X4
 UvTgZumTvTDEx09ADRGgt/axsNYIKcSDNciRZW3No4hZ7lrPA5lZsaR32938ik0bRQ8=
X-Gm-Gg: ASbGncvWslk8qQuwgQv/XBNDmwTBK4Oo8kSmcH0u+E0mD4wuV1nngL1A/wbT9vH/KUt
 0cXcZ3JFhSL3L7DRZQLod6ABQfpWFhLJocYfgExt5Ppc0UxbEfeeqsSr/wRGEUNSc5UVUyQfzwT
 8k7k5QadIRbOoLzSMHGqqLqRgqZj1tGf4OdragixJl7xk+7CdsHx7fmrskkUaJlL4zekbR0gbc1
 wx97oWSOjSpta66/m96SgCxl3TXIW765jetsYZ20qV/FOGlOOf6deksmU+VqqLdb+uFKTjhD5ne
 8mdr9ALM/A8GhCLN/iya2MvhiKek517hwdljVQPlDKviy2iKloNciWDo3TMiQHja1LZ5xboHVjj
 PDtH2sC3k8kO4iKzD3mNIVxcb/B8K15sT5MskKTw57FlZpo7P0uGkwXUxbQiftqQiOmxTtmc=
X-Google-Smtp-Source: AGHT+IHhnmKRSBaXhMho1xJOsWVgi5LQUW8KbM1C6nlGXeUlzjZdopYo3Zo2W82a3Vw/e8yYqsUY9A==
X-Received: by 2002:a05:600c:609b:b0:458:a7b6:c683 with SMTP id
 5b1f17b1804b1-45b541d1026mr161386315e9.1.1756303630019; 
 Wed, 27 Aug 2025 07:07:10 -0700 (PDT)
Received: from [10.223.47.213] (54.red-88-28-4.dynamicip.rima-tde.net.
 [88.28.4.54]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cc7b699d5dsm3616507f8f.48.2025.08.27.07.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 07:07:09 -0700 (PDT)
Message-ID: <92e74dad-2027-49ab-8af5-5181b829d68d@linaro.org>
Date: Wed, 27 Aug 2025 16:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PULL 07/12] ppc: Get out of emulation on SMT "OR"
 ops
To: benh@kernel.crashing.org, qemu-ppc@nongnu.org
Cc: agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>,
 pbonzini@redhat.com, peter.maydell@linaro.org, bharata.rao@gmail.com,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <1464655277-14748-1-git-send-email-david@gibson.dropbear.id.au>
 <1464655277-14748-8-git-send-email-david@gibson.dropbear.id.au>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1464655277-14748-8-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

(old patch merged as commit b68e60e6f0d2865e961a800fb8db96a7fc6494c4)

On 31/5/16 02:41, David Gibson wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Otherwise tight loops at smt_low for example, which OPAL does,
> eat so much CPU that we can't boot a kernel anymore. With that,
> I can boot 8 CPUs just fine with powernv.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   target-ppc/translate.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/target-ppc/translate.c b/target-ppc/translate.c
> index 51f6eb1..fe10bf8 100644
> --- a/target-ppc/translate.c
> +++ b/target-ppc/translate.c
> @@ -1392,6 +1392,19 @@ GEN_LOGICAL2(nand, tcg_gen_nand_tl, 0x0E, PPC_INTEGER);
>   /* nor & nor. */
>   GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
>   
> +#if defined(TARGET_PPC64)
> +static void gen_pause(DisasContext *ctx)
> +{
> +    TCGv_i32 t0 = tcg_const_i32(0);
> +    tcg_gen_st_i32(t0, cpu_env,
> +                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));

This sets CPUState::halted = 0, as unhalted state (a.k.a. "running"),
is that expected? I'd expect "Pause" to halt the vCPU to avoid spinning
(as mentioned below).

> +    tcg_temp_free_i32(t0);
> +
> +    /* Stop translation, this gives other CPUs a chance to run */
> +    gen_exception_err(ctx, EXCP_HLT, 1);
> +}
> +#endif /* defined(TARGET_PPC64) */
> +
>   /* or & or. */
>   static void gen_or(DisasContext *ctx)
>   {
> @@ -1447,7 +1460,7 @@ static void gen_or(DisasContext *ctx)
>               }
>               break;
>           case 7:
> -            if (ctx->hv) {
> +            if (ctx->hv && !ctx->pr) {
>                   /* Set process priority to very high */
>                   prio = 7;
>               }
> @@ -1464,6 +1477,10 @@ static void gen_or(DisasContext *ctx)
>               tcg_gen_ori_tl(t0, t0, ((uint64_t)prio) << 50);
>               gen_store_spr(SPR_PPR, t0);
>               tcg_temp_free(t0);
> +            /* Pause us out of TCG otherwise spin loops with smt_low
> +             * eat too much CPU and the kernel hangs
> +             */
> +            gen_pause(ctx);
>           }
>   #endif
>       }
> @@ -1489,8 +1506,6 @@ static void gen_ori(DisasContext *ctx)
>       target_ulong uimm = UIMM(ctx->opcode);
>   
>       if (rS(ctx->opcode) == rA(ctx->opcode) && uimm == 0) {
> -        /* NOP */
> -        /* XXX: should handle special NOPs for POWER series */
>           return;
>       }
>       tcg_gen_ori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], uimm);
Note there is a similar code in gen_wait() doing the same (but 
correctlyIMO):

  3366  /*
  3367   * wait without WC field or with WC=0 waits for an exception / 
interrupt
  3368   * to occur.
  3369   */
  3370  if (wc == 0) {
  3371      TCGv_i32 t0 = tcg_constant_i32(1);
  3372      tcg_gen_st_i32(t0, tcg_env,
  3373                     -offsetof(PowerPCCPU, env) + 
offsetof(CPUState, halted));
  3374      /* Stop translation, as the CPU is supposed to sleep from now */
  3375      gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
  3376  }


