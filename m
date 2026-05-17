Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E22CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 16:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOe7B-0008AI-QJ; Sun, 17 May 2026 12:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOe79-00089b-9h
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:13:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOe77-0004Mr-M0
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:13:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso7432635e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779034391; x=1779639191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J4KmTFDxjt9peL1fIkMDgewvYMtRoTZEayRboPQgiV0=;
 b=huFx4EzgCrzZu1P1FaCq1FXyRfh8EzXXFONRvFlFOza7iTDbilsihhupTif9kGslgQ
 MbS3vW25KjXu17sRmGcuIRQiBc+JfYQp9z8JkuUWpxssXrQqHlwONZVaLQT+p9huKbw5
 Oo2i0qKjfa/tSkrqREMlx1JHB0vwwCbYnprnO2sDatBESQ80mfdqRP4p/yS0CUhn76Xa
 GiA9Aw3sQPB6fVnmBRqAtDd0Mzpu+g/kk0i1b7XdQ4/A7HBQBhnoVjbbDyv9spTq8bfw
 6NmPZ0ZHCdXYdcdgiDqeYs3yGCd4JoT4LCVwEsjzvGtPLpr0iKS2IfrFD12UFZ7xkdMk
 RWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779034391; x=1779639191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4KmTFDxjt9peL1fIkMDgewvYMtRoTZEayRboPQgiV0=;
 b=moD9E5NO7OWL61skSPqN5WoXGfCKHkUlcDm1mG6KWwvXUm7klm9HggT4pnJ2aZLhlF
 /vf4b/OZx5qCKKYZTbG2Y7qtZe2Hoq2MsFDos/4AvgZxeo3AyMdtzkwOVPVevLlySO71
 0jqW22b2zSdrrnaoTEiAU3XMknGCtOooOm6RNAS7oMAxsx1TWrjW95BLPsjUHXOmDlPj
 l6AO+laVsmiuufSJvQAGtxg/Cmhj2EvQnc3zJuIwAiuCsV7NMQ7P4LRtEl24ZPD9U4El
 nOiwKZB9Vyh2mdCGSkJHBltnyD3HYQ4QNTwcr3iXZw/Tjl0/2UzQiZWIUPkjzLIjrvL7
 IPJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2dncJhnyWwqyiShVnTGVd9UUGH9RvtqOXWaYOCZRqE/fH81i87m3tlmudv4AATAHcO9StXeNwASl3@nongnu.org
X-Gm-Message-State: AOJu0YyTJ35Yo/5wI4spnlmIN7HWlt73hVSsgIhCBiwg5wuuodIorcjy
 nkbB4+hD18miLdGsF1L5RFeld/5qdf1HsTAWsfr06xBxVTl5xMRUGq4pNZCf/osXbnY=
X-Gm-Gg: Acq92OEEz3U+WXC/WQT+EUV8Z0kJ0zKTHL369E2rfaPoKd0ul75yUC6Kr+T4C6bTHR2
 G9MKawbGrSx70OUwotpCVV0WoLTk/tKSmYK9IZ68gr9okmcO4NiPgFnWpYpLmygPpQYHteEUWTD
 u0i9UoSelKul1nq4SSk0xeMPcMtI8zv48Lm2cMuFLD4w8uneyyugF4rLsCTIsDkt4sKFHgNkoVZ
 CYrwQKsIgKLWTcE7W7XhJcipy1SzAk1GRihRHvM81rP/OLCaK63O/gatr25bZ/wmcndUhkPQXFC
 +2IFJna+VCDVAtjadyv7Lvg/d/62SL4JQgc60rE8/i8mBoio5uPdCtqEPRUbR/+XPyW+CK8wLEG
 +DNE99vkxM3c0J2xjRL9vRGt4wlcmQtC6483GuroCGF4XK7KKCErWF6YqOFEjm6rfSjvSDXeL4t
 uNLswNM1IZIC1IZS3oUAqWoWse2CCAt3WM/H+L2KQHiGFRS8TZ1aioyjGdbaMgGUu+LA==
X-Received: by 2002:a05:600c:c096:b0:48a:563c:c8d6 with SMTP id
 5b1f17b1804b1-48fe5fd4b51mr129127675e9.7.1779034391275; 
 Sun, 17 May 2026 09:13:11 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm88144885e9.1.2026.05.17.09.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 09:13:10 -0700 (PDT)
Message-ID: <9acb9e94-27f3-44a4-a8ab-f2cb67c75328@linaro.org>
Date: Sun, 17 May 2026 18:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/63] fpu: Export floatN_minmax
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260517003002.321430-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 17/5/26 02:29, Richard Henderson wrote:
> Allow target access to routines using the minmax flags.
> Make the existing min/max wrappers inline.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h   | 93 ++++++++++++++++++++++-----------------
>   fpu/softfloat.c           | 50 +++------------------
>   fpu/softfloat-parts.c.inc |  8 ++--
>   3 files changed, 62 insertions(+), 89 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

