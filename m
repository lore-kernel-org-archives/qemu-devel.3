Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D7C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 23:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfQmh-0000bD-Nw; Thu, 02 Jul 2026 19:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfQmg-0000as-8H
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 19:25:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfQme-0004Ms-LU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 19:25:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8478fe07f0fso2333166b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783034726; x=1783639526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nBkoEvza1HQ/2+412lCgtgc4jsLhGjj4zlg0TwJAHOY=;
 b=UbXjc93z6vb3MsEb2AIJ2FDplmnEm6qysVbE3++Ai0ojaI3OgNYOsQlMnTPr4ecn/t
 66ihHl+9d9jifl68KnrZzOdRR0oW+yJC60qjDG5YC9KZYw1cvZM9e9C/cnfc+gVMY0f9
 SFRmmJyKgqQw91gIC5C2NBrg6JY/4Ih77NA9KqZ5lLI0nndHqN+SbUW5X+tUPatoidiU
 s2S28XzNMPMGhBRK/iKpFyQX3npq2Z9fO0WNB9CQmM906j4Y+LZCSW/Dq1BnXpjtnjFD
 wlZVMF+57yjyLGaP44kIFQqf6TxOtvxnsjNHFN/HVJqu+XSJp2Tbz67/6RIy11fX/qih
 n1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783034726; x=1783639526;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nBkoEvza1HQ/2+412lCgtgc4jsLhGjj4zlg0TwJAHOY=;
 b=oWYch5VX/uJSBch7ISkX5GNLSum2Ck9IgL04rver0EZRru162JiEfaU9WkOlZiQpkb
 Eqhwg32+2h3WWo47F5XMaoj72SCUZhNeWcZblu8ug/wqu3GJAeI3ZsLCs419zua2ktCg
 7EiumK7EPS+HqZzoshVwYAgNXf+5dHBgOyrbOn1XNbvLYjzxVcKzPT5gkG8HXQMetR1A
 ZqBMbkzUyLMPmXGQSPss9c+OiPXhC4eHRrWDMbqbGJjiI4p/P+aVRDhuxGMyn9xh5smQ
 FNaQZvetrLC1ropdxATGOD9YGfHzkUvQT2HtssN4PhnQWNJvncbd5x4/ujAtP+dqCeIS
 p7eQ==
X-Gm-Message-State: AOJu0Yxc5tS1fdgKcl9czpJYbQ/2ISrgUbO6+ChaBEfh9VUqfsljDBHw
 KqWslQXcwYF3kuEhg30BI3L5THvwlbRfN979g76eZ5wJWPKpNzXh1pNgsUYGUN/335f02r8zw1M
 Pf03p
X-Gm-Gg: AfdE7ckp5Rfj4wbfIW2k7dQ/Pal/d5nkPlJemMDtis5Nvg+g32IzZcemp33xmmeOXk2
 vUu7UW/f5G+1UfZtJDK9QuHzt9vKUkJ1rQ+pxgFIkJAwGXRaHuC+g+poJNkznaiVwO2htOYRFat
 6+YYbsgO/wvkKpk460ei460kF+kRpdQnEQ350spZchOZpALpM1QGldGC+trYK43EBdXt9qUomZs
 SVjkyJhTodHKek38HTSlSIyxQhB0dcOrMkl0ZhVHYrKj8FEADgu1jOUy6WahJib73DyZ8eVl2kT
 Ovbt6CPYTpYqUyg7Nang7CsTl+vyyksttcme9e2S7OZ++Pn5jNl2AXnjIJjydgqHZULouDV4kww
 pZUrk1+BqVEQ7gCTzWQ1xoQ12gh5IpzR7AgjfXuBTWhg2HE3gJkxzEd6Oa3yjXMkiR5AoW1X4Xm
 a835nO4ZIMEIdM+l1u6QrhVKfci9Q5vxDMlgFphSGbuOm2HBsV1sSCDct+1Q==
X-Received: by 2002:a05:6a20:9185:b0:3bf:a0e5:99a5 with SMTP id
 adf61e73a8af0-3bfed588b28mr9012899637.47.1783034725967; 
 Thu, 02 Jul 2026 16:25:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921d28d9sm1750834a12.24.2026.07.02.16.25.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 16:25:25 -0700 (PDT)
Message-ID: <ff7fda84-8c74-4d1c-8fc2-cf556f2d5710@linaro.org>
Date: Thu, 2 Jul 2026 16:25:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] target/arm: Pull VFP "can we use D16-D31" checks
 out into a function
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> Currently we directly call dc_isar_feature(aa32_simd_r32, s) for VFP
> insns that use D16-D31 to see if they should UNDEF.  For some v7A
> CPUs (Cortex-A7, Cortex-A9) there is also a CPACR.D32DIS trap bit
> that will make VFP (and only VFP, not Neon) insns using D16-D31
> UNDEF.
> 
> Pull out a function vfp_d16_d31_ok() that currently just does the
> feature check but which will provide us a place where we can make
> this check.  Since D32DIS takes precedence over traps to EL2 and EL3
> and simply makes the insns UNDEF, we are OK to do this early rather
> than having to wait until vfp_access_check().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-vfp.c | 61 ++++++++++++++++++++--------------
>   1 file changed, 36 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

