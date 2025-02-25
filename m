Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AC1C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwAR-0003v4-EO; Tue, 25 Feb 2025 09:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwAO-0003uP-FK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:44:12 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwAG-0001BT-Kq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:44:08 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe82so5984613f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740494642; x=1741099442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SfwduAnSn0GaJ109JcrQLoruPnhZV20e+COlV+vH434=;
 b=nuK6uVgt0/oI8gVswA7WOaxTIDHBq3v8bQU0HPdrTj94Q/x8uwXajAmEJdRsKYyvqr
 DIyLrj0513KGnir/HoFFM2M+RUYD03TRfsamgVi6Wa5MR2WIzCib0GWggD8nVYfzrSPB
 2gizEdQ9dBrAaZ+Tb5ugYib9+WBPSvqFn3tSJRBul6wXYcQ+i0ck2uHbSFJQCo2zS8DH
 D1iWWch6UcxEky28lFouqrf11z+rSlAAedmOuACilNuitsC9xFIAScues8a148bBqcur
 mllVteikpkNvtxyiXajUjzwUZeU2l195lbmEu2b8jemQD7HDpEZq6pi0L4E/c9VDxVtJ
 dPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740494642; x=1741099442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SfwduAnSn0GaJ109JcrQLoruPnhZV20e+COlV+vH434=;
 b=jICSzbs+LizcT83ixIwSaa3I7+J+KQJIKTfHNMxBqguggCioAA+Wwmw++rTn3cdXpd
 R6K7k6VQ56dv9mVJA5nSVueOrlr1E7ocAPfbUxDgEa2+0uBU82oxmh/UK/apqkIya/2L
 S2aqgsqHWXbm7O2pQ4QsXYj+kTYeyPrgsdV2T/JIJmp1TRco1XpfZPYEegV+D+0I0+yJ
 R04CY7WsCQBJE0JsTUaD4P+DV7UOrARTyIbMEaw3+FatUBrFsoe23f2vd+Ux624hj005
 SOFNynX4JGrHZL+je0xSmmlYphHPwMFyOvjT3umVLM0yOQmPOq9MohP3PDYRZ0hmOVwd
 yJYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvFWFyba9ViGuduVZ7pvARAvEjOGCcMS7ufm9u77Jlb/n+HzRPhBAc0LLVTUCJGO5Nr3KJBiC7ARG1@nongnu.org
X-Gm-Message-State: AOJu0YxM+nRlFUsyJV0laPTJoXpomn+x98QqJb+OhbkoeWYoB0HxuKNo
 hUz0LVa6U7tKaKmWSAlSUat2wD3WFvDKQLgAufQyV2rP10BF6rozRQpacJW4lXU=
X-Gm-Gg: ASbGncvUKZeXmclXMg+ct+pCjyVWD38ldA2+0ttI4HcsDKLMElZOGqFpSealyg/6ET2
 X1AbdznXb2FYRqqT/OUKKShbZ2H1qn1PFeeIh8+4hOYftWyggNZKezdm+kHYXf8QlXQOHiyx3bX
 9YxN7VJ2xMK38jArEsxdhyfAa5IJ0syfw0Y8bDcQ5ZblUlOd/m5mOcxDH1rVjBAPPv8KPR84Er9
 TnyGLye/06HkiCa7CuvlBcPPQLQJ8288iWLawme8WzW9geJdg4iQlnhTMLMIzcWJvX2T6tquFpS
 UJUyoi0Hip9jmm7H9vz+zju2dOyUFQZcqJdpxA1ERxch7SBLP29MleJm4NyhKOUVAHilPg==
X-Google-Smtp-Source: AGHT+IGUCSq3Za9PiLlSygqzEDbV1gCcTl6K7gSH69LKUkDhLcWiqv7a5S20ke+RD5Sr3wSkmhnoMQ==
X-Received: by 2002:a5d:47a9:0:b0:38f:2856:7dc2 with SMTP id
 ffacd0b85a97d-390cc604026mr4173481f8f.18.1740494642274; 
 Tue, 25 Feb 2025 06:44:02 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1539dc0sm28823265e9.9.2025.02.25.06.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 06:44:01 -0800 (PST)
Message-ID: <4b103a04-b119-4704-b7c9-d8e3bb482832@linaro.org>
Date: Tue, 25 Feb 2025 15:44:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/loongarch: Fix some modifiers for log
 formatting
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
 <20250225-la32-fixes1-v2-6-8ec68ada3dd5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250225-la32-fixes1-v2-6-8ec68ada3dd5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 25/2/25 01:40, Jiaxun Yang wrote:
> target_ulong -> TARGET_FMT_ld
> vaddr -> VADDR_PRIx
> uint32_t -> PRIx32
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
>   target/loongarch/tcg/tlb_helper.c                  | 2 +-
>   target/loongarch/tcg/translate.c                   | 5 ++---
>   3 files changed, 4 insertions(+), 5 deletions(-)


> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 97f38fc391338ba4b76115b142fa76d89e45cd62..a1426b46f36c99e300ab924cb487875ec21ab226 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -517,7 +517,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>   
>       if (unlikely((level == 0) || (level > 4))) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "Attepted LDDIR with level %"PRId64"\n", level);
> +                      "Attepted LDDIR with level "TARGET_FMT_ld"\n", level);

"Attempted"?

>           return base;
>       }

