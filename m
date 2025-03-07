Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3B4C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqffN-0003Wz-C1; Fri, 07 Mar 2025 16:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqffL-0003Wn-Vc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:55:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqffK-0001e4-GD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:55:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so19729245e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384533; x=1741989333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q2WHUktLuWtHpWsNWonNrUYfmV1AHSB2WVsYFWs2LFU=;
 b=WWoBEATO1ng5AVlKTiOWMD7GTwd3l1FPB+UIjxzjCbqyCxoh2Xhpg7lz8RctADLtrT
 BT6NVvlH7yfoxpQOF7XSUPB+DTtAMtKe7TFfHOrnlcX5CFu8vOTvgZFpHvYqfczvsEtK
 3bmluhi2K05lyekekcypAdvQoBsdeDdxeThMJZQUvQNQFN88CbO8ZLdwvjHpt52Gr1AO
 m5GMDvGm4fFvtHYLBfYVhj/Fl+E2B2pkjqXMJyhVPZIY8vk1fVNm4AjyLPrr7WYT3qKX
 c+cgFXROLuz4/OmoTsy5+YbkbBmrFq+jFumD+588TSUkVr/KeMSb4277F1CrVooA9kZq
 scYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384533; x=1741989333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2WHUktLuWtHpWsNWonNrUYfmV1AHSB2WVsYFWs2LFU=;
 b=vJBEnOsPqBaewyUs7qfsXTAmpE34aQivTXh2Dd/qvCqzZ7r15XXV9a3R9XSt7jvwAC
 hXwKlPaa7f5mBM3aNZVgIwrsr4oe+BasM1ANaAZpNvmSc1jinrQMCf3NQw31t7S1vE7c
 J1Gjqz0Bfq02vErh3gBRKoLdSmahRwH3IXikGJqc3QsQ+97jESgdp7sl83t7CYELan/Q
 S13XbdBc32Op2k0azzGR2wNUNzLGy6d7MP5AG4x2QN7DfFjAB3BJIz3hMoR0TX1xqAgZ
 f4vIeG7SrbZf6vnaiXIo1+HdVUAmlL/A0q+rXcq7lDst9uETOPj3HIOx7ftXqi5jwLX5
 Oolg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNPZuFXq0CcCCIyK4+eqkjO+fcS/RbgsaghkIV1AAwqZjrsdNkfYJwwLJ0N+dhSvnxvr4b9yogP8Ld@nongnu.org
X-Gm-Message-State: AOJu0YzKicN/IQTOxMXqitE7aHiU3LXCdNWR+7puTK2Vb42QIkU5o0Qn
 X664T9tTshiA9JcWk3T81SQijkyGoJcWZ3P21P3/d1iR7ggs4tJ6VIhPzze57wZFY8z9DQFJKoj
 EjJo=
X-Gm-Gg: ASbGncsLAtVadXgLTc0siRI5GLnHJ1PT9q9zStaLV7OU2cPgI48nXaBuDVai9Gs8WFd
 ItATAfg1dOAiG9/8KTRQGBu+N/ZQ0uH2tvdnF1YM88asxYhjLFn2AxhxT4bivXckgVxv7rqPaxQ
 pWjEUY769DziAvBww7Wp37YBEuyUr7LbZScHSVtW+MFT/ukWqf3gAGBYOFrQwTAWhmEOo5RPZZ7
 72ohlGOk3T8FpaNoRDgemQ5SVBlRe05UvXf9mx1Qt/kT9ckTJpL7zDtoyfQdgUmtLChCpB2Cy6D
 bfFiNtlxjTNcEts3/Xm8dajBCnKOBRIQTnoaRRSp7e07dPOR8GpLvRUTJIgn1T8dLBODzMhJBXB
 HL0MiR4UQk8SR
X-Google-Smtp-Source: AGHT+IFnRgQnCE02FvsY9Qgro3Upkg17CrF7XOTf+wuHPVlgFY6wFxenk6orpID0llInoQ4s85Jg1g==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c434 with SMTP id
 5b1f17b1804b1-43c60ae9832mr32146005e9.20.1741384533084; 
 Fri, 07 Mar 2025 13:55:33 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c6ffsm92958965e9.33.2025.03.07.13.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:55:32 -0800 (PST)
Message-ID: <e79189ec-7630-4c25-adb0-f490d6caad6c@linaro.org>
Date: Fri, 7 Mar 2025 22:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] accel/tcg: Build tcg-runtime-gvec.c once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307185645.970034-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/3/25 19:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime-gvec.c | 1 -
>   accel/tcg/meson.build        | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

💞

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


