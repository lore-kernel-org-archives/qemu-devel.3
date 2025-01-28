Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5919C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrDr-0002dt-S4; Tue, 28 Jan 2025 14:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrDm-0002Wc-QY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:26:04 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrDk-0003qM-4R
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:26:01 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2165cb60719so108199535ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738092358; x=1738697158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WM+J7y2MQvZcFWdyoH8P5UkeacWQCDFuLsTIMgZiyRc=;
 b=DQVInOH4X5/6Dppl346A4kvMaf60upmEDHcxYwc8hhHhzrQM4QOjMwj2i6O8ClF9yp
 Lf2EbK2TT78Ec4WRQMPf54qt8/EgR55temmmQa6TptVrnDYNo9VmWntVKs9LaKe5+JrI
 0dGOG/ASqONGX5xEBagd1WQQDEnrU5Gi1+GFnb2WVAx4A/cDs4M6s8ZN/fEVCKvRgS/F
 6kNum0GwC+iCcoaCVpQDXAUv3B9iNm8p16pIXLGquNWs4Wa6ycCFVXFT19LPuAyDfo/W
 aYde7D2CLdVr7IUiSkgzoz8K9ZO53onRK8HStuTytXR5L1WXzSIfEzN3eMUeaQf2QA72
 xLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738092358; x=1738697158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WM+J7y2MQvZcFWdyoH8P5UkeacWQCDFuLsTIMgZiyRc=;
 b=toFqpkP/Uswb/ULr7cQq6V1bfgzSuH7EhDMG0dsK3lvIV6xdpQvrNtAVuIzkKgxeTb
 Czy5u7BlDjS7jwL96K6ARYMrD5/TFwmwnDAop0JKc5EYM4by0xjvpUC2Px6q2oLKQCi8
 72Lw2etytxTYEPmFEaO5Ra2kvB17ESDf8KI1ZYt3cCg/jOaQQTbRMBCwQsFhEB5tTcYA
 onyFUNDvK2mUSV/GXlrqo7gJ1vQs0QUSvTIM8zIT4UzAsfD78kJPat3Dz8Pt18Cdwkbk
 4I7sfeNRSM8jDyz5XCWLHNhLJnIN6mjzhWRXQBypdCUyOkbdqm0kbJ58K+MjuGMpkT8t
 RbXA==
X-Gm-Message-State: AOJu0YxGCMhPWkdxXZbR4NfQ2FRWYJ3E7oXFLnoM/DlIzQxa9zbdO1DR
 8k/naTEfnzTwXpqCI4ptOlZQIhEPEuR21dut4cPOCA/yLPUYTwrSjNzl5CWewMEfhTIRM0tyWzB
 h
X-Gm-Gg: ASbGncvbROAgGY1kUULGZpj4/8CQNDfAAkTtg0JVKphA9JVZj/XhOXhDVNS7Z5nU4B/
 EG6FzigaxpyDPyOAOv5lZhxSdfFJ8e42WRryU0/4znr4l/VcufWHOq5mdT9JfdKi5GYKzJxqTD/
 hxf8Si+teMr6+4aB/vX8MewtlGDxlyjXHrGBiQCNhGzcvBYd1G0N0yoDftL8FrzJ8uWKBmKxSKK
 y199XP5PqQeG7QC60IG9UYEYvGZKRe8Z/zSyXsI5MdkGUVQtE2FuH8m0rgUmSutwNqs3xtZd/s2
 3CCY7UIfQYpJvmrcmUCNooz8lve8jzNQAcbpb6DDEEU5Yf8JUaXDjCwuXpgzv0JoTxOw
X-Google-Smtp-Source: AGHT+IF+2JQgbGGE/FKLQM6u5OAnG2tBUZd7/P0q5heFWDeh/mw+F1aQxK3kvFjMZn8HRaK/GZA14w==
X-Received: by 2002:a17:902:db0e:b0:216:282d:c692 with SMTP id
 d9443c01a7336-21dd7dcd39cmr4271355ad.34.1738092358196; 
 Tue, 28 Jan 2025 11:25:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da4141513sm85351495ad.119.2025.01.28.11.25.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:25:57 -0800 (PST)
Message-ID: <f44cd0b1-81a6-4e61-ae7e-b4a4c4848d83@linaro.org>
Date: Tue, 28 Jan 2025 11:25:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] tests/qtest/migration: Add MigrationTestEnv::has_hvf
 field
To: qemu-devel@nongnu.org
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128135429.8500-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 05:54, Philippe Mathieu-Daudé wrote:
> Allow tests to tune their parameters when running on HVF.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/qtest/migration/framework.h | 1 +
>   tests/qtest/migration/framework.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

