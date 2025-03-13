Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06F4C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmFn-0003vE-D9; Thu, 13 Mar 2025 13:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmFh-0003uc-8o
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:21:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmFb-00089F-7m
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:21:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22334203781so45574825ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741886501; x=1742491301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rnyGx9+8GJDSKYJ2SHVn8Zc8jCbrAgx1zBwwBXAmDfU=;
 b=jnNL0MCpppS97QnjAhebxrXwUF6heNGmM46MkcsowHmo9xcM6LDgLOzxKvC/oYOjAu
 SBxe5xz0KV6mh0rny3EQkK4JEQqcfgOp+fU1bWnmNyed85WdeF9Vuygn9xly/+W3rNEH
 HVWEqpJdzVIkFTXVu6Wrfv+Pp48C6DSEwWNHK6D1ySfJtonhpTliKYsHt54e95/l0MmU
 U4d2qsTXYtioN2BrTJ54TLIgbtl2+L4P6qHEq9njbaJFmecLS0JsBDJgAcnXbpzFRFxq
 7zncWZh+L0jsd3RDUppWZCGuJfMriJ/d499kxyat/VC/sOvD4B++VxqGBhusVkvRc80k
 wnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886501; x=1742491301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rnyGx9+8GJDSKYJ2SHVn8Zc8jCbrAgx1zBwwBXAmDfU=;
 b=otaNuSEpOnrbitzoDhOG0v8YCCjZZRZZGf9mpIRH5Q24Osz6ho00TQCrx5MOwu6d2Z
 jzeDvBRqO8mefLzdtFfUQrMTURN76yaW9qQQdYpm84Qvhqj/AdAw6bwYlQRejUVGIMgc
 j5SENh/XTRg67KcIDVS/C67QYfbtBP/bIf6iGh0xXRmG5Jwg83Tvxh8lPs5k6G+8rfRZ
 Exkk/PX3glFCHmdYY2/voCBludR+WZ3aq/3uQpVxW8HklFnIBwcmQq1jWchk8eyFxpgo
 BL4Cwj0XE9tcVLQzorENVl8Bz+8iOosJ/nJAn+il1zqAp7Ngy3qTyLal0I1HiCH4O+Bi
 rjcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCnLnVLgjmSfqwoGPhMfdpF9BqUn9mHQn3Z/OCz5IdG2XMQ8+QM8y0l9ep1lP2B4VFYFP48VvVUvtv@nongnu.org
X-Gm-Message-State: AOJu0YxFzUKg1ZZ0CEBYnuu0u+ClIKNrHEgSNFQnxauxceoidrRqZU0h
 0bykA8ssQzMorEA8G2+9JCBF+Rv5yocNzb/j5vKOr/JEDD6zdEl1vOcdE9lDDyI=
X-Gm-Gg: ASbGnctp2bwcus6z7uQnrW1G5BhHn5IFCQsAnNSxfnYjKHbylOejrmHsX8bSmo+ryF/
 cZeuLV20r6IfdQQnrUjpUiO8NYbOckuc/L0HYJlhimYKJyj7qHdP3tIZ8MQnpCZOzuuDsJlp1zp
 qCcIvqkci42+yTiySAMjYmL9VBXwHVirXj8AwWtU+KvgWDx0NEEwPV1Hog8I84e68s4MBowPZBH
 y0T04DMETJlcOrO7JCtSyAwJZPESReHEAtz1poI6JRnBxuQXvIiMCBrJIu2k86kl3LO1UhBG1dm
 1lHSTULBI4WXBZzAEum35UhNqm9bKypkB2CsPSx3XHUOMdJvlMwoGY8XHA==
X-Google-Smtp-Source: AGHT+IFNvEC6jaP87I3U0CFg5RPGMFCWipEa9Jzt6wIP5tGn0nd4I2g8c2wsrPx/Rkm0t2ftEE3h8Q==
X-Received: by 2002:a17:902:e843:b0:21f:6dcf:fd2b with SMTP id
 d9443c01a7336-225c64f2fedmr45519495ad.1.1741886501417; 
 Thu, 13 Mar 2025 10:21:41 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbfdfesm15908045ad.203.2025.03.13.10.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:21:40 -0700 (PDT)
Message-ID: <a4ecadb5-2626-41f9-aeec-c08457e6e9cd@linaro.org>
Date: Thu, 13 Mar 2025 10:21:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/37] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/12/25 20:44, Richard Henderson wrote:
> Cache the mmu index in DisasContextBase.
> Perform the read on host endianness, which lets us
> share code with the translator_ld fast path.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h |  1 +
>   accel/tcg/translator.c    | 57 ++++++++++++++++++---------------------
>   2 files changed, 27 insertions(+), 31 deletions(-)
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
> index 0260fb1915..64fa069b51 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -11,10 +11,9 @@
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
>   #include "exec/exec-all.h"
> +#include "exec/cpu-ldst-common.h"
>   #include "exec/translator.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/plugin-gen.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/tswap.h"
>   #include "tcg/tcg-op-common.h"
>   #include "internal-target.h"
> @@ -142,6 +141,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>       db->host_addr[1] = NULL;
>       db->record_start = 0;
>       db->record_len = 0;
> +    db->code_mmuidx = cpu_mmu_index(cpu, true);
>   
>       ops->init_disas_context(db, cpu);
>       tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
> @@ -457,55 +457,50 @@ bool translator_st(const DisasContextBase *db, void *dest,
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
> +        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);

Should it be MO_UQ?

> +        val = cpu_ldq_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return tgt;
> +    return tswap64(val);
>   }
>   
>   void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)


