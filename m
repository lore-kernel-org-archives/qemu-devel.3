Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B4E9D827
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9X6P-0004cf-S3; Sun, 05 Apr 2026 19:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X6M-0004c9-3y
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:41:58 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X6I-0005Bk-H9
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:41:56 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35d932cc948so1782970a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775432513; x=1776037313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OZTI7uDYyCa0csCQmCJW6AfoMI0/v79qRdtHrSz5zL0=;
 b=f7qSL4zz2MSpa5HKoQvnlPrgRoY58zlSdC2QVIPtKOf92eGxCIJsqENQ5vp/OwX9AB
 sOyCrl/beTlGyPuWooycJjxkO4tYUPb/oyfh1NZBBR2LlxmPNNeF85x1MpaCst04hbvi
 U+UZYlr1hYIDJ1WKspyKSQrm9oouvaX6IowjBMsKADvXUbcF+6oZEMKUd8p/j/+hglxL
 S1tEyuafeoXIy8wMdYynIJkxIxqTWQ3tNunwYsWZJRzRs3/lCq4jSGlcuM+BSFkoWTXS
 jSU+Q7rFELMNcpxwuntMts4ktDJtuVBn25iVA/yxU8OAtlYpuru2SuXUpVqwWHXhcTyj
 Y0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775432513; x=1776037313;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZTI7uDYyCa0csCQmCJW6AfoMI0/v79qRdtHrSz5zL0=;
 b=fnQv0slBVZaok6cVwxfFsrCwRQfB1rnhzHUsqnQmJDBRp7kHLH1+ZmxdNmT8N+bpLS
 sxM5U2XUo482qF3i66QdpnQIqNWEugwhlX/G3HaZTMNm+7txgqeXp8wfV9/UFFDLhJIE
 xGwZ4uf0X1kqmZMULEIWee0xWfXOx+O5Y87vXeiDzthSZ2m1enZ4mQKK6WWtnTgvJDb5
 +4enN+eEatSmFcg/KHH+lE45K31U+FTy0/EKRtv22dLRrb/1xbiOIb3ncrhEzND2iJxo
 iCQtGfMlrnpWgPxbZpVcMroQ3oEOk+9zKD9OiLZEE3vSH/X8HrNKSjykJfuXWX+u34ef
 HQCg==
X-Gm-Message-State: AOJu0YykUedtd7QNBjCjPuszMN2zrcdKw+jsrSsuErJ+19Jj4bRqvIj4
 YxwIrUt8yVW6lAxfpBdM7KpsyRpvH52OWIhhLQhag+ySOjUAEUq5HFMpETop0lVzHBSU6Qy+b2L
 VeE+U
X-Gm-Gg: AeBDiesqzQJXCPLOFqTGtQwlqjON/CFx9O+d1mJsXCx3VGFgR94IjHTKEX0WE6G0qIW
 HNXVguofpcjT53UtKQIz3qsIdMKhpijdV+GswinX+n16Ll9B6YBXUU5V3LUv1SLaGIJZyGhCWrm
 b5b/ut1h1hUMv1dcQYW6+vZi5760p5EBpvEGYKqQihaHu31xb4FFuirGkTT/SK0kIIx8NRIYcrH
 VFrxjjwK/7q42x/G2+MdCuiw+xUjs8jmyKlpqVYADFyl1kHthTofCX/bX6ooopSgsa3/0iGgfLc
 /F/bl9Iyn797843oWoE99+cqiolPI2e+khngvulSHj87ASdJw4zTD50uEx362DDVVDwFYFEAzUm
 LIZHpoQ18McrquNf//RtKLgUuDbpMcJDxraMfc5enrjWgwAKYSNFnDoq4ihxGRVYXVDA8B/Smm+
 8EH1Bzg9SnqHmkURq0V1yMLGtBo+1ZNtmbLHskTx6KQyhzYHgSkcU6CEvsaFIHNBT/124=
X-Received: by 2002:a17:90a:ec84:b0:35a:cf:64a6 with SMTP id
 98e67ed59e1d1-35de6973e69mr10175808a91.23.1775432512894; 
 Sun, 05 Apr 2026 16:41:52 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe9377b7sm21328049a91.10.2026.04.05.16.41.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:41:52 -0700 (PDT)
Message-ID: <2cb30aae-40af-4784-b38f-c4c7519143b7@linaro.org>
Date: Mon, 6 Apr 2026 09:41:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/35] target/arm: migrate wfx syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> This will help later when we expand the fields we report.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 3bd98a30367..503b19b5d02 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -655,11 +655,25 @@ static inline uint32_t syn_breakpoint(int same_el)
>       return res;
>   }
>   
> +/*
> + * ISS encoding for an exception from a WF* instruction
> + */
> +FIELD(WFX_ISS, TI, 0, 2)
> +FIELD(WFX_ISS, RV, 2, 1)
> +FIELD(WFX_ISS, RN, 5, 5)
> +FIELD(WFX_ISS, COND, 20, 4)
> +FIELD(WFX_ISS, CV, 24, 1)
> +
>   static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
>   {
> -    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
> -           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
> -           (cv << 24) | (cond << 20) | ti;
> +    uint32_t res = syn_set_ec(0, EC_WFX_TRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
> +
> +    res = FIELD_DP32(res, WFX_ISS, CV, cv);
> +    res = FIELD_DP32(res, WFX_ISS, COND, cond);
> +    res = FIELD_DP32(res, WFX_ISS, TI, ti);
> +
> +    return res;
>   }
>   
>   static inline uint32_t syn_illegalstate(void)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

