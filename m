Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48412C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twR8A-0008OE-GQ; Sun, 23 Mar 2025 15:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twR88-0008Nj-2J
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:37:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twR86-0000I1-Gu
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:37:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2239c066347so80485965ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742758625; x=1743363425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aFsN9QNVIUdgmic/nMHOU/vMi+SnWp1uZJldFQD5uko=;
 b=QMQ9OeWvW6sqcG7tH8cWCtU8b8NeoCbGV6hOQliGMEHGMHumPMjZy0LQvFcrqN2Wy6
 dVdlBblpdMBkGi6fMHqcrOjnE+skRBuRJQ5VkkYnYNCeA7Mg1VdWUh9TgrMWpeuBYqfU
 6Us5TNHTDQMINhln1yIWOKTRi/aBQrGxbgQXJRZQsrg4ksanUgCyVK2xMxeffpMb1Kch
 fsZbB8tYpLWeu99ZkyvpbTOQuKjf+EaTOlk73ds7TZfIWVsB1b8tmgFGKYcwMB1kT2T+
 Y2eQnWzodMBPnBRJfwsHweRPzX8EmI1SmMYbhKigND8G2eG7pf7Oai/AmA0ioV5rEepw
 p0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742758625; x=1743363425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aFsN9QNVIUdgmic/nMHOU/vMi+SnWp1uZJldFQD5uko=;
 b=ZTon6KacdXHrPAm/Mrkjs1RckmzWmwI9p13n98tRDA+OBDbqWfp2tNeLLT4oS3rTTc
 HRA2rITwpAUScQEqJULDCxKmItGwYUF5d4naDcWgJYR9TxaohTWCm0zXLmwCMV0B/n90
 gCmcy13Stw4jZ0nLWH4fJLOjxu4D50rgwgAnXldvayig8lKHCtexuqJ4KHP/FIhkOp5o
 4lxOrkmmWerAfagIfLe9lJg/Vn97WTM+z+blzefelYjTGu6cTCxEJDiwwkDtaWPF0nTV
 4XB4oTF/vgKbZcZwGIFFOkoz6W/KBx3babTAw3GgXx7Z96WOa4KwSSk43dUnnlFStKBr
 2UFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEr443cbb9CAioEg38ttfgaeqwg/VwbeglQ67PHZMGy758hKGiohW7phO5DZXzPHWIMVmNcqCVEVmm@nongnu.org
X-Gm-Message-State: AOJu0YwjLPw3Dxsn/5Cyv6pnFCdqJP0rb1IVLIAPI0vz3uE9y17Cd3lo
 cjbBT9jL80YLQlVT1cbvBKfsoeThmTMPdqaCUigdb6sirSGLwDryTvxboiuLuNo=
X-Gm-Gg: ASbGnct3mgyKT+1ozQEz7fMq4na6y0xDqVjeKKcpWLC7iwPjz17wZzsgHSsQzdRedf6
 iFmjJLdS1314rJ+AYU/e97jRkRyy5BvkdNWYmHt8xcRFaKPzjj5ifm8a6Ky8t5SM3MQVs91zyBF
 giI8krdjSeTddsqRUi8QyASZ7N0i8nB0PjVGvP5QQzOA4E5DgHos+G/P9slmZGdhA+jrt/RzZIi
 r2ftoaY4v3BMwtWkq/Zv4keasKRTFk8YJGjF7lfmd1jfpFr9RE+NegBp7/dJfycJJc+smqviIHc
 3q4NtwB000oPSaz3dvMQKLZUr0cNNQSQweg3umFrQ+pTLjhv4Mr6nPGCRzIYXYVCyHugKU8ja0X
 8ml31QeEX
X-Google-Smtp-Source: AGHT+IEfZzNzGR8ATTRp9XvwUOJ9Ba9h+/FFFjlbnr+Q3InyZSRXbyWWEYoY1KpvywdGICttkrg2Mg==
X-Received: by 2002:a05:6a20:9f90:b0:1f5:8cc8:9cbe with SMTP id
 adf61e73a8af0-1fe42f311bfmr15412277637.5.1742758624686; 
 Sun, 23 Mar 2025 12:37:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a28001efsm5587748a12.22.2025.03.23.12.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:37:04 -0700 (PDT)
Message-ID: <1109fe22-9008-47c6-b14d-7323f9888822@linaro.org>
Date: Sun, 23 Mar 2025 12:37:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/30] target/arm/cpu: always define kvm related
 registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-21-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-21-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> This does not hurt, even if they are not used.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a8a1a8faf6b..ab7412772bc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -971,7 +971,6 @@ struct ArchCPU {
>        */
>       uint32_t kvm_target;
>   
> -#ifdef CONFIG_KVM
>       /* KVM init features for this CPU */
>       uint32_t kvm_init_features[7];
>   
> @@ -984,7 +983,6 @@ struct ArchCPU {
>   
>       /* KVM steal time */
>       OnOffAuto kvm_steal_time;
> -#endif /* CONFIG_KVM */
>   
>       /* Uniprocessor system with MP extensions */
>       bool mp_is_up;

I'm not sure what this achieves?   CONFIG_KVM is a configure-time selection.


r~

