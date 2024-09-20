Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA954C78820
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 11:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srbn5-0004jE-PR; Fri, 20 Sep 2024 07:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1srbmz-0004e0-Fs
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 07:27:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1srbmw-00048p-EF
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 07:27:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718d606726cso1331766b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726831619; x=1727436419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdeW3p24owznaYlqCLJU8dQ2EYtHaCE6uN6OzIGGVp0=;
 b=G5rTPPTZ3B1M+6YmnldP78RO0ObMzA7JrEgE6jbR9BBjFniNaHibPsCudB6f1k9+p3
 kG1ivnnUytqr68SSQp2XpgOZkowBcGPkPgycta3ulpq3scmhGz/wgh40t90/lQdZG6CL
 Uqh2vtJBnPgtC9i4Y8Q5dZZGA76DfvrZLfzwpfm2p6vBHWGgbT9ofVBGClwQl4lMjq7W
 V/YbDDSXq+JPSjI9oXv0Mz3zAgUg+6bsbD/Brly+ETwKmTbxNbE7PSBcGrjKUM8IXFfO
 Digotj2XZAXHaqzY847qDXouvMPBVFasot6SIqRby6K4IJiP2ldtM0Lu19iu3leoBLKD
 tUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726831619; x=1727436419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdeW3p24owznaYlqCLJU8dQ2EYtHaCE6uN6OzIGGVp0=;
 b=cSttJENCAQoBPzzVivFTZbLlAoYsmcYEqR1NiniJ51fCtK3ZkmY14ymtxgjmmJ0zXq
 6EllrSyA7up8eRMHfWDs0VyapG02DHYq0CS/ZpG1tpOEz6zFa9eepRrMYBdQmxfhMiwa
 IO3Mbzc+XMQTGBOp3sG6nj3+3EzwUpgi4GcU4JuWSK7SjOJow8OQKYXh0pAwTCbz8qvr
 AlsZtZ4/njviheFyzVJPghsyLw7aIpJPl5MdDsN1nrlSk7YfqP2Cg7Q5vWpO3GrRN90o
 ODZAcX2akhQoDOz/JwmhjRkjTS02hMi+JDNjnlxLG6yYTEvHn3ETsGQ1JaHFW4ET567P
 cF6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCULMY4rcV4ExrO0Grd4DJSS/mUspFIG4SLYyJjIp/43US4fZ2VMr9OeJm9pQF0X6xM4ggpwP7Mr9FMW@nongnu.org
X-Gm-Message-State: AOJu0YzbJnCTpQBuNwrULIj1H1+OJGwpqJ3DmQtREFaL+Eng2PmkGozP
 lfVNPYhPqmYz0AEPPgABIowZk6gGOwJuQhSUL96yX9f8IGq4YgVO0+tkWtVF/r4=
