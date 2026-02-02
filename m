Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F499E73145
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 08:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmpMu-0000Yb-Qg; Mon, 02 Feb 2026 03:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmpMr-0000Xl-3M
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 03:33:09 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmpMp-0002In-5I
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 03:33:08 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-352e2156450so1962114a91.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 00:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770021185; x=1770625985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3Q4pUB6dwT1IH4kBQRSDUrBIsszIM8iFAFh/q+9ldk=;
 b=MKIdr1BzlSBSCMuo5yMvQFjJNHyTg88BbToUQNJ7UhuIx3gICLCPMdDc/UD2Rn6l7j
 Y/rAGO84cxw8X7yWitquJXQWPs4SOUOtM1JYOg5HXdkJGhbEsuFDX7/P6vfrB2iBVIdc
 1a/Jcs9ppAhia06e6mvD3pTvKe2ZYbUjdBeQRvyBWydqhKmpEJ7omJvhmD2mojr768Z9
 r+CAdU/ixxq+uxFb4W/KodGLe17FJmrL/7BUHWurNhoH3B3pqXV/e9qlSH2SplznEAlR
 IG7dG8KaDTw8k5G1k3dZo4tBc69e9uOGKb3f8FQ1m/3mAwzoBxQiQMOa5kMMIL/umfhU
 gsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770021185; x=1770625985;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N3Q4pUB6dwT1IH4kBQRSDUrBIsszIM8iFAFh/q+9ldk=;
 b=dNRKu0t7a+hgkh9KE6qBuPDiWdDbFCIlUily5xXAHGj/0FmVQSvX6edcxmz4qj/sIv
 RjjPetUb3LuCAV0EqnQfK46sgSJex4HIOlG11t8ypy/FIhKxBXF6MuLkTMeOXqq0rHd3
 rGVrq6vWPeScUPKwEIS6h0iRZVmuZOI2ZEbdQUug7sSsiLj03/s/BC4Bq9TniDi5VXIm
 BCnaPGdSOStBZ+Wx49frkzdUzuvgs+DjYNLItX7wB6xwfeI9GIfKT8wF3L5QebY5w+Hk
 zVjnIUNP26L/QyMkPi4HbpQgKsLItHXIh/CcAOQQY5kwVGnJhiCZOqcx9CFTuUGEQail
 p8Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf6dudBvGHYEqEDdTD12abSodwgsGAjqgldCxwPJZ0F1rGZFgOZRyW2aoybQ4vUN3Tg+h8BcUT06cV@nongnu.org
X-Gm-Message-State: AOJu0Yz0teKe4A8XYPkTURoYfGo5mVfDT8JUm47sdAC0sP6lSSAcEFHu
 bGnj+7tV8lNY13LlW8vPxA55ragrWgHkgHRzXU5xxO3xQCGbEEtolqs08DvzMD+1P28=
X-Gm-Gg: AZuq6aL8XvsUSJ4vx0fR66px0dQfQvwquU1o3zjX+KjvSwh+icp1RObhsGO178AiQiL
 6vJLBzlE06iQo281J/OxAue8p76zfr317EuRVPdesb+0LdFTCuSOdT3ctnn8jFqVwnU7IYFl0Hr
 qjnyZCe+Zjmxqp1BTj5JtQeAsIg/YcUGXreaikBgzkA0cs1JYXZa72zP1pTWWxTzwTY//mrM933
 HbjC4zQTK0yisEhOCrsuU8iS1yA7B3rAYp2yY7jngKSe4lkujrB5qnL4NYOxP9A2sSM37DBpWgY
 QUdpOvtAXrKrQacuM63kJbaPo5xTWuMF0QkwUCz/n7d6H25b991UX1msDiVeHw3FrBI7Yne2Dyp
 aHfjaRY7qDcLpe48mgvWO/DaLsIi696rZBgIGbGSwtt3Hj2ViRbMYLtrPtmilckqbab/jVFzO6x
 ioP4arpdQU+pYNxLVPgb/G7A0rUFzMSq/TEbcbZuu7uIFViT8U9UzOdYKmASNrFtDxgvRhSEEeO
 1t+ThQTKFXzkr9Z6XU0tnJ32gG8gOlA6FwZOmZYjHoOrBGJi1Vq
X-Received: by 2002:a17:90b:2e41:b0:34c:635f:f855 with SMTP id
 98e67ed59e1d1-3543b2ebf18mr11259814a91.7.1770021185299; 
 Mon, 02 Feb 2026 00:33:05 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 (bg30dj08q4s9ql12qb2z.ip6.superloop.au.
 [2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3543be52017sm5001663a91.2.2026.02.02.00.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 00:33:04 -0800 (PST)
Message-ID: <4f4d1b91-0747-4cc4-8813-031741f20d41@linaro.org>
Date: Mon, 2 Feb 2026 18:32:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/4] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, j-young.choi@samsung.com
References: <cover.1770010668.git.jeuk20.kim@samsung.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1770010668.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 2/2/26 15:41, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit d21a442a5ab9bc1597afea13f01113d5bb3e772c:
> 
>    Merge tag 'pull-target-arm-20260129' ofhttps://gitlab.com/pm215/qemu into staging (2026-02-02 15:04:44 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260202
> 
> for you to fetch changes up to 94e72135d4d657d672561b1ae02a5854421616a7:
> 
>    tests/qtest/ufs-test: Add test for mcq completion queue wraparound (2026-02-02 14:33:46 +0900)
> 
> ----------------------------------------------------------------
> UFS MCQ fixes and tests series.
> 
> Changes in v2:
> - Fix additional endianness-related bugs.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

