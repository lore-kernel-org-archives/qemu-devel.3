Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD5CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 09:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu6O9-0004AQ-3l; Mon, 17 Mar 2025 05:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tu6Nk-00043z-P9
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:03:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tu6Ni-0001VF-W9
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:03:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso12624635e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742202212; x=1742807012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0NzP5ues2cUTX5oSD4nW3ka8/QDaW3K1Y9I5K10kfb4=;
 b=ouM7nymGMILRsS2mHYFn119vGO5S2p5LK7XGrfk0dvFSYK2l6cF6ujxJ3IlX+hHrCl
 ksEeB1UrwufYNQIYCkbwkLnRZDzqUmpc3Kg6rdSpVbAC7K5pEmP3W0p+WCfFVthCC3tg
 zNa99iYGSPH1w1bLSVp5Ei09KLW1HLwBm4p+oNI5CMf/PP5FB35SPx3YX08d7CJhvHzy
 kRrfUbilbGth1jGfcMKNta0gdmma01TIVVEEYNnV9kaGf88nmyicNRKPmBoRbsTFi1qa
 +szt1nXpbIdaiw8HL3/UDxpUDvG33qTEcdp348kNLqDEM9WJ2iicYuaqF2C+UabP1jwH
 /EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742202212; x=1742807012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0NzP5ues2cUTX5oSD4nW3ka8/QDaW3K1Y9I5K10kfb4=;
 b=RS/8v29VBp4260nAbTLJ75qH1RqOI1SYkLewWMtVEIarJu0Ls5hUbuA7KCUoq3iext
 Av3PKdlnGPyHpKiNHrGhOKsoCWpKLal/Y9co+4C+u5Lb+z5KgeV77oH9l/dpJfvxyPsE
 4a3vUis4RVTNmOEOL6R5GljBgevIc7Rky7PjwbfEtcRl/INXsfRx6iF21sbhal6+BG1S
 dX/+SZmhdTta/7Tnw4FAsuRDWkutjMsASzY0zGHcedAZPseZcV32XRFK864cLk+Asfoj
 0Sp9nssviMJOzM56bLHISf7BI4xtwNE76W1sTuMeDbvcw2yCJkJOJkX7blge9hvNUo1J
 gOOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ7iHfTIrVPGZ0295ZApSK3/0JBqUZXXjLeLlkw7LGB+Njc5inbtu2eK02nKi4j7fKqdOHEdSoQH0h@nongnu.org
X-Gm-Message-State: AOJu0Yy4LOeoBoKuc6P079fOWZvAHuhnZeo91lSQJqzRQ6B9+c0IXOq9
 4SjswFzZtlAB/DGQXineMnoUn0bC/hrjC3ZMu1gEfZg6yThmXSp/fdLjN00hMFc=
X-Gm-Gg: ASbGnctT0x37JRVT30hviMQVGFgc7vDgEXWl1JwT5XWVw7tK221McBWUjt3dlut7pBy
 QTVyaKgxnyZM8Bu3XIKbrn6i1O877KA+xwbzfRXhH3xMvPWgVWamC5xN5PWnXH+Z5MnyT8LKZhP
 RyDCcIa6a9zV71TSAxs1oDqm4ZGdJBE5S2t+XP93zgU1V3vPNtKjeJq0jy0yK8rufkVrg5uMmWk
 Vdqcv5Tj1XdFHzWk4tgl+UK3H8ThK1WT96h+VcyHnlvFjZVRGgkjMDdnFRztHhMohoaPNZll+Kh
 JRAZdPJb49tmRnl+k+PG8Z7GEeTSVzH9FeCFHnotEzWYtmu8ROYBf3IzgnQwB6KjtuUEcBxWuET
 eLlk3t4RuEDI=
X-Google-Smtp-Source: AGHT+IHUZLx6v+/rMbt2CU1hAcTr6TJ5WZAdaMRRK277NE9RKrD6+z8sE/eVWBCKAx0BpuAYbHUPjQ==
X-Received: by 2002:a05:600c:4245:b0:43d:2230:303b with SMTP id
 5b1f17b1804b1-43d22303221mr91954895e9.20.1742202211768; 
 Mon, 17 Mar 2025 02:03:31 -0700 (PDT)
Received: from [10.223.46.213] (109.21.205.77.rev.sfr.net. [77.205.21.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc49adsm98657195e9.24.2025.03.17.02.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 02:03:30 -0700 (PDT)
Message-ID: <4be1fdc1-3c50-4e20-aaf5-f6831a944246@linaro.org>
Date: Mon, 17 Mar 2025 10:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memory: suppress INVALID_MEM logs caused by debug
 access
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250314074107.992163-1-npiggin@gmail.com>
 <20250314074107.992163-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250314074107.992163-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 14/3/25 08:41, Nicholas Piggin wrote:
> Debugger-driven invalid memory accesses are not guest errors, so should
> not cause these error logs.
> 
> Debuggers can access memory wildly, including access to addresses not
> specified by the user (e.g., gdb it might try to walk the stack or load
> target addresses to display disassembly). Failure is reported
> synchronously by the GDB protcol so the user can be notified via the
> debugger client.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   system/memory.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 4c829793a0a..960f66e8d7e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1412,18 +1412,23 @@ bool memory_region_access_valid(MemoryRegion *mr,
>   {

Alternatively:

         int invalid_mem_mask = attrs.debug ? LOG_INVALID_MEM : 0;

>       if (mr->ops->valid.accepts
>           && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> -        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> -                      ", size %u, region '%s', reason: rejected\n",
> -                      is_write ? "write" : "read",
> -                      addr, size, memory_region_name(mr));
> +        if (attrs.debug) {
> +            /* Don't log memory errors due to debugger accesses */
> +            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> +                          ", size %u, region '%s', reason: rejected\n",
> +                          is_write ? "write" : "read",
> +                          addr, size, memory_region_name(mr));
> +        }
>           return false;
>       }


