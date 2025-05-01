Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CEBC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVln-0001UE-TC; Thu, 01 May 2025 11:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVlP-0001CS-UV
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:23:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVlM-0005OS-BD
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:23:51 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af52a624283so1025221a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746113027; x=1746717827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=wReMwhXSU8I3WdmCxPI9relCAn9DP9g1egkUJrdXmXwmQDmHlaAY8ybje5wqZdz3T+
 fP+hkGPxGmJY25Wee6hS/sjGWQbDWPQi6IJnzyqdhklqjK4PkTcrb8wCCwJ6nEizGvLq
 bESmWjp05aRy1rduK6fVP8LxqzrIl5eRuBXPPm9qzXGY49396MfEaFlzaEOan2rnBR1L
 +wIMpLgHYHxjjX9Fjr6t9OW+XTqSCmj/LoHyjXDckmfFHEYZWoVYBRQ6PopZdNzpLPTe
 is/VhHXMdB62aRLHEIa22JlFrqkVAazqUW+pNyjz2fruvmy1N1ffpWmfk2XS0jjugjSt
 nj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113027; x=1746717827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=WEzgYcC9pQz068IRxO3w6oOccqIseki0TLq0BzW4ihGhAFzcwNrSZ6YgMZWNHtpaYV
 4Q2P3XE2dSp8BCblC1EXVH7B4KQKfK0Zys9PPrt4Lb9i1CghD9S5i07wWRF+zNt+ZgSe
 +RSg9LBsA845VrXAMCpbkDj+7RA2dbDCtUkfAj7mhWCLr7JAQyodOGDGEL/Kk2EYCBVL
 Lh/gftF/BQVRe5Fzu0G37K1l1r8GL6JU2DJslWte2UKu6VSFG6HnRSk31U7Zz9ot3/FQ
 YZ1Za5BBd1OvtFVxg4FlM+BxQ2JBj1p6LrTOhSCOEV+rkKuxt82I6dQqUwOES9qM6VWW
 R31Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzz846a9EYxL+ww6Pr4n0AaldJIwRl0VP8PEhElw9EgMfWVmgS/duZVz7sKYQix7T4IHmKZGkc5L3d@nongnu.org
X-Gm-Message-State: AOJu0YxvGzxLLOxbhB+Fag6/s3MjbKHPucjdMuqeyX5EwDzXlwkyVvxF
 zgQq+veVnyLitg6cK0pwBqQ00krP7ZWuRZ+VcczwIY0Kvjfg/5/eaGTP0Anme85MOuVHw3mS6g6
 Y
X-Gm-Gg: ASbGncsIPI0cBEY2UCtIcP0LlSOvthV610+JW3WElanJfT0SAm5SfOF3r69BwLr17dJ
 sUtSj8e5cXT19yPX7ONJAmUKM1gsgXCYKxfxUmRelSciB2/KyiGo9O0D9UTZC1OwjVh9YI4mPNV
 lfJjq5Fb+uSwLxoBTJfpGp8WoUlNC2hvNk30umRbNAi+LlxzBC+1xI7s1j8TxEVTXI/mprsAQMk
 OnNChq7izAILFekH0yPTI8Lor0bKLNhkt+yxPQLhK9HXRViODhkWlrQ4bobk9YA1NGlEzGaxFcz
 N3YoaiofXVjm8um0LCtDdPuiuRpQCk9xI7UBzx7QolLRujDZfdcPgX6N64AtYPMwkgWuFIjViXA
 R54UeEDuIMunKlc7nMQ==
X-Google-Smtp-Source: AGHT+IGeIGOXpxe2jTOUCDPMZOtd+K4fLjVDkKah9tXMcswEOyenkaTjPmkGiWjX74LVyS7YdNXcsQ==
X-Received: by 2002:a05:6a20:9c9a:b0:1f5:8cf7:de4b with SMTP id
 adf61e73a8af0-20bdcd9eabcmr4194086637.16.1746113026817; 
 Thu, 01 May 2025 08:23:46 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fe120sm914753b3a.86.2025.05.01.08.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:23:46 -0700 (PDT)
Message-ID: <f3fc3946-a191-44df-a610-fb636e2b314a@linaro.org>
Date: Thu, 1 May 2025 08:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/33] target/arm/arch_dump: compile file once (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-27-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-27-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

