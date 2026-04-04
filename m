Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41124E63FE6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9AOp-0004P4-7y; Sat, 04 Apr 2026 19:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9AOo-0004Oj-Av
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:27:30 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9AOm-0005U0-Tx
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:27:30 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so1892363a91.1
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775345247; x=1775950047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Il1L2mfeL6LjxRgw84cjobckL4+JaKlEhePrj01OVqQ=;
 b=VBubYWDUI9aWoSuo4c1v+wnEtdHWLJLoA1MPoFKE4jVN2o4j4WQh2ZSCE5iU65laFB
 qVnkGscSupOx5vcNxj4RHhewUTZ8yqnoEnBJnUDIwKjqMMa6RvWhjnBYtu5rjjbl7205
 vxa9IU6HsToeyLsCg9gMoLhFkhoTFaX32xmj6grwX1DbTRO6wxGJccL9NrThFPvoV7n4
 deaBNDFbIkAdR43I/MmUOOdB6yf4vkLbP5M5PuaG9jmPJau9BjNsvaEO3PWIpNsTOyUm
 0jIIMRyoSFYZHZX+WcCw9JnT0PNMYqlNwhC82W1Z8nhXbAuiImAFkmpCzFKyV3ohNe+G
 M94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775345247; x=1775950047;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Il1L2mfeL6LjxRgw84cjobckL4+JaKlEhePrj01OVqQ=;
 b=VqyhveXgC028PtGpreOHRu8i5J9gVoBPwS2U2La6lKSLg2w0Os75zla0x1Hy7PKf6a
 9HTG4ImZJI0da4d/TaDC27wH37zuoTNkIJOxsWOqBtGV7ybAHNXJlkGIV9jB570F/BEF
 vBJYMinyH8+7Xxh6YgqWcJpudWDlcAjNvekcgA+KlRcInA9Lg34kyeG0z5e5URo8rGSk
 kfdYeeQAusFX3+BnngWYYb8zkm1WqQHnmNreLyQ8OzTBuOD+ge/pPVKoxlTFXBggUb5t
 UzsUOqGgHFW3sYZnOeT2llhUis280WppygD4t7z/tku4I6u7h8kAdm919e3E3/gJnJvj
 WR9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQO9HuehAtF5/kTK9LqbE+GayhvwXEo4KmXIv33iPRu5e2aX0Pot8GOPIlO7rofQgRZJ36bITYGLm5@nongnu.org
X-Gm-Message-State: AOJu0Yxc/yXoTDJklVEUXUfLVkqFpLT8vHsG/+Eg1EMk0dzWfF1xzTkR
 4xAvSK3fPmR8Yrghjr4C9Y6x3lzt1Mt7UEfiBOAoobXEAFWWocq/Rt1sFWs047Q4lg4=
X-Gm-Gg: AeBDiesFkJxFafuLP5G2uJvXbYRu/gaazXupdYQBHUc2MbuGXsGwbQPWzhoHjw8Or9G
 Yr07rF1fKXlukYp3I/kDKPqg1/QXmIuHFYcduHD56PwJSyOpHuuzfdlLYk+G/BgBjxI/lYaG42h
 RUmCBPxWYh7bKay6OnIAgKK1sKKy0BO17rW938fr2Pgu25o0pS9VH8LJLgla7D39k3kem1Ml0Xm
 mAmq79y41n3tHFxc83rweusddZ/oK+7pTRWU2Zxi7wCztO0vN2f2esN/S3ixqHLuOa8I65Z+Jga
 5ojl8lHcwOBvD+843t+q6u706kPgpGeZdQrPhE+y21T5K20R+5SFzh8l+L1erudn85Y6kBM4WVk
 E7lKq1Dntymjl7uT5liTyJkTKTllruK/VtR+6e+cELHdTbJNZWgnQGiSGAo/qTkYHVUehPhwOoE
 PsQT6nPk0hmw8ydnkLybY2BjyzXSXEucjhqN1Zsb2dtP/ZppnXwaTcKEa3W4n9j2VEKTI=
X-Received: by 2002:a17:90b:2b4e:b0:356:35a5:4a64 with SMTP id
 98e67ed59e1d1-35de6842dc2mr6931907a91.4.1775345247149; 
 Sat, 04 Apr 2026 16:27:27 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe624756sm18566834a91.5.2026.04.04.16.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 16:27:26 -0700 (PDT)
Message-ID: <e46477fd-ff3d-4c53-8f88-0980ce5aae4e@linaro.org>
Date: Sun, 5 Apr 2026 09:27:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] target/arm: add TCSO bitmasks to SCTLR
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
 <20260309-feat-mte4-v4-2-daaf0375620d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260309-feat-mte4-v4-2-daaf0375620d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/10/26 08:59, Gabriel Brookman wrote:
> These are the bitmasks used to control the FEAT_MTE_STORE_ONLY feature.
> They are now named and setting these fields of SCTLR is ignored if MTE
> or MTE4 is disabled, as per convention.
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   target/arm/cpu-features.h |  5 +++++
>   target/arm/cpu.h          |  2 ++
>   target/arm/helper.c       | 20 ++++++++++++++------
>   3 files changed, 21 insertions(+), 6 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

