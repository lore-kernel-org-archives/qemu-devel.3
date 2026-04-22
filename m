Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A809DF94CBB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFNuB-0005A6-QO; Tue, 21 Apr 2026 23:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFNu7-00056K-IC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:05:31 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFNu4-00055B-SU
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:05:30 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso1902298a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 20:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776827127; x=1777431927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XztD/aKPvxLXRvd7ZY4iLYCNEe5scz0ePJP8mjOwk6M=;
 b=EOUTXzm339gf4kZo+S10XUiiSA01JVYhbleijhSuWE91WBY+cF+Blw2fD2pUdjv/sf
 GQSmyIVJejMI2tUnHk/BFJhnGWrGXY+vkxpRAg+WC4o+OxvA/aWX957qP0rVKIrJHqxQ
 DqNqzFzbg5WYpjvePl8AW/KzYEJVc/oFPfiptZtSc4mvvqWe8oKvzZ9yJxnk0yxQjAD+
 AN009Cr/qyYviqtCMGL2V58F4HBkcq3/b4ZRMbV6+swq88/wIeXQQKHrzz+UDWTQU0zv
 2NRBQ2N37YKWIjJCeLvxrswdZvY30Q6PHnE5Lz/tR8ylT2JRO//3ONiRDTBHlQ+K8HSn
 FdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776827127; x=1777431927;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XztD/aKPvxLXRvd7ZY4iLYCNEe5scz0ePJP8mjOwk6M=;
 b=dPyKm7Sr/emDewEAcsYyyV2nOjdUZ3NNmz4RLCRSnnqvvKDBOEVEZJKUeIH75Ni+lk
 FGBdj7NxB55fxwTIZcOSXTO8GwsH3oMvZM3586o2A7RS8c8be+42tNdZ3vf2bCUTbcwJ
 VsOJ/3rlv57OLLIb2XtYiAKu7+jadvyEiGMKF4jNPkOKWZliHJ4CcSS9Brzrju3sUnBH
 YnHJ/WZAkCPioz2saG9s1Jdqf8Ty350c01yZeoqX1u6uCXw54J6GT7c4T7VtfCQyOzu1
 6/xX//z28ZVvH3NmyZKtLvx7q+MhjNsMRiHdQSfBwxxVa6ofb0knpWqppEJQRV+yyT/D
 HFQg==
X-Gm-Message-State: AOJu0Ywxgwx4SXyK+miryLKQsduWBuTjJF7uOLn5VdBp1Y9f9GwlggXv
 8rzP2ZA7mwaXwqMQpT9bzXE3GUO6+9HAYk+ces8zrU0hSfgGaSeMmZkYJsgd82DkqybhHmR35Ii
 Yd3PBNN8=
X-Gm-Gg: AeBDietTVTN2YKOltIen/HtUKsOltCFRaCCcw646+5D3oSw4uymyM8hAbEyEXmhgdkl
 Vstz4W5Dd1qDgf5FivFMlPtpmiysOIeW40YQwrsPBaL4eGPb1PaO+Kxb30KHROQBznbu23UcpEo
 UILVaa/EYce8t/jxACz7bwhpXX3FG7oFGeRoq4KCdqdoxN4tcgO6lE6kqqb3TSSM/PO4ne/+9bQ
 kL0Y0ADaJ24IKv/nJZ8VA9NL4XK89+e8X4PefMvzpYvGst5OYowxhcL4pYdrcZJowceL/zjn6Le
 z+8V4piED/Z/weTTXwt/6LBUrIpKR1+3+boK/rT5eyqTwlLrupEh5SWjhQ7msoZWq4zSxPVE1K1
 Gmoy7JS6a3uZibAmRLadjJybacA8VXsedrotm8Ly0oaMMofWq21zu/hPIoQ5v0wV83Jb3MSl5JJ
 inFASZs/e3as9DX0LO1ljazx8xcY86q4SoKSsLGMAvkm2Ll68VOW9VjqChVRq5kg==
X-Received: by 2002:a05:6a20:7fa2:b0:398:9662:10ff with SMTP id
 adf61e73a8af0-3a08d687750mr23863443637.4.1776827126683; 
 Tue, 21 Apr 2026 20:05:26 -0700 (PDT)
Received: from [10.72.56.227] ([144.130.157.129])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797701d9bfsm11188261a12.16.2026.04.21.20.05.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 20:05:26 -0700 (PDT)
Message-ID: <cb53282a-238a-41e2-9024-92deaa493110@linaro.org>
Date: Wed, 22 Apr 2026 13:04:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] target/mips: split Octeon SEQ/SNE decode
To: qemu-devel@nongnu.org
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
 <20260421-mips-octeon-missing-insns-v2-v2-3-a0791df188c9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-3-a0791df188c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/22/26 03:27, James Hilliard wrote:
> Decode the equality and inequality forms as explicit SEQ/SNE and
> SEQI/SNEI instructions rather than using shared generated SEQNE/SEQNEI
> entries.
> 
> The explicit decoder names match the architectural mnemonics, which
> makes the translator entry points and trace/debug output easier to
> correlate with the instruction set.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Split the SEQ/SNE decode cleanup out of the Octeon arithmetic
>      instruction patch.  (suggested by Philippe Mathieu-Daudé)
> ---
>   target/mips/tcg/octeon.decode      |  8 ++++++--
>   target/mips/tcg/octeon_translate.c | 26 +++++++++++++++++++++++---
>   2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 102a05860d..8a262feb1d 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -30,6 +30,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
>   # SNEI rt, rs, immediate
>   
>   @r3          ...... rs:5 rt:5 rd:5 ..... ......
> +&cmp3        rs rt rd ne
> +&cmpi        rs rt imm ne
>   %bitfield_p  0:1 6:5
>   @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=%bitfield_p
>   
> @@ -38,8 +40,10 @@ DMUL         011100 ..... ..... ..... 00000 000011 @r3
>   EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
>   CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
>   POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
> -SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
> -SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
> +SEQ          011100 rs:5 rt:5 rd:5 00000 101010 &cmp3 ne=0
> +SNE          011100 rs:5 rt:5 rd:5 00000 101011 &cmp3 ne=1
> +SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi ne=0
> +SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi ne=1

By splitting the insns, you no longer need the NE field.
You can also then use @r3 to avoid repeating the arguments.

> -static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
> +static bool trans_seqne(DisasContext *ctx, const arg_cmp3 *a)

This would become

static bool do_seqne(DisasContext *ctx, arg_r3 *a, TCGCond cond)
{
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();

     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
     tcg_gen_setcond_tl(cond, t0, t0, t1);
     gen_store_gpr(t0, a->rd);
}

static bool trans_SEQ(DisasContext *ctx, arg_r3 *a)
{
     return do_seqne(ctx, a, TCG_COND_EQ);
}

etc.

r~

