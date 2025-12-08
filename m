Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC38CD3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSdOm-0007Ry-Im; Mon, 08 Dec 2025 10:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vSdOl-0007Rj-Qv
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:43:39 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vSdOk-0007gW-3T
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:43:39 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45330fe6e1bso2862502b6e.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 07:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765208617; x=1765813417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQaDJSDrwSxi/bET+h/yHsYzhOSrBn18tV57wOxOSbc=;
 b=NfV9CcyayEglilsvi33I5GyKULs8i2NHQJkBQIXaSBLwm6MEgQOYSVVUVvEHTx4JHJ
 rahDfiQCiqkj1QhwQxY0IKjTxgi2rTadlgXYsbQr+cBK+65p++p1/jvtADsiLycKjPxt
 YDcQMX7rZi48KeGtJ0PnjtNzP7Ze1ERn9XSgRKBikIDj8qbTGYRvEpVb6Nq1hPexpynw
 d669eDfUG8mJNYIRigRLtAFRJQ20oPaN5gIJ+NoFVjxccKC014PGcNXeySqC6GhFmhkN
 ZSuX6P9VgmLN6+9TiG8ngCd0OdhKiGKaCUcyBs6/szC1fi2CCVFAuHrZX5LMdH3uJaA2
 M35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765208617; x=1765813417;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQaDJSDrwSxi/bET+h/yHsYzhOSrBn18tV57wOxOSbc=;
 b=SfLYwt+EJftAFycLqphqJGQ56f9grjEaMzTdNCjo84pujx4bZU5htKri5j9hIgy8c5
 7i7n8RCKCkYu6A7YGiAH5uAAQBzN0fOvF5a0HJqCGz5x9IupfiquBxzybjPjNbBq1zo9
 lNJgRtVmz2BRf46ox7sS2ivXSQfFlESyWyY3uDCxayvX9h1wqVLI0AUyhVoXowYvl9/r
 UyRBoemvuAg5zSUiP7H+BcSijdq80+UwjDjEbxUkUyjelB2M3pBXpxqlxv/KIihXZ7I1
 ZqEkykU0jUWYJsT2pLA9RI4zsNNBpfbKP+/lUJWCAJJFdMhd1HItBiUK3KIkqbpLtSEG
 s7LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGwZIXBojSS8/iaHeymRM/RQJClL6fLPLL7Vh9Wn9M0JnbOUQQdtkZlaPeZxrOi9PFvcM1RYWZj6Su@nongnu.org
X-Gm-Message-State: AOJu0Yw/A+LnYCBBz01fFNW/BImRUSxuRua5hFv04HJgTfI7RTBhbNOv
 Lkgq8iy2lRyllp6aSorK9scGvg2cgqeTLmeKgpV/3j7QwMol4CmOkw1g4atVbus7btI=
X-Gm-Gg: ASbGnctHg9eUvkrEEzvK0To7zKz82NJjl1f7Fgk37vY4lw7ow01WOoslYNLdZrMad3m
 LV7OkY+zZcu2/2ALZVwXlcu35zlnpFeGSHnTxECwzcLwaEEsmnyTPoE6QhuTpN91VIzm2Q85LP7
 jRYoqSyve5p3zQkUB4Fb15uf8iVeU6eUDarTbGb0wI/oGrpa537sWCPaB8oHa5Sbuo7ZhyUw6Tt
 EK570s29pAB/FNQQpD2hpknhiTuF8mN/WYDeg8ZZu7UE7IAhGFaHSEUSX5TpvSH5WA0kRqraA/b
 l8uyHKnoTL1Pwp7bR4Aq7392xmqf1FFvZRFZCU9oRvJkm5NRV3EHngvILwwfiBDQg44iGJETkH3
 PRHY8JdM6LLBB6/rNrA7RGx1t/AnFxOJJq+12t9uXBaPJdGGsmn5EV4P9IYOgZZVew4Wv7mMzog
 rFgf9hZE0hpSXG4jWT2zC55XjwvOz7FdX4kcPlnN0ia4SIXV2fyy0jePnk5jwqpZep
X-Google-Smtp-Source: AGHT+IEaFxlrYWKBDyI4cmTJ1wq7OPQA1nEX2IDCra4S0tuuGUIAFSxRwRmyHV9EWIXxBgSkWTAMMQ==
X-Received: by 2002:a05:6808:1a15:b0:441:8f74:fd3 with SMTP id
 5614622812f47-4539e0c9fd0mr2982738b6e.64.1765208616840; 
 Mon, 08 Dec 2025 07:43:36 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453801528fdsm6388855b6e.18.2025.12.08.07.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 07:43:36 -0800 (PST)
