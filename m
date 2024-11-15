Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA62BD68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzx3-0000yz-R8; Fri, 15 Nov 2024 12:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBzx1-0000yh-EG
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:17:43 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBzwz-0008Sq-TE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:17:43 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ede82dbb63so1186578a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731691060; x=1732295860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkqwAD+3lB2H2OZqewErfCghuhQDyvH53CEeqv2+Ff4=;
 b=swbHlW4ia1Pv9aXF5yZmf+7VBLhmYhuy2F7fKEYyq9txDGZY3t6594nKwcmaHcXGud
 NVo4uUV+XHJwCDBirJZdxZXRyvscB7OoeiBwDEudfz8BwqdP8vRWFSX+bDWmheSqGzC7
 lLMfBUBNVmcpPnMbaqXLlOP8C8a40/xNyE4/5SNQHBQ+t8wZ75v2TUP6O9JrfYdFedBF
 mk6pe/8311J7jm4Nt5PbGJxPn5EGT+naGzmVNR9jHlx8sA9Vj4mzVUCwSq6xLYHlWvAK
 PwBoF/sifoSK5KSnQ4/edYc4FD7RbtZ2kC8t+26kweLW6jap4t7C3LYHc4pEZTkbFop5
 66Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731691060; x=1732295860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tkqwAD+3lB2H2OZqewErfCghuhQDyvH53CEeqv2+Ff4=;
 b=YiQ/31H2SM/CN1iwhY/izepWQbFtNsjUbKWL+BUTKhrBqkf43IEtx5wVTF6XvM12Rg
 VVoTpgRk04iGSRu24UvaVb4K4KVKy6eynjVJb8vErzCIQVq+IQnU33U/ez2/KxXIoguA
 Q1I7LUVcPC1tCk3bS8+SVshVZZSi0ccBydVveXC3Oo+MI+jvJF4Y5iUuGym1C9LAlmnK
 dumBg8FJ6Qq1ApyeiMcmGXq0gwpwdM/jvAtkwgtboq+bjkZU+JJXy6rRLIgSC9XK61Xj
 LFL/Kz5ARUHjZGp+lVbYJdYQksQoPrX1d11Paq4N9DZ/zQiDw7iUZxu/iZP3eCZa3h0e
 8Nhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm2XeaHr3Ndp2jcklSJP22imfITCnnqGxmUvzbXehsqi1RPFUWPPWgdyBLiowJ04OoCuOU92HEqZSR@nongnu.org
X-Gm-Message-State: AOJu0Yzm3PH+GJ+ovNXApkC+iwiOqJULLtKpIwC6aqTIwHMCjZ/DLkag
 Zn12Rvp+8F1NVTBcOEhqyJ6BvaY5xxi9gNVFxzcZtkhML33mdN9r1APMXkKtXM4=
X-Google-Smtp-Source: AGHT+IFKJqorvT4Z8Tx55mciNpegd9MqQRXXjbBY7QdR0b5QAavISXXwH0G68yjRGDp77tWUEGMcXQ==
X-Received: by 2002:a05:6a20:2444:b0:1db:e536:158e with SMTP id
 adf61e73a8af0-1dc90b47e50mr4887625637.22.1731691060185; 
 Fri, 15 Nov 2024 09:17:40 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8c1c31df6sm1530409a12.31.2024.11.15.09.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:17:39 -0800 (PST)
Message-ID: <67387cbc-13d3-4536-9250-4d6285364a0f@linaro.org>
Date: Fri, 15 Nov 2024 09:17:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/sparc: Move sparc_restore_state_to_opc() to
 cpu.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241115152053.66442-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 11/15/24 07:20, Philippe Mathieu-Daudé wrote:
> Most targets define their restore_state_to_opc() handler in cpu.c.
> In order to keep SPARC aligned, move sparc_restore_state_to_opc()
> from translate.c to cpu.c.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.h       | 11 ++++++++---
>   target/sparc/cpu.c       | 23 +++++++++++++++++++++++
>   target/sparc/translate.c | 32 --------------------------------
>   3 files changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index f517e5a383..bcb3566a92 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -607,12 +607,17 @@ int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                                 uint8_t *buf, int len, bool is_write);
>   #endif
>   
> +/* Dynamic PC, must exit to main loop. */
> +#define DYNAMIC_PC         1
> +/* Dynamic PC, one of two values according to jump_pc[T2]. */
> +#define JUMP_PC            2
> +/* Dynamic PC, may lookup next TB. */
> +#define DYNAMIC_PC_LOOKUP  3

Keep these out of cpu.h.
But frankly, moving the sparc_restore_state_to_opc to an "internal.h" kind of header is 
just as effective and keeps all of the private-to-translate.c things contained.

> +
> +#define DISAS_EXIT  DISAS_TARGET_0

Definitely shouldn't be moved.


r~

