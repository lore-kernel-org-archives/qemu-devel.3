Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C6FC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Raj-0001io-8c; Fri, 25 Apr 2025 18:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RaE-0001HB-9S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:31:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RaA-0005iC-H7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:31:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so25792945e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620301; x=1746225101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GbVWYqdOhsJLdKAjXd9ZwdSHKBlxNhT6Rk799iOQMHA=;
 b=tQRXLqEFO+OfWkXhPZHpSeDgJoZ43Kk/8bHM1GUCcPkkpLkXkMD7yRS23RMJz1ouYM
 hoAEdsE3G5GSPkI6sfUWhUJtMAJ9Zp6fmP5a9/NRl7YwO9ljPvSoCNcHV85jHixbZd+C
 6DfuaIp4xGJmBIUyTBXq3xyXKjOdFHg3/lDs16Fxj6gVT+Ct6jb6T5V94IdKc7IpAmiM
 pnT3g783gUdwsP5cXiRCgkUfusp6DUtHBN3A7p1vu8Sx4WCBDpLuZVG8tUIqVefDdbE0
 S3aOHI8Vq8ooTy4/eG0gMFNeXsNy/UNAuI7mKj7icPln0ZMKVtY4BD5QuGYyZM5Dkli+
 M0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620301; x=1746225101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GbVWYqdOhsJLdKAjXd9ZwdSHKBlxNhT6Rk799iOQMHA=;
 b=WlCS6M7+/y99xo12DK6jCyX74JUonZR/Us+YI5HZryGm+sFOz5SozNcDnCe0MRC87U
 W2I0Ozply1hcoxBivZ7wvcSvMAh0OXAFf/Xv8i/xDOh035tQ/b4YzQWrnP5CZCDDeM8O
 JC0HGyHpVlKMSbqDNMRO2MpaNceetO7NZIZw8NjqwHkXzYxIrptzQTUv5Ra0LGdIkzlQ
 X0gRZnKcPQI0cpxKP0Lp+K0uvzVMTGe3dwDkA9I++1stavA/nWbehk2dO4IDzBfsYEOV
 mJNQddrU+Tv3YXtYwtMHg9jylgbmHOrSZ+pMIbA5XuP2j9q7G7RcV8xya2MN/lIeNLt2
 QY+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXao4AYmSeRLjmVwhJtRAn2jCrvMf/YGA/KyOjAtvrEVwWs7eC05ngySJT54t5VobZ+W1kWjSpYoBwv@nongnu.org
X-Gm-Message-State: AOJu0YwMBjZ3INeToEjJ+7ATmSSfU4TIQr5amvQvEHl+rh+jpYIbLCS2
 816Mg/uyAl48sGbLCAPtLfC/cfsBu7DS/xolUJ/Kko/wlYomlGz9tYSt5KW47lFO8eQdu7LMJrg
 /
X-Gm-Gg: ASbGncutTBc9Rt8iJOGRNvjOplrFNpBKjQVdVc+38QCEljrPgB9PBWHDpdem7pk82Rr
 mbl0sLqwdS7Pe/V5gFnyNOnj2Fw2rgKV1xFCvObx3lzMqwWx2OT1ktr3JwXbtbWsO0S9UH6Kljs
 5tjXSZlJuA6lKZxJGa51cIFXbGMAjZ9bqmDwrW0pDjQYFnwECSh9cqviJ1dqyLUnASdtTsenCMq
 7dUbnZi1rjI8GDifZ/1Pv71BMmuTjFEIZjCMhfOgUWmqfse8FyMw2tmMhU+jU2MjSJ198XagCNW
 1NY3zrcJTmrdpAmHUuJ75AEEyKD+SPMURVL892bpazZHytie9hzRfNb2QtI/58Hmx9Hb8Lv/DW2
 Vo30uXCXv
X-Google-Smtp-Source: AGHT+IHHb+GnRcXoRanCuJ43ZASoW1XboK9LCsPuLA8Fc7R2WhIQZ4l3NKA0BqITCdgZj0YGIpZhzw==
X-Received: by 2002:a05:600c:1e1c:b0:43c:fb8e:aec0 with SMTP id
 5b1f17b1804b1-440a64c16c3mr35887685e9.1.1745620300921; 
 Fri, 25 Apr 2025 15:31:40 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5311403sm38015725e9.23.2025.04.25.15.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:31:39 -0700 (PDT)
Message-ID: <2b0975a2-ac4c-43ad-953c-40debad1b71d@linaro.org>
Date: Sat, 26 Apr 2025 00:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/riscv: Pass ra to riscv_csrrw
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425152311.804338-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/4/25 17:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/cpu.h       | 8 ++++----
>   hw/riscv/riscv_hart.c    | 2 +-
>   target/riscv/csr.c       | 8 ++++----
>   target/riscv/op_helper.c | 4 ++--
>   4 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

