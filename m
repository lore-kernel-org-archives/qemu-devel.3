Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CA1C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2IP-0005zX-8k; Sun, 26 Jan 2025 08:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2II-0005pU-A2
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:03:23 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2IG-0000zh-Iv
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:03:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21661be2c2dso60012925ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896594; x=1738501394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=19/VI50mVi1ByTLwJm06YaM8DdNpW+3HZSwVRS+a2PA=;
 b=d6RF7EZUSq5c+12hGkHxepskSjSjPfvB+5BPyljvuic25QzaT1kUlE16q6nlLrsaOa
 aHBIfIVf/FP4qcJzkmk//X8oN7AcKhZzUe4Ro4K7aEBPf0enB7f8t84/gVxNWzmPX06y
 t5gbNY4WCgRXUkS06z6xCMHrX70yKw/0PiAi8M6Fi1DhlZekAwRGBvrReSyBSVrz/HSr
 oNHSfsWQsaqBDvCgv4CjeYyiWQLBJJGSlI36bHuWwtHh5BTOJWmiR+oYPOQf2y5U/mRR
 ydoXTtxVxloXympg6du1Xsu+k6JfLZie5inHTWjdh2QdVfaRkZEmYIP09LDonL2+LK4H
 T6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896594; x=1738501394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19/VI50mVi1ByTLwJm06YaM8DdNpW+3HZSwVRS+a2PA=;
 b=C//6Nzv1UpnsYhDLumhcIsspk6KwjPdEnAV+AVtP/rmO2vsMXkRbijpClcXcDvJwgy
 sov06euQm7pmQm0dEeKDh+34/KM0Zq2V5SS2VegaIBFVW5E41IZaype8MqzwiBWTrS/b
 4okBoqDSIxVXLWQ6h9SAYA8G2qfW8IDcPiFutsMo+J4UxL/VAiVKRaYgQc4jYHkllT87
 NFO1FznWhzbTnrHkNNBb19GcuQtH52QVePq7AxxoH3pAgm1R8GnmxIOVBa6GFVxUzbGk
 1Yh7WZ2dxrlge9eBQpI5XNo7Ub/iUl3MCIJLo7PhLoxxxiC+7pAb/Cnw/St0+uAhPeUx
 LKqA==
X-Gm-Message-State: AOJu0YyPJEicK207bTiscw+VuWSs0tA/mlXvo88ZDnWmcFHLljL62kM0
 L3BQ4LESYk+UdX0PXVeeiVVitiqOixlBCUYxes8H+C3f6KnQA2ziCgAYkprhStll9enWj79CpuB
 u
X-Gm-Gg: ASbGncspOghOD/eVbE55c2ok3IR6MiAgLB5RFzI3j/8V0Ogz8pz1VYsagzWid6fbpj0
 OMMcR66cXpE7ES1WR2ZsRyGHfaSshKBdUIqpVkyNgoEsgGlUaeJfJPqBBenvu4kv1Ymiypaq090
 t9ys5ycnaJ+rHBOZREjqyz/6OCtZIg5ADeRhkKy1MC6Yu4T2Ayv568PwOsOqTtlII+vAcmzZ40R
 UeWMU3qtE4AaQlW2Yk84KjfyqXp6Y52OQ6Y1QuoXKgfdiM5SoxHxcUYHq4YAyYlu3+7l239867o
 WBvpAZgEnswet4m0GBaD0zM=
X-Google-Smtp-Source: AGHT+IHKoKd+bgNWJCSFlCXCSTetOtMVS/2/qtKfLwxZ2GLdqzHfpEiSYBSxlbuohsj/9uHBfHyV5A==
X-Received: by 2002:a17:902:e851:b0:216:2bd7:1c49 with SMTP id
 d9443c01a7336-21c355639a8mr583424995ad.29.1737896594628; 
 Sun, 26 Jan 2025 05:03:14 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9e1casm45100535ad.34.2025.01.26.05.03.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:03:14 -0800 (PST)
Message-ID: <3c9716a4-6684-4d95-9b69-2d886a37dea4@linaro.org>
Date: Sun, 26 Jan 2025 05:03:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 54/76] target/arm: Handle FPCR.AH in vector FABD
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-55-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-55-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Split the handling of vector FABD so that it calls a different set
> of helpers when FPCR.AH is 1, which implement the "no negation of
> the sign of a NaN" semantics.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.h            |  4 ++++
>   target/arm/tcg/translate-a64.c |  7 ++++++-
>   target/arm/tcg/vec_helper.c    | 23 +++++++++++++++++++++++
>   3 files changed, 33 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

