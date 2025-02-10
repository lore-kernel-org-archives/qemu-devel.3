Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE58C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thR46-0001sb-6c; Mon, 10 Feb 2025 05:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thR41-0001n8-Ga
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:30:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thR3V-0003IJ-69
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:30:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dd14c99c3so1093617f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183419; x=1739788219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gFiFmrMwXiWeJTqvwyS7mLXXlvFNIWanCI2FweRT54M=;
 b=Md4cI5HyFPaRrFwjrpuAc8ywAvegfmO+Ch3k/Vf4ZdhjT2urrGbf/Bv8vxiKMmXWdr
 5P6NcR20tQvUshdfyIb6bzBT3loU9iZUDde7QITbPIugauYRN84jQrSGaobAI4LD4dTX
 TrQp49sJgdSsqPvAAw7yPwSxu8FPLNMGQaAh/cvMaYw0IrRBIET1j1b1ZgtrI3AKz2ON
 lIwQY1jJHmnqdCPUnEINwA6rHQVKKe/PVok6tnh+IGdtI4MDJvdjFEsc8g4KM5GFryG2
 juGgjdBdV3eVyi0f0OmfT6pugAExf830qAPhQze3grVHk08l90iscml2sEvSvUlV3tOx
 Z0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183419; x=1739788219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFiFmrMwXiWeJTqvwyS7mLXXlvFNIWanCI2FweRT54M=;
 b=ZXBdkj4LO7zTHmWWvJcUdt1+iMmT5OB+QIA+p5G/tJa8GzKHwXxbrdkIXpIqflYRag
 JuyXOBmX8wV/tyVgYkfOTMNccEzR8kvt3Hcv/u88snZ/BB/ZwMKhu+yE+HCqPfUlTyJE
 PVTOaeOuSErXaThzUtE8g7Zg9z66pM16vWslHftDgh+jV6YO805oWh1gdhlrebNYoSAy
 E9SkBd9KKl68K6TjSVOr01sIXdrto5FE+D77CCl433cHsClRjN/TR3YClmAmaeeURAez
 wp3VjwaJL/1OwhhTXQteyLICkBq1S1dhq9/uh0wNMOj5pfH4uZeQRJhcZvDfzrWerKRK
 loYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULCx6akJfotPcP8+sIjCt2/Uv4few226YXwK3UDq4mm94Ot7ddUbAk9b8LriuWKt6OxWekhY7dGDl9@nongnu.org
X-Gm-Message-State: AOJu0YwWMqScxt3aAelOl690td+ayN7V2f0L6ePSdUlEbYC8ukcvNjWP
 ZUyoWf9lRNadlIV/iSIkW6e8JTp/7pQmqWvTfCcrd8ViQNzcQpoIyS681b+P24hCFtr9eL1RMBK
 VI1E=
X-Gm-Gg: ASbGncvMB4Xb2vc8J0mDQZQN0Phv9fCB0O8Ezdh2xRThRv//tdJkSbkiuUtQ/R4hjU5
 cmRlj02HHRckTfuHgEGVrugrvHzvcgbVWg14or/snu9qxkiHRa/2ZIidQ1IcxFUuiHAVpyMLs2P
 J4AXL/Du4hEPf1CTXs4tje56Ybcq+7uxIVw3DdRreYfvz1bIbJ9wG8pQRPLFA4KIB5tPSjeLR1y
 PX54olmYpwfx09O8wE5ghyndwrtJuJhz+lwjvUsAjVeSWwqhlHIO75bqNBl2mY0mopPPrDtbmNc
 +nHWeZOfOCAzGMWmxDdLbZENdmb+IV8cs252Kh45rEA5mEQl5mnUa4anhmkdhvtO
X-Google-Smtp-Source: AGHT+IGvdkuq2z/VkhoeOf9C+C+jAoROkXl1LasUDwzm8R2nIOyaJp4552SkQP9RY4ZKsrLhDWfuPA==
X-Received: by 2002:a5d:6da1:0:b0:38d:d946:db15 with SMTP id
 ffacd0b85a97d-38dd946de79mr3436374f8f.5.1739183419499; 
 Mon, 10 Feb 2025 02:30:19 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd44c5e3dsm6479076f8f.62.2025.02.10.02.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:30:19 -0800 (PST)
Message-ID: <f36be293-9e46-4468-a74e-3122929a5547@linaro.org>
Date: Mon, 10 Feb 2025 11:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/9] rust: remove unnecessary Cargo.toml metadata
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250210102255.2555097-1-pbonzini@redhat.com>
 <20250210102255.2555097-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250210102255.2555097-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 10/2/25 11:22, Paolo Bonzini wrote:
> Some items of Cargo.toml (readme, homepage, repository) are
> only present because of clippy::cargo warnings being enabled in
> rust/hw/char/pl011/src/lib.rs.  But these items are not
> particularly useful and would be all the same for all Cargo.toml
> files in the QEMU workspace.  Clean them up.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/Cargo.toml   |  3 ---
>   rust/hw/char/pl011/README.md    | 31 -------------------------------
>   rust/hw/char/pl011/src/lib.rs   | 14 ++++++--------
>   rust/qemu-api-macros/Cargo.toml |  3 ---
>   rust/qemu-api-macros/README.md  |  1 -
>   5 files changed, 6 insertions(+), 46 deletions(-)
>   delete mode 100644 rust/hw/char/pl011/README.md
>   delete mode 100644 rust/qemu-api-macros/README.md

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

https://lore.kernel.org/qemu-devel/Z6SSBl3j9DUgdwLi@intel.com/

