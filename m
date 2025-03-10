Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79362C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfcA-0002hZ-Ki; Mon, 10 Mar 2025 12:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfc8-0002ge-NX
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:04:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfc6-000714-0v
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:04:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2255003f4c6so32908445ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741622660; x=1742227460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hjM3z2K9Zz0Q3+hQLNU8o8Y3lDwcqAvbguD52a3MJqU=;
 b=mpTgdIuQ133Llbs8DIS5FgL1MpLBPcG2FGpnsirWuNTxFatGqAP8jFxQhiXxc72WDm
 gmlFr9RMhcgE4e/4CGeC3yBbhouY6A8iGr1q0vqn9SgWxPkr1W4e9fY0q6cP6NUpeCh0
 eEam5jO1ONkiGC1Nt2ygr2VeZEkMmJvS6gGR3w+Fu0JjLlVG6XoIQsYdqW8glE74ssUS
 kPBGxRXcxtBPLHfxtNDTGifLhy9Othj31Q4yKXN5TF5G7UPxWzjA+Oiaq8M5zlnXeBWo
 tgmN9AfLXmIEfsMAuLUTVcWOrCthdmZXcasIkHObKQpAtYWH71SWi3ki/HqODLM0Pftk
 8ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622660; x=1742227460;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hjM3z2K9Zz0Q3+hQLNU8o8Y3lDwcqAvbguD52a3MJqU=;
 b=kRxZADuBR95xZiuhhN3hJ5fmbTzUGpsuozqZpEv7nbnzb0FYgxkp/onPW3h4vWNI9B
 lei6wf+xduQkt366DG1dDgYXJuztFpYcLJgyuzLRvatRBXShnJ8PyXLZ/BxOSA4y7PPy
 YiQezJunn5eR+7n3J/pqbcrxIq0zfAMKoP1HHO0RTJbHal6fj9drFSJHBWysuj279tMe
 qxgV2MFv5TTghLefSNLt14SRyzAOX9UNkbjFCfb+doJu6zppxyAZhQEPuuX2wSELM4Ma
 Bt6W37rH0+9ek4BB0VtsC3ARGth+wrZf0s8XOHXzDZDOobbw/3NDIVW0CLeMeXVxM/FV
 L+Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaRlSZ3xqaZGjl5Y6YzMFplRIzDnR3FVHd9C+2jtYPhcIls9vzKRgZmRnl9KhXstLdarYlUI56XYle@nongnu.org
X-Gm-Message-State: AOJu0YzdKxEdECPmHdf9rXZLUOznau3nKT+7rULMSjwHv0/6Nu18Blok
 oC7Xg9Yitdo6qK1DZvhl5RY/WhYZyvjGlkofiyhYAegqICjQqOy2CZz3FhbFmOysmUJ9H6mx6FH
 EdoU=
X-Gm-Gg: ASbGncsWBlJU0uvAACGUVKDam26Y84t8bvXDd7JTXYItPr7gh1g4q0lhCD8VvUDw4S+
 P5feAjoC78btEfedeNMNowoQddXzcBhTT/jla9XWuGZ/tiL9HItaJ7tx1fh2aChRqbEMyfGS6yk
 qbBJlFwMOk2koYO67XzkQpnwbHVMFL102nd5zJClyFgHp2YhdPtxegd5v2/nnSHeyEHuNV7EHR0
 LLzWe8xyEBKxsAlZEjHX/FamZWsusU4aCGX1gv/PQLZG2zESHjSfiWevUHRVO2tLs0ZgLaFYy1R
 0QlWLHrO9dRixQLwi6wRmFLtPspbpN4nTTLklXIicKHi0N/oALWaPLGsXypiNz4agSC7
X-Google-Smtp-Source: AGHT+IGgmdAQIxytYYe2dFJZyLgJ6GdxDGQ/gyD6JYLXCfbaDpyCS1GVZm1cF/lz2LzC09A/ADrQ5g==
X-Received: by 2002:a17:903:2d1:b0:221:7b4a:476c with SMTP id
 d9443c01a7336-22592e2d657mr5059105ad.18.1741622660040; 
 Mon, 10 Mar 2025 09:04:20 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a92699sm79683365ad.204.2025.03.10.09.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:04:19 -0700 (PDT)
Message-ID: <56ef7bbf-f412-438a-9468-74b9e94c1371@linaro.org>
Date: Mon, 10 Mar 2025 09:04:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] exec/memory.h: make devend_memop target agnostic
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-5-pierrick.bouvier@linaro.org>
 <b58ef75b-36fd-4089-aa64-3dd8601a1f5e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b58ef75b-36fd-4089-aa64-3dd8601a1f5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/10/25 08:25, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> Will allow to make system/memory.c common later.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/memory.h | 12 +++++-------
>>    1 file changed, 5 insertions(+), 7 deletions(-)
> 
> I guess this was split from patch 3 without updating descriptions,
> and this is the TARGET_BIG_ENDIAN reference removed.
> 

This was intentionally splitted, and the subject mentions the goal:
make devend_memop target agnostic.

As added in the description, it's needed to allow system/memory.c to be 
compiled as common code.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


