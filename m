Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C308ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yTs-0005Ph-KN; Wed, 01 Oct 2025 11:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yTM-00058N-Sa
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:10:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yRN-000106-Ha
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:10:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso9018635e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331297; x=1759936097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AIzO+so5KPpKzYj7ZNyXWUr3LlH8ilSE/g0AxNVpzLk=;
 b=frX/pU08FU3nH0HNXJNevCrdIKND5TwEvt4g/ZLwm6F/axJCF8831FIDag2g6BqnTw
 XWc4EbXNoHROVeaCcnFxBsQBGZMU6oomNTHesmXBPY+rAilcJ5JMR1TO+KWkJMHcLkt2
 vV90WZIywuyW1Rpg1EydMjJi2L5w89DJu911O/5bwBU/mT6jRlabNDDdjZ6GMtyKBzlG
 gB9aCNWbVf4TGyL2aaZYir2S1gYgarv1lS7eZs2bd/Plcwr6O8BnPiU+qTcjsK11heC0
 CFpeIlpazO+NCLMjqPKHMjTE7oSG2MWr33/N6HIJIQc9ubKdtU1lnrMGRmru/V2A+gac
 GzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331297; x=1759936097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AIzO+so5KPpKzYj7ZNyXWUr3LlH8ilSE/g0AxNVpzLk=;
 b=U5XYtbh2tG1MFTaUleMYLcTmd24DtSiHR7c3wCXr7zK/aiP07InzL/sY9wuIp1aaXd
 AijJvBUFhJCAjin79CFEcQNnnV56E+u+2TLKyDSG0v9s+4FqwoP9i0Sp6gbhKbYbeXn1
 6nupuG13fsNcE5UTTE2vgvVhPbVAekwgyOdObW0ecsWLlbaDVjskaJwsLuMnsOeGFx1I
 0an1vUG/SY0Ft/MiJELx7f49UzUdgGiAGwXZF74JOCGAR8WnB3SBBvCm2STTV+mNCQK8
 aNBBROydzRKHsqkvQLbGpPRJR7z7Z28NlFhTIjr9L1RkJziV87Wbn8zs7g8L8srwv+J3
 U/gA==
X-Gm-Message-State: AOJu0YznyMRi12MBpawUHCY/UaTk90Owg9MyXiSY2vM9RvkO2j2d5LGx
 9pci4ZhztuTlNsXGx8UdtzmixPKCC1R7knGXK6vtjF7Or4LqkwxTsHVetWNYjRKpfg3++iwj+lR
 XI4zmK+FrqA==
X-Gm-Gg: ASbGncsgaWef0/JivIiosTfIt+cH416LeLMT+fp+u6PW08bTvGvumnO0cSHWA87chef
 bMgxYuO5ElRBkWnXkszKYsVGQ3nt2Ni5QttdAcxsOPRf4gNBidf/vBIy703Q9MdkQxXUhQa0s+D
 wdOOXPPD/3pLADd3lJYAZZuL+PkjYMiW1alxOGF0v1CsDkbpciAxahZHlpCSBy1awQrYtRqYqp2
 T2TKnWLlDE69Jw9NyL8z5amJ47SjwCbD0aXqgQQvdCpnMvUjNatKZoB34pGFZ35Qx8c0Bv6Mzdz
 FUAg9WQPMYb/tBXl/9woiuKwlpKnVbZ9g16sWDgf3+Ijdf65w5VgjjumeiL5aVFBtPlVe6bgdcn
 MyyzNGUVIdTB+R0uVkLtDShaANthpKJxL+aNm/YM5mHfV8qpzXG9wjW2q6o9x7E6GrsAL3vUUrG
 9fKYjcSGKaInBEtw==
X-Google-Smtp-Source: AGHT+IF8lK0vCB6Jq0ASp5XON3vV1O5ddVDMpb/bh1bTP5csPrsFSBh6gHEnoWssD9AA1CELhwJX3Q==
X-Received: by 2002:a05:600c:8414:b0:45b:8ac2:9761 with SMTP id
 5b1f17b1804b1-46e612c8a6fmr34590585e9.13.1759331297205; 
 Wed, 01 Oct 2025 08:08:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9768bdesm27674817f8f.23.2025.10.01.08.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:08:16 -0700 (PDT)
Message-ID: <755adcfb-95eb-46f4-8c73-34c43e6b85ab@linaro.org>
Date: Wed, 1 Oct 2025 17:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] hw/core/loader: Get cpu first addr space with
 cpu_get_address_space()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Alistair Francis <alistair@alistair23.me>
References: <20251001150529.14122-1-philmd@linaro.org>
 <20251001150529.14122-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001150529.14122-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/10/25 17:05, Philippe Mathieu-Daudé wrote:
> In order to remove the convenient CPUState::as field, access
> the vcpu first address space using the cpu_get_address_space()
> helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/generic-loader.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)


> @@ -130,7 +131,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>       }
>   
>       if (s->file) {
> -        AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
> +        AddressSpace *as = cpu_get_address_space(s->cpu, 0);

Oops, I missed the NULL check.

>   
>           if (!s->force_raw) {
>               size = load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL, NULL,


