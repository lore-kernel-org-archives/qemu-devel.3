Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EEACD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2U7-0006rq-F5; Wed, 13 May 2026 01:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2U4-0006r2-1j
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:50:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2U0-0002tN-St
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:50:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3870445f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778651411; x=1779256211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Sf2tfuWuKlnukLq4+ktSa8pLfgoE3IU9Ogh6uxa01M=;
 b=BhPfXA2PliiWtE0kFy9uakaMZaWvHHu/LUc1ou1U8yfEHUCqlZxB9MlRKcTqf9CHZV
 PikMV4Vj3bzVlZ6LkOc14fsS62wz/24jPcI+WJznOat0xSBu2nKHJYTZms51SFR33ao9
 zc+xGB15Y4bo59sMsCVzyBrJSvUKAvojWgRWuSvAJL1e0MwoQP8uhOVMxs2y/Czai29C
 09bPBWvnscL/rV5aydsGogp1cse5Ol/b4pKKJZpZ8sbwvQr0YaIYkMY6Ir4/GkmyWuiG
 SaxBUQiiwzA0BhxJp0lYGmze/KAgv55kEL/QRkdeX/XJFRSPhyq3Z1NhvXFRBtX7jE4J
 lTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778651411; x=1779256211;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Sf2tfuWuKlnukLq4+ktSa8pLfgoE3IU9Ogh6uxa01M=;
 b=q/zmOYtWsqRI4TnuhYm9bkctRvpE5IhoxofuWKFDg6sCQGgainOEeBma8xpmqh2Dc+
 vlKk/axdEsEyX9bJp7H6lCQlGXXkwngENimWhFq1/NJLkUD0trSDNi1gF6IxiVJoV3z/
 u4CDktL6c5PPcuTQHo+ic9WTIZ42wKfeUCkyQIfFiNjD30i15PybLcN+N7Wf9Y5+Tz+I
 MZLHsNsYWHp0f0pGzOImBeP9mbD0oM+eFBxJYz9EfiheJ3kSadPEvwSHfaqwEdKW15P2
 vYQHUQuKx16/YD67Y7P+NMaI6ARRab67I16gBPjY99Z2nLAijkVmVXuX8SvOvzA/Sddf
 P87w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lCEyvKBs5Af1oSggCuBpk+aDCpkHvjX+uBxl36h44GMazsOhG2gj0BFRAr0ymHqFvrFnD4E7pCG0a@nongnu.org
X-Gm-Message-State: AOJu0Yw0T6afP76t0J2FUXsrVhk+dFZXLXxJBH+KPGUgHk7luHwSnzPQ
 jaJOUYSbJ5L7Xr3Ymp4OkfRMe1k49eqHWYdq27LZ5ZKnqgdn18ElXNdzHrjnZJPxU9cJCU5X5Mm
 fTOkeyvQ=
X-Gm-Gg: Acq92OH7BZexShlqpOWM6bh+GG7M6VEy8rhQPPfvKi5ICYnAdnAegng+xE9WFW1sxsP
 iVnaz5VWKCPsXjrVdDPTh0ynhAgGxc7TJpXKcc8KlJ0qUEPz1TsIUxvjuqMJlSvSJGwzsOwF0AI
 2/THqoSExRRwHLpZjBExo7TI9hZA6uxLZL3Wq6SpV45/gdHSq+3O1WBWnuEhJnBAjRam08QO8cp
 ir9fOguZJqzlu7DgRz0JjB1uN+GsNVGEnIY/levcb2oQa9vimllHNi12yZhjlmpAc6N1fT6z8Fp
 3xR3+gyDdwVTOii2BWOiWWmhmFE1f9Zawlm1DXMelmYSrHUWG8TV8ukcnkJ5QjAPoWcrQZUSOQK
 G0SW2lcNeaoP5VtYAP/+6EiirDzrKTdycPvAgGpbjVCA28hhrVX4HJ5p+e9ZrIrqnCjue8DN9ij
 BVYuE1/y68oGuGhmuOvYoeo8XoPCVSIqrQ9V8P3j52IBzSzRQjnylhfXdyaEL1D089sg==
X-Received: by 2002:a05:6000:2485:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-45c43bec213mr2946543f8f.3.1778651411111; 
 Tue, 12 May 2026 22:50:11 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454922715b9sm40182522f8f.36.2026.05.12.22.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 22:50:10 -0700 (PDT)
Message-ID: <1c139eaa-bd0f-41bd-84da-b071a0656474@linaro.org>
Date: Wed, 13 May 2026 07:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] hw/dma/omap_dma: Remove unused ifdeffed out code
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512203414.3633237-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 12/5/26 22:34, Peter Maydell wrote:
> The OMAP DMA device includes a lot of code which has been disabled
> via ifdefs for over a decade. Whatever this unfinished development
> work was, all knowledge of it is long gone, and we're unlikely to
> be doing any serious work on this device model in future. If we
> did, we'd likely have to start from scratch.
> 
> Remove all the ifdeffed out code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c | 94 -----------------------------------------------
>   1 file changed, 94 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

