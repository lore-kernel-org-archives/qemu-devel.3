Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A38C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwV7-0002bG-NV; Mon, 17 Feb 2025 03:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwV6-0002b2-M7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:29:12 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwV4-00028V-IK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:29:12 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f31f7732dso1274853f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739780948; x=1740385748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Qqqmenc/397MjyB18fr8gx6L+62aZTM2qYCy1xedks=;
 b=ePCvZRd8/HIiNBC9qs0H5eUA1f83KziYLWN989aa/AGHteIud4/6Jwmfe38KmoYDFf
 yOcbTYvyZkLB4abdEGI1La3jcLiU8jD6mnBi/hUCATwcGM5DeDl4/XIxjUOkJuZUYSJq
 aNIY14+oejdtX0CDdgKdV0HEDfN1AZyKvSa97UPw7n/FWlXsK0RWtQF5fmUMc+IO9g2I
 wBBbJkpH+EgI44rxLuD9lWEkOBB5sJ1eWsnaqSNVXyKRsDcaySDbzpq1a63hO/EasCQ1
 Eqleoc8P2fJ47dg2I56YXE0MT2P/HXWgR3bJdyMR6S4E0wv5iI5sPbvwjSXTHY4oWpLQ
 irPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780948; x=1740385748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Qqqmenc/397MjyB18fr8gx6L+62aZTM2qYCy1xedks=;
 b=XU/fRpsCcK8YC6hapu+3lJ4uGXZZat1heo2wpDEMt3Jl+EUP7yjkVECP8i7MdBOBYV
 f9J3xQLNQUn8sO7qNtH6EMR5SisaLX3m0/mZ3O6+ecs8pnKIhQpDC4+8XTDSlEsVtOox
 RpsLOSj3DJC159vabKZp+j12dDLYJWgnu0CjYZFTj/zawfQ0kxRnwI/Jwm+9gFSOZ2T/
 JN0skmMieF6hphy5r9dmvnn9csSoXhIA4Mv5+PB057O4U76C1vjrD5XH189PIOKTc64c
 nOGJnK9LtS9iR5kk87YTLva8UzIfMmK50u7lQCxL8FXGTWeibDyb/adjK+pup8h564g1
 k/0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3hxVQ9JxCv7pePm8zozV/0s8RgIxanOaoAtIYYIfSXi63QOhAkiK8khzKeD1NXTHj7xNSf4QWzkLE@nongnu.org
X-Gm-Message-State: AOJu0YyZ9DF6+eMsA9nwCODMqixpAduzRi09qMUOG14XA7idF6yt37Vo
 8OKnpt8SyQTGmQI7qyikQMNSCp5B+2fw++9kGUjyYW74SlPxVRHdR09PGo9XTzzHjKDblSz1jDX
 B
X-Gm-Gg: ASbGncsFxpEI6TyHx7IZ5P3HYGXKrgwX5ze4l/A8nPk1D75jhjl34+iQ8x9LarEuYGj
 ZwIhWV91Hx348NNsaacDD2aafR/KSnbTJ9wjPzOgyB2vDHGEkTxoJXi+s9U82x+fABqA2mUi3aq
 1ftXYOtJ4FyBxi4b7jjKNUOSKoeajPoPgc7inmmdlGI+p0KlP4luNoCCCVgG6PnZ+L3IYwNfqt6
 nfJlo4Mk3yI8BPDgvBxNMtN40n0SKTbWUhGgLtrTtk7U9zKX273z6SyJ+8LLiu8UFILgkfwBxdu
 pn06ET/78wHqs7IV992IvffH1Hoj6w==
X-Google-Smtp-Source: AGHT+IE4DEgjMYwltrxqZWqSZKQ2CjIN8MxBDC3WAQrE7lndNZNGOt26OYZsm9UQS8+Prez+flocxg==
X-Received: by 2002:a5d:6da7:0:b0:38d:ae4e:2267 with SMTP id
 ffacd0b85a97d-38f339ded2fmr6247082f8f.11.1739780948288; 
 Mon, 17 Feb 2025 00:29:08 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dd5acsm11743376f8f.35.2025.02.17.00.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:29:07 -0800 (PST)
Message-ID: <003d3f5c-16e3-4754-9a3c-a26f61b9bdcb@linaro.org>
Date: Mon, 17 Feb 2025 09:29:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 043/162] tcg: Merge INDEX_op_divu_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-44-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
>   tcg/optimize.c           |  9 +++++----
>   tcg/tcg-op.c             | 16 ++++++++--------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  5 ++---
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 20 insertions(+), 23 deletions(-)


> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 127d0f9390..77386eacb7 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -551,9 +551,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>           }
>           return (int64_t)x / ((int64_t)y ? : 1);
>   
> -    case INDEX_op_divu_i32:
> -        return (uint32_t)x / ((uint32_t)y ? : 1);
> -    case INDEX_op_divu_i64:
> +    case INDEX_op_divu:
> +        if (type == TCG_TYPE_I32) {
> +            return (uint32_t)x / ((uint32_t)y ? : 1);
> +        }
>           return (uint64_t)x / ((uint64_t)y ? : 1);

or directly:

      return (tcg_target_ulong)x / ((tcg_target_ulong)y ? : 1);


