Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E7CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeIl-000483-6e; Tue, 17 Dec 2024 15:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeIj-00047Y-I9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:36:17 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeIg-0002zs-QL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:36:17 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-728d1a2f180so74563b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467772; x=1735072572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRjqxkrDyW0LuoVmIUJek3DN8EmtlvFq5TB+fEP/fJc=;
 b=LDP99w9k0DKrjK1oySRSdeBGQKStG5CqxQ6P5xyWctLqTCSlpfA59l/8v6BhIC4fHv
 PVOuEsiUpRaxq3b9K6L335V/sqxb/J91wxcIOoNZUlsPseDiaV7/s3UVCpbb+zN4ha+c
 PMhxfU7jNh4IWvq11DcaGKcVFrGu47amsBMmqcOGQa2qbaCTWFENKOcERxe26VzoVuoN
 qJ9EpWagalpBMeU1CWuSAWev5QemWLN+4bSNTYk2kE66q+MN7taIAG8y2yP9ty81pqPO
 aeiUUwA254YLrr8t6FLaN1j7b3LQaYwc/3a7Id5Xwd+ctcThj4w0nWHH20TtdgSy92UW
 Flzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467772; x=1735072572;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cRjqxkrDyW0LuoVmIUJek3DN8EmtlvFq5TB+fEP/fJc=;
 b=R8FF8mp4jCWsbT0AYxrDh+VMcndfBL/Tnq+bNmLC42BLss2Q5MdbWYJ05WzGUY51P5
 ZIe5yI9GkbooZ32+nvWFMboYFb6xTrGWgANZHU7d4++e95F4owUl/rPKf3Ft3iHKBVHy
 e997xcq9EFOZAQXVf/Cpr48G+w7k+tp3R2VEU/kkopiyhSawp5JKnpfndTbuGvoCMmdX
 qg8i1lY6nQyfoyJqP5MC9fIRRWhDPQ6iStQjA0MAaAnp3/qV/DZziQ7FQ6Y/2uQvRJMx
 SswlZKM9jS9a26vFJ8mrIZPruv/JPcvg+ABrZ37ISEPog1dEDbX/CXuC2ZClDYlk5jJL
 08bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDecF7Rf957WA01EliCZrfmcfs6UnO6shQEfhiVt8dpSRbzJM5jK5f7GsFgJa8lqqQjxZ6HAjk0MGO@nongnu.org
X-Gm-Message-State: AOJu0YyLPUUSrdGs5kEgAaNX28vmv8SlAnFWRLgWCd1qOgheePuSl1XS
 mY7ttmJzO1V2WuxEfhbvoEH7axuldhTisKyFyUf+G2c5fP9GmTtKcvh2cY37kTA=
X-Gm-Gg: ASbGncsea9AV3ScbbWgmsXUPbWLKRcUaIOxmN/BJZvk8hXDHvjasjWBZuEWrcxmid+Z
 Q838nimbShJGZaqSHWmPSINzGucp9MyJRxnO2uO6+vI9YVM32OOEpQjk15DWY1LglcvyXxPLwMr
 /MNbfMY2x8OXjtItLTiTSbjUQiN1i6qatzLs/Tl6kOu5sRfmRvA/OQHvNI4ROjxLF03svu/srYB
 7NL3kngV005/54edFI+b63DINrIeygmrEFk9XAb738Dzod1JfpiolTpDUUuAdbMSIfH2g==
X-Google-Smtp-Source: AGHT+IErCzYJ57z0hSKvNIx3K8tFYDwNMcbbXhNEtKg5E/8Et/0U7AaeA03bJuRm17Rv3hu4L658hg==
X-Received: by 2002:a05:6a00:2d9f:b0:729:425:fde4 with SMTP id
 d2e1a72fcca58-72a787ef801mr7251897b3a.11.1734467771670; 
 Tue, 17 Dec 2024 12:36:11 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5a933c1sm6274850a12.2.2024.12.17.12.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:36:11 -0800 (PST)
Message-ID: <a3a42472-8862-4b96-822a-4ce1ebe7d0e5@linaro.org>
Date: Tue, 17 Dec 2024 12:36:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/46] tcg/optimize: Use finish_folding in fold_remainder
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-30-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index ee00620ce0..eac5ef5eec 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2134,7 +2134,7 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
>           fold_xx_to_i(ctx, op, 0)) {
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