Message-ID: <b9dff9cf-d56f-43af-9c76-b778ab76fedc@linaro.org>
Date: Mon, 8 Dec 2025 09:43:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v2 2/2] tcg/loongarch64: Support every TCGCond
 for cmp_vec ops
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bingwu Zhang <xtexchooser@duck.com>, WANG Xuerui <git@xen0n.name>
References: <20251208095354.25898-1-philmd@linaro.org>
 <20251208095354.25898-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251208095354.25898-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 12/8/25 03:53, Philippe Mathieu-Daudé wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> Support for TCGCond's in loongarch64 cmp_vec codegen is not uniform: NE
> is not supported at all and will trip over assertions, and legalization
> (currently just operand-swapping) is not done for reg-imm comparisons.
> Since the TCG middle-end will not legalize the comparison conditions for
> us, we have to do it ourselves like other targets.
> 
> Because EQ/LT/LTU/LE/LEU are natively supported, we only have to keep
> the current operand swapping treatment for GT/GTU/GE/GEU but ensure it
> is done for both reg-reg and reg-imm cases, and use a bitwise NOT to
> help legalize NE.
> 
> Fixes: d8b6fa593d2d ("tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3237
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reported-by: Bingwu Zhang <xtexchooser@duck.com>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> Message-ID: <20251207055626.3685415-1-i.qemu@xen0n.name>
> [PMD: Split of bigger patch, part 2/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 45 +++++++++++++++++++++++++-------
>   1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index dbb36a2a816..1a243a57beb 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -2184,6 +2184,33 @@ static void tcg_out_cmp_vec(TCGContext *s, bool lasx, unsigned vece,
>                               bool a2_is_const, TCGCond cond)
>   {
>       LoongArchInsn insn;
> +    bool need_invert = false;
> +
> +    switch (cond) {
> +    case TCG_COND_EQ:
> +    case TCG_COND_LE:
> +    case TCG_COND_LEU:
> +    case TCG_COND_LT:
> +    case TCG_COND_LTU:
> +        /* These are directly expressible. */
> +        break;
> +    case TCG_COND_NE:
> +        need_invert = true;
> +        cond = TCG_COND_EQ;
> +        break;
> +    case TCG_COND_GE:
> +    case TCG_COND_GEU:
> +    case TCG_COND_GT:
> +    case TCG_COND_GTU:
> +        {
> +            TCGArg t;
> +            t = a1, a1 = a2, a2 = t;
> +            cond = tcg_swap_cond(cond);
> +            break;
> +        }

To repeat my review of v1, you can't swap here if a2_is_const.


r~

> +    default:
> +        g_assert_not_reached();
> +    }
>   
>       static const LoongArchInsn cmp_vec_insn[16][2][4] = {
>           [TCG_COND_EQ] = {
> @@ -2236,32 +2263,30 @@ static void tcg_out_cmp_vec(TCGContext *s, bool lasx, unsigned vece,
>            * Try vseqi/vslei/vslti
>            */
>           int64_t value = sextract64(a2, 0, 8 << vece);
> +
> +        insn = cmp_vec_imm_insn[cond][lasx][vece];
>           switch (cond) {
>           case TCG_COND_EQ:
>           case TCG_COND_LE:
>           case TCG_COND_LT:
> -            insn = cmp_vec_imm_insn[cond][lasx][vece];
>               tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
>               break;
>           case TCG_COND_LEU:
>           case TCG_COND_LTU:
> -            insn = cmp_vec_imm_insn[cond][lasx][vece];
>               tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
>               break;
>           default:
>               g_assert_not_reached();
>           }
> +    } else {
> +        insn = cmp_vec_insn[cond][lasx][vece];
> +        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
>       }
>   
> -    insn = cmp_vec_insn[cond][lasx][vece];
> -    if (insn == 0) {
> -        TCGArg t;
> -        t = a1, a1 = a2, a2 = t;
> -        cond = tcg_swap_cond(cond);
> -        insn = cmp_vec_insn[cond][lasx][vece];
> -        tcg_debug_assert(insn != 0);
> +    if (need_invert) {
> +        insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
> +        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a0, a0));
>       }
> -    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
>   }
>   
>   static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,


