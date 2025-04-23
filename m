Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20B6C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WI4-0002kc-7R; Wed, 23 Apr 2025 05:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WI2-0002gX-9o
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:21:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WHz-0006Ju-Pu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:21:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so4872171f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400065; x=1746004865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xIuUy2QJttCB0e9d+dmUA2TJ4/4gpP3/UpaFE8hrebE=;
 b=zrMFc15QmACCCA3R7P1++iseCLP5UlfaFjTmoUUU7cvrGQvLu+6+KA2xZzTUCGiRSd
 5fpQ4ccwvZawIDQkYigoZlJq2zz6iaB84GRapoVOL3ErM3cpTwZ0nX30tVlONkczrq/K
 KNcxvxQqxgxEwLZg+O8wMRsDE36XuktQw5K6ULYq4BQepSyTOgABA2UbC4+tLZnRS7Wp
 g57VfiZSG6cw9GevtUoSjK6J532mV9jAFd+I652ctz2O5zPfXQCLm1anmdAeDf+nAupa
 5pDfaOInoXJndN7zRcxkpSMLbitMrE8sf3Vvni72DfWpQMbUAA4HK29uz+un9Uc7X+2s
 cWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400065; x=1746004865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIuUy2QJttCB0e9d+dmUA2TJ4/4gpP3/UpaFE8hrebE=;
 b=snjF7oJpKzO4dVLQgQEwSyIrVbf8eXA+7HC5NEfnTEJf4+XDDPBqbBbmwVl6KUkbEt
 c/ORj1IeOZxyprp5WpsMMSQopUfePWko7zhQrqn4KkX+2LI7/z8HXE2ZdufqV/hDPila
 tD2ytOixWT4rriQ7NSRAA/1NdNQk5PHw9jyXJIrIieIxH+4Kme31YBvDMzivmrvjw9vh
 0zqApRJqWt65qBzBmVXzBTlOmMLby1hdiyObR7x9JDQMOkqq8di8wfRH5TVGC9Ah+J3X
 Ts1/iYYmm5cs74zxXXbUo5JDLLZs+yc2tgffeGwq6IK3bRy1BPf8xtBh955El8Og/5yV
 IuSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj2SsWC1IjPmBo6qMYXKTVUzLHQoRXwMaG+5GWVOMgXEAuydxm3zd1j9tcchlSI2R3Y9+bTZG+q6xO@nongnu.org
X-Gm-Message-State: AOJu0YxLfiqIm2btCgUUuXhloCh2tfjlPsaLTmMrHw7K+JPyazZEV+rY
 qq/3MFh8epOErkE+w+fdtaFqU4Mq+pTU+ZuOXE+yc9kNW0vMTC8BkcBti2FxiYQ=
X-Gm-Gg: ASbGnctFuMBz7kat1RKecVckPswN2PqQw2KzZQmYMHHmyBP4dpKUN0UM/6ow0QpkO5h
 e7KYqUQTnv/aPGsXhf4sOGrYVyT5LEtOrerH4V7Hh/Xm4IZPTawvE15IqRpi+LBLURiSDYdhg58
 jjpVZfEYGn3xVJ87LMTA6lUixmjc/rixwbS7mPyVYeGT+ylbHWhPLTiV8tw+pyLRhW8QCqHHsHL
 eBvu1F+YrJefOBemdKiPnjTwRnrr2UQkGr+rK4xinrXDC0UP7yQcw4V9loJF5KiX9et9fLWhSx3
 tM/rIZAcSpbiDfmkfH7qjUpg5YD7cIPilpRw2SXrECXnDEy6BysYhs2/zWdGghhjIOoOrQ3R8ah
 37Yj6dGuW
X-Google-Smtp-Source: AGHT+IFUVOYSBEvJrdX8UK0zsqmvAx3foCr68vYdj9wIMZySSa7Cdtk9Ye/e/z3QLcW15k7KVVWg4g==
X-Received: by 2002:a05:6000:4a1b:b0:39a:cb5b:78fe with SMTP id
 ffacd0b85a97d-39efba8a4f4mr13533109f8f.34.1745400065422; 
 Wed, 23 Apr 2025 02:21:05 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d03csm18389239f8f.59.2025.04.23.02.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:21:04 -0700 (PDT)
Message-ID: <9b5a3f6d-b1aa-46f8-85ab-cc3fe189858f@linaro.org>
Date: Wed, 23 Apr 2025 11:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 011/147] exec/ram_addr: call xen_hvm_modified_memory only
 if xen is enabled
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250317183417.285700-12-pierrick.bouvier@linaro.org>
> ---
>   include/exec/ram_addr.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index f5d574261a..92e8708af7 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -339,7 +339,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
>           }
>       }
>   
> -    xen_hvm_modified_memory(start, length);
> +    if (xen_enabled()) {
> +        xen_hvm_modified_memory(start, length);
> +    }
>   }

I thought you suggested to un-inline first:
https://lore.kernel.org/qemu-devel/9151205a-13d3-401e-b403-f9195cdb1a45@linaro.org/
Can be done later.

