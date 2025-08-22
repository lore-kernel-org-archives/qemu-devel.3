Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC59CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTCp-0006Oi-Oo; Fri, 22 Aug 2025 10:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTCm-0006Ng-Mm
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:57:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTCd-0004FF-W3
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:57:23 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-245f2a8fa81so23968845ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874632; x=1756479432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6zCIuYRYqyQmG5eHsdcsv5wOMi8wmLLKOKxQwUfgtjw=;
 b=JsXTjwzSTRAx31opHAw6gZVzovmFyLLlA95nb12o2LR2c1DsCAQinRmZlDLOthTlbg
 pdpUqlJ32FScr0dgkxDhdDcbZX2Wvmad+iMEhwj63hXp/9lbbW9WCgqqolDUPrqZDPYT
 oWLr7jr4B2AzslV5RUdjgf88ryatvjiKJgEqOdllSVFFDc6k7GxLlQxeecfSVAl5nO7S
 aATWi9qrk5Y5/kf0BwBIsk+4vb6u47Jc0fMxpQsbwa2Xm1jbY/vZZMhmFVmQMXRogPm5
 KX4aB2jlMeWQl41uixn35y4d5bVdMkHVZROisgDoqSwuugKjiQLUcPupwHNFrloguaG3
 6tAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874632; x=1756479432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zCIuYRYqyQmG5eHsdcsv5wOMi8wmLLKOKxQwUfgtjw=;
 b=AGOBAo/cn73ib31JyO3ZP7Q14lnVrC2qCTrClC2dN8qZ4i8uiCzvQTKHieTI2fYz7v
 Y/XEvHr/138uAdMD2jB4OPKq0x21LMT0uOZ+jsgC9x6xszDBsm0BtCTcvjQCXiDRnljv
 p6niNPgNFbaftIrGivmrD/EE98zkMs2fG2dEGCpq7lQkovJ9fQ+eQFFDwoALYFLoiBbl
 jcINWVmo3LEfUcaxUL6ZXhsNCx6z5Y38+Bv/YdscThbvuByyPJmmVi1tNILPXReRxKSb
 cqhwfB5LbYJ2en999KcibfX/rFnogZK+yIgjN1wttKlaoM+Fup3lk0FnXN7tgLrI7ACz
 x3xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbuj0jzIV6529X21RVxEPEc9y0J8nj16ik1A5gL6rRgA5Rf+GEre1lzqj3oPrpjjIB0+F4u4sG7TYq@nongnu.org
X-Gm-Message-State: AOJu0YzSbL2Uqt8y2LH+eEjV9vn2PxpMEbs7ePiK1ENVCZ6vDd9LREjG
 p7HewcK59ibkP+0ddso8OYlraDqdc0qHfCd5Hiu3kjHrvuSiC6hpp/YVFG10rLxhJQw=
X-Gm-Gg: ASbGnctWDxuKYtXPlGdj/XIseuOALpwOLhj+OBqyaq1WP+iKmdHyoQRp/x+H8M1Yoh0
 YMseWQZnVXkb7oPhad1ZbgY/2nKmyM1tt6iiNicePvh3YPzWski1ZO6wUr3tXy255KUYNNYg8Pf
 c+JnDxMH8iW+dt1hzrmSRf1u8TsWkbACYRtNOunXOcx+CveF/U/aXQPVMmTmXOJrDUJmJRs7HXG
 t5Z/5Fi8DwSewobA2N+HkQ5SRYfCAQqwGNk/rbS0OX/TkBqVvZWXVBDYwlmM3+gXNO82Uznrqlt
 YU/utLux3wbykx4a+VVLqW9Txxa8eFwRLBeghVZc2MJ858FLutNX+SO91/RcpnGt+hQ/HYgje3K
 INyRBq8WKrJOLppGnYtqj6RUvOPS7xV1BWFPp
