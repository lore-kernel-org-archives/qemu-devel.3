Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3954C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEwL-0001V5-BK; Mon, 30 Jun 2025 09:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEwH-0001UT-Ol
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:52:54 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEwF-0003LL-GA
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:52:53 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40791b6969bso1391417b6e.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751291569; x=1751896369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uIvDn77Tzyb0ZQ+hf66c/rcWaQxfInDt00kx30yTbM8=;
 b=leJwniJaAkXoh12Uy5yBCwvTxR/OlZ5Do/yIaVsFG8vBw5C7QT94rEWbPxqJBWfqYl
 2aD7p14uCIPlPZNJOnn6Fjp3B4TEqXOyG1RTqWKVQ0npN3S5g+uRffQyz92yis9oUCus
 7Vpjnq52pY74wRRTsa89ecteLk48D0GeE8DXggF+/C9mNSvsBVYyOFny23ipc87rGbaj
 vohL/M5AGqC45zBzy43+D36TiJ2oZkNqGjs526Fc4pSjEBW/e/sd8ggNPGWQrwfHCgBS
 CS/bZ9Hx2M2nxTQNT6VK7v1GHe/WRID3AWvlpxbTlKBUamoHJa67pC/J4kQ2PAMefbEK
 NQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751291569; x=1751896369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIvDn77Tzyb0ZQ+hf66c/rcWaQxfInDt00kx30yTbM8=;
 b=ttHIFW0W9yBd9FSREubjyNwhUzDDJvuCalejsCp98bRHDxvfNrAymHWKnD8jIhtTGb
 3eqU5wrd7qm2tGt/A1S/apYcK77bqgVq3NLgvHyon+7JBpeg9zC1PQ5R+6Ft6x3JMLrE
 LGrijlS5tAtYpPXJLo6dbN7nUsHymsZMoaOulYPeRvfXbrpA2bK4phJRiAtt5xYc8yWB
 4aiyYUFuFtatepsoFCLWchti+3IzSQEgvDA0Vd6LeQHl+lyd5ofNg/M5+DyRV9y0vLZ+
 LJzmMmJCLHsZZ6yKxjUhvmwo05lLeVcWQF15GD1TuebDk5yfjKNF/oMl2KSbippzRt0S
 ovPA==
X-Gm-Message-State: AOJu0YyR57KdKh56Yfewza8ON3UTtmUAg/KWNqpDu9SMzs9g9mJJsvj2
 iv6CssSnJzL9ujoZs0F5iQatjCBauJfxe67EocHZmOnc0SSo8wMP3NYuZashTJppCvNUmCZ0y86
 BEuFF
X-Gm-Gg: ASbGnctsmzFwYAEtLzumwpZPYvARTdGG/0KQFd7jLJLdUzE3iobboADWTaPeh8atoYd
 +9LdX5vfo2So0bk3kzHh13ExSAIDicmc5sODm6gciVuyT72YJ7s70/dK3vRpGzV3AdcF/YlREW0
 BVVDU3E3+ELDd8RESHiOAIpd+nIprqWROBhKW/dmC7rEIbipzbPmRYUOrx5J+c++bxXbeKTya+p
 n/wSPpsLt2475tZ4pqh/a1VpDV2hOqf7w6XVmrj6taXDaU7PnE433PUxotQrlu8TV/LkYkvo8YS
 KeYdhKPp2IuIsLFHCEqASOi8NRennsZHHjVHyPzPRaR4gAb7DtQhvQKkaKwYel3sdt2Ylp6TXrJ
 srHRF+J28AOo=
X-Google-Smtp-Source: AGHT+IHSV9gdfI/ATxOl4x6BizopI5pGvX0fTaKREdRulKkkfQYVMZMzwB+N7ubo0akjz990a7EPUg==
X-Received: by 2002:a05:6808:1688:b0:3f8:4523:2697 with SMTP id
 5614622812f47-40b33e71889mr11176193b6e.37.1751291568909; 
 Mon, 30 Jun 2025 06:52:48 -0700 (PDT)
Received: from [10.25.7.25] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5a35sm2721993fac.2.2025.06.30.06.52.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 06:52:48 -0700 (PDT)
Message-ID: <b72220c6-5735-4051-9462-42b203dadc66@linaro.org>
Date: Mon, 30 Jun 2025 07:52:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/arm: Re-use arm_is_psci_call() in HVF
To: qemu-devel@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250630130937.3487-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 6/30/25 07:09, Philippe Mathieu-Daudé wrote:
> Re-use arm_is_psci_call() instead of open-coding it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

