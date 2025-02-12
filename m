Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEC4C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiH1r-0007aU-9L; Wed, 12 Feb 2025 13:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiH1l-0007XW-To
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:00:03 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiH1j-00011O-VE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:00:01 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f4af4f9ddso86713245ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383198; x=1739987998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6sS4uGhXpZyg1qY8tLuptsulkGjCzua1QgFsAt5fiLk=;
 b=ivWfa+jKa5tVaGO32ckUCvZy3fVv0NUvW/jZMG9B7nS3kHxhrIY5T8zWoiVluM46SJ
 +0CI4Ug99Eli1n8RIPhbwUgwSUSQthd5febEMbAxZD4mlMvfuxT1hIwGdSLHpHZHUtw3
 nLGvSdp0K6dTzzaNbtEJfhPAVk5V0RTB2rkiMTHUMkTDbfgKUIyvd2V9z8SIbzEk1N68
 QA8aVVWZ+8k3MfS2DmvaPZh2m9FLDlJg3szXxCSzKm0p5Rb2vHuQMHJQJYrhObPTwJm6
 LM3IybTQOvbqz2AQmN9cSbaqqtFvf1jBFSCcNZDyAI4DQvxBb+dt2X6smv/xFHdwv7fr
 absQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383198; x=1739987998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6sS4uGhXpZyg1qY8tLuptsulkGjCzua1QgFsAt5fiLk=;
 b=OfMzXarEFG41yrkxRzjn9uynUgkfz5sstKmTzuQqxPUbU1WJa/cYb7BWykW3Nc+w5+
 kuLCKubluqjJDNnm54uAA1W5qOP+B+J0tQZTjujZcTvg9/i7aHmS1ygRkbCh52rAD7wE
 PxgnO1GfxD6DCQYpSANNg7CgVt9/GrhZxjtieW4zpQgst9/Tz2hvBlgyLhxorxDIYdQj
 BWZhUkbiTUIR2GFjYJUcRkLm5s0ynxsjGAVDwH8X7DKZP+yxDpCEvWr8nqC68qgtPbk8
 K2R/GV/0LMkXjwV5RHdNmn3d6m4fEQ8imOjNpUMgKomVOI9LXrM5e0g0eAEOrxvocgb3
 veGw==
X-Gm-Message-State: AOJu0YxpfWkpfJuy7ph2Jg0RT6eN12eLvSWu/Hi+yxAKh4GafkOKXr/U
 brojjOqkrlMdY4X+0xB8+AwQHSZ6HnlUDX9z9ynUUaq4I4kc3Vgso10OST4lwdsP4716pm2fFD2
 E
X-Gm-Gg: ASbGncuYJeVhuR10qYW+5oAe4SLUf2h0VZKQzF/y2hFQLKh9/Wd0DE7c21xCKnnkn07
 b04+Ev3iurNNghUM6W12AEnU5y0QeT/hJGVr5qQU+5t0+nF9JMiIwqzaNV4M30a4XIkJoMKMM85
 6P2i7MhFOqB+etkoS5RcTsoT47h7CfAYKd7e7W/RZB+JFEgf7jCGc6If7fi2CoC7D7gNCotoUs5
 ffqopIhcUXNS/nWD6xbr4ja8gNAcfuAJ12vwiZvmojDOzvXVwuloe+0k9+NwI6+y82rBORC5lca
 4ZXLQPG/w6pHJL1UdvIjRgiI0ET0B7fvdd/MFy8zOe7aG/NqVXQi5Eg=
X-Google-Smtp-Source: AGHT+IHFp0q1cgdJz8Z1ibIG4qaaUGB9lfEenBuIrb0i+MCdNAtHo0kcQw0nAGb2UAy4rAuMo01nHg==
X-Received: by 2002:a05:6a21:d86:b0:1e1:b60c:5bdb with SMTP id
 adf61e73a8af0-1ee6b39bdc7mr758193637.26.1739383198015; 
 Wed, 12 Feb 2025 09:59:58 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73089c88552sm6459374b3a.93.2025.02.12.09.59.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:59:57 -0800 (PST)
Message-ID: <52c06049-29dd-4409-8e8e-ea2745611a24@linaro.org>
Date: Wed, 12 Feb 2025 09:59:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/arm/exynos4210: Specify explicitly the GIC has
 64 external IRQs
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> When not specified, Cortex-A9MP configures its GIC with 64 external
> IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
> configurable"). Add the GIC_EXT_IRQS definition (with a comment)
> to make that explicit.
> 
> Except explicitly setting a property value to its same implicit
> value, there is no logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/exynos4210.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

