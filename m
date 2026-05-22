Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7126CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQS8e-0005tQ-Bq; Fri, 22 May 2026 11:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQS8b-0005tE-Of
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:50:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQS8Z-0005FA-J2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:50:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ba6485d219so57033765ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779465009; x=1780069809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=91OCM+ZTDX7BNbNmeSammyyQCTfpA9qaA9U+yG3lpEI=;
 b=CasZd0H/OkEkEJ3TCP85MPZ3kc6EMYNaRUe9ufxyafOauPkMtsYVIWZQKEAHNEo78u
 fbSM67p1Ap2Vz3WpK3I15ho3okAtJ+JYuii3PugCLSthMBnPnP54t994RyB7oRC1ErMf
 pRVWz3AuBib7XKo6arKjOagq4iC4S8Fn5/dwtzQ91GpSEv9D+Tk8aaiP+7/Uice7B8zH
 MQ069ZYfH25b1EmBqeS4fIJFt7BkC5uxYMHENUttubuJQKHBqZttEUGvi8R9MwgnLkXY
 Ai6/d6eW3FYG54ixhLhk2Vvqq9YIHxkzT5ExhNY8koKbbXyd7Yc9HV69MLkPdp2IOjJO
 PlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779465009; x=1780069809;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=91OCM+ZTDX7BNbNmeSammyyQCTfpA9qaA9U+yG3lpEI=;
 b=ncusEtPMFCSqKOnM/l78LRBZziZosx8DvK/8F6h6FmnZweFx7ISWj0HxNBi/UKUoWj
 jxtqpOojwsxMSQdIEsi/FzCI8owGY7NSeZocbcjPGvqTiCPul108stdskideKHwOch/T
 EJ+s6BFRA/VJlhCS/D6FllSOmQDEFDs0+HpPVwNfUcnM318DAvdgz++SmgVzdYdIXxwL
 pqcLc4KhunkCeu4+MwlwxiffwfCAdkMhL7Qc4YEyaa4hypi1H7YPMqsdYMkxuZBFUJzZ
 F5bK+QhA+YWnKhlOd/H4YWN8N1MjWO6c6+IWDRZIFpGqxJtbdlHic0SUma0vOEUcb+oB
 GuEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vDwl5Ebv5XXHiddWgfxboPHwDDsjkjEQPMCMhQ7EyfNAgA/nV5zfGYDRIgtld5iKBBy5pNcDe5vqQ@nongnu.org
X-Gm-Message-State: AOJu0YyVz64SH9KD6HAQ80u+mLyk3Iv1TUnrAK0TMLuPLK/UpgEUlWgX
 XAExMyM15BT+zIc74+n6jbCMZ24RDqRXLk5p3EukuZFZFzW4a8U9PciwxM+4wEyLtCU=
X-Gm-Gg: Acq92OFOGXdBCF8AV0RGEqBaAGgaWhAI+wSBbtz9UpZDbdJFRf38V8NWBIXtya+NvX2
 X3m6LtprRXKGYg+rzV7NnE0yr3IyJiwFNDsNNgNtKYwX6l0j5xgZD9DPpH++5Mm8kO7TCLAdbQz
 daCLYUGfx8B/7ik50OgwoHlIsF1m2I9oP6Sojs9RaE9WAw3GxhZyGinJAlZO/iuKuZo9lZ644kO
 oefumf2ztUxnNRZ3QmPg6lIpfQOiiUoftRH1Jnw9bxzdlux2E+/xbcmJYMEhRvT5JY62aZ9UbRb
 tR4hpunAKz2WxoDUONhdIbXDdur1xNL1zf6wyxpm0Udfui2vZhEaZJoPyniwTAvD0X3XvZtyk7R
 Zd0TzsLeUEbHnKoorizbYes2zwavR38iA5UO1c+LNmkuCi+k69T5/K90X8WsODT/caU1Zk5zQVS
 xwTnAJNuTms6DkNQnTMkFmGkawwWERAAa7TR1Hqpx7TEZTo4Jioqo=
X-Received: by 2002:a17:903:b85:b0:2ba:bfc:7699 with SMTP id
 d9443c01a7336-2beb05908eamr49752065ad.17.1779465009262; 
 Fri, 22 May 2026 08:50:09 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb591f63dsm29116275ad.83.2026.05.22.08.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:50:08 -0700 (PDT)
