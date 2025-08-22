Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A696CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTKT-00063J-Dh; Fri, 22 Aug 2025 11:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTKH-0005oa-VZ
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:05:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTK5-0005Qr-UX
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:05:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77031d4638bso687606b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755875089; x=1756479889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RcXFpFcsz2o2Nzjw3h3EANE1RROMlfaR0fdCkYlkHB4=;
 b=uSx+N1R198ooF/tSDI9xHwhEruiRcsG0nG9LGr34dEzkYIQ/4K7gMUYFzFUEtvy3Rc
 FiOcxiqfEKaPmgva7xTlYg0zxvhfEWiy31ZP1lIXChK+EIzECnxayFx+CfiyRFcS4hz1
 DctcKs8YR1eO88wmsqVG8jrQb4+rNjt96LcZM4Wk9uOROy5wk/scMjQTI5MTECTBi+pG
 /Q2Um/KQmjCmXj19pcrgdymvlZAZ98hIHPKSameNii9Q6iv+scdykki6FIzOcNqx2KXR
 siFDzWgyOUz6d1pJBnZp1hRfh+0p0kxi1nPYKd+Nh5QNrTLWFTOQeFtPtF9ZINI57kX7
 5KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755875089; x=1756479889;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RcXFpFcsz2o2Nzjw3h3EANE1RROMlfaR0fdCkYlkHB4=;
 b=lfSozV6C/UnZkdo1k5aISPzH8gvhzM7hBilMwN0oLtABSUffxhKgk/sErskvqMkMha
 yjjCZHwJAd/+NJJYzZx+NqVq5YyWV+bnFjbwAbdcEnVUkzfaFWbWB5Tlfn1AS2lIk1EN
 2xS3+bmiKZOBVAqQI+fyOtQL8aTFJn+DOY+wv1rsh7C5jmx8N0ampZGF8KjXKuBMc3bE
 MUCSBkutV5ySfxa6YJIPGWEwJE+CJevGNgCaUZ1mrllbNVOZ8xbIg48wnBNdpjvyd4cW
 6tCxeDkaQr0/1dGGqsybXGdjZ9KsyiEPdlj4Q/RADDwBNLlUrDc8dpr7C42D3Hno30q8
 fuVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk/GPKWM9jLvC0TdOHQWR14dYyMuo+5GdfKsnaXhrfThzJQlnJzXgcuudnJ10jO+DrvMTMkovXsv6z@nongnu.org
X-Gm-Message-State: AOJu0YwmRbg1MBhdZ0BrfIiX1mrmEPwc1uLEuTe9aV/OKMJ7l6Rlfuro
 PE3VQKCx1O+QKn17gBefFqW4bvfKPZbv6yTckxerbfFj2Z0AjTH/hKWFCc8lARQfF7jigeLBu20
 TuOSFnlfJGw==
X-Gm-Gg: ASbGncu1wNq+3H93Prm08hg5nYj43JJdkJe3hxz3bpQVNKGHBau8rBTi30sWjsSoFQG
 xGsqVnyEy//svs05moSLV48dGPhPm8RbNGLupbYp2DiAdqHah/nHvoS4S6hi6RgSgGmeqHt7xLK
 4kT+EHy80TalJ3+XCflGUrMBaqWwWjHC+0WGbSH75AFdr1895zvMxjNplpVVxNJUGn1iuXwsBlO
 UjcardfP+kYc/OJjWu1GgDrfyLXxFgJ+Xb8CTsOsMKse6/Zud+OqWtFfd0vBjBNj9gwBxdsIEAL
 XMdoa12f4rl+ZKz+OF4KjpnHlozulyh+6ySIvm/7WENNHzyZYeGfabF7W3QTuCS68HRamNSdIpc
 k56cRX7lc8K3MnKcw1uMOPO4uAsKGmf1HxyKd
X-Google-Smtp-Source: AGHT+IF59mXoQwUbYyzNEWsqJUGWIrmmpdgL7gjo4HS3L19atEqK2QA30uGGF5h+jMHxT43vmOjtYA==
X-Received: by 2002:a05:6a20:939e:b0:21a:e751:e048 with SMTP id
 adf61e73a8af0-24340d7bb9emr5091041637.35.1755875088628; 
 Fri, 22 Aug 2025 08:04:48 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7704000edeasm184983b3a.45.2025.08.22.08.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 08:04:48 -0700 (PDT)
