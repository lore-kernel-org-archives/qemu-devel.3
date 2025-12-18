Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95988D6E2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJEM-0005Qr-D1; Thu, 18 Dec 2025 14:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJDn-00051T-0a
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:59:36 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJDY-0008S7-Rt
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:59:26 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7aa9be9f03aso919211b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766084347; x=1766689147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Denfy8daX2OLkgvA0aVjX62fJ4udqhAHjM8A98C1dcI=;
 b=hc7sGuX8xKp6a69Rti+bN8iUpusx3qmthzjoljJ/KJXb97tPmZmebIp+maMvHYKoxu
 jEEJ940EzZ6y8Qxg0DwmbJLck/UJhNMJy6vlLHdFBKDOJeCJRIcrsYb+SSVAnXePeFPi
 kGyTXgN2i8QPEr83V7nyK3Dc6Ul3s30kHMyfZSme5KUQfFOlFD4kJVtseamEKB5Wn/m1
 dsUnZ8B6WaszmTBh5SJV9N4iyc7VnmeONpLkCHEapY8deOhykUOWlOFTyVWCvnnDeEzH
 eE/yr2zXyHhi8pVIqtncohVX9uA9evKsoIQteuo7G0XpJDi4DvoL9lLMmHZpwzj2Fjap
 nOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084347; x=1766689147;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Denfy8daX2OLkgvA0aVjX62fJ4udqhAHjM8A98C1dcI=;
 b=Lk8FsOQbew0sUIB7Y+HJJRWnWexz2HSG1tzXAvngEayv1AxcF2idQGFMgkBP4HXRMb
 2oEQiW5cwVGMsr81bunjkHpyWuJVATWbjLIq6YobT2Vyom7Mw9+QeIeqftIA9QIBep3J
 t79mb4ZRBJJd82ELXbQirU2m9/INgGGjJa4P3oqz2Ftgy+k4rqCxKNPcPipTlx289ypu
 8q6p7wZijtg752d9JtbaqgAJ8WGfcmQyF7ACDAqXqCVe1K3360e8OfoiNsHpCAjTkyiz
 wHatcOO8QXtUnoiUdf3ISGE6NQpoKhTWPNm7cZnqIpQvnbWogOZ1aX8412XqSpHGwG0I
 V07A==
X-Gm-Message-State: AOJu0YyZLGM+ELkEU/x/Hsanlcg0Z2HBZkhdzG1qe/8oK07GK9XfKbYn
 NtqKXHDffUfa1TaXgdryCJuJ5K0MNR+viFDCABxeDYfK1WfwILnEF9Jv1Ej8mTLPhgT+xFF3sEe
 0WswdBtI3uQ==
X-Gm-Gg: AY/fxX4n2cQnWBdzMV1zDNNMWwWnDNdTNu8rG+2BgoHTp8McPV2HxaE1rdiBzt+3LsV
 mk5nkmuY/5InbCLotMCKFwYImqDMD/HKeB2CPMRA6xUD6ZAMj0VBhK+2cYCMAWDP8d6gtDLsW4e
 FuqAeqdqQdPlFmvf1hlRvWSfqBvShYVQjHYXNLx/XTR89wAk9P/S4RHtkSxWlN+JLn1CrVensK5
 E0pfSEJ8c7skqhqAsY1eTOr3jeBQtt/pB6Vb742wNwoRv9vffW2xj/+B2yUqDdsZdo74r+HPxUd
 +ssrKrAwoNiCVsVD1qwsE0GgmaOqH6U9OTU/QCGsFSZIlXT7wAKj5423LwBaGSBY4GsSkjv7Y4O
 NKmg50eK7rlzznlcRPWEghbE5A9fVFWRdlxOYuQ67cZeK1RbQ6dnhdcLNPV59Uu2WLrZzNut/Jn
 5LHecVdzbxKKNyL0AeEP4B87kg3Xmxnw==
X-Google-Smtp-Source: AGHT+IGkaRJzDlXUfiO9zG8m+D3UNY69o1a5NBMRt36JX6fcwYMcKNS3e73kmREwXIL+wQd7c2CciQ==
X-Received: by 2002:a05:6a20:3c8e:b0:366:1de8:62dc with SMTP id
 adf61e73a8af0-376a77f12f3mr468537637.8.1766084346897; 
 Thu, 18 Dec 2025 10:59:06 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e79620bd3sm76616a12.4.2025.12.18.10.59.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 10:59:06 -0800 (PST)
Message-ID: <6036f00e-ab42-47df-807a-ca2ed82f6a6f@linaro.org>
Date: Fri, 19 Dec 2025 05:59:01 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/net/opencores: Clarify MMIO read/write handlers
 expect 32-bit access
To: qemu-devel@nongnu.org
References: <20251218181812.58363-1-philmd@linaro.org>
 <20251218181812.58363-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218181812.58363-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

On 12/19/25 05:18, Philippe Mathieu-Daudé wrote:
> The read/write handlers access array of 32-bit register by index:
> 
>   277 struct OpenEthState {
>    ..
>   287     uint32_t regs[REG_MAX];
>    ..
>   291 };
> 
>   546 static uint64_t open_eth_reg_read(void *opaque,
>   547                                   hwaddr addr, unsigned int size)
>   548 {
>    ..
>   551     OpenEthState *s = opaque;
>   552     unsigned idx = addr / 4;
>    ..
>   559             v = s->regs[idx];
>    ..
>   563     return v;
>   564 }
> 
> This is a 32-bit implementation. Make that explicit in the
> MemoryRegionOps structure (this doesn't change the maximum
> access size, which -- being unset -- is 64-bit).
> 
> Move the structure just after the handlers to ease code review.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/net/opencores_eth.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

