Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789F6CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRst-00015J-Vl; Fri, 22 May 2026 11:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRsV-00012g-89
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:33:37 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRsT-00051E-JH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:33:34 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c80203b9d7bso3346980a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779464011; x=1780068811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDyEPhkW+qEQ9S4J8mXrDjRZyuafJiR73dMD5KSeAZM=;
 b=L16+Z86aNPe2eLvlTfmRi+BFt0noBUU/pUxHhjlwH7ydiw3fwbwsNdoGRxYvQX9Dt0
 VqmqwGRWE3bxoy5u/ak1wllJnzw82J9Rr+mxxS3kMdiUNDW3McL78L49AJJnFXR4bOCj
 h5lDS+9iCtEJ9QcbFY7rvL+KD8dTyf62c/RSTc/Tp1O/NpIL0xfGjWEb8eN7Scf9Ggaz
 eTwic1y5kSaoi5izThRA3mUnWB1BtpDZNOGp+37epwDLKwwMH0H0etDvasA+C8pM9op/
 n5uukrSpGV73KyM/2vAZt3l0E0pSDjmFRX2QAB88UJLgeUTr8HwgWCri6qXAQtDc9/qd
 VQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464011; x=1780068811;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDyEPhkW+qEQ9S4J8mXrDjRZyuafJiR73dMD5KSeAZM=;
 b=HeI60oLgpkOZO2K4+UHzMLoxTQYyKvjOb3IJ9UIz4/+wc6b+SO7L5dH6EuM6S1tpQh
 t4OJ5R7/T9IBSKkuVDPOw9XhzbsYWem4XMzL8KxN1uaBAsE0IYPZO1giU/llou9JWnHs
 vriqDLUThYbjKQPx4AF0W8j0+TOWSB6/D5iPesrTcqySpKgYaINWwrZ8B9PAJCNz9QbI
 gjU3OUwyuZwPbQytjNdMDcvq8X9MO92lJ4gnw1DP8DtzFCgCpfikvVMZ3RZI62T2v+gZ
 4xGOaTyDoBhbH3yyWGDftAwF+nqzsdOLKnsPxwpHGDDlpTy8RqZUDFXAmDs0Dvh8keQD
 SV8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WjTnoppPHnrxqIm2rueqjGqZOz8ZCYjQNRgSKhYXeKHAHHjwpvAnSE/YGcMY+zBaOn45wsSSBumRq@nongnu.org
X-Gm-Message-State: AOJu0Yz2CZ7szZ9oTl0SLj58rOGPHvEVc0KBpRgm05ZpU6YBaVS9Bjcq
 NgnMsPPbjcW6WelPLuXXDT+sBR62etlx51T2kLbGl5slZzX1dbKKY7Fsnbia8KPmuTw=
X-Gm-Gg: Acq92OEY1N560tHs+5IlI5fZsrsOeEhOw/n+3WPJP2W6JKuA4rA55U6whvuNFtTg0td
 rKbI+ghFQFl9RnL7bBo73RdQLnLfWjeyD07aJyhpFm9tLGPf2DVkotHyLJk2P9xqU3fCY63eUsv
 lgpOH6+eJqX0XTke1FPRzTt/PJtp4OePXx9N+ogFiDFw7//7Oz1InX5FHVC8lTf3femMHSl49yW
 Td+VpEfNBzHTWkViozlWAtvXSvv/3NuAv31lIbYegqZyN6VfbrOLkchpo3SAmfvZWqF+rv7Tbnn
 gj6ufGnZdwLlE52rcaFW2IOnar0bT1DZweLPw8KE0J0KhxL8VlCBbIxyOEn0tnAou5xrBOr8b4F
 HO3U363OeADtbugjPU+L6fK6sFbMYxqmVjdsdosGbvEeqwKGE5x9wsvQcm5zNnSD2Z3h+8fC989
 miPqFAeqS9aflA770ulJydWHCz8HpHaMi9rfdwBHA8l6wQnK99e9g=
X-Received: by 2002:a17:902:ebc2:b0:2ae:6259:5aff with SMTP id
 d9443c01a7336-2beb031adfdmr42103835ad.6.1779464011329; 
 Fri, 22 May 2026 08:33:31 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2ebcsm21093545ad.49.2026.05.22.08.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:33:30 -0700 (PDT)
Message-ID: <12907495-84d8-4540-be9d-61921f188845@linaro.org>
Date: Fri, 22 May 2026 08:33:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/22] target/mips: decode Octeon COP2 register
 selectors
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-15-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-15-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 5/21/26 22:19, James Hilliard wrote:
> Add explicit decodetree entries and translator bindings for Octeon
> DMFC2/DMTC2 selectors that are simple COP2 register transfers.
> 
> Emit direct TCG loads and stores for register moves. Use signed 32-bit
> loads for 32-bit DMFC2 readback and mask narrow writable fields such as
> AESKEYLEN and CRCLEN on DMTC2.
> 
> Keep operation selectors with side effects in later functional decode
> patches.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v13 -> v14:
>    - Add missing HSH DAT readback selectors.
>    - Implement HSH DAT/IV selector transfers as paired low-32 architectural
>      word moves using tcg_gen_concat32_i64().
>    - Move the CP2_Undef fallback into this selector patch.
>    - Remove the redundant AES RESINP translator path.
>    - Add HSH DAT readback smoke coverage.
> 
> Changes v10 -> v13:
>    - Keep simple register moves in their own selector patch.
>    - Use final KAS result naming and final CRC register selector names.
>    - Mask AESKEYLEN and CRCLEN direct writes.
> ---
>   target/mips/tcg/octeon.decode                 |  80 ++++++++++
>   target/mips/tcg/octeon_translate.c            | 210 ++++++++++++++++++++++++++
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c |  89 +++++++++++
>   3 files changed, 379 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

