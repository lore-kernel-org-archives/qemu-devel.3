Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC331C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNBg-0001yM-0m; Fri, 24 Jan 2025 12:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNBb-0001Z4-38
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:09:40 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNBY-0005UL-Ho
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:09:38 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216728b1836so39591665ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738575; x=1738343375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1GDjlLmxQKxGcMYupdVTsTHiU9Gv70phAG0Khcrwl2Q=;
 b=BSzwXZh9pc8a5OAzQPA5bwMU6Y3X3dl0LKaf8V+dqkc7riMQ4SHoxRt+buAjkQogvX
 a2bvX1uK3i9uRi1fuvH9dvKLFY16yzpXadUhRvI5Bbt1YvwH6N3XudM/z9UhyrBqiUht
 ZCOb64pfrdi7X+4BTMvrkw0yBJYwpxFUSRIbVqJVw6BNMPJD913VK9/2a608kTVCOkK0
 D5bFaSFLkn2gd6j9h4AdYdq64rWTOsh2sMT1+0W7EDuD/Qa8HSzFr8VH07hCijCDZkrX
 6bJdDVBYL/6lGSwT8bAeDD8kmE+liEcllNpAg9C3B8aU1WR3pUNpO0gN/rwCqJNQ2dMf
 28Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738575; x=1738343375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1GDjlLmxQKxGcMYupdVTsTHiU9Gv70phAG0Khcrwl2Q=;
 b=EW3UNOJFdAaYf8y6Kp8wXMikERllDrFi32k/2Isel1bEYYXKLaQVYrgQieGygJMheG
 eNW3A+rcUfBh270RJ3mv8Lu99+gHCAzRdhAjiHGg8ExdDQDHz4Zkunck6grR65fGB83h
 NNxb3DXnjrPxip1Tq9F2LQCiVW+06C8ky4OklgRHy3EjEtY1NfdWGSCIlUj1qd8lw6Gh
 N05pJufcrseJGVZfx5BaUxOrFZMwZy7yQ+6lt9NYkcBeHOBBwm7X65g90rO6BIotDW/8
 mDTNaEYV8c+yEue3olUtSDcfhNRqqw/iQYrKQTbOv53tqdNfsj5EA2he4HqGVjU8N3Nn
 fVmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgXjdJV94+qHlHG7e4aKq0Foo8brZzeXlxZkdlJBFiDY2a0hxYcWOyPsY27KnioaNJPJ8EnSgfurZZ@nongnu.org
X-Gm-Message-State: AOJu0YwmyAoOvh31/n7l5h/mtHWGulWEXHnFRxqzOGCz/5/6l1M2uUF9
 6aazIllfmi6PPKlqMOmye37XAefHZGqrmTi8P8xwcMr7RYaFqKT2NaWb1hARpbE=
X-Gm-Gg: ASbGncstiIyiJ1t5625HWc6I1e9Xh3n1ly3ZT4KHzWdlcUQ8x6KlFE4uGSA2knjX6yB
 CSieBOA6R6pEivUPA5i7wd5QLG1tXF7aP3+3AYsv05wPnzKwmn0pfeE8SYeHhhR8ychlcq7F1Fn
 7snFQRXvxBTbuFi2zLnjaXblbRHxAeF2NOilGMZkJuL4FuYQQ+6ukzOEwGHiGajk2bi1jI3IcjL
 kumLs98T4/OpMYfn7P1q+cJESQQXudzorm42xnsPbkPgg+KlD9m2ZbPz/tATkcoRpSPMZT7Sr4f
 W0xIY+t1cv7RyBQjz/VUYrZt
X-Google-Smtp-Source: AGHT+IEaxsWTy8Xt03tFQ9e61r0u36sj3ngJvYP7ajmGDLc4iV3GQJg9g31ANul8wDPaFtD1A7ybvA==
X-Received: by 2002:a05:6a21:998a:b0:1e1:b329:3cd with SMTP id
 adf61e73a8af0-1eb214daa70mr44297292637.20.1737738575053; 
 Fri, 24 Jan 2025 09:09:35 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b3233sm2205483b3a.61.2025.01.24.09.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:09:34 -0800 (PST)
Message-ID: <e082e62f-ad9c-4cfd-bd12-a733faba1df1@linaro.org>
Date: Fri, 24 Jan 2025 09:09:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/28] target/i386: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Move has_work() from CPUClass to SysemuCPUOps,
> restrict x86_cpu_pending_interrupt() to system.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/cpu.h | 4 ++--
>   target/i386/cpu.c | 8 +++-----
>   2 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

