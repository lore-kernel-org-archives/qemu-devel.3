Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A4DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xTw-00032z-Om; Tue, 23 Sep 2025 03:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xTn-0002zw-SV
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:30:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xTd-0002WS-16
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:30:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45f2c9799a3so38735235e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758612607; x=1759217407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JZsHAm6k6n/KB71tK1sveo6UNgf8hxXmVJpwfr1pKGA=;
 b=dbCYdn9jdYH8lGhc3m/VMVFVRLtxRPyzDpTXaYxSS/X/sa9HF0IUyISAOPATxnpGau
 VLCAZDF3oh+84ESeof2lkLqPGuCAcbUvsi12pDuRZ2g82i3f7PjxCk3Eq8c+6saRIzeY
 RYopHBfSqQEWR08VU6rFKeX4Ao4ZGAjgjCykSc54Mxt+yw7obFTpJw4iCSDX+EkW1uHH
 5Qkv/FGo85XmPEkO0dTUKoWrSGNaKV7Z0mTUAqHUOOqcBGain6N6Uyi9bqSke5kltRwL
 7dSHPDLn+oS6JsF3d5QkNeYXmn30ie2KCruNsxgRU2gWX23QkgkiLygAEnIESyLi1/Ee
 ibYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758612607; x=1759217407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZsHAm6k6n/KB71tK1sveo6UNgf8hxXmVJpwfr1pKGA=;
 b=dLXhWgEQx4gCIMgU0uHhLKW3s/5poDp7Aty/uxvlz7CYUGWp+nef1laLI8Fm7Di1UJ
 UwUJbJ1DV+NvHW7o64Ek/1s15M+djcpHwwN0KI95a3StKKC+TRIYxlVWWnY8nH1P1lKy
 Bpv/595U3L5q90ld8mX1WHv8pjhQNQ/AhusJ3tpGGnSz5cZsk/yW/TzLdPvN634nz897
 hlHg+zzefSpN4RP/pBug27Icl6zJpk+q4SRiXM8vnwVYVzoaE53FW4q1294is8tOwK5K
 weygP2Zgfv+ku/pqPjhdwcvwnZBQMXyvaoXlVM7nIP7dgBFla1wJTrW6mzAsiZakdoO0
 as2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBcgqs+Y1iAqcBg4KgbwFCJoOmyCRhQcN/4gdCEOKfVg6fDX8ww/63hb60ITi6rymoqyXRYbS4D2BH@nongnu.org
X-Gm-Message-State: AOJu0YwvD6mjNXqoQow89H1Fi0U6ojpJVNd4LEMeY0beejwQeUpc+eei
 3PDFMXErm/wJk/04FkTNdgx4a4D7cx8Qg7Z7pxzbrVttVj2E5m0IZem0fyYHFjqgBKU1N0BM7di
 UlmO3PJ6vGQ==
X-Gm-Gg: ASbGncvHYmPmzVUVs/R7ejg3LWwRLoo695cOj7DS1TiVnIzIiBwi/wtoJf5uqu/45Of
 SZ8nfqCM0SzhcAVhL0ebahiCfQaVw9lACYAYmskSODGtl1w+mLJ3nKVe82MUafwdaB7zLC7L86D
 v6e/dnw80CZWfdmeTo7Kru+CwoNVrZcULBE43gqq0RKbyyjwnLiIAfdzOH/AXy4ulWuHuIphoZ7
 7GpKRI4tEmY0HpAphVzAi/JpYWxmsOHMBBJO5fIvVLFuNOdASwWoMQ11fGXFn1T+/gPRV+ESBuu
 KesftjijSlH9eDqT8gPNKswI/F7pljQnZmddGfzou4OHKR0kEmNcDn0T4RtgvMHjAdvm/yqdMPQ
 4CksDHPxCY9LutgN8aVQ2pea2y710/w13oAAJyOTYYVFvQqi4cCjlXCfGdPDJmRbrO/94cNRtJy
 VX
X-Google-Smtp-Source: AGHT+IH/Pu1q2rQWUwoovUvhwLKNUKywRyHinybfSZkpUUZmGC9zqxdokgolVE/evjTMlyuAMqAz9g==
X-Received: by 2002:a05:6000:2907:b0:3fd:3bcc:c205 with SMTP id
 ffacd0b85a97d-405bb34e68fmr1250958f8f.0.1758612607128; 
 Tue, 23 Sep 2025 00:30:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbf53cesm24281346f8f.59.2025.09.23.00.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:30:06 -0700 (PDT)
