Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF9FC369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oLH-00056X-8m; Tue, 15 Apr 2025 18:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oLB-0004x9-Es
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:01:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oL5-0007qu-RM
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:01:13 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-226185948ffso65292105ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754466; x=1745359266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vYHul0996Zg2NjrxdJ3ezWHZbVa0RF0tzmbTrdjMN2s=;
 b=e2etvbdj4wKEBTd2PPd0DMgBLiDOTpq7oFzB0lJFgNdPeCN3R6f1pNvuPO1aAlfI2U
 eORad/LdMt8sSNgFPZkCKdQYtQCO0UKgA37zDSu2dPk4joChXZcr4L0z4ow6F2f4BA5u
 r5fkJM4XWxUjMe/lHgogiby+jbPXZvOFvmwdsxAh+k8I6iKBxD3IFNgxMEFTafviJ7df
 YNXU/67Giv5tPRILUVVEmvVNkj73YUjKz5ipUl6FGVSTJ24xyvBz5ARvdwDmg+ADi6Cj
 15wf7Tb1K8dFz6adAHi604kofaRcRoAFx+czo1Pp47vTLjSndgeYqstu4MmDRSOctZ97
 ElMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754466; x=1745359266;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYHul0996Zg2NjrxdJ3ezWHZbVa0RF0tzmbTrdjMN2s=;
 b=k6bpUn3a3+/i7MhmabWYgn0iLcv66cG5e+/pb+TeOS0C54h232TY3O1CooCPCFZ1Y7
 E8/FyTPdWRcgxxfKxevnpU0wCQWTdTo7upBOQ1/E47oTG7+EJWZzJGyniFMdkMkaI7wp
 YwFf9NNF75hnXVeNMeTZxuc/JrLPkPl/nbUtgkHGtmBLUqouBHWMuV35bBkBZX/bCHsM
 /TquoOhfL8dyQBAI+BSXlwsMwBqRxCMWCL77YsUnvMYA7MX2TP4WHnUyefGMw+4SkKez
 oLvLO/BTc5fzPKewzZYXRXKkqtUoGcBv6qVCGpJc1Q7aF0QjaKU4wN7dd0w7k8zHQ6Xa
 U6yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpNjtgPGPeTsdXNro/5SNOxFVRcOBDGw0iDT3LEtXGUkLy9w6l8KRLuiLhwCJTShwJ88HIYgO2t1QP@nongnu.org
X-Gm-Message-State: AOJu0Yx8dmyKPTbkt9GlbUcit8eJEJiY2mkzvWTtCCDIGI4lfI8Hc+AA
 rI0JD1TDJdFrngCc4JDNrg2W400wpoJ1E/Nv/1r7Q79rC0nLtZ9xLsUsoChNGDlStltz/QJ3m2V
 1754=
X-Gm-Gg: ASbGncviH7dmBBr1/uxUQqhgmRdHhdfPhSZ/JaBZgMGRnCWHRuqD/FlInyeJpGuJUpV
 HDgrXyQuv2Lt9DXfT6bHQiqHqDgok3LZpV9hxZsxpmmUMsMMzvPfYI88Ksxdr1SNH1rbNJiYn2U
 Oye3IWCzvVA3jZ3wrmAnJj1TAt9+MaOp/RTRUcMzDNKOQ2Q46A5iVQWS7kUSYu0W0Qk596oMUxT
 cCHLPQheqD+aqSDXQ9iF8O2r7vZf0JVYHpddzN+doE9KeWL1xzJ6mQ6Y7rZ+a1jLKlY1CVZEvwj
 3x+PmZzLzSVr2wEpA6669YUujGqzFzYapzPcjStaF4XybwPJzid9OkwCNB+YsKMi
X-Google-Smtp-Source: AGHT+IEyHBwcWAxhJH1tIy8MpWgSeneefZ9009SujCXSaqv2GgzLQWi6KJTSmGjCuKI/LBOPIsXSgg==
X-Received: by 2002:a17:903:904:b0:220:c813:dfce with SMTP id
 d9443c01a7336-22c31a7ca93mr10904465ad.39.1744754466035; 
 Tue, 15 Apr 2025 15:01:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6dbasm191615ad.239.2025.04.15.15.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:01:05 -0700 (PDT)
Message-ID: <7131a8b8-383b-4c24-a830-882c13c15e42@linaro.org>
Date: Tue, 15 Apr 2025 15:01:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 102/163] tcg/aarch64: Improve deposit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-103-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-103-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Use ANDI for deposit 0 into a register.
> Use UBFIZ, aka UBFM, for deposit register into 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-con-set.h |  2 +-
>   tcg/aarch64/tcg-target.c.inc     | 29 ++++++++++++++++++++++++++++-
>   2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
> index 1281e5efc0..2eda499cd3 100644
> --- a/tcg/aarch64/tcg-target-con-set.h
> +++ b/tcg/aarch64/tcg-target-con-set.h
> @@ -18,7 +18,6 @@ C_O1_I1(r, r)
>   C_O1_I1(w, r)
>   C_O1_I1(w, w)
>   C_O1_I1(w, wr)
> -C_O1_I2(r, 0, rz)
>   C_O1_I2(r, r, r)
>   C_O1_I2(r, r, rA)
>   C_O1_I2(r, r, rAL)
> @@ -26,6 +25,7 @@ C_O1_I2(r, r, rC)
>   C_O1_I2(r, r, ri)
>   C_O1_I2(r, r, rL)
>   C_O1_I2(r, rz, rz)
> +C_O1_I2(r, rZ, rZ)
>   C_O1_I2(w, 0, w)
>   C_O1_I2(w, w, w)
>   C_O1_I2(w, w, wN)
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 62b045c222..dee4afcce1 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2572,12 +2572,39 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
>                            TCGReg a2, unsigned ofs, unsigned len)
>   {
>       unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
> +
> +    /*
> +     * Since we can't support "0Z" as a constraint, we allow a1 in
> +     * any register.  Fix things up as if a matching constraint.
> +     */
> +    if (a0 != a1) {
> +        if (a0 == a2) {
> +            tcg_out_mov(s, type, TCG_REG_TMP0, a2);
> +            a2 = TCG_REG_TMP0;
> +        }
> +        tcg_out_mov(s, type, a0, a1);
> +    }
>       tcg_out_bfm(s, type, a0, a2, -ofs & mask, len - 1);
>   }
>   
> +static void tgen_depositi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                          tcg_target_long a2, unsigned ofs, unsigned len)
> +{
> +    tgen_andi(s, type, a0, a1, ~MAKE_64BIT_MASK(ofs, len));
> +}
> +
> +static void tgen_depositz(TCGContext *s, TCGType type, TCGReg a0, TCGReg a2,
> +                          unsigned ofs, unsigned len)
> +{
> +    int max = type == TCG_TYPE_I32 ? 31 : 63;
> +    tcg_out_ubfm(s, type, a0, a2, -ofs & max, len - 1);
> +}
> +
>   static const TCGOutOpDeposit outop_deposit = {
> -    .base.static_constraint = C_O1_I2(r, 0, rz),
> +    .base.static_constraint = C_O1_I2(r, rZ, rZ),
>       .out_rrr = tgen_deposit,
> +    .out_rri = tgen_depositi,
> +    .out_rzr = tgen_depositz,
>   };
>   
>   static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


