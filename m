Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E44C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaZn-0004Nb-5u; Thu, 27 Aug 2026 09:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzaZl-0004LG-AI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:55:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzaZj-0001Ev-9N
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:55:29 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c2529b3139fso261482766b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787838925; cv=none;
 d=google.com; s=arc-20260327;
 b=KWdqdL6oUUYEDfLPpxFzz7Te/3BOqylMS/+5JLPf46rHbTNRcT1EeRfzaC62/q5oEq
 oW6NI8iWObynwAIi5PcaVLqnZQGkDddjjfDxJJ/VZMU0zwqldzYudnAN6cChPRTdpe/v
 lIjKW1oJ7vwoOwzYpqcpfTtLycPZAqx7xZA1AoDYCDO8VVh44lWm8WfKuc5oLMlQuq0h
 T/SoCRvlkFBScrGWsKSy5rcQ+VeCiALlxOJhz9SWpzYNvDKWJP8TuauCHOYLILq9Hl2t
 K+DjPTBQ94b+UZfF6XEL2YtNQrXPPUJJW1JT7Auh5R6VQ5ebdXkLYmVd2D7zyd67qhoa
 QRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z7iyjWDK1mAgB/lcxDDjJqAVJcg1hit6hAafcQvHTxQ=;
 fh=ha6/36mnVIse2IYGESlpLWU1S2sZOniWgoAfZb7nzCU=;
 b=N24y9ZVuc29ts5dkvYHwaKFvvR/B49UzYjoYyK1RkX0atYcHK2QbJL16LBYDRoGUvD
 8bOk1ZJ32BbQsaL/6+xMmY7xaZqc0dRBTvu5ghZ1eORsdq2qajIbHuZL+wBADIZz6wYb
 kvjEqKGt8TaZoq8wEQ65mW2YDLM1pskDBk4DU8N9502bg4ImHENKvMkEvPvwWFQoEEVT
 hntlHt1ikUkta5YpBdDXDE0PXB2Ch0Dfti9koYM/gms7uIbF7i+JoW68u7QZ9uqJCgqS
 CEtXx9zWAtXvleM6VaqrXJpeVHLa93x6Pc8Y3ZXvFBJez9mnUKI+Lu/DSQw0uWq6vjfa
 O0Ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787838925; x=1788443725; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z7iyjWDK1mAgB/lcxDDjJqAVJcg1hit6hAafcQvHTxQ=;
 b=E0esFl3Jgnjxx6rFFFQn49s4oU8gPV84ltbRp5YBvshqRgWgzHAObiwdnRIJmZCl2O
 ecU03jfWlentzgxslAzywURU/Zh2Z6QmZpC0RNb6YDh3ogIHEomxrPwfaVxdRHHDK3O0
 R3wtduW4u/Vk+bYVTE2FAufTHfIVYk377stG93BXxFTwe7SUt6kHZ2RLm5f7gfQiIdnJ
 xe2v9lX718G8Em8B26dhF9AEkBNRzfJaUXkgGA6sRzvxLiEBNKBUL0ObVXGhKCt2Gxoj
 jp/wtjWQ6JFgAz2YJDSfuD2iHWAhF0yizBtZsfE9cQyzWHaVc8E5XXx/NY3mN85jhq4g
 sltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787838925; x=1788443725;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z7iyjWDK1mAgB/lcxDDjJqAVJcg1hit6hAafcQvHTxQ=;
 b=CSZs4AMt84SLKVd/FZrffxUjKkg0jXNMkXOMe5rIzfZKWwuR+F4wTXCUZDTNdTyoZX
 poSiuIlyE6ADdfbKtYrs4Fq/aXJIXPQblu9M3b23AmnHQ1i1Ff+jbg12Vp6qVXQEjAiR
 f5aVEWO157hsRrLzgC+FwkizlO8Gkv3TTAG4nuu9dZWbQt4CwVsfqVaaaItkAmCGzZVJ
 Fj7wZIZohWkJbgxfJSem89wFXQNel5TKsBNmZqX9QCJgFwcPv4kZzETJ16XtT0SLfO7l
 Sxl5vbYRuY0IxrYmeNWX34PvkgTkBJmK8IdKhIILnoi/N8AgI3SDiOB6YwjIHA9w2QzP
 IJkQ==
