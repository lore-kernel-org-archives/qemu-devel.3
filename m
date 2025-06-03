Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6BCC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 10:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMORx-0003Kd-AK; Tue, 03 Jun 2025 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uMORk-0003DS-VU; Tue, 03 Jun 2025 06:00:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1uMORi-0003N8-3I; Tue, 03 Jun 2025 06:00:40 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxPuO+xz5orxAKAQ--.63252S3;
 Tue, 03 Jun 2025 18:00:30 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxLse6xz5oe88GAQ--.28599S3;
 Tue, 03 Jun 2025 18:00:28 +0800 (CST)
Subject: Re: [PATCH v4] target/loongarch: fix vldi/xvldi raise wrong error
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Cc: philmd@linaro.org, lorenz.hetterich@cispa.de, qemu-stable@nongnu.org
References: <20250603082510.353876-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <289a2ea8-cf7a-e263-05e6-f4c5fc36ce8e@loongson.cn>
Date: Tue, 3 Jun 2025 17:59:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250603082510.353876-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLse6xz5oe88GAQ--.28599S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1DKr4fXw1ftr4xtr1rKrX_yoW8ZFWxpr
 yakr4UKr48KFZ3JrZ3Xw4jyrn8uw4xtw42gFn3tasYyFWxJr1rur4Fy39FkFyxC342vr1r
 XF4Fvwn0gay2q3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8xuctUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.054,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Song,

It is a little strange that patch with three version is sent in one day.
Maybe we should keep careful and calm :-)

Regards
Bibo Mao

On 2025/6/3 下午4:25, Song Gao wrote:
> on qemu we got an aborted error
> **
> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Aborted (core dumped)
> bu on 3A600/3A5000 we got a "Illegal instruction" error.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..9fb72fe914 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>   {
>       int mode;
> -    uint64_t data, t;
> +    uint64_t data = 0, t;
>   
>       /*
>        * imm bit [11:8] is mode, mode value is 0-12.
> @@ -3568,19 +3568,27 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>               t1 = (b7 << 9) | ((1-b6) << 8) | (b6 ? 0xff : 0);
>               data = (t1 << 54) | (t0 << 48);
>           }
> -        break;
>       default:
> -        generate_exception(ctx, EXCCODE_INE);
>           g_assert_not_reached();
> +        break;
>       }
>       return data;
>   }
>   
> +static bool check_vldi_mode(arg_vldi *a)
> +{
> +   return (a->imm >>8 & 0xf) <= 12;
> +}
>   static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>   {
>       int sel, vece;
>       uint64_t value;
>   
> +    if (!check_vldi_mode(a)){
> +        generate_exception(ctx, EXCCODE_INE);
> +        return true;
> +    }
> +
>       if (!check_vec(ctx, oprsz)) {
>           return true;
>       }
> 


