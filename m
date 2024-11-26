Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C71D3B992
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwLP-0008Hv-Ab; Tue, 26 Nov 2024 09:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwLN-0008HR-8M
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:15:09 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwLL-0008Hx-0d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:15:08 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f201a932b2so260273eaf.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732630504; x=1733235304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ROA+OZ9D+Wv/M9rcMPWwyzEf0I4zm5e8oyhizSV4ziw=;
 b=sOgj/UHqqm6bpCNq4XHU5JAQvLLfgZVSKEBRJucAeNwZgMToxxFj4emNwD2TXVk4k4
 QcgY+7BeC+sQnpMCmv5wYkt6EIcFM9B4WdmENc04iAUC4LyJDYTBApy8Ne0xfceGTZV/
 Ju2oErf0x4K0jHWtndZjFIno+a/CcfcUpiX1PNi875pdXKGV0jirfrA0ed+uEELfBMlJ
 mVUFq/CoTxb2jFtq33jv5PK2edzWyQJ6jhCkfBp3/ZGL7s34jYZ9reEIG3dvxGJb0vgu
 QNCakiG/twR+7cnaY8IDySYyxjyThMt2bFTu0UZA0V9GXY3Oi88NhD0DNSCORK2M9XgK
 YEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630504; x=1733235304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ROA+OZ9D+Wv/M9rcMPWwyzEf0I4zm5e8oyhizSV4ziw=;
 b=l7ZdJF3EjX28U1epRV62d9dSUZo//7k064SHeW318htN5DA2CDePSu1tfbL/OEYcJx
 FdBUzL+o7lmS9vr4ZSIy/hMDOvHLMbcYagK46vFDK2RdasybsfrH1Y4y6SUX0i1b4KwU
 4mLge28N+efx87FRs/NtpC4DFZIIB0+Y3yC1DpH6tFYoDJkHdXJ4xDDSfCMd34Qwsj1a
 Y3YZvG5SJ0/CE2zXkYSpitA2UxiVCuLkEt3VzzdUxxCRhb8ytvW+Il+cMlSiMZeuD4/j
 7BtuXFGhl6WuBuaFbY7CqhqkEkmZ+iJx75EIX/yYCMwjvZWP1pR03vjNZeEebFcPNRsJ
 N/gQ==
X-Gm-Message-State: AOJu0YwKUI1exj0d3WzZLr/tYBzU6oqzL3wPkTqGEAyyTcL7pKI+w674
 8KObRhkt0mstKsboUcqz6tuPrM+83oeDLxmOticSij3wEdjb7TdgUJ73Fm4/j3+z/vCxOv2H+j+
 p
X-Gm-Gg: ASbGncv+d9g63Z+0bCHyl5uXxJCixQ0PpBbUw3xR8iZ2sWLxRvaBcCgHzAQktmn7sGj
 x3gaxJXOk8Wp7+sduCrO9gf+fEaom8YkNOxN/Y4As1y9N4BShxLZouKBuDr7Gkq9PeXVwkinHe2
 /tnThpWJAKn4nbhpNrAHDm+DgCgzutczQNa8OxFwCZ/+ndqBJoXSDMrF8Tm/Y2IhZnyfsZHDe8O
 2Wnijyml1L03YKajny1MIddIszANfLf4JwqMWjWegJlGN6Ha12wm99Le/9xy5+zxw==
X-Google-Smtp-Source: AGHT+IHFkcT2OR+0bPp0E6T74SIVXbijUm8Cp9f0h73hxT4QiIvI6uoZ66QrpmFXTu7vlrP/U5+B6Q==
X-Received: by 2002:a05:6830:902:b0:71d:5f22:afec with SMTP id
 46e09a7af769-71d5f22b21dmr1670016a34.12.1732630504355; 
 Tue, 26 Nov 2024 06:15:04 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f1daa186d7sm1722537eaf.36.2024.11.26.06.15.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:15:03 -0800 (PST)
Message-ID: <0a751295-7e17-4ac5-b6de-224424ba21fe@linaro.org>
Date: Tue, 26 Nov 2024 08:15:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/mips: Introduce gen_move_high32_i32()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> Similarly to the gen_move_high32_tl() helper which sign-extract
> the 32-higher bits of a target-wide TCG register, add a helper
> to sign-extract from 32-bit TCG registers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h | 1 +
>   target/mips/tcg/translate.c | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
> index d5d74faad92..f974cf29297 100644
> --- a/target/mips/tcg/translate.h
> +++ b/target/mips/tcg/translate.h
> @@ -156,6 +156,7 @@ void gen_base_offset_addr_tl(DisasContext *ctx, TCGv addr, int base, int offset)
>   void gen_move_low32_tl(TCGv ret, TCGv_i64 arg);
>   void gen_move_low32_i32(TCGv_i32 ret, TCGv_i64 arg);
>   void gen_move_high32_tl(TCGv ret, TCGv_i64 arg);
> +void gen_move_high32_i32(TCGv_i32 ret, TCGv_i64 arg);
>   void gen_load_gpr_tl(TCGv t, int reg);
>   void gen_load_gpr_i32(TCGv_i32 t, int reg);
>   void gen_store_gpr_tl(TCGv t, int reg);
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 80e2a8e5256..d6be37d56d3 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -1494,6 +1494,11 @@ void gen_move_high32_tl(TCGv ret, TCGv_i64 arg)
>   #endif
>   }
>   
> +void gen_move_high32_i32(TCGv_i32 ret, TCGv_i64 arg)
> +{
> +    tcg_gen_extrh_i64_i32(ret, arg);
> +}
> +
Actually, I don't see a need for either of these.
Why not use the tcg_gen_* functions directly?

Indeed, the combined tcg_gen_extr_i64_i32(low, high, arg) in most places.


r~