X-Gm-Message-State: AFuF++nCpFBK0J1l1EgEn4vJtFu5VgHI7uIPjrrNGaz2AMolODAdpNba
 re5u8WlJxoJoZZWB1K/28a0K2RVXNIBHu4XMQeaioB74TdCOFHLpDKnKEbp1iALir/p5mmbAmcf
 ARg2mEn05rSNKC/gJ8EUpLGTUpA5LZvLNo1EtaSa+1A==
X-Gm-Gg: AR+sD10T6EoFCO0fEuZVtFZ3qe/mr+uo0qdeRBJSZ4CupVEhWWct6VJhEylhn35tSY/
 H0trs6FluSr24ZRPQ/ohjkK2lHUvHSQ2XcgqWBcO/UTs2r7rLMl757FWAmikULbNRQ3ptdrG9Aw
 Kj/VwLDHqgV1Stoy2UkVMgXto+tTn31YFUYT+viKI1k6iQrpDWpUz5zRcvz4BcKCyo/JH/QddbQ
 TlNCKdJ+V6h7ywIcEH7uYZqdA4GuYkTz1AU3v40gUVMJdDUpU3bSHGRaeN8gp+938bJBHbw5ase
 xZ9rpUnA2YQYEFvGogmF32Gx9+HRZsCq3B6TRDMaAoV9Qyu2rnmXExhgvxJ5uZULf8YBBv2m8BO
 zDVV98BABJhGGGVv5zm5fvFvE4zrOTo8EH1RhkTg=
X-Received: by 2002:a17:907:728e:b0:c20:53c7:488d with SMTP id
 a640c23a62f3a-c250bc2d085mr1208203166b.14.1787838925445; Thu, 27 Aug 2026
 06:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
 <20260818002629.172827-2-simonxhy0404@gmail.com>
In-Reply-To: <20260818002629.172827-2-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 14:55:11 +0100
X-Gm-Features: AcwNN1XwAno_RQlVog7vUGr6bLcpZM7nv0cCXnsG2FP_eXcxKsjFNYEpL3SA3cs
Message-ID: <CAFEAcA9Y-tzX_a=jwWEBJ6BivowF_=+D_RBmA92KKJ03QvVyzg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] target/arm/tcg/cpu-v7m.c: add cortex-m85 model
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>, Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, 18 Aug 2026 at 01:26, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add Arm Cortex-M85 CPU, modeld after the existing M55 CPU.
> The new M85 feature PACBTI is not implemented in QEMU and the midr value
> is based off the r1p1 product revision identifier.
>
> Arm Cortex-M85 TRM:
> https://developer.arm.com/documentation/101924/0101/
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> Message-Id: <20260805153005.9989-2-simonxhy0404@gmail.com>
> ---
>  target/arm/tcg/cpu-v7m.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index dc249ce1f1..a1e62a20f8 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -237,6 +237,45 @@ static void cortex_m55_initfn(Object *obj)
>      cpu->ctr = 0x8303c003;
>  }
>
> +static void cortex_m85_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    ARMISARegisters *isar = &cpu->isar;
> +
> +    /* QEMU currently does not support the PACBTI feature */

Looking at the M85 TRM, PACBTI is a configurable feature there
(that is, you can have a real hardware M85 without it).
So I think we're OK to start with a Cortex-M85 which doesn't
implement PACBTI yet, and add that afterwards. We'll have to
add a note to the an555 docs that we don't implement it yet,
because the AN555 does configure its CPU to have PACBTI.

We can improve the comment about this:
+    /*
+     * Real Cortex-M85 CPUs can be configured with or without PACBTI.
+     * If PACBTI is present then ID_ISAR5[23:20] read as 0b0100,
+     * indicating that QARMA3 is used. QEMU does not yet implement
+     * PACBTI emulation for M-profile, so we report as a "no-PACBTI"
+     * CPU for now.
+     */
but otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


On the Linaro side, Richard Henderson is planning to have a
look at emulation of PACBTI for M-profile, which should fill
in this missing piece.

thanks
-- PMM

