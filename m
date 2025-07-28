Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B432C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 05:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGCX-0006QF-QX; Mon, 28 Jul 2025 01:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugG7N-0000Ks-Nn
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:09:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugG7J-0006Vs-2E
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:09:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-74b56b1d301so2607818b3a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 22:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753679379; x=1754284179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aH6A2kTeYPvKdTkIYNNw9CSsZNO6eEDLWYB7qWhai7w=;
 b=rCB43CqscbdQVGWCn25T0ChwlqS6SwM5MWzeFnlyAAasHdf+KdcbP1vC+gJEUWO9cr
 ingY/SDa30Gf5oSbOJAFQQOLd7BecFbR10WVHLXnjYuvYSrwdcGQC6q2Yx+l9jGAZ93I
 GbLtSLCI8PKgXtcq2cXJJ1885HvER1XIjGFA+HhOd/Yn7aIOnEbFwaaCZweKXzUViXaT
 lQRrTwg7QzDXKUWRZe3VlFvfqEs6kxXox044O5JMqbibzwAQuhgwi0GltrQfpxfGi/4u
 ioxzvaQOQK94fsjR8GrH8K6PswZu/S8ULv49AKJpqDzyP3ZT4ianBd4BL2m0LUsMM7Ju
 4jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753679379; x=1754284179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aH6A2kTeYPvKdTkIYNNw9CSsZNO6eEDLWYB7qWhai7w=;
 b=IPsLaPhiGOjGF1Z0NmPdcr92uIRrt3y9YwpLmUZAXsxzpA1SavYkZBUiRHIk6lFTkq
 6h+qufZN6dUyPjabgow/vsGCGnjSR42/5yAor3IlWw1R+NpeESH8lhJoaiYvRP9n7dYQ
 Ze3F910X1IhLMtWrQrX2pQ63SFGkRL2OIBq3UW6d18uQPhldHPV281jTQbYs7Ibms5Sb
 AhR/tbcDJ0Ha9Cke4nW6XpWd9faaNa4YeAVPB1Kez6FJNMH8AZRw42i0Tt2AOr6K+zAM
 esfJtnK4adq08G0zr+YNgl+l1vMqXgWCxOVy63r++Wixib6LSGAWn4C9u9HKoz69mGOJ
 hCeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUj/Yl9qprvV8Y75xk0GnkutcVdZGvlI8J9zxM9bo3v4f42wPoUrPiigjRvgtsYsBf6NBg8r+ImOuH@nongnu.org
X-Gm-Message-State: AOJu0Yy6LjOzwf/El2SFONX8g/AOj+yJKrQxo7Zc0nY9+VauwSR6TwSM
 IIY07KLmIp+/nefO+nUI6FpPOVeXscFJ5WUo/AivoLkiSAB8fqzFgCtyier7MgKzSJ8=
X-Gm-Gg: ASbGncvVC6T1/hg2LruVFegMA0+/arukWZ3o4CiStE7afcpvX6BlBgg4X5UG0mAR/na
 X/in0XMKgSn7ZDNcE3lft2J1cA7ZAVt/uBP+CSUj+x6Q4A3XAPklmqDqce5DercKS1CTNddgccq
 YxHHcud8zhvYsHraAs4CLQM6NMZDeIW/LN039Xq4TEz2Vtc0oIZifW6M9OasUJu0+tWyKjc4Z7K
 npAKaxJ+wOe1unn6OP7OtEFMu9BC6FPXb73Q7MZqzGBUGS1QrGnODXxn9AV22AM7gURLipq9cCI
 z7grNe/l639Ht2IAENeZamod3dOXirWg5w5cq4GyM2rY1dbF+IYsIGAI9PWH9pFY4+GFQh12kZU
 aVZYrcVkAbpHfJ6rtiIiHyO/cJnxMWADmcNmAxy8frRoyHJLtxPw0wpG+csiKSKkp3X3m80TQE4
 GB2mIPILKtzWGf
X-Google-Smtp-Source: AGHT+IH2fnVxJ/qWeSxd4JzYlaePI3dtAfHjavK+vBJkqOEyZ1EDW954IUjiS8dCd5vk6P4pRdy5mw==
X-Received: by 2002:a05:6a00:2d83:b0:742:a02e:dd8d with SMTP id
 d2e1a72fcca58-763348bbde2mr14728537b3a.20.1753679379076; 
 Sun, 27 Jul 2025 22:09:39 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76419d84234sm4431864b3a.57.2025.07.27.22.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jul 2025 22:09:38 -0700 (PDT)
Message-ID: <7e06bf78-e9a5-47da-b0d6-7b1af5b20a10@linaro.org>
Date: Sun, 27 Jul 2025 19:09:35 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/17] target/loongarch: Use correct address when flush
 tlb
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-14-maobibo@loongson.cn>
 <c75d79ab-97b8-464b-9774-a51de03a8e31@linaro.org>
 <b6d7747c-c37c-206e-6f44-535e5410ec14@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b6d7747c-c37c-206e-6f44-535e5410ec14@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/27/25 17:22, Bibo Mao wrote:
>>> +static inline target_ulong __vaddr(target_ulong addr)
>>> +{
>>> +    target_ulong high;
>>> +
>>> +    high = -(addr >> (TARGET_VIRT_ADDR_SPACE_BITS - 1));
>>> +    return addr + (high << TARGET_VIRT_ADDR_SPACE_BITS);
>>> +}
>>
>> Don't use __ symbols.
>> Also, this function is
>>
>>      sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS - 1)
> yeap, sextract64 is simpler and effective. How about loongarch_vppn_to_vaddr compared with 
> __vaddr about function name?

There was one use of __vaddr in this patch.  Do you need a separate helper function at 
all?  Just use sextract64 directly within invalidate_tlb_entry.


r~

