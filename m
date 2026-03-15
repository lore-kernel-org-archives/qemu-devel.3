Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAE4F3026E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 17:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1p2n-0008UG-L8; Sun, 15 Mar 2026 13:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1p2m-0008Tu-BZ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:14:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1p2i-0007jh-QR
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:14:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b44c0bcdbso51298f8f.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773594859; x=1774199659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X9l8ptDXXRaC2pJzuAa9rhP/bA0KLx+pXcT+7LqyR/Y=;
 b=DxyKHCNvawc2BVbgmJKR+70N+3SOzz7Nfnf9FtgmRddlQh7/aTqBefbUbIA9mLPZL7
 XR2HXrUrsbIQ2gm45IfBsCtFeVX8bu1sT4jv5crAaamN936L/2U4lA4iPNKD3GjHJWUo
 QWSHpLJcakKODde41Oyj6uKFohnhZ9M4/JQ3zOFmWDnRKqthauPAAzdTtwxJe13gXsIn
 Kcl71bIb1qznCkcqadoH2x2K8+pHdjU3PFd+VfJQUMJUxmpQj+euxvBJVJl/ypuKdByq
 RPKCQJVF/It9fdZsrgrgbBOr8BeXV18t0wRQcunCC8i6z2lxlcexBFMchhcRUHivkqqE
 HTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773594859; x=1774199659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9l8ptDXXRaC2pJzuAa9rhP/bA0KLx+pXcT+7LqyR/Y=;
 b=DtmgAEvbskTeCY5EIfdjuJiOdWGNNvofejenmMyYLVDiX6X7hrRWzGC/ts96o+ylDf
 dDTka31DRz9FUg/t2/YV/GWcbTpC2GTgYRcRASxcmkMtShYGsfgbP0u8+ihlJgUvHID7
 XHCHvUIAEUuo6C11RHavH4rkbxre2uQstuCngeO2tD0B9XrB5CM9Rx8OtKPsAaJkV/08
 OvTeIdKZ8Kz50OIhyfJsV7x4soMgnOZbPvjOviFbh7lnOff4jUfm6A26V1I+lLsWM33m
 nGPXMLwyl0MJjME6rIyjGYvSQLtpV75T4dMB0H8wY3QOZTXe3l2xbRqgbZo1WlMKZ7w2
 G5xA==
X-Gm-Message-State: AOJu0YyNPydfdYurx3Zi8g9T/IGezLTbTle2UMrGTKMhZ6bELo3gufbq
 lum8OhJn2cbsk+J5cCoEEeksbZQbIOsnva16zsHbmJU5Hh6VQ/QKLVR61yss/vZ8u3xW8BeeX3A
 6w2hvK9M=
X-Gm-Gg: ATEYQzyNfOxEHpOJ6EPvST9ttgmSuiSu++ZEbffxc1ElNcIeq5a98ZXxnC7hubN/Bhx
 Z+IHpFmE+pWOIBgDdGha13IBaiI2Ebu/gmjBcJ7f8Cls7pqIR4sEeY4XJS6Fb3YNpYbfxaiXurj
 EkHzYUSVRfKTCFcV3Q4jn4WYAiJnp9SH2txMKv+CcGnX3bZzS4axfjxdQqwKB5pC91g88IrmvdC
 3DR59DPtdoRTAaUw918EC2/Qm844DjqjrrXWWPMie5drva/DZuhaGrwbhEan6C465tkk8VcS/aY
 8oUX+VRCV/tLKUCULmutf3IkZqjXZUxsxVXuI1fpueyYFIVWlkvwb3fojAD+kAvJkzpv9yZc3Pz
 /a2VmUCVvCeBNc3OtnaviPF7TA9WE+f2yz4tkKL4a2A4T6ejjc0zlL1VVN+FROUl57VgI7y0oBv
 PVMlh5GzoRSZ5eyXDnNL78O5r9aCXOdwKbCp2WuYIdYkZgjQcN5cX4A8P+e8fPEp9GEg==
X-Received: by 2002:a05:6000:a85:b0:43b:3cd9:aa61 with SMTP id
 ffacd0b85a97d-43b3cd9aca9mr4594859f8f.25.1773594858791; 
 Sun, 15 Mar 2026 10:14:18 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b3d87b1fbsm10034725f8f.7.2026.03.15.10.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 10:14:18 -0700 (PDT)
