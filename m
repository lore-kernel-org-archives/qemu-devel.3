Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7249FCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1xL-0001xW-LQ; Wed, 29 Oct 2025 04:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1xE-0001xD-K4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:54:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1xB-0001tZ-Sd
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:54:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4770c2cd96fso29194795e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761728086; x=1762332886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zwtDB5OsVykkcVX1bOe4drvBTNEZzR+RyccqYulB94A=;
 b=ztYsN5rpScAJ5UMv5+JtfIIU+qcnGYJHoW64INzWqF1SD0HhZbFR6t32j9eha9SWPQ
 Qg1ow1Pue34k5ccG5OJR17HfprBvCwp2NKrZ+uxq37phI9Koq2co8qV6EZ3Meovguwdt
 SYknLGy68UnVeKwM8DVA/m3aYm2QfmC40SEk8FCKN7FV47QL4SRehMW5X9+isOiVBJGP
 K6NGSD3worljg+0XtW903D3Vzt7/wxMlT6s2bKSFOYsSOwlgmGAwY8fIgkRQzjcPxgcK
 5VP7dtd9DiDyN/u4wMFgbuwd2j0AaXEkVspyKeWMi7T7grUcT4xBcImZ9MXnzq6+D1UR
 gxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761728086; x=1762332886;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwtDB5OsVykkcVX1bOe4drvBTNEZzR+RyccqYulB94A=;
 b=EZO3rOjiQw3rcsZ5pRglGB1gCBdz7Cv6q604Y9TVjcu6KWSZT08lEh9nWpWj7CYp3p
 o/A5rk5O9+H6R2raAJkTv/1YpUIGtBhB2Nz8EnE1uKdLedTkthZjvmVIRpRml38AF6Ob
 9/ZEkHUY4G+/DeRObttclw9CXBq14dz79bLivbHpUxS/iemB3EXsldAfJSd/itXmnQwW
 YTqZ6qscNL9EicIgWGI14lR2TQihPXDo4TDfCIhvzxFgTfYyLwIzh9or5n7t4IVMsGjt
 shaQVJgZyJyzwBlFQ3fWZN5HlWwwrAPS6jA3X3jUK22CsXzydL0a9BcMKSZ51CapKNHt
 PxiQ==
X-Gm-Message-State: AOJu0YzTeeApe5gaEg4FiBdfUQAN3ANO2a6PgnDvUMR3r121NoTQaGM8
 /SuZAaHqzNCo8px4CsK9YSGo+iC17xNkgBg/XQ+3xJP1x+FrhsUQdekn3lhNLDQ4/oJkVe43Jsq
 oiLrzbxc=
X-Gm-Gg: ASbGncvZoBlwxXO8nPXHsN7LZUVwiwIBh5/hVlPIttldMxh9LFHy3NtUXLBBj3t2ih+
 DHzH1YC+fREwoLJDLQUMT6NoJ+PLygpowPINwAQPZsXkkOwmpiTq/qmLag2VZxnZkIZvT1eQbO4
 f6eZ0ZSLtI3RSe5B588lIXW6XZw2G0x6/U5j/Pt0RmhHlPF+J9yYg2ShmM5yTWs7HzdKjgwOcIa
 OoC/o7hnfDPhTBQwiG5FR3Hzr8akusyLLIBNa/GvJdk1t18BoD/hVyPx4ORzhnXMXzYYAloczOu
 0rSuAjnKeOYPKYztgkgkw+Xmrku+vYNiYASxPMj526vgvPAGuUPx2cBDCmv1im4KNKLFFVk3hHT
 sfw1/grr6KloWjx8QIccZv8K5wnBmhaGO3tnoFS1/PSYtCAUeml9E1pw+/P3y/XPlMkF7W0BOgz
 r3ZgHJyQ8VvTKEa++E
X-Google-Smtp-Source: AGHT+IFjtgEAPZfj/uRdAY3xNUXpMCGL4JHo3Xk1FjF4yFFV/qrhJOVJ9Z0e/k4tIrQcZ8KPD0uMgA==
X-Received: by 2002:a05:6000:2088:b0:426:d820:a3f9 with SMTP id
 ffacd0b85a97d-429aed354c1mr1303905f8f.0.1761728086573; 
 Wed, 29 Oct 2025 01:54:46 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de971sm24773633f8f.39.2025.10.29.01.54.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:54:46 -0700 (PDT)
Message-ID: <35c397e3-6411-4fee-98e6-1bc55029c07f@linaro.org>
Date: Wed, 29 Oct 2025 09:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/25] hw/sysbus: Use memory_region_is_mapped() to
 check for mapped region
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-25-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
> Check the region is mapped in the global system memory
> with memory_region_is_mapped().
> 
> SysBusDevice::mmio[].addr is left unused, remove it.
> 
> Suggested-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

