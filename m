Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA8BC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ff1-0006Kf-I7; Tue, 22 Apr 2025 11:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Few-0006JR-IN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:35:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Feu-000278-He
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:35:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so2166798f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745336138; x=1745940938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPamGZBnVVlSwRxHN04A7QufkhaZtWsEeN7d3kkLgVI=;
 b=bCMSp1+lP+td/pZy58W6OEzu3Y3qLR6zVG3L5wbRNj/ioYv8p++iGckDMmn58D7+l1
 UebCCGanfxwGuBNDIqjQ9ipRzJmbU5E6QG8QfiFges0j92zYTE++knUj1zwSp9r2ZRD0
 ng820vhBSWO70CTiq7Is1c0Ozx9a2pbUyfY2jKLf41L8GI/whZUTqaefpNCmHBQRMnr7
 nPskSuFuI4Aihz2IRaGsNEP8OMZG9FSkAC7gqgeTVlYt2CV68IO5IBxbioLpdNj8KtkL
 0XSBZbVcjAq1ZvrOcoCsnOO76f+m6qoOpeGEj4OiFqvAdwApODgJ9YuGBHPvOh45rwK6
 U9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745336138; x=1745940938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPamGZBnVVlSwRxHN04A7QufkhaZtWsEeN7d3kkLgVI=;
 b=u6RLvpfaS6P2vzNPgFmclq6BmgulMiX0kpVdpKiX9iTCz82w34eraVwHamzfRVQtmo
 Bjv5BXNTYGwnWSxkv3bDoCWyRKVi5HeFWhbL+r82SP/c+i6ObofHuOxCG2EDrs0vEfjO
 /3bPnaWkHK1xZWJPDCmgPM1/fvu3HRT1Tl+hdie7SQIX/1Es2u7Yu+DqgG39i5GTYkUe
 Dm/olN5XEyti16cbG1DVx6UKpidQiBsAfjx3AJp/flVkM1pKLBu3zAF6ZFI2fthNn7tm
 vprzN+CyFVhCYlhEJSbTiUQk4Rax4JgL19v7zQexF7/0HLY5CwsBHnZlXb7EhIEeXyYh
 1wiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwE4umoVV2Fw9O7yVqWZiRqN2xgdPMxvTFyJDmK0EtKJ6CbjFJHchPMjJHH4JKzuMJBiFaVgRviErB@nongnu.org
X-Gm-Message-State: AOJu0YwZNqfbdoxZ8hIs8eg5jjO49PKrRXrM1hlbpXOdLlTT1vk815BO
 fiTLvSSrQnbL5m4XrFx+BYUBQngrGsdfnOSVJjWYKHW4hZDyOmNylspBiuA04/d+nKh0G+jTbZw
 d
X-Gm-Gg: ASbGncsYMoC+E7PwDbA6RSgvKq6uMp2CRtdwxD08lJ5SVay82p/gqy5XFgcxyb9m80F
 csADO1UvcwGSGngvRF+XJOog6Q9rrR5wkplxmFbX0Jb3ypuDV3IbUeM6fROHo7bpmpLahke1zTz
 NcxPO4LjqFXuGjjr6G9MgnTqTpesZ+auxfVF43/3Pxbr0WQ0Q1AGjGZD/fKyfI3w+qYWF/SDG/0
 g2F8qQXyXst0zhUM9OKbxeEzeoQ5+S/fdcWVkiBcZvegmHSnfsjECgrM1RvfE67shvy1K24D4dZ
 J9FCxTylcZ4vQzBBYUec5e/AkCGr5B7bjy5AHN6u9JtJi214zE5a6olFUIyjGxvkjSvWS0DjMzg
 BDLzwyV6z
X-Google-Smtp-Source: AGHT+IF38F1TVVwqXAOk5+8CX5tVCErxQ15LsadM910jJ75JSPbrQSeNxyLZJiy3j0RYyOi803+m3A==
X-Received: by 2002:a05:6000:4308:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-39efba5aea1mr12873256f8f.27.1745336138365; 
 Tue, 22 Apr 2025 08:35:38 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acd08sm180263315e9.12.2025.04.22.08.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:35:37 -0700 (PDT)
Message-ID: <9d099599-add8-4656-9153-ff071670aade@linaro.org>
Date: Tue, 22 Apr 2025 17:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 075/163] tcg: Remove TCG_TARGET_HAS_negsetcond_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-76-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-76-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 15/4/25 21:23, Richard Henderson wrote:
> All targets now provide negsetcond, so remove the conditional.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/optimize.c                   | 24 +++++++++---------------
>   tcg/tcg-op.c                     | 12 +++---------
>   tcg/tcg.c                        |  6 ++----
>   14 files changed, 14 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