Message-ID: <509bd103-9535-4822-a62d-b959bf3f8044@linaro.org>
Date: Sun, 15 Mar 2026 18:14:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/riscv: Restrict access to RV128 registers on
 RV32
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260315165949.40027-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260315165949.40027-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 15/3/26 17:59, Philippe Mathieu-Daudé wrote:
> One half of 128-bit registers code is not reachable for CPUs
> running in 32-bit mode, while the other half is completely
> broken (handled as a pair of 32-bit registers).
> Better restrict this code on 32-bit builds until RV128 is
> properly implemented.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> More than 1y having issue with the 128-bit code path and
> the single binary effort. Fortunately while I dunno how to
> test 128-bit I could with 32/64 bits.
> ---
>   target/riscv/cpu.h                          |  2 ++
>   target/riscv/machine.c                      |  4 +++
>   target/riscv/monitor.c                      |  4 +++
>   target/riscv/translate.c                    | 31 +++++++++++++++++++--
>   target/riscv/insn_trans/trans_rvzacas.c.inc |  2 ++
>   5 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 633d5301f30..94f4daa06e7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -214,7 +214,9 @@ typedef struct PMUFixedCtrState {
>   
>   struct CPUArchState {
>       target_ulong gpr[32];
> +#if defined(TARGET_RISCV64)
>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> +#endif
>   
>       /* vector coprocessor state. */
>       uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a8791..e220e562ff4 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -168,6 +168,7 @@ static const VMStateDescription vmstate_pointermasking = {
>       }
>   };
>   
> +#ifdef TARGET_RISCV64
>   static bool rv128_needed(void *opaque)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
> @@ -187,6 +188,7 @@ static const VMStateDescription vmstate_rv128 = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> +#endif
>   
>   #ifdef CONFIG_KVM
>   static bool kvmtimer_needed(void *opaque)
> @@ -487,7 +489,9 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_hyper,
>           &vmstate_vector,
>           &vmstate_pointermasking,
> +#ifdef TARGET_RISCV64
>           &vmstate_rv128,
> +#endif
>   #ifdef CONFIG_KVM
>           &vmstate_kvmtimer,
>   #endif
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index a9d31114442..b99a4e6ec18 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -251,8 +251,12 @@ static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>       target_ulong *vals;
>   
>       if (is_gprh) {
> +#ifdef TARGET_RISCV64
>           reg_names = riscv_int_regnamesh;
>           vals = env->gprh;
> +#else
> +        g_assert_not_reached();
> +#endif
>       } else {
>           reg_names = riscv_int_regnames;
>           vals = env->gpr;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 6d0f316ef1e..5b4a9934e83 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -38,7 +38,10 @@
>   #include "tcg/tcg-cpu.h"
>   
>   /* global register indices */
> -static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
> +static TCGv cpu_gpr[32], cpu_pc, cpu_vl, cpu_vstart;
> +#ifdef TARGET_RISCV64
> +static TCGv cpu_gprh[32];
> +#endif
>   static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
>   static TCGv load_res;
>   static TCGv load_val;
> @@ -374,11 +377,15 @@ static TCGv get_gpr(DisasContext *ctx, int reg_num, DisasExtend ext)
>   
>   static TCGv get_gprh(DisasContext *ctx, int reg_num)
>   {
> +#ifdef TARGET_RISCV64
>       assert(get_xl(ctx) == MXL_RV128);
>       if (reg_num == 0) {
>           return ctx->zero;
>       }
>       return cpu_gprh[reg_num];
> +#else
> +    g_assert_not_reached();
> +#endif
>   }
>   
>   static TCGv dest_gpr(DisasContext *ctx, int reg_num)
> @@ -391,10 +398,14 @@ static TCGv dest_gpr(DisasContext *ctx, int reg_num)
>   
>   static TCGv dest_gprh(DisasContext *ctx, int reg_num)
>   {
> +#ifdef TARGET_RISCV64
>       if (reg_num == 0) {
>           return tcg_temp_new();
>       }
>       return cpu_gprh[reg_num];
> +#else
> +    g_assert_not_reached();
> +#endif
>   }
>   
>   static void gen_set_gpr(DisasContext *ctx, int reg_num, TCGv t)
> @@ -404,17 +415,21 @@ static void gen_set_gpr(DisasContext *ctx, int reg_num, TCGv t)
>           case MXL_RV32:
>               tcg_gen_ext32s_tl(cpu_gpr[reg_num], t);
>               break;
> +#ifdef TARGET_RISCV64
>           case MXL_RV64:
>           case MXL_RV128:
>               tcg_gen_mov_tl(cpu_gpr[reg_num], t);
>               break;
> +#endif
>           default:
>               g_assert_not_reached();
>           }
>   
> +#ifdef TARGET_RISCV64
>           if (get_xl_max(ctx) == MXL_RV128) {
>               tcg_gen_sari_tl(cpu_gprh[reg_num], cpu_gpr[reg_num], 63);
>           }
> +#endif
>       }
>   }
>   
> @@ -425,27 +440,35 @@ static void gen_set_gpri(DisasContext *ctx, int reg_num, target_long imm)
>           case MXL_RV32:
>               tcg_gen_movi_tl(cpu_gpr[reg_num], (int32_t)imm);
>               break;
> +#ifdef TARGET_RISCV64
>           case MXL_RV64:
>           case MXL_RV128:
>               tcg_gen_movi_tl(cpu_gpr[reg_num], imm);
>               break;
> +#endif
>           default:
>               g_assert_not_reached();
>           }
>   
> +#ifdef TARGET_RISCV64
>           if (get_xl_max(ctx) == MXL_RV128) {
>               tcg_gen_movi_tl(cpu_gprh[reg_num], -(imm < 0));
>           }
> +#endif
>       }
>   }
>   
>   static void gen_set_gpr128(DisasContext *ctx, int reg_num, TCGv rl, TCGv rh)
>   {
> +#ifdef TARGET_RISCV64
>       assert(get_ol(ctx) == MXL_RV128);
>       if (reg_num != 0) {
>           tcg_gen_mov_tl(cpu_gpr[reg_num], rl);
>           tcg_gen_mov_tl(cpu_gprh[reg_num], rh);
>       }
> +#else
> +    g_assert_not_reached();
> +#endif
>   }
>   
>   static TCGv_i64 get_fpr_hs(DisasContext *ctx, int reg_num)
> @@ -1453,14 +1476,18 @@ void riscv_translate_init(void)
>        * unless you specifically block reads/writes to reg 0.
>        */
>       cpu_gpr[0] = NULL;
> -    cpu_gprh[0] = NULL;
>   
>       for (i = 1; i < 32; i++) {
>           cpu_gpr[i] = tcg_global_mem_new(tcg_env,
>               offsetof(CPURISCVState, gpr[i]), riscv_int_regnames[i]);
> +    }
> +#ifdef TARGET_RISCV64
> +    cpu_gprh[0] = NULL;
> +    for (i = 1; i < 32; i++) {
>           cpu_gprh[i] = tcg_global_mem_new(tcg_env,
>               offsetof(CPURISCVState, gprh[i]), riscv_int_regnamesh[i]);
>       }
> +#endif
>   
>       for (i = 0; i < 32; i++) {
>           cpu_fpr[i] = tcg_global_mem_new_i64(tcg_env,
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
> index 8d94b83ce94..8cf7cbd4599 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -55,10 +55,12 @@ static void gen_set_gpr_pair(DisasContext *ctx, int reg_num, TCGv_i64 t)
>           tcg_gen_sari_i64(cpu_gpr[reg_num + 1], t, 32);
>   #endif
>   
> +#ifdef TARGET_RISCV64
>           if (get_xl_max(ctx) == MXL_RV128) {
>               tcg_gen_sari_tl(cpu_gprh[reg_num], cpu_gpr[reg_num], 63);
>               tcg_gen_sari_tl(cpu_gprh[reg_num + 1], cpu_gpr[reg_num + 1], 63);
>           }
> +#endif
>       }
>   }

Doesn't matter much, but I forgot to commit this hunk:

-- >8 --
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc 
b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 8cf7cbd4599..dc67a027f86 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -92,9 +92,11 @@ static bool trans_amocas_d(DisasContext *ctx, 
arg_amocas_d *a)
      switch (get_ol(ctx)) {
      case MXL_RV32:
          return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_UQ);
+#ifdef TARGET_RISCV64
      case MXL_RV64:
      case MXL_RV128:
          return gen_cmpxchg(ctx, a, MO_ALIGN | MO_UQ);
+#endif
      default:
          g_assert_not_reached();
      }
---


