Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA18E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe9g-0002qu-Tk; Tue, 17 Dec 2024 15:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe9f-0002qY-KM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:26:55 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe9d-0001Wf-Vv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:26:55 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso6121771b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467212; x=1735072012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f1fV0Qu+C0v2v8A7SFlrbJ84Lg7q0owyvCjAlcAhHQo=;
 b=q69DVlX5CY32HDABiOmGatlAjYqQcJ6OIh123BrylZgjnDw69j/6Q3AeviAd6lYAgO
 RiUJEP/URzjxP1HBQrH1ySoT3axHIeLoFLokuY9egVIwE4wFNPwhIh64J9aCBsDXCkdl
 OlENezJoCYW+R9ib7caG2VbTHyN9W7/g692MJY9LnsvNnQY2vT4vMXBeS8DUtk3nxNj+
 30ngDkvXHAPxM177YahgEvb4mqL7+rnVRI+bQTxweyAXiezv4pbaVz2nFAz/VVmm2ABE
 20J4mROokCxszEGhS9ZLt6ul4WlVUFjJL3fNVTpmuFqJ+olKUiehB5weKNQHrFhmiM9Z
 LYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467212; x=1735072012;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1fV0Qu+C0v2v8A7SFlrbJ84Lg7q0owyvCjAlcAhHQo=;
 b=UVl/KgyPM3+ZrQ34Ybp+RutlIco325b9kZlsgvOIu26KguXJOyM9QJCq4Z7CLeN6Wb
 AzUdtyJm0sRQRvZo+LXkZjlUXIx9qjTHaocibFQRRFHVeR6v+LvsyOafWvr1kdLCE0a2
 db1oslLFIQ/4oz9Xql59lQRTfihN1a+Xh2oFNCQ91LNWc18Sb9JZkIJhpT3k9dINzWj2
 EOTUtXxDfK0Na4blaMThbDIXtP7RwxYoKhUh9MHt/PJq+f0cqlaNn9tcsxA3cZX0tuuq
 WRHpEfdR30vEcKVylUnjcrjoUc67zfd4+OnjBktZT8Et3fILc9nqVvzDDrCyirJcp/T7
 uNFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnykRWX+F4+bBWsEm2AR1Zy8qWYNppJj3d79yvdjXYD25w7tU359C2VbZjKurPH/SU5/ouAdoPx/+T@nongnu.org
X-Gm-Message-State: AOJu0Yw6YS7N6LJkRk5myR5NZecgRzoZaA08KtZkJZ8MmwMkw7eyw+lq
 w2GdQA7kH6gObi/XcWtIimjbihwsXrlkRxAigpF4DPSoHzBRwXavWwY5QZrbDIA=
X-Gm-Gg: ASbGncss2byHgwS7jKCq5Nj8xoqgMgXkXbwZIlek6FTNL90pdTAc1EM3f8cYMFOT9ST
 lDTTm/6gCBZ1YPImxw6sr0ty5dqa3ucNOXUlwuZWshP840FTGtt41AcjY+Zj7my5JfiSGllRBBD
 RPcHj6v6baSerJrWgk95Kes0rVc0ibu6/H5mcfWNqwi+WuCnWTN3z8G/RiSBvDdUaEIiMYpxMfV
 /ia6+Dv/JYRtqRr1moqYDapO/z0MhUgLBOMkd7O1H8CRNybHmLIuJheFiI7YqE6zykqzA==
X-Google-Smtp-Source: AGHT+IFczRVjrjIRHB1TZG+cNM3UnpQM9aiyaxz/Ay3LjkWQl+nX06UGsOYaztd2kNDWBb2NVGbFJw==
X-Received: by 2002:a05:6a00:35c3:b0:725:e309:7110 with SMTP id
 d2e1a72fcca58-72a8d01f9bbmr590431b3a.5.1734467212227; 
 Tue, 17 Dec 2024 12:26:52 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bcdf56sm7300341b3a.182.2024.12.17.12.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:26:51 -0800 (PST)
Message-ID: <c90e5aaf-5ec7-4de6-a145-0f75a67ef275@linaro.org>
Date: Tue, 17 Dec 2024 12:26:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/46] tcg/optimize: Use fold_masks_zsa in fold_exts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index a0ccf7f3f2..5d10e704a7 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1759,7 +1759,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_exts(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t s_mask_old, s_mask, z_mask, sign;
> +    uint64_t s_mask_old, s_mask, z_mask, a_mask = -1, sign;
>       bool type_change = false;
>   
>       if (fold_const1(ctx, op)) {
> @@ -1795,13 +1795,11 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>       }
>       s_mask |= sign << 1;
>   
> -    ctx->z_mask = z_mask;
> -    ctx->s_mask = s_mask;
>       if (!type_change) {
> -        ctx->a_mask = s_mask & ~s_mask_old;
> +        a_mask = s_mask & ~s_mask_old;
>       }
>   
> -    return fold_masks(ctx, op);
> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
>   }
>   
>   static bool fold_extu(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


