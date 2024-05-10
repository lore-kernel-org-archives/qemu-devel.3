Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6855C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NBL-0005NJ-MQ; Fri, 10 May 2024 06:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s5NBH-0005KZ-1N; Fri, 10 May 2024 06:08:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1s5NBD-0006AU-E9; Fri, 10 May 2024 06:08:46 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxiPAg8j1m_oUKAA--.27072S3;
 Fri, 10 May 2024 18:08:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx9VYd8j1mPJgYAA--.29480S3; 
 Fri, 10 May 2024 18:08:31 +0800 (CST)
Subject: Re: [PATCH] tcg/loongarch64: Fill out tcg_out_{ld, st} for vector regs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, qemu-stable@nongnu.org
References: <20240510091251.7975-1-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d4efa83c-4e34-a3a9-6112-26b24cfbd101@loongson.cn>
Date: Fri, 10 May 2024 18:08:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240510091251.7975-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx9VYd8j1mPJgYAA--.29480S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFykZrykur1rGry5Aw4kZrc_yoW7Jr1Dpr
 15XrZIvas8AanxArWayF1DGa4vganayryqqFs3GFW8XFWDKw1kZws5Jr4ag34jq34S9r4D
 A3Z8Jr13CF4qyabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.372, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/5/10 ÏÂÎç5:12, Richard Henderson Ð´µÀ:
> TCG register spill/fill uses tcg_out_ld/st with all types,
> not necessarily going through INDEX_op_{ld,st}_vec.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 16288ded944 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2336
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 103 ++++++++++++++++++++++++-------
>   1 file changed, 80 insertions(+), 23 deletions(-)

Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 69c5b8ac4f..06ca1ab11c 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -808,18 +808,88 @@ static void tcg_out_ldst(TCGContext *s, LoongArchInsn opc, TCGReg data,
>       }
>   }
>   
> -static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
> -                       TCGReg arg1, intptr_t arg2)
> +static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
> +                       TCGReg base, intptr_t offset)
>   {
> -    bool is_32bit = type == TCG_TYPE_I32;
> -    tcg_out_ldst(s, is_32bit ? OPC_LD_W : OPC_LD_D, arg, arg1, arg2);
> +    switch (type) {
> +    case TCG_TYPE_I32:
> +        if (dest < TCG_REG_V0) {
> +            tcg_out_ldst(s, OPC_LD_W, dest, base, offset);
> +        } else {
> +            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_32, dest, base, offset);
> +        }
> +        break;
> +    case TCG_TYPE_I64:
> +        if (dest < TCG_REG_V0) {
> +            tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
> +        } else {
> +            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_64, dest, base, offset);
> +        }
> +        break;
> +    case TCG_TYPE_V128:
> +        if (-0x800 <= offset && offset <= 0x7ff) {
> +            tcg_out_opc_vld(s, dest, base, offset);
> +        } else {
> +            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> +            tcg_out_opc_vldx(s, dest, base, TCG_REG_TMP0);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
>   }
>   
> -static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
> -                       TCGReg arg1, intptr_t arg2)
> +static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
> +                       TCGReg base, intptr_t offset)
>   {
> -    bool is_32bit = type == TCG_TYPE_I32;
> -    tcg_out_ldst(s, is_32bit ? OPC_ST_W : OPC_ST_D, arg, arg1, arg2);
> +    switch (type) {
> +    case TCG_TYPE_I32:
> +        if (src < TCG_REG_V0) {
> +            tcg_out_ldst(s, OPC_ST_W, src, base, offset);
> +        } else {
> +            /* TODO: Could use fst_s, fstx_s */
> +            if (offset < -0x100 || offset > 0xff || (offset & 3)) {
> +                if (-0x800 <= offset && offset <= 0x7ff) {
> +                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
> +                } else {
> +                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> +                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
> +                }
> +                base = TCG_REG_TMP0;
> +                offset = 0;
> +            }
> +            tcg_out_opc_vstelm_w(s, src, base, offset, 0);
> +        }
> +        break;
> +    case TCG_TYPE_I64:
> +        if (src < TCG_REG_V0) {
> +            tcg_out_ldst(s, OPC_ST_D, src, base, offset);
> +        } else {
> +            /* TODO: Could use fst_d, fstx_d */
> +            if (offset < -0x100 || offset > 0xff || (offset & 7)) {
> +                if (-0x800 <= offset && offset <= 0x7ff) {
> +                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
> +                } else {
> +                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> +                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
> +                }
> +                base = TCG_REG_TMP0;
> +                offset = 0;
> +            }
> +            tcg_out_opc_vstelm_d(s, src, base, offset, 0);
> +        }
> +        break;
> +    case TCG_TYPE_V128:
> +        if (-0x800 <= offset && offset <= 0x7ff) {
> +            tcg_out_opc_vst(s, src, base, offset);
> +        } else {
> +            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> +            tcg_out_opc_vstx(s, src, base, TCG_REG_TMP0);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
>   }
>   
>   static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
> @@ -1740,7 +1810,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>   {
>       TCGType type = vecl + TCG_TYPE_V64;
>       TCGArg a0, a1, a2, a3;
> -    TCGReg temp = TCG_REG_TMP0;
>       TCGReg temp_vec = TCG_VEC_TMP0;
>   
>       static const LoongArchInsn cmp_vec_insn[16][4] = {
> @@ -1820,22 +1889,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>   
>       switch (opc) {
>       case INDEX_op_st_vec:
> -        /* Try to fit vst imm */
> -        if (-0x800 <= a2 && a2 <= 0x7ff) {
> -            tcg_out_opc_vst(s, a0, a1, a2);
> -        } else {
> -            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
> -            tcg_out_opc_vstx(s, a0, a1, temp);
> -        }
> +        tcg_out_st(s, type, a0, a1, a2);
>           break;
>       case INDEX_op_ld_vec:
> -        /* Try to fit vld imm */
> -        if (-0x800 <= a2 && a2 <= 0x7ff) {
> -            tcg_out_opc_vld(s, a0, a1, a2);
> -        } else {
> -            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
> -            tcg_out_opc_vldx(s, a0, a1, temp);
> -        }
> +        tcg_out_ld(s, type, a0, a1, a2);
>           break;
>       case INDEX_op_and_vec:
>           tcg_out_opc_vand_v(s, a0, a1, a2);