X-Google-Smtp-Source: AGHT+IHj5wh+jxeGSP1a8BGDV673FShq0Fdtjf4HI9Di7mEVCSto0zO52qXMBMj0Rw35TUVFljYy5g==
X-Received: by 2002:a17:902:d50d:b0:245:f6aa:1cd0 with SMTP id
 d9443c01a7336-2460245b0fbmr91542365ad.17.1755874631629; 
 Fri, 22 Aug 2025 07:57:11 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-324fb2fee00sm1988478a91.9.2025.08.22.07.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:57:11 -0700 (PDT)
Message-ID: <33849bb7-07a8-4a04-b142-ebfe5d286332@linaro.org>
Date: Fri, 22 Aug 2025 07:57:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] single-binary: compile once semihosting
Content-Language: en-US
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e7ea76f9-b66c-4656-b8b6-4d0ff0dfee35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2025-08-22 07:56, Philippe Mathieu-Daudé wrote:
> On 22/8/25 16:31, Pierrick Bouvier wrote:
>> On 2025-08-04 11:39, Pierrick Bouvier wrote:
>>> This series compiles once semihosting files in system mode.
>>> The most complicated file was semihosting/arm-compat-semi.c, which was
>>> carefully
>>> cleaned in easy to understand steps.
>>>
>>> v2
>>> -- 
>>>
>>> - use vaddr for syscalls.c/.h
>>> - static qualifier for console_{in,out}_gf
>>> - use vaddr for arm-compat-semi.c
>>> - semihosting/arm-compat-semi: fix cast for common_semi_set_ret
>>>
>>> v3
>>> -- 
>>>
>>> - keep common_semi_sys_exit_extended (Peter)
>>>
>>> Pierrick Bouvier (12):
>>>     semihosting/syscalls: compile once in system and per target for user
>>>       mode
>>>     semihosting/syscalls: replace uint64_t with vaddr where appropriate
>>>     semihosting/guestfd: compile once for system/user
>>>     semihosting/arm-compat-semi: change common_semi_sys_exit_extended
>>>     target/riscv/common-semi-target: remove sizeof(target_ulong)
>>>     target/{arm,riscv}/common-semi-target: eradicate target_ulong
>>>     include/semihosting/common-semi: extract common_semi API
>>>     semihosting/arm-compat-semi: eradicate sizeof(target_ulong)
>>>     semihosting/arm-compat-semi: replace target_ulong with uint64_t
>>>     semihosting/arm-compat-semi: eradicate target_long
>>>     semihosting/arm-compat-semi: remove dependency on cpu.h
>>>     semihosting/arm-compat-semi: compile once in system and per target for
>>>       user mode
>>>
>>>    include/semihosting/common-semi.h             |   6 +
>>>    include/semihosting/guestfd.h                 |   7 --
>>>    include/semihosting/semihost.h                |   2 +
>>>    include/semihosting/syscalls.h                |  30 ++---
>>>    semihosting/arm-compat-semi-stub.c            |  19 +++
>>>    semihosting/arm-compat-semi.c                 |  65 ++++++++---
>>>    semihosting/guestfd.c                         |  26 +----
>>>    semihosting/syscalls.c                        | 109 +++++++++---------
>>>    ...mon-semi-target.h => common-semi-target.c} |  22 ++--
>>>    ...mon-semi-target.h => common-semi-target.c} |  27 +++--
>>>    semihosting/meson.build                       |  18 +--
>>>    target/arm/meson.build                        |   4 +
>>>    target/riscv/meson.build                      |   4 +
>>>    13 files changed, 190 insertions(+), 149 deletions(-)
>>>    create mode 100644 semihosting/arm-compat-semi-stub.c
>>>    rename target/arm/{common-semi-target.h => common-semi-target.c} (59%)
>>>    rename target/riscv/{common-semi-target.h => common-semi-target.c}
>>> (53%)
>>>
>>
>> Ping on this series.
>> I'll be out next week, but it should be ready to be pulled once the
>> trunk reopens.
> 
> Modulo the comment on patch #9, the series is fully reviewed.
> 

I'll send a v4 with this, thanks.

