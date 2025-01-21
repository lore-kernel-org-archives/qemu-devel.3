Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CA2C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNLg-0004cZ-AH; Tue, 21 Jan 2025 18:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNLU-0004Wq-LI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:07:46 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNLQ-0004HU-6d
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:07:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-215770613dbso80816245ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737500858; x=1738105658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XkIkFKI/BEinBdottpQ7QgICUzJEVNnYg5qzzSOzFg=;
 b=dcQzjH0lI8Q0AbvBT8DW5qJ6EJrhxV4w5UPBWscjvugcMEIfDYqwzJSwoiEhKgpCJy
 9UeMoStfvEqwUrQWJXKhhSQPYgrAwym7ahS4V2QHzJ4OnWnB78DnZWA18SDFy4jlCRT/
 XXqR+o4GdQSoXXl9Iql8FSsakPcIZYQ2xcSemvRYbF8AjRkFL6iG9IBSA5HxzXv2+xM9
 F9RTVAN5OiaIMP3Tp4xXVUKaSlln9fOLkGZBNW/kcb0PQIpOCqgeiOsK3JqGnYc3x//e
 4orTHcd0ym96P92tzJ25194yDYQSVGmp6BK8h/DcUYobrRpNqmmrtCSXbdWP4lUtlwOJ
 +bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737500858; x=1738105658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1XkIkFKI/BEinBdottpQ7QgICUzJEVNnYg5qzzSOzFg=;
 b=UcwPxWg786CX7rI/alNW2pqCKMV5/VveGXEsGO35x2Q3Vis3GAflnkTW7evJamAcqM
 2H/gP+pcjfyyvm3CnmIEDV5DNg+GdJlg1XChTSjnI/USdqRJpN149i15F0zXDTp3/ysZ
 92J4PxiGCBk30kaWD4NEKZyjQNR4/tse1eyzyBnQMfg9zgTfiNlN/QeflW+cnRsLZ6FF
 6ksT8zvkaUI/OkjY9VE2+kHScNlWdD8eNE2xzEiNeVtMiVU9/UiWriavtgNNmsUtJQXw
 ligVS+iZJA1ZQ9W5ySWuLvbFq1SeJsCioBDxBp4/tsWbwq05tInDXECT9bonyQFK7L8g
 4CjA==
X-Gm-Message-State: AOJu0YxQC2gmGIK12SnDz2D9igXAhs2q0xFqig/ru7pX8pIE3du1AIZ1
 mPZARurxQZpXTwR7NGQWGDIU6rFYH511/0767Es0T6O5xXy5kfsHkuX43F2SHgtAQFlLYVoFkIY
 F
X-Gm-Gg: ASbGnctzk7l6yojVJBecjAKiVrVjHwARIXKgaODPi0bF7ggkuovYYxBvir0DvRTEi/m
 fdtX8mZLmwRcSZ9BVEUeekt8/eKI7fqVSkKWJ3w1+zl2MTv2jAa3oKFEHWmg7n7aRDs+XHf8NRg
 COqmWOiVWmq0H2uiPvA4dNSSY4Vrms+u4dnsd2KncNbi0KJBVoRcH6OOglkIe14nzt/Ga3hRWdx
 ku7eyUwNjXPRZ0dUdREaVrSOuBzfBiUtbrgUkAWwq38QJEDOSghUuevHQpVlYbrSatVe13Q904a
 UbVx1IcoQguA9FH9Zk9K/dFes3JBOvH+nxys
X-Google-Smtp-Source: AGHT+IGX74gr+Hb64oJs/asXKsid1kgeDgtOFLHBokeYlzWb262S7rNzDu2b497ggSY82Wy6sCs07g==
X-Received: by 2002:a17:903:1108:b0:212:68e2:6c81 with SMTP id
 d9443c01a7336-21c355405edmr332378625ad.24.1737500858232; 
 Tue, 21 Jan 2025 15:07:38 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceb9e7dsm83218415ad.77.2025.01.21.15.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:07:37 -0800 (PST)
Message-ID: <0fa6a043-588c-44a4-808c-2a588b65596a@linaro.org>
Date: Tue, 21 Jan 2025 15:07:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/mips: Initialize CPU-specific timer/IRQs once
 in DeviceRealize
To: qemu-devel@nongnu.org
References: <20250121161817.33654-1-philmd@linaro.org>
 <20250121161817.33654-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121161817.33654-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/21/25 08:18, Philippe Mathieu-Daudé wrote:
> The MIPS timer and IRQs are tied to the CPU. Creating them outside
> in board code isn't correct. Do it once in the DeviceRealize() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/mips/cps.c            | 4 ----
>   hw/mips/fuloong2e.c      | 4 ----
>   hw/mips/jazz.c           | 4 ----
>   hw/mips/loongson3_virt.c | 4 ----
>   hw/mips/malta.c          | 4 ----
>   hw/mips/mipssim.c        | 4 ----
>   target/mips/cpu.c        | 5 +++++
>   7 files changed, 5 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

