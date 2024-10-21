Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18FD15DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tw4-0001XU-K1; Mon, 21 Oct 2024 11:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2tw2-0001QR-89
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:03:06 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2tw0-0002q0-GK
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:03:06 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea6a4f287bso2908479a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729522982; x=1730127782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O62fE/KqQcuMt3nFF1X4KaHAUnanEmrHkxHwvr7oQo0=;
 b=Jc8U/ijKRAKaT1/t8glRbA4SE+HOPh04QBHTZCXfmhIuHvb5JWqvPxwKA2b9fEeNsE
 gIOQ+GBLaWAvTsLTaUU5xJaBr05+iJgGw51hgkoOOLuhcpk0MQoeIAEhdZR4V8y6qyR6
 hmDV6UZxTauaHbGFUc2l9V7xnWk8nmEcG4CJOcW4nEod60zD6/v8tWEfqpUeagJ1QNk2
 I2r38NXbMIaGXStveGACfdfo+bbpYc/JkZzk8n9ZEUfrw6q4UVwBoSof991EyQUOGKSV
 znDBnctIbfgXlsB94xKIfs35DcK6q7shoPBSD4b0Immvv1CV3Bs3tyknQoyZ0eEW+EuJ
 Pq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729522982; x=1730127782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O62fE/KqQcuMt3nFF1X4KaHAUnanEmrHkxHwvr7oQo0=;
 b=k9oI8IRnokqF7R3HyHWIDblMG/hujulMvGHYTTPPEs9P0lcz1gfM+rqnbF/W25mqpr
 o8Djpn75ObFuRPTAvnrkj3WbXEqE2ODWxxfeaJs+gSaIhSK592/Ltx7JsTRH351Lssz9
 LU/SfH3kzZHi/7eAdCyLjtXMrGIYxbmJwXDTKzvyCPf2i2ky9iCIx5FIZaZNcvJVs0Ri
 xHwQxV7WOGKOp8HLXeJELn5qMsG9loy2lFaJ65xvz0swsCBtQHahgdWli0XYUPxaZOl6
 IJlYqDV5AI9PsHoz5nMG4kE6ecayqx75sP13r7E7n0QbGJ1aiuWumpEaGrbXhDQhbYl9
 HSGQ==
X-Gm-Message-State: AOJu0YwvwDODXJ9KDeBsXQq6F3mZlbe68fEIJrqmuBuABWYs4g6QUOFl
 O1T7GnvKnzvyHY2AXxUHzpHVxyYTPx/886zp6YU1McAQiLYKaiTQBiruYJL18DXTxKyYDLuZr2a
 d
X-Google-Smtp-Source: AGHT+IH5OiKhnNgnuqhxPAoLg1fJ+rMDtQ3u8WFJy+uyrzwwGy9Zp9Ks5zNIAEkj5IZHBE9aUIny2g==
X-Received: by 2002:a05:6a20:e617:b0:1d9:27e1:3f43 with SMTP id
 adf61e73a8af0-1d92c4de235mr15784094637.17.1729522982344; 
 Mon, 21 Oct 2024 08:03:02 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeaafd36esm3242276a12.6.2024.10.21.08.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 08:03:01 -0700 (PDT)
Message-ID: <7eb739af-c39e-4d5d-a439-99abceca7f00@linaro.org>
Date: Mon, 21 Oct 2024 12:02:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Introduce ase_3d_available() helper
To: qemu-devel@nongnu.org
Cc: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241021145832.34920-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241021145832.34920-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x535.google.com
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

On 21/10/24 11:58, Philippe Mathieu-Daudé wrote:
> Determine if the MIPS-3D ASE is implemented by checking
> the state of the 3D bit in the FIR CP1 control register.
> Remove the then unused ASE_MIPS3D definition.

