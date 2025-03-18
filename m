Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED9C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuf9m-0007yv-Lv; Tue, 18 Mar 2025 18:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuf9f-0007xJ-RN
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:11:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuf9c-0002ID-WA
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:11:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225d66a4839so1345305ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742335878; x=1742940678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+69esl2nOuGPMBCNKxNirnt+vS+cxkG3qdPl+eItGdM=;
 b=k8/cRclkzpYdzM3Rrx1vSzGony9d9Ecfj5nqrDF9MLGf3+nNRD4wdmD/K7pRrJLmCw
 emRW4MwWfZaCa8JOhKgtQUlWtKYOmx5NtGkMVqurrNLX2ImK2iZtEeFjhm78lqfZ55XB
 Pdzous12OST9/N+/ifFrC0CZjsXPQD0gqx7vlc6Ych/QYKxPHtOvjRZXq79nvNGvRkK8
 Q5VY8b8kfzEsBqpuQVXHf1JeXiT+kCpBGnznZ52KacGvspe5LTEVdhTuqIXl0+TesgfE
 P3ffxwZ8QX0heeIhpBKe6nDpQoJgOo8/9JHbHm9bHTZCuFJZVQFCXyr4Q8DOU6aWwIpE
 Q2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742335878; x=1742940678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+69esl2nOuGPMBCNKxNirnt+vS+cxkG3qdPl+eItGdM=;
 b=frSbEIDYHqGF8a8SIQNULRQDan+NRZL4AZ3rHicCHFDhF5dE1AtPSpA5ECCvVz7jOw
 Crdl+ABbJjKRKMivwzTZGJZeKbieIRhsm7MjfjRVLDWDkpPqr2eqlrOYyunY5rtV9aED
 L+zVIzxRfqMotHfbz2y/isvDD9Eq/3tJKl2uNJV02kNJdiOEL9KoDVnvAwT/DnIzzNWF
 eoAh45bMyUpIPVT04RoXswZsKXSxU9F765ygWwObQO58INj9YEhZu8qjqQhMKsIXMELr
 x3i3KQQWQLqB+5OqnUrvssTuTLy+fsr06xfdPjs4al1KSvTHcMuP15j3pM1kkOMEVJNU
 /BgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW369qe5mNBpCE7w7JTAR+FTq53sdROtSKlHH9knP6yZuw9rUfg+T3V9NgnhSno2bq94vaZp6CD8oe7@nongnu.org
X-Gm-Message-State: AOJu0Yx2t9v3RwhpYWwO0hsmWqbRZDT5l6XqkKK01IbrgUY1CRYTsL6V
 qMpWMDh+m9z1s9/kZq09mXrhuG1xEl6JYZE6BfCDZE3i0S1gi5PKeV1V42dxPDE=
X-Gm-Gg: ASbGncvbO2qmBxnohgvNIu9O1rquFH86jN5uf3cYHkYLUWuc3qYIuUVQm1nI3YXsejl
 wlboUk8FF5B5o24WRYFqFNCg0uhOHgMZbWVZ+m3oJVVqHeVTLOqpxe93nPjK4u10HsAF/b3HcqA
 mb0ObUIX89CciA6Qs9NQtyIiRA8EkFBjhYyiFHpLpY2Hx4eGt0PRX5QTuNtYmCZbTa41D4mS0xT
 ZzuoD1TfuDvoutnOULtzKvz2Sa21SXULEx9INI+xoPVhsD3aYyi1KVJ2pzggKmnaWUh3zHELa1G
 LZKfnWULmuRzNnFkE+bl+OjV92GwBdNF7+Fdwoiqsg7iCgDPzggGFmCyR29Ib8HIA58BMyBypbB
 mARadetkv
X-Google-Smtp-Source: AGHT+IF+o57KxPqZyp1dw2vr26h6BTXUQUOnR/DxEq+2jvgU+MIkHQqqlXf/RtfTtCdotr4CtaEHHA==
X-Received: by 2002:a05:6a00:218d:b0:736:bced:f4cf with SMTP id
 d2e1a72fcca58-7376d4619eamr874582b3a.0.1742335878454; 
 Tue, 18 Mar 2025 15:11:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b10edsm10459572b3a.171.2025.03.18.15.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:11:18 -0700 (PDT)
Message-ID: <35c90e78-2c2c-4bbb-9996-4031c9eef08a@linaro.org>
Date: Tue, 18 Mar 2025 15:11:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] exec/cpu-all: allow to include specific cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318045125.759259-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/17/25 21:51, Pierrick Bouvier wrote:
> Including "cpu.h" from code that is not compiled per target is ambiguous
> by definition. Thus we introduce a conditional include, to allow every
> architecture to set this, to point to the correct definition.
> 
> hw/X or target/X will now include directly "target/X/cpu.h", and
> "target/X/cpu.h" will define CPU_INCLUDE to itself.
> We already do this change for arm cpu as part of this commit.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 4 ++++
>   target/arm/cpu.h       | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 7c6c47c43ed..1a756c0cfb3 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -46,7 +46,11 @@
>   
>   CPUArchState *cpu_copy(CPUArchState *env);
>   
> +#ifdef CPU_INCLUDE
> +#include CPU_INCLUDE
> +#else
>   #include "cpu.h"
> +#endif
>   
>   #ifdef CONFIG_USER_ONLY
>   
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a8177c6c2e8..7aeb012428c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -31,6 +31,8 @@
>   #include "target/arm/multiprocessing.h"
>   #include "target/arm/gtimer.h"
>   
> +#define CPU_INCLUDE "target/arm/cpu.h"
> +
>   #ifdef TARGET_AARCH64
>   #define KVM_HAVE_MCE_INJECTION 1
>   #endif

This doesn't make any sense to me.  CPU_INCLUDE is defined within the very file that 
you're trying to include by avoiding "cpu.h".


r~

