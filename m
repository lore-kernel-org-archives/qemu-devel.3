Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6765C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 21:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjQ3V-0007Qk-NO; Sat, 15 Feb 2025 16:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjQ3T-0007Qb-7I
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 16:50:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjQ3R-0000ri-NL
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 16:50:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220c665ef4cso48263245ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 13:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739656228; x=1740261028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kRHw9PtO1omIn96iJfuszKx3iDwR+1DAayOzL7u8Mzg=;
 b=nlE4paJfgAhVSwGqOowKW7yNjvOxXadU2YXUdtK84wuDNQgwiR6VE2tNjsj9q09yIy
 fFtF1WUQ3FN8Bnf1gQyitEkRIsiawgUFrQ8/0xiLgvvc7TxL8u4d8c5oA57tw1w2yHJj
 yLIUb3Nfzhfhc+Sdr2Iju1Il64VHLoLxbwt2b8peeOk9cpkmWSwA30qlGpr5E1CDvboP
 EL6gl7oeH2gi3qRjppQIi6RCcMCGohckOdZ5OSYthMng04w2aWcTrBRBemf4J9U8ZDf9
 ihiid8gCh0gAZ6GMuD9UofLm6wRgo41xrNVGL81jUn6ej5Whjm3GP58vgPSTqIP0ok7v
 vDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739656228; x=1740261028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kRHw9PtO1omIn96iJfuszKx3iDwR+1DAayOzL7u8Mzg=;
 b=MDOnkoMnBUeKH19mIW8NgDJJfOrjYPYNhNiYD7/ksirVFoq5EtQYmdkfpyf1O0Z5lq
 GxhYn0QG0UiOfZ1fgfjiVjdxkSecbZAIk7yBf916FZOqmBqVqVwqh0nZkEI06CIXVNXz
 iI16j18JfcNNtB/ueIe61OsSLAFZaQQaeDCzCI2KKapio4RCKjR52bhyhYHdfjR1Gm8w
 p5E3gM4IAUkC9Hz58fvbkenp9MSzNxA8V4mLTfB9oST9oMGZb+JUGNjv63WUsCSJuAig
 B1zAr7KRX43gnWdti6Mc/c7fcf+jJXLjO1MQCQ6oElW2vbLdlMo8Cv76F+8pi7VH+MQO
 99gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGfrnwqeWnmMe2liG4HHQ4LX1Qj8d2B9NdJ2azylVs5cI/Pdm7kzyf18tOGtMaAtb5fCsrjJM5uosv@nongnu.org
X-Gm-Message-State: AOJu0YxdISv+hSYQrMn6xo20U9e14H6h9ACqJVo1Gqg5fy2KN41rEC2V
 qfst9cBXhpoz1oTUEDk6wD7xOuMJTn962V3sS0XFkK3ZwyWtLk43B//lAgNU9x8=
X-Gm-Gg: ASbGnctCkD+pCGC/d7P7l4q8We5QV67mU5CW8Gu6WxhDmM50bqgOuYNEjSvSY3MBC8b
 XUNqJ+Jv27mPmSpgoSpdderdQwV6+J8BqMKpLlzEK4ff4aweDx+CCLV5Lxl3w8TyN3yfsPTN59K
 Zc+emAtXm4MpQGutPA4y6SNbpf/xoaK6fCDz7CZd4GWZDepY8fPjSIATejxkNkVD4EaNphYvxxA
 WgyHOVe00kfOLTGZ9k7YKP4PTDcwM3rXwdOqQLrft1yO0+Y8APDyiSruUywMnT1M3rprxwDzG+c
 cKeuEGJo5huLOCC2i33DbzoFCKDHVQKZW65JJCChZdylswGWVIVzc+Y=
X-Google-Smtp-Source: AGHT+IE9FxZaDEGPrLUL283HCg+EdX/xzGHXLNBjZejVF/26xQPgltd8rSb9qNA/FNXnN1HAPOoOXQ==
X-Received: by 2002:a05:6a20:a128:b0:1ee:1e05:206d with SMTP id
 adf61e73a8af0-1ee8cb7d7fbmr7212583637.21.1739656227782; 
 Sat, 15 Feb 2025 13:50:27 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add540f75f7sm2323263a12.46.2025.02.15.13.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 13:50:27 -0800 (PST)
Message-ID: <38bfbaac-329c-45c8-a672-68cad965201b@linaro.org>
Date: Sat, 15 Feb 2025 13:50:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Michael Clark <michael@anarch128.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
 <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/15/25 12:24, Michael Clark wrote:
>> Why?  varargs generally produces horrible code.
>> The split between alloc and insert was intentional to avoid this.
> 
> it's pretty good code on SysV because it goes via registers except for perhaps new_pool_l8 
> which will spill to stack and get copied unless the inliner can eliminate the copies. 
> maybe windows has bad varargs. but I like the style better than deeper layers of wrapper 
> functions. they should fix the compiler so that it produces better code.

varargs will generally prevent inlining.

Indeed, just a quick look at aarch64 tcg_out_movi shows that without your change, 
new_pool_label, new_pool_data and new_pool_insert are all inlined.  With your change, 
new_pool_data is not inlined, all the argument regs are dumped to the stack, etc.

I don't think this is a good change to make.


r~

