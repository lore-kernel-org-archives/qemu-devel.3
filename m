Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C567CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v441w-0002yP-KU; Wed, 01 Oct 2025 17:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v441k-0002pe-J9
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:06:22 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v441Y-0004rx-07
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:06:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2dbso243186a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759352759; x=1759957559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yfFryuOhw4dhr3v5uGB5/AVDZv97D7VVkdVBtWfxI+4=;
 b=n2UTSDAuEYodFSVNux/knkS1MVPGsXn8ARbHycVmnnjlEH1nNq+QFi7xUatpg9o8Nf
 m/3Cs8e6iNZHsCovybxnmeENponV4cKBoajXek2UzWdgnvIXHiblqS5wqJsEoiBGP2P/
 voyEri3jlXI1p7JgtQWIkXpDAxN4rKj1yan0Fz5GBmo5n5W7lXAug4vszPxowDD9Ju5D
 fmidjg1ylp4AL6nS2rZRzOoXYHeP8kJYEuiwZwCaRaFlHSuhetFVBPlJ8LWU/sxcqjBw
 4BNHKDN1iADGtM0O4oeCVyKTYBX574c3ehEDlq10KZLAGk7ct7S0Zx4/gUtA0+KgW7Zs
 uYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759352759; x=1759957559;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yfFryuOhw4dhr3v5uGB5/AVDZv97D7VVkdVBtWfxI+4=;
 b=p3iJZ84in3Rn72ihsNceN4z0gBvlQt/7h+9IZCrLLL79wMxJxOfedOG+CvJBad1JVH
 O832+B060Mw5fOLdauEXKIj0QbOSoFd0u2UEy54tnjPjMjI+J3IgxAfr2cn/8r7ls+aV
 iWn7qkjuERioi0UPKNNE4en0gtLS6d8DRnmw5jYrJkRPY2D+pjMBzVs+My6QPJKzaayY
 0NHMlYDZoNNmXTMO7j9y0c6gqWCfdlJ21Kax7NdO/fZBguvVw7I7JFAXbGJ+GutuhCaX
 N/kWoebqktiPzSk4BVkhq0NK22SxnXNTz7odcyJzJRqXJ5ld4VfQThPHOLlUqxP/doI+
 U23g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbE2QXdRXz6I/xsxPd7g60awbge2FYs0XAV2xy82bUNZFzpf0Ohl1HS3OcmtgcvlUMICYgyNYpcSVL@nongnu.org
X-Gm-Message-State: AOJu0Ywxo7vKSZ+icBd6RiEGhvM5uWgRjTc9bNWJ3se2VJQ44ayqaT7g
 btd6338puvj7Zx/yKtE2ZgTvvCOdizNjWb9qjHKYn7SFLQ54B/OlxsKfh+cb2tMaBW8=
X-Gm-Gg: ASbGncvLOG8Q1cLOoVmDVv93EP9k7SuKw5C3muuLJLPJcOdoDTHLpGQxQYxe2ZYCqDl
 ixtv8w3QCH2LbAiPFtBqsvh1O5rpD3dY8T6Spu/xxAqqDvJcUo8Wt7+jlxQLPoYQr8fSEl6AEnm
 ghfiHfq+Cd4d+yNWz3JPBZUi6nB0d8SwvNhUzMOi0PYdHZkPZiCgB2KyzUIFXH+Auuz5YO10jh+
 vo/UM5Vbvz/CEjkPG57MEQ1JIw7k0YaUOwXbMaYZuLkGXvHFUPsPGtM/0nvBFR0DbzkOWxYNxW+
 o0UrdcD+ZoXXBZfL33TC/f6spjy4C1DC2RAp91hCLshQnzm+9NSkFYhVuTcHk/AsFfODSw+kwCz
 LZFeGUFdkGGcgOT/BM7o0kFAFTZOj+hVDjsCWOAwFSjOKBf1N+LjNEezo25X6
X-Google-Smtp-Source: AGHT+IFj7AklmnUtUWK3aOPgo60NM55n+zYVS/nR55/6H/ySQMJ6y1W5sTw7r1TTPV7i3Rv99rFO4A==
X-Received: by 2002:a17:903:19ce:b0:269:82a5:f9e9 with SMTP id
 d9443c01a7336-28e7f2f74a7mr58843915ad.29.1759352759452; 
 Wed, 01 Oct 2025 14:05:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b87acsm5133525ad.76.2025.10.01.14.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 14:05:59 -0700 (PDT)
Message-ID: <2539cd05-e9e9-446f-93a2-188c3faa8948@linaro.org>
Date: Wed, 1 Oct 2025 14:05:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] system/ramblock: Use ram_addr_t in
 ram_block_discard_range()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001164456.3230-1-philmd@linaro.org>
 <20251001164456.3230-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001164456.3230-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 09:44, Philippe Mathieu-Daudé wrote:
> Rename @start as @offset, since it express an offset within a RAMBlock.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ramblock.h |  3 ++-
>   system/physmem.c          | 20 ++++++++++----------
>   2 files changed, 12 insertions(+), 11 deletions(-)


The patch subject is now wrong.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

