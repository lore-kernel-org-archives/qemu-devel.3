Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E238F5A8C5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEvnm-0000Lh-Nd; Mon, 20 Apr 2026 17:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEvng-0000LO-Sa
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:05:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEvnf-00038u-GS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:05:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so19417115ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776719096; x=1777323896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ic5XHddauHAa376rmqpwdyzZlEOjFWEkZiiE/zcY2mY=;
 b=QkcLUD0XMJWtlDEEBWA75N6FOLqKhbNCTGdqrWr/KtlaHX5tpqN9BQi4kI5LeNCLKA
 yt2JbKmSVu8HmrbghX9bu09lFMT5BchX6WIKOYi93BMfPlmCR4WuKJKiYYeHGnc5Vjvv
 +CBYv5UxguxH/8GVNi2u8TIFH+NjKzfKogrUNORruUhoPZyGLRLBLH2yDcK3u2M3Zykt
 ij7LVMd7tZUBSqqBqFzKdhKjeZQ4GNJeFVcGjBd9Enk9L7Hsjj/EhDXenMGXh6EKtIUi
 amNEolUSUj0j2A0l0ZbwIYZqZEVCf3kWEa+vVgeM7J5BJsSsphO+Uafck4xh0hs0VMVN
 +NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776719096; x=1777323896;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ic5XHddauHAa376rmqpwdyzZlEOjFWEkZiiE/zcY2mY=;
 b=FouevM95C6hjTkfLLW2hf59G9sXx75ePh+wBF6uFHyuypyrQLbC5lf1Tv5RNbiBtFQ
 XviPX2TkeLJs5T9EzWXvV7AbySdfl7ajF2xUqxWczZ4vzZILOLqyJj5lcCjBe5F4m2Ww
 ENzIR4aK+UTPDWXuv4NnV+jNPmFAJ72GBjOmoCDSJoIQlPjDAV3UpciFLJKbQ+NAAs7x
 MRyK4TPL39Ecx+Q0dtlvJH3jTilyqS64uH1bBelj9Hsf8o+TqyKLlCvobnssl0FLtg0C
 HutqPdLR1P3K160GvyeV/91SQKew9MpADojSIsZI5aboVWh9MkoNjXquu4LDcefntFlX
 LEkg==
X-Gm-Message-State: AOJu0Yy8EBA14byFFD8rxS3V6f0aKlRwnEaQfZpCw+dFZsQK2JdvpUDT
 lRixx/6fRwuUGXSch0c8FAlEjsHn2x5xTNi2ic1CzRx+IAW5SoCswWrGWp1Q3NLQUD6ACg5Ozaf
 W6ZHLOEk=
X-Gm-Gg: AeBDiesKfsjmBAEnjOWHVHIbzA9jop+jifiZpCtsX9Ai8g54bHEDnWR1IfMO+n5Y8+2
 x3T0+SyUCWncsSxDr8fJGRfCJkOtq19zctc06d5HvVoyo43AbBXx7C3F09bYUtjeaWyksAGMzhL
 4zf31s+nMTJYknHzFglQx/LdxjpNAzf8hVFy1gHU8JUQBJOFuDs7Wb4B5iz1+5MUtUEWyMSGwF0
 yN9oGomaX0Rluz3JOpOfDt/f9MWAukid+L5T63DTWoDzqlczz8brGdO+J6lOubRQfMcs2syZOJ8
 I2qjmtAb/UVN10sF2fjVCAxY4bVPEHfcXjCR/MMNE+7DBXyrypGWp4+5pf32/+/tnJyL4sarp3X
 CFFYP4H6+NC6E83k4lqwFqLtj18wFAnJyGurcOlMs/R9E5JdIr0ZPGm9qlQZgvQmo6iM6+1dVBY
 1oEh5m/JMD+4bZA9mVWmAeUjGiovWvptFcmsH2LaLZcgdq+BnJowlh
X-Received: by 2002:a17:903:1ae7:b0:2ae:ba5f:3ac3 with SMTP id
 d9443c01a7336-2b5f9e77afamr150502055ad.2.1776719095492; 
 Mon, 20 Apr 2026 14:04:55 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa16e72sm112955445ad.19.2026.04.20.14.04.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 14:04:55 -0700 (PDT)
Message-ID: <0b737192-2b95-4c74-a3cd-736e6c4b8405@linaro.org>
Date: Tue, 21 Apr 2026 07:04:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/mips: add Octeon COP2 crypto core support
To: qemu-devel@nongnu.org
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-4-james.hilliard1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260411070637.72421-4-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/11/26 17:06, James Hilliard wrote:
> +static uint64_t octeon_gfm_mul64x(uint64_t v, uint8_t c)
> +{
> +    if (v & 0x8000000000000000ULL) {
> +        return (v << 1) ^ c;
> +    }
> +    return v << 1;
> +}
> +
> +static uint64_t octeon_gfm_mul64(uint64_t v, uint64_t p, uint8_t c)
> +{
> +    uint64_t result = 0;
> +    int i;
> +
> +    for (i = 0; i < 64; i++) {
> +        if ((p >> i) & 1) {
> +            result ^= v;
> +        }
> +        v = octeon_gfm_mul64x(v, c);
> +    }
> +
> +    return result;
> +}

See include/crypto/clmul.h.


r~

