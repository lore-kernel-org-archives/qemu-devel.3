Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7946C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XQq-0000np-UQ; Wed, 23 Apr 2025 06:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XQO-0000Y1-39
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:33:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XQJ-0005k1-RV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:33:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso58608155e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745404426; x=1746009226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ni4t7A9p2OYy2IhnomWUDf9O+D9TkDqPtjvUBzPzFx8=;
 b=PwDUBnQMp4Qym1rITQah299qBTd1KkFayG2Va1xTIuktrWpumnRigM5WzwgcAdfU94
 cjVH+5XPRKxAiKnYDczgIffZpR7HIimztza4dmSV6r/phCsVzWGkCRD1Jy0tyix/FWC7
 /Km8J5NE0LFuQf9QZSiy1nhxLlvLbbZ9pUUxudT+ystWTxfPDkNKI5hfeh2lbl+6IlE5
 IaZgncI6Xh53saQBpTTup4iSino8GlbDnTNUKxNcLoxwn6JxAb2m6GK4C0Ssikt3tf29
 xflQQP3aMex5omOpVqc2vE69pHQNnDBn/VzmU7dv37MBu5aT/H3PiCUiV91un0E00WDj
 NdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745404426; x=1746009226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ni4t7A9p2OYy2IhnomWUDf9O+D9TkDqPtjvUBzPzFx8=;
 b=opgkcUh7KkH85dcgfv2kwx2QennzSVxEuLOnSV/m2OqMoT+CS4zua/aiC1uu85+tWM
 7Z1fQrXZnMDQL3pmi/6ozluHAawuaNZ0Auz+0R5E+QKAS+0+Ww3sPVwEBx+xwJNYBjjV
 LkxDhyR/lg/PLdXETnuj7cPUqTvzKfZITH5mEu+vU2TIMJrC2teVLcLxGpPTANbcowsS
 yFg7Sfr/lwPSmnnXsXR5UPQ4bphmKcP5G5nonPb50ssLcQtYbKm16LDppf5nSHATFt07
 fJwK+R2amQW6KGzNQ2Jf1hoOPrRuqmRxi7giqnVZL4GkkAvdsvWowspo3sfEDh9BVKcT
 4xNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbdZnYxGKPbHrykUx0/cgI+IFutRBAIM8nVQiP41Y1xEBn5g5Dcsflj+BtsDb8C8owJ9v8lA9eID9d@nongnu.org
X-Gm-Message-State: AOJu0YzDYGc1jscIAYofvqSkjIePJUoJWmP2VY+GlMEzPpxv8k40q3g9
 thMbAWyCRjgT/mdYonCkmnxiNGv1ezAw8qho7/6bF7yrsbQBQH3HzQTU21g3iOo=
X-Gm-Gg: ASbGncsfkP58N6u463LJibxmioI/QPpJQprpY86N+Ol5GXBSnsJboe7cq6hG98fAIKO
 Z96WMjyU6GMJ5ymdhVtFJIvbjTMewM5oDQKivB6PymW8mCk4vHggnI2b6GGgfBmaBygsmW4ZNLK
 zpDx9+HcW/fm/F6kaH9Xs72CsPubPLEiFdBVdRbUau+PCa7uthFb9b0jowrODLqS1N24Ma+n93M
 RTQqlSX56fJO/y2LC4TANaPL3lll5IfXD3LXf+7QSTz6uAw8nJbq/IS2XUUvs1EPOSdWcjyveCN
 UDoRSdzvgRRW5Zb8+r+UeGIGy1Si6uONo/jwK9rwRU8R1+OrVMlm4tf3729WJ0GOC1SODEMOESh
 GBjcS14vU
X-Google-Smtp-Source: AGHT+IHnXTpkVuGkk6xRHhEhqmI/GYrkq7e18Ob1FXHtXuF5i8uoRu5SkhcnhDgcNkQnJBFj7JfOCg==
X-Received: by 2002:a05:600c:4ecc:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-4406ac17729mr153026635e9.29.1745404426131; 
 Wed, 23 Apr 2025 03:33:46 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433141sm18465508f8f.35.2025.04.23.03.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:33:45 -0700 (PDT)
Message-ID: <e37833c6-042a-40af-be15-5fee3c755f4a@linaro.org>
Date: Wed, 23 Apr 2025 12:33:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 116/147] target/arm/cpu: flags2 is always uint64_t
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-117-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-117-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Do not rely on target dependent type, but use a fixed type instead.
> Since the original type is unsigned, it should be safe to extend its

s/should be/is/ ?

> size without any side effect.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-21-pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h        | 10 ++++------
>   target/arm/tcg/hflags.c |  4 ++--
>   2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


