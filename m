Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35EFD1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxGw-0002J5-8V; Thu, 08 Jan 2026 16:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxGk-0002Bj-Fv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:10:10 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxGj-0004b5-4o
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:10:10 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a3e76d0f64so10872625ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906608; x=1768511408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s8nLlMvScOIPC5ZIyJzQYot/vxP22HMesTL16tLtg74=;
 b=nV+YFcvZyxAp+21Dec70toJaa2vvbcSYzN7eMzdBS1cVZAu4RCGVYczCBxuzYz5fS7
 RiW3rEjsR+IEi6xn5YwmNp1m27OUvXBRQkcmEZNqTmNiaE3YlkQgnu3DJBmnwcbLvorN
 TUaXehtI2JfhfNumo4rIQOs/3dJnIkVr08uSSoUN9uwn6DMYubXTkTaFeNfzo38gyjvf
 p0km3t772hfPm9aph8I7qNuD8EucML4ySIjqugF6h0f7uRnZ55rcFau+jxnvnxw5ZEyB
 7mO80xIrJ5Z39i7w2hRgPeI1Wczpn3jVme4eHvZso/CTeErzYTQPb1tXuZPSaeK6KUF1
 K63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906608; x=1768511408;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s8nLlMvScOIPC5ZIyJzQYot/vxP22HMesTL16tLtg74=;
 b=gh98FB28MZLPuTekoG3takBC4OmIJTQZLuuQ0DU6kkJKq0TtV3CdxIcucJhhVzphSM
 vp8j7sCx9XWS5ojfrU8tGP0Ot9CKfY9mOSuoc0hsNMBVwWyXVmv2F+vQbuQPsuwez1/u
 8q4jDcyg7f9IXwtH662ELPs7E3qFUflXIZ7tj/F2sBi8+/xC5kHIAjxuc2086Afl41gN
 WAUVmiFPAr++SLjZ7MU23NwfbjwxS9q8BOQ8c5IxNUg5D5bNDjGcdS0SNZU5iH1sFiy4
 TUArynHxSo0llDLsYOYv9AJWOcMlf/muAEBoXUnMUKl0ezAPSzbc6YO52KpP2YeSTXBn
 n1dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9l33XJtzqskR+SFdohD2rSAdh6+4tF8MghHpTZMXroll1Xg6XzDGof4RFGYD3dUlkW6W1L0ZnNnMn@nongnu.org
X-Gm-Message-State: AOJu0Yy/JLKEx5sWjmKzBehP3QEIFLw06pV7ZjJDcuCAb6a0P5Q6yjXx
 j7iSblQ1TEOdi6STInpgH2Kz7Qt3tT7pJXt8GPU0T8m6707h/vyX1TewlJUgWl/gqgo=
X-Gm-Gg: AY/fxX5hqGa49VTOue82cEQkPsGKnFYoJDZOxvT+m1/Vj13ADDhGTD3OH8AC74lVrfn
 6JN/vRjBIiQm9aFq+CpLB44RHTdTXzSApT/UH3F+pUMI0Q/6ULpmSRJ98NorBBgSTUZHCgT+a3w
 YJrMt8R6jhggIE9pJdmKc+KVX4fuGIMnWltDqORxSPhyJ+rGtK4YuSGPfG8v5VuVSuXn2HKGCXr
 3l7FUuvrNvDnAEO2nqbcuKToS0gFJtqthnoudfLQpFEiqpeVN483OOvcR6SH5HDQtGzv0oyF01I
 30SxEhO5/5nJgXMstlMO8x7t8Wdhzd9AUgt10AHO0N54dhlyJYz3mlJ5xkB45dZDXUy3xN449xt
 Ov8T/BsmG8jI1B6KHJF4i8MrBZsj3s+8ltAKnJd7u8kzeE62ftF8HcG3rR4k+vSxs8EGACaT0EQ
 EDmjQLK258SQqpsk/GIew1gctCQg2KCZoSFhHAf1tTio4I+0hhGTl59qUT
X-Google-Smtp-Source: AGHT+IG6EfBBCx/MduwSdyCbUUMizLxHAu90vkpAw9fWhW7GUMYR/GDHZ6chvKFwVnh9ISuC08tJ3Q==
X-Received: by 2002:a17:903:189:b0:2a0:89c6:1824 with SMTP id
 d9443c01a7336-2a3e3991076mr106378465ad.8.1767906607590; 
 Thu, 08 Jan 2026 13:10:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2c0fsm86998235ad.66.2026.01.08.13.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:10:07 -0800 (PST)
Message-ID: <7b3bbbdf-4e1d-47aa-a3d8-4f1cca0bb1e4@linaro.org>
Date: Thu, 8 Jan 2026 13:10:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/50] accel/tcg/runtime: Remove 64-bit shift helpers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-35-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> These were only required for some 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime.h |  4 ----
>   accel/tcg/tcg-runtime.c | 15 ---------------
>   2 files changed, 19 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

