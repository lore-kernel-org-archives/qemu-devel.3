Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED465E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTtp-0006ko-Cj; Fri, 06 Dec 2024 03:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTtn-0006j2-I0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:41:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTtm-0001NL-4a
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:41:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so19857425e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474476; x=1734079276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7LXJTAkpA6lTm9Xnbzp5+iCARf4cq6KrTqF2RNcWzI=;
 b=wQCi1ee0t7whD7quBqR6CttKWzxGJNNRCtpmSLIbKzElZ7DQ1tcwbH0xOaIkdY0fdb
 XV/G8mAI38wotwWeg59ceB16JZooqApGydSjIH/cfbclhlcrZIgoSDQ/uqaUtBlOIDGL
 IihYiWM3o6s/qec09fgRVVoiGdLMKewmnlZAEQQ9kTbknnSJl17fOQkXqri+eDQQTp89
 VVq9x/VxljcU8Z0lBF4xSOn1FrCMQi916K/0hcPUj9NUYuulnmdijEy7w9PMF3Dbvuiq
 YNTr6jVWwPPaHGky1YHIDKqFXeJcLteodRZOWN2VyiWN3+yXwtOLb9a3/e1aKBVgmj/n
 nNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474476; x=1734079276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7LXJTAkpA6lTm9Xnbzp5+iCARf4cq6KrTqF2RNcWzI=;
 b=OjERfLyXCZaBL8vZJymPbkGW6831/TQjUeWV/fjNzALs60de2ZdQhB5YV0nMxo5GW3
 NsZI3YXvNfzmfVfouW0XDj+MiC1CgbHReJ0PCWkhFcp1j37HdINJgZMFwH/zqSQJMxyS
 O/974bb874FHoyZRp+DyEIRFYQ1FpndQLOtshxsZdCEXwvt3UsPbBto0u0atMWTRanCG
 iRdY+SMJ6nSGY5AYQW1KmY6ub+TX9NyxU3t3kaaOziNFXPAsyMBTN/W7BWmASMrykFpL
 j5g9KuEnucldI1gUwwlCLjkSCwzz9ALQTH94v892qViFqgOU24aJPd1AYVqApulx4PLo
 xORg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLbW6fZ5BTiCObKSVgQhKqm63njZpIV92tSPmV7INTHbGUlnduRrEU7qNfbLIslLtU7upZ703SiQBE@nongnu.org
X-Gm-Message-State: AOJu0YyaI+dLPb9bHZ+ly/NyGvDInraPqIBZ6qw52N6phjSRqtuj5fO9
 JpvoG9NmdMhBXrG4lsPllWq7CS4AbOpn7FCyDeQGeJy1ul8lfDl5Qny54orDXow=
X-Gm-Gg: ASbGnctJRs860Hxf95GAvyeFAR241B5mqA0Po3knEQ/T3imPya5HFycmLrAA2BKPr/J
 SlTvmJb7Ggl872AWx3uRek8IdAAMxmNc+YCLOk1m1bIMeqQCuAiIAajJhQeG8kwhdFvVquBnMYB
 PyGwrNRLB/9zi7crMbMlnEe/12NRdm3Y7NGtsCO2aPD6fQFsqgOfWbSbCC53xhctuak2Nh499F5
 6hJMxWYShBuEXtFjJKGX6r9iIBcMcLdk7wUF64G8Ujl49AyuXyXBcGCEuBI4oL7b6IRqe+FPVDQ
 xyrwYyY6ULlBoNIN6w==
X-Google-Smtp-Source: AGHT+IHXwqtaDFN9Q5WRz3LK7MHUFS1S70mqQh88TSZC3/CE8iC6GNtnU0W5HO8SeWmLvchVvD2KZA==
X-Received: by 2002:a05:600c:4712:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-434dde6b312mr21015405e9.0.1733474476440; 
 Fri, 06 Dec 2024 00:41:16 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219098c8sm4127372f8f.77.2024.12.06.00.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:41:15 -0800 (PST)
Message-ID: <08ed4f7a-18ce-4797-8144-944ea9254df0@linaro.org>
Date: Fri, 6 Dec 2024 09:41:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Use float_status in
 helper_fcvtx_f64_to_f32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031952.78776-1-richard.henderson@linaro.org>
 <20241206031952.78776-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031952.78776-2-richard.henderson@linaro.org>
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

On 6/12/24 04:19, Richard Henderson wrote:
> Pass float_status not env to match other functions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    | 2 +-
>   target/arm/tcg/helper-a64.c    | 3 +--
>   target/arm/tcg/translate-a64.c | 2 +-
>   3 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


