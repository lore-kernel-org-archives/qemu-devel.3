Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BA3CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3z7Y-0006v7-Bz; Wed, 01 Oct 2025 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z7R-0006u0-Al
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:51:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z7F-0000vn-Jb
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:51:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so68534b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759333885; x=1759938685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ExM71hwE/fvqjf6UdseF3nDue5V/YVX7xcBAixuT0AM=;
 b=HkTaD3qFjZY8A1tKXVx0FtNRsGbV+qBVlOk/ysz11V6EOpVngYQ/6+MevvVpL60iHz
 8uBl4jGpXAvXz/jgdr2zcYtdJG31U+3sRtoNeuIKb5SNTWjqxWGJwe1t39Ly6vCDH3vm
 b1JcYc75KwUymyob0O9/0u+8I8IlGKKPzk80c5ARy6lNcZC9pQoOa7tKPOzw1gTRdVNz
 9rPVkrKIJDlgXRcTiNw8+if9qBXoPWUEEmwO+WcM4zjlsco5UKLFC83Mk5TGcUKAUCxq
 WJZkYG7ItpTM/uFenjlH0mcamcagGP6VUpdeHKfZjEDfo61q7leLxGvaVboATShfFOqe
 ZXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759333885; x=1759938685;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExM71hwE/fvqjf6UdseF3nDue5V/YVX7xcBAixuT0AM=;
 b=N3imdh+nSijDaVxIPhX/AzCIO1UpVDxNri3/PahbwKDcgHHnMu94u2Amp5ZxWJUfo/
 PK8Z+egxTH1yz+qPBXeLZV2vCgu97aDkiOVvJVEAPjqn4eEwcw6pdjTXFwZRS0NuXw75
 DhVPbtVoe5/BRW29Z0siNq2ziuHsk7FQLViaA+wJtyvvrMIj+ND6a9bzgaeGFgNlTnt3
 VdzEXH2O+XXiDWTXaVSM4azi8F4G1dd3eIj45/lIOFJdRvPdfwhwG0OsWR8/T0sBKC6f
 3wMJfgTDAczUgYhB3QZT+pM6AXlVSLIGv6jAx1Z8eCDNw92+mNHwAYW9L3r1Tl+ylnUS
 hwFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAlCm5g23GfvVW3vT5P1LaFKTptwA7lwSh2d89UJiKzr6KNxTolki9DyzcNHdw/8DcoMzo15Jcn1xz@nongnu.org
X-Gm-Message-State: AOJu0YxIY0asv9+rNF4Bf/wlk/R5mmZzFdU6VWNn4QDiQRbDm6Mto5j5
 W6Kwmd66N1uYwnz35N0AARnXc1W/n+DQh6Mw1IOv0q/zS7GEzdB9e6qp7Vx1PGctiME=
X-Gm-Gg: ASbGncsfSl6wJ/5COV99+MZgnNrMFyKGnX5RfiQsDNMhw9YlNIUIUi6vmR4tO790pzo
 2v3shJ7UxTE+DowZl/IVzbMSdnVxgnxWIvLt5NAmHZsxnDwZ14ADncF4778/FXwxNJNuv4DNxPr
 IjSchofyEtMkoHMtHLNdMZEbtLCgOtj3FooKM0BpZoAvayDGQZoiMgJTd43yUgrEY3oke/OqAxN
 xWMJWAOYzDS/pPwkPfP/v8Wtg7PTJ4R2S9q66/3/ZgCbUgJo+QfRQbVlr+/FahwbzMGiZhcxU/e
 HrWHHOoNIZlvZMqWafJZSdSIER6MNPwZmrqxLe4kfCSfUZhVhdReUhsSnfvs0leBRNfwUeck6Bs
 UG2UHc1TSRCpyvPxLcbHUqiSF5aisY3HYOYlhIs/RiftSPQRMt5LeArjdyHXl7G4BqST3N4hOQ2
 TbtRw2V0Uab2uMTqSDCHAKx7t6Psnmls4=
X-Google-Smtp-Source: AGHT+IHZjpCpwbc7IBcfk2j2SeU25GgJDQnZoVdDKIjA2ILX6+evS6ScRS0N1jUGE2BcdikriAiFWg==
X-Received: by 2002:a05:6a21:329f:b0:2f9:39b0:fd88 with SMTP id
 adf61e73a8af0-321dacc34c6mr5788874637.21.1759333885267; 
 Wed, 01 Oct 2025 08:51:25 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02098b77sm68217b3a.93.2025.10.01.08.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:51:24 -0700 (PDT)
Message-ID: <833908e0-280d-4d37-8f4f-85d3da13f5ca@linaro.org>
Date: Wed, 1 Oct 2025 08:51:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] system/physmem: Reduce
 cpu_physical_memory_clear_dirty_range() scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
> cpu_physical_memory_clear_dirty_range() is now only called within
> system/physmem.c, by qemu_ram_resize(). Reduce its scope by making
> it internal to this file. Since it doesn't involve any CPU, remove
> the 'cpu_' prefix. As it operates on a range, rename @start as @addr.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 9 ---------
>   system/physmem.c          | 9 ++++++++-
>   2 files changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

