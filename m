Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B57C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Olm-0005D0-6L; Fri, 25 Apr 2025 15:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Oli-000585-0F
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:31:27 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Olg-0005yf-DU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:31:25 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af9a6b3da82so1815670a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745609482; x=1746214282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ytGJ8GJi0ChUKD+Ma5+D/p3oHqSvu+zgiR8YH9VhzJc=;
 b=Ybm6/TyU0h+ZKUwL+fqieRogSf/mJ9Q8AnT5KDi4cjpaZJQNcEM7xOOacx8COtiGyq
 xlDK5LbghBuvkmZ80VNoyU0shhf1DYgHE0FoYK/Sw4N5LDjLT2sI8yRxHM776ghSkpRo
 1/iLa4187IQu6zb1gcIwRb9NqS/quZtdzRX+/1FmcAoEVYWv63pj2MQZVWTgvkRUOAO3
 f3oLMRAMRI93KwolcYd8HQ8mNj8IlxGCEyjhS1cD5Czzyd1lGxH3O43uVkmoLjHXWPDd
 10F3jPQsYDq1W1RatoecZvxfmIfbjQ45xpE0+p47tGjG+8nk8tsoRoBDwec/dpn2cuR1
 AyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745609482; x=1746214282;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytGJ8GJi0ChUKD+Ma5+D/p3oHqSvu+zgiR8YH9VhzJc=;
 b=Rk2Bnek6M+HRWlUl1XHUwkBBD+g+05gXOCobELAFboB5Z/wr+Y2WwI4rn4KazD7FBT
 cTLPTXgTJximzYFjZeHfTXc2Jl8lOh51JImIsnn4DhlOMq9mzrZKUsqDBa6EgZkznIEx
 Jf8/4RbfnoLZAuPso5mUutq3hCpnsjzWY6Z2TmycMLdRFfgh+cC9fK+wzmrgi10ebQYd
 y5ypAffcHePR13qVLPFJFP/a0Zn3LL0FSwmRQp8x4ZqESIzQ5l9MdCM86tbYnUHXbZEs
 bRphSefIDmGCwBrJaAFQSHZ7lDwYLkTcKEiwwt2Sojew4//sVAsXTDKe47F7Il7tRTnX
 PICg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/k8FeMuWyC6FaYNKlSG9wm/dFEs5ddNvFELAmm8/QoMuZck0kzIBRyrvdLrfxvgGnb8d3A2iA0VXj@nongnu.org
X-Gm-Message-State: AOJu0YznpwG5/uhF3Fo2aiGNv25+7HqJrfkelL1Zi1VetRKeUwsXV8n6
 oZKbzuS0MjQQp25FqzmTjCuWDImVm5e8bcsTbQaYrJAJ/B5c2H1DgKYo3ePqscg=
X-Gm-Gg: ASbGncsOUVqM76tq5fUAu1oGQQ/NCN4WHQ+aSkYeaFT3n/Z+s9hcVkHTrd7nnw59Bak
 nSnfkevk4X6a3/UBDtNsTOXCMVD48hmZBhT3aHkAK7jQSH8+zxkXf4OxYockXMO4gZ9yJtvVug/
 suBEP6jRoc2VVt4YRZFvbzluukgTYrItGk+NX7Bgds9nQbsKPOcjmj3J4FPmhxKqoWSjVjzFLj4
 f29au/E2JRwvQGgWp0bi1PRO/4NzUtaFu0qYUsNCs/Z1rxprhKjwzJP0Pm3LqzaS+YM88A6M+lr
 PWgn3cBr63nGs0W+9lDnQjzpZb4iTknpzE0LjxiFL+qIvsMkL3c9ZA==
X-Google-Smtp-Source: AGHT+IEI09CMfSUI1HuutfJgV/FBXumsTDnOf8vCl+j8BsZjDvhrHB+YHrQv4XOsd5MYW+7DE2VJZA==
X-Received: by 2002:a17:90b:58ce:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-309f7dfdf42mr4789238a91.20.1745609482445; 
 Fri, 25 Apr 2025 12:31:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef097e0csm3900401a91.25.2025.04.25.12.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:31:22 -0700 (PDT)
Message-ID: <f16c70cf-78e0-44e9-a4db-1e6e027770e1@linaro.org>
Date: Fri, 25 Apr 2025 12:31:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_page_range__locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


