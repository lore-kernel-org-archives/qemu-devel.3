Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646AFC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 08:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5hAD-0005A5-TG; Fri, 18 Apr 2025 04:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u5hAC-00059s-6N
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:33:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u5hA8-00065K-O7
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:33:31 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Ax3eJRDgJoypvBAA--.19673S3;
 Fri, 18 Apr 2025 16:33:21 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxbsVMDgJoNjGJAA--.14934S3;
 Fri, 18 Apr 2025 16:33:20 +0800 (CST)
Subject: Re: [PATCH v4 1/3] target/loongarch: Add CRC feature flag and use it
 to gate CRC instructions
To: WANG Rui <wangrui@loongson.cn>, Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu@hev.cc
References: <20250418082103.447780-1-wangrui@loongson.cn>
 <20250418082103.447780-2-wangrui@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <10c89e31-0963-7d19-27ae-69f4037abd63@loongson.cn>
Date: Fri, 18 Apr 2025 16:32:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250418082103.447780-2-wangrui@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsVMDgJoNjGJAA--.14934S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFyrGr1fur1kArykJryruFX_yoWruFW5pr
 WxCr4UKrWUt3s7Z3s7J3yYqrn8Xr4DKw42vayktr9rurs8Xrn2vFZ7ta1IkFW5tw1UZw1F
 qF4avayqkFsxZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.272,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/4/18 下午4:21, WANG Rui wrote:
> This patch replaces the obsolete IOCSR_BRD bit with CRC in cpucfg1[25],
> in both LA464 and LA132 CPU initialization functions. The corresponding
> field macro in `cpu.h` is updated to reflect this change.
> 
> Additionally, the availability macro `avail_CRC()` is introduced in
> `translate.h` to check the CRC feature flag.
> 
> All CRC-related instruction translations are updated to be gated by
> the new CRC feature flag instead of hardcoded CPU features.
> 
> This ensures correctness and configurability when enabling CRC
> instructions based on hardware capabilities.
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   target/loongarch/cpu.c                           |  4 ++--
>   target/loongarch/cpu.h                           |  2 +-
>   .../loongarch/tcg/insn_trans/trans_extra.c.inc   | 16 ++++++++--------
>   target/loongarch/translate.h                     |  1 +
>   4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ea1665e270..fc439d0090 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -431,7 +431,7 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG1, EP, 1);
>       data = FIELD_DP32(data, CPUCFG1, RPLV, 1);
>       data = FIELD_DP32(data, CPUCFG1, HP, 1);
> -    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
> +    data = FIELD_DP32(data, CPUCFG1, CRC, 1);
>       env->cpucfg[1] = data;
>   
>       data = 0;
> @@ -530,7 +530,7 @@ static void loongarch_la132_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG1, EP, 0);
>       data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
>       data = FIELD_DP32(data, CPUCFG1, HP, 1);
> -    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
> +    data = FIELD_DP32(data, CPUCFG1, CRC, 1);
>       env->cpucfg[1] = data;
>   }
>   
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 254e4fbdcd..ab76a0b451 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -129,7 +129,7 @@ FIELD(CPUCFG1, RI, 21, 1)
>   FIELD(CPUCFG1, EP, 22, 1)
>   FIELD(CPUCFG1, RPLV, 23, 1)
>   FIELD(CPUCFG1, HP, 24, 1)
> -FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
> +FIELD(CPUCFG1, CRC, 25, 1)
>   FIELD(CPUCFG1, MSG_INT, 26, 1)
>   
>   /* cpucfg[1].arch */
> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> index cfa361fecf..eda3d6e561 100644
> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> @@ -97,11 +97,11 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
>       return true;
>   }
>   
> -TRANS(crc_w_b_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
> -TRANS(crc_w_h_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
> -TRANS(crc_w_w_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
> -TRANS(crc_w_d_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
> -TRANS(crcc_w_b_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
> -TRANS(crcc_w_h_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
> -TRANS(crcc_w_w_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
> -TRANS(crcc_w_d_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
> +TRANS(crc_w_b_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
> +TRANS(crc_w_h_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
> +TRANS(crc_w_w_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
> +TRANS(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
> +TRANS(crcc_w_b_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
> +TRANS(crcc_w_h_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
> +TRANS(crcc_w_w_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
> +TRANS(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index 195f53573a..018dc5eb17 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -25,6 +25,7 @@
>   #define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
>   #define avail_LASX(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
>   #define avail_IOCSR(C) (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
> +#define avail_CRC(C)   (FIELD_EX32((C)->cpucfg1, CPUCFG1, CRC))
>   
>   /*
>    * If an operation is being performed on less than TARGET_LONG_BITS,
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


