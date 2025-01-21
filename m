Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DBC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGeA-00027E-L5; Tue, 21 Jan 2025 10:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGe9-00026b-Kz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:58:33 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGe8-0002Lw-5r
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:58:33 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216426b0865so100419875ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475111; x=1738079911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gIrHZ0c2iTh3jXSdH/p5VWMnasPEDnPNa4raTYMLQjM=;
 b=EFxhFY3fbhe6Alb2n2QwXPeY39mgeNkAGs/d2linY1fmX9L6UOm/jqetGNBkt5QAoP
 gN4zpuJ64W8eRW7SiHgK9jUrFYKK0quVC5VT9cwpDLcn00qcZl8DnaX6swpz0JaVDQWL
 PeKBzql8DyErbiNFyuZl1wU0YuMJSZb9Z+SuxFu39JqSzG5UeR7xWb8X9nYUEWw9n1La
 ULX0ISUqjnbGlgTD1BXGxBm7H2NSOkEUEBGZMT1KlKzx1lSzmIXz3yQU3zzxKluYjlxv
 +QMX4NT/oKlS0tEMay+FAallHE3HC0e1L0zCx95BvcQlk5ZAWQXL5v3wXu4DDcStczV7
 MPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475111; x=1738079911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gIrHZ0c2iTh3jXSdH/p5VWMnasPEDnPNa4raTYMLQjM=;
 b=oJb3JtUma7/+FI9cYL28WH2WJ6PlOb/WYKqZY2vVMuK8rEuDk/19AZsNP/mzma8GcP
 jo+guo3Eisfb7vJP5ZtBSP7aM9KNBxVF9OABsJ2ehNQpgypZWmHZVAC1Qd3Ebkvf8+/5
 zGgR3KlT6BU8azBSx2+dIqG7fwKD4ku07YKxsTnqZasiLwyWjkpAmVavlxQrzEPOV3f4
 f4wF65ZZByBK/QYbYdofumqz+WiIz7b2HDJkhXo3zLLwFoLLrCmxK57+vV6IqcMUXGJy
 nRTGnqSRTfefb/LgOTPndeKFv8+xrjT+1rUMbYMA34RJRibJPY0WAaTL8wbjTmF7BX31
 I01Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJZiMmXFz/10Gpo7NdZ7hZidCUg0m37eNs6XgcnfmIICkuhkafRlIRb3z9N+bsenykXVl7WK/583qy@nongnu.org
X-Gm-Message-State: AOJu0YwWvoeNt92NTjHQ+Vckt+kKty4MiFJaphf13hdKUqM+EvyxsEjJ
 RyI3x9xzctO1BxC1ZrMNHvDqPyzs0D1eO9NJ723nTSPUDzun6TMXt8qP5ANu2nY=
X-Gm-Gg: ASbGncvhiZify2y/uOrq62HElPFFDcgtBolv1sD53gqEYV0Gi2GurdZGJFQjYLlxktK
 25bgzsQWUKnYRITfEdzJ8ZSzDwZ0fBjemLJM6YdHk+FzND1Nw9f3ZoIVxErcP+qCePoFAAbyFvG
 S2aiuvKyjcn+a4v0dPjt7Bvv0nk8j7/EYCcDUOIW3uPkefqkC9FyQWmtrgpyMyFdenkFnqRZH3q
 Xb77AeGmQf8qzyC0stWQZW0BXuqsW2UOyit0RItqTmVeo83fK6AXtGFfK1BqcuTOslmIDAYAiXf
 CYJ9+aYwW8P1Hpg7yJ82+yiVcabNmskCVns6
X-Google-Smtp-Source: AGHT+IENF7fyUvzZuQGn9pHaJMAMFwBxfSlvSxjWqVLKwA8KySCKzjFvGEyLbkAhsRd6tOvtGY6WrQ==
X-Received: by 2002:a17:902:dacb:b0:215:5ea2:6543 with SMTP id
 d9443c01a7336-21c35546dcbmr274484125ad.28.1737475110958; 
 Tue, 21 Jan 2025 07:58:30 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea2e29sm79601185ad.38.2025.01.21.07.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:58:30 -0800 (PST)
Message-ID: <e77acfd4-be29-4831-b034-cf95161b5681@linaro.org>
Date: Tue, 21 Jan 2025 07:58:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] gdbstub: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121114056.53949-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/21/25 03:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c     | 26 +++++++++-----------------
>   gdbstub/system.c      |  7 ++-----
>   gdbstub/user-target.c |  6 ++----
>   gdbstub/user.c        |  7 ++-----
>   4 files changed, 15 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

