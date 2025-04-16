Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE25C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u585H-00020c-ED; Wed, 16 Apr 2025 15:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u585F-0001xU-Sf
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:06:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u585D-0004dB-RD
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:06:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22409077c06so390645ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830362; x=1745435162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l/86c3CGktKfyN1Hiqb+6fW73tQfbkPtppAR3dp3yC4=;
 b=WFT5QN770LTFyW57GbyE9rN35y5RzjwfptQCDofZ5pzG+Lgy5CCdTBgLKMskJHTE+r
 Cs2bPTu/u8aMwuSAFk48dF50iUtGeftLYkRv9LBiLQjHehhMIxMBcpT/0KthUrQGhob/
 0SNFdD/IL1Br4CjNGP6U2/AIDUFls12AXG7EMzYBpfRxy66/F/in7VbgaWlPUY9wL8U6
 0u6h74JPGZo0R5x1Vpe5y5D4DeqWuNJbkTN9FKhcmNMA4Kzav9VH2aFWC/jYF7OCmnXq
 ERDV5kNbGJMFrUFn8o8doX8WOZk/qDPICI0MSBDSPShs7tMI3rWysS/PjAui/xtjkTKD
 LKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830362; x=1745435162;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/86c3CGktKfyN1Hiqb+6fW73tQfbkPtppAR3dp3yC4=;
 b=ujemehbPWD9WxLuddxFHJ24+hlGw13exaI9cE8U+jW4Ov7Ve8nKF5v0pi5Gyy4Hs8Z
 4jF9OJGA6wPpjHzHd/rx3wyaWuBxgtYglgid9GD1IRkOnNdN1P3C/Z5OB+0YURhT32ql
 GZkSn9Z7RwlNP30morDwi5Yn6EADuEwK5Pl5+3RhKzvrV3J/JKw76cvrYvnNtyoh+zod
 /3MJ+R8h7ozlsVXE/BSNXT+1yOro7J73yffsEKk1xz/2wBm7M8YEus9K83EpxQ2IUB73
 bHg5lUejeZnoRTtx2YR3zIBRcIIkMZCWpFeRg+bgX3EwfxHhf2o0Og8RMKMv2xzlE6S0
 YJlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Rzup9UHmXId6u1MmSPo3hzYHSVwBT/yTTS4VX6KsetHuo5D2KsAuYCAZ1fo887N49JghI85+grfm@nongnu.org
X-Gm-Message-State: AOJu0YwTmJYfe+Te7eFrWehGYQe2MWbzreS4PO4/crYmIFI5D9Z502E/
 0wfrJ43Jb8PyTdGfHl9AA05FbWxEqe3++YB0zkKU5F9MsuNClRvJ9yJKuRTXPJc=
X-Gm-Gg: ASbGncts+22Rqg5tL1ac0ml8FxHvGJfR7OZ4VLe6NFX4X4Mj6lqUAb82yjrXafpNZuG
 KV22o23lGT+mTdrnhVfYBeDPbACnwlDZkuhbqK6gjbfZWnYbaUbtV8e2ZvsBHmN8CihMUbcqHgQ
 TEMnyX2THwV2dF+fujzKEQexBT5SQH4+Q1HI3kwis34yF1LTFj/Fo6eyImO0aIc7Qfs93WS60XU
 Gb+wUk3FQU2xC0qsjd1WnMZt/mFuWwNNJGaTqOyTeqf2d2CzCnExQLnJJZBK0pHrxkhzlyQdHlh
 o4RAZkOAryS7TfWQ/YzqAA8LFY2hBMhpP1rvV7ndASxsVPdt20vWgg==
X-Google-Smtp-Source: AGHT+IGwQQRN1zJCTa4njj5/N4Q9zgFmi3FkhkCmUXd5Rl36rHde5tGMNDx3aYBroxSdWneVVF5EZA==
X-Received: by 2002:a17:90b:3a4b:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-308640251ecmr5103799a91.18.1744830362080; 
 Wed, 16 Apr 2025 12:06:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3086104dfd8sm2020056a91.0.2025.04.16.12.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:06:00 -0700 (PDT)
Message-ID: <b859406f-8f36-4929-9deb-0ff00fbf3b5e@linaro.org>
Date: Wed, 16 Apr 2025 12:05:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 127/163] target/openrisc: Use tcg_gen_addcio_* for ADDC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-128-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-128-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/openrisc/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 7a6af183ae..c9856fdc88 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -220,8 +220,7 @@ static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
>       TCGv t0 = tcg_temp_new();
>       TCGv res = tcg_temp_new();
>   
> -    tcg_gen_add2_tl(res, cpu_sr_cy, srca, dc->zero, cpu_sr_cy, dc->zero);
> -    tcg_gen_add2_tl(res, cpu_sr_cy, res, cpu_sr_cy, srcb, dc->zero);
> +    tcg_gen_addcio_tl(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
>       tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
>       tcg_gen_xor_tl(t0, res, srcb);
>       tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


