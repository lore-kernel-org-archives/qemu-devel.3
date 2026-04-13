Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87956E93812
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8ac-00051j-RM; Mon, 13 Apr 2026 00:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8aa-00051V-HG
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:07:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8aZ-00043K-1z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:07:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f33d28c1dso419602b3a.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776053271; x=1776658071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7fBqi1hlPsumx1QP6xa7NwykRVdNbIGOFiGwTuFUuOY=;
 b=kM4L+Ijj3GAaDfHIwfPVNSAJr87WGLjRK95j9j0Q7X3W7nmQTcLkQLd5LLI7Gu1hHP
 Tr/tYSMFEOp8X7dk6ukdAUDNBMrkR+tdIbCy86kC6wFe8tpKLWkOufmPPbROcbNbnKKO
 F7xIUdi+XDnGDWp+2DTRLBmduoTQGv/lu8r8anlhpRJD0oc8A0dhw1aFI0pKkNht70XV
 VjYDL1O8olxtRqaIfvcF0cDDvmHdINv5QYdIB0NmMbUnjwZudWrvqG7oeWDVvZIuPIYy
 Z9CG18PCoJfZCJvx/a2auMDSOplMv15gJpGqNd++I32rV8EA6dHoRFhyw9zwDmMeasKf
 OKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776053271; x=1776658071;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7fBqi1hlPsumx1QP6xa7NwykRVdNbIGOFiGwTuFUuOY=;
 b=VbYhKixGQCY44FeELYv5B4ZHTPwAYe7ScwAYULAlpjM0qOtSyjfB7Gm3wxweNddGXc
 V/vutlCf0wfcrhfxfpcFtPcGwho+/Yv6KHE+4DqxN9pEya4Jf5VCW/67sxvI+SxXlAlD
 z3hxTCW2+sLHFOcCa+4bxHMx2tUSRp0iTf7lwTNHFlTl/sm0dyD7vb56g6zGyz9wz8k1
 BbqiCW4UkzdITQ10vK1Ghml+i5Vbl0DVt8tnm4xQjIjjAcQZRD3gFgWvuYgt7sMYIj3q
 Ybj9MbWDTrIXd1jU7pPQ/mzbj5BuDBv+0I+WhDcvOabAlpa37xFSGSNGxGT5Q+vQYCbq
 nO/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fIJ++WwD7Mf9/Ax+QtYHT2+cUfyfCYq9RHKmb7DHDyolLMXbC9TyPjrC0xKx0FJi0ktXUbI4q+ls3@nongnu.org
X-Gm-Message-State: AOJu0YyY1ovsOXYIpeShxLgj1Qf9FpVQd9iGhwwKmJiISm5geHtYvZvD
 wwutBNBoQB59junwvUw3y47J5AbqzDfxkg6GK5xzKlyI63uoXkmzOEyAZBFslsPIYIk=
X-Gm-Gg: AeBDiesgZEOpiVG3VAhi3v01KrYMj1Joc9lZFhxVOnETX9hTiI5iNvoof6K/SDJLU5u
 TKHP68WVewKGBp+bagZcXphjB6OAftHHqF1dmF3abeu7WPZJODYWlM+79uwA6KWDXkgIYEQP7Fw
 g5fr7kgy3kf0U8RdyxjRX7bfsBssLkxcOPomJBirDFJY1ZtN5WAP1MpsFaiOUzJf4awNGXMRK10
 mWDwk37pptq1WRlO/0q40c1FUJ6D1p1QCT7vJfL9AmJHG4nlDnkF6k3iIewbzTBBY1qkXmRdZL4
 V647N0ZEgtuZLcq0Zmt/+Hrpj3QGF5ftyctxGAZuXn1pYGbzOm0qMQFDCA3HqnCSGSV382EpM1/
 eor0YbYDghqQzcJh+OALCIJePFJdo5LmCqOfcK/6pymcjPHv9V3Gt//4fog1oFM+dfnLZxAA5TL
 t7Pkex01T82ZZ63oLfLwKrh7HRScrqJy4mJZ+SiBGaQvC/3MmjqUFytaJ5pgvZBhnPpRHd754g+
 XJZcdGmNLxMlxrDJ7rpsxTSuC5SrZrdjdJeFUl83rdOHDtxBZ0Bo0M=
X-Received: by 2002:a05:6a00:929c:b0:82f:2319:7d4a with SMTP id
 d2e1a72fcca58-82f231983ddmr6814095b3a.31.1776053271103; 
 Sun, 12 Apr 2026 21:07:51 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c34f789sm9978505b3a.19.2026.04.12.21.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:07:49 -0700 (PDT)
Message-ID: <d67c1832-3575-4cec-b045-9c15ee90d8b4@linaro.org>
Date: Mon, 13 Apr 2026 14:07:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/27] target/sparc: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Restrict sparc64_monitor_defs[] to cpu.c, register it
> asSysemuCPUOps::monitor_defs hook (taking care to not
> register it on 32-bit SPARC target), allowing to remove
> the target_monitor_defs() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/cpu.c     | 19 +++++++++++++++++++
>   target/sparc/monitor.c | 18 ------------------
>   2 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

