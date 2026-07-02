Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C2CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOOQ-0006gQ-ND; Thu, 02 Jul 2026 16:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOOO-0006g8-L5
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:52:16 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOON-0003cp-4B
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:52:16 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-847d1e9db22so1171849b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025533; x=1783630333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4igSEQbRRqFAd+2qC3yhmAju0E5nj3Rur/oE06rG7WQ=;
 b=aYcwFXnaAd77Di0f0Fy4y3tHQu3pKuU2kxzYabUD+rGi3KQkHxfzy+PHZnsTKATDsu
 2R7jz3YrQccx3//SAl3MDKzct9tMKfdEtCQUkLB1OZsLmSiCagHQ+/r80Vx0kB3+UJ5h
 mdGgCyo+oEqONKeRUIjk6dXBk4Fb1IjMWlnxx6K/UBhIpHuXQN5Mqtbl+ABQvELTaQjK
 a+V/9a1abgk4QYyvLGqW0vQNGkHyNXQRe0HxKyx5OeQATHcCXQWjsHI+y1Lwnjn1M5zU
 YxR5TdJcKF62bUP9wRFU/QM3q0GxHHldzeupBZ+CRS4bnCRZfModYtlQeSJWTc44UhJh
 69ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025533; x=1783630333;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4igSEQbRRqFAd+2qC3yhmAju0E5nj3Rur/oE06rG7WQ=;
 b=Cs/iNq2g8pZGZD4JXe57cdDFPEfimdfhNgXOIvdZxrNWRqJ7wDuFbPq43DYce+0lqr
 s38UDHYb5Af2+4nW2KvEe1d2XymiDngRfq3xXIhEdQOgRIAsRRf+YCC9o0EMN9qFFU/j
 u1KrYvMUbA4tSxA95Fq7qea07lZKAKz3oLU8MUTAsdk8u2lTGOFRlTlu3rFLVhK672Jp
 MVd0AIXHIZ1Pepdpd1tJ4Km6oxqT8itpsmXOVGQbVfgHU631T7aMcO2fYBcvi0obqQUM
 kdGOPQ2yMSG7hd3dT39Cx7CHkXsEMQnE8pxjgFqRcyuTLmxt7atoUr8GKmegeqKO0CDU
 7bKw==
X-Gm-Message-State: AOJu0Yxi6V07c4kzbR4BcVqoznTw5JS828TZ16efUZuVpIrr0i6mAIBW
 C5v6OhQtttuIQJ0RoclDSPegcPCXa3Nz8ZwDhKdbNzW+KOeOi5WmD9SErey9Qjw6nWx+02rD1PB
 bkSOU
X-Gm-Gg: AfdE7clv0EdqHodlEAVnpUvclbPhspOXyV75U4mPPXnBJJo/003XmyzYAQF4x1SNVWU
 AMAXiLLWxMUyLESog1Lm5Kv4YbdEiRWNiuxwzjvaobZSpGdWjc9QRPZeucqT4gLBm9m5s1M02K8
 l5hJqLcOkCRRa1XDwFEhBqFEha3ljIFbN/vqH9mfE5xoQ1YSdICQ/gVSMFogXNmWCyyDvxqhbeN
 IPR/BaAmCikI1xwVVUlpDJWZ1395KpGR3KX61Iozp4+9UVh8cnpD9nX7U/XztnnYpLuzic+N90U
 L3x0U+lUxXXPJa1ti+2/2eKg6/lvZvOES7bgpoADkI1vlClSOXzI1gecFrPEq/yNI+hrJiEtVmn
 I1P3p0ePOIyFAMygddcmmf0mYwsyTT5OITgpnPaErFEGAolzXuhc/SUy287n6BnToEO3awqSncI
 in19bdRSNU2476KpxuhVpFVi6mSJ5fb5cl1RZ+bjoqic+pfvvNfukJ8ckAmtYFjClEQ+zf
X-Received: by 2002:aa7:9a8c:0:b0:847:76dc:3fd2 with SMTP id
 d2e1a72fcca58-847c0988997mr7915688b3a.36.1783025533113; 
 Thu, 02 Jul 2026 13:52:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb7498ccsm1882915b3a.15.2026.07.02.13.52.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 13:52:12 -0700 (PDT)
Message-ID: <73168e97-cd8c-4fdc-a0f5-8ede8d42bfe4@linaro.org>
Date: Thu, 2 Jul 2026 13:52:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] target/arm: Separate syndrome functions for A32 and
 A64
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
> Currently we have one syn_fp_access_trap() which we use for fp
> traps from A64 and from VFP and Neon A32. This means that A64
> has to specify arguments that are always fixed for it (coproc
> and is_16bit) and A32 can't specify arguments it needs to (TA).
> 
> Split it up into syn_a64_fp_access_trap() and
> syn_a32_fp_access_trap(). This is a refactor with no
> behavioural change.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/syndrome.h          | 28 ++++++++++++++++++++++------
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate-vfp.c |  2 +-
>   3 files changed, 24 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

