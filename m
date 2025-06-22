Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4161BC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8Jv-0004dF-GY; Sat, 21 Jun 2025 20:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8Ju-0004d0-GY
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:12:26 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8Jt-000133-0G
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:12:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1426480b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551143; x=1751155943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MKoPjrMZNJowvTQ3weSgOgZt/sqydCv0jzqCBk+Akg4=;
 b=ZDGnq8SXcSLusbI7PZddAtvshlYFvUhExcN0nDe3SjTYk5Ka0oKyYQNi3zsJICmsaw
 tpRzgUNwu9m3im1+aXJI1odBLMNdUKyXIuE26GX2NV/Btej65/LQM7vjEAXSBrZAPb6b
 8rGWzTXE8yQ2Fp7nw1vwrJzZRxsnOsRiie6TX/54U/BBeK3YqYVox7FOon10j4P1jdEo
 21Z9rIqAvVptPV759aEB7eadRoRzFSgrQ9cuzpvMf2SUQ/OTjJmkik8NyZqtszdt09wv
 Moe9bAdJMgpU9q5+/9/nCxYfHEwzfPywUanIaGQc7owTxBm3WlJgM6jnsB2kyh2XT9tV
 3TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551143; x=1751155943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MKoPjrMZNJowvTQ3weSgOgZt/sqydCv0jzqCBk+Akg4=;
 b=owI9h6/GZGZRcdSMkG7LnYrXqOtKZTuy3oRUc32FpXoCKpSruvnWUglNdwtI1hy7Y6
 zB858eNytPdPW7vWHgHEmCyaaqFlx5FAghaivyHKrABCGcdKZUTropzHp7SyS9xRaY6o
 OUhY44q0xrjsQBc8dLi5gkmDCOaqe7tfzGdEunKzbwr0U0vXPkZPhWp9jySmZideyZiZ
 1SKMd3cPy0dzKM03FUgrhKnG9Cu8wFNE2jh12pmYeAIxQEqNtR+B9zxXuXuG3qJ72z5z
 YbAqCir0/9/QL2lG2idctRqk5ks3qqoZexG+RY3tIqOelJj6+IPnKxjdlFlVwUSr8nov
 cMpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr2MBUPmdLON/DGQw6V9Q0RnKUrOnBazolmlhN90pJ1UNn0924b7+j+LZuHaKRKR7R3iNOv8j3UjTJ@nongnu.org
X-Gm-Message-State: AOJu0YyqRTRTWmuJgzfqt+wMK+4Tjq+ivPygNu60KKshnzKIwmQuXOHu
 iRdqDy5JPFFx18Xp0n9pv5VumvwqiENw3hYqdX7AUZKOd85IVHcRqevIG2GmCX6r+0M=
X-Gm-Gg: ASbGncvYclDQmYY8dKH+0q85tMAbavjNKfemNari17kb9r1K2X/exARf5UeYLVChXaw
 VyFvdUzo1qB5pm0LcHjX5OKeIG2jvSorP7fRXVRGuDUdfjFaHeCGrbf7c58HEX4j9/qoqwS8vQN
 vnPHEGkyN+oacrx60a0f0uGrAf4Ec3T3swuL62WyxKjP/FxAW3rxDGKboOcVXyqy7cBsdqRYF0x
 qdovHnlz7ZQI02GzIZIp1uJfWCV/05YP+HT5fIE0coH8cCXsqcyGXPYY6gwpGXck4TfiteXcOue
 QgVhlkL5WfccQKGeYbQGOoVnZpYkRCOlPHNmQJn2Dlm3QuidyPfzTl3INvEEcv5H4eq8dokcHBP
 KNnJSxxg1Tyf025skzdotOYQRl9DC
X-Google-Smtp-Source: AGHT+IGkU8QxsL5zz5VWwb8Ow+qUERjj9+ZI87JeoRccV1GXRp1ejHpmIVDABBguJ++fUu0b68cDKw==
X-Received: by 2002:a05:6a20:7354:b0:21f:ed72:d891 with SMTP id
 adf61e73a8af0-22026f59a4amr11137877637.20.1750551143342; 
 Sat, 21 Jun 2025 17:12:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f11ac8eesm4661017a12.34.2025.06.21.17.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:12:23 -0700 (PDT)
Message-ID: <5f0e9e94-2513-4a37-bfa0-02bb8d1d24b1@linaro.org>
Date: Sat, 21 Jun 2025 17:12:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/26] target/arm/hvf: Directly re-lock BQL after
 hv_vcpu_run()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Keep bql_unlock() / bql_lock() close.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index c1ed8b510db..ef76dcd28de 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1914,7 +1914,9 @@ int hvf_vcpu_exec(CPUState *cpu)
>       flush_cpu_state(cpu);
>   
>       bql_unlock();
> -    assert_hvf_ok(hv_vcpu_run(cpu->accel->fd));
> +    r = hv_vcpu_run(cpu->accel->fd);
> +    bql_lock();
> +    assert_hvf_ok(r);
>   
>       /* handle VMEXIT */
>       uint64_t exit_reason = hvf_exit->reason;
> @@ -1922,7 +1924,6 @@ int hvf_vcpu_exec(CPUState *cpu)
>       uint32_t ec = syn_get_ec(syndrome);
>   
>       ret = 0;
> -    bql_lock();
>       switch (exit_reason) {
>       case HV_EXIT_REASON_EXCEPTION:
>           /* This is the main one, handle below. */


