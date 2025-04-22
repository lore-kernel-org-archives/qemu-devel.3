Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12710C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HrG-0002g1-Eu; Tue, 22 Apr 2025 13:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HrE-0002fY-QT
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:56:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HrD-0002Gr-1M
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:56:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739be717eddso4223772b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344589; x=1745949389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vnCVdewz02efPlRJy8vuBwCXUcZJzbcnTcYQWu+eIrc=;
 b=ejzf8lAKJfLdSDKTDiHJ3yf1FzdWLVsi2wLXmmllzAVe8W9f+qip+UhB5QAFNE767x
 MDqGBnKKSYDvcPoME9zdKWfNIAZrWGaeMuZnN5TWAOZq5LuoGgaptvW1V02MJSP+f3B+
 b9SWP2IC9vUwLw9axTjFIgEZodWQCRcYhc+NsTBjRvqd9UN67rl7cyodriwQziatH36o
 8QwQKFCDp5qiwd8Jce1JFiIb6YHgSwKpW1MdOvlNw0KH+3bqI9a99zd3Sl6xpwR0IRAH
 EyKyfGMZB+/l4fcXyhkplnw+5+jGUK7i8ZyWNTwnhBOzw/Vk/KxZ2JB12hmJ6Ylp5o6z
 hQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344589; x=1745949389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnCVdewz02efPlRJy8vuBwCXUcZJzbcnTcYQWu+eIrc=;
 b=NJJlsLSQMkqbaW9OkozUjHcvdR1kR9d8ADC0fxJ8hMxXFz5SPYImHaFS+CH1fyFWts
 NPkAyQEWDXUSAexSM5Ty0uoAf8LoCe3z+lOYnL4Y08yJt1ppv6j9T5YYpWfJQGEEc8zd
 j7scztP10lRi7OTqW7xShk2g9yuUCDU4eWmZ03xxzqgPaJT9/qwiBtkfB97y0mBcW4vY
 GwiupLik6pwdc9BjMolvjytuUuS6sDpOifiauvGAgTot7wVHLsTho8Flj4qoCHbHhcKp
 JDcaCR7L+7XGIqj4u9XI8BIwYVT7/CQqIHiRua0y7KJKEYjlOHgRQ2+SoObe25iB+d8U
 UKrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCiQqRUMWdefZEy663PUIL4NqD9S2fDbdT0E9VYsu+kg2s7k9LthmksooX5UK2hNnDYYOVxuKr/SCr@nongnu.org
X-Gm-Message-State: AOJu0Yzf5p67BbNERDbOacs4ZhxjLgeyidQs4ar/UrZpImnHkuoZ35bE
 y0HjB53MKnZjqbIqHPld0kMatU4d2LZVAPCNk0/2XLMLmVTKAafbF0PbOgTysJA=
X-Gm-Gg: ASbGnct1cg7YpCoZ3bJuZwIcWefjCi7vK8Weiecb1lcUOx2jho9QmCxDB4ynObvbTJ0
 uheF+yKzru3uODwXAPOYDwwZSSmrX6l6qnl+fOPS5vUZi7Wv9Ew/zVKMsj+S0GsX50Ioi0u20Go
 ctqM/Ecsp6jIlepez+sSCaRXUwHieBgEnwurtegOnC46/9dTEzX1+i2nW7tNd+zE9iQ6+3Kcrm4
 LF+5SvBuRD029UY/h/jM12Cc0qSeD8ELPremyxXPDarKC90q/hjNDdVgUCzslC21JtQdd00WQqR
 kMtpupfJiWBeVjM5fy6XYXJxRm4/ZJk+zP9Oq9+j8pN5423Z7dv98U4i8geSm5kjOSgCb+iJ2OW
 ZdcT71EE=
X-Google-Smtp-Source: AGHT+IHBlJtpIuEGkT4H4xMGSmzr51lZ0QPm2N1NrmjvVoR8uZjjluNp1bDv9t7fAJMPJe0yQ5ThGQ==
X-Received: by 2002:a05:6a00:1145:b0:736:476b:fcd3 with SMTP id
 d2e1a72fcca58-73dc15d7fc4mr23878825b3a.24.1745344589528; 
 Tue, 22 Apr 2025 10:56:29 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e510bsm9267345b3a.66.2025.04.22.10.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:56:29 -0700 (PDT)
Message-ID: <62c23632-b498-4fe9-b337-294b0fe4cec4@linaro.org>
Date: Tue, 22 Apr 2025 10:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 12/19] hw/arm/virt: Register valid CPU types
 dynamically
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> +#ifdef CONFIG_TCG
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
> +#ifdef TARGET_AARCH64
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a76")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a710")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("a64fx")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
> +        vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
> +#endif /* TARGET_AARCH64 */

Why do these need to be strdup'ed?

Do you anticipate other instances where these names cannot be constructed at compile-time?


r~

