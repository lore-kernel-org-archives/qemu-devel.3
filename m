Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C79CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9t1-0007Bz-64; Wed, 29 Apr 2026 14:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9sj-0006nK-0N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:43:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9sg-0001i2-2A
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:43:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso54001f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488208; x=1778093008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pRxTLmfcF+jRs3/+yS2j8IrHCwnIEZST4WkzJ5yvVrg=;
 b=dhuAH2uK/JUvum8AXRBZXdJqmEs5afMghQ2Dh8n9YTp5ZID+hRmWXn51o0mJtC8yRX
 eYid/JJg2p6oskNTfSXLsiE1mrgV4Zj+5PrkumRpVpeg5MxkAGLBjbOXbtR0SgfGCpkU
 m7EMyzWfQ2Vm4v4glr9aj9TztGFcuLHuquC1QakSYHQpbtpIvCMdAjVl/GZhWNlurpwc
 sobLzE9IDmFqcbZU+GQBOla9Eud5iidzdXcghCOdiGvju/z27bMw43Zj1z4E/K69p5J3
 njWUfvHo9MW96CdVpOhz6Oiciv+G+rxx0RwJsch7DLgsvx4SryJArRR7Fciuhbttmnb9
 D2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488208; x=1778093008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pRxTLmfcF+jRs3/+yS2j8IrHCwnIEZST4WkzJ5yvVrg=;
 b=qYdzOnGZya4Y02km5ktVTme9qyCtz5fOk9/Eam01IxIWg4WW+/pYJ8o971uhS2bs2b
 nPN3yzQOWPHXb79G7MXJc3jRKovvGA6FA/idSL0LCb3bg1ifHICzer5NiLh2B0XqkVW9
 aRvwKrJmYgxLiwva4Ax6PD9g1AdPHSf3bEP/p0xtaDZ+2XSJQbaylRI4ShyAruoWM+YP
 i/sV6OQjC5zS+DmIQxR7QCogVEtKHENuU7+Kb0gi5Bu6dQ1beYUb2TTN/1PCBa9qZNq+
 PiF3nIjkEP9pPxbn7pLWfPmw5kW3+unHH3AQwNdF2cu9hvAVXNEL7wV7j6MrVnFe2hfm
 bjhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NFRFUrvWUq+nuO0e9jSWGT/jgoq1j8IjJaCFxxctH2ul7/PV3UfEv6JVW7ZxI4Fgn5VUMjUPmkShp@nongnu.org
X-Gm-Message-State: AOJu0YzeKLCvkm8yfulaTH/02120UWzAHsW0gqBlrH7aKZaUJjynAk13
 u+LueB4g4vv/7Lga/MjYqVGDfYksOCCUdonw/vszCHYgB1kCAy114sIErp8oXyNkOO8=
X-Gm-Gg: AeBDiesjHLFjJE/1WCaUQMnJHKPQPnds0ZLrfm0WU7vDQax/SR7UvQ1Uihw7KTzRUA7
 cB0STKtVlmBGtTAZp414+kEwIHUOVXXOhdGrLQNnWyOUD8zLWdGidE0bECym7Sqh7i1ES62kFRM
 Y6KJJKIW0ruFreasgrP4Th8QSkqAjJ0fFyqTUcnT/x/tr3ocSZYWLg0J6rpScYz4gBru3TqLpu7
 XB91mrEOesWKGWho7tU7ze820EyD3cHVAmQYE5UlGKd+nil8HiMEomHUm147wYR6eXhGoAAfv22
 Uqc7qrQtPYFCz1f/1nUqwuLvzFgQxNX72j0EMouWxXA+k61dC8IjAZjSfxz7fmXwmYIgrVg1aeD
 Um8v/Y41Pq8EMuKvP2QQ5rPGq1Ed9YY2X/5WMlPZZCT3R8nd3oO411HF70Gx1+6OT6uyb2IOp3s
 Vx9K32g601cfi6/N3eba49J43JR7P9/KaQicfRi/A50+no/DRbc7G1+UVJC29QqtiH1XFdnAxGd
 f4Y
X-Received: by 2002:a05:6000:1884:b0:43e:b0dd:396b with SMTP id
 ffacd0b85a97d-4464a4470aemr14999179f8f.25.1777488208284; 
 Wed, 29 Apr 2026 11:43:28 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7217afesm7403536f8f.23.2026.04.29.11.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:43:27 -0700 (PDT)
Message-ID: <80b93f58-3836-423f-9a09-7939e0f9c1ba@linaro.org>
Date: Wed, 29 Apr 2026 20:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/84] fpu: Return struct from float8_e5m2_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/4/26 15:39, Richard Henderson wrote:
> Inline float8_e5m2_unpack_raw at the same time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

