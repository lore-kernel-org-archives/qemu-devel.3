Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B370C87FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhapM-00014U-5Z; Thu, 31 Jul 2025 17:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaY5-0002ZI-A8
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:10:49 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaY3-0004su-AE
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:10:48 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b3bdab4bf19so1232849a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753996246; x=1754601046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bb7D9Lxegq02kvTykJdq3EA4Q6S0rk+CHbkli87raZ4=;
 b=fHs9kL6vJOG67kiBLkJOa+dgDRoiIPkQ4VfBqlKoOTTTlddSAFclyz1ppf3bJSCcaN
 iwieKXZfGNHxSxeB4/Q7AhsnXVLhbLjsgPJw2gijOPn8izAuQTocbCVGRHIBLCVD+sQX
 P6Q5w2flvM4C3rCbr0gXJ9dLdDPX1ZCiGqqRl2nQuaUUXcoh0AVz5ma/bcm6XGO5KD38
 qb7Uqz+WyCywIll8DGqm39CkHp9syOayPW+HAy8YI/F2Sl2a9sFGz3kHdB4dxqMKVvXP
 D2i6asAQaXiB/IuG2PFTV8RezjZVpll6jjlg+VIDCROa0Xk3nJ5C21uc+8oCSoTWIZS6
 OMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753996246; x=1754601046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bb7D9Lxegq02kvTykJdq3EA4Q6S0rk+CHbkli87raZ4=;
 b=YFsWgaRpFp1tp9IRrX5bb+z7P+SfUVFjzFNGQZ0U2/JJB0BExSjABTNHxKnRcuj6Yw
 qp6ma8kBzqZi1Abn4H+r7sZYtdyBbwlNlt22xgzBjd1lAKN5IkWamP9PMJ+AFDmlOMp3
 3Q0b1VzhRTITNuXxy6XHUOdTXXq0mIzDRwjLQ3fi+2WxLI3JV3g8yhGg6hWE9MONJj0B
 pUYdKXQo6g36Wpt2oODZ4/4v4D1p2rLtE4QvGoW17+n4RHrpbK6dpanPwHrqceCif75P
 LhheyG59OcLD8bAHlB0s9Siz/FF5UJJQUjspkaiRx3isEvkdWbF6fOcCggLjKjLjjVjA
 fIIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6i3P1WoZ61cNdjSWX/CrnZdZsmvwhWHNrZubwGX550a3p1dTvwd9bDMSywuVy5VcKRa6tpYEzi3E7@nongnu.org
X-Gm-Message-State: AOJu0YwSBQ6LImqpvrL6Xoqon7IDNbM8rN0oadR2uFoT8iKUtB18v6zo
 6Zg8G/JD+t0P9hr9NdaeIis5YSxdbuq9SyL/KlvS30ZbM/bPbADHVYFOHILGMpctAHc=
X-Gm-Gg: ASbGncsTw5m8MVzHkXOUMmg+zjOBk5Oj4obvgeukncMqdB375nh1wLHWyrE0tVmBVG3
 6IwmFCKuZjj5oznRgItc32Fv1W1wrlXN67/GhLqA3tsEF+kgxXnayLsEm+KcNniGmay/kOPgTih
 A2sRI9WGXurJnUW4QNUifPuaDaV1nVLZN4aUZUaRcpQQfUi68PDcUeF66Fx2A/bbba89Iln2523
 ltKlpLmAkvENKX1Y5EaAWa8LuZUESrMPcNfVt9L0OwuPIQ5AnQQAOvyQDm07HVdZc4Li9LD7XB3
 pjK3UXkxTPjT+EPxoCmCpIb02+a4F5NiOwJssNtdMFfrfE3FbhFxlYdDvt6U1z9QOGgDTlC98I7
 ehWM4S6L8pmgyI3SlfDou76U07Lepy2ySfPk=
X-Google-Smtp-Source: AGHT+IEa/Zc3w+vt/2NFyVWAgo7kRX3/yCOkFVA0mQ2tWbMlQ+Alt9n3o7sV4joEbvndMH13awd9EA==
X-Received: by 2002:a17:902:ef02:b0:234:9375:e07c with SMTP id
 d9443c01a7336-24096b2ce15mr131276995ad.46.1753996245631; 
 Thu, 31 Jul 2025 14:10:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aa9257sm26092695ad.153.2025.07.31.14.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:10:44 -0700 (PDT)
Message-ID: <8cb7b4a7-39f4-42ee-9894-a116d4de3369@linaro.org>
Date: Thu, 31 Jul 2025 14:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 53/82] target/arm: Emit v7m LTPSIZE exception out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-54-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


