Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4ECC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 18:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPdm-0002de-Tl; Sun, 23 Mar 2025 14:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPdk-0002dH-22
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:01:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPdi-0005x2-B7
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:01:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso49408015ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742752896; x=1743357696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2xmPGVgeMRBKmsCFQqtt5fFNBLmT1ucA+eqOVA8FXhw=;
 b=HTrQRZbUinjDiEqDIuEQQ8geHuJwPFe7mTeHY2IaFeAr7I60Ezgj2hkxwgE8PFhJFq
 5+4g6BJ/xWVdTWpEORemSDCP7VHu0XfR1FMkCpDu4EjLMWqH40g5TWgD3hJN/ax9NmqY
 jCMX6u6Yhn1wH9Z1p6RMK3S2C/XZHJ9OQFmcNc2O6yODt0Aj5IKI7mzJmntfAb3hzcmC
 ryiAFEl2wecYjdtLLTiGtJYI4RgGSDZLcJRwtCrQkEwBCrsM38B9Jayx1qbw+9ZOru7u
 5Gtol0Hk+wUv7BEMhDH4AvtcUNABWJTDwPSoorGLbaVVowclQmxgiAf1dMwhT8KWqHfj
 d27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742752896; x=1743357696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xmPGVgeMRBKmsCFQqtt5fFNBLmT1ucA+eqOVA8FXhw=;
 b=twAmwwQApD6yUJvWm7WpcKyzHDNucTvs7PkyPABweYCNlDrLoPn5974ekWaWgAQib1
 6zjztffpJk4VDwR/jCbWm4SNzPTBZ6xSJp32qJXwjetu16lLqRrgf5sZYzOcRZZ7XDVT
 w13GhegjeHleZtq2I/bqAdkDR/i7mA/gYqPJgg19bTc2nE5nCqV1QLz5n9nPDiBL7a2F
 jbMH5uNe7aVBbuOs2xRvlt6oNy1m8y6C/oPEBLdyhtqja8Ii9lrJQDFxM6TT59NaQ+3+
 PnQW7mmVusG8p0b4bbFtpInUYSZ08gVWWLVUhky6YTp24J2PlxVxcN9sQnErZZXWtiDY
 5gjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYQJAkvro39I7Ki56P8GwaTQ6e7ruL9GiTa8NvNaJENRKorx+tsIsBi/P1zO6jigtlnj81pcejWF+J@nongnu.org
X-Gm-Message-State: AOJu0Ywrm4XgfBns7myvDeIFHlrmmna3lzjrXsmG9nulunP5AjChgpAR
 Zyzw3+S8WHexCaKYO0beHCFcy8euve7my7C4y8PFg5MU3B7JEaYAuDjoqQ32ug4=
X-Gm-Gg: ASbGnctX114rQnIQ4fkSgRPTEaWdqgH8Ji3hlpOmo3yl7JWIdJ5aPCkBpem9nPMUSOK
 H3HdXrrilMwz4c/zISjCz2YDBhZ9r4G8yxaRw6Ss+ZVgKvYQlbYQ+rQIrKahCbIk+vXutztJfdh
 qAIP8uk2vCy1FYizjWM4Xo+FI10rJGOuLTdSZZrhmp898GGT2YlIXGRJn9f6qGHo2QFpl3x0UQE
 jZnXBD6f3IekusSSrajWvwnJUEoIX39hXk2Su9v7BmQBH4BLauoJqI/Y9p0nNP47rGW71VBeU4O
 1APiM8vjmuGJRLlHiSgAERfi2/kYxlxOGouA0kJcrheXF9ZGePDKC3HUUbAeGiGFSJQ4B151TnD
 o6KAN8PEW
X-Google-Smtp-Source: AGHT+IELFC4mXddPni2kBVoTwHDgyDb5PrQHGaHJi8Eb7HMF2vE7D0zBXfdSll2oKLLQVw/o34OHBw==
X-Received: by 2002:a17:903:2f8c:b0:224:1acc:14db with SMTP id
 d9443c01a7336-22780dbb92fmr154361495ad.29.1742752895914; 
 Sun, 23 Mar 2025 11:01:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3977fsm54665455ad.14.2025.03.23.11.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 11:01:35 -0700 (PDT)
Message-ID: <8bb0c545-e614-4864-8c21-40de78334c7b@linaro.org>
Date: Sun, 23 Mar 2025 11:01:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 4/7] tcg: Remove use of TCG_GUEST_DEFAULT_MO
 in tb_gen_code()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321181549.3331-1-philmd@linaro.org>
 <20250321181549.3331-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321181549.3331-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/21/25 11:15, Philippe Mathieu-Daudé wrote:
> Use TCGCPUOps::guest_default_memory_order to set TCGContext::guest_mo.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/translate-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fb9f83dbba3..26442e83776 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -349,7 +349,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
>   #endif
>       tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
> -    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
> +    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
>   
>    restart_translate:
>       trace_translate_block(tb, pc, tb->tc.ptr);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