Message-ID: <adcd026f-398f-47c3-828b-af13f362cc94@linaro.org>
Date: Tue, 23 Sep 2025 09:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] target/alpha: Simplify call_pal implementation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 23/9/25 04:39, Richard Henderson wrote:
> Since 288a5fe980f, we don't link translation blocks
> directly to palcode entry points.  If we load palbr
> from env instead of encoding the constant, we avoid
> all need for tb_flush().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/helper.h     |  1 -
>   target/alpha/sys_helper.c |  6 ------
>   target/alpha/translate.c  | 21 ++++++---------------
>   3 files changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/target/alpha/helper.h b/target/alpha/helper.h
> index d60f208703..788d2fbf28 100644
> --- a/target/alpha/helper.h
> +++ b/target/alpha/helper.h
> @@ -90,7 +90,6 @@ DEF_HELPER_FLAGS_2(ieee_input_s, TCG_CALL_NO_WG, void, env, i64)
>   #if !defined (CONFIG_USER_ONLY)
>   DEF_HELPER_FLAGS_1(tbia, TCG_CALL_NO_RWG, void, env)
>   DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, i64)
> -DEF_HELPER_FLAGS_1(tb_flush, TCG_CALL_NO_RWG, void, env)
>   
>   DEF_HELPER_1(halt, void, i64)
>   
> diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
> index 51e3254428..87e37605c1 100644
> --- a/target/alpha/sys_helper.c
> +++ b/target/alpha/sys_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> -#include "exec/tb-flush.h"
>   #include "exec/helper-proto.h"
>   #include "system/runstate.h"
>   #include "system/system.h"
> @@ -38,11 +37,6 @@ void helper_tbis(CPUAlphaState *env, uint64_t p)
>       tlb_flush_page(env_cpu(env), p);
>   }
>   
> -void helper_tb_flush(CPUAlphaState *env)
> -{
> -    tb_flush(env_cpu(env));
> -}
> -
>   void helper_halt(uint64_t restart)
>   {
>       if (restart) {
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index cebab0318c..f11b382438 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -48,8 +48,6 @@ struct DisasContext {
>   
>   #ifdef CONFIG_USER_ONLY
>       MemOp unalign;
> -#else
> -    uint64_t palbr;
>   #endif
>       uint32_t tbflags;
>       int mem_idx;
> @@ -1155,7 +1153,6 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
>   #else
>       {
>           TCGv tmp = tcg_temp_new();
> -        uint64_t entry;
>   
>           gen_pc_disp(ctx, tmp, 0);
>           if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
> @@ -1165,12 +1162,11 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
>           }
>           tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUAlphaState, exc_addr));
>   
> -        entry = ctx->palbr;
> -        entry += (palcode & 0x80
> -                  ? 0x2000 + (palcode - 0x80) * 64
> -                  : 0x1000 + palcode * 64);
> -
> -        tcg_gen_movi_i64(cpu_pc, entry);
> +        tcg_gen_ld_i64(cpu_pc, tcg_env, offsetof(CPUAlphaState, palbr));
> +        tcg_gen_addi_i64(cpu_pc, cpu_pc,
> +                         palcode & 0x80
> +                         ? 0x2000 + (palcode - 0x80) * 64
> +                         : 0x1000 + palcode * 64);
>           return DISAS_PC_UPDATED;
>       }
>   #endif
> @@ -1292,11 +1288,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
>       case 7:
>           /* PALBR */
>           tcg_gen_st_i64(vb, tcg_env, offsetof(CPUAlphaState, palbr));
> -        /* Changing the PAL base register implies un-chaining all of the TBs
> -           that ended with a CALL_PAL.  Since the base register usually only
> -           changes during boot, flushing everything works well.  */
> -        gen_helper_tb_flush(tcg_env);
> -        return DISAS_PC_STALE;
> +        break;
>   
>       case 32 ... 39:
>           /* Accessing the "non-shadow" general registers.  */
> @@ -2874,7 +2866,6 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>       ctx->ir = cpu_std_ir;
>       ctx->unalign = (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
>   #else
> -    ctx->palbr = env->palbr;
>       ctx->ir = (ctx->tbflags & ENV_FLAG_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
>   #endif
>   

Probably unrelated but still same target, could you also update the
comment added in commit fe57ca82b09 ("target-alpha: Add placeholders
for missing userspace PALcalls")?

         case 0x86:
             /* IMB */
             /* ??? We can probably elide the code using page_unprotect
                that is checking for self-modifying code.  Instead we
                could simply call tb_flush here.  Until we work out the
                changes required to turn off the extra write protection,
                this can be a no-op.  */
             break;