I forgot to mention:

  "Note, this allows using MIPS-3D on the 20Kc model."

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.h                         | 6 ++++++
>   target/mips/mips-defs.h                   | 1 -
>   target/mips/tcg/translate.c               | 8 ++++++--
>   target/mips/cpu-defs.c.inc                | 4 ++--
>   target/mips/tcg/micromips_translate.c.inc | 5 ++++-
>   5 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index a4a46ebbe98..6a4c4ea683a 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1319,6 +1319,12 @@ bool cpu_type_supports_cps_smp(const char *cpu_type);
>   bool cpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask);
>   bool cpu_type_supports_isa(const char *cpu_type, uint64_t isa);
>   
> +/* Check presence of MIPS-3D ASE */
> +static inline bool ase_3d_available(CPUMIPSState *env)
> +{
> +    return env->active_fpu.fcr0 & (1 << FCR0_3D);
> +}
> +
>   /* Check presence of MSA implementation */
>   static inline bool ase_msa_available(CPUMIPSState *env)
>   {
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index a6cebe0265c..6b5cd0d8f53 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -26,7 +26,6 @@
>    *   bits 24-39: MIPS ASEs
>    */
>   #define ASE_MIPS16        0x0000000001000000ULL
> -#define ASE_MIPS3D        0x0000000002000000ULL
>   #define ASE_MDMX          0x0000000004000000ULL
>   #define ASE_DSP           0x0000000008000000ULL
>   #define ASE_DSP_R2        0x0000000010000000ULL
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index d92fc418edd..9e0c319bb23 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -14952,7 +14952,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
>               } else {
>                   /* OPC_BC1ANY2 */
>                   check_cop1x(ctx);
> -                check_insn(ctx, ASE_MIPS3D);
> +                if (!ase_3d_available(env)) {
> +                    return false;
> +                }
>                   gen_compute_branch1(ctx, MASK_BC1(ctx->opcode),
>                                       (rt >> 2) & 0x7, imm << 2);
>               }
> @@ -14967,7 +14969,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
>               check_cp1_enabled(ctx);
>               check_insn_opc_removed(ctx, ISA_MIPS_R6);
>               check_cop1x(ctx);
> -            check_insn(ctx, ASE_MIPS3D);
> +            if (!ase_3d_available(env)) {
> +                return false;
> +            }
>               /* fall through */
>           case OPC_BC1:
>               check_cp1_enabled(ctx);
> diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> index 19e2abac829..2728f4dba67 100644
> --- a/target/mips/cpu-defs.c.inc
> +++ b/target/mips/cpu-defs.c.inc
> @@ -663,7 +663,7 @@ const mips_def_t mips_defs[] =
>           .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
>           .SEGBITS = 40,
>           .PABITS = 36,
> -        .insn_flags = CPU_MIPS64R1 | ASE_MIPS3D,
> +        .insn_flags = CPU_MIPS64R1,
>           .mmu_type = MMU_TYPE_R4000,
>       },
>       {
> @@ -692,7 +692,7 @@ const mips_def_t mips_defs[] =
>           .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
>           .SEGBITS = 42,
>           .PABITS = 36,
> -        .insn_flags = CPU_MIPS64R2 | ASE_MIPS3D,
> +        .insn_flags = CPU_MIPS64R2,
>           .mmu_type = MMU_TYPE_R4000,
>       },
>       {
> diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
> index 3cbf53bf2b3..c479bec1081 100644
> --- a/target/mips/tcg/micromips_translate.c.inc
> +++ b/target/mips/tcg/micromips_translate.c.inc
> @@ -2484,7 +2484,10 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
>               mips32_op = OPC_BC1TANY4;
>           do_cp1mips3d:
>               check_cop1x(ctx);
> -            check_insn(ctx, ASE_MIPS3D);
> +            if (!ase_3d_available(env)) {
> +                gen_reserved_instruction(ctx);
> +                break;
> +            }
>               /* Fall through */
>           do_cp1branch:
>               if (env->CP0_Config1 & (1 << CP0C1_FP)) {


