Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D200EE77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 17:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUqyY-0007vA-HC; Mon, 06 Jan 2025 12:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUqyS-0007uY-DQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:33:08 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUqyQ-0004kh-Sg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:33:08 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163dc5155fso208004255ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736184785; x=1736789585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zzjXJMqHg+79+/vGgS5TA9DD7wflqECYpPW9JAfr1F0=;
 b=tbK9RsbbQbC8K9iy3P4kHsaQz+Rzt+vf5WmBUmvbZBsGdPd8eq/xvpZFLJCJ/wawAu
 ViFwiARLJCj917EOVHXd6F3jwuAq2h67PwjccsBQRfDRrBD3t/TN/QGzvZCD8D+4xP+Y
 +HIktsf9Ljod76GoUhIKIoxQl/MpTY7vEB8hAXUTuJHOCXFDeXruSENWKGly0pd1UDEO
 fUzo+VBdomASqGQbLbMmCS+XwOvvKcgKH9d2+xMFhYb4TxAEQ+yF7aKv2ht4419BbpEf
 YUfraDYMtFZBKYakhke7dLf5ix1EDv8Ppq74trj0NuGNRQa/NXbh5R2ZHHS8Klm2KysE
 Mb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736184785; x=1736789585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zzjXJMqHg+79+/vGgS5TA9DD7wflqECYpPW9JAfr1F0=;
 b=Bq0obsAxaYvhW+uurKmKae2oaDwbn34CSN6w77wI40+j8BShcKoqJKc8Cewuz50gHo
 71LKyeT04RCsaHf/sq7W15sULYnhVE5oQp5MoqwZPUKr/QxFPooDthwv/HfbgkC+t/mi
 jAIxV4YWCJ/86iJKnR1hEmJqQ8HCX2OV05J075Hz3hzjLpH5J5gDJKC0WpZjbN9tjcjZ
 2GvfgU2lftTPfQYIyU2/hB9VZVTpiYeWtj/jZwyqLtMQLcBSSEvA9j25z6Fbx1J1RNAV
 JjBMDaZJSb8DhhGGoK6XSsWSQNZVNXdtYaNAQDkV/pnV5ZjsF4rTROYwdXnlT/ODyRrz
 bZZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPUFm/t83nLtpEjSLcYOcIoDIc6zCy91O9ie4iBj9j32gVU8w+wh28Z6LoryN5BQ2JAQ7VGvwINOC6@nongnu.org
X-Gm-Message-State: AOJu0YwLYMm0o7yS8w3bLnjI5M6S4qnFdZMRVuXYal1ETcqCFX1Iqc4S
 p+9IeB+a0aYN+hyvmb2yOcy6BrBzWQ/lJjy7/FbQ8ZzUTFM6C8ma3o0UPwLPhREgNg4PeYaXUBe
 u
X-Gm-Gg: ASbGncsOszpAxFGB1bvrARvl4AVbijYzUAMi5UGng16pnT83zrrHPK0iEHd0oE9nwQv
 OsSwTyPE63TN4RUchSyVMurXHepF8Yh89KACB7Rd6efBBwOh7wXlK8Z92tbVo4HOHLzTtGstoFI
 EuWqkW0/yIwp8mNpzkak5Gg2fO+SH4jusacOoTgKvWIjhits6R/WwVPEUMMK2zklQMWb/kHvj3+
 EkreTG3Lm9usVBG5zIlY8MlaFOMJZgNmpgB+Yl3BDgsWTowcN8FXx7i3YxfoqugN/qsPu4GFlHH
 anDEsRW24UEndq2LxflR7uLkKzfSqYY=
X-Google-Smtp-Source: AGHT+IFwJQvdYX3tbA+W8D4b/0CUDFtrwMbh8ElRep817NpAHiWpRHEtigTwNMBd9lU6vbeE/r8JuA==
X-Received: by 2002:a05:6a21:3983:b0:1e1:f281:8d07 with SMTP id
 adf61e73a8af0-1e5e046ea33mr91049871637.10.1736184785185; 
 Mon, 06 Jan 2025 09:33:05 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm31715405b3a.15.2025.01.06.09.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 09:33:04 -0800 (PST)
Message-ID: <4ce6f778-cc35-4481-892a-f4ecf69d9059@linaro.org>
Date: Mon, 6 Jan 2025 09:33:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Try hardware accelerators (KVM, HVF) before
 software one (TCG)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250103150558.1473-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250103150558.1473-1-philmd@linaro.org>
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

On 1/3/25 07:05, Philippe Mathieu-Daudé wrote:
> As Daniel suggested [*]:
> 
>> We should consider to rank HVF above TCG, on the basis
>> that HW acceleration is faster and should provide a
>> host<->guest security boundary that we don't claim for TCG
> 
> [*] https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/vl.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Do nvmm and/or whpx deserve the same consideration?


r~

