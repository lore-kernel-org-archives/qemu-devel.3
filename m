Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D996F30280
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 18:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1qdH-0001FW-IH; Sun, 15 Mar 2026 14:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1w1qdF-0001FI-Pg; Sun, 15 Mar 2026 14:56:10 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1w1qdD-0001TV-5i; Sun, 15 Mar 2026 14:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1773600962;
 bh=o40dCX0CGQpKDWzfJhlJU21wbdrPQlfmHhVESnLhdG8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QdGtSX+4N5HY5q+5tu4cp/NTfwpj8xPNia5y1OqcMey/Ygdm9O5lBwGn4k9HQPkgM
 /aen1XBEt+azPkNdVAGwjIZFWlclaMc95ccGTf2oEbRFoBFAQNtwk+Tyqfd/8fcsUv
 AXnc/g9iahYVKw4KJf/GfuNXEkemFYnxa+iuv8Xeq8Tw0DgLhSMoWHwkxughL+IQGP
 VNeGD3TPGz10j5z9nd4w4uDsS8oUPyPRrpN+tYiVPHlhBdFggQ+fbKeNK0wyqb1I0S
 u8fk7E8rbsCVfHdlTvnXrwcCj4fgnIF+rhCnB92SU3PVbK7DLBaR+6jc+ssJIiE11t
 dGinDOaJW0bjA==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 32B3640232;
 Sun, 15 Mar 2026 19:56:02 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 2E01EFF859;
 Sun, 15 Mar 2026 19:56:02 +0100 (CET)
Received: from [192.168.1.62] (35.201.90.79.rev.sfr.net [79.90.201.35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 4C778400D4;
 Sun, 15 Mar 2026 19:56:01 +0100 (CET)
Message-ID: <35544128-3c7f-48b2-a67f-9253cf8f5df0@univ-grenoble-alpes.fr>
Date: Sun, 15 Mar 2026 19:55:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/riscv: Restrict access to RV128 registers on
 RV32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260315165949.40027-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <20260315165949.40027-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Phil,

   my understanding is that rv128 makes no sense with rv32, and
   the user is not expected to run qemu-system-riscv32 with
   the -cpu=x-rv128 (it triggers an "unable to find CPU model
   'x-rv128'" error).
   The rv128 code just relies on XLEN being 128, and assumes
   (implicitely I admit) running on a 64-bit host machine, so
   with tl = 64.
   The code is absolutely erroneous when tl = 32, agreed.
   The thing is that, as we want to get rid of the
   TARGET_RISCV64/TARGET_RISCV32 defines, the rv128 specific
   code still must compile whatever tl, so that qemu can be built.
   However, it should never be executed if tl = 32.
   Typically, the patches I sent earlier this year to deal
   with lq/sq endianness fit into that 'compile only' category
   for rv32.

   Thanks,
   Frédéric

On 3/15/26 17:59, Philippe Mathieu-Daudé wrote:
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
>   

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot,                        Pr. Grenoble INP-UGA@Ensimag/TIMA |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


