Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3AED637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfgc-0008Bi-Aq; Tue, 16 Dec 2025 19:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfgZ-0008B9-M1
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:46:35 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfgY-0001Uw-AP
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:46:35 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so5957574b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932392; x=1766537192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DEUdmKIuqgmrXUd9rHHRdIozeKWgL4Wknky/5d4c750=;
 b=TeyhBnPOVo4Eg9lXRFJ4CWpwL/VR2wBiMIqmcSyj5soImDbnCuT+G1fNqE5m+SPL41
 wxix281z69Gov4SeaQOYjmiAafU5ZGLzOdmLmnUHpmetNPXmD92jfJ4ygOMMaEddkdYF
 2hhTkDCcubxhEmYp4vjFfsr4aEIayfry/GbuyN7HpPOQGy689MdZZZDaFYJBcX/z4cp0
 ll0E87lG7dDpvBjFGEpVYUM8oBWk2dhqJRYCAH9U8ER9eTHlCkQy6vlvy3s+3mcIamI2
 fqGgVeeuUqoPLe+WyQlsO2BFQI/lwGsa5H/DRyFhHxIbiOmkErGEJwz1ezJFIkT7PwIY
 G9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932392; x=1766537192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEUdmKIuqgmrXUd9rHHRdIozeKWgL4Wknky/5d4c750=;
 b=AUw0okPbGi0XOjpNuN5U/8oCynexAJ9CznGLVeYLhv+DniUtwEZ3q4OnZKyjYbVZKW
 QdZgreyWA2S1CNFv4NfkT67yJOitp5YmVturC2FckAKWixwjpOwBsAY7KJdYqv+L1pLl
 JBWMFpKvCFnaQut+65pfQoWMKdFA80HbFfYUAHctFil5derTVTTVUZvZrYJDzQxwnc+F
 msUzjM2XdUxEHNOD5F0hWz3Q31pZEn2mas9NtTjF+AugORSjLi/mcmGMjBKTmopeNQBP
 X63o9NJrgVIYujGFadd4Q5VQGttku+niCsGsmr5NVBR24g+QDxww4JhdR2gbo34/PqTg
 q1og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdria6SdnYJfmLxHF9Kw2JW2cz4oTf1Tlu3IiXHw6yo0rocrrZ47ubNn4fzSPm7zNkrQiTloVbkPWF@nongnu.org
X-Gm-Message-State: AOJu0YzdMjh7Yf/+H3DqScO9qUxlYudADYtp1l7dIvTYa4PLn/mUtHHF
 lL9EGA/qY2bWZJbdogl15s/l2hgKCZGPUCcJ5ZjNLppdFli5S8+6CaEU6aDAiasjRus=
X-Gm-Gg: AY/fxX4mAfuSgH9bWiW0SmYf/4CsNXOS50v72LHo8RMQVZzeRmH850TMnuJsPTkwCmb
 azJRXah2/hj+uiLIXgwx7lppsY8aBEb5tJ9JzsVGAm+zBVVUW1s8sqS6uE38KpIidEIx2N/Zqr1
 XCvq+PLpzUdzS+Pkz6wYY0zK/Xgv8wtkVblsqNDN4LvZa/p+xBfgrmJ4EjdPrSwtgguKx58wmaY
 e7o8WrF0vNCzQp4LxcWjSPYrSmgAexB/ZJ/ndv3RVryTevy6FlM3tCdumGWTDgiP3FT+SIHgQ6G
 hjulJ8h0WcC0eA0uTZhZlv6hqf5KDy14RBRRRsfwkSINC4Dp4Gl0G27GOK4VXMKdSLUvYsNKHMB
 37yqOTdhZ4BpweFgfcGYPT0Gidjgk6S28Lwb+JWemYVulDV8BAYmTHyX6ONO3x22KGKAeNriYfV
 R9TvxKsIIrAikSLG2tG2UpFg6orByF1tWGdESgbjCclY9znJ1Y7aNSHI0=
X-Google-Smtp-Source: AGHT+IGEDJIe2ZtavDb8H7OzyhY4u2/Cx87B2vsYO1X1FhcjgmKOHzUejsb+J5neR72Uvzi1qH1mdw==
X-Received: by 2002:a05:6a21:328a:b0:366:14af:9bb8 with SMTP id
 adf61e73a8af0-369b04c69d7mr16124827637.66.1765932392197; 
 Tue, 16 Dec 2025 16:46:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26fa703asm16065970a12.16.2025.12.16.16.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:46:31 -0800 (PST)
Message-ID: <6f4e91a0-790d-4104-9eb8-b6006582a491@linaro.org>
Date: Tue, 16 Dec 2025 16:46:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/riscv: Make pmu.h target-agnostic
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-11-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-11-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/pmu.h | 2 +-
>   target/riscv/pmu.c | 8 +++++---
>   2 files changed, 6 insertions(+), 4 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


