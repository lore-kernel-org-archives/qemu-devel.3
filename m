Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE150C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 06:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5etl-0001Tw-5w; Fri, 18 Apr 2025 02:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u5eti-0001Th-NZ
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 02:08:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u5ete-0001lH-E4
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 02:08:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxmnFE7AFo3ojBAA--.58123S3;
 Fri, 18 Apr 2025 14:08:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxzxtA7AFoUQWJAA--.25458S3;
 Fri, 18 Apr 2025 14:08:02 +0800 (CST)
Subject: Re: [PATCH v3] target/loongarch: Restrict instruction execution based
 on CPU features
To: WANG Rui <wangrui@loongson.cn>, Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu@hev.cc
References: <20250418030702.445700-1-wangrui@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <4ddf9364-fe52-e2d9-3e80-b01f76201085@loongson.cn>
Date: Fri, 18 Apr 2025 14:06:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250418030702.445700-1-wangrui@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxtA7AFoUQWJAA--.25458S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJr4DJFW8ArWfXw18ZF45XFc_yoW8WF4xGo
 WrZF48J3yxXw1Y9FWYkrykt34qvryIva95A3y7Gw1UWFykZa1j934fCw1vvw43Z3yDJFyU
 Ww4Ik3Z5Ja1xZwnrl-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
 UUU==
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

Rui,

Thanks for the patch.
Overall it looks good to me.

Could you split it into three small patches? such as crc/64/fp specified 
small patches.

Regards
Bibo Mao

