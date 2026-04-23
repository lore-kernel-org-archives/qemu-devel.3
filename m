Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CDEF99370
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsKo-0001pp-7N; Thu, 23 Apr 2026 07:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsKm-0001pA-Nt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:35:04 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsKl-0007Ng-0V
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:35:04 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2adff872068so32325535ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944101; x=1777548901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZKlWNHWN6OImKUHp8U8h7SrcgaDpYAguDthFSxzveFo=;
 b=fHVSEAmSlRBq669L6dtgtEfdDYk35moMXE1kSu0uNpd1h6c6s1veMLbIURDky+orpV
 nP3Umyyb9uI414O88astagHteYsy8ztDKy0ZhQTjFOBYiaIXX6D5aWB+QZ0HCWvuORDz
 NulMWskrkJaMfx+/6jEdaqiLPWuG7hUZxqnKVeYZWlib7ADkwoPdLf1HGyxVqd7tusCG
 KldBeMvx3QrBQxUWUu8pJg3YTQOTvSuHHl3La+bgJCnrEgLDwdsKAJ2Ug8m3TTJLG9Su
 Xpi//3BYJ6xLggJ/Ax8Im/YDkWRWo6+zx5dl77C+l7cIYV56oLhvBddVe32K7XUurcGG
 slwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944101; x=1777548901;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKlWNHWN6OImKUHp8U8h7SrcgaDpYAguDthFSxzveFo=;
 b=ISjnXcgR/U9qqfcIqiu4E6h+C0SUpapVQNYW3SJ8bm8KFU5Qm9CbXj6ykRqJ8fnQUi
 +RvmgMK786Ixov6Bkbsbo/O/1XebpKDa4erMkSENiTVd4pUGE1IqLr1QNfiWCDHMkPnP
 gWXyIzsh0q7+532ZbdiAYSFCWnRo23y8cXkrDLRQ6e4+17bH261cL+5B5RPO8YNWc61j
 sEDcpym6Np4Q7LCr+bzps+f08L/ahjr1rzmS+d/aAM2pXaYS04ocXZV0+Tu7xMoUASYX
 0gLt6w0znKv90GE3sAOzEWkbfmdtr8X7VT5TBb7RRl641pMw18PZ+mg0OrU/6AP38MXO
 QSlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QFK+bw9CESQannthn5ll4xAlz444mWorYo+i9wYLjvrvCqJE7y0Mqs6uulrg1inifZcAisvfOZjwW@nongnu.org
X-Gm-Message-State: AOJu0YxtxVVwc/arMAJX24mH6db8tCQ7vTZFKqvXAA4SON/mGXM8TMhV
 sl2KZi2TMOR94Hrl8ed350xqY7csfTd7jClHydBEWfwd695/Vdo0YMNytgg0ULA7u9w=
X-Gm-Gg: AeBDiev1go+3og4qUTmyhAKy41YOlfFgpcgbwlnWEUlU3NIbrz+m9YlMGzF/l6hLYbJ
 FZ9LJ3qo80XEW17u/AcmP1U0F321Mmx7BC6V9GH9YumPJM0ok4VP1bbA9m+BObpsheHLTgPlbUD
 rT/AY588s8jxvnVUuPyLpSPFchYa0RsQ1GmYpVdWIYAEHvVPo7t9Uego4ypnxyZOvwd6i8dIXlb
 vmRl90gOmUDXPTtRqiLF7/z5Jgddziw31CGXBAsyZgYaQa1Tw/1jB2KHDQ3y/dQ38XSzWYcwtCH
 lqi7rPoIZVIzwpKY0j5UhJFXlydS3w0T6E/h8OR31jrVzBbkRJ+Owt3+kCHSY5KqLO60oBjsB6R
 2dSLynOp1SCAaCFC8Z6kYvlOdaP51HhAsMiF7Altj3EEnzxUTvmziOzu02/qXHbz7c/hZXhnjTu
 CNNnt7gNbKQWJXrfIenB+Jh44N9yqyI5HyO+XQ3bRRdkfdfwTteg==
X-Received: by 2002:a17:902:74c2:b0:2b0:6d33:e7c0 with SMTP id
 d9443c01a7336-2b5f9ecaea6mr214576545ad.1.1776944101146; 
 Thu, 23 Apr 2026 04:35:01 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cb92sm184731975ad.50.2026.04.23.04.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:35:00 -0700 (PDT)
Message-ID: <6b4559d6-cc75-4e73-b0e4-0311c1a37c98@linaro.org>
Date: Thu, 23 Apr 2026 21:34:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Remove unused tcg_gen_vec_*_tl() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260423101904.36131-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423101904.36131-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/23/26 20:19, Philippe Mathieu-Daudé wrote:
> No code uses the tcg_gen_vec_*_tl() API. Better to
> remove it now, since to compile as translation unit
> files once we need to avoid target_ulong uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Now this file only defines tcg_gen_gvec_dup_tl(), which
> is used only once in target/riscv/insn_trans/trans_rvv.c.inc:
> 
> 2156 static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
> 2157 {
> 2158     if (require_rvv(s) &&
> 2159         vext_check_isa_ill(s) &&
> 2160         /* vmv.v.x has rs2 = 0 and vm = 1 */
> 2161         vext_check_ss(s, a->rd, 0, 1)) {
> 2162         TCGv s1;
> 2163
> 2164         s1 = get_gpr(s, a->rs1, EXT_SIGN);
> 2165
> 2166         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
> 2167             if (get_xl(s) == MXL_RV32 && s->sew == MO_64) {
> 2168                 TCGv_i64 s1_i64 = tcg_temp_new_i64();
> 2169                 tcg_gen_ext_tl_i64(s1_i64, s1);
> 2170                 tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
> 2171                                      MAXSZ(s), MAXSZ(s), s1_i64);
> 2172             } else {
> 2173                 tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
>                       ^^^^^^^^^^^^^^^^^^^
> 2174                                     MAXSZ(s), MAXSZ(s), s1);
> 2175             }
> 2176         } else {
> 
> Cc: Palmer Dabbelt<palmer@dabbelt.com>
> Cc: Alistair Francis<alistair.francis@wdc.com>
> Cc: Weiwei Li<liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza<daniel.barboza@oss.qualcomm.com>
> Cc: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> Cc: Chao Liu<chao.liu.zevorn@gmail.com>
> Cc:qemu-riscv@nongnu.org
> ---
>   include/tcg/tcg-op-gvec.h | 24 ------------------------
>   1 file changed, 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

