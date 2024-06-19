Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099EEC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 06:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJp9i-00042w-2o; Wed, 19 Jun 2024 02:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJp9a-0003tD-Ma; Wed, 19 Jun 2024 02:50:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1sJp9V-0003hR-QM; Wed, 19 Jun 2024 02:50:46 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxSuq4f3JmYyoIAA--.33059S3;
 Wed, 19 Jun 2024 14:50:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxaca0f3JmH8soAA--.32673S3; 
 Wed, 19 Jun 2024 14:50:30 +0800 (CST)
Subject: Re: [PATCH v2] tcg/loongarch64: Fix tcg_out_movi vs some pcrel
 pointers
To: Richard Henderson <richard.henderson@linaro.org>
References: <20240619055002.119042-1-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, yijun@loongson.cn, qemu-stable@nongnu.org
Message-ID: <06661142-5244-2ceb-d747-3220f7ef361a@loongson.cn>
Date: Wed, 19 Jun 2024 14:50:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240619055002.119042-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxaca0f3JmH8soAA--.32673S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1UAr1xJryDGr4DKF13WrX_yoW5Gw45pr
 9xGa4Utayrt347CFsrZr4qqw18Jr4DKw1UJasrKr10v34vv3WDWan5Cw1Sga47ta45Ar17
 ZFn0yw17WFWDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.355, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/6/19 ÏÂÎç1:50, Richard Henderson Ð´µÀ:
> Simplify the logic for two-part, 32-bit pc-relative addresses.
> Rather than assume all such fit in int32_t, do some arithmetic
> and assert a result, do some arithmetic first and then check
> to see if the pieces are in range.
>
> Reported-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Hi Song.  I was not thrilled by the "goto out" that you introduced in
>
>    20240618125044.687443-1-gaosong@loongson.cn
>
> Instead, I copied the logic from tcg/aarch64/ for adrp+add.
>
>   
Thank you.

Cc: qemu-stable@nongnu.org
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> r~
>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 7ca52d0248..e915e97bba 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -382,8 +382,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
>        * back to the slow path.
>        */
>   
> -    intptr_t pc_offset;
> -    tcg_target_long val_lo, val_hi, pc_hi, offset_hi;
> +    intptr_t src_rx, pc_offset;
>       tcg_target_long hi12, hi32, hi52;
>   
>       /* Value fits in signed i32.  */
> @@ -393,24 +392,23 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
>       }
>   
>       /* PC-relative cases.  */
> -    pc_offset = tcg_pcrel_diff(s, (void *)val);
> -    if (pc_offset == sextreg(pc_offset, 0, 22) && (pc_offset & 3) == 0) {
> -        /* Single pcaddu2i.  */
> -        tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
> -        return;
> +    src_rx = (intptr_t)tcg_splitwx_to_rx(s->code_ptr);
> +    if ((val & 3) == 0) {
> +        pc_offset = val - src_rx;
> +        if (pc_offset == sextreg(pc_offset, 0, 22)) {
> +            /* Single pcaddu2i.  */
> +            tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
> +            return;
> +        }
>       }
>   
> -    if (pc_offset == (int32_t)pc_offset) {
> -        /* Offset within 32 bits; load with pcalau12i + ori.  */
> -        val_lo = sextreg(val, 0, 12);
> -        val_hi = val >> 12;
> -        pc_hi = (val - pc_offset) >> 12;
> -        offset_hi = val_hi - pc_hi;
> -
> -        tcg_debug_assert(offset_hi == sextreg(offset_hi, 0, 20));
> -        tcg_out_opc_pcalau12i(s, rd, offset_hi);
> +    pc_offset = (val >> 12) - (src_rx >> 12);
> +    if (pc_offset == sextreg(pc_offset, 0, 20)) {
> +        /* Load with pcalau12i + ori.  */
> +        tcg_target_long val_lo = val & 0xfff;
> +        tcg_out_opc_pcalau12i(s, rd, pc_offset);
>           if (val_lo != 0) {
> -            tcg_out_opc_ori(s, rd, rd, val_lo & 0xfff);
> +            tcg_out_opc_ori(s, rd, rd, val_lo);
>           }
>           return;
>       }


