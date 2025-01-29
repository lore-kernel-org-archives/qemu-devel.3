Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E040FC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC07-0002hq-ON; Wed, 29 Jan 2025 12:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdBzx-0002eM-5Q
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:10 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdBzv-00031L-GH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38634c35129so6346424f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172226; x=1738777026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dyq/xDN9gTwJHwkVZqlSrx073rrg1I2J9F6yJEE5pMA=;
 b=rTjPRPMHZ8UgnQBrnpJbJmHq5dqPV5FL4pJqeC7LALq3kxZfa8xWV9u4JI06ciDaZY
 3JFZEWgYW8l/4PEoIZwnr1LG8BnAVQ7MfMoy7u3b2l+tJKuVuK8eLjXbDRW5JYB/Wj8p
 5nYAFiY5lS8HoqshtuXss7lcJZP/f2QkqmqX1SUZ7d9I7gf79IFVqtnz9YFzCAPulcrD
 dfWlkvVeBWb0qnitEt6Yrbi6g0EodFExZPCMhRmcN+9GKVBIGAxXD5nJKGqdDDhNAdmO
 2UDSLGufxIwIWI90av0i5uSkRVxyy9DHpV1XjYLuh2RNJEkfwa2YhwOx/4WiZgTR7k54
 pjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172226; x=1738777026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dyq/xDN9gTwJHwkVZqlSrx073rrg1I2J9F6yJEE5pMA=;
 b=mCNt0/zqSagApHXmVEZj3b3YEu8TtRxcgXl/dDWvLpLP1ZFYV82dsiZwvmFTppRC/G
 yn6yffLNpqFHSHLMoBMD0ZBp79e1P1ofxBNJe3OcxK3Ah61hWJiJPED8BG+b09uAGqts
 FhG8Ho/mGo8++qUKxc4jS6a1upDgnj6lv7GmGsltRM5dTUrTCA1KEqNVJqCHYM/9E7rt
 MF03Qt2u/JU9/+k4cX0Z5Szl508ceWUNdpODq0aKuAbtwEur6MoQsuJoGlmIPbOcFg/B
 KqdtBCiUnlUvNGcyjXDtOo39fQ4uCq+DYCeUGIxbLiio7eYXuaw50noItYipnz8zKsJ9
 bGpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxSSVip/oclj8ig28ENpCullNRESLibl6hpBmev7ycYd9utuFecSvwdNoC+oCb/a/ZWbIssMtDScH2@nongnu.org
X-Gm-Message-State: AOJu0YwpyN8sVefa4R0zcPQnQrOrFbNmqbIK5GmITbTppysaiaZAL59P
 z94MmJRzKRfZ48Nmg7lEewCFYy0ouSGInkhYPUQl2ey0yKg6whWZ0wfip41f2Ooj5bEGz+4bFCN
 GxAM=
X-Gm-Gg: ASbGnculShLzLXiPswcNcz1F2eZl93JK3DeSrfLdfmTMu7BGnz0/Ww+1Sip4K+dF4Ev
 d/D91x80h3VzE6Qw1RyzlQlOXgXmL8YoEEpLDqJ93zCbiaA5UZgoslF4DIR4er/dED893ddzb3+
 bySh1yZ0h/tUIHwlqr1r2KQfRwTiHuAi4kc2Im/31wOdRf04Y+qnRc/B2wi+0FXB+d2yi49Rk+D
 CLznM1ePUEBcxKYPoxe+NyjJcXzSF5x2T9MsEPV2CsmGmpJZDBdNVYUkio3H9+G5MIIxucJcs79
 QJJqwEjcV2v0YIyQmdZJeMXnDpmvGNQ9XfOZpl5QAq6lIb1afJ1Itn055n8=
X-Google-Smtp-Source: AGHT+IHvMFdWmmYvDMTh+alnrTCTpsAIu5olQgCBrR+f05PatblESqwuBUSoa+UIMu8q4evLSzJ95w==
X-Received: by 2002:a05:6000:2a9:b0:385:eb85:f111 with SMTP id
 ffacd0b85a97d-38c51960449mr4138030f8f.14.1738172225834; 
 Wed, 29 Jan 2025 09:37:05 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c35e1sm17573630f8f.82.2025.01.29.09.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:37:04 -0800 (PST)
Message-ID: <5fb74df9-b42c-49b9-8d3b-29e8d24042d4@linaro.org>
Date: Wed, 29 Jan 2025 18:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/34] target/arm: Remove ah_fp_status
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_AH].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h        | 3 +--
>   target/arm/cpu.c        | 6 +++---
>   target/arm/vfp_helper.c | 6 +++---
>   3 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


