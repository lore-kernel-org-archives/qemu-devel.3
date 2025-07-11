Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71760C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAsF-0000cD-SP; Fri, 11 Jul 2025 06:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAsE-0000XM-FP
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:20:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAsC-0002XF-Gh
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:20:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so1687217f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752229253; x=1752834053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSVUXWCMuhFRONHseCY0/oaDPq6vBhrOMPsJnjzGER8=;
 b=agKF9E1cXWQNA9KsXFg2piJ2SQwzIQ1Nmgb+aFHdVgekaZCgiSkpqQXTZlJPBWb7tH
 75onzSrPURqrqS5wcifJbcsV6jIaX7OKdipdErlao0Oo8zRfF/pPhIgwQCJWlNoxLxaT
 2y4lk1bdwH8eYL38T+JWqNLaz85KuibyIoWNQ39de3QUYcAfx+Bzz5h4IahythDpjz+B
 s81XJTYaZOrSOuQxdJnmFzeAe5pREuvxvYmdyOf28qvvqISnjzjn2eLFtY4tIi7HcV5Q
 NluIonCKQ3l3D5WR7jxJM/VLVzDGlLXLDTTgXIm9eamF2UAs0l95WZBENF3d1Kyu4YeK
 dbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752229253; x=1752834053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSVUXWCMuhFRONHseCY0/oaDPq6vBhrOMPsJnjzGER8=;
 b=NKIBZlDMI9hgMPG0tFqe8zwxJefYRDuiatUC/m+yrWQG8GHQF0E9O1IZ9E5nZEN9Yz
 0KAUbxX6BeYpwlizxzNfoCrt7jnUxyxBavrFMtKwQyLL2Fz+ePz4lOycFBiWbxNWnFOn
 i5aseIa8cUTLxXUTY8z+6oSVi16ybxuUGPPZtsUM3Gies5s5LvqBcAulkP6laP+PFNMc
 hg3nwpCcajzznW3rVgmcnGZ8vI6g6PhvwsfrNhYoZJbo1zWUe9jI7VOd6ej/vglOfqtW
 WWnL0JFNeFqkO7nrIcENg9vcxh7cvWdPrvX3f35l0x1siH4BDCgGqt+zkwUgOtr+5Ez8
 wsiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf1tETU9D0fbds9+OhTmoHEVDmaFoiVqT9XZYaubrbReCQmKLEPn9fFGnMgPSH16xwprTqLKfbp7Bn@nongnu.org
X-Gm-Message-State: AOJu0YzYbOf5tHEkupVpySK4Uc/t7QOABe+55eNY477CB7gyq/EGA5PB
 XJy2J4SCSf+FDHJGMZJTKBtDQlUmY4PIhqxtj2HGhvT1Iy90xnjJ1F4XcpRElkyIjrM=
X-Gm-Gg: ASbGncss0Y5HVLwRewt108ubRqRkCx2nnKHAaYCSwgR2LM9Djmm0FBYtHTEwPfNZoFb
 jz6IcNSa9rtXJGlFvWa6AkMg0iNftRkSRs69w6mAs0N1BxBCZDg6tdDqgsOZARvMmlA9NLhitUR
 CfAFsHTLO3FPT41PRWHkOSSPFZ20HgCMKwMfsSclAxw41qxLB9u8XxE3EcZS5TX74cOM/WPzQBI
 4kENIFPxmATIKiCWiBzM/pV0yNSPQvI6re6EAsd8wiocSedHoVxVS2X+wPYW9PbxEbdQcUD+3Fp
 e8Hr0cKhDWnu02CdeBK5SA3UeTYGY/thNP2nygARimCTQDo3cDJlSA4wW0crQcdTzGNpK6bbc6g
 eddWTmENwU2pyeWHWru2CL4xTfaosqLIbIKje6sjY5Sot+NjiwTzHDVqFO+69CrH3vghm7w==
X-Google-Smtp-Source: AGHT+IF3T6EV+dqXBNMiEfb970Kd0s86j/WV2DYWLNMw09wsGy2cBKH8ijB0LTBYlS39luf9PtvwaQ==
X-Received: by 2002:a05:6000:65b:b0:3b5:e6c0:5cb2 with SMTP id
 ffacd0b85a97d-3b5f1893c01mr2545730f8f.25.1752229253240; 
 Fri, 11 Jul 2025 03:20:53 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5062119sm84323975e9.18.2025.07.11.03.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:20:52 -0700 (PDT)
Message-ID: <305a41f5-6955-495e-a0ac-988f19f98067@linaro.org>
Date: Fri, 11 Jul 2025 12:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Use uintptr_t in tcg_malloc implementation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250710225053.168169-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710225053.168169-1-richard.henderson@linaro.org>
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

On 11/7/25 00:50, Richard Henderson wrote:
> Avoid ubsan failure with clang-20,
>    tcg.h:715:19: runtime error: applying non-zero offset 64 to null pointer
> by not using pointers.
> 
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Supercedes: 20250618183759.9197-1-iii@linux.ibm.com
> ("[PATCH v2] tcg: Remove NULL arithmetic in tcg_malloc()")
> 
> Ilya, I think I prefer this solution to &dummy_pool.
> What do you think?
> 
> 
> r~
> 
> ---
>   include/tcg/tcg.h | 6 +++---
>   tcg/tcg.c         | 9 +++++----
>   2 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


