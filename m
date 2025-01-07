Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A284BE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3qw-0007fs-0v; Tue, 07 Jan 2025 02:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3qs-0007eN-BF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:18:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3qm-0007C8-Pz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:18:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4368a293339so119076045e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234282; x=1736839082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KX6wbuZiK/w8u2O8jAl0PPK3V7Wv30Ccx1D+/lOAPq8=;
 b=MaiQVrIcJEYihkBIARcZyulrae5bcc73wCwRHJpnVjxgr4kbNQK55ZlDiUiZ0HG8Ly
 NgL3WnzPjqn/YVhQTrTD+DF3vW/9FW19br2D95EPWk30tWOBKvayhOGQteCH1tP7We9s
 khFz9YKeXcXf+HXiuqey4dTUj95QuvsZbDMXa0KNISBvXjTCsR5QVsm+0V77Iufd6KBR
 +Iv+9iFws7xuzWbQI4Y+8ye9bxMgxX0Fc74qd6zy+WaICDzYC/a2RB6KJ3X3QOxl/CnM
 F9i9JtfIce6DN4zU9HGS2/dbnNGGAqGInu5+SIs32VuSn+X9NHsHWiYNPuyBmNodjnOD
 5ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234282; x=1736839082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KX6wbuZiK/w8u2O8jAl0PPK3V7Wv30Ccx1D+/lOAPq8=;
 b=WPC3RbFH4aSKxTQgcj9tBoBHtfamMH0Z89TpSh8Mi8kNEgsKTk3HqZH+jIywc/doyP
 wW7qsPXW+Ydz0rNul4K2/Rs3XwF6O0Hvk7L3jcl/MKIx12iMgkbwcXB/2PKwp+35yUCU
 rOcMWMvZec6XOfsJmSzAns1X+o3/IgkKa0asP2gjzrF/l42HaRxIbN6hwWEgfrO2DpKr
 XpRi91hG7JlYbzcKiyYnDcBlsmIpbOP9fVbVt+rssQEHcx4bXSnngjhF7CmDsq7E76tx
 h2wY0Q4kf2VMXJgdHLBMS9ZCRsB37HHvwqgG1git+shLXq7E+SSTYL03leGwPGDtkhq7
 7C3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTZ+wvqpcHvLIgI05tHq89/JOqRSHsoJEQkiuv77JxrMFoprn/7AhfCKhfnyytH3PYar4RLBPXmbx0@nongnu.org
X-Gm-Message-State: AOJu0YyUeBlTIe4rk5mA9kUw4r0Vq6B0BYxRePuPPuUGA35chtaulwz3
 fvH3SkU4WTITdZz3aSlvF8IyndQOkncz2VOiOXWm4XmnYu0PA7ONMfmB1jt+9Q4=
X-Gm-Gg: ASbGncu0tFkFGxMLPvyQrhzeMhgIOaibjB/RnlWZqV8l+p7+yyA7nL+Q4PSMe0QKp0z
 nzEmBGcziRdSOhsfaeX28qplAwGzCuiqdm+zYKQ9Kdyd5Cld71ec+ElvIAVjvlQK2XO0NTUqaio
 XisLQHluSPUZf9hjgaQ6P9eXogBl1XEjcNf73krJWlVPSOozvjOfLo4gjH9tXPNuZsBs1g/ta0s
 +3FzKVrryLKgWgvbImd1kd5L0Z+SbU2nUlbKeq7ofDwtZAYUUSADBGBBdoiEe73nWDEOY3Go1JE
 QZaDKxX8uXvCDJQb90jRZ0tW
X-Google-Smtp-Source: AGHT+IE4QnsWMTgLSs8vPXmbF+OgzkYHl6xqN90uBHTKirPo5hSOphMKm/AMKNH4GiVQrtwZMQJ5VA==
X-Received: by 2002:a05:6000:470a:b0:386:3825:2c3b with SMTP id
 ffacd0b85a97d-38a221eaa0bmr37495106f8f.18.1736234282189; 
 Mon, 06 Jan 2025 23:18:02 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828989sm49697244f8f.18.2025.01.06.23.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:18:00 -0800 (PST)
Message-ID: <b089b60a-9d01-4508-81ec-73a2bfc38524@linaro.org>
Date: Tue, 7 Jan 2025 08:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/73] target/i386: Use tcg_op_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Do not reference TCG_TARGET_HAS_* directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


