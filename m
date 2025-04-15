Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702D7C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4np8-0006Au-4W; Tue, 15 Apr 2025 17:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4np5-00067e-Ri
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:28:03 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4np4-0007gB-4b
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:28:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so5612991b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744752480; x=1745357280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zPc6+JD0eSwxMb103fPJ5yv3Y01yV48KeMeh/WE0M/0=;
 b=q9kataG01UbMH/Fc2ScYi4mcR8aQ2JSIR2Z6y/LpzMdEhsa3dFJ41K8HilxX03jAFy
 DInm1ZMKXF40/1ZT3BGLm/vzutXgn+PJ4FTKRHug2A61cFr4PJncQMjYBkODOA2T9AoB
 h3f0+v9iBEsXlz2cGCi40YXy31RfjXm5VQcgddERHv1/CN2WmbcUJvJAJswMPMX5DdvX
 8GUari9u/zsKg+Xbnxfr5DUjMSE7lHIX6NjjTfOYm7chTZWHL6NaQ9U4JIecEFsd9XMp
 YsI9x6LvH6T3VIfirpbrG9lTl49jxy9h5+elL12PgI3dsR0mMCpEIeRspzOF+FtKczA5
 9R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744752480; x=1745357280;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zPc6+JD0eSwxMb103fPJ5yv3Y01yV48KeMeh/WE0M/0=;
 b=fbWz0jVkhJjovHukSuWVWOPVLDV7vMRKe7jM9cPVHlg9lqdL0xEsny4Y7Ja9MmZxeL
 QzP1Pc0CFhm+uKbraeaZXXdGsoaFyc6xhjvl9rqs4CsLThyc3WIWw+oShNBlpjpYtVy0
 rsAbrCQ0qsZ9tXRj//S2RCzx+e0L0O2mQZfAtzX1B2Q1yNbiTzeNQ+1k3PINuj75mKyM
 WyDBaL3oo921pbKsz4LCvda1IeX5VB4i/+O245FOxGgzSluDDZuRKv124lFQxNuzo9d7
 23nwjc+kneYZEObHkPYJNYmNNf0T2drlKMSrChRIBGzqXhFtXKUK2f09mqGRuBBZPHQ5
 uyWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpL5lwcgR3Z4HOPUinyaIJ6WfZ7srb+9DJyJ92w2Im4h5oNLSHlDY/GRufFnaf+wlyZIYyHMFhgt73@nongnu.org
X-Gm-Message-State: AOJu0YwlVhTVWhQ2lsznsiFEXUjV8yWsQB9bRZl7c8oY1WSLMPnEJ/WQ
 eB+TWJ87XAI7zekuagCOqI6gvDBCPVsp3XloRscHkdaLoRE0ehftikHUdB8gu0o=
X-Gm-Gg: ASbGncvdd6izF8Af1lo+ttfQwAydC/349qUy5xLn0eBJ1BxMQhK/lnfWmDeIANGw0rB
 9x9f/en6wOsYvHUQ+FUsSDWYaYzXdZyADPb37oqpb06yZnl8+b+TlNLLC+j1DSIB/XectOhEHJP
 WPixoUQUrkuDn01NhoQ4zDWgO/FsWXbkOxPjeAE38EUemnEyCAityfFuHT9QEbOo6mktLIJHVe7
 CHy/KENJ+yvOx10A2b29YZUgLcTcDDRP4j/dEUjTt4o2GATv4Ws4IBsds1JjDkVM+ZYAyfQ4x1E
 5+Eo6E/fRuclKDFAl100ic8hc9bmSi5zcVPmtgSK6VOplBUY8eNoOg==
X-Google-Smtp-Source: AGHT+IG4YJzJc++AU5Cx0WGRzFVOIyIGsSGntN/dl7/78bKXDruIis6Qb50Uyw92F75lH9W5Jx0f4A==
X-Received: by 2002:a05:6a20:d04d:b0:1f3:293b:7aa with SMTP id
 adf61e73a8af0-203adfb16a8mr801575637.4.1744752480664; 
 Tue, 15 Apr 2025 14:28:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2333841sm9057369b3a.160.2025.04.15.14.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:28:00 -0700 (PDT)
Message-ID: <c70d8b65-55c9-4d97-b2ce-fc04cca5f544@linaro.org>
Date: Tue, 15 Apr 2025 14:27:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 084/163] tcg/ppc: Expand arguments to tcg_out_cmp2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-85-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-85-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/15/25 12:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 1782d05290..669c5eae4a 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2206,8 +2206,8 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
>       }
>   }
>   
> -static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
> -                         const int *const_args)
> +static void tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> +                         TCGArg bl, bool blconst, TCGArg bh, bool bhconst)
>   {
>       static const struct { uint8_t bit1, bit2; } bits[] = {
>           [TCG_COND_LT ] = { CR_LT, CR_LT },
> @@ -2220,18 +2220,9 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
>           [TCG_COND_GEU] = { CR_GT, CR_LT },
>       };
>   
> -    TCGCond cond = args[4], cond2;
> -    TCGArg al, ah, bl, bh;
> -    int blconst, bhconst;
> +    TCGCond cond2;
>       int op, bit1, bit2;
>   
> -    al = args[0];
> -    ah = args[1];
> -    bl = args[2];
> -    bh = args[3];
> -    blconst = const_args[2];
> -    bhconst = const_args[3];
> -
>       switch (cond) {
>       case TCG_COND_EQ:
>           op = CRAND;
> @@ -2286,7 +2277,8 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
>   static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
>                                const int *const_args)
>   {
> -    tcg_out_cmp2(s, args + 1, const_args + 1);
> +    tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
> +                 args[4], const_args[4]);
>       tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
>       tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
>   }
> @@ -2294,7 +2286,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
>   static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
>                               const int *const_args)
>   {
> -    tcg_out_cmp2(s, args, const_args);
> +    tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
> +                 args[3], const_args[3]);
>       tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


