Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F0CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 00:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3OMG-0004yp-LR; Mon, 29 Sep 2025 20:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3OME-0004yK-86
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:36:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3OM4-0002Nn-D2
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:36:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso2229448b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759192587; x=1759797387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=atdlI7vzKpmqD9zWnpkRWycEonRpOIznWy4luXoh9jY=;
 b=yVlG7mbWBiVBZLjMlMRT98ZFWWmW0k0J4OA/Mp6c0dbBhqme4/SET/D4vCNig/MyLT
 IhWfvP/3kUg1ndFKhuthuKAVi/g4Y/uQvTIMFhkVcRV4smao5e4bFpo9KprChtGJsK7/
 vwQycfjNihw2WK2lE4C5gx58p8cIXtHIT+x8GQbUk+EJWpFetjZw5N4IEdiRrFt7Q3Ee
 UMbhtEgwSG75L45LedYcANcWgt69R2cwIXWg1aWPsWIZphDte6KG47my31lnh4uwmcZ4
 FwwhJOLRzPtHw8TrIMmhpCYqUXC1c2v+P/QV3i4DnkohWGUcHLidrouasjpLQGnctxGi
 yAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192587; x=1759797387;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=atdlI7vzKpmqD9zWnpkRWycEonRpOIznWy4luXoh9jY=;
 b=ls2T9SRGOBGp6OOzxIDthVPklK0Jmxa+SZNHjQ6E/u2bIiwpzNbcl6G6eMfZTwqo5m
 bVz8Inw38IWH3hDsWYKbInst/qnJjwnhbW/dTLJ0dHAzNwmA7UIyvz+n+EuN00RGf6Gl
 xjQjB+aQISK4qGY1OOFk20rMvH/gPo3G48W+ocOL4ctq91KKSjSTHXvSkPxAjB/6A3m9
 k4721DBxtSjoi0iMAvRAb4E0SzFyRo/EqMEpT6zvD/KcB6CsCLVtBmGztfMgsHaDz9wB
 nrQfEB4C5knlUQsec8Ypn3tMevAepypd7qLgHSOlL7R/bYIWxkZo7HF1013NecGxJoyj
 Hpqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl4kca5/LYX5oNuO97t4a72fGtGP5eERRP5RPMBdQuyyYK8lrKwDelMZkKAeFa190HqMk+kZpJgNAX@nongnu.org
X-Gm-Message-State: AOJu0YwSraIXUtTiT2SFdjj+CG1/Y5IcXott9Y3haEhJ8605cHUZ5jeR
 GFsSvobghSkUvVmCoQ6O1YePAH/NfFNDcyofnACxrsqqOSmEzAv0nMOjGfJhRb+LjnY=
X-Gm-Gg: ASbGncu96ms7woq+K87AXlJZ+YTuEVq9+TD0mhRM5ZvifqgrmCrGVDsQyptU/YkfuiR
 fBzRCSKWk6iYjmB3SeoKWI0BTD3yi6gEt5zNt5mdLZy1GccRWPB3SnPcLHMH1BWfznjBXOVbbRD
 +9UaR9GZY9ndX+0dNhpm4AZzzODjJehDshz9xCbzeZ6nhsTkrm6JMHBFSbfOpbEl5s9fXtpycPY
 E7OOZHDxc1fA4txHbNDnOPNHjy2LNb7W8AdjuAotWFAsnmcfgPrCN6mmyAi03TIKdmlesWt161N
 VQkH+qFrMj/HsAf1fDb46shRVS+oGLhrDOUx/ZvvLAQiWhTWvDLr++gQqHu0F3m/NsHU9COCDo9
 JCWkk1BYpxeyHbVpWPkrJ2BzDqwDEGW6DRtIo39l+hHhT9RLOtYXQWw1rhax+S4ueQVGKa5c=
X-Google-Smtp-Source: AGHT+IE2lcaR1N/0LapnZf40wxoCvgtlUzC3bIQ79yHI1mQNHjwDaPjzRhvMTLogX3G6iXQiW4IMmg==
X-Received: by 2002:a05:6a00:180f:b0:781:16de:cc0c with SMTP id
 d2e1a72fcca58-78116decde0mr13109432b3a.19.1759192586997; 
 Mon, 29 Sep 2025 17:36:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102c06af6sm12035118b3a.88.2025.09.29.17.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:26 -0700 (PDT)
Message-ID: <998c8711-a75d-465e-99d6-672f5d6e1164@linaro.org>
Date: Mon, 29 Sep 2025 17:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] system/physmem: Remove cpu_physical_memory_is_io()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250929183254.85478-1-philmd@linaro.org>
 <20250929183254.85478-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929183254.85478-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 9/29/25 11:32, Philippe Mathieu-Daudé wrote:
> There are no more uses of the legacy cpu_physical_memory_is_io()
> method. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 2 --
>   system/physmem.c          | 5 -----
>   2 files changed, 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

