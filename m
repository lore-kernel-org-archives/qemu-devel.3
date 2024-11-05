Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA5CD2B931
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KWo-0000QE-Jf; Tue, 05 Nov 2024 09:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8KWm-0000Pg-Fw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:27:28 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8KWk-0005Z8-Rs
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:27:28 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso587027a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730816845; x=1731421645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NxZGa884lP/VcAOdkDHINcbjywT8hKv8kHIayA2ySsA=;
 b=uAu7Dv80FXvxSlHsktW8Rpx1kojlAso8gLxDY75vEjBYNBss4E3WGA8l5o3K7IwLVT
 Y5c38QoIqWU+HP0IKlKlBGj7ErXuxpQIj9aB6ABXQFs+b+G2BY47bRh1PyX4N1rmhuB8
 n4N29OvQMnH7akpKwobr48YaDD40I1rdGrBAfyeBhR1dBNClOekxkVqgeZhtBWSwRnRc
 vGZqM4T1iSyAiLiPWNwyZheEFFrWjR9oUvKIvPxeYHJ9XioErmakkNLxW1bB/mEsrOXj
 CDR7fUSPmfEbXbI96UX1iUiR8hPSjAOXqW54X/QbJGJgmGk7Ze/UKkAiPwbqus+aVTg5
 6h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816845; x=1731421645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NxZGa884lP/VcAOdkDHINcbjywT8hKv8kHIayA2ySsA=;
 b=D2a//tK3/82qdUm1B6btb3AOgEtEXXocb3PNyu0pTIdDzlLQ9dvPQKP5+nk4fGoScB
 nsCYUG4CTg3CAFqz1DA88xgfcYP5NYO2WqRg4AAugR8N/RRv26iKqyRyGBNXSbEQUbxo
 E3/B5sPwTncjCyR97N3q53q7NQvRQswStm0qRvGveirV5X9DzaypAQoaYiLaN8i95AKc
 ZFzNRKOhpBgj+TlX7o3LaAHrkOoyqRiNpqUIfUZpT55WBD8lGtjaGRw2qI1SpFrXCcO0
 EI6P6u9ZuIUF6rxNBItZc5C2ch57wQfGxFONpfQoemXVh7cTNN4jevV0ezaaY7jagN67
 0+wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvkP7hjprkVYbgTxGOMYbFmSrvxiU2dSLCxw7gjsL79bV3jaoKfx01tVvOrm7H5PQDoX8FOHvZbo+m@nongnu.org
X-Gm-Message-State: AOJu0YxuPrcSG1/VWWVrPFmuWU2PqXS2nqICGRjvioTOy3oH+1LQPRfA
 XueQ5x+T1NccCsl8D/pLhh4KDnX1gZweliXAiZHD94yrrVIR27WNZTbNp5skbrQ=
X-Google-Smtp-Source: AGHT+IHLt/7OyMIm7uybbqZ2vGxoOnNROSpLMwD2iFXvWf37TXnrvCQOGByq9yyjQRAJoUJ2E777GA==
X-Received: by 2002:aa7:cd6c:0:b0:5ce:c7bf:3bd8 with SMTP id
 4fb4d7f45d1cf-5cec7bf3cb9mr10526990a12.3.1730816844712; 
 Tue, 05 Nov 2024 06:27:24 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6ac1f79sm1349797a12.43.2024.11.05.06.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:27:24 -0800 (PST)
Message-ID: <23534a10-ea21-47ee-b31f-0ce9185e6545@linaro.org>
Date: Tue, 5 Nov 2024 14:27:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] target/loongarch/tcg: Add hardware page table
 walker support
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org
References: <20241010063536.2276871-1-gaosong@loongson.cn>
 <20241010063536.2276871-6-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010063536.2276871-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
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

On 10/10/24 07:35, Song Gao wrote:
> +        base = get_pte_base(env, address);
> +
> +        /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
> +        shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
> +        shift = (shift + 1) * 3;
> +        ptindex = (address >> ptbase) & ((1 << ptwidth) -1);
> +        ptoffset = ptindex << shift;
> +        tmp0 = base | ptoffset;

This is a guest virtual address.

> +      retry:
> +        old_val = ldq_phys(cs->as, tmp0) & TARGET_PHYS_MASK;

Fine.

> +        if (old_val != new_val) {
> +            cur_val = qatomic_cmpxchg((uint64_t *)tmp0, old_val, new_val);

This uses a host address.  The cast, and the resulting reference, are incorrect.

This is why Arm and x86 structure things differently, using a different tlb index to 
resolve the host address.  This allows the result to be cached like any other address 
resolution.

Riscv does something a bit simpler, using address_space_translate to resolve the host address.

Most of the rest of this patch set is going to need review from loongson employees, since 
I've not seen public documentation in english for this feature.

r~

