Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F15D15DB7
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqYK-0006QF-SA; Wed, 03 Dec 2025 12:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqYJ-0006Pm-Kd
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:22:07 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqYI-0003LP-7L
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:22:07 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so80203135e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764782524; x=1765387324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iel0om4w9WTOG2S6C09lkqaEESFcr1tmhtoi5wriekM=;
 b=GtNvVIAUQ8zJ4X88AvP14GSQfvjrhheMVbNNmIiKVszYnO7LozbpXsQ5oruTgGOPxd
 4VCfr3x9iy9nerhpSlXSbb2X8MoRLzcdXZdsqwHa/tycDl0j8gIhhBC4myQ5a2AwZhWR
 C1eSXWx9VQcuYrZOnMxqAvMbxN6KWtA0FThbJHaFU1J0jky5YsgjoTARBj7SGlWZTR4x
 VShClAX7VHSycrf0bzpNR27eHIjawr92UyZ4s2kx8y4+2xnzL9rCSJL90ev3FSn8CZ/O
 wV5yUN9ww8MWkMlprdtCHKW9GEjvNH+EwSF10SRxHYfViKEpMsYCwhmzrPiZhzbqba1n
 UMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782524; x=1765387324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iel0om4w9WTOG2S6C09lkqaEESFcr1tmhtoi5wriekM=;
 b=vI2Ow8UuE3E4ydds4Kcc+MibOer4dDUps9yvQgL7D7CY3j3NAwGpcmr0fD9Im++kh3
 +LLg//YQtcBWYR6B4DtV+3p1yHif2VOMPY/4j9dplSeowVb962EVW32F55NUNysxFyKF
 ECKRnvMjgsVZFIdepBxriMIJfmJWRuXfHLT956sxNWJ+OgaSn3DsnppLsjwBvcYsFINf
 DWqxPJhFeIZZFVMZFw6KMLcOHtWO6oTmUg9hE8twbs8SaZMd1V7QyFPJ0H9oP78Z2bCh
 AZgw+3qE/yT08cd4fUA1fDmwVjCjLbL9uthlHQGoXbrxy2ZV9OzWuuTamn0zusNdEf4P
 2hUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhcw7j1SVvBft7i+qN/gxj8gILK3Rn7Y8OWoMwAL8+YKwB3d131CCpP4SPhXOFUyiyW/dPfGpFUF+9@nongnu.org
X-Gm-Message-State: AOJu0YwFh7YZIHKRcB60Js3g+Mfb9MvKeyHq66sAV2fPNxRT+fu+392e
 Pk4UFucKhc9TkOZVjxhVLhPophW9EMABlJKCdERHVTC1dBxWrRInPHANZNS04925Sk6TVyoHyFh
 k8isHIkI=
X-Gm-Gg: ASbGncu6hg3Jkb8C2lVf6WazP5nc44GOQiOFrQmTwZChOv081db+H48hFtgJNQOTNVA
 tWgmBEnrenb/OcxauTx/yAzzNZFRAYK6G498teuZ/gSqwhrqfIH1NEicbo/Q5TxtBbzNO48IM4G
 yuKAxzeY9PCHLt+hop4u1BvC2C8kRuDuWyPkgO6DytWYbX+uGD9dUJ7dPaZiLdy8ufmABwYeJrE
 nVuxW5jqgmgSKlHpsFY4rBRU9mYuUj4EtnD+RJZEuxMADE6IUuy7HbT3Lig8i6B7lIJQcvv0zfw
 6mfFJNYbLmPwXXBhO47x23C9agcOhWUE/In4dFebstVN/Gmqb8CelY+9U62DCwxOCk4zS+qZW8K
 2EBQETXLz+q+2Xtm6jF+pZp0EbDEWcVLk7OdLLaCrxjxVrEw4gxSCmMI6YIZ6GZYx90m8tjhsZj
 b4xzbp5nZ5URmbdUonHlUSUs/IHdEP2sHBcZlNmkEwt+wu221mkzkCqg==
X-Google-Smtp-Source: AGHT+IGhE9AeEsblB2C1RPzAquI3WRwqUamqRvhSlyVMozqA5YVNZD8EGI+oFdtoVQ6V8y6BM5jLPA==
X-Received: by 2002:a05:600c:c8f:b0:479:1348:c653 with SMTP id
 5b1f17b1804b1-4792af333d2mr32151305e9.18.1764782524431; 
 Wed, 03 Dec 2025 09:22:04 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b02e7fbsm20430595e9.2.2025.12.03.09.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:22:03 -0800 (PST)
Message-ID: <3baf7c3f-6425-4f17-ae1a-8aaaba7e1f1b@linaro.org>
Date: Wed, 3 Dec 2025 18:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251203161500.501084-1-richard.henderson@linaro.org>
 <20251203161500.501084-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203161500.501084-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/12/25 17:14, Richard Henderson wrote:
> Since d182123974c4, the number of bits in a MemOpIdx tops out at 17.
> which won't fit in the TCI rrm format, thus an assertion failure.
> Introduce new opcodes that take the MemOpIdx from a register, as
> we already do for qemu_ld2 and qemu_st2.
> 
> Fixes: d182123974c4 ("include/exec/memopidx: Adjust for 32 mmu indexes")
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci.c                    | 19 +++++++++++++++++++
>   tcg/tci/tcg-target-opc.h.inc |  2 ++
>   tcg/tci/tcg-target.c.inc     | 14 ++++++++++++--
>   3 files changed, 33 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


