Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F90C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNag-0006K3-6a; Fri, 24 Jan 2025 12:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNad-0006H0-UB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:35:32 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNab-0001VA-Fn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:35:31 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e5c74cb7so197761485a.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737740128; x=1738344928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AMV+qxzvpWkMNhHrkYE0PGfCQKHhVFb9yy79ND4wiAs=;
 b=ZOkkwgOc1ZgtGSzzRnR930ObNXtjo2+PHpRAvnL/LFUw/VTW+il7Bz/gZMKGfSV/gF
 vlZSxqmpBfDcTnOYlo9onJbmUsdOntJAT/ebslNg0bCA9xHyczaoZL0m1T3Cmjsv7n6O
 7ja0svIejZcW11QvG98jHByVGMOkrshRvjRqYJcaD5Lqy6v5nI5wXhce/nMbV/eiqNfr
 gwY95A/ngXSx2G8QidVzB+hlkkwyNvE7kReqqrIf68of933zknb/045dUL7sjdhgf1/M
 PEROUzDfyh321/m+13YwQg4/TnoG107YcDgJu0IwgRv2xiaWrUzCSl7EDpVNzbSrottH
 NnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737740128; x=1738344928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AMV+qxzvpWkMNhHrkYE0PGfCQKHhVFb9yy79ND4wiAs=;
 b=wmGya1VKCD/IZRfEibRrOTL3O2njyLbWd4ZHd9o9inJdDF5avpD5ogMwiFIPX3nn0v
 H3h6weYMVH5Ju8qIK2sh6j7pPHyqiMVjUbUbjEwaVP9mx44mmSANRLiWqZYcs1qUlrIf
 Woe2eo5qohQMSPHbgqwdu5VbYKrjCSWamzaJ46jVOTvSiQubWTESmELCKWwzkNvdgCmX
 wVDeW+Scu/eU4+gardHbzc42oWuKQdNz9ezAZeiNuQp76O28o6knBzrCP8Z9wylsxC/F
 HtqeMYYMjqfmLvttUrBe2PG2kvT5Pkz+2HfFV7AoI5T/T3FOrFf7U5ugSKxZXsDU6LGz
 sVQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEY4QP4d1GswannmowFnhn/w7WFq56xFNZTF6A5+9+uootR8R6VlaXyC1RQOODiEFNRL72bT9wQP7L@nongnu.org
X-Gm-Message-State: AOJu0YyTNnrEkuLDYvG8Zmlr61e3eB/IQY8NwOChpCqVhusAFzgHYvP6
 Y3QuD5lq5xKV818I2fDWALROVkBUpTqn7hlwhY7XcZwAE1QQPDIHWzYXXsF3z6Y=
X-Gm-Gg: ASbGncu9xf/7KR9mBo0lxfBbPkcgAmyUcUs/TGVCAFj5mrFIlicJFEIz7rNkovN8TiN
 RuOqeLlIZlVFy5jXjvvaD9sEtvsrPiHWyUR9fluDJWVUN9FfnrBuGITSSO8wYVP6XpXCiqUraLC
 X5NzsSQyieWLVspkU4pUbTox2wbnQ+eJZ7u6loSvv+SPC12YEYcR+vT/cnP+NvL969ihFPPl0LQ
 RvaEnWNc6vGszgoeDm6I3C7fx7sEoAjSGibmTI5WxO29fFI9TrxdqXFIT1medjydGAnoG+3PP6h
 ddtEWyZM08EGdx8025cXAHMI2oIpxTOawXNq/ncEwNClTSIY7BNNHlw9qLKn5HSncw==
X-Google-Smtp-Source: AGHT+IFqT2uj9wwWRu5cFAOT4OajMSZyAfttDtfHz3yV6UsbaJ/kYc4lOumCvgdjutXyJ54T76XZSQ==
X-Received: by 2002:a05:620a:4151:b0:7b6:d050:720f with SMTP id
 af79cd13be357-7be6321c277mr4448304985a.22.1737740128327; 
 Fri, 24 Jan 2025 09:35:28 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af109c7sm113780885a.111.2025.01.24.09.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:35:27 -0800 (PST)
Message-ID: <822bca3a-600f-4a08-98bc-07a11a5e32c2@linaro.org>
Date: Fri, 24 Jan 2025 09:35:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/28] target/sh4: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sh4/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

