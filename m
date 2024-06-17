Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA381C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9Aq-0003V7-6D; Mon, 17 Jun 2024 06:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJ9Ak-0003Up-OD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:01:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJ9Ah-0004ek-4x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:01:09 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxHutfCXBmtokHAA--.30171S3;
 Mon, 17 Jun 2024 18:01:03 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx68ZdCXBmaGMlAA--.24580S3; 
 Mon, 17 Jun 2024 18:01:03 +0800 (CST)
Subject: Re: [PATCH 08/18] tcg/loongarch64: Support LASX in tcg_out_dupm_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-9-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <7a880312-e0e7-5aa9-4624-5f160103573f@loongson.cn>
Date: Mon, 17 Jun 2024 18:01:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx68ZdCXBmaGMlAA--.24580S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFWDKr13ZrWrWrW3JFy5Awc_yoW8tFy3p3
 srZrW5tF9rXws7Cr43A3W5Wa4xK393tw1Fqa43G34kZryqg3Wv9an7Cr4ag34Utr97Ars7
 Z3WYqr129FZ0yacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 b18UUUUU=
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

ÔÚ 2024/5/28 ÉÏÎç5:19, Richard Henderson Ð´µÀ:
> Each element size has a different encoding, so code cannot
> be shared in the same way as with tcg_out_dup_vec.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index cc54bc4a53..1e721b8b20 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1690,8 +1690,10 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
>   static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
>                                TCGReg r, TCGReg base, intptr_t offset)
>   {
> -    /* Handle imm overflow and division (vldrepl.d imm is divided by 8) */
> -    if (offset < -0x800 || offset > 0x7ff || \
> +    bool lasx = type == TCG_TYPE_V256;
> +
> +    /* Handle imm overflow and division (vldrepl.d imm is divided by 8). */
> +    if (offset < -0x800 || offset > 0x7ff ||
>           (offset & ((1 << vece) - 1)) != 0) {
>           tcg_out_addi(s, TCG_TYPE_I64, TCG_REG_TMP0, base, offset);
>           base = TCG_REG_TMP0;
> @@ -1701,16 +1703,32 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
>   
>       switch (vece) {
>       case MO_8:
> -        tcg_out_opc_vldrepl_b(s, r, base, offset);
> +        if (lasx) {
> +            tcg_out_opc_xvldrepl_b(s, r, base, offset);
> +        } else {
> +            tcg_out_opc_vldrepl_b(s, r, base, offset);
> +        }
>           break;
>       case MO_16:
> -        tcg_out_opc_vldrepl_h(s, r, base, offset);
> +        if (lasx) {
> +            tcg_out_opc_xvldrepl_h(s, r, base, offset);
> +        } else {
> +            tcg_out_opc_vldrepl_h(s, r, base, offset);
> +        }
>           break;
>       case MO_32:
> -        tcg_out_opc_vldrepl_w(s, r, base, offset);
> +        if (lasx) {
> +            tcg_out_opc_xvldrepl_w(s, r, base, offset);
> +        } else {
> +            tcg_out_opc_vldrepl_w(s, r, base, offset);
> +        }
>           break;
>       case MO_64:
> -        tcg_out_opc_vldrepl_d(s, r, base, offset);
> +        if (lasx) {
> +            tcg_out_opc_xvldrepl_d(s, r, base, offset);
> +        } else {
> +            tcg_out_opc_vldrepl_d(s, r, base, offset);
> +        }
>           break;
>       default:
>           g_assert_not_reached();


