Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C256C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBZ0-000056-5W; Wed, 26 Feb 2025 02:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBYy-0008WF-Ir
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:10:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBYw-0007ok-CC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:10:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso3191475e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740553832; x=1741158632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2gYeRv7iRCPka2zIZesCkLRkYl/+6bcBw7EbAQzLlMc=;
 b=F37yLyooVIO5o+QQZ05AeJfyjfONYRMA6G/iLdgi1Jn5+9nsPYi5m513UfOShc5Dqc
 X3LFguKTV2tlUv8lKCRk5spTjaG15jNOXYURNY0QPCNNtnC568G2GeSirL/pgT5XXbA0
 /kymj6hwufGC2d1XO+ugQXiBIl3qqj4yc61reXgXfq6qJ6VkPSY4DVcVXRY7OVInhw/Q
 6Bd3bRGE5W1aShjvhSUv+MFN6T/GhTtT2P1Ic11l75bNhcYP9eSb3/Bjck9HZKc+Gf33
 +ZD/AZDQI9OHcNwcuiTkdvnWAbjF5YY3UfHWPe3FXg64UAyQiQKBMNKulPIg3II/AGwn
 Ql1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740553832; x=1741158632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2gYeRv7iRCPka2zIZesCkLRkYl/+6bcBw7EbAQzLlMc=;
 b=JrdccQDtGMdUjWZpIbIvtQ82EoIgIbP2ix4jmPTOwO3JEfbrN9Er3lK3Ii1tBtAcX0
 3Q4A96sAj5kfbaNVhfPLirjd3jnUKYUKGmg0oUYfVpPwR9qIFmsZateqd1LjKvqEdlXG
 6YTZZjPJ1z788fBORBHSWQmN5gerfH2gNeKNOHHs/klykmpqOUU6DiWbiQY9YVNKsWLN
 iUbWJEV8QD9iGQE+mkPZaMuETHuS478LVDdMbBNdh4jf1qgdFP5SvazNi1Ner1aIA9A2
 T1pkv2yEQg6w3riYV5mAmLDQ2PBdXHJvFcDudft4ETg3sm1F8AeCOQMLlWIuX+kGWAyS
 i0Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdqjLJvm56MEc0NmJjI4Srm0PBfyHaICzE0BgXkoo2ZoOuQiH7v8RgbKHXpkacHINviYutld5mISXt@nongnu.org
X-Gm-Message-State: AOJu0YxShkI+rcMwOlCJSwJHfJjhthb5Knaf6gMbIoSMA9b5rAXghnNJ
 uNHksdd4glWluUhc1wrBf/qwbt9Fy7YeC5oGpg/cPmhVJsaO9Kdt8AMQh41uLYk=
X-Gm-Gg: ASbGncvD/HiaZeoDXlgxOefQ9eNmCpvqsDECMN922ukCiYLGaDzw+b74H/42D7dVAJu
 tOU7ypyTKfD1eXvcjPHkev+iy5Jp0VabpFO4SYnL2xLlnAMQ6vK/gD1lGFZIpRI/zQFOSNZbyJ4
 bto+vw2WhCwtpIhNLNJILjts5zeI95wfMxQeOCFjfVOrfDy6M0KKMBK/64rrcj2lVsfmgthl75j
 ZRyutWU5rOnWXLV7Q2Q0Zrre5p4MkRMal5SMs78kyDR25qm52zcsxbqYOdFtd3wu4o9Ikea43Z7
 ryKfECA2BnvxBZ5l7WJ9HtFyvNftUvPfwrIMPHAFrSVRNk3bY/5NbVmJ9gREEOrKusl2aQimbik
 =
X-Google-Smtp-Source: AGHT+IG4PyHItjccNloGyGBFci+KaBDuMcjZjJcBrn00g6sBn2zFl1S5OfXToDKyu5AB+3PF4y0/Og==
X-Received: by 2002:a05:600c:1d0b:b0:439:98fd:a4b6 with SMTP id
 5b1f17b1804b1-439ae33cb6bmr170610995e9.15.1740553832039; 
 Tue, 25 Feb 2025 23:10:32 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5397d2sm10944375e9.22.2025.02.25.23.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:10:31 -0800 (PST)
Message-ID: <337f97b8-2026-481e-a3aa-a12af05639af@linaro.org>
Date: Wed, 26 Feb 2025 08:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] loongarch: reset vcpu after it's created
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-3-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207162048.1890669-3-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/2/25 17:20, Igor Mammedov wrote:
> Reseting vcpu before its thread is created, caused various issues in the past
> for other targets. It doesn't cause issues for loongarch at the moment but
> to be consistent with the rest of targets, move reset during realize time
> after qemu_init_vcpu().
> 
> That basically prevents reset being run when when vCPU is in incositent state

"inconsistent"

> (i.e. accelerator hasn't initialized vCPU yet).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Cc: qemu-stable@nongnu.org

> ---
> CC: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index e91f4a5239..15018d43ae 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -634,8 +634,8 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>       loongarch_cpu_register_gdb_regs_for_features(cs);
>   
> -    cpu_reset(cs);
>       qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>   
>       lacc->parent_realize(dev, errp);
>   }


