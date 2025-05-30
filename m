Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DEFC5B555
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 09:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwFF-0003UT-6B; Fri, 30 May 2025 05:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uKwFD-0003U2-Id; Fri, 30 May 2025 05:41:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uKwFB-0006ZM-Kk; Fri, 30 May 2025 05:41:43 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxGHFSfTloB_4DAQ--.26567S3;
 Fri, 30 May 2025 17:41:38 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzxtRfTloj1H9AA--.11118S3;
 Fri, 30 May 2025 17:41:38 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: add check for fcond
From: gaosong <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn, philmd@linaro.org,
 lorenz.hetterich@cispa.de, qemu-stable@nongnu.org
References: <20250523011745.3833883-1-gaosong@loongson.cn>
Message-ID: <c809fd85-1b1e-acac-a6c1-6ad13ac84f2e@loongson.cn>
Date: Fri, 30 May 2025 17:44:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250523011745.3833883-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzxtRfTloj1H9AA--.11118S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFyDKr17Kr47Xr15CF4DAwc_yoW5Ar45pw
 4YkFyUKFWUKF95AayfZa15Ka15ur18KwsF93W0qw1fGFZ8ZrnrZayrKF4Y9F45JF1vvryF
 yF1jvw1q9aySq3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1LiSJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.828, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

PIng !
ÔÚ 2025/5/23 ÉÏÎç9:17, Song Gao Ð´µÀ:
> fcond only has 22 types, add a check for fcond.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2972
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_fcmp.c.inc | 11 ++++++++---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc  |  4 ++--
>   2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
> index 3babf69e4a..5be759d30c 100644
> --- a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
> @@ -4,10 +4,15 @@
>    */
>   
>   /* bit0(signaling/quiet) bit1(lt) bit2(eq) bit3(un) bit4(neq) */
> -static uint32_t get_fcmp_flags(int cond)
> +static uint32_t get_fcmp_flags(DisasContext *ctx, int cond)
>   {
>       uint32_t flags = 0;
>   
> +    /*check cond , cond =[0-8,10,12] */
> +    if ((cond > 8) &&(cond != 10) && (cond != 12)) {
> +        generate_exception(ctx, EXCCODE_INE);
> +    }
> +
>       if (cond & 0x1) {
>           flags |= FCMP_LT;
>       }
> @@ -39,7 +44,7 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
>       src1 = get_fpr(ctx, a->fj);
>       src2 = get_fpr(ctx, a->fk);
>       fn = (a->fcond & 1 ? gen_helper_fcmp_s_s : gen_helper_fcmp_c_s);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);
>   
>       fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
>   
> @@ -63,7 +68,7 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
>       src1 = get_fpr(ctx, a->fj);
>       src2 = get_fpr(ctx, a->fk);
>       fn = (a->fcond & 1 ? gen_helper_fcmp_s_d : gen_helper_fcmp_c_d);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);
>   
>       fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
>   
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index b33622ff79..0128a2398f 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -4666,7 +4666,7 @@ static bool do_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
>       }
>   
>       fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);
>       fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
>   
>       return true;
> @@ -4686,7 +4686,7 @@ static bool do_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
>       }
>   
>       fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);
>       fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
>   
>       return true;


