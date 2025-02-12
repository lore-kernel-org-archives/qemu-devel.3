Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94199C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGvj-0003xJ-RW; Wed, 12 Feb 2025 12:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGvi-0003ww-MR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:53:46 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGvh-0008Ir-9J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:53:46 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f62cc4088so91671755ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739382824; x=1739987624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JW5v3qdp/VstOerzTvG471Xa0Kv40UV8gKZ5liJpQZM=;
 b=epwoKyA2bVArV/2heMMwFVRJwD5YksWy+pc4gozkSWWjcY1SS0umMG7EZfZdfN0XD/
 lUcfoUW4Br7vWiG0JbYp2tsmDi8hpsIttS1zB4HAUYhvLeS/F94vj5jDpEfKFjXj1Bh+
 FUi9rKHtb3e07qSg892Plile1n7HZ4JB2O6PdoEsYn+RLYXCbJ46mu0h1gSnLLjlZCeu
 uymwOzY26hAj3I+RWcdy5XtnpCAXwWvgbwq/e+/tpEAuRJ3FX7ek2jVL+Az4z22Vzduf
 1WMxPyAYMbXQZoiYDl72IAUYC389leE+ETdhwUr1h8Yg5fICFQ8TLhDsy05rAKtS4QQ6
 wWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739382824; x=1739987624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JW5v3qdp/VstOerzTvG471Xa0Kv40UV8gKZ5liJpQZM=;
 b=A3zDizeSh7jQhX6M3114+oPo9RC9gYXG8sq34txCwUB10lwvb2Gck0+sGibWe6QNxh
 3EDW8uTq4cQQ09ykF7/uHdDJlAaI7/+su3FPQQ3t9exdT/aKcAwLk5b9h4k9C/L8nCPk
 WAHK2ktdKErAUdTSyx+P62U4OTd7Xqop4PTcAMHCdmz7MoztboIyP08bArsz8xx6rHk3
 RMiACfKyWR4UIYQIka76gSvdGFAhW0lQX97STd9xP21fyE9KYyWaYCG0G75pOtw2rqWP
 nwCrFVkrxRTy/k+gMCSzIVYe+vWykVFRzT8D/X1XUNHTWuODrmQKXQHHlc8m7VnGPxwq
 MgvQ==
X-Gm-Message-State: AOJu0YwJYQilyBG9Mkexl1pLNcFcewc3mmxQpzwJ1kObhWIN3zyTwlfm
 hDDSTnNs3GRxXUnwugJyepSWg/PPmT+r/f05RzJbMeAWyeiayM3ICpcGc/2U2UwGOEsk9CSk5s0
 p
X-Gm-Gg: ASbGncsddHEw01UrM30UWaWonbx+A9o2AkEgHtUU/UD9q7JTru4xVupkRIpW5r0gAn6
 scEU7OQLbCRQYF397xlfs3Qp7UW6LkyAAs+d1TfJ/5ddbuV9NRw/U4w90dSXMAagBoax1j/i6Bn
 HGHLK101NO4XcP4roNJOBPu+p9yZTSx/Re1q+JvZh9D98uFlI4BJ6dGwYupjA5pRicO7qX5yvBn
 fUE95MYHOn4ZRD12sTfwLO4mv0RAmwk4Jq9wUi7ilAG7cOmkhELlGYjHgqe1fdWcIclRMAzdniH
 2kEfAbWIIDl10QWu9kqZ7FZwm6gI9SotIQ8q2EwWLAEy806k0LZTqR8=
X-Google-Smtp-Source: AGHT+IEJRUX7ke9c3oMUFZgMNive328Wm/sh5tTZXgYyTy6dwqK+ar+QIkVIm6+oU1y9gubQSlmFLA==
X-Received: by 2002:a05:6a21:6001:b0:1ee:6a96:34c0 with SMTP id
 adf61e73a8af0-1ee6b3ff8aemr531845637.39.1739382823756; 
 Wed, 12 Feb 2025 09:53:43 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7308d31fe8dsm5940714b3a.169.2025.02.12.09.53.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:53:43 -0800 (PST)
Message-ID: <6fd5d9f0-3633-420a-8a10-0b4f145958dd@linaro.org>
Date: Wed, 12 Feb 2025 09:53:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/pci-host: Mark versatile regions as little-endian
To: qemu-devel@nongnu.org
References: <20250212113938.38692-1-philmd@linaro.org>
 <20250212113938.38692-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212113938.38692-5-philmd@linaro.org>
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

On 2/12/25 03:39, Philippe Mathieu-Daudé wrote:
> This device is only used by the ARM targets, which are only
> built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
> using DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/pci-host/versatile.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

