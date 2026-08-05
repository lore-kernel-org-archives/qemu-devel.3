Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924B1C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXkz-0003lr-GT; Wed, 05 Aug 2026 05:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXks-0003gl-0U; Wed, 05 Aug 2026 05:17:43 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXkp-0001h2-AX; Wed, 05 Aug 2026 05:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=eJRZGsd7IC6wBE97rqG7YhpUczFYalG96078wCk4Lcs=;
 b=AEfkVKvBAmdt9/hiA4PBPPk6Asra/LAoiNJypC/Ubisp6AL+kDuMw/dDd4WUL9
 hcjh3UzOaxY21+/r5B6fVN/TUtesS2ou939T/fHXpkwaKjrt1WkVTROssdXi2h3Y
 GobpTC5sU6bf7vT6gLnfUY7M2K85/VOFISaRT1MjBsa8U=
Received: from [10.2.10.30] (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wAXlIib_3Jqct8iOA--.17165S2; 
 Wed, 05 Aug 2026 17:17:17 +0800 (CST)
Subject: Re: [PATCH 05/11] target/loongarch: Expand bitswap inline
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, maobibo@loongson.cn,
 lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-6-richard.henderson@linaro.org>
From: Song Gao <17746591750@163.com>
Message-ID: <ba5f8bd5-1a40-6a26-5279-8bdd3b6a38e2@163.com>
Date: Wed, 5 Aug 2026 17:17:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260731000503.170446-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _____wAXlIib_3Jqct8iOA--.17165S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1DtrW7AF1kXrykJFWrKrg_yoWrGrWkpF
 y7ur1UKF48Xr93Zw4Iqw4qgFn8ArsrKw42vF4xtr9Y9w43Xry0qr4kK3ySgF1UAan8Xr4v
 93ZYk34j9ay8X3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBWldUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbC8R1eZ2py-52tLwAA3t
Received-SPF: pass client-ip=220.197.31.3; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-2.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


在 2026/7/31 上午8:04, Richard Henderson 写道:
> The bitrev_[48]b instructions reverse bits within each byte.
> This may be accomplished by reversing bits within the entire
> word followed by reversing the bytes with the entire word.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/tcg/helper.h                 |  2 --
>   target/loongarch/tcg/op_helper.c              | 11 ----------
>   .../loongarch/tcg/insn_trans/trans_bit.c.inc  | 20 +++++++++++++++++--
>   3 files changed, 18 insertions(+), 15 deletions(-)
Reviewed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index 4b0fc81db6..e76c73c775 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -5,8 +5,6 @@
>   
>   DEF_HELPER_2(raise_exception, noreturn, env, i32)
>   
> -DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
> -
>   DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
>   DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
>   
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index 37afa8e92d..f41f0cb1e6 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -22,17 +22,6 @@ void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
>       do_raise_exception(env, exception, GETPC());
>   }
>   
> -target_ulong helper_bitswap(target_ulong v)
> -{
> -    v = ((v >> 1) & (target_ulong)0x5555555555555555ULL) |
> -        ((v & (target_ulong)0x5555555555555555ULL) << 1);
> -    v = ((v >> 2) & (target_ulong)0x3333333333333333ULL) |
> -        ((v & (target_ulong)0x3333333333333333ULL) << 2);
> -    v = ((v >> 4) & (target_ulong)0x0F0F0F0F0F0F0F0FULL) |
> -        ((v & (target_ulong)0x0F0F0F0F0F0F0F0FULL) << 4);
> -    return v;
> -}
> -
>   /* loongarch assert op */
>   void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
>   {
> diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> index 3d24e320ce..1200f931fa 100644
> --- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> @@ -178,6 +178,22 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
>       tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
>   }
>   
> +static void gen_bitrev_4b(TCGv dest, TCGv src)
> +{
> +    TCGv_i32 t = tcg_temp_new_i32();
> +
> +    tcg_gen_trunc_tl_i32(t, src);
> +    tcg_gen_revbit32_i32(t, t);
> +    tcg_gen_bswap32_i32(t, t);
> +    tcg_gen_ext_i32_tl(dest, t);
> +}
> +
> +static void gen_bitrev_8b(TCGv dest, TCGv src)
> +{
> +    tcg_gen_revbit_tl(dest, src);
> +    tcg_gen_bswap_tl(dest, dest);
> +}
> +
>   static void gen_bitrev_w(TCGv dest, TCGv src)
>   {
>       tcg_gen_revbit32_tl(dest, src, TCG_BSWAP_OS);
> @@ -199,8 +215,8 @@ TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
>   TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
>   TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
>   TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
> -TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
> -TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
> +TRANS(bitrev_4b, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_4b)
> +TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_8b)
>   TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_w)
>   TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit64_i64)
>   TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)


