Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B51CD78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI76V-00051C-3j; Mon, 02 Dec 2024 09:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI76T-00050f-H1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:08:45 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI76S-0004u5-3r
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:08:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a766b475so39631145e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733148522; x=1733753322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sJsbVBbT7C9ttAMdgNcbdkObeksp2o8Bm42drA4g7zs=;
 b=QU6MkLc3EsNGjesM5Pez44jqfzGkTr+m4e04t9R6LQIDUPI/rb8dJZEa5F9ohKcdhd
 sIb3fD90x1fY1IK03lDg0UY+HCMWPuWfUp3Lph1CYlZWrb43yfhuv+Eql8AWFF3icL/n
 RVjn04fj4x8/kerDzONL/vkUvhWP4S3OZskJfvIt2PmLwt0hSOIcQhG4O+dwXB/uV432
 VQ1rNfYhLX/91/16FHuAfpvVQo4lwh15KPSO/jWIk1gEcn6pnz5UNJ8hBOYBlbR7jvXi
 8QsApDltLRHSapjMZtWz4CBu/xSt6p0l5uDTvIwL2ngiiSAh5O7ApPPGyF1E3eSDiWXX
 QKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733148522; x=1733753322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sJsbVBbT7C9ttAMdgNcbdkObeksp2o8Bm42drA4g7zs=;
 b=PbASJBF16ha+syTYUOWwAxeqItzgBKbpMWy5CbGj6Pxx5hNA1pqaDxkzB6njwS+nV1
 1rjVHDg9zdbZO4K2dnU1/M7GWIwvPmeybd/J29CeJIQaEQdQxW3OgM32wH7qvsu/faqD
 7a12vTTamwP/4S0oii3mYRTpSNDn/bVdNpQEe2J1k2I/OTgL5UX8TmiiMy3IQveFhYdS
 sJSG2918KXogzcb5SCqiOwF+SsUdAAVLZ3mD7YFV1NTwzmZkgnYfR6kLw1X/IKhrRWgw
 ZWX5rhd5bIMsAfVwclDX8/IY6wuWIwEG4J6PaHhvZu2azL6SjC9ktxAYcqIQQ+LzdWwd
 cCtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGQKbPz3QVKf+wn6I9NoXyRvoCOKJzqf3OCzJv/B+RbB4FG24NZrDBMpzyqQXqJRbFpG2KdCYTQVYt@nongnu.org
X-Gm-Message-State: AOJu0YwVIVrqSK0NwIskXWfrrm0zxL9aTN3klZFFHBzGBlGqJC3DTrZZ
 4oQjDeXWLMofVGCZqbTIqP0ogSiTXRI6RwxYYEmD5Rr831aki1UR3t8eWljzgJ0=
X-Gm-Gg: ASbGncvCm/1kYWGSouktlAjifs/lbF9OhV2k0KwVerKD3/y5JI5swMrQWPfT5ZO2rdG
 6FjUVXNXWxRUTIJECvxdMDlyYo2Ybu2GvsPwtVowE7v/gGCKZK3XqMxdarV5l6+KNLGu9ulfhH+
 yE18JP25EVd4E6szFiglqkvySpj479Ii/yXqQXNrCrjAlkpu27AcMdtgWcMDzIOjLv0X1h9v/iU
 rWgyMy6TGsxrbKN3TBsaIPZomVpkZbFRNBLVsOTfmnqlXOl66LdiSB6dV9/NMxBLGYYqwZZpL/0
 c8v7vT7w1YVAmdlA4T+I40FZmINpPw==
X-Google-Smtp-Source: AGHT+IHQ2GuF3qxfGSH37J1KVauOVKbVX+TKRmQYFLXfPiFgcJgZAngkVXMmR6eHCRY9rtLokqonlw==
X-Received: by 2002:a05:600c:3596:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-434a9dbbc00mr203939275e9.2.1733148522354; 
 Mon, 02 Dec 2024 06:08:42 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dbf9f5sm151960665e9.16.2024.12.02.06.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 06:08:41 -0800 (PST)
Message-ID: <85d253c5-3d25-41c9-a6bf-ea6ecb6b2049@linaro.org>
Date: Mon, 2 Dec 2024 15:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/67] target/arm: Convert CLZ, CLS to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 72 ++++++++++++++--------------------
>   target/arm/tcg/a64.decode      |  3 ++
>   2 files changed, 33 insertions(+), 42 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