Message-ID: <5d76251c-5f75-4854-8d2d-f37491df40e2@linaro.org>
Date: Fri, 22 Aug 2025 08:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] single-binary: compile once semihosting
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
 <7c026d43-04b4-4615-8478-639393b640c2@linaro.org>
 <e7ea76f9-b66c-4656-b8b6-4d0ff0dfee35@linaro.org>
 <33849bb7-07a8-4a04-b142-ebfe5d286332@linaro.org>
In-Reply-To: <33849bb7-07a8-4a04-b142-ebfe5d286332@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2025-08-22 07:57, Pierrick Bouvier wrote:
> On 2025-08-22 07:56, Philippe Mathieu-Daudé wrote:
>> On 22/8/25 16:31, Pierrick Bouvier wrote:
>>> On 2025-08-04 11:39, Pierrick Bouvier wrote:
>>>> This series compiles once semihosting files in system mode.
>>>> The most complicated file was semihosting/arm-compat-semi.c, which was
>>>> carefully
>>>> cleaned in easy to understand steps.
>>>>
>>>> v2
>>>> -- 
>>>>
>>>> - use vaddr for syscalls.c/.h
>>>> - static qualifier for console_{in,out}_gf
>>>> - use vaddr for arm-compat-semi.c
>>>> - semihosting/arm-compat-semi: fix cast for common_semi_set_ret
>>>>
>>>> v3
>>>> -- 
>>>>
>>>> - keep common_semi_sys_exit_extended (Peter)
>>>>
>>>> Pierrick Bouvier (12):
>>>>      semihosting/syscalls: compile once in system and per target for user
>>>>        mode
>>>>      semihosting/syscalls: replace uint64_t with vaddr where appropriate
>>>>      semihosting/guestfd: compile once for system/user
>>>>      semihosting/arm-compat-semi: change common_semi_sys_exit_extended
>>>>      target/riscv/common-semi-target: remove sizeof(target_ulong)
>>>>      target/{arm,riscv}/common-semi-target: eradicate target_ulong
>>>>      include/semihosting/common-semi: extract common_semi API
>>>>      semihosting/arm-compat-semi: eradicate sizeof(target_ulong)
>>>>      semihosting/arm-compat-semi: replace target_ulong with uint64_t
>>>>      semihosting/arm-compat-semi: eradicate target_long
>>>>      semihosting/arm-compat-semi: remove dependency on cpu.h
>>>>      semihosting/arm-compat-semi: compile once in system and per target for
>>>>        user mode
>>>>
>>>>     include/semihosting/common-semi.h             |   6 +
>>>>     include/semihosting/guestfd.h                 |   7 --
>>>>     include/semihosting/semihost.h                |   2 +
>>>>     include/semihosting/syscalls.h                |  30 ++---
>>>>     semihosting/arm-compat-semi-stub.c            |  19 +++
>>>>     semihosting/arm-compat-semi.c                 |  65 ++++++++---
>>>>     semihosting/guestfd.c                         |  26 +----
>>>>     semihosting/syscalls.c                        | 109 +++++++++---------
>>>>     ...mon-semi-target.h => common-semi-target.c} |  22 ++--
>>>>     ...mon-semi-target.h => common-semi-target.c} |  27 +++--
>>>>     semihosting/meson.build                       |  18 +--
>>>>     target/arm/meson.build                        |   4 +
>>>>     target/riscv/meson.build                      |   4 +
>>>>     13 files changed, 190 insertions(+), 149 deletions(-)
>>>>     create mode 100644 semihosting/arm-compat-semi-stub.c
>>>>     rename target/arm/{common-semi-target.h => common-semi-target.c} (59%)
>>>>     rename target/riscv/{common-semi-target.h => common-semi-target.c}
>>>> (53%)
>>>>
>>>
>>> Ping on this series.
>>> I'll be out next week, but it should be ready to be pulled once the
>>> trunk reopens.
>>
>> Modulo the comment on patch #9, the series is fully reviewed.
>>
> 
> I'll send a v4 with this, thanks.

v4: 
https://lore.kernel.org/qemu-devel/20250822150058.18692-1-pierrick.bouvier@linaro.org/T/#u

