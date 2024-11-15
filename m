Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DBCD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzur-0008Al-0L; Fri, 15 Nov 2024 12:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBzun-0008AF-Nj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:15:25 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBzum-0007tA-6i
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:15:25 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cd76c513cso19370695ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731690922; x=1732295722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/hqt+YVGvat5alUVLTbvfZAYGB7Ef99osaEXwCyy0hM=;
 b=xURctRauzZKDC3AwTJNbkOVIzgNMDmUQ7uyFQstcM1sfMjLyl3QA1STV9eKE3A1W1f
 rooXJZpQDByHp+rq3DPbyw26+96zYoqDfUhc+NKY8yHRlA0zRm6WNgR45jhdQRV5Upz6
 TwORkD8VbHSQ2L3/p1SMuXzfg/GZTZchOs/1adHtON5GQQ8mMjfALeB5D+hs9RaGyGUp
 KK1W+GQxRCF0VZJUMlBz8e9XumDw40dgUF/1AFYuHg+/zLNi8OkHjuJVPBCgA1cFfgVz
 Gq10Eo9Pvyx4HWznhNSAMGqOHbwZsNYIZpE6vtnPU8VOQd4Ic13i4z5nfelZ2bgxhbcB
 JWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731690922; x=1732295722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/hqt+YVGvat5alUVLTbvfZAYGB7Ef99osaEXwCyy0hM=;
 b=lK3AN/8UKMWhEmSOz8b2RWMXqwOWX9Z0ctpckbJqzt8AnZz1bALJXvHc8ijN4Kok74
 ZlxSWTt9KpMceaSy3zNU9/uvCjs86WIZKoSsOqEwPA2skLOfBo3SKfxr1J5qJPLk7phZ
 g0UjuOzwr+7ZNqFp35iCz9u+0EsdKmPSJj3hidmvGX2Av9r4fJ1/D9lmXc1oknn7BkJJ
 GmVk6Jxi+3+gC0ZEWKztGJiRfxnbcl/mZ6NCN596GAEqRBsqFKLcTrnc53QChE8/uqzR
 I3kElfXvI8OhOgYcQ6ckb/KsW10xgMD6QEXhLO4sqgSmYebpYQyx4D43JQdgzt5hQxG3
 /+rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9pVmZkvj6sBQ4Ik43Hij/Gl5QVFlTXJBUaaRvHc+OaJ4ZnuLNZ8IJgOgO7ulWK2qScsy35XTrvxPY@nongnu.org
X-Gm-Message-State: AOJu0Yx6XzFUSrE2/SOWgMKS2ib69KLgwkSEJy5bNeq/aGK8vEGCKluH
 H81yj006CENP2CroSZ/xOSBwucZhP32FJ/eTGsqyI0aqkzjNhK1TUJpu9YphnJhWCYoKX1/SuYM
 0
X-Google-Smtp-Source: AGHT+IELOEtR3PjYe37L/yjW7XBh8535DCBnQAHq2dCX2TvMTTvTINU0TPhQSzE+KDA9GBMMfpW3nA==
X-Received: by 2002:a17:902:f68c:b0:20c:ecca:432b with SMTP id
 d9443c01a7336-211d0ebc52amr45346435ad.35.1731690922637; 
 Fri, 15 Nov 2024 09:15:22 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0dc4cc9sm14691055ad.46.2024.11.15.09.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:15:22 -0800 (PST)
Message-ID: <9d443426-9f7c-46cf-bca3-8c4d83f2fa8c@linaro.org>
Date: Fri, 15 Nov 2024 09:15:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/loongarch: Declare
 loongarch_cpu_dump_state() locally
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241115152053.66442-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 11/15/24 07:20, Philippe Mathieu-Daudé wrote:
> loongarch_cpu_dump_state() is not used outside of cpu.c,
> no need to expose its prototype.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/loongarch/internals.h | 2 --
>   target/loongarch/cpu.c       | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

