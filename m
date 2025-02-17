Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB84C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjweP-0006ta-FF; Mon, 17 Feb 2025 03:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjweN-0006sU-Aw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:38:47 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjweF-0003YL-S1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:38:44 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f325dd90eso1173478f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739781518; x=1740386318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+vA5V8uZCXU1ifiChcRwSW9bxHqLbzblnZ3/mEejDg=;
 b=sK+C0ayrmKqI28dSTGotfE5gO2I40pvILeL+lyKr51KqFMieplCZY3PN4nNgK9W8Kv
 dq32mxrAPpPvAEwfOu+iUw2tfOxLG/hkBOlmScsL/DzZJMcDZsEy7F8spQgFqlvcp33g
 kERAR+CHGyia6JNrHNXnm2i2IZlGT1Ln7wLHqYmg1IDzA71wszWzZIQRaGf16l9JVeJv
 Cn4FzIA6bEN9/BgtfSHs+B1ni0hkeXdGDIdF6TLQ1zYX1BZr+i1LBi0Z4Dw+RJ7U8sM1
 3ecjcETTIXJd8FrM6+EXYXhyo5Y3hWGa7lMH9iExYqttbKMstXBOGtsVEumgYbZVbFwl
 d9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739781518; x=1740386318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m+vA5V8uZCXU1ifiChcRwSW9bxHqLbzblnZ3/mEejDg=;
 b=UT2b/+y86+hp8fz/1lXg/y9NMD0e7TqPgRVRW7VpUJFGaTWqmzfgUaDpPzUi+7kI5q
 VgS7J/Oe9VGbTcziwOp8M2QTsQJOYk7Cvi/cSl64mhC3ufxyAXEn7iddOuHFbyuahsBC
 RsTlovGixP3k6Fjch6wtXIlA27IDHdk8OKxOCzLgOOfiSEr2gqEAUUc2bZaqe/jdQv0i
 NLxMVmbobudKVJYzGHQE/zhRyR30LfK98gMjFUdSy4iisN9/mWb1to9nvq7lxzRiI/KZ
 +DTUd6OplMrQewM+BUuGQmj3mAwpdSEQkrC4NlK+nPko0GPGnYyjDaEE6foPkvHEmVFC
 kxfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUTtqsG/jFR4hGws7zGUqBOFrNDDh5RwI4ZBXq2U0x8O7mrw/AtdPrxIO89JeUtyM26IIbJfHDSgva@nongnu.org
X-Gm-Message-State: AOJu0YxpmoMudAh+EVCwcEI7MNgYidtQQQsiFCeXhr3kXgZ+MOof93/q
 jQY+EuRBWb18fd46DV2Q33sogSWq6G5KCL+Fi60/ToeVU46539SiYGSUUCSdcx0C5R9s8lUBLfB
 e
X-Gm-Gg: ASbGncunb/45CnN72hoYwUnZTk7qGIilNVjCsIjkH78UEJWmuT8loGW/8OCfwc77GXz
 vyqKkHPbjdhBvv8fpj0d+zmntuYwTGoP6OXLpVl5KIp6CeTn/V99Ly1u68GhJezuFnGcuFqjejN
 y2xfecZPg9pgGFE7QCcKoAm+oP2p+8sFvCIcdImFwP33CjeEes3vbYMJcG4P4yssWo6t3d2Moy0
 8A/VLCGyRGbZDyeCiN1tApvs6vXpD2lCrsWbGLQgGRVY7US4wJjE+vpUMSg8NW+K3o1YxtyAQ1x
 Y9mX8RooTcOQt4cjZKbAYmf6RwUWTA==
X-Google-Smtp-Source: AGHT+IFc+EhioFvFdQiJgwaThpqBolGxBISY9X+yDTOG61GXjj2WNc733nfn9M+IuuHRs0yiyFk6cg==
X-Received: by 2002:a5d:468d:0:b0:38f:2b34:5004 with SMTP id
 ffacd0b85a97d-38f33f4e2aamr6723173f8f.38.1739781518079; 
 Mon, 17 Feb 2025 00:38:38 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4423sm11812951f8f.11.2025.02.17.00.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:38:37 -0800 (PST)
Message-ID: <48241aca-ac94-4444-ba60-fdf887fdc953@linaro.org>
Date: Mon, 17 Feb 2025 09:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 055/162] tcg: Merge INDEX_op_shr_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-56-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-56-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 17 +++++++----------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 11 +++--------
>   docs/devel/tcg-ops.rst   |  4 ++--
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 18 insertions(+), 29 deletions(-)


> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index bc882dbe31..a10fb67da8 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -440,10 +440,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>           }
>           return (uint64_t)x << (y & 63);
>   
> -    case INDEX_op_shr_i32:
> -        return (uint32_t)x >> (y & 31);
> -
> -    case INDEX_op_shr_i64:
> +    case INDEX_op_shr:
> +        if (type == TCG_TYPE_I32) {
> +            return (uint32_t)x >> (y & 31);
> +        }
>           return (uint64_t)x >> (y & 63);

     return (tcg_target_ulong)x >> (y % TCG_TARGET_REG_BITS);

