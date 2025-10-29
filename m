Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE77CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1v3-0000Vr-FE; Wed, 29 Oct 2025 04:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1v0-0000VU-TL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:52:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1uy-0001kV-Ia
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:52:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so3386927f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727949; x=1762332749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BhAG5V72lhnAqfiaASU2O7p0+hSQreXqIdg5YGiZRzo=;
 b=dHiBO/NhXqFoTIC9RZkGu1GNty9+dF5/w9PBy4zx+JW/nJjIJSOaU8ejzdlTRw4+Vs
 w7Peua12Wl2mHzzVHu9EXqFxu+DqnVRRhgXdkATBrS9M3mzCA2OGJT4poi6QDdu8XssW
 A6G4+fsTAwJdF1ktS1wZBqrtfyqMQsm0itXibeuMamrmoMbxJv3QGiAoDzTIxBDCthny
 5y337/d5brMvIBhgtwZ9iik5Z8CvpqEGN+5ELgcpKYfdBLV3nJLTdrR4hq1+KSLs9y05
 OmyhsoByFYDRS7/usXuEc2FUYEUMKhZWHJT10hJ7VQJd9LcD6GQiSDtSjf6pga9Ao9dz
 03Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727949; x=1762332749;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhAG5V72lhnAqfiaASU2O7p0+hSQreXqIdg5YGiZRzo=;
 b=IVOFakT1mLQQY2G9n05XxwB3p7xoWpxY593wMe8k0mP3YIf96W+3aDvxR0Chx3nqLb
 nPdDt1YBi/J1s1dFHF/CIvjWssFj79KgxWtlmzM2b7U9V6UUEPrFAOlOYrBR/hOzwzYI
 et12t/haSYz5NaY6TNUjrZHX+cLBeXfVK9Z9z6A8z/jcctaA8bCidiIat9JQBLP1UTcA
 axhxhtz6twLIzx58DLlKrHw7TW801UFhhn14/2pVFV76b5EhLrEzkxLhWRznOZKyzCAR
 HwdSPFb/exMlkpQ520PqOjpXEUlY8jdIDY3cDfBvVSl9a9tR4ppVzVL8mW115ScDUdKY
 q/7g==
X-Gm-Message-State: AOJu0YzTVMP5rEac85vDYXlL0StG13Cm8a9ZG56gwvRAC6Q7dQQfL4vS
 TVwxks0NmrCMsUV5FzxyxR7zVZENoSVmOHMFCkqpS1hjKjFRwEc4UDo0dbjBiDEPeuBz28NY6sm
 YXmoq9J8=
X-Gm-Gg: ASbGnctkgOdujtQPUgwVfzIdAdioScPZiitMbja0fvFhalL3keKR0JE9fEP4fXl1zT2
 o8E5SERAXZEl6Q1hWNloQruvYx6H5MqXDO6qdMezvIxBQjtCu+KEF0Q2XZrX+Yb6qB6SqFmT01R
 sjIzNtFuV4ngq5mwPXp8uFDGLZ8fuGf0uZr6fyvECs0xlXVZg/2bOGMX2+1T5ux/NgqS3U8I7m0
 6lDdf3Ebu9Qn0W45Vzib7ciobIS0zL0kxBF2CeJm0udzcpKg8Zui3M4lS6s41y/U0xyA9a+kw6G
 UoB0d+oG4exUiU9e9tTBExXap20nQxFaq3zu5LGyh0ygjnHfPkBmMmYXyGP7QAxducyCwJK3RKi
 R3XQPCQlg6shnivH9yxsZUJAYqprrfua8sPBbEjqWQbk1I6UK1ouTHEvyDYk3HJ+vr9rQb/fXS4
 uiYWoxPbhvw+LMmyU6
X-Google-Smtp-Source: AGHT+IFyy/S+4fAUwMT9phJVuMQuPR5l5eeTk9T2TSJuSQiSEySzWhtoSbjj/by6SyEPYDey41ZXyA==
X-Received: by 2002:a05:6000:2583:b0:429:927e:f2d with SMTP id
 ffacd0b85a97d-429aefba9acmr1720394f8f.38.1761727949456; 
 Wed, 29 Oct 2025 01:52:29 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771902fa8dsm38673335e9.8.2025.10.29.01.52.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:52:29 -0700 (PDT)
Message-ID: <6815d70d-3eaf-45e9-a9c5-a706c9825530@linaro.org>
Date: Wed, 29 Oct 2025 09:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/25] hw/sysbus: Hoist MemoryRegion in
 sysbus_mmio_map_common()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> In order to make the next commit easier to review,
> use the local @mr variable in sysbus_mmio_map_common().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/sysbus.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

