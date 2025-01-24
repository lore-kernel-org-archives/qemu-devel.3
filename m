Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CF1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNEw-0000Qv-FL; Fri, 24 Jan 2025 12:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNEu-0000NB-BR
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:13:04 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNEr-0006D8-SK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:13:04 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21680814d42so40060875ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738780; x=1738343580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3See8692uOXsgoD4hTZPnV+EDiPYKbGbZx4LsYaVUY=;
 b=yjZ9JoOEME8VBFD4IZ12nbdDRROuKt682FPeJhjJw6Xh4+iincpvOGzlImQOYYPACO
 JvfmNEkcE+6xpp7MmDi6QzLgflsrDMU4JwJx6VF5jBC5+BAt2apYsf7WaTgq1G00BiLd
 rT/0SpxuhY+uxy3udzeuMxh9uI3rAa8e+/GhtXT1MUcUdaTUo4SeMCncJxpi9984qSv0
 u32Y8pkWkSRxoa6LWxzoBFOwqKeZC0n3ef5BT8ZxuITehQqJq5rLQMrT7yYCo2j2hYPJ
 rvzFOFhvNSb2Jzh1JrxQyxQbe8AW+XHOIFYdMI7eM1D1xgP6CHB8cnVYZ/lBXx9d3NMM
 5DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738780; x=1738343580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a3See8692uOXsgoD4hTZPnV+EDiPYKbGbZx4LsYaVUY=;
 b=m/g5mEakOwGNwn+Ycw4Zka0b0s0MmYDnKR/s/+FAudGEwtHSOUEuqNzGZK5ioHHXcs
 fSb0+yIaoKFNGG2I1ZtsAvc4vjlI8LwY8Y80IeafcgiMJGOJxTK5jVpqBCxs4OC3YGQS
 s5OPp/0pzJqHi6jo1T09SUbgpFZNAqT/G+pFFLZFsH/gKw+3GwGTDwtXPh15SOi0MHHh
 OElbL3z07B3o+3/k9KQ4kXAVyVhhCbxKylnHYOEead1OV3g9ZvEdx/Mmog3zqt0gCnMq
 C30f2YmKEdvQkiEPA7ReZFbHH5ypNHhfH4mjcM3PlUJtl6WP+5uEH3n3R3Z5WYjLwOKI
 DbPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmX9E9G5jPGOsZav/h2t2UZcmPn/twdIhtLkbDI8mjbZdI5Ds2N4LDpRsPx2XFuI00ieE5XO+fgfEG@nongnu.org
X-Gm-Message-State: AOJu0YweGK4eYBOds4jEQVhmpgkmR/CkzjqtGI3MhxFnkAcEEwF2ZL/P
 PkETf8Ys6o/7aeHkIf/GfW1zfz3u2xLmzOMwBjx25yQjz4k+273Wrci//UCl0MM=
X-Gm-Gg: ASbGncuzzD7LyykKGAPTV+tE4K0sWDHtyGyMx8/mxgPeZs3Y+3RlkwY7jsby76s7WCR
 tHfFDhjjq/GE9ggv8Tzx1uD2hsWgrFtszWHroZm4zCImO5xac7nRpGBqBH3UpcS1IsAvJuBEkMw
 zHg979qmk24hFsLUf37g2FxHWaVjYxcveHD3I9KDS03/sxoAX4OjhklzkTsOT8pb1dGPcZayA6D
 eoW6GUMEZTsI8KWwgUah9WsX4vFqT4OnrqOY6luPPuTWVTSBVmWXWTwz0yxZtBkpIJa+oRmi1ty
 hN4LVNB3AlF8TwtgvAQqE9j3
X-Google-Smtp-Source: AGHT+IEOBVe7oGUQSUh1Ypt33Si5xBrKDElfvjQNcuTiXK35wObz10sd3AopNEaCcNanCleTDY8/Vg==
X-Received: by 2002:a05:6a00:4615:b0:725:f1b1:cb9f with SMTP id
 d2e1a72fcca58-72dafad530bmr44733377b3a.20.1737738780438; 
 Fri, 24 Jan 2025 09:13:00 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b324bsm2194511b3a.62.2025.01.24.09.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:13:00 -0800 (PST)
Message-ID: <27a14c26-8afa-4ad2-8ce7-7696adcb4537@linaro.org>
Date: Fri, 24 Jan 2025 09:12:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/28] target/mips: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Move has_work() from CPUClass to SysemuCPUOps and
> cpu_mips_hw_interrupts_enabled() to system.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/internal.h | 4 ++--
>   target/mips/cpu.c      | 4 +++-
>   2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

