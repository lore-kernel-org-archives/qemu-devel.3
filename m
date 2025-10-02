Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BC4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PiE-0001SU-Jo; Thu, 02 Oct 2025 16:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PiD-0001Rb-Fc
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:15:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pi6-0005TA-Pk
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:15:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-26983b5411aso9669375ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436121; x=1760040921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mOLHYKHikropdCH7NyW9HXS3D0bgrDGBXgrypOXrGUQ=;
 b=xtsK59wXSjiaYaoTdBgjVkYae94z2uO4LEoVRQT1xnCyrRYhnhaOPMNO3IbMRsWvW0
 SPD59KPNVAcqrgReQR/f3BGD/M10tncgRuiCTn26k/NIlQPazW6mMORJM383Sn3itu8K
 bp7o6+kqjqSnljBZLw7rB3ES8ssPVfkyx9khrtaHEoBm6vPPp90n5ZPki6wDN4U1N6ii
 kkQLJ+go/vCGtkBgDJM1bEGbFvf0tnN709hUk0vBf0MmvNjIii1gChS2fO8eGVG4UX3X
 NpApv1qKtEszOzj4EAYNHjbsZnUMZbOxKA2GzXALipsB3Mi0EYr6gHtjVC4OGIrpnsPf
 LXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436121; x=1760040921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOLHYKHikropdCH7NyW9HXS3D0bgrDGBXgrypOXrGUQ=;
 b=peYqKFq9IaYAUlOC4ObY5fCu9AK8o8sPncJDIhDGlG/zUFHpEsKLj7+EiiALrkdFfg
 4BkJgkem6QRjJCvWR6rtXswAhoO4xYPqhe4+yqYcqZA2q4u0ZhQK7xIBN6k7ZM4B2kEs
 k37LpBpWu/vjv5960KyFm4Yx/2wV8VczLJOCaeYS4rtfZb88vvad3wPNJL7GiX9+kPas
 IiV0QLSsofeRFeMs/32KksvgS2b0dLeolalhGF7CyIdrdAvV3WrvUUgbnqnuI5a8lCsP
 VnaMz2Jj/l8tEI3DnOfJLtqcx9hh5rJYuzAOfaqcz0h6Dn6V3Da1s9xyg8dC7ENBTn2A
 257A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Cyk5euRdCmvz1e0uI+RiBZkFif3fXIEKewcy1lAYun8PRbEbiZTyCEqbvEm+pWCaS4mhiousbTwm@nongnu.org
X-Gm-Message-State: AOJu0YzZzq+zumMem2JV6TYjRh01bqQ5Osyhbdu01cVExRamV9vt/g1L
 bV47wFNJzf/kZQ2xjAtBftvRbhO3WJxih4CJGLVeNI/DGhNtVE1D88jhL+4UtZQOCG0=
X-Gm-Gg: ASbGnctK3p/dEjAwMMfGJsatQCl6LIV2svNnqZFwQqltxqhwkDSzd6sKEFOc/mNzNoA
 esxsZyvj1XuHI+lTDwXEmqGu4rPO7yS1MFKVeyT56nELqtCIfC4f+/6nB0xn/AeCKZt5JH6zMXb
 GD+4FOBPlPXRzmaftyfvG480P+ZMamEhIV7WG4t4Ivaw508gNLZSVCeIgQkfa8Y8XxJaz/A/e93
 oQQhPXAnWXtrLeVgvVua4MGasWNOSGgV3vC6cyy1iIezXYn8aBHJxrP/p04FbavxIPOIdnM3UEX
 atDmMtWhyt61/s2XZs6Hgj14o3Q+2sjMD2lpG+4/uPJo1/ej/LczhYkL4y3Q8De2WgUD5/HA/pv
 hImHMc2X1z76rWgdJhf6Na9PzChvQm6TEyr0gpB9naV3XZwMRl7oZQUXr1s+jNJ4=
X-Google-Smtp-Source: AGHT+IHRTOXZmyZkVEHRexy9T8A1SHU9+N8k6e0A4aJS636GrGzCw/KXudIhGh2yAT3h0LnA9tIr5Q==
X-Received: by 2002:a17:902:f64a:b0:26a:589b:cf11 with SMTP id
 d9443c01a7336-28e9a6569femr5260725ad.43.1759436120698; 
 Thu, 02 Oct 2025 13:15:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1261edsm29319985ad.34.2025.10.02.13.15.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:15:20 -0700 (PDT)
Message-ID: <c3833b08-0a40-4a98-8ba8-d59ace81fb87@linaro.org>
Date: Thu, 2 Oct 2025 13:15:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/33] target/riscv: Fix size of irq_overflow_left
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-25-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-25-anjo@rev.ng>
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> Fix to 64 bits to hold all relevant values.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


