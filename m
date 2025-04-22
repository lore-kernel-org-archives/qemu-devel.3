Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CE8C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ICr-00063t-R0; Tue, 22 Apr 2025 14:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7ICp-00063e-K7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:18:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7ICn-0007KN-I7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:18:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso53125955e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745345927; x=1745950727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bub3nfUHwqUUx6cZnFjcbiUcpyM5LZmNfyEU2wGgs/c=;
 b=KWZsULVvFMHj+DmtfT6TEzwYEu9+VEAKUPcwArk5lCRzcEgHYMmjk6Kiv9YxVdZTob
 H57X7pI6Zj9F1FfnpKPnVP3z2E+9poLA/sXuHd68+XlNkHN9+OIR6u3FJprOurOoB8Af
 ALCOCZpnUA53WGuzyumNbyCkWIT3R8cYUi2N5EkOVCI33mRMLbSeyKuSvIdHhQZ+PDwB
 rSYaD58dc6F3y5gPVBmPJSSjSvJDbOvGW0Ak87aNxaPS7V0YtPKcRuQkVYvHCXEeyv1k
 f+PhiE473lYcJnN5Z4YRzPzrLF4z70OMTFNC/3sEv2nW3uj6M81gxHWkoAAqp7mQ61II
 gXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745345927; x=1745950727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bub3nfUHwqUUx6cZnFjcbiUcpyM5LZmNfyEU2wGgs/c=;
 b=fk7bmrrB/V/vQU6M1nrDJFiNaRQjxr57AvhUS9HWf+IHcxuUqursW2a7wEQns9ozEW
 SZLjLd1ajRisAcfPEQCWX5uKMedyMyjas2qPuH63hSsvKBNvAsy6epE3Xxm9D50+SYih
 09g5KS6cwnWVvcHRpwsYvOR3eavEazMkgBKTjkQIObsEkCssUgycy86oplFVXghDFqhZ
 heiGx2uiYFClVOoHgrk+OnsHhW+MJd62bCaZUywS8jCv3pc1c9VkEe57Gb7RsM7VENu2
 /H3zMQekGzdFmQG0eb3s0DeTwJb4tUlZqDD7H9rajeCpzYWO5VMEJIKZutF6coZJsgi9
 yd4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI/Z4eesqNDqJ/L8lq30qxF0STmPUwJti+/LH1UO1cZdGH6ukUnh6ogXbxBmDSsEeFj1xrPi6tR3Yn@nongnu.org
X-Gm-Message-State: AOJu0Yyjrev29vX2USm1uYz4g73DNBZUrK0L300u2NAPWZwXzOAj3Fuh
 ArKNMbE839nAQIOzdNnGFCVh9vTEgaZX5lwUWVO5YW2MVQEIv+/XpUjS6PFknvE=
X-Gm-Gg: ASbGncu7cbVoyxuCF9+rlBGThuugaMdnF3ZqG0MG1y94gL0REjfSzJlcK3VeT8gO9tI
 6lkIwkuOKzxYs6i0o7PBz1dl4eO5xM9shCPfQSnIPDVKPefJ8EtTe/SmaUAOivpjcOsQCKEhBW4
 RA25Q6btSRfDjExxzGQWegEolsPHjzepBoNEl2IyY3cU2AyCIfCkT84ujDCTvSZR8QgO97CeuUS
 XrJlNTXYHqTAQZ/5ACzBt+LazuArYEiQZS8DOJHzPDvHS1KwTq6bQNdsFdrGMaCQhKsRoYoGjt4
 uSREdJRlqG2XseRNOKx1xgrFAa1mHt16LNRHOoen+Q0mNZKCQMY/8grsWmLOtz/fzeCnJ/QiE/v
 QPfKlcVSj
X-Google-Smtp-Source: AGHT+IFnLBRqAToA9c/Pk+fFl/YVqd1+yrUZ7dYaR0soT8uxfkouwWpSWyEDr8cvE3KuU0XQoBjqcw==
X-Received: by 2002:a05:600c:a4b:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-4406ab96871mr164009525e9.14.1745345927398; 
 Tue, 22 Apr 2025 11:18:47 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db230sm185401965e9.31.2025.04.22.11.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:18:46 -0700 (PDT)
Message-ID: <4e83559d-bbac-414c-a71f-076e038db772@linaro.org>
Date: Tue, 22 Apr 2025 20:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 12/19] hw/arm/virt: Register valid CPU types
 dynamically
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-13-philmd@linaro.org>
 <62c23632-b498-4fe9-b337-294b0fe4cec4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <62c23632-b498-4fe9-b337-294b0fe4cec4@linaro.org>
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

On 22/4/25 19:56, Richard Henderson wrote:
> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
>> +#ifdef CONFIG_TCG
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
>> +#ifdef TARGET_AARCH64
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a76")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("cortex-a710")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("a64fx")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
>> +        vct = g_slist_prepend(vct, 
>> g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
>> +#endif /* TARGET_AARCH64 */
> 
> Why do these need to be strdup'ed?

g_slist_prepend() expects non-const.

> 
> Do you anticipate other instances where these names cannot be 
> constructed at compile-time?
> 
> 
> r~


