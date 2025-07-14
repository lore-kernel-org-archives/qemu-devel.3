Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F9EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQaP-0002pV-JM; Mon, 14 Jul 2025 17:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubP36-00021I-7Y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:41:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubP33-0002E8-Qk
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:41:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74b50c71b0aso2680542b3a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752522071; x=1753126871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8kbhLWeO1agnqH+2iodbCvt5U+Jl8WSYS0tBFEtKL0=;
 b=smN1wiH+Ljfi2Mm6Cw6P9dtkG1dbDaO0hCVKfTyoJPPbgkAcxi9uy020v84J0bzmGq
 nzt0dvk228YkLiDy4cKgNW6pSUh2GSmVl/zOuRKI/yBHlrkenILPn3Wo7cUp21sowF0i
 8qtrD0a6D6/DnH23C897JxWWjdMn43i1BpeFACMztJWul0L8lCgpsRgP8BoGnnKOWeEQ
 CPs4DUika/z04RJybBOa4zjn6z65juGYF2+kqSd/po8x/MQVD1mL2U1K7SWxyjFvMxvA
 IdNWwKNyGlyQF7htXK6ojb72BgJzfoTvHLdVu8VoG40hwv+YMdf/ng8IYNibAGZR1b3U
 8E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752522071; x=1753126871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8kbhLWeO1agnqH+2iodbCvt5U+Jl8WSYS0tBFEtKL0=;
 b=MSUDS+qlwhOYskRdYBalAmv9BNHs1uDtgj057hWYu81laR0XcafziRRYUzw9ae59bq
 I2Td3FL6LKttxGxjmvqkfpHibsEEGZWWHKXrQ23/c8lOORGXNKRjQlSoAptN++G7PzZg
 kuqQ3SHHlA0tLCzVLbgRsTc1lB8QOFaHMr9xkQ+mHt+0ofqeRC9waqZzsHgTSADw8swE
 BirOOTcLNWbZX+sHXJa8L8GTBRSHO3ZDfSzvud+afAQaiikjuhtfqFvBVTmEt5bqk6PQ
 sJZ6Wws9x6CvG0LcKEIVh/fNOJ486SSbxv04aRob/qBqiT4EuvG5sA6XG/RKxcI5UuOF
 p7fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5VBCEb4LEWtxYvPCn/9Suvg9PId/PBR47jNFc++UON/Q42OigERj1JrOdov/RqIFTzwwOvRoOyqpf@nongnu.org
X-Gm-Message-State: AOJu0YyplLjtsOj4t/mef6nruDbG/80GVpsx5gtQz41UC4mx2pXs2XSB
 qAXxiI8Pi2nDRHL5sacvbzpeHybDRejH7cJ1Mw3NnWaC9CqMzoJGFsPTgCDgiKAk/LQ=
X-Gm-Gg: ASbGnctricSGpanZXq/K50wuWk+QEaPBBhwyOszQZIb7itpCiuy2TmdxqZDLUhE2+H9
 J+FlEu0Wwrcw/zJcsULnVIDnKKurg6QKfv5MdvQ4Km5Q3m5GN1PQrnbfFUUid0x9hfWk5E4iw9J
 4wiN02S1QjerFKEDOg/W2H8v8WH/cM4ay9QdQTUVKOO1mxyW/6utqNrj9SLcEJ8pQlQdLz93WaJ
 LxAXD9eYTN+n3ZJ2b5n2Qs2iTfVHyAw5FackPXQLFjgt21nCvevudpT0fFGadrwJRULniogNgwe
 F1Wx+gz8ZlfxeyOy2DTYg3LyfQespB+uZstqFkAy3aEiwOj0f3p8Aq+T7l/adhsMEB4ecEeqCwM
 VqT2rbwhi05wF0Ub1UFSybFD92hl29rqoVQ/6Pi8E3EWu/98ZoTVu/xikcAZ7u5o=
X-Google-Smtp-Source: AGHT+IHDnfI9gEGXqI/RhqRvQrDpgbt7IegLqn/IGAaUlx2SRfRNCKuf95p7kEAJl5t3P0/V+j77vw==
X-Received: by 2002:a05:6a00:18a0:b0:748:f74f:6d27 with SMTP id
 d2e1a72fcca58-74ee3239763mr23496789b3a.24.1752522071458; 
 Mon, 14 Jul 2025 12:41:11 -0700 (PDT)
Received: from [10.113.99.227] ([172.56.179.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e068b1sm11341991b3a.58.2025.07.14.12.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 12:41:10 -0700 (PDT)
Message-ID: <a38e4185-71e6-4edf-99c6-c4c1f85066d0@linaro.org>
Date: Mon, 14 Jul 2025 13:41:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Added support for SME register exposure to
 GDB
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250714174330.913636-1-vacha.bhavsar@oss.qualcomm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250714174330.913636-1-vacha.bhavsar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 7/14/25 11:43, Vacha Bhavsar wrote:
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 64ee9b3b56..c39d636caa 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -228,6 +228,87 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
>       return 0;
>   }
>   
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    bool streaming_mode = ((env->svcr & 0x01) != 0);

env->svcr & R_SVCR_SM_MASK, although perhaps

> +
> +    switch (reg) {
> +    /* Svg register */
> +    case 0:
> +    {
> +        int vq;
> +        if (streaming_mode) {
> +            vq = sve_vqm1_for_el_sm(env, arm_current_el(env),
> +                     streaming_mode) + 1;
> +        } else {
> +            vq = 0;
> +        }
> +        /* svg = vector granules (2 * vector quardwords) in streaming mode */
> +        return gdb_get_reg64(buf, vq * 2);

     int vq = 0;
     if (FIELD_EX64(env->svcr, SVCR, SM)) {
         vq = ...
     }

is clearer.


> +    }
> +    case 1:
> +        return gdb_get_reg64(buf, env->svcr);
> +    case 2:
> +    {
> +        int q;
> +        int len = 0;
> +        int vq = cpu->sve_max_vq;

sme_max_vq.

> +        int svl = vq * 16;
> +        for (int i = 0; i < svl; i++) {
> +            for (q = 0; q < vq; q++) {

for (int q = 0

> +                len += gdb_get_reg128(buf,
> +                           env->za_state.za[i].d[q * 2 + 1],
> +                           env->za_state.za[i].d[q * 2]);
> +            }
> +        }
> +        return len;
> +    }
> +    default:
> +        /* gdbstub asked for something out of range */
> +        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func__, reg);
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    switch (reg) {
> +    case 0:
> +    {
> +        /* cannot set svg via gdbstub */
> +        return 0;
> +    }

I think you return 8 anyway to ignore.

> +    case 1:
> +        aarch64_set_svcr(env, *(uint64_t *)buf,

ldq_le_p(buf)

> +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> +        return 8;
> +    case 2:
> +        int vq, len = 0;
> +        int svl = cpu->sve_max_vq * 16;

sme_max_vq.

> +        uint64_t *p = (uint64_t *) buf;
> +        for (int i = 0; i < svl; i++) {
> +            for (vq = 0; vq < cpu->sve_max_vq; vq++) {

Mirror the q/vq loop from above.

> +                env->za_state.za[i].d[vq * 2 + 1] = *p++;
> +                env->za_state.za[i].d[vq * 2] = *p++;
> +                len += 16;
> +            }
> +        }
> +        return len;
> +    default:
> +        /* gdbstub asked for something out of range */
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
>   int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
> @@ -392,6 +473,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
>       return &cpu->dyn_svereg_feature.desc;
>   }
>   
> +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    int vq = cpu->sve_max_vq;

sme_max_vq.


r~

