Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBFEC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmhj-0008K9-78; Wed, 19 Aug 2026 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmhh-0008Jx-B5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:16:05 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmhf-00062n-Np
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:16:05 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so1253351a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787170562; x=1787775362; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pLA/00YsntMw3WAlL/k9SGTzIgdjgSB2zvM/mvMYoRg=;
 b=b76C5R7EGia8XZ+aoQMtAVxPmJJZ9rzctRZIBdNCqkK7wL8w2jB/46mXdNKy1p7/6c
 E8XWAoGNlRi3txBhTYNVkV+oIdp5tBUXrKJ8YJ1/nTzKOAA47E15iFUUTosDpJ0b9zO2
 wG6uhpgcSsrBdJJnDcu6VYo5nH5/1wMLMneEP5O8RDW+CJxyihcv9L4OtJFs7x+TQX56
 E5hCQ3e6crx4qoV/zlx8LO+hKc9bVfWda4diQ4/Y9lPYucXq+iqijOGUz3cuTFixBH8g
 zZ4bH02M8pTqLD7i+EORkMphlkCfKLgYij3Vzr24Rf/ZP/DMs9+xtTwo8FD5I3pe0IWT
 goxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170562; x=1787775362;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pLA/00YsntMw3WAlL/k9SGTzIgdjgSB2zvM/mvMYoRg=;
 b=Z4nnie0fOmNhZJVhdZat7vzfAimZAYBBCVkbNpxUN3QgJntK/YJ79vqbToMIUBqgJX
 Z+J+dN0pfw6evA29P3p18y3jPZnZcrXpBcxmivhxl4kJia16A4kpAnAGsPLbOqnf4+hm
 lre6ZU97kaZnZjGV/tK290hQOqS/hF7JfwRlbCY2dc2f6vQ1ZthdTt35WuY03AhIaJTa
 2q98i9550TzlH5YpFd1sbpHzvks9oVbzNp7Wvy9g1Lm8aiqnjk8CkCVscOd8rBD7uhE4
 pd4UilNzHCkUtP+RgmISH7YJf7Yce0X5ipXEZEKUCaERJ44uph/WU+s20xJKf31ABEu2
 93bA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+Tyf3w42s5Ado7WU95DdooHIFUpudTgi37C+7pjO3n8+Na0Jf0KQa1uaa254WpCbe2u9x0zAJPVvW@nongnu.org
X-Gm-Message-State: AOJu0Yw6Qg71ZytNsIz6uKRdzORS3ID4axe5iEzdKd7V6DL32bFaTik/
 GiUw3EnOEAz3CumvgWKOpzgQW1FdLYLIsy64ruy0UdeRuMlrpFTMeMFnPIxBbuUAZeI=
X-Gm-Gg: AR+sD10L89fZPZQHQNIhu4pkBnQqewXkHz9etqKOHo3yHLLZ/ZlUy09Oy0ZDe6d7cXs
 M/XNbte40+M3Z9slxYVosqGdHH63SgwVz5+RkYypsm0BcMi14yPJACoJKNUGiY/6csqO5P9LKfH
 0gbQ0WReu87XlsCxhaRUAOtP+k5KXCnvPy4juPojbBhUOeHBDaoYWJwiQaPwiFLKeOoh33s9R01
 OtmJP3652XMGv8zhKfyAIHmZ2qCk2MgQ7wniisz+FyE8l2y4Vn6ktbvqeDGK2xZTYHrK8tX5mxc
 kxuSUCMzw2nFuAbcTtT+9RNi1kJ/xFlRrnl+2gbnDm/rpP4Adln3g0aGZhXPnS/EWuCkhTednEV
 HYxLXkvq+c7zADyKCMhslliTxfLe+8zuqWjBhGbAd/sJ0r710vtbYM/pW5cyEziTXANhJyvKl/0
 bEt1AOJTZKl1QAr5nbckUKiFYJgh7qPw6vR7K5JBRsBo6bg9bQ0ax1YirzL0q611JdeQJU9LeEL
 Ip9QHEt
X-Received: by 2002:a05:6a21:1583:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cd00aa4483mr15516706637.0.1787170561937; 
 Wed, 19 Aug 2026 13:16:01 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1556753c2sm962186a12.21.2026.08.19.13.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:16:01 -0700 (PDT)
Message-ID: <a7c21fef-6ee4-46c0-8014-f85f4d6f27bf@linaro.org>
Date: Wed, 19 Aug 2026 13:15:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] target/arm: Convert cpu_exec_halt() to
 transition_halt_to_exec()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-8-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> arm_cpu_exec_halt() now merely checks cpu_has_work() and
> conditionally call arm_cpu_transition_halt_to_exec(), which is now
> the generic flow in cpu_has_work_after_processing_async_events().
> 
> Register the transition_halt_to_exec handler to use the generic
> target-agnostic flow and remove the arm_cpu_exec_halt() wrapper.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/arm/internals.h   |  3 ---
>   target/arm/cpu.c         | 12 +-----------
>   target/arm/tcg/cpu-v7m.c |  1 -
>   3 files changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

