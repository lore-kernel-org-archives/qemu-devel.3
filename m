Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2BE10F287A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GZc-0008Me-Ns; Fri, 27 Mar 2026 19:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GZY-0008M4-0B
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:26:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GZV-000792-G8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:26:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so32722215e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653986; x=1775258786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DlY173GHES0KvWxNcJWtyThmhiS1t7oZSgQDwDaQ4UU=;
 b=upJKb79RwID8cX1LyOKtzAiUkGHs7HVJSpxZUtFyStyJge1xhLAgLwoR+mR78QFKj7
 Q5d0aywS9SCd9X2CGQDYfJQuJov4KKNG7yB2UpprcRN2U8qjsWoa76Iy6eedwRpppJGL
 awDRSTqAQv2zRndpmVDzOnMdbpNrhaBnwDDo8ielx6HpidU5PINHrTNNyjuC6RHKkam1
 f842GTDu8FUNDEAwCm4KDsmdQcegZsnAzJrGprDEnrwr/ZNPCd8YfT3padvaPbkbRtPE
 rvaXKIMd4zdJO6VglCJhC7/f7syTDCu1waWebbXR0oNf+QSd5uAP2TNV3wDbWw+qLnar
 Lfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653986; x=1775258786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlY173GHES0KvWxNcJWtyThmhiS1t7oZSgQDwDaQ4UU=;
 b=nuIwhOCsexJmu3kD7NbndRcTtds/Na2ozevrV4xi54mDlInmMYcf+YQt/cARWJ0w60
 CwBsaeW0i0+275yH682xMvXta2opXRl6EIkSvn0WOQ9nNAOmx4bcmpjcQ8yOxwuqF2xj
 1xtY44HQSRwNb4h/34qehmT43DpXNELWr/NDM9ijUCUha11JamOLXwMYeyqStKpYMHND
 5rrOTYianJVMg+dLudK/+RHhSAO3QkvpDo9eqGvkNmYPQHXGLkwdwUjEerJppAcocUf+
 k2TQR9yUjAizFxYELVHfFN1dimdQTdUfdV5NvSBVVVBIHYLNqreWyydjUsvQ107b8UFX
 /Lrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIzmZhDXJIeWHqX3zxILlkxArFSYoH7GiXX/ou1dfEhuOHnJ0woXTtltU62QeZHwCABrfreqFZeWM2@nongnu.org
X-Gm-Message-State: AOJu0Ywb9BLkWWDj09XAUgaKLbhgQi9cfFOQxfAsME2FjrhcjbAlA1eD
 tnxmeYjRy15R9UKvxP/0ChH+bKy6ydTLWXPnB87PkZ0FEY2AIbj/MZe4u//qBrJwlIk=
X-Gm-Gg: ATEYQzwc10/Zqk8Ar7NiK6jBIyvb+CYoMJrA3XvMDZusT5R1tGykxTKO5FpNUSCzpNo
 gkE6aJAL7YJaw4SANRkqwUQdL33a0fqfN5cmUDi9KqoHExRGvYblHrffRo3NcWTQ3HVGWUbNRY0
 K0x4nrWP43x12s8i/MklZxvWnvEq34jkkqUlh5RxYsJDLMK7msgTSemgAKeJAp/Rbwv3Zo4qgrE
 WPCJyq1BlYPy5wznLfDxQGg3ApMU4iYfED+cT/kxcgrP+KDL+uRqDMfjKfz7E1YO1hSQ3KtUc08
 dXA0KuuidbVrCSM4xPdwwNxEX65Qh5AZz1NrRMZ8AXY5SSO/tW+vOAS9vTCWaYQI2wbo1Wk6yUH
 a270qPhZhOnqboPxDKLUfl5GtElNzx7uTWZVQopuoQpU6t+yqbjOJumbBuIMBkLUZd1yu7qYmrP
 9XbjigFPsraLzA0q3jE8/ip/G4e81HmiMoNUPJMvUEdAAgLostComEVwrP8EwooACGph3wJjxt
X-Received: by 2002:a05:600c:45c4:b0:486:fe45:483 with SMTP id
 5b1f17b1804b1-48727efbed2mr73079765e9.22.1774653986466; 
 Fri, 27 Mar 2026 16:26:26 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722be608bsm153255555e9.0.2026.03.27.16.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:26:25 -0700 (PDT)
Message-ID: <dcb18b56-4fa3-41d7-81aa-3ef38d60a144@linaro.org>
Date: Sat, 28 Mar 2026 00:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] target/arm/tcg/op_helper.c: make compilation
 unit common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-10-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 17:50, Pierrick Bouvier wrote:
> Remove unused header accel/tcg/cpu-ldst.h that has target specifics.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/op_helper.c | 1 -
>   target/arm/tcg/meson.build | 3 ++-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

