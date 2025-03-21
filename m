Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9B2C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 13:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvcIP-0001m4-1Y; Fri, 21 Mar 2025 09:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvcIL-0001ln-CQ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 09:20:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvcIG-0003ry-V4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 09:20:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso9356085e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742563210; x=1743168010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i276BsA4Ce536iWlQiXD3jMheFWwqGT2z2BK+mF/6Hw=;
 b=HVlh+yp4cRBSF2y7SpMqavv7pu9vwEpDEQMMO2qUMyA4mO3ybEVARW6h4BmyfjLkUw
 uIYKe0+rp0uaa3eBx7dn2MqpgAkyH9/LaQP9bX6OEhEZXd7iA3/mbXu4gnAhNWtYWBeT
 I1sqN8uOpWZik88MVixEr8uI6SbNXBc8W6VmTHaJ+zQQo1pWuyD+3ILUrz0YzMLWVgRH
 5LFNqe8HqHTFZKbvrp6cx5O+U4qWXn41sdnoEpm0TN7VHTrC+xYUM2+T3kzD0qt3HDJB
 wdTdU7wa996DXB0P5do5k6DirfHaQV+b9mAwenI6lYEwVqz/4K/tHZ+oiRaswyS9etTk
 Fa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742563210; x=1743168010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i276BsA4Ce536iWlQiXD3jMheFWwqGT2z2BK+mF/6Hw=;
 b=V4p0ic+bZ/waEUyrS83+hF5bIdzAi0KXFZ779+NDsFv5xQoUOXNzUvA92DauOod3Kl
 vSfRf6S+eaIO6L3qv8vmL0U8UdCNOhOZ8FMA2tQVshjso3ypU1+ZM++dCtLSVYH7EUCG
 NO5wUIroGx86+NOr0POuQkHvIFjPIYoqBfqasr4LMrzngxayFPtFOHgs74kMN02yyI49
 WrsYxHTtrGwipk4Z0k+yeg+mtfVOVNx1c0D041PHGE/DvceYOBGCfE3KPx5UnZYBUvab
 ckBPWJXfVpaNtNi5uo+vzkdqlX4uU5Si0O1h/ayEDq0LgRUj5sp/lin8jD1/izTpQ+Oi
 wC/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ieYPyI9dbmuu4gSzufgIjifziXSjRQRhbYz/XrjC6sbYCSOooPYbICnjSN2cgMnGAHW5WDg0+Z4T@nongnu.org
X-Gm-Message-State: AOJu0YwqAD/zkgH+YhHlr70RWNaRSO41u7WEqPEW4K2kZc4/MFgfN4wc
 5ca0yxpTK8wKpf72WRx6cFN6LsPz3jbkcsM/RVWZH2y/SjoFMW4RJZgHfKLNiFg=
X-Gm-Gg: ASbGncs6UAfqxwnmHQpcMXBEYyBJWjxazSO874E184bQVEgNQaGvJBzlrwiyWicMbXS
 6LtzdOelikzn56nzk/8dRoXglgbAG+CzEkxx+cVNKXumUtUz1gAaDBBv9ge/4rfKR5k1pL1i0Et
 VH1WtDhSidSFoFR7cgzZRnSuU8+tpm/priIllube6RY7DbEESlVC05CAZhYgBBltshLTl5KtBmd
 1CNffnYgInc4HqzFcJwC2NSjtX9SSI3eKuHZURqf9TgxDNBIPrpnLz1nXREMBRMaJ1+x28vSKgw
 xZmK07ryx0XdSmcszmShWAoAZSVj4J6oM7OFDIC8ifI1t9PovlMdutesmagICt6rO6AJxagt6Vz
 4H2fUwlPgFh32
