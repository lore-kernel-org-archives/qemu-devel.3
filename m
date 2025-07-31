Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7A7C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbBx-0007iG-27; Thu, 31 Jul 2025 17:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaz0-00080R-Vz
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:38:39 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhayz-00015p-6t
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:38:38 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2402774851fso7859235ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997915; x=1754602715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fPTXtdiLABpycOyzbsco6f3LVVm7p2zbNmbCS3oTBFc=;
 b=IEFFeFSOZqRuy4AE38nYfc+mF6J6SB1dUL5Sziga1/1GK7KNG/aL8KYYx3Aa965hPa
 7q65NMkOfH8VWXvyEaKEJfacglMQ3E8d3PyOfIvJk3R0vJ7perj7YTvfLztbcrH61HUF
 SixxFEUuHSKl6exYeBZbepe+I71A6oVZ2HjtKNslYlT6XwjuUC19QB7caUPUplxg4sfO
 fIZcsil0Nnfk5BhKoSumunGuQQ/15EnYRjyc/gjdwn4E9mP4pgCmbvL69dPXptkeTNMJ
 7M2WCu6mSzOmGkGe4eVO2ZSGrViv3ymDzihkYoQgPyYArzzN3gE5QBQIknwTZE0KIFq2
 HBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997915; x=1754602715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fPTXtdiLABpycOyzbsco6f3LVVm7p2zbNmbCS3oTBFc=;
 b=E0BEbEn8Vbh0w8q9WGTH3bBEmXC4i9FLl1x2wnFSvQdsDU4COdczemEoHnWkQqCRyu
 r+sJOcbVZNOO6t1YT9qfdxjmmQUdv3tRarhRiW8c/0XPxZA9lqccI9aYiLsUXr049C8g
 9RHGR3nTSkm4aqEwaFqLRKBLK7VBdq5y13bQlqQj71NvLDKNYg0zlrWJpBkQhOLUoutv
 e6binA4sxy0WVpnWF7YYRjtN+S2Ls14GSMedy7OT9VOG6Lw4L07gwq9EiQ9EURhHB9ws
 LpUXALTKRhfoUa0d0RqKl0DmZKimfi6pKGUYMuHVvu7x579zPNExSTgcjnbUQ0YLEYei
 ogPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcWszy7e0+kqLSzA8J72BnUkFcYhC3t7Y+xjR9a2lK79tTxuUChy29mefmHTTwFI3jv3dVA1HVL4hH@nongnu.org
X-Gm-Message-State: AOJu0YyWzRrkRy+LJDvLLRsRdYSPCGQ9A7J8hWDYJ19SyLnmmWn4mBmp
 txgf5rxUeOMzCOxemDNLmo17Aen6fhYGvRvv8Jve7NLkpL8NdS4WMyJLBhO0/1Y6lKc=
X-Gm-Gg: ASbGncsZn/NHhilltwpcYp5jgQSS0zb5kmTzCZxEdrO85I3lBEdgEM6u/3OwVXsGztY
 rwAIoAXPgfh3knoOsTDc5WMmUxiSQL2QNJJTJhroMpXfNQ+/t7UtDdQ5HpfKR6NKpTmlq9AoAAV
 0HCxGH1NzmsTNUGBHvWooJw/MzCH9NL+WOzxQqHUCNtKI8gMGZ+KUongyJSc8OH8eW89HQxX990
 jgSYGiA1SLzluChUNoib8rOzR9f9jBD2PV3H3R6HWsI34fHyXGepXiWRyg4udk1lIfgvRczFw33
 +kIoAuZ0XlnrFb+4L+/eoew3ekqxiwZo8C81rXfZ8fZ57MkcWgEbwYpDffhm7ZqUG8icEQ51CbB
 EyqfcR8Kor/P9aqk/tLTeDU14UfmNCrdQJoM=
X-Google-Smtp-Source: AGHT+IFlfh6G5ztsT5v9B3mKCBSEDxifsPA5p32wEHVRFknE9jBoBs1wi6VDtKpweVpQ5fQv+n2O/A==
X-Received: by 2002:a17:902:ea12:b0:240:a8c8:5f6f with SMTP id
 d9443c01a7336-2422a6a7c11mr2620495ad.27.1753997915495; 
 Thu, 31 Jul 2025 14:38:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef66fdsm26299475ad.38.2025.07.31.14.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:38:35 -0700 (PDT)
Message-ID: <0beffe53-1f6b-4e9b-bd9d-95ac5ffcd92c@linaro.org>
Date: Thu, 31 Jul 2025 14:38:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 60/82] target/arm: Implement GCSPOPCX
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-61-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-61-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
>   target/arm/cpregs.h            |  1 +
>   target/arm/cpregs-gcs.c        | 17 ++++++++++
>   target/arm/tcg/translate-a64.c | 58 ++++++++++++++++++++++++++++++++++
>   3 files changed, 76 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


