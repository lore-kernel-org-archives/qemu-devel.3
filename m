Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C106C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 01:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJNkQ-0000aB-0y; Mon, 17 Jun 2024 21:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJNkN-0000Zi-SK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 21:34:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJNkK-0003gD-Lq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 21:34:55 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxOuo45HBmF8cHAA--.30783S3;
 Tue, 18 Jun 2024 09:34:48 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxbcc15HBm3KcmAA--.28227S3; 
 Tue, 18 Jun 2024 09:34:47 +0800 (CST)
Subject: Re: [PATCH 12/18] tcg/loongarch64: Support LASX in tcg_out_addsub_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-13-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e071739d-87ec-4bfa-03fe-9ddff9fc674e@loongson.cn>
Date: Tue, 18 Jun 2024 09:34:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxbcc15HBm3KcmAA--.28227S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1rJrW3Cw17XFy7CF1ruFX_yoW5KryDpr
 nxWF43tFWrXFs3JrWaka4jg34FgrsakwnIgrs0kw1xCrn8Ar1Uua4rtr1jyayDJ34xZF4q
 yF4xZFW3GayUtacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.388, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ÔÚ 2024/5/28 ÉÏÎç5:19, Richard Henderson Ð´µÀ:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 36 ++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 47011488dd..652aa261a3 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1758,21 +1758,25 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
>       tcg_out_dup_vec(s, type, vece, rd, TCG_REG_TMP0);
>   }
>   
> -static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
> -                               const TCGArg a1, const TCGArg a2,
> +static void tcg_out_addsub_vec(TCGContext *s, bool lasx, unsigned vece,
> +                               TCGArg a0, TCGArg a1, TCGArg a2,
>                                  bool a2_is_const, bool is_add)
>   {
> -    static const LoongArchInsn add_vec_insn[4] = {
> -        OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D
> +    static const LoongArchInsn add_vec_insn[2][4] = {
> +        { OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D },
> +        { OPC_XVADD_B, OPC_XVADD_H, OPC_XVADD_W, OPC_XVADD_D },
>       };
> -    static const LoongArchInsn add_vec_imm_insn[4] = {
> -        OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU
> +    static const LoongArchInsn add_vec_imm_insn[2][4] = {
> +        { OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU },
> +        { OPC_XVADDI_BU, OPC_XVADDI_HU, OPC_XVADDI_WU, OPC_XVADDI_DU },
>       };
> -    static const LoongArchInsn sub_vec_insn[4] = {
> -        OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
> +    static const LoongArchInsn sub_vec_insn[2][4] = {
> +        { OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D },
> +        { OPC_XVSUB_B, OPC_XVSUB_H, OPC_XVSUB_W, OPC_XVSUB_D },
>       };
> -    static const LoongArchInsn sub_vec_imm_insn[4] = {
> -        OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU
> +    static const LoongArchInsn sub_vec_imm_insn[2][4] = {
> +        { OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU },
> +        { OPC_XVSUBI_BU, OPC_XVSUBI_HU, OPC_XVSUBI_WU, OPC_XVSUBI_DU },
>       };
>       LoongArchInsn insn;
>   
> @@ -1783,10 +1787,10 @@ static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
>               value = -value;
>           }
>           if (value < 0) {
> -            insn = sub_vec_imm_insn[vece];
> +            insn = sub_vec_imm_insn[lasx][vece];
>               value = -value;
>           } else {
> -            insn = add_vec_imm_insn[vece];
> +            insn = add_vec_imm_insn[lasx][vece];
>           }
>   
>           /* Constraint TCG_CT_CONST_VADD ensures validity. */
> @@ -1797,9 +1801,9 @@ static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
>       }
>   
>       if (is_add) {
> -        insn = add_vec_insn[vece];
> +        insn = add_vec_insn[lasx][vece];
>       } else {
> -        insn = sub_vec_insn[vece];
> +        insn = sub_vec_insn[lasx][vece];
>       }
>       tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
>   }
> @@ -1963,10 +1967,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>           }
>           break;
>       case INDEX_op_add_vec:
> -        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], true);
> +        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], true);
>           break;
>       case INDEX_op_sub_vec:
> -        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], false);
> +        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], false);
>           break;
>       case INDEX_op_neg_vec:
>           tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));