Message-ID: <466d799f-86d9-4c52-8789-fdeb3b673b90@linaro.org>
Date: Fri, 22 May 2026 08:50:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/22] target/mips: add Octeon GFM COP2 helpers
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-5-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-5-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/21/26 22:19, James Hilliard wrote:
> Add helper support for the Octeon GFM carryless multiply selectors. This
> models the normal and reflected multiplication paths, including the
> XOR-and-multiply forms that update the result/input state used by Octeon
> crypto code.
> 
> Reflected selectors operate on the architectural GFM register bank using
> bit-reflected register transfers rather than a separate shadow state.
> Keep the 64-bit UIA2 reduction path used by SNOW3G F9.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> 
> ---
> Changes v10 -> v13:
>    - Map reflected GFM selectors directly onto the architectural GFM state
>      in this patch instead of adding temporary reflected shadow state.
>    - Preserve the 64-bit UIA2 GFM reduction path used by SNOW3G F9.
> 
> Changes v8 -> v9:
>    - Split GFM selector operations into their own COP2 helper patch.
>    - Expose per-operation helpers instead of a generic selector helper.
>    - Add matching helper.h declarations with the helper implementation.
> ---
>   target/mips/helper.h            |  10 +++
>   target/mips/tcg/octeon_crypto.c | 139 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 149 insertions(+)
> 
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index e802f50fd6..9a6702ff60 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -27,6 +27,10 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
>   
>   /* Octeon COP2 selector operation helpers. */
>   DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
> +DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect0, i64, env)
> +DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
> +DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
> +DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
>   DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
> @@ -38,6 +42,12 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect0, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_gfm_xor0, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
>   
>   /* microMIPS functions */
>   DEF_HELPER_4(lwm, void, env, tl, tl, i32)
> diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
> index 811f36f46a..b22474574c 100644
> --- a/target/mips/tcg/octeon_crypto.c
> +++ b/target/mips/tcg/octeon_crypto.c
> @@ -11,6 +11,7 @@
>   #include "internal.h"
>   #include "exec/helper-proto.h"
>   #include "crypto/aes.h"
> +#include "crypto/clmul.h"
>   #include "crypto/sm4.h"
>   #include "qemu/bitops.h"
>   #include "qemu/host-utils.h"
> @@ -75,11 +76,149 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
>       octeon_crc_set_state_reflect(crypto, crc);
>   }
>   
> +static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
> +                           uint16_t poly, uint64_t out[2])
> +{
> +    uint64_t zh = 0, zl = 0;
> +    uint64_t vh = y[0], vl = y[1];
> +    uint64_t rh = (uint64_t)poly << 48;

Docs say

     T<15:0> = halfword_bit_reflect(GFMPOLY<15:0>);
     POLY[0]<63:0> = 0 || T<7:0>
     POLY[1]<63:0> = 0 || T<15:8>

I can see how you're getting aroung the reflect, but not keeping the two 8-bit halves of 
poly within the same word.  I would expect this to be

     rl = (poly & 0xff00) << 48;
     rh = poly << 56;

> +static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
> +{
> +    uint64_t lo = int128_getlo(product);
> +    uint64_t hi = int128_gethi(product);
> +
> +    while (hi) {
> +        int bit = 63 - clz64(hi);
> +
> +        hi ^= 1ULL << bit;
> +        lo ^= (uint64_t)poly << bit;
> +        if (bit > 56) {
> +            hi ^= (uint64_t)poly >> (64 - bit);
> +        }
> +    }
> +
> +    return lo;
> +}
> +
> +static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
> +                                  uint8_t poly, uint64_t out[2])
> +{
> +    /*
> +     * SNOW3G UIA2 uses the GFM datapath as a reflected 64-bit multiply in
> +     * the low half of the 128-bit register pair.
> +     */
> +    uint64_t vx = revbit64(x[1]);
> +    uint64_t vy = revbit64(y[0]);
> +    Int128 product = clmul_64(vx, vy);
> +    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
> +
> +    out[0] = 0;
> +    out[1] = revbit64(res);
> +}

I still don't see how this matches up to a simplification of octeon_gfm_mul for some zero 
inputs.  Comments to that effect would be lovely.

> +void helper_octeon_cp2_mt_gfm_xor0(CPUMIPSState *env, uint64_t value)
> +{
> +    env->octeon_crypto.gfm_resinp[0] ^= value;
> +}

Consider doing this inline.

> +void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
> +                                              uint64_t value)
> +{
> +    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
> +
> +    crypto->gfm_resinp[1] ^= revbit64(value);
> +    octeon_gfm_mul(crypto->gfm_resinp, crypto->gfm_mul, crypto->gfm_poly,
> +                   crypto->gfm_resinp);
> +}
> +
> +void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
> +{
> +    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
> +
> +    crypto->gfm_resinp[1] ^= value;
> +    if (crypto->gfm_poly <= 0xff && crypto->gfm_mul[1] == 0 &&
> +        crypto->gfm_resinp[0] == 0) {
> +        octeon_gfm_mul64_uia2(crypto->gfm_resinp, crypto->gfm_mul,
> +                              crypto->gfm_poly, crypto->gfm_resinp);

Why does xormul1 get a 64-bit path while xormul1_reflect does not?
The only difference between the two is the initial revbit64...


r~