X-Google-Smtp-Source: AGHT+IEqOa4eHD+YJbcRQ53I4UxRmDg2TQGcYEcDR/OMXSnqlHRCAN6oSGl+yxvwvfFS/Xkv28odNA==
X-Received: by 2002:a05:6a00:3e02:b0:717:839c:6822 with SMTP id
 d2e1a72fcca58-7199ce8f2b2mr3834319b3a.17.1726831618788; 
 Fri, 20 Sep 2024 04:26:58 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-33.dsl.telesp.net.br.
 [201.68.240.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944b7ee58sm9656894b3a.127.2024.09.20.04.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 04:26:58 -0700 (PDT)
Message-ID: <e1ecceab-084e-4864-a361-e5f06fa4b57d@ventanamicro.com>
Date: Fri, 20 Sep 2024 08:26:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vector
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com, richard.henderson@linaro.org,
 Swung0x48 <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-3-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240911132630.461-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Hi Zhiwei,

On 9/11/24 10:26 AM, LIU Zhiwei wrote:
> From: Swung0x48 <swung0x48@outlook.com>
> 
> The RISC-V vector instruction set utilizes the LMUL field to group
> multiple registers, enabling variable-length vector registers. This
> implementation uses only the first register number of each group while
> reserving the other register numbers within the group.
> 
> In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
> host runtime needs to adjust LMUL based on the type to use different
> register groups.
> 
> This presents challenges for TCG's register allocation. Currently, we
> avoid modifying the register allocation part of TCG and only expose the
> minimum number of vector registers.
> 
> For example, when the host vlen is 64 bits and type is TCG_TYPE_V256, with
> LMUL equal to 4, we use 4 vector registers as one register group. We can
> use a maximum of 8 register groups, but the V0 register number is reserved
> as a mask register, so we can effectively use at most 7 register groups.
> Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers are
> forced to be used. This is because TCG cannot yet dynamically constrain
> registers with type; likewise, when the host vlen is 128 bits and
> TCG_TYPE_V256, we can use at most 15 registers.
> 
> There is not much pressure on vector register allocation in TCG now, so
> using 7 registers is feasible and will not have a major impact on code
> generation.
> 
> This patch:
> 1. Reserves vector register 0 for use as a mask register.
> 2. When using register groups, reserves the additional registers within
>     each group.
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Co-authored-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---


As Rixchard already pointed out, we must have a "Signed-off-by" tag with the "author" of
the patch, and it must be the exact spelling. So in this case:

Signed-off-by: Swung0x48 <swung0x48@outlook.com>


More info here:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

-----

Your patches must include a Signed-off-by: line. This is a hard requirement
because it’s how you say “I’m legally okay to contribute this and happy for it
to go into QEMU”. The process is modelled after the Linux kernel policy.

If you wrote the patch, make sure your "From:" and "Signed-off-by:"
lines use the same spelling. It's okay if you subscribe or contribute to
the list via more than one address, but using multiple addresses in one
commit just confuses things. If someone else wrote the patch, git will
include a "From:" line in the body of the email (different from your
envelope From:) that will give credit to the correct author; but again,
that author's Signed-off-by: line is mandatory, with the same spelling.

-----

However, you can't just amend this tag in the patch though since you're not Swung0x48.
We need Swung0x48 to reply here ack indicating that it is ok to add the Signed-off-by
as required, as a indication that Swung0x48 is ok with the legal implications of
doing so.


Thanks,

Daniel


>   tcg/riscv/tcg-target-con-str.h |   1 +
>   tcg/riscv/tcg-target.c.inc     | 126 ++++++++++++++++++++++++---------
>   tcg/riscv/tcg-target.h         |  78 +++++++++++---------
>   tcg/riscv/tcg-target.opc.h     |  12 ++++
>   4 files changed, 151 insertions(+), 66 deletions(-)
>   create mode 100644 tcg/riscv/tcg-target.opc.h
> 
> diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
> index d5c419dff1..b2b3211bcb 100644
> --- a/tcg/riscv/tcg-target-con-str.h
> +++ b/tcg/riscv/tcg-target-con-str.h
> @@ -9,6 +9,7 @@
>    * REGS(letter, register_mask)
>    */
>   REGS('r', ALL_GENERAL_REGS)
> +REGS('v', ALL_VECTOR_REGS)
>   
>   /*
>    * Define constraint letters for constants:
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index d334857226..966d1ad981 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -32,38 +32,14 @@
>   
>   #ifdef CONFIG_DEBUG_TCG
>   static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
> -    "zero",
> -    "ra",
> -    "sp",
> -    "gp",
> -    "tp",
> -    "t0",
> -    "t1",
> -    "t2",
> -    "s0",
> -    "s1",
> -    "a0",
> -    "a1",
> -    "a2",
> -    "a3",
> -    "a4",
> -    "a5",
> -    "a6",
> -    "a7",
> -    "s2",
> -    "s3",
> -    "s4",
> -    "s5",
> -    "s6",
> -    "s7",
> -    "s8",
> -    "s9",
> -    "s10",
> -    "s11",
> -    "t3",
> -    "t4",
> -    "t5",
> -    "t6"
> +    "zero", "ra",  "sp",  "gp",  "tp",  "t0",  "t1",  "t2",
> +    "s0",   "s1",  "a0",  "a1",  "a2",  "a3",  "a4",  "a5",
> +    "a6",   "a7",  "s2",  "s3",  "s4",  "s5",  "s6",  "s7",
> +    "s8",   "s9",  "s10", "s11", "t3",  "t4",  "t5",  "t6",
> +    "v0",   "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
> +    "v8",   "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
> +    "v16",  "v17", "v18", "v19", "v20", "v21", "v22", "v23",
> +    "v24",  "v25", "v26", "v27", "v28", "v29", "v30", "v31",
>   };
>   #endif
>   
> @@ -100,6 +76,16 @@ static const int tcg_target_reg_alloc_order[] = {
>       TCG_REG_A5,
>       TCG_REG_A6,
>       TCG_REG_A7,
> +
> +    /* Vector registers and TCG_REG_V0 reserved for mask. */
> +    TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,  TCG_REG_V4,
> +    TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,  TCG_REG_V8,
> +    TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11, TCG_REG_V12,
> +    TCG_REG_V13, TCG_REG_V14, TCG_REG_V15, TCG_REG_V16,
> +    TCG_REG_V17, TCG_REG_V18, TCG_REG_V19, TCG_REG_V20,
> +    TCG_REG_V21, TCG_REG_V22, TCG_REG_V23, TCG_REG_V24,
> +    TCG_REG_V25, TCG_REG_V26, TCG_REG_V27, TCG_REG_V28,
> +    TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
>   };
>   
>   static const int tcg_target_call_iarg_regs[] = {
> @@ -127,6 +113,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define TCG_CT_CONST_J12  0x1000
>   
>   #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
> +#define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
> +#define ALL_DVECTOR_REG_GROUPS 0x5555555500000000
> +#define ALL_QVECTOR_REG_GROUPS 0x1111111100000000
>   
>   #define sextreg  sextract64
>   
> @@ -766,6 +755,23 @@ static void tcg_out_addsub2(TCGContext *s,
>       }
>   }
>   
> +static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
> +                                   TCGReg dst, TCGReg src)
> +{
> +    return false;
> +}
> +
> +static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
> +                                    TCGReg dst, TCGReg base, intptr_t offset)
> +{
> +    return false;
> +}
> +
> +static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
> +                                    TCGReg dst, int64_t arg)
> +{
> +}
> +
>   static const struct {
>       RISCVInsn op;
>       bool swap;
> @@ -1881,6 +1887,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>       }
>   }
>   
> +static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
> +                           unsigned vecl, unsigned vece,
> +                           const TCGArg args[TCG_MAX_OP_ARGS],
> +                           const int const_args[TCG_MAX_OP_ARGS])
> +{
> +    switch (opc) {
> +    case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
> +    case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
> +                       TCGArg a0, ...)
> +{
> +    switch (opc) {
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
> +{
> +    switch (opc) {
> +    default:
> +        return 0;
> +    }
> +}
> +
>   static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>   {
>       switch (op) {
> @@ -2100,6 +2136,30 @@ static void tcg_target_init(TCGContext *s)
>   {
>       tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
>       tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
> +    s->reserved_regs = 0;
> +
> +    switch (riscv_lg2_vlenb) {
> +    case TCG_TYPE_V64:
> +        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +        tcg_target_available_regs[TCG_TYPE_V128] = ALL_DVECTOR_REG_GROUPS;
> +        tcg_target_available_regs[TCG_TYPE_V256] = ALL_QVECTOR_REG_GROUPS;
> +        s->reserved_regs |= (~ALL_QVECTOR_REG_GROUPS & ALL_VECTOR_REGS);
> +        break;
> +    case TCG_TYPE_V128:
> +        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +        tcg_target_available_regs[TCG_TYPE_V256] = ALL_DVECTOR_REG_GROUPS;
> +        s->reserved_regs |= (~ALL_DVECTOR_REG_GROUPS & ALL_VECTOR_REGS);
> +        break;
> +    default:
> +        /* Guaranteed by Zve64x. */
> +        tcg_debug_assert(riscv_lg2_vlenb >= TCG_TYPE_V256);
> +
> +        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +        tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
> +        break;
> +    }
>   
>       tcg_target_call_clobber_regs = -1u;
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S0);
> @@ -2115,7 +2175,6 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S10);
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S11);
>   
> -    s->reserved_regs = 0;
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_ZERO);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
> @@ -2123,6 +2182,7 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);
>       tcg_regset_set_reg(s->reserved_regs, TCG_REG_TP);
> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_V0);
>   }
>   
>   typedef struct {
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 1a347eaf6e..12a7a37aaa 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -28,42 +28,28 @@
>   #include "host/cpuinfo.h"
>   
>   #define TCG_TARGET_INSN_UNIT_SIZE 4
> -#define TCG_TARGET_NB_REGS 32
> +#define TCG_TARGET_NB_REGS 64
>   #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>   
>   typedef enum {
> -    TCG_REG_ZERO,
> -    TCG_REG_RA,
> -    TCG_REG_SP,
> -    TCG_REG_GP,
> -    TCG_REG_TP,
> -    TCG_REG_T0,
> -    TCG_REG_T1,
> -    TCG_REG_T2,
> -    TCG_REG_S0,
> -    TCG_REG_S1,
> -    TCG_REG_A0,
> -    TCG_REG_A1,
> -    TCG_REG_A2,
> -    TCG_REG_A3,
> -    TCG_REG_A4,
> -    TCG_REG_A5,
> -    TCG_REG_A6,
> -    TCG_REG_A7,
> -    TCG_REG_S2,
> -    TCG_REG_S3,
> -    TCG_REG_S4,
> -    TCG_REG_S5,
> -    TCG_REG_S6,
> -    TCG_REG_S7,
> -    TCG_REG_S8,
> -    TCG_REG_S9,
> -    TCG_REG_S10,
> -    TCG_REG_S11,
> -    TCG_REG_T3,
> -    TCG_REG_T4,
> -    TCG_REG_T5,
> -    TCG_REG_T6,
> +    TCG_REG_ZERO, TCG_REG_RA,  TCG_REG_SP,  TCG_REG_GP,
> +    TCG_REG_TP,   TCG_REG_T0,  TCG_REG_T1,  TCG_REG_T2,
> +    TCG_REG_S0,   TCG_REG_S1,  TCG_REG_A0,  TCG_REG_A1,
> +    TCG_REG_A2,   TCG_REG_A3,  TCG_REG_A4,  TCG_REG_A5,
> +    TCG_REG_A6,   TCG_REG_A7,  TCG_REG_S2,  TCG_REG_S3,
> +    TCG_REG_S4,   TCG_REG_S5,  TCG_REG_S6,  TCG_REG_S7,
> +    TCG_REG_S8,   TCG_REG_S9,  TCG_REG_S10, TCG_REG_S11,
> +    TCG_REG_T3,   TCG_REG_T4,  TCG_REG_T5,  TCG_REG_T6,
> +
> +    /* RISC-V V Extension registers */
> +    TCG_REG_V0,   TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
> +    TCG_REG_V4,   TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
> +    TCG_REG_V8,   TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
> +    TCG_REG_V12,  TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
> +    TCG_REG_V16,  TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
> +    TCG_REG_V20,  TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
> +    TCG_REG_V24,  TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
> +    TCG_REG_V28,  TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
>   
>       /* aliases */
>       TCG_AREG0          = TCG_REG_S0,
> @@ -156,6 +142,32 @@ typedef enum {
>   
>   #define TCG_TARGET_HAS_tst              0
>   
> +/* vector instructions */
> +#define TCG_TARGET_HAS_v64              0
> +#define TCG_TARGET_HAS_v128             0
> +#define TCG_TARGET_HAS_v256             0
> +#define TCG_TARGET_HAS_andc_vec         0
> +#define TCG_TARGET_HAS_orc_vec          0
> +#define TCG_TARGET_HAS_nand_vec         0
> +#define TCG_TARGET_HAS_nor_vec          0
> +#define TCG_TARGET_HAS_eqv_vec          0
> +#define TCG_TARGET_HAS_not_vec          0
> +#define TCG_TARGET_HAS_neg_vec          0
> +#define TCG_TARGET_HAS_abs_vec          0
> +#define TCG_TARGET_HAS_roti_vec         0
> +#define TCG_TARGET_HAS_rots_vec         0
> +#define TCG_TARGET_HAS_rotv_vec         0
> +#define TCG_TARGET_HAS_shi_vec          0
> +#define TCG_TARGET_HAS_shs_vec          0
> +#define TCG_TARGET_HAS_shv_vec          0
> +#define TCG_TARGET_HAS_mul_vec          0
> +#define TCG_TARGET_HAS_sat_vec          0
> +#define TCG_TARGET_HAS_minmax_vec       0
> +#define TCG_TARGET_HAS_bitsel_vec       0
> +#define TCG_TARGET_HAS_cmpsel_vec       0
> +
> +#define TCG_TARGET_HAS_tst_vec          0
> +
>   #define TCG_TARGET_DEFAULT_MO (0)
>   
>   #define TCG_TARGET_NEED_LDST_LABELS
> diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target.opc.h
> new file mode 100644
> index 0000000000..b80b39e1e5
> --- /dev/null
> +++ b/tcg/riscv/tcg-target.opc.h
> @@ -0,0 +1,12 @@
> +/*
> + * Copyright (c) C-SKY Microsystems Co., Ltd.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.
> + *
> + * See the COPYING file in the top-level directory for details.
> + *
> + * Target-specific opcodes for host vector expansion.  These will be
> + * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
> + * consider these to be UNSPEC with names.
> + */

