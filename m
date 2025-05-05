Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470F8C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBs6H-0002PZ-AY; Mon, 05 May 2025 05:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs66-0002LA-LN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:26:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs63-0001IV-41
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:26:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so26483625e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437204; x=1747042004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvT02RXoHda76DM5TE3n0s4myKM/b8D31YKQZVv7YYM=;
 b=JoVPrNB9K2XWQ6ta0J3RsJPTu8PcA2dhn8IUXoQzNRaCtjXo2g1mXsAJlF1mms5Qn4
 1N/CKFuzWLwhhB2itgUeqZO13j7aSnfm1yLeD62UjLKnY5zTYKFPGuVxQNIQzgC7ifpP
 6GTqzuSYoy5dp68tMdPPMGK6Ff/zisk5wN5lYL99GcnmSyhe1yTt+r8Exaa8V8DmxUby
 WA/WTd2IK+e8pAiVE6CU89Gm2xRddTXlmvfSWDP755kYWBcgFmr0nmpsoFMg5QdLW7aP
 a6Oj8OuzNlRy8u4dNVzNrcnI0cauzZ+mQlR9LgkHEJxXz7BWJiIynlL+bZyeCj1t4rni
 phHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437204; x=1747042004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mvT02RXoHda76DM5TE3n0s4myKM/b8D31YKQZVv7YYM=;
 b=EHoohKSguIZZrEcTcb0gKeInVtzm6gCvEokpKTdImq8jPXqWtm64TFgG2Smh5uz37S
 4xou9s3sgwPgwFxEbELCC8J6ktplbKUwcK6EH1goWqvMvIOJ/PVIAxZ9WF6m8QVrxuyu
 9z4bMI/Zgz5l9K8Lo93gYnWL/L4O4FCpvvlrhduPBQWe/K/+F8LMADyhKBjUxi6kvSPy
 /qJ8iI9vHM3XVs8MW6sQdhC0PVVKceLP22Ra1NFH9eYEAoe6RrCgKsKkBVUDhv/X8R1f
 O9HzcvV7N1C10CX0ony/cnLa657iJOycXK+/MOHQTHxhASbL6omgmd2loWeTPLsy16t1
 XibQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLgqaFMKHgWUDh6lY0kfiGLTA1ETeSUyKinT8cohYNv46mkYekCnDr7pUlFdU4hpGo0W4XCxmcgoP3@nongnu.org
X-Gm-Message-State: AOJu0Yxur8GRQgmVUfIrWhma6kBWGnu0FYeOyWGkpnJlwxV9yTfeeBjg
 qA43hWUCWuCKhPHa27zRiQG3Ek+yVnXFp2zX3CH6QKaYn0UPyHk1mBIO4nARlMI=
X-Gm-Gg: ASbGnctvd1j1Y83OvF1w/0eQPhd0fhCThLch+0+LQf5ZkVRZUGOjPsM2MtjqMK6Khjm
 FKz7btNApupJqsbSDuNbGBkz0ei2wnfZ5j7xJpOUxsx++rrYH3nbZ476XDIjuqEUfRzhLbak99q
 g0hf/tw8ydCH2uOG0BFDzeUyW2p0aIV1/vZTJ3SWMBH2jOY8IRxj9+yqPVQ2hPT5RmoIk+5TrWH
 kgtAZsH2DORNhg6Rh78CzqbSeNE1juwd+WcO26tsJcq2tLqZ1ayWr0+tZEM6YgkU3BZwscgrWFb
 H8r0gIW8vryp3xqxWj5QFsVFrOsHfx69Z+P5RMXMYHdlQzFNIROINjSihJIQMA/uril4FnB69Ak
 2SQ0ethcJmzZGh0XVaNpiQs/JaQW9
X-Google-Smtp-Source: AGHT+IGAnB/IJ/UYtC3Sva/8xxIJEUSE/yYUlo190mqjJHXVQ5ojwswHVZxHbiEqJgQxqDwKOizOOw==
X-Received: by 2002:a05:600c:3c90:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-441c48bdfdamr56088375e9.14.1746437204233; 
 Mon, 05 May 2025 02:26:44 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2aecb54sm171744845e9.10.2025.05.05.02.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:26:43 -0700 (PDT)
Message-ID: <f71e3271-ff26-422a-a9d6-72a6174f0115@linaro.org>
Date: Mon, 5 May 2025 11:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] target: Use cpu_pointer_wrap_uint32 for 32-bit
 targets
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Michael Rolnik <mrolnik@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> M68K, MicroBlaze, OpenRISC, RX, TriCore and Xtensa are
> all 32-bit targets.  AVR is more complicated, but using
> a 32-bit wrap preserves current behaviour.
> 
> Cc: Michael Rolnik <mrolnik@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h | 1 +
>   accel/tcg/cputlb.c          | 6 ++++++
>   target/avr/cpu.c            | 6 ++++++
>   target/m68k/cpu.c           | 1 +
>   target/microblaze/cpu.c     | 1 +
>   target/openrisc/cpu.c       | 1 +
>   target/rx/cpu.c             | 1 +
>   target/tricore/cpu.c        | 1 +
>   target/xtensa/cpu.c         | 1 +
>   9 files changed, 19 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


