Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F3BFAD3EF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjtT-0006dC-Rp; Wed, 22 Apr 2026 22:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjtR-0006ch-8D
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:34:17 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjtP-0003w7-Qf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:34:16 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8eae9229110so631499285a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776911655; x=1777516455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7N1yxP0ugoI/czZkRB+lq8izLlAsBvpk267EVYHGkSM=;
 b=jwvLzf0nzFz9zZ9eHsQi7g6qWdj6UTg7iwoYLnCrqEkro+zsdSuVRsO2lH6HBD+bD3
 XF/wX5ppczXTuCWcONeoxbi2VHU7Z1QEYM2KftSnOtLGWm/DcHrHOeJeozfoodUhgNM0
 ACJDBS5mH3TNvFvF5EfIYjU2rAg7frJUNc1Ag0NgW/c5Z4rMbIU3nM2ey6ZhnRNy4wdY
 qcY0oqT3l2ZTCNIHJu2EbDCJ09JnPnMN9UkdmpWMqZf4XkYJbpsS2bF2ww7TVc9T732C
 1sURx/ANzkR//XpU0OVa6DHabtiLpAw2dV7JMmlxNA15N/ALsUT0Rf2pMf1JlBv+WxGN
 5BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911655; x=1777516455;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7N1yxP0ugoI/czZkRB+lq8izLlAsBvpk267EVYHGkSM=;
 b=XtLF+g019bfHI3yn3zRk22bhXyO81bWxRmJw40ZbEsJj0JBagL0BKi3i9bf7MmA334
 i+veynZht/x0ZbbWNr7bL3g9HLjLvipx0d/pn6wbpBfPcLhKD5z9Knl4I61fOZksMCcH
 08nv+fCygWDSoD6eSMA2hqXsyfg0ttpPBUJKdXjWuoQq414cHFp+fcZKdlkx6F5j/qVV
 9NMpaH4e1G6sE5FqpQ/+71ePS8DugmhMcokMkqyTWlW5uas/oar5mR//mGpigTPQ3Imx
 xdvyuB5NQGDZvZJ11LmTkHe8a/EXWFTER1+AiQtmW6ucAmB+/NsfXEsZaiLJcMwbPAus
 jBkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YRkNkOFnlUSsCJB24bHKlwA2Jwi8zD6Y+Ax8yljEhfCcrliDzRrjtCzt7TF+EGvWwRsaQp+5UBxRL@nongnu.org
X-Gm-Message-State: AOJu0YyOmaXlD1Bg2i7N+byq8UHeLzANG04bYy0UMDtPFNb7/yfCpyho
 N2NDpI0OWIXL9/zh71jl/pc5A3zBemmAzaWj8YGwwZkFJFhoJCmKOe1qgymdhXuHxiE=
X-Gm-Gg: AeBDietzvSXKjMj7kQdVnxR+r/8pfXqzkMRnt31jIZ8ooWDvGYJ59fGr+xMspPY6Q3d
 7QfIU1H2GwxAMGqSHiKVBCyMJ+MelRIrf8LihiBF9cstYhgNUVVIx60VRY0Tli3AN9y3bF2sg8q
 ACya7lNI8MWmk4Kmo6I4mwpi2vzpxhUsq/K6ygf+7NHmFRWcQZD9W9CttuzIRbGk8IFB0E6fGCG
 vt7F9U5PrMcRb8NgCJUdkBRzIgJwLiTwZ+5+mt4lgH0gZLEDnwktBlqT8yWGrOI5AhKNUX23i0n
 b5lLx1q+ybl5HKDpTtnywKcDWp7GW48ngYkC9Wxl+8GnS3LerG+C+fa1Izp8xngbGYcv8DmIV/p
 yp7Bez2iaKFk8Yhhb0piCjEYQJp94ohfbDIGj0vuNSvmaivxyimAmvyh4A3la+R9Ange1A50gsk
 H2j7QcLvXbbqlanQNgWKIkbv/3AYd6DbjdgpmrTgdVbHASyBipJblv+Bg+iSxXbvfeh53duoIfJ
 IACPR04ngGlWfBA31AQl4ImJP71lFm/wbyryMQ=
X-Received: by 2002:a05:620a:7102:b0:8bb:ac44:bd3c with SMTP id
 af79cd13be357-8e791d89af1mr3530398785a.52.1776911654668; 
 Wed, 22 Apr 2026 19:34:14 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d98c15a9sm1695571185a.43.2026.04.22.19.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:34:12 -0700 (PDT)
Message-ID: <11414183-9725-400a-8e49-cc7c3a559842@linaro.org>
Date: Thu, 23 Apr 2026 12:34:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] target: Rename cpu_get_phys_page_{,attrs_}debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
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

On 4/18/26 03:30, Peter Maydell wrote:
> Rename cpu_phys_page_debug() and cpu_phys_page_attrs_debug() to
> cpu_phys_addr_debug() and cpu_phys_addr_attrs_debug().
> 
> Commit created with:
>   sed -i -e 's/cpu_get_phys_page_debug/cpu_get_phys_addr_debug/g;s/cpu_get_phys_page_attrs_debug/cpu_get_phys_addr_attrs_debug/g' $(git grep -l cpu_get_phys_page)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c        | 6 +++---
>   hw/i386/vapic.c             | 4 ++--
>   hw/xtensa/sim.c             | 2 +-
>   hw/xtensa/xtfpga.c          | 2 +-
>   include/hw/core/cpu.h       | 8 ++++----
>   monitor/hmp-cmds.c          | 2 +-
>   plugins/api.c               | 2 +-
>   system/physmem.c            | 2 +-
>   target/sparc/mmu_helper.c   | 6 +++---
>   target/xtensa/xtensa-semi.c | 2 +-
>   10 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

