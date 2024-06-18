Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB904C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 02:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJOjV-0001JY-Td; Mon, 17 Jun 2024 22:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJOjQ-0001Ig-NN
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 22:38:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJOjN-0005fy-Ns
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 22:38:00 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axz+v+8nBm1ckHAA--.15288S3;
 Tue, 18 Jun 2024 10:37:51 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxmsb78nBmVLgmAA--.28221S3; 
 Tue, 18 Jun 2024 10:37:50 +0800 (CST)
Subject: Re: [PATCH 14/18] tcg/loongarch64: Support LASX in tcg_out_{mov,ld,st}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-15-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <937038d0-b702-87cf-d6f5-6fe5dc1377c1@loongson.cn>
Date: Tue, 18 Jun 2024 10:37:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxmsb78nBmVLgmAA--.28221S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFWDKr1xZr15uF45XrW8AFc_yoW8ArW8pr
 1UArW5tFn5Aan2krsI9a4UXFy0qwsYyry0gan3Gr1kXrWqv34Duw48Jr1aq345t34I9r48
 Z3Z8Xr13WFWqyacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8w0
 eJUUUUU==
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
>   tcg/loongarch64/tcg-target.c.inc | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 5f4915c6ac..e633d268d0 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -325,6 +325,9 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>       case TCG_TYPE_V128:
>           tcg_out_opc_vori_b(s, ret, arg, 0);
>           break;
> +    case TCG_TYPE_V256:
> +        tcg_out_opc_xvori_b(s, ret, arg, 0);
> +        break;
>       default:
>           g_assert_not_reached();
>       }
> @@ -854,6 +857,14 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
>               tcg_out_opc_vldx(s, dest, base, TCG_REG_TMP0);
>           }
>           break;
> +    case TCG_TYPE_V256:
> +        if (-0x800 <= offset && offset <= 0x7ff) {
> +            tcg_out_opc_xvld(s, dest, base, offset);
> +        } else {
> +            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> +            tcg_out_opc_xvldx(s, dest, base, TCG_REG_TMP0);
> +        }
> +        break;
>       default:
>           g_assert_not_reached();
>       }
> @@ -886,6 +897,14 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
>               tcg_out_opc_vstx(s, src, base, TCG_REG_TMP0);
>           }
>           break;
> +    case TCG_TYPE_V256:
> +        if (-0x800 <= offset && offset <= 0x7ff) {
> +            tcg_out_opc_xvst(s, src, base, offset);
> +        } else {
> +            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> +            tcg_out_opc_xvstx(s, src, base, TCG_REG_TMP0);
> +        }
> +        break;
>       default:
>           g_assert_not_reached();
>       }


