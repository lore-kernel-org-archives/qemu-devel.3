Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6C9C7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMb2-0002vE-AZ; Thu, 19 Jun 2025 17:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMau-0002uZ-IF
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:14:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMat-000061-1a
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:14:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso847247b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367685; x=1750972485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+SYrB+kFl/pfajQI7EJSEfdNTq29PD+mHISr0yot9Qk=;
 b=fwHBGzaLIzYcpMfGckOFyVzhUv8MMb4qwuG8QeAko2ZccdkSuWjr5LnzbPNg2IlcmA
 VNjkJb1KC+SEiw3b/NX9LfVYB3Wz5W3uXwWP09u0oWSvyyLepJieaAQ3x3eHEUKquYjo
 x3BPoD1EYsie7YVaJIgr0XRGmPiy+YCUj0Q9yXArAv8O/jlq+v1Sm7Go3bIjS/8y46A2
 SJoQWOipvUekLdoQeKKl6DuPiKW+f6UKXiwyc1in0mZ59nHadwGj0q+8Z+KlO6H2BdUY
 aok7SPaJ5DT4+PIKAxbNhxWyHZ1ohw8gnoVGdR/5xrohloMy2mJMBl99eGlGh6WdkuNC
 s9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367685; x=1750972485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+SYrB+kFl/pfajQI7EJSEfdNTq29PD+mHISr0yot9Qk=;
 b=K3p2HvHrNcp+hnx8XdzZ0N3k4zxH357YKNmXiS9uRpaP+q7QSF4wq7V9xWrZwiLs/L
 45qp3dXHJkl+tIcP2v6rdjzqLizXWt8E8tbO4rVv3iDZ+T2fgmV3upLeKUTS/45fLShw
 TCDutY13b7wIEquP48cdloWcFLx7J3CXhnkaRW0vGvwF0WN2zWE6mYTMGRVxCvmFa+Ky
 OLbX19LR+WEx4DcLH0F5Ol3t8aHcK0kjgxB4FLNYsFYGozzqJmyRl//JcHfJs1zQJSMB
 vy+5fEWuwrtN8INTwdkLD988VFSWy7OLRmgnqVNcnyPnGUqatE+/KfFwH/UUZX+6CaL7
 aH0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkvauwU6zFqxXhZ1pXpwtaOcG6cuP0EVJd5UXDCb4udb2WtbgA+pOhcR98oeXCvyOmHg5ZvHqRSj3i@nongnu.org
X-Gm-Message-State: AOJu0YxJhotmeOCoBoM1T3IG/eUtflhhif2aPVtfnKYFinbVpoVvJQyW
 9/nNkLZyevgWpfYP0/Vr05zg29Geye1aE4PTV/oM0DHIIQdGY+Glkt7zYGf34L9+DRA=
X-Gm-Gg: ASbGncsyB3813864a/5aSROA9ESd35M7VEhm8TjyabzMLYBpTxlVa/DQnAQ+VQ8+y22
 TsxnAHCtbwWXc7zhIA/WEgQSzkZZxVPZ3V3lboRFSvjkbRaMpDCLo2eoR5h0s+e1hqb7UkLROp7
 9AI+Zji6pa7pUn4vzDz+i8XuZOIe8ySxtpg9V6mpH2tuJQG7OC1Pn3OOQNx2YkNwc3O88TZP4X+
 PtsUU01HWJrkr4Zx7Zj9wKzpsL233e1RqvFEUbSrYU7oDUa+o+H4PSv4tAgUFLK4ELb3fIv4Y+L
 z0xQajBcKktQKVZcUAaxz+HSXq3OEHv1Zp1EnXqLmPiM4/fRPZMr4l8QinX8mSBj78+m26sc9G2
 Q/5T0VI6c8JZ4q8vTU/vxwAX01AC+
X-Google-Smtp-Source: AGHT+IGEXxIItobnUdNEdM7TzNSflWoKbEjI1Z4tXD/Cy1LEAJO12pPai3YGs+QlaFiJFdFRdIYNVQ==
X-Received: by 2002:a05:6a20:914d:b0:1f5:889c:3cbd with SMTP id
 adf61e73a8af0-22026f00cefmr680586637.35.1750367685248; 
 Thu, 19 Jun 2025 14:14:45 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119e350sm234088a12.28.2025.06.19.14.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:14:44 -0700 (PDT)
Message-ID: <d2f50c48-d3b4-4ce5-a18e-5bb37f14a6f9@linaro.org>
Date: Thu, 19 Jun 2025 14:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] target/arm/hvf: Trace hv_vcpu_run() failures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> Allow distinguishing HV_ILLEGAL_GUEST_STATE in trace events.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c        | 10 +++++++++-
>   target/arm/hvf/trace-events |  1 +
>   2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

