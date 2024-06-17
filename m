Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5ECC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ7TV-0006xD-4L; Mon, 17 Jun 2024 04:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJ7TR-0006wn-RB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:12:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJ7TN-00041q-MW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:12:21 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxLuvZ729mRIIHAA--.29851S3;
 Mon, 17 Jun 2024 16:12:10 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfcfW729mdDslAA--.24749S3; 
 Mon, 17 Jun 2024 16:12:09 +0800 (CST)
Subject: Re: [PATCH 02/18] tcg/loongarch64: Use fp load/store for I32 and I64
 into vector regs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-3-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <972b9c61-33b0-dcba-7fcf-61cc496844d6@loongson.cn>
Date: Mon, 17 Jun 2024 16:12:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxfcfW729mdDslAA--.24749S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryUWF45Kw4xuFykJFyUtwc_yoW5WF18pr
 nxXrsIqF98Ja17Jw4ayF1DXryIgFs3Cr1qgFZ8GF4kXryvyryvv3ykAr1Sg34UX34Ivr4D
 A3Z8Xr13uF4qkabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.677, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/5/28 ÉÏÎç5:18, Richard Henderson Ð´µÀ:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 36 +++++++++-----------------------
>   1 file changed, 10 insertions(+), 26 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 06ca1ab11c..b9078ac793 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -803,6 +803,12 @@ static void tcg_out_ldst(TCGContext *s, LoongArchInsn opc, TCGReg data,
>       case OPC_ST_D:
>           tcg_out32(s, encode_djsk12_insn(opc, data, addr, imm12));
>           break;
> +    case OPC_FLD_S:
> +    case OPC_FLD_D:
> +    case OPC_FST_S:
> +    case OPC_FST_D:
> +        tcg_out32(s, encode_fdjsk12_insn(opc, data, addr, imm12));
> +        break;
>       default:
>           g_assert_not_reached();
>       }
> @@ -816,14 +822,14 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
>           if (dest < TCG_REG_V0) {
>               tcg_out_ldst(s, OPC_LD_W, dest, base, offset);
>           } else {
> -            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_32, dest, base, offset);
> +            tcg_out_ldst(s, OPC_FLD_S, dest, base, offset);
>           }
>           break;
>       case TCG_TYPE_I64:
>           if (dest < TCG_REG_V0) {
>               tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
>           } else {
> -            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_64, dest, base, offset);
> +            tcg_out_ldst(s, OPC_FLD_D, dest, base, offset);
>           }
>           break;
>       case TCG_TYPE_V128:
> @@ -847,36 +853,14 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
>           if (src < TCG_REG_V0) {
>               tcg_out_ldst(s, OPC_ST_W, src, base, offset);
>           } else {
> -            /* TODO: Could use fst_s, fstx_s */
> -            if (offset < -0x100 || offset > 0xff || (offset & 3)) {
> -                if (-0x800 <= offset && offset <= 0x7ff) {
> -                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
> -                } else {
> -                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> -                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
> -                }
> -                base = TCG_REG_TMP0;
> -                offset = 0;
> -            }
> -            tcg_out_opc_vstelm_w(s, src, base, offset, 0);
> +            tcg_out_ldst(s, OPC_FST_S, src, base, offset);
>           }
>           break;
>       case TCG_TYPE_I64:
>           if (src < TCG_REG_V0) {
>               tcg_out_ldst(s, OPC_ST_D, src, base, offset);
>           } else {
> -            /* TODO: Could use fst_d, fstx_d */
> -            if (offset < -0x100 || offset > 0xff || (offset & 7)) {
> -                if (-0x800 <= offset && offset <= 0x7ff) {
> -                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
> -                } else {
> -                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> -                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
> -                }
> -                base = TCG_REG_TMP0;
> -                offset = 0;
> -            }
> -            tcg_out_opc_vstelm_d(s, src, base, offset, 0);
> +            tcg_out_ldst(s, OPC_FST_D, src, base, offset);
>           }
>           break;
>       case TCG_TYPE_V128:


