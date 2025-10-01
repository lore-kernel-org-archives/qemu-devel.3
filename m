Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4115ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3z9c-0008U3-LH; Wed, 01 Oct 2025 11:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z9Z-0008Sn-D6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:54:05 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z9H-000185-TL
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:54:05 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4dffec0f15aso87991cf.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759334014; x=1759938814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KbJ01SkZKCBEt8pqRr7HEHGV6Qn4yPaAuNgLxcUyLrg=;
 b=rzwH7601r2XZrTbcfdJXkttJmNy99jhWj8qly0VrZ3y5xr6t/Cb4K9fXIvq3vJQd8g
 zxbrrQyRJaDOznvdlacPLY0GAQwj/CpPWX72HxYgo+9/cEj8K5CmGF2pTcEMBNL0QU2K
 d4buCBCfkMK1RsrtnyTgxUK9XREMaGgo/ekeRbtp+l0/9M9enloDPyg+z4TKng56pieP
 eiBWxecy/kHFqsAOsrrYAbbVRtl0VxsJ2yDB0tRsVs6VkEgotDBEe7JVKqdYcmLImdJH
 EJpuC2BSjW0aCJ26KxADc7i4xjATmBdVj4nwO0pKPcamAs8SuBtrVsBWJ+yGAVPpWp7b
 4NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759334014; x=1759938814;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KbJ01SkZKCBEt8pqRr7HEHGV6Qn4yPaAuNgLxcUyLrg=;
 b=I5bfEMjXnsCEn+MJopXdu0kHRO2V9HQ+os7QWkBFNVnzemG5BEIvuy4mOKC+0pUhkv
 1eT/sTs7VVRb4sFsqMMR2+TzCpkcm7AlSz6GXEM/r9zbXh/kFozhLtrZtVq5aya6pcxb
 AAAJ+HRa0uBbfW7+gbqQjTLtBW8fbinFiNMxs+SdsXXRA1HXTngAZCRFG0MvhfL1qbVN
 xJBnwlUqGv4u9RuqG9gCHK7A2FHalODzyf72vYpPV2B731OeQak54gRhyhxcLdLDoBYc
 /acb3SplK2ElKeQ7qgDImOXKQfw/8s0jZWB1eAZVusbsg6fpmw6EA843JpL5CbdoYRcT
 G/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdrQ24tYeXKiMJBuonF/T5UWk4k6Ci96MKOdx3fRFI9ZYCuBJTpOkuCrsaWBcfaVoc5FI2MpPAyMVL@nongnu.org
X-Gm-Message-State: AOJu0Yw1crjY++oGiBccQmP/rlPfX2pyITwUZUs2w1mIoIaZPpiMVXWJ
 ic4/r9HJoRNEmkVhUuB7bIwocqlQPwtp/6MdSVH0nu95xzh7aTGCtF7W9ezguRp8IDl+tEiu3JK
 hQ1mj
X-Gm-Gg: ASbGncshc8ZBWgYj4BYH7xs0Dcz38sAWe26AH//vDYaveV/vUGowOuPc8gd/f9jsMOD
 l/xQtji65SvGCoRSXkv/3jvicpq97hbfHAHs2rtOQwv+lGjVE3vNbgvFKWNWYMGfe9rImH7eAwV
 hHAi9x8v4uagNXeFQkmFR3C3y5HVwihq5Dl/Bqb3pC5G7l5J4knLtuyXGJ19oqhr9HKnc2+QXlu
 SPIrst+J7GxvtAM6bLJuHw6Dt9ipuFooS8lAiE+/+JkdZY+UQUcyEkNvOILwdmzeruBEFvTmpxm
 yhlPDvWmrHf3r/NK+TDkoI3C/7uwVrDR9MgJtCvKPtWO5/eJbC2ftcA3Scv2MYHiT9/Wz+HCIwB
 F2K91nSjejKPjqr4Utdq/pRy4R8yS3hVOYY9zcHAquN/s2FXY3vBjRiI3diejFbstZrtM+rNMWv
 Ny77o0MLtgL8mAfEAydzXdu7YtHoxXEEk=
X-Google-Smtp-Source: AGHT+IEa7sVe1aScw5AiIjhx0WviZtnD9Kptm3v4E2anRTpJBrIZymxax9/x2iHW2sL70TcrUTgorw==
X-Received: by 2002:a05:622a:1306:b0:4dd:3871:93d6 with SMTP id
 d75a77b69052e-4e41c82e88fmr46727801cf.6.1759334013574; 
 Wed, 01 Oct 2025 08:53:33 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55cfd377asm752231cf.34.2025.10.01.08.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:53:33 -0700 (PDT)
Message-ID: <34be952e-c9d4-4557-89fa-aa14ee65acec@linaro.org>
Date: Wed, 1 Oct 2025 08:53:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/25] system/physmem: Reduce
 cpu_physical_memory_sync_dirty_bitmap() scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-24-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_sync_dirty_bitmap() is now only called within
> system/physmem.c, by ramblock_sync_dirty_bitmap(). Reduce its scope
> by making it internal to this file. Since it doesn't involve any CPU,
> remove the 'cpu_' prefix.
> Remove the now unneeded "qemu/rcu.h" and "system/memory.h" headers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 79 ---------------------------------------
>   migration/ram.c           | 78 +++++++++++++++++++++++++++++++++++++-
>   2 files changed, 77 insertions(+), 80 deletions(-)
...> +/* Called with RCU critical section */
> +static inline
> +uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
> +                                           ram_addr_t start,
> +                                           ram_addr_t length)
Drop inline at the same time.
This is a large function, and the inline was only needed for the header.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


