Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70879C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzDO-0004jW-Ef; Wed, 02 Jul 2025 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzDM-0004VX-3k
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:17:36 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzDE-0006Jf-0q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:17:35 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-60d666804ebso3301eaf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469445; x=1752074245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DyX+/lf13Z8LUAauHSsa0TwhJ2NfD6RuvNxG1+5wEO8=;
 b=RiJqhqkDnXRjtsfgAMwqifs2ozObPnQ7QlYC81Wu3bYCUahf2wswL9wDIU2UHE6Z2/
 p27hzV8/hs+l5v9RbJtcBwgPdYgvq1PuaHlA0v1DL6CooE1aBRoNE0qGc/6Io7EEyaih
 +h+gz0C+7No2ZUQuzgAF3PDNtWamfKL5HoLc0impFA9VQtv3TgRgSMYttpgoQbvx/K2f
 Fae75KLwfPVlTRNJiNH0ZKr/oWQe/tiyyX6m9qShHwjqHfwyPagbrn4qih+4W/0I139R
 dhqjvs9tCR+vJ9Wuf9twcbPcFphAUou5MmRtf+Uogp+FCF/Hfl33Zq7lLuvOvK2jvGmf
 sjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469445; x=1752074245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DyX+/lf13Z8LUAauHSsa0TwhJ2NfD6RuvNxG1+5wEO8=;
 b=ec5BHySSQht/auYF1pRgpqJtVKhwqJ6lyUTWXKVBPE5Z3vM0hhV7zx+wJshgzY/14Y
 L48LGcG7Q5Gpc6UDZD1FKfVXdw2yQekArIWvdSM5nzRvurJB7s2vbFSo/WhodfdC5IRL
 kw3zdL3JAv2H0eUQkP9WCXg9Y6jdHDFFkj+8KaxNoz3afKA94/l4sRZmiuWOHW8b0+TI
 oB6PAqauLIwoysFY+UBuSZhnilxNpEWPMC+Nwq6/U6dothZXFuA8IZUNPUXlBFUaFz0P
 zTlC2bhArZFnPJEgQg21E4uOWs1yrUyEKmEBWUq8dUzXfOjtSX7SzUxpI4nL7+V309/j
 5Rcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBgvcgmvUpdSuU7LEZjqAspy7k4GxOvnlYjZ5YssIM+rt5ZhDnNAAAqQn3xtai0tISc2EBhxDTjIkr@nongnu.org
X-Gm-Message-State: AOJu0YwYTuzokGqsMxZlYh9kK9DXqBVRf4nteHKMNLnN+By6zf09wVeZ
 9MTVozpOvFe2awNlRbVaU/Rh10kbs/ToqRyZRgp3H5abSDSXXPNlm7C1lKX7V9PwM1E=
X-Gm-Gg: ASbGnctga+yaBNAXx+tbtkC2El4i0uPizu686JQSPgmi3G24kqsOEQKHLxLY27MeDhH
 Gmtml6E3vwd7R94Nqhjc3Pkcnr/L5p3+TljxXLfo5CtNcDIZu3qs+qVU5o3Mpx37AxESVZdYCIB
 Zsh42aXtwKIqra7ZnKI3E8gN9tjVFPydMFzID2C7gKt6NGD8SCQCoGVQrZ/g7hfwi41VKEGi77K
 DdKfsP+C1SGc2sRsoPmQ/D3Mn23htt+tCTxtF+5Hbqj8pViqnO/v6AoclJdaSEcD7RcX9WyBhyr
 M0tL4p4tGQ71n9zJZWndQ/IMTtteC0/TwVmOaDdjoOgcAu2tGiogaOefqzg0DLHw8JLTnXDP0vy
 c
X-Google-Smtp-Source: AGHT+IHUY+Qe21w8Z3mg4OfxCglZsM6fQzBJcS6Uz1IJyhxZFyI8CSgTD0D23EwmSAb7nnTkRwkncQ==
X-Received: by 2002:a05:6820:4c10:b0:611:bd4a:ff56 with SMTP id
 006d021491bc7-61201c2529amr2438391eaf.4.1751469444738; 
 Wed, 02 Jul 2025 08:17:24 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b85a0d9esm1721696eaf.30.2025.07.02.08.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:17:24 -0700 (PDT)
Message-ID: <9f4e14ce-39a9-461b-b36b-89eb1bac9440@linaro.org>
Date: Wed, 2 Jul 2025 09:17:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 56/68] accel/tcg: Unregister the RCU before exiting RR
 thread
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-57-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-57-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Although unreachable, still unregister the RCU before exiting
> the thread, as documented in "qemu/rcu.h":
> 
>   /*
>    * Important !
>    *
>    * Each thread containing read-side critical sections must be registered
>    * with rcu_register_thread() before calling rcu_read_lock().
>    * rcu_unregister_thread() should be called before the thread exits.
>    */
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 9578bc639cb..57a4bcab203 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -304,6 +304,8 @@ static void *rr_cpu_thread_fn(void *arg)
>           rr_deal_with_unplugged_cpus();
>       }
>   
> +    rcu_unregister_thread();
> +
>       g_assert_not_reached();
>   }
>   

I suppose.  This isn't like some clean exit or anything... we're about to abort.

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

