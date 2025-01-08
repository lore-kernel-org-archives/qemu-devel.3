Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ED8E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 20:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVd81-0007nE-38; Wed, 08 Jan 2025 15:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVd7z-0007mc-Mt
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:58:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVd7y-0007bX-2s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:58:11 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so122942f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 12:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736369888; x=1736974688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6EP+H9vs3RZsSrBEy4KUT2vK7/akYOcuaOfWMAj8iPg=;
 b=YPeivN8YRKBdaeHX61cuc9vxtt+jrcWZBT6RqZEeVhJK+kZfPZ0wcTgfRmeW6PCrO9
 FNJxEzrYhU3nXyocy1MGcfX4/Sgc0D8buI9HsAN8mfnCEh4tE95RzNtAmhmce9RZZL2A
 HzA8hWYeQsM0x09Y/kZOGCfgCFZ9LRRRhpTGJEoUrKY3UUIx/8FnttO2ZX9Q7fpefI7B
 C7cS9XGChZnFm2b6EdFjvIRcuQR5inhk4teSHjKVvkC21+u/HdtgrFM5dB+HKn8LJd3f
 d9++82x2zLx9RfuZxaZWnZyi8a7YB8BsKqTcipefjFNxsrs3NESrqbmv12+wOvBDGSD9
 PDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736369888; x=1736974688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6EP+H9vs3RZsSrBEy4KUT2vK7/akYOcuaOfWMAj8iPg=;
 b=bYlnDgZ1aHgYevaHYMpWDRjeEFlTVDEeIHZkjnbciz/ax2YpK8j2IR7UVMg3MKP/TE
 MzWKVsUaobwbu6+s1XkRZAaiP1zVwb6Bz1NlFL4xWDMr4Fva4erqjUrKW2Sy9GoPDGPN
 r9mLG6CbyK5iLTQqCz2WMOonA5Ko1cuXEEae45KHzds+1lX2itP0fyNGlsoxJrKlsl4l
 xhvG3rfbj011tcFwcXEwmDNi26iOPxM0AURqMF3fxsf8ag77V9d+i9ruSd9AaHMt02wA
 qp6deELXXRKUqmt3KSMA19bLO3c/sLs2XPW6KtMqGYKMkpOMTcR+zeesKMJ2CELzNBhz
 vwZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy4YwZoudc8jE6xkriFFbtmyKw1g1E9xbHr5NWhfh6vDflCh0obM0xA78+ZLev4YlOJqOk7OwDjZ/T@nongnu.org
X-Gm-Message-State: AOJu0YyAV3R+i5RgwXQJE/I3ZCqGpwh0Z4/iuDa0F0a7HfbclWFXPHW9
 f/CYcScgKj85plLWl2zqocdwBjspU1dufjwuWJa/6aWJohniOUOsr0vDFktHLMo=
X-Gm-Gg: ASbGncu+jnJZZZ9kF5c7qh1VTPTXw9QuDYrP6tLzseAXitBat0N/w92uddtbmvH7eNF
 b8MBCs3hgK3danTWj9vVWRglxpOxbFff7DVtZy36jNdnQfa2aaolFpJoBSn1GBgJPDL+ldVN+2N
 1Z/kTOmbraPS4K4OH0OBLHF0374oumukotNq68MtJEednSvAdgJ2MuxcL4IdfUttVyEGLLbbvWg
 V4DudmxvNNEuA7yjJzylLBCPwepEYPGUwVvDePhKz5PW4NseCBiNK45TJ0vFSgiwPf94lX73QWP
 HYYfZbE4kyttZlo00TsIS+OA
X-Google-Smtp-Source: AGHT+IFe+DJh8gIs1CY4x/ZCM0LOsRvYFVVIqBGD4Kdn8UZUtUvcAWJHUWDsPBcU/qqyZ+kdjRry4g==
X-Received: by 2002:a05:6000:2ce:b0:38a:6807:f86 with SMTP id
 ffacd0b85a97d-38a872da793mr3517896f8f.17.1736369888480; 
 Wed, 08 Jan 2025 12:58:08 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e528sm54437305f8f.83.2025.01.08.12.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 12:58:07 -0800 (PST)
Message-ID: <22a19a9f-47e5-47eb-b9ea-6bd2757b5c90@linaro.org>
Date: Wed, 8 Jan 2025 21:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 59/81] tcg: Merge INDEX_op_andc_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-60-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-60-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h          | 3 +--
>   target/arm/tcg/translate-a64.c | 2 +-
>   target/tricore/translate.c     | 2 +-
>   tcg/optimize.c                 | 6 ++++--
>   tcg/tcg-op.c                   | 8 ++++----
>   tcg/tcg.c                      | 6 ++----
>   tcg/tci.c                      | 5 ++---
>   tcg/tci/tcg-target.c.inc       | 2 +-
>   8 files changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


