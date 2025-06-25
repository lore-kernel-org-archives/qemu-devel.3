Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F8CC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURQ9-0007Cl-1y; Wed, 25 Jun 2025 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURQ2-00070l-DW
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:48:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURQ0-0005EW-Nt
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:48:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso5253456b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862886; x=1751467686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s/Y5ZyONO53NOKJ7YmRGDdnawblMtvBKampI+nQDoeI=;
 b=eHIP9O53VQLR/wIuQu/YlxESI5XVSNzurIDcaS5pRQiZZRoxI+U8wnP+IcxOeAHAAN
 eqB5USykNzE3g1huADDGch2F+k4YgjClXZoxOD76qBi0Q3U6wFEcaNNU9Z0NsGMbU+Ja
 inVlC+L4NaXEuxLwGgb5ya/e0z7Hz00YnX6Te2THP41m8no4ZkwkVFcFk/FJhAXJ9ES6
 SqynoDwj+9Cu81fCutmKjSzVnb3xmZhUTJdFYNOhIdHn4rzSz8e4fneZr2mP2gcTk6NI
 UPqV8yAiWyKq4kpu+wbBFLkLaOoBeaXe3JM0jiHvKjC8NvCFu8lQKVTc180cupdp0fPF
 zriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862886; x=1751467686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/Y5ZyONO53NOKJ7YmRGDdnawblMtvBKampI+nQDoeI=;
 b=jJesI2ewcK05xNYMMyobBtbLTGNKycl1onHHm6NDN5MgD/IRnniCwvq2icHFbOGDgV
 hbzMO35AtoA8t9QPD/yGaHDI1iTrih7Zbo+eZzJW/sw6UNE1LK7JqQHtfqo20zPL1V1w
 GL+2ouvnVTqHjwcQJkm8G1mvr1lbiCR2VN2d5sfDxooBqbcI1ASOhOQWqxhwx/cof6di
 XHMdE2FxpUqpGPstColidW00XmRffNaIy0NBauhT/xA9PtXYq4S6pl0mTHYFF08eWTk0
 swBhv6dZKaA6XjiQQXjYHNatYsCtGIB3ViQi+KCAC1vA97bLES9csQh/XaL2IgAISXbx
 o6xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp4rXur0B5T9KnbXF/nUuckdn+NXK8Q7q1WDRmvATHctH0d18nSzw/xY2Em+WBQ9mrAhoJQrQM3vMg@nongnu.org
X-Gm-Message-State: AOJu0YwShW8DXQYysQzHTf7nWTCpLDKmp9mMGcd6jeJ3KUGdbouWk6hw
 VTjZl6JpffO1GeIJONZfAqFapZUn/Kd3+IxUJ7ubl6/FW1isNSdau+c6rwjmoEQa/liBN/cU+6D
 WPOGhpp0=
X-Gm-Gg: ASbGncutYs+QG6kfOp2GK/V+zbZTIfEKZMwftXDNpmQrucCaI34H4Sa6vadk/viBXAN
 vQhbtCVV/8tamSIvVzbzzIwv+2d/4qgQaVv+w85pvq/IH38lg9EO/JTjs8bbSNSyWcgOAPmLtTe
 +7iErCJL0CKM3QDlN7fw4KT83H56Hg6a8rEs3JBvUTbZV7XSZ3WmuaTRD4emZz6UHuSapZhhMXz
 txYA2uDfgrVgQcMfhwyS2hWkxvbbCpsxP/f4ASL8Rh30V4senxpksDQn18piuE+OHmwe1gSXsOE
 /imdw5AsfNu4/G5s53J6eewy1eivRO+oyldL+IF9hUkF4IqPyKSA8qkvgx/y+OGrTuigIASv2Kk
 =
X-Google-Smtp-Source: AGHT+IHPxz5D9a/IRefUeKRoi1KGmR1i/tDbXBDbGTJSikvxb5G+8lozH8TCcUmCYRlWxbLSVVv/Vw==
X-Received: by 2002:a05:6a00:800a:b0:74a:e29c:2879 with SMTP id
 d2e1a72fcca58-74ae29c2a25mr365325b3a.15.1750862886160; 
 Wed, 25 Jun 2025 07:48:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e4293dsm4901188b3a.66.2025.06.25.07.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:48:05 -0700 (PDT)
Message-ID: <51e10325-97a9-480e-a78b-4c0e157150ce@linaro.org>
Date: Wed, 25 Jun 2025 07:48:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_nor
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


