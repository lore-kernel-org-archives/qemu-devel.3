Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24727C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbM8-00007i-QP; Thu, 31 Jul 2025 18:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb5a-0005Vq-31
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:45:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb5Y-00029q-Eu
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:45:25 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1488404b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998323; x=1754603123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4lyau6g7ZS2X5dhFoC647e0I5kJk8G+2Y7odzEKMVBY=;
 b=L/T2io/Lo85k/JJjzKAOiHWhsHNHwDv9jaKRpwJVV3kg+8HTuEOEoH29kEKV7lm8M4
 Z1sFcY/Uf9P0tqVDwun1Qa+HPpwOu/8WrTcpGFzcIiHtTglf+3pEs4lSSacIhcQPMd9n
 32ysRrEHn9tjkDLDfmp6w0x5YMFWpGu9SQzy0RreYxz3/dWMRWO5oWXjQ6eRm0UOhTB4
 lUmo60jEuZhIZmbuf1+GTX7iPUMFEVLqmhpXoeppt+5G5K4SooSFWeYsigm0KzU8VtXj
 +nEPCTzADgyNl8M2c+YidsdSIGpIoB2ezvcaA52C/VmcISWhcBiVb6YI0u7BTslNoMs0
 vGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998323; x=1754603123;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4lyau6g7ZS2X5dhFoC647e0I5kJk8G+2Y7odzEKMVBY=;
 b=Op9a1XCzP3+3eSiA1WdRsVi34RJ7FnBxc4F8f33FRAfspGBYFl1jCq/2JB1s7oKDHl
 4c2Hv12yGK4AjG+KNA+pbjsbNDhdVKZQ3lDE7xm88knUMuxj3bk7QgWyHkRCTcYWO7w8
 CZDCsLFo7+KGGVE/F31Lbii2m68vUvlzDIiq9DDf8KK7fSF2oUEUK6XCmLi/VWkxWY7b
 5oVb2xa9pRkhsyaJ1h+eg98Q26lVrKcnEosksAJsM15O3wHFQNNXFo8fzCoey3bxQZzX
 8BMGANpZnCFhyDb4h94qmOPm/+cCak0n3LfeCYpBUufBsPo8DVUXZxZBD5KEbHsR+d/v
 pR1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ1y/xDQPD6IiAF3CD1OX4f4ieb4WXWn/y75Mhjsdyi9phyj1zJRVeMCWm1UEJBdmu+Kje4ljL2dNs@nongnu.org
X-Gm-Message-State: AOJu0YxflsfJEpmk6wXf50tS8bXXcVLtT57pEIa5RkQRc5nHsCQa+TgF
 olgBeOf++4EtvynqAPBbkh5cygqcOQWlmIWQ+2ivUT4vkrGXbt3EceS6mKaxQeuzx7E=
X-Gm-Gg: ASbGncuVYOP/vGxHC0X7YDlpDBwcc5jqt6QiyKeQR6MGCjO85QYKiffb52+jGYlxIXd
 C6v6nNNMc0G/1GTHVgHKchU8SZOzK01TfmBUIb7sq4aPP93OJiVcGLb3wO9IPVAVs7zPVGwzaOf
 WUKrBKiXG0hOIojBhrZPACeRfrE74yMa01TggzM2Jdyy0CJEtr6T4QaCpXAv+QxyuILDjkkLMlI
 Tk8vDoJSFEy+0CeBcZnepB5kV8w4wDoGMUQm4haFvLFgHhrcV1t1vboq6tdHkB9eox/kGCAwHz8
 ER/yPHq6jGuOaXRNtTKgylU1++wlILcPTvR6aL0ZRMdGvX3lvG5oNHrVNaDiyLcIpjrTaZfLueB
 GI5P+h3+CoYcLVz9sO3/veveoPAmD6nadsAo=
X-Google-Smtp-Source: AGHT+IHS12Je/GUDRVIQfNE4+eeY3TxvlmzjSw9hn9gQihRIiIa7n3f0L2+sJPwStzkGYulVnsAFAw==
X-Received: by 2002:a05:6a20:748b:b0:229:1130:7411 with SMTP id
 adf61e73a8af0-23dc0e6183bmr17642183637.31.1753998322880; 
 Thu, 31 Jul 2025 14:45:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b7ceb3fsm2260945a12.22.2025.07.31.14.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:45:22 -0700 (PDT)
Message-ID: <932f835d-d095-4941-a2aa-921b4dd25f8c@linaro.org>
Date: Thu, 31 Jul 2025 14:45:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 62/82] target/arm: Implement GCSSS2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-63-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-63-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            |  1 +
>   target/arm/cpregs-gcs.c        |  3 +++
>   target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
>   3 files changed, 41 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


