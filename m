Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF7ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqcm-0005CC-Tl; Tue, 26 May 2026 08:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqch-00058T-TO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:11:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqcg-0003ep-Ab
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:11:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso41179665e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779797460; x=1780402260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/s1BcrY5/kZuQUR2dUK0bQG91PnxSPbeyLPjXumN9Ms=;
 b=rElr+nZ9FLSX+V3RB9CllYpYkFgzFXBHUzUVWLpRzjiTHuoeH4nTvysZTYP8USjEnp
 D1jGSyhV0FD4yghtcpxqg1DUWJsXlo6GhHNnn2pF7O/pofg9OwePnd2i2F72dVtWSr9d
 Pq3R7fat6yAyfg5mOpKTYscACBEJxVmmPa4cVqXW1H7v8a+3fAfQkd+FUfkt/EB3OgL0
 3Qe0uGASkfpbGW8wNRPP+ip6eCVt9FKOnzTpquFdrNIkvaCw/6CUVrD8lbnnYxZNML5y
 qF7fDGqGlV3MPZMygFb+jU6H502AHQllCYfYrXnAVYSF7cn1eKkwfKDRSfeArOutO2Ly
 Tlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779797460; x=1780402260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/s1BcrY5/kZuQUR2dUK0bQG91PnxSPbeyLPjXumN9Ms=;
 b=c+ZejgrEfau88CvFaAnE8ois2TaeS5hN9YtgVCppn26CDoVXPGxzUgJjI1h13qMkap
 V6iUhXmCZ1WA501FuB/fGfdNXezhoqNxqCJUJkSjxVyZaWyGaTe9X/jj5lpdGlUYwymn
 lXwu4BJgdV2akfMXdfkAQSzY2AUtgZM2K4Hoh6NgqlBZr6Fwzpp1HPXO/yjZEKt8T9/M
 OzCjJ5IW6xML8u3/BJiBB8ojwKjuEgOZGxyUG2y+qpDumvnJLEPDGlJU49l7cA3q/jAH
 sRacvz5kV/rN56feUbYFcVuZmn44enbXMtPeUZc3gb8ZmF9x2DVyE8MAakV3mA/mfXVO
 9aUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n5h1ta3pLKGf0iPDf6tAnxZfmGEfZnHRqtvvL2i3HicyB+pyIGGCt1HT6NkUWwOrqnculvgXhGqeQ@nongnu.org
X-Gm-Message-State: AOJu0YzqI1EgsM0EdbvH0tBHbVWqhtdZwb8uAQReqcx89IK/AfQXS69L
 dsowW0qrKcrHq8OKzWct8WSayi6WANGbSXmDJzsMNCfR8E1pIMZsrySM1kJeFmn9bSQ=
X-Gm-Gg: Acq92OFlMNHplYZYd57TQpNigVCCNQsI1hBg3iQhdpGjX44rrrI4lJmXLtHlQ3rBzeq
 Zlz4y0ua6ImYkG0BXOH7agH89u4jWtPzD+06KaI/jKby1YCqR3CWJ/hukcrmxbcxjBzZnBtpPG1
 q1F/2TbkoZiInZOECu2g537t3hEU5IyuZ/WEUh4ofyNJ8mhFr6P5QZEkpCwz9wnKEN1Vuhx1GFW
 EaF1OxRo7EemD80lCP9OcCZjx/DjudOpIN8eMswUETAquzgTM5eB4bL5z2tY+B6QMMjv6UGP7MS
 t/7RQPjBi/EVPQgvIyWJBDt+SZu+CU0qoMOq6Df4Hkk2/D3wAtA163SYbxDvqWVXtMbHcyuFyYm
 Wj3IgUmN/JNu9fBLimDKgv3WXgOwpA4tjBTbTfacuBND9R5a2lP8VIHZAvLjtEhbUg4j7DmoikK
 PjnDkirhTqQI2ucNO6FBdIMpsOXOvAMF3b0m9REiTAq+bror6pVGR/TUJi3STpXiEAE6TDhRQ1J
 y23
X-Received: by 2002:a05:600c:5298:b0:48f:e230:2a26 with SMTP id
 5b1f17b1804b1-490428e16bamr309970805e9.33.1779797460393; 
 Tue, 26 May 2026 05:11:00 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ed1939c6asm13938965f8f.2.2026.05.26.05.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:10:59 -0700 (PDT)
Message-ID: <8dc10f32-9923-4e3a-8aec-46dc1a88e5f4@linaro.org>
Date: Tue, 26 May 2026 14:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] target/riscv: Remove unused tcg/tcg.h include
Content-Language: en-US
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
 <32c6c8ac5e0eb7a8da660054bb9e59ddfc154e25.1779792111.git.fritchleybohrer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <32c6c8ac5e0eb7a8da660054bb9e59ddfc154e25.1779792111.git.fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/5/26 13:04, Zephyr Li wrote:
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---
>   target/riscv/cpu.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

