Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B31C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJ3z-0000X0-6F; Tue, 06 May 2025 10:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJ3v-0000W2-VZ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:14:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJ3q-0005nJ-CS
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:14:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso26413075e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746540856; x=1747145656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BWfS0SFSEGfz7yReYqyP8xLm+iKyuU10YGuK2J0WMjk=;
 b=l8aU/8BWfLe78onDdzahjjuz9CJfB8Cfm0biaxBPMHl9+8iMyOtG2ONioIlMaslfdc
 pUp8dUI6mfKrTQuWxbJIsNsPh5BplRwnEWY/Yir26ivXyBgnPUZ+r8aMHxuOtgW2wJhz
 nPG+OaDYoBQ4DS7m6ihAy/zz1ThCyXaW1r8QKrw7BEO3OTPLDLVS3gpKRm1wDEpCSBjR
 Zuz3L76L59RMCIAPBD4pl+ZLu8lZ32+rdPlsbVNj2nZ2WseZ8+0YYIIf84D6hY4+xcVx
 4VZmJx0bt/5E5PDfavC1nHx+yxc5bqfJMY9MP7Yf6+4d+P4YPgMa60B5MTdToEB8+SHQ
 AWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746540856; x=1747145656;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWfS0SFSEGfz7yReYqyP8xLm+iKyuU10YGuK2J0WMjk=;
 b=UVd1qlkULc9V/IqAodsAtXHObj/4f/YI//DseEA/4WeFbiO4CsVyuHeGNgj+hzojzc
 5yoK3XV9fFhsFxyCYRE5ITDAEy9t7g+pUhoJaNLwTZUQkQCZaMG4Z0w+OYq5TZQ6/XS6
 60dyXtJ9EEyX70SXrbHHq+sjT1iaVoe1T1Ye4fbviUyq1oxA19I5FPUJctLkmvr5vQw0
 YtV2vceZsGU4vrBUkKIzLlcmUF2m5gxczeKwNpiUFhhp5rHVS4LrkHulsISAFVKiKoMT
 Qtlw7Vrmja/C7klsOuDQouq2ByV9A4Jc/Lk7FbPoyfMyQ0+FydhThHDvuZKg3uhb7cFN
 s8wg==
X-Gm-Message-State: AOJu0Yy/wovpYl0gKxZJfidrvD6d3x/NWs2yJ1C7GNRBDKanN6Dzkins
 5d7ICQj0P0l8pfFD/ZB5jv+h7skuCWocn+JRTKG3jH6i7DoYxsFjRttBblYGNzH12MOhf+866vm
 A
X-Gm-Gg: ASbGncuEAvyEueWDGxlqjsxjy6ZpeuNeJaltoZhVnahWL3oGvBm+a5IrvWcLq0NFRRi
 mKY8P+0hO5DJ3IBFPyKaCe8A0gBVR9oovLwu0hEa7oW+VD6K+B4XpEzjBhiXaUCyFUA+VevWyPB
 PkU7IJpVZnz6KlxO/IWG6Ai4HSgNfp7SBzqLyj08s7tRSil5edGy7vKo1rsMV1M+U50tJfpzgHe
 xASsgX2XFeKF7W02FzeGO9N6PEmKoD46OJ/9iLGyKBlLfzrWqmvBSDqQ2AZSzJEx9SYchPaeV9U
 lPchin/myjJfT2FDcOfwLj1LJq+GpIbNrOQPUh9uyFpIUJR7napY8DlZZxq8OjE9Z4X1asYgxtT
 AYUUt4A==
X-Google-Smtp-Source: AGHT+IEfR1KzWxBflmQ40JzdhkwXYnU40/V6vFHTbssqDxt86gN9xWr2/py0x1+hB2AlQeU3SHLVLA==
X-Received: by 2002:a05:600c:1e1d:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-441d100ad8cmr25816445e9.20.1746540855768; 
 Tue, 06 May 2025 07:14:15 -0700 (PDT)
Received: from [192.168.1.82] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a286dasm170049085e9.31.2025.05.06.07.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:14:15 -0700 (PDT)
Message-ID: <704012d9-cd54-489d-966b-99922774f2e8@linaro.org>
Date: Tue, 6 May 2025 16:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 26/39] system/hvf: Avoid including 'cpu.h'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-27-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250403235821.9909-27-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

ping?

On 4/4/25 01:58, Philippe Mathieu-Daudé wrote:
> "system/hvf.h" doesn't need to include a full "cpu.h",
> only "exec/vaddr.h" and "qemu/queue.h" are required.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf.h     | 3 ++-
>   include/system/hvf_int.h | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/system/hvf.h b/include/system/hvf.h
> index 730f927f034..d50049e1a1a 100644
> --- a/include/system/hvf.h
> +++ b/include/system/hvf.h
> @@ -14,10 +14,11 @@
>   #define HVF_H
>   
>   #include "qemu/accel.h"
> +#include "qemu/queue.h"
> +#include "exec/vaddr.h"
>   #include "qom/object.h"
>   
>   #ifdef COMPILING_PER_TARGET
> -#include "cpu.h"
>   
>   #ifdef CONFIG_HVF
>   extern bool hvf_allowed;
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 42ae18433f0..8c8b84012d9 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -11,6 +11,8 @@
>   #ifndef HVF_INT_H
>   #define HVF_INT_H
>   
> +#include "qemu/queue.h"
> +
>   #ifdef __aarch64__
>   #include <Hypervisor/Hypervisor.h>
>   typedef hv_vcpu_t hvf_vcpuid;


