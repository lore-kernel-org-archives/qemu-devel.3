Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98434C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXkN-0003U2-Uh; Wed, 05 Aug 2026 05:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXkL-0003Ta-3L; Wed, 05 Aug 2026 05:17:09 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wrXkI-0001c9-JY; Wed, 05 Aug 2026 05:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=o4AcxqBXkMiZ5V39uzOdJvd3jICysuZnmI6FDiYwNIs=;
 b=cJw22flsHROwnvmJuCEStziNGe6FWsMNcyJIoUp8pR4gdIlbG/ZUtLScEDEHZY
 TS5LQz5c/QIBjBI6QXss2O4xkq7CWS/riCgLdr+5sx28ndcWisvho1uFtx2vZ37F
 WaljOiFL68Sim8HMFfDv7ZGZfnmb5L+swgAKSTdqdgJ10=
Received: from [10.2.10.30] (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgAnCoJ+_3JqWVGmJw--.22431S2;
 Wed, 05 Aug 2026 17:16:47 +0800 (CST)
Subject: Re: [PATCH 04/11] target/loongarch: Use generic tcg_gen_revbit*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, maobibo@loongson.cn,
 lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-5-richard.henderson@linaro.org>
From: Song Gao <17746591750@163.com>
Message-ID: <443ed820-8ae6-80f0-f3cc-211e103076f5@163.com>
Date: Wed, 5 Aug 2026 17:16:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260731000503.170446-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: PSgvCgAnCoJ+_3JqWVGmJw--.22431S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4UZw15try3CrWfJr4Dtwb_yoW5uryrpF
 W7Cr1UKr48XrZ3ZrZ7Z3s0gF1DArsrKw47Xa1xGr909w43XryIqr40y3y3KF1UJ3WUXr48
 Z3ZYkryjvayUX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRPku-UUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbC0B9WX2py-39IxgAA3Q
Received-SPF: pass client-ip=117.135.210.2; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-2.999, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/tcg/helper.h                   |  2 --
>   target/loongarch/tcg/op_helper.c                | 10 ----------
>   target/loongarch/tcg/insn_trans/trans_bit.c.inc |  9 +++++++--
>   3 files changed, 7 insertions(+), 14 deletions(-)
Reviewed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index 8a6c62f116..4b0fc81db6 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -5,8 +5,6 @@
>   
>   DEF_HELPER_2(raise_exception, noreturn, env, i32)
>   
> -DEF_HELPER_FLAGS_1(bitrev_w, TCG_CALL_NO_RWG_SE, tl, tl)
> -DEF_HELPER_FLAGS_1(bitrev_d, TCG_CALL_NO_RWG_SE, tl, tl)
>   DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
>   
>   DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index e63ac66daa..37afa8e92d 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -22,16 +22,6 @@ void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
>       do_raise_exception(env, exception, GETPC());
>   }
>   
> -target_ulong helper_bitrev_w(target_ulong rj)
> -{
> -    return (int32_t)revbit32(rj);
> -}
> -
> -target_ulong helper_bitrev_d(target_ulong rj)
> -{
> -    return revbit64(rj);
> -}
> -
>   target_ulong helper_bitswap(target_ulong v)
>   {
>       v = ((v >> 1) & (target_ulong)0x5555555555555555ULL) |
> diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> index ee5fa003ce..3d24e320ce 100644
> --- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
> @@ -178,6 +178,11 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
>       tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
>   }
>   
> +static void gen_bitrev_w(TCGv dest, TCGv src)
> +{
> +    tcg_gen_revbit32_tl(dest, src, TCG_BSWAP_OS);
> +}
> +
>   TRANS(ext_w_h, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
>   TRANS(ext_w_b, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
>   TRANS(clo_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
> @@ -196,8 +201,8 @@ TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
>   TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
>   TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
>   TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
> -TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
> -TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
> +TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_w)
> +TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit64_i64)
>   TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
>   TRANS(masknez, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
>   TRANS(bytepick_w, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)