On 2025/4/18 上午11:07, WANG Rui wrote:
> Previously, some instructions could be executed regardless of CPU mode or
> feature support. This patch enforces proper checks so that instructions are
> only allowed when the required CPU features are enabled.
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   target/loongarch/cpu.c                        |  4 +--
>   target/loongarch/cpu.h                        |  2 +-
>   .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++----------
>   .../tcg/insn_trans/trans_branch.c.inc         |  4 +--
>   .../tcg/insn_trans/trans_extra.c.inc          | 20 ++++++-----
>   .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
>   .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
>   target/loongarch/translate.h                  |  5 +++
>   9 files changed, 52 insertions(+), 43 deletions(-)
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
> diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> index 3d70d75941..77eeedbc42 100644
> --- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> @@ -74,38 +74,38 @@ TRANS(sc_w, ALL, gen_sc, MO_TESL)
>   TRANS(ll_d, 64, gen_ll, MO_TEUQ)
>   TRANS(sc_d, 64, gen_sc, MO_TEUQ)
>   TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
> -TRANS(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> +TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
>   TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
> -TRANS(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> +TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
>   TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
> -TRANS(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> +TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
>   TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
> -TRANS(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> +TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
>   TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
> -TRANS(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> +TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
>   TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
> -TRANS(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
> +TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
>   TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
> -TRANS(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
> +TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
>   TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
> -TRANS(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
> +TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
>   TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
> -TRANS(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
> +TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
>   TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
> -TRANS(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> +TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
>   TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
> -TRANS(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> +TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
>   TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
> -TRANS(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> +TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
>   TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
> -TRANS(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> +TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
>   TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
> -TRANS(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> +TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
>   TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
> -TRANS(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
> +TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
>   TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
> -TRANS(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
> +TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
>   TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
> -TRANS(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
> +TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
>   TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
> -TRANS(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
> +TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
> diff --git a/target/loongarch/tcg/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
> index 221e5159db..f94c1f37ab 100644
> --- a/target/loongarch/tcg/insn_trans/trans_branch.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
> @@ -80,5 +80,5 @@ TRANS(bltu, ALL, gen_rr_bc, TCG_COND_LTU)
>   TRANS(bgeu, ALL, gen_rr_bc, TCG_COND_GEU)
>   TRANS(beqz, ALL, gen_rz_bc, TCG_COND_EQ)
>   TRANS(bnez, ALL, gen_rz_bc, TCG_COND_NE)
> -TRANS(bceqz, 64, gen_cz_bc, TCG_COND_EQ)
> -TRANS(bcnez, 64, gen_cz_bc, TCG_COND_NE)
> +TRANS(bceqz, FP, gen_cz_bc, TCG_COND_EQ)
> +TRANS(bcnez, FP, gen_cz_bc, TCG_COND_NE)
> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> index cfa361fecf..298a80cff5 100644
> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> @@ -69,6 +69,10 @@ static bool trans_rdtimeh_w(DisasContext *ctx, arg_rdtimeh_w *a)
>   
>   static bool trans_rdtime_d(DisasContext *ctx, arg_rdtime_d *a)
>   {
> +    if (!avail_64(ctx)) {
> +        return false;
> +    }
> +
>       return gen_rdtime(ctx, a, 0, 0);
>   }
>   
> @@ -97,11 +101,11 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
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
> +TRANS64(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
> +TRANS(crcc_w_b_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
> +TRANS(crcc_w_h_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
> +TRANS(crcc_w_w_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
> +TRANS64(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index ecbfe23b63..34cfab8879 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -233,11 +233,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
>   TRANS(iocsrrd_b, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_b)
>   TRANS(iocsrrd_h, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_h)
>   TRANS(iocsrrd_w, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_w)
> -TRANS(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
> +TRANS64(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
>   TRANS(iocsrwr_b, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_b)
>   TRANS(iocsrwr_h, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_h)
>   TRANS(iocsrwr_w, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_w)
> -TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
> +TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
>   
>   static void check_mmu_idx(DisasContext *ctx)
>   {
> diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> index 377307785a..136c4c8455 100644
> --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> @@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
>   TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
>   TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
>   TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
> -TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
> +TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
>   TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
>   TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
>   TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
> @@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
>   TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
>   TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
>   TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
> -TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> +TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
>   TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..a6f5b346bb 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -4853,9 +4853,9 @@ static bool gen_g2x(DisasContext *ctx, arg_vr_i *a, MemOp mop,
>   TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
>   TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
>   TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
> -TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> +TRANS64(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
>   TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
> -TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> +TRANS64(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
>   
>   static bool gen_v2g_vl(DisasContext *ctx, arg_rv_i *a, uint32_t oprsz, MemOp mop,
>                          void (*func)(TCGv, TCGv_ptr, tcg_target_long))
> @@ -4886,15 +4886,15 @@ static bool gen_x2g(DisasContext *ctx, arg_rv_i *a, MemOp mop,
>   TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_i64)
>   TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_i64)
>   TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_i64)
> -TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> +TRANS64(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
>   TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_i64)
>   TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_i64)
>   TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_i64)
> -TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> +TRANS64(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
>   TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_i64)
> -TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> +TRANS64(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
>   TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_i64)
> -TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> +TRANS64(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
>   
>   static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
>                           uint32_t oprsz, MemOp mop)
> @@ -4923,11 +4923,11 @@ static bool gvec_dupx(DisasContext *ctx, arg_vr *a, MemOp mop)
>   TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
>   TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
>   TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
> -TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> +TRANS64(vreplgr2vr_d, LSX, gvec_dup, MO_64)
>   TRANS(xvreplgr2vr_b, LASX, gvec_dupx, MO_8)
>   TRANS(xvreplgr2vr_h, LASX, gvec_dupx, MO_16)
>   TRANS(xvreplgr2vr_w, LASX, gvec_dupx, MO_32)
> -TRANS(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
> +TRANS64(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
>   
>   static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
>   {
> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index 195f53573a..bbe015ba57 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -14,6 +14,10 @@
>       static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
>       { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
>   
> +#define TRANS64(NAME, AVAIL, FUNC, ...) \
> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +    { return avail_64(ctx) && avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
> +
>   #define avail_ALL(C)   true
>   #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
>                           CPUCFG1_ARCH_LA64)
> @@ -25,6 +29,7 @@
>   #define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
>   #define avail_LASX(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
>   #define avail_IOCSR(C) (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
> +#define avail_CRC(C)   (FIELD_EX32((C)->cpucfg1, CPUCFG1, CRC))
>   
>   /*
>    * If an operation is being performed on less than TARGET_LONG_BITS,
> 


