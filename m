Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D35C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Rc6-0004Q5-9X; Fri, 25 Apr 2025 18:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Rbt-00045k-JQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:33:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Rbq-0005ng-Ov
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:33:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso20485095e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620405; x=1746225205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YyT5TWfRI1CLPsZr26VVfA/aqL9HO8wqqzuYOJ5k+cc=;
 b=vWA4xJH5z2kcHC4lld37txIu9XtWOFdJhLBcKFmrxEFh8x+4V6XuCwutX5Ut3feaBL
 +rMa5EknDKD2FLfi8NUqjLORYQ4TikkXmMgA830hoPffJBVLMOaN5M2QDSoBb7tOk4Vf
 IQtMb+NDs/p4zIXOQU7JsmXNI8al2HO3g+oyKDYCpglGegACyZpieAitUh2NBsKcEuyo
 CTpSrCVrXj3VUzKy5YNqrp3Zc2tG7xm4uzGrAUYjgDaFG6Vu3fIhw/mvL88Rkf7jMkA8
 nk0rzlPPjdIijnoUaKdczq+2VptA55c2HHNuVtS2mSvrcnUUectCm8xFnQB7VR/Mge8T
 GkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620405; x=1746225205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YyT5TWfRI1CLPsZr26VVfA/aqL9HO8wqqzuYOJ5k+cc=;
 b=tJyKtaiu+yQ5G7Zkk/P9AznZhoCSjoP49rddErLZCUMABvOpEY15NIutMJogF6X5Vi
 hj6vEzK86XHQT7Cf7Exr5vGldfYFFpe0uWl5vn63ht93XwGhlocjXQRwR0qznX+Wxvsk
 6w2TvJgK7Mm3tKaE2eiqLKnlRZCDVcmNwlMTkIcKhWzl2kgV81BacUfzDDMn94aD8z3F
 Ig1m72CTSKGJCBDIaZp0+ejDhkFKQrqeqaKaLMvyamLvWa8YCkB8/grgUTJGQTk/EvqZ
 ubyuKN5ttws27MvTaQNkd5Z3OZe7bZequx1Bx8zKMj/ReYma7kfPfb6bbPmP4LGsZiab
 YXxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9oql2oPEHjuF87pa15kszc3Pi6BhTOP4AJNeQooP5z0oadGpkrGPfrTDXikIAJvCtEmbv6I3xjp6p@nongnu.org
X-Gm-Message-State: AOJu0YxiAs4keznvqPZY/7GRjOUULLxwGBT3i1TOyO9KnR4j8g1VvQuE
 Bmf/7sI9W7uoGrqbanuS919tHq/h7CJf/cKsvnC/ZIAzBQI2ZC5oc3cMaCUx2rA=
X-Gm-Gg: ASbGncv5X5U8D8EVBFszPEPI/g5lJSnI9lpiRGo303YOAsiui4/ZGNSgWh+WR9IB0D7
 rsJxUZLmxi5o2kxxwi2OZ/CIksYkj/xdzmQdAFzNPls3f2ehpbb2P0814ijbKz3eROsOK/rmvIw
 Xr9GgVkT9ayWSLm2u77OHkar8e4fLFzem6AsyMki50inoxgL8+TtKCTjrtzguvs72/vTt6woaQ0
 uRcwU5W5i85e3pP4qn9zw0ROIln5qDDNkSpn/iKT90d49tsvTy15oujaEj9/rIJ4C87Uq79Ywct
 kBkp8sKSuf3CPObTHe2jL+dS4GpB2RSgy4Fxlwut1LlPe1CYZQZnoeY6ek+kRDZzBkRQ5Strfg+
 FkKRVXQk+sflmzlq9kFs=
X-Google-Smtp-Source: AGHT+IGM8Y+W4gCJ0qb8rs7zIZMoXDIKfZ5Oen2vT3qF0dWZ0x0ka4A0vsYC7XaFdTIWbLvourVplQ==
X-Received: by 2002:a05:6000:4282:b0:39a:cd84:a77a with SMTP id
 ffacd0b85a97d-3a07ab85dd8mr608064f8f.37.1745620405069; 
 Fri, 25 Apr 2025 15:33:25 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46981sm3555675f8f.66.2025.04.25.15.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:33:23 -0700 (PDT)
Message-ID: <21574198-8266-4262-b5dd-a9e23d46201c@linaro.org>
Date: Sat, 26 Apr 2025 00:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/riscv: Fix write_misa vs aligned next_pc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425152311.804338-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
> Do not examine a random host return address, but
> properly compute the next pc for the guest cpu.
> 
> Fixes: f18637cd611 ("RISC-V: Add misa runtime write support")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/csr.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

