Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D56C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 16:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3Ni-0008IA-Bw; Fri, 28 Feb 2025 11:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3NU-0008BY-FF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:38:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3NS-0004L7-AS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:38:20 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2234e5347e2so50042935ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740760696; x=1741365496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DExi79Azjhm9bvFLDhPuql9Yt+hDKIkvIuDN/oAdjBs=;
 b=RRprocQ9y4U5N1wn18M272iqUWnzzKAU8cwYQEoHyheUy7Fb4eJjkeEKSaqTlh5Ozr
 Sn/g0Xp2hNLH1Ikxm1k3Ls2ycTcAh4Drm1Kwa6gdo6WHcuv/okmKwvrSrNgtb0DbAmlZ
 df3IkxWAekIiCJGKP6wcBA6rf6J/oCWSQQMXHeKpCLXLwODr5xqhoM5qI71DojrcDP++
 DG4VeDsf4OdqtZ1rs4AR62H3BsSSuW8otTpNTs4hrUYPOYbH2gmwSQXRTS1p9/KHdMOc
 YWEK78vBu8SP0QhDAdhJktSXuSiiyyeGqDqAREJFieNjSHpMSM7hXN3mekvm5l3TMPEy
 TL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740760696; x=1741365496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DExi79Azjhm9bvFLDhPuql9Yt+hDKIkvIuDN/oAdjBs=;
 b=crOU8C/0GXPH0OenrLdfIur0EszDEUiNp98W1MbpTnhntBXfXgTo7qvoCm+0pbVnqa
 yXqKowAkmYIvRxEfPnfVj8dZgc3mZRWMSUNqk6O62saBEHIapgNHd0ojA8FQ+4YiQOm4
 spdcl3KDUkO9yKyON/2ttoWr+hV8ehYO5IxIjw+GZf3rqSFBThlED0xY4A4I0AYZ02ZN
 nwONhkpYwmjYPhnS1WjbmwaCyNDdQgTI00XPS82Dtdxv0VnI3mJpYSE37ioG4Bp+nv5X
 Y2N31CoykRAkt0KNZR+f9gUP4DpDZYfO/T5kue5XMQ9wAB2+B+34IEtOeaMdR887F0eD
 A01A==
X-Gm-Message-State: AOJu0YwyljMBJtFBDaac3QkMK/wVDZo3GpbIklgJgbyLp1KqETu3r5pL
 5mFkxrKqCC/AkJLighVi3js4MPebxjdSbEhI4gaD1iJ5Ha+J7GJV8kstSgI3HqcIZUz88tGdNKk
 r
X-Gm-Gg: ASbGncuFW1V6eBuXa1zhZL+UZ8lZIvr6zIEC/kF+ZWI5eNcZfs5YAqJonErxeUBywol
 UWzCfjQd7wJWFzZe2kRCUP9BvOTgIk9FtaFukvyVNwpGDBVh+9zdhCR3Z44jWtNd7dKU1XmSt2W
 mbvDxkm/6gekkZMh2+JSajQFGFjtvEQ0L2zzlak2lZnu8Fo0cUq8l7+/gCJmpiFLTOlPkBSm8ct
 5uy3t/m8kFk2IE3SEd49aVtAoAS9z/jZFaddw9CmOnQe8TElyLSDFIaE06aDYYxVEc7i0E6tVse
 s9wAU0TppV1eU+zQN4xXzfhi7AUI4rItcyCKk91zPzbbDT5zV9W77LOYLLlMtp5TKHeEWM/yxNn
 BQQtE4nQ=
X-Google-Smtp-Source: AGHT+IHvYfTbqI8l0rT+fx4OuSjuoM6Z4kS26FIwNKEECKLF4N8577E/p1krjT5671XLNDv+oBADcw==
X-Received: by 2002:a05:6a00:3d4a:b0:734:a25a:304e with SMTP id
 d2e1a72fcca58-734ac419cf9mr6106470b3a.18.1740760695918; 
 Fri, 28 Feb 2025 08:38:15 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7ddf2476sm3674773a12.14.2025.02.28.08.38.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 08:38:15 -0800 (PST)
Message-ID: <e38db4c6-39cb-42de-9efe-8b5360cfbcbf@linaro.org>
Date: Fri, 28 Feb 2025 08:38:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Make dummy debug registers RAZ, not NOP
To: qemu-devel@nongnu.org
References: <20250228162424.1917269-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228162424.1917269-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/28/25 08:24, Peter Maydell wrote:
> In debug_helper.c we provide a few dummy versions of
> debug registers:
>   * DBGVCR (AArch32 only): enable bits for vector-catch
>     debug events
>   * MDCCINT_EL1: interrupt enable bits for the DCC
>     debug communications channel
>   * DBGVCR32_EL2: the AArch64 accessor for the state in
>     DBGVCR
> 
> We implemented these only to stop Linux crashing on startup,
> but we chose to implement them as ARM_CP_NOP. This worked
> for Linux where it only cares about trying to write to these
> registers, but is very confusing behaviour for anything that
> wants to read the registers (perhaps for context state switches),
> because the destination register will be left with whatever
> random value it happened to have before the read.
> 
> Model these registers instead as RAZ.
> 
> Fixes: 5e8b12ffbb8c68 ("target-arm: Implement minimal DBGVCR, OSDLR_EL1, MDCCSR_EL0")
> Fixes: 5dbdc4342f479d ("target-arm: Implement dummy MDCCINT_EL1")
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2708
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> This is a very old bug (a decade old or so), and Linux doesn't
> hit it, so I didn't think it was worth adding acc:stable; though
> it's not a very risky patch so there's no particular problem
> with backporting it either.
> 
>   target/arm/debug_helper.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

