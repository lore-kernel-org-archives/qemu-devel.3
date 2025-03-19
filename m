Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAB1C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhDt-0006Xg-Bf; Tue, 18 Mar 2025 20:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhDl-0006VO-W4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:23:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhDi-0000EW-UK
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:23:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22423adf751so110512615ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742343817; x=1742948617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ivYpHRfJWLr9rshD8LTIAqr3W5R3RkI/xacMbSyBw10=;
 b=R8/cFkYvAz32swHHUCuUI7EztpFYAWPPBHeFpPMvdMG7cdzwIHHO1ThYLgnwZH/e8a
 lZ0XoHU4MKTchEDunCKJSlaZh3ti+DU9y2tpuM5qOjUMKg4/w8Qi3QjvlPK+W/4SsgZD
 k8K7tyBYgW1gsNRKXDxewaNLkfmZxhF/AmgRUSmViH8VwjBEWX5XRVAtzA8BtSh8ItQX
 AWmiIlavVgjUWXs3hda33CWhel6s194mWp5gMsUkTSB994iDi5QSqo/C4LKpRKr4Yq7V
 Iz7iM9D8W4LQqaT2UsyCOejduqjm38v9kTEFFX6mZvs3nhDv4icYpYvXNTSrenSm4T4E
 RJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742343817; x=1742948617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ivYpHRfJWLr9rshD8LTIAqr3W5R3RkI/xacMbSyBw10=;
 b=VM5eYh9DjVKx5g3VI7p29HUOn/Qlqst/4cLZhOG8DBPm5dPoqYkVbVmUaS16DBljGb
 KyKOsqdXEiNu5lobResiuOQET6pbpsXlcNmcwAr2z3fqHnGr8INBGeJ4e595xIa4ZeHV
 VfYi/C2FYfOGIrUbyoUbMzoRsBi7BCl2RByjJNsFLZ90kHmdWqmpG6czbdvpfYl1w79S
 J5F4vJzBcZvIzojL8+C1sncMf8JWB2x9zBWV1OBowsCrNeJCHFk9wqKpaknSJFjhCtar
 99LMqlbswUxabpKMlMBHkLYD/bNJb4FFwyMUgzwmRh1EtOthFi0ga4V+p/lPU6uPMhr+
 RorQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfvlmVR3RqgJGJWnH4mw0d8RnIJwTP4uXTXBghHdubmv1ozhbZigBSYlfT8kEpDYF0pV6CmewJRyLL@nongnu.org
X-Gm-Message-State: AOJu0Yw7FLKXsr0hyTnUazPuepBdW8W8u2qXo5GsmTjpQcNL9+FqkMn+
 f14wsksZSkEL+aP2YpuYipPbSpnAuqE7HZLgRFZGa+E4jXPKyVcJIZYINLMW8pw=
X-Gm-Gg: ASbGnctsWo5n+YNIAi8DFti0b2ipSPBxUoqPJeoJZecPRglpAZosAIEDZBroCWRWYM5
 xq3X8+oEoM/57iJufZr2uXb98jMk97uyEQ+l42CaJGwcgu4XaJzyaFt3jsFbkQCSiIlDxDkgzKX
 rKhXgfB5KzzsRkn/zD43YP6jZpTwhnjZNQBSHyItGkLw6i+uah05SeZrJcyglJSW7UEP3ifceGn
 i75GlZJwLRX5qTNvg30zhqqQoFz5W455zAz26AN4/3CMF34zJqGr1jIUM+bP4Gxn4Ca7k/G+qJ+
 JhYOnL449CPT91VPEXluecxjPqnrqoQM1V8p+ZKG+eLQhDmBeDkTINF6j/F9S3h+jthF
X-Google-Smtp-Source: AGHT+IFQw2BwftxCBJqQnAOKQRZRg2gU2v0+cc3tnKGmz8Bki6PnG6U1vroV2QalCdLE5TWqWJ08tg==
X-Received: by 2002:a05:6a00:18a9:b0:736:5e28:cfba with SMTP id
 d2e1a72fcca58-7376d6ce4afmr1280269b3a.18.1742343817507; 
 Tue, 18 Mar 2025 17:23:37 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371152958csm10271355b3a.26.2025.03.18.17.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:23:37 -0700 (PDT)
Message-ID: <f3b98848-70b7-4ece-8ba2-43f0e07302ac@linaro.org>
Date: Tue, 18 Mar 2025 17:23:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/42] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> Cache the mmu index in DisasContextBase.
> Perform the read on host endianness, which lets us
> share code with the translator_ld fast path.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h |  1 +
>   accel/tcg/translator.c    | 58 ++++++++++++++++++---------------------
>   2 files changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index d70942a10f..205dd85bba 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -73,6 +73,7 @@ struct DisasContextBase {
>       int max_insns;
>       bool plugin_enabled;
>       bool fake_insn;
> +    uint8_t code_mmuidx;
>       struct TCGOp *insn_start;
>       void *host_addr[2];
>   
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 157be33bf6..6fd9237298 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -11,10 +11,10 @@
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
>   #include "exec/exec-all.h"
> +#include "exec/cpu-ldst-common.h"
> +#include "exec/cpu-mmu-index.h"
>   #include "exec/translator.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/plugin-gen.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/tswap.h"
>   #include "tcg/tcg-op-common.h"
>   #include "internal-target.h"
> @@ -142,6 +142,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>       db->host_addr[1] = NULL;
>       db->record_start = 0;
>       db->record_len = 0;
> +    db->code_mmuidx = cpu_mmu_index(cpu, true);
>   
>       ops->init_disas_context(db, cpu);
>       tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
> @@ -457,55 +458,50 @@ bool translator_st(const DisasContextBase *db, void *dest,
>   
>   uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint8_t raw;
> +    uint8_t val;
>   
> -    if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        raw = cpu_ldub_code(env, pc);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UB, db->code_mmuidx);
> +        val = cpu_ldb_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return raw;
> +    return val;
>   }
>   
>   uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint16_t raw, tgt;
> +    uint16_t val;
>   
> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        tgt = tswap16(raw);
> -    } else {
> -        tgt = cpu_lduw_code(env, pc);
> -        raw = tswap16(tgt);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UW, db->code_mmuidx);
> +        val = cpu_ldw_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return tgt;
> +    return tswap16(val);
>   }
>   
>   uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint32_t raw, tgt;
> +    uint32_t val;
>   
> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        tgt = tswap32(raw);
> -    } else {
> -        tgt = cpu_ldl_code(env, pc);
> -        raw = tswap32(tgt);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);
> +        val = cpu_ldl_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return tgt;
> +    return tswap32(val);
>   }
>   
>   uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint64_t raw, tgt;
> +    uint64_t val;
>   
> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        tgt = tswap64(raw);
> -    } else {
> -        tgt = cpu_ldq_code(env, pc);
> -        raw = tswap64(tgt);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UQ, db->code_mmuidx);
> +        val = cpu_ldq_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return tgt;
> +    return tswap64(val);
>   }
>   
>   void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)

If I understand correctly, cpu_ldq_code_mmu performs the tswap call we 
used to before. However, we now call it again when returning the final 
value, leading to tswap(tswap(val)).

Is that expected?

