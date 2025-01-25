Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE35C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiJ2-0008TR-EP; Sat, 25 Jan 2025 10:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbiJ1-0008T3-AD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:42:43 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbiIz-0006ZV-Ts
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:42:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21661be2c2dso52901805ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737819760; x=1738424560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sgr49kdkx0yk2MPc0pdrcvQ376Dh47btKuYjQ+Jh8hM=;
 b=wRU9baxwYARiraXA4gW8HNqP6CucSnA4HRPPl6ee3QNyQw9WCZ4wvtRAetb2uTF8LF
 EZnA8uIcbGgiVDNFAL2yiAzOQfoTCkDJdv77njEO8IhBBb7BEnVUOZv2d4LPyHtSCcYy
 gOQQkr4TMyUwv3oCABruOSEIfElhYyV7XdC9qfRYfvrn1XSXzCxSq7sDHNDsI7/QzPft
 e4k3sQ2UBDeyk4dNOZQMKXoNoLBk1SqrO6IYShwHr4WLxEie4PbMrjNECszGRX5Jn1hR
 b8NTlZ3l0wQcNzE0AQETMey6G8rJfppZjOERW0UsVNxy3eXLA75hw+IIeogmVdxEqNGH
 Q9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737819760; x=1738424560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgr49kdkx0yk2MPc0pdrcvQ376Dh47btKuYjQ+Jh8hM=;
 b=i4GyYVkmyE8JTTic+w8yCqtml7CHKX6W0f6y0ZsKN5tGy6r9h7RQgxknRVovQ/cqpx
 IDCyja0hX1dLIHwtyWe0t39mucg2+DdZ4C1tf+2DewSKJdSXYAUu+ekUpakBDRFD5eMa
 42+mL38wNpZZvsmdbxZjbq73qq3Gi37/bvxLng0kBaBqSpw1tf5gu7DNmhSFb5pWCLXk
 CZ5dDViUgSRMqHq9t8kcxqo15+pxyQBiyjsA4BolArt2a/e1J+0DzvloD8LOAEbQeTdb
 utEHPxuYKZJQw2KqiszQjp4ovg7pJpu76UqSRB+htXCp2+IkeHm+I7G4SYTgdd9ImoEV
 N1Tg==
X-Gm-Message-State: AOJu0YwCqk90ZRnxVxBLBeAL1I2P5TvrOvOez3MGCwGfbz5821JEfxF0
 jjT8LscL7Jdf75SXJuTD5KuXxlTyJjahPmBipOr2ym+mk/MJHVHjnHsI4t/kMoFuRkGyPLd6YNh
 3
X-Gm-Gg: ASbGncv15si/GwI1Hs+P8Ln6ElGx3gJRps2IvyPpMSWxlUGyQVf48vQg+rOdRSGIiKN
 mCP63Z+w0uRAugjBaxhurtq075XtWVoTscWUns6IK0dt+OS/kuy/KsYKBC0iHzlbaIegcT/uBQK
 bXiUzmyJiLtVuW+wRe6EmWOyHv3uYPfgmZZWw7FflKdz2p3OqieqVZVRFTXgC4usuO9hcE6hfFe
 wmz5REUZphX5r18a3keixb0K5DfWuWlFmJi7XCJa7yWa/IA9vJNqtBaO7uTJv3DZpFhOftkIg+/
 FlYXzcTDpuK6t9b/NJS2sQ==
X-Google-Smtp-Source: AGHT+IHkUGEsRi+21KHuo2kDvt3FTGa8q47b7kgK9WTt0zTA+7PMkTSGBh7stiNgAzGpfRcq/rP5eA==
X-Received: by 2002:a17:902:ea07:b0:216:1543:195d with SMTP id
 d9443c01a7336-21c3554b521mr505817555ad.25.1737819760333; 
 Sat, 25 Jan 2025 07:42:40 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414d87fsm33604265ad.172.2025.01.25.07.42.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:42:39 -0800 (PST)
Message-ID: <1b732c54-93b7-412e-bfc5-89a569d50fa6@linaro.org>
Date: Sat, 25 Jan 2025 07:42:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/76] fpu: Implement float_flag_input_denormal_used
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-24-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> @@ -4411,6 +4431,11 @@ float32_hs_compare(float32 xa, float32 xb, float_status *s, bool is_quiet)
>           goto soft;
>       }
>   
> +    if (unlikely(float32_is_denormal(ua.s) || float32_is_denormal(ub.s))) {
> +        /* We may need to set the input_denormal_used flag */
> +        goto soft;
> +    }
> +
>       float32_input_flush2(&ua.s, &ub.s, s);
>       if (isgreaterequal(ua.h, ub.h)) {
>           if (isgreater(ua.h, ub.h)) {

This obviates the float32_input_flush2 check.

> @@ -4462,6 +4487,12 @@ float64_hs_compare(float64 xa, float64 xb, float_status *s, bool is_quiet)
>      }
>  
>      float64_input_flush2(&ua.s, &ub.s, s);
> +
> +    if (unlikely(float64_is_denormal(ua.s) || float64_is_denormal(ub.s))) {
> +        /* We may need to set the input_denormal_used flag */
> +        goto soft;
> +    }
> +
>      if (isgreaterequal(ua.h, ub.h)) {
>          if (isgreater(ua.h, ub.h)) {
>              return float_relation_greater;

Likewise, though you're shadowing in the wrong direction this time.

Otherwise it looks ok.

r~

