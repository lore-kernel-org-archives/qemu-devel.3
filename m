Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F3C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAJQ-0006NA-JF; Sat, 21 Jun 2025 22:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAJN-0006MI-Ac
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:20:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAJJ-0002b3-5J
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:20:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-235f9ea8d08so28911155ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558795; x=1751163595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xkVEyPUGzNLd0OvyQ7i+Qk0NeLLuogU4dy8/F+ARKgc=;
 b=DWu5+0aT+VXFrG4PEnSdBwxC4yXOnWgexBTB0Bo9t8Cl2BP2Og37syYwJ708kxaLGU
 HiJZPG5gzPxA/ahO2RScvKSXBDI+l4AUHbyHHZiCcjT/EPu1B0v65NYmPISt3Oab4L7Z
 jd6KS8Y2YpH/wDFsZ+cMD7csJa3gKvoAaRlWh36Cn/A5nGQzZIhiYQA4e8Hnu8PYel7k
 17JyNuOXtHgcCM2+2UJbCY1+aTYQ0CyENcH7aM7xx0J8lH0SBFHJtBvMxpMdKumPdvU/
 3fc2V/0gR4MueioVZ5ITf89bJxXKZPPA2c6kHlxqynV/PjaDhyorMDZxfQKsEqxO3ekY
 3X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558795; x=1751163595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xkVEyPUGzNLd0OvyQ7i+Qk0NeLLuogU4dy8/F+ARKgc=;
 b=pM1eMOej5I3lDjLUElTm865N5iu2OeIJMG1pTK38l8pF8m1ogMwIBT8M9tm1VXyMvo
 BNWxG+CZXXDIZp7Io0OHEQiZ8lJxa+ctIUdaZGO/P34cTkdYaCBqvRbby5M6dimDqIK2
 XPg+GJbdWyUu4AwWzev0VvntRxPmv4zrYKNVPPXMouTsxs7dZt5HGa06YDIygZZWgH+5
 0tGvOob4ODkc7XxOzcQ+iogY9KgWiHZ4luErOMjn1U5gLVlIyD+4cEeAI6mi9Twt5Skj
 /DGuZ0yoMyX0I+ePYCgaalv2UPrnoSV0kMX7oeTd2Se60xVz4j+3gRK/Hf56SCGl3QyJ
 x1eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyfyrHRH0kSjCPpss/azLLHHgko6Ylx0EAH/oBNLrZbZpyJq8twkjBbOpTMkbxjPO/5y9MbwD9KTiw@nongnu.org
X-Gm-Message-State: AOJu0YyweOg2BfYRuvtm2dJocw471jhGJNZDvZSHEyCIJjwApKG5rRN9
 mV6EJrtcecMtCjG+Qx0XmDeZVykOWgW5LzgjOLPai1iM547q6yNBcGpKOTaoSka40wI=
X-Gm-Gg: ASbGnctyjTw6V/+MwExDsYFrEh/HVO4pGUox3FeXQLGKti42wcFg1uqvoNiELh/w4c3
 2X1bF1hF0uUQeK8vD+NsLn7FELjor9b/IFskvquULx0Xk5fdbBceSCV5UoblScMYdQxdBkW2RZD
 QjZLWST1CHG6hHeKGYesonJ/ks5bDD9SYBj7tUul2S/NGflmOoPoiwZ70NWilrl3M+8vdXYpR9i
 6P+DwJ6OGJKxNASeBVKLmaOPGe5jcl7zUhzLxwmdYlAf1V4Aq2rZmM8VM4ih6tRk2nf4tI7ApEM
 ZvOQ1UR877QCTSrX40pNo1Clun0ZjCoXzre7YeK9QP0EXYoSqE0xyW1cyk4jT4kQDucIvLrw1Iv
 PQ5NL32c8yIBxoe6aKVJIvOISJOsr
X-Google-Smtp-Source: AGHT+IFaa/Nxi9/hhuhehhgjSimqLscTwkE4YR4HW5Xe62kq/Fhw8z0Cl4r+feuBE4il29uUq1O7Hw==
X-Received: by 2002:a17:902:cec5:b0:226:38ff:1d6a with SMTP id
 d9443c01a7336-237d96e3e0emr124088275ad.7.1750558794919; 
 Sat, 21 Jun 2025 19:19:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a226f20sm7428880a91.7.2025.06.21.19.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:19:54 -0700 (PDT)
Message-ID: <267e88f2-a2a7-442f-b2bc-73ec51bd1917@linaro.org>
Date: Sat, 21 Jun 2025 19:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 02/42] accel/split: Define SplitAccelState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/split/split-accel.h | 38 ++++++++++++++++++++++++++++++++++++++
>   accel/split/split-all.c   |  5 ++++-
>   2 files changed, 42 insertions(+), 1 deletion(-)
>   create mode 100644 accel/split/split-accel.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

