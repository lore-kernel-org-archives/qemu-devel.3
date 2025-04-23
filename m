Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C93C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Xba-0000ao-Hz; Wed, 23 Apr 2025 06:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XbS-0000Xf-Oe
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:45:21 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XbP-0006wq-DJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:45:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5f4d0da2d2cso8127330a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745405113; x=1746009913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0IR/47eCkgowldnbNBOrsTJBr5V5cH40pH12vLJJtYk=;
 b=ATL9NgAyo06x3Ctg9qb9DHc20Wx/p38stCQH0oo9rHQioRk/PsRpr/e7MSQeE0daAS
 KqX2NIE0NlF6X2VIh2BaAII3Th6Kx+AePkQh7SVpAjUi2wAzvRHOIFFobuuU0X5mvOUh
 aUnfAPYx51mljv7eN4BUkwAqqGL44LzV8NuUf8AzAEOlFxYDmAqiqpSszvt8og73zFT/
 DLWKC7JvtHQwIa72Y379Ngtp5bnPe5xp8/AJG0Kcms+IcOq9AnADG/J3SIAGoXwXsCDr
 wg3viuNccjI1W6fOaX56JDjY2Jab4C+Mq6/EeP73VUbMaSRr1c1oZSV4e4eJaQnz4zSt
 FaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745405113; x=1746009913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IR/47eCkgowldnbNBOrsTJBr5V5cH40pH12vLJJtYk=;
 b=ijTeaYk6oa0EO65twxq5lPKHdlTzczD+Ve2R/qMiJvxWsSGR6K6hHAtvRUbDw4xS7Z
 FxNdgV9Wdbru7IxpSKZpL1XePTlhGtC1E/SwWh+3SIbA0NLSK/xZZD+WWL+W/q/4pBl/
 n8sixc1dFu9qXQJ1Ipw+ys32SJupo3Pt4MwGWpRn5l5oU9lio9BQwnGqMfOzQv5ZZgAw
 /9tzaGdhb8yOK4oWJDSxbQ4lJfYbfUCWwYKcZ+9WM7C1/t9Fy0d78hInfeF6VDJjorFX
 JD9YNUp/ZqJ85X4VWS0sBBxLxzqnUB9c7icy8P6KXmuU/AXVqCiKpfoWkjYbM/gKpU3Z
 AwOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjWtdN/KoVFGrrRU9jEE1iEmXPlaTPH727uChUr+TCBKOS2zxwXqCqYmZuK78QcwAjy3HITL+k1RhR@nongnu.org
X-Gm-Message-State: AOJu0Yxs3IMbpebynyGubGOXnkMn9PX/9CTAKIL+UBhHe6QnspGAIiLr
 EUVSZc0ScFjeOi+fLnQXh65eBX50SDxGtC22cNHpGAdo88R8PeM15x629LUoNWudELNlQlnrjfc
 9
X-Gm-Gg: ASbGncuRy1OKYrFMi+GMJqtqgtvMMPxh3EN6tPi1nrLBcV2IHZco6FzVMkJW+yAcvg/
 XF8DepQNhf2ic1oQTE7v/ZNUKs1FL7LHyZDMaUKtUWM23umvDwZabqXjmyPO4WG1DHDkLQoKUQ+
 1mUmjYpI6z5EX/P2pVw7/jETxOX5t/e2sTjtDDSaxyxC+vFeM5vposx8zX9R7jgRYUBm4XUjLfT
 dymxsHx1mdXaivt6LkGqZVNTcUd6rWdlhdOKHP9ZabV8OLehbsPX3dTm6xMRyzrayKLhfdZUpUQ
 E8S8XRVMVeE0X4ukcNQGe+uZE6z6wL19+npMgnMLvutCX82DQBdj0uY6Gq4S6QhKencP9p5zxE5
 27YQRQJ8ZMV/KdKgXtSc=
X-Google-Smtp-Source: AGHT+IEMa5iqwbAKnCvqmWZexLqe6wF7lQGZdSPr1mlKO39kWxdDpc2Svn8JdkIGgGB+DsmBezU5dw==
X-Received: by 2002:a05:6402:1ece:b0:5f3:4ac5:9bc0 with SMTP id
 4fb4d7f45d1cf-5f62860f778mr16843982a12.25.1745405113391; 
 Wed, 23 Apr 2025 03:45:13 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f6258340b8sm7281268a12.56.2025.04.23.03.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:45:12 -0700 (PDT)
Message-ID: <fa33278d-e0ce-435d-a064-fdd425eb7b5d@linaro.org>
Date: Wed, 23 Apr 2025 12:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 144/147] accel/tcg: Move mttcg warning to tcg_init_machine
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-145-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-145-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 22/4/25 21:28, Richard Henderson wrote:
> Delay the warning to tcg_init_machine, because we will
> have resolved the CPUClass at that point.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


