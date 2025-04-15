Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A6DC369C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4np3-00065r-Ur; Tue, 15 Apr 2025 17:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nop-000617-Sh
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:27:53 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4noh-0007cI-BP
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:27:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so5281328b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744752457; x=1745357257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iQ1AXgo4ehu/XzJsQwipIm+Daf6WhFuBFu9WHFZaFmw=;
 b=sE1Ghf0TPyEzn+1qE1t6kMpEpyqizVeHaNI5XAKEf9lzOGzpl4+6jxIzUr08VTeADI
 ksB42nviW9jOT11qUMcsC0p+0nJFouzBtpLkCtBNicYhw2Khac50ZiMZ0R2s57JBDKfS
 5ZsTcNXPn64AziJ22To9K+l7wpGQWwtyoP40t8pSWzeQTqtaXsWaNs4ftVcUfjE1eFlL
 btsaBXRi71qOpiZjN/X51hC1jxQtM3ImSoX5PQ24fvgKbNf1j1gTzwF1ghIsfSrAGHX6
 iGwsfuTXQNk/v+expBqxonJUG4HiK2uNxBvzZHumENHRS+YZA87LeTLZo59ESW0CCQZb
 5EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744752457; x=1745357257;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iQ1AXgo4ehu/XzJsQwipIm+Daf6WhFuBFu9WHFZaFmw=;
 b=vu5dqRZLai5VG1cL1T19bZsU10YrNEzaD+29TapbxzLR4FlW4cQi+dGDWKitjfguhv
 IoIDp0ldBnsikuccpkuF7LW+48CPG/x8NN17xKf92Iyeg1Q5DwEafOAXu2EgcjARKoIv
 zKTOrNwkf5NixsMmjK2jMfLkl6/4P7V3A3+66Bo2F23VhscUo/dN07wZX11ykloO960D
 fsXaHIE3eq+pm0c/Q9aXmttvRQg4+jqFp47jUeNR8vRl6jZXv/0Fkn1DpaI6HC64Ko9a
 KIVuj1aIEdy24O5pL6y67fv9nhHoyk1fG0xCpbJa4PnyUgkk7pk6sIhsSir2JE2fr5nB
 +J0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUmPhb0MK2De5ndXvDZnhKK3iOmyFlly+kmtn2GNV3uqSjvila/Mrh4gLxT0qxBJk30iQaxpSxBQbt@nongnu.org
X-Gm-Message-State: AOJu0YxG4lRcbNj0XRSQwuZCyDN7/nPILditTYRxd+Xk8c/ss3u9fua0
 MDfgtj0m+LkT+dOpz3/mhvsQLWktRyqeei8yYLVvsWFhP/UDOHXeSZRwcjKg9Lk=
X-Gm-Gg: ASbGnctWuGZhWZpGvKeB/rE9MeEXv5Iaa4wQcGnUp+xume3AxKnEyOPYGCgNCgCGV2/
 2skN5L2y/XOkW8JQezrRXtxSSkuym4imWqt6YryTUZu1MAinJ4UVzWd3RQWkFnmEhKDJr5PWi7Z
 KCDlWcKPai7Fl+v4tBwVVwO8XYL+o956xYfy2yjMOdcRASVUJ8aEyamMahUI7SPzTWZ/yF3nZHU
 k9EIsXMcTlbFdR1+zRj6Xkb3TgSUPP2HBYnRzzWuEX75JpCzNhAMmtk1nxuNEDRMM/lg9HBJAqt
 2Uo+d60c+xhOgsVJaw6dl6yPQTS2QfiVmgNBOEXdCd7kIxR56VFJnJNspiC/kCbE
X-Google-Smtp-Source: AGHT+IHh4OM00Ttn9EBsBQkEs+RFb6Ue6byNLqZkml5L1pgAGGbos/0Jkh+HzMdiOoQHt6gMSBgwsw==
X-Received: by 2002:a05:6a00:4644:b0:736:46b4:beef with SMTP id
 d2e1a72fcca58-73c1f8c3ce0mr1400614b3a.3.1744752457290; 
 Tue, 15 Apr 2025 14:27:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21df6b6sm9016416b3a.74.2025.04.15.14.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:27:36 -0700 (PDT)
Message-ID: <05faf186-a953-4219-aa43-034bf33a578b@linaro.org>
Date: Tue, 15 Apr 2025 14:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 083/163] tcg/arm: Expand arguments to tcg_out_cmp2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-84-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-84-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
> Pass explicit arguments instead of arrays.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target.c.inc | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 3d864c1c1e..cebd783285 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1254,17 +1254,9 @@ static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
>       }
>   }
>   
> -static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
> -                            const int *const_args)
> +static TCGCond tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
> +                            TCGArg bl, bool const_bl, TCGArg bh, bool const_bh)
>   {
> -    TCGReg al = args[0];
> -    TCGReg ah = args[1];
> -    TCGArg bl = args[2];
> -    TCGArg bh = args[3];
> -    TCGCond cond = args[4];
> -    int const_bl = const_args[2];
> -    int const_bh = const_args[3];
> -
>       switch (cond) {
>       case TCG_COND_EQ:
>       case TCG_COND_NE:
> @@ -2344,11 +2336,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           break;
>   
>       case INDEX_op_brcond2_i32:
> -        c = tcg_out_cmp2(s, args, const_args);
> +        c = tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
> +                         args[3], const_args[3]);
>           tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
>           break;
>       case INDEX_op_setcond2_i32:
> -        c = tcg_out_cmp2(s, args + 1, const_args + 1);
> +        c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
> +                         args[4], const_args[4]);
>           tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c], ARITH_MOV, args[0], 0, 1);
>           tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
>                           ARITH_MOV, args[0], 0, 0);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


