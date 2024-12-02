Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A833D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9Mo-0006wC-Fn; Mon, 02 Dec 2024 11:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI9Mn-0006vk-Hj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:33:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI9Mm-00023V-0w
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:33:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e5db74d3so1553692f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733157222; x=1733762022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E6bWi0hV0u86tHnyEyjfthQ/EHZlzOgl3N8j1p49Dsc=;
 b=TtX1nd2rCxARTi3kaM+lvKdeSkWhGLyerbeceLz2wVlCJ2Ke5hl40FG+kMh42m18CB
 pv7UidvKv1puQH3Bpl/VjSHDMgmBZkWwXJj+c4Ln/IC4j32FtZ7aPcGPMjOO6hOKO3pQ
 wz4AwqdlYxnCfvoPXjXBlP9+vilDI63+epxj04krjd1GS595b0poljjHzUZ/7w4R8gkN
 LIuP18RXNByLQFupj3WVIAecbjKAD3uI4PoO88MxX7mEvqHkxBL5z1Ov16kdPADNKcr7
 LRJjHk6LL19Rmm6s045Qm+iAnd/CpU5mfc5Nx5tBwLw5t057p3nKGeYqw5cpxsHO60kl
 y0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733157222; x=1733762022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E6bWi0hV0u86tHnyEyjfthQ/EHZlzOgl3N8j1p49Dsc=;
 b=cwts76Nn6smXXD0f4tXtMB5DPyaADQlC/UjHyPPjProL6ppKbHvhRDPB0yQhiC8+LH
 um8Rz9xcLC2s0OuGdYOOlhhlxJ5p6bpnZd3j1EARDgKw+r4X2+mQxy+QICj1u1RVczFn
 MCpUYbXTy+pw0qgGgzVZRuGpqiHsSRbOc1Mf+cl6WbA5Nc4SmO6aWq8HFoZMAsAC9nfd
 ywMMkUQXY5A98Z4NthyHZzqQW52r25XygGXjLdgNgO0JMWsjmdZp4KeSmihCkET1p1zY
 8fVN+d2x1DV1Kf1rojWZr5nin+57e7FcrfBOSsnOYHBvKK8cpEXvbROUJ9mb8RZr6DcS
 hTvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0IHWgNMWfyzB3TyV1PW8mYXS1lyuzle0YfIXMoUYlNaOtrBT6bA2NBGYlwvhp+QXAvvSQQ/MQ7o9m@nongnu.org
X-Gm-Message-State: AOJu0Yw/pH7hB6kqo7o1Fh92oUBax6yzPZoGX2Yrm+hebvni0lC6TglX
 /0nobp9TGWM1kla+XBM/Y9v0SsCsPKyGNp3ASlIzpGz2A1qIeYICHzVkJdkk4I6vudUUkviHrq1
 YdVI=
X-Gm-Gg: ASbGncvaNeS5bx0BqAdGNtd7GH4Zj2yCay0fep2fgUbKbhnLjExbcOffe53AuHoqeFt
 AC8kVwVqeFsyXrq0A4k4XWejaW3Q/VxttCpzw+zroHUVOmOLfop3VzWNbRTzpGfP/OW0oUu7/WB
 GCKxWwEk3KGXM1K+af0qgise0n5OVwWH7OhpvMC1u8gywxFXzTXvW2qmCQkLvA9IyUgecwj3v/l
 24QSS62M8kjGhPUPQ/71xh1yGSYPARm0CymJj3qgbsBfvJkG9/hJPSgt8Bx9F1DN11JVZw5KZlS
 FIcoanj42ShcQJui42l2cftrWP1ddw==
X-Google-Smtp-Source: AGHT+IEMQcUUmSpZJce89qmpTe3APWtQb0rFX9O9KjJlMGxiHe4OlboVLsXd5Rb4EF73UeFRv67yJg==
X-Received: by 2002:a05:6000:1568:b0:385:e2d6:8942 with SMTP id
 ffacd0b85a97d-385e2d68a13mr7424822f8f.54.1733157222033; 
 Mon, 02 Dec 2024 08:33:42 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74f18bsm194172825e9.4.2024.12.02.08.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 08:33:41 -0800 (PST)
Message-ID: <0cbd29d9-6e60-424e-bfc1-38b55e1fa31b@linaro.org>
Date: Mon, 2 Dec 2024 17:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/67] target/arm: Introduce clear_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-48-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
> In a couple of places, clearing the entire vector before storing one
> element is the easiest solution.  Wrap that into a helper function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