X-Google-Smtp-Source: AGHT+IEjcKosqQ9xleF+sMTB/pRgACxGtyviYNug8TnFdjDk/3d7Zt+Nzp67tf/SolXKqmwWlWkQEw==
X-Received: by 2002:a05:600c:1e0f:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43d509eec2fmr34082015e9.11.1742563210115; 
 Fri, 21 Mar 2025 06:20:10 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdec51sm78385515e9.27.2025.03.21.06.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 06:20:09 -0700 (PDT)
Message-ID: <915c5266-bf73-43aa-b0ff-80bd094e4d0b@linaro.org>
Date: Fri, 21 Mar 2025 14:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 4/4] tcg: Define guest_default_memory_order
 in TCGCPUOps
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-5-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250321125737.72839-5-philmd@linaro.org>
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

On 21/3/25 13:57, Philippe Mathieu-Daudé wrote:
> Add the TCGCPUOps::guest_default_memory_order field and have
> each target initialize it.
> 
> Use it to set TCGContext::guest_mo in tb_gen_code(), removing
> the need for the TCG_GUEST_DEFAULT_MO definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h   |  8 ++++++++
>   target/alpha/cpu-param.h      |  3 ---
>   target/arm/cpu-param.h        |  3 ---
>   target/avr/cpu-param.h        |  2 --
>   target/hexagon/cpu-param.h    |  3 ---
>   target/hppa/cpu-param.h       |  8 --------
>   target/i386/cpu-param.h       |  3 ---
>   target/loongarch/cpu-param.h  |  2 --
>   target/m68k/cpu-param.h       |  3 ---
>   target/microblaze/cpu-param.h |  3 ---
>   target/mips/cpu-param.h       |  2 --
>   target/openrisc/cpu-param.h   |  2 --
>   target/ppc/cpu-param.h        |  2 --
>   target/riscv/cpu-param.h      |  2 --
>   target/rx/cpu-param.h         |  3 ---
>   target/s390x/cpu-param.h      |  6 ------
>   target/sh4/cpu-param.h        |  3 ---
>   target/sparc/cpu-param.h      | 23 -----------------------
>   target/tricore/cpu-param.h    |  3 ---
>   target/xtensa/cpu-param.h     |  3 ---
>   accel/tcg/translate-all.c     |  2 +-
>   target/alpha/cpu.c            |  3 +++
>   target/arm/cpu.c              |  3 +++
>   target/arm/tcg/cpu-v7m.c      |  3 +++
>   target/avr/cpu.c              |  1 +
>   target/hexagon/cpu.c          |  2 ++
>   target/hppa/cpu.c             |  8 ++++++++
>   target/i386/tcg/tcg-cpu.c     |  5 +++++
>   target/loongarch/cpu.c        |  2 ++
>   target/m68k/cpu.c             |  3 +++
>   target/microblaze/cpu.c       |  3 +++
>   target/mips/cpu.c             |  2 ++
>   target/openrisc/cpu.c         |  2 ++
>   target/ppc/cpu_init.c         |  2 ++
>   target/riscv/tcg/tcg-cpu.c    |  2 ++
>   target/rx/cpu.c               |  3 +++
>   target/s390x/cpu.c            |  6 ++++++
>   target/sh4/cpu.c              |  3 +++
>   target/sparc/cpu.c            | 23 +++++++++++++++++++++++
>   target/tricore/cpu.c          |  2 ++
>   target/xtensa/cpu.c           |  3 +++
>   41 files changed, 90 insertions(+), 80 deletions(-)

Missing one TCG_GUEST_DEFAULT_MO mention in docs:

-- >8 --
diff --git a/docs/devel/multi-thread-tcg.rst 
b/docs/devel/multi-thread-tcg.rst
index b0f473961dd..14a2a9dc7b5 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -31,2 +31,2 @@ combinations where the host memory model is able to 
accommodate the
-guest (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO is zero) and the
-guest has had the required work done to support this safely
+guest (TCGCPUOps::guest_default_memory_order & ~TCG_TARGET_DEFAULT_MO 
is zero)
+and the guest has had the required work done to support this safely
---

