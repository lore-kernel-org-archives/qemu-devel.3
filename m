Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908C9E69191
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 20:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEa51-0004Lz-SD; Fri, 22 Nov 2024 15:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEa50-0004LU-SR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 15:16:39 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEa4z-0003c2-CH
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 15:16:38 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5ebc52deca0so1397172eaf.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 12:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732306596; x=1732911396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bYwjthPz7ZSTjWvT6SOtnqt6VUWOzk4V8pDNWIDKjVU=;
 b=zErxDJw170wWC4q0m+6n6dk4pCps0VGonm2b/m95m6tbnrC1dBpdei3EMtctiRGKWH
 Pna+5SYcEZQ7H68D5GnpSAITovlHV2+1tL2MAbkN0T4DJICSpgHCo2YZvEfmi3ccwp1Z
 R3pHYslNZNpuzIZUe8zeLOJrRwt+jWo2+qHVW4UIRYpWQfLuIauWJFqyfzg/DmawqMi7
 eapO1KWp0jZsgtR+mVtUmK+pcVK+vcQ2+b7yzCT4rp1w843frIQBHjW2rM9W6asHsMkf
 75oN+E3W6EowLy3ZERDtQjCC8dJHwKJgU4qdHMaXipecZGYsU9yUhqGCmh4wdsIjTt2M
 Kp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732306596; x=1732911396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYwjthPz7ZSTjWvT6SOtnqt6VUWOzk4V8pDNWIDKjVU=;
 b=BSxr/sq5649zTumxLZFUCx0zYpn3PZXxOIjUPRykEakz7T/6BqdhKuTKiYy3lT1l6T
 TMt4dIjS3c/b0p8S06gfXD6StK1rbpzq3EP0lb3h4kRa0VmpVNzlbQAADwnjnSJFd24Y
 bjB76c4oW4WKnS26FqpdxdxXhdBM5C4bPlaRt/3WpOfCwH+Ytwz1oH/GXO7OQjNroDIc
 7wOijPpGcqFE3NKY6xDjGOYAR176/rm9YXp/HyyP1j7J3RjwwLvXF7I+wyvjQXQGM6AW
 LYz+DGmoGK1TxiEtyYC5rXMOx6eeivh0c5WyEdtWgs4lKwwLQbRx3fehLa9k6+K0PrKK
 u4Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd2DBMYuGzLspmQjlCHbNuFobcgDppk397xqoXfamHJnbHIdFzplK1DFUXk0wlISnIlh+BbzCsaEhB@nongnu.org
X-Gm-Message-State: AOJu0YxqPnNlc5mO2iwpN1RJz4Zrnf5n42K0bFI+wRlP0LwMhy0A59kM
 cb36401qL4iIlzdG0xqyKNyMk3T/OX2SkpprTjzrUyH3GlZapJGhPb0OPvHWRrc=
X-Gm-Gg: ASbGncuCWWxSlNWlhvHjOVJgF9Airs5nx94HBUpKVEPWKlAKiZm5TlqBgsoh4iZ3EMX
 K7Y/FjmDY0XsfrObm+0yqOJhm3QVqDTHzPQC1m8e27L0qkWHKO6ABxHKBy2+JnDxQgJxpEe4J1s
 Asa/k4nph0UqgWvuBKg/8TZsbcIcMmQ2yJliO+jhjWvHdP0aBCeL9SqyQN+/5mOXpPDVdcoxrbV
 djvjB04NzWHl2u429JoLppMxgVxO9pyShQWBPp9ihyt+T1GYysMO8BOj6I36+jYhrfA39I=
X-Google-Smtp-Source: AGHT+IFegg7NAMezxrQakum+ABDZZ9Y450wDu/3U+Xx+7fw7W/hXuR0sTrLw2o2VUMm4TpNUCTC1UQ==
X-Received: by 2002:a05:6820:8c6:b0:5eb:6c26:1ca0 with SMTP id
 006d021491bc7-5f06a911c41mr3723009eaf.1.1732306595926; 
 Fri, 22 Nov 2024 12:16:35 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f071fa5201sm280632eaf.25.2024.11.22.12.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 12:16:35 -0800 (PST)
Message-ID: <ab1c101c-67e2-4bfb-a050-94567fca0699@linaro.org>
Date: Fri, 22 Nov 2024 14:16:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg/cpu32.c: swap ATCM and BTCM register names
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20241121171602.3273252-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121171602.3273252-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

On 11/21/24 11:16, Michael Tokarev wrote:
> According to Cortex-R5 r1p2 manual, register with opcode2=0 is
> BTCM and with opcode2=1 is ATCM, - exactly the opposite from how
> qemu labels them.  Just swap the labels to avoid confusion, -
> both registers are implemented as always-zero.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   target/arm/tcg/cpu32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 20c2737f17..2a77701f8d 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -574,9 +574,9 @@ static void cortex_a15_initfn(Object *obj)
>   
>   static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
>       /* Dummy the TCM region regs for the moment */
> -    { .name = "ATCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
> +    { .name = "BTCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
>         .access = PL1_RW, .type = ARM_CP_CONST },
> -    { .name = "BTCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
> +    { .name = "ATCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
>         .access = PL1_RW, .type = ARM_CP_CONST },
>       { .name = "DCACHE_INVAL", .cp = 15, .opc1 = 0, .crn = 15, .crm = 5,
>         .opc2 = 0, .access = PL1_W, .type = ARM_CP_NOP },

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

