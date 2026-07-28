Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFDDC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokrH-0001mu-BJ; Tue, 28 Jul 2026 12:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokrE-0001ky-5U
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:40:44 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokrC-000531-S1
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:40:43 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81062fdeaf5so17218517b3.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256841; cv=none;
 d=google.com; s=arc-20260327;
 b=sjO9+6T90KrdWbIf4BHy6z0LrhX7bAauBBJblOAFbEYdcBm/NFhmx7BQqtnPb+IRFE
 F2PJYS7dcMKR9BIUIF4fLZfegWTX2mKJ4ItwFo+gw1kIdR7O8Jzx1ZullBv807HNoF9o
 tF5mQzWq09BCXlzZLav9BZE63wgQgMFL+jn0PE57YOk+9vZ6LElnyLM9aJRTjE4d/L5Q
 r2OF8qJ+/C9wBIRGCK8d5UbWlSbfr3NLCrYPHYWUQaX35h/FfsPEHaOT6L094XZPb4M9
 b1iF2E2TTDIChzD9//14lHY5KxUI2Z7jFE2OqYCm4ny9Nd3yXq2JkwBpM/JZGXlP+090
 WK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4xaLGyZJCLrr64KtVZXpMLwebt0UyZHPNQWzO5gDA10=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WGBRA8HsCA2eHKzbi8KX8ywK6IEq2eI3SgULdPwAMKp+TMmk0bgwXUJ8ngVpSU3RNk
 XGZaLql+L5iVo6n3oH3Bi7aiLc/gKs3CjZmUg5pLdI0tNHOFyQNygBiBUnbcq0wj9r0n
 M/R0lx9tHuXacPRIXWNNM05kIotb6IZG1LLI0z9yRHHiM9sVEnf/rErmRwhjUusRL2B2
 3VnzCgO/Ncwv+hi7kqV1QwV16rIqargzP41yroQBA5A1V7y4gPN0k2HRGhj1t5OUIwfq
 dZtL63Eif5PMVuotx/ei7Th2ZWdZ9Sz1G+OD97TIP77ErDOHNwSSbZjpRaPjywlx1S4m
 yRnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785256841; x=1785861641; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4xaLGyZJCLrr64KtVZXpMLwebt0UyZHPNQWzO5gDA10=;
 b=JsUTlWpxBT+WJyp22/q3DUOquh7iuq+ByzSz3dR/2F7k8l2o7JFVedZIhkaKlZ96n5
 oG58QKP2pv2gMQ0UHhUKky7XYhA1FhkAUv81i1x1GppYhYMoFmdGUHJSP3+sGGg6vu+Z
 Q2gnY9/syLrCp5Gg7VVXyLn0tA1xO72DxfkfxN3wIPistkTMhYVMFyuwx2p6t2QMmNiB
 SiaC3iXRG9FX/kFZKxR7KX3oI1RW448aKoADDUgkxgrSuHFgwtOPN3IgcGRXHPRucOXB
 xV0aw39B8YiGV3tZzVsUbKC+A9tdlYuncJqs2rbJHZ3subzLCEENKtTljZO+MuZz3KDP
 JB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785256841; x=1785861641;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4xaLGyZJCLrr64KtVZXpMLwebt0UyZHPNQWzO5gDA10=;
 b=Jv1+Qu2z/bWELFbCmkm2CO1AyqpbJvc5EOc4boXPuggAYT2DM+nHufLlF18yrAxT99
 vEELzFd3PDawMKG62S9Obr7R+k3NzFCqCdNbPwU1hRQTT6vMZX6pelBBLt6ONgW0Ue86
 ff7MEIvkciOOH33VWXQt9L0jQpMBJUC1IzmNodWvgZZ4hXBvrUIej6nSb7SQzDL6UpLF
 Bl8mROn2i8IyBwXrhbVqgjULRQ4Hm8JXseijTnXg6miiXBMzO8On80YFBNqLcBUteneT
 XDetvE46Cviaw4mnHxVgoPtDpmngqLBsI4Wv63163oz91pDLvqJZYqLzelebluT09L0F
 LRNQ==
X-Gm-Message-State: AOJu0YzlAxvDbdZfNAl7dnirhwzblaXKG585avrHAPQdYnCGTQYbBXOI
 6KEO+EkfAf3HYJrBlBYdrYRcdJ4evy9d6ZNJDGYdeDg9iLZknBvQGXJsXVrGxuhGZsGYVnk3Jfp
 jbu3f57zXa/xOJxoflA6xcTyg0hVRj9zvptEcZyOCfFMngk3B6gHw
X-Gm-Gg: AR+sD11OEo0ZpJu3gK4mcB/qoJGTRQ2VpEIOvlz+SUNfIo04nvBuLXzJBeU6O+E4GYA
 P7034dWDG5tXffM8jjqmFvPh3VrsBIG0RdK03b1zLoidfULD4eOfutzt7aWL1abZbwW8BKkACgC
 Hu2j9R875fzRErcHide4juml0qILj7mMk7V3kmH6kYNxvFaf7CG1fS/hvUjhE53jsBytfyWS/tW
 +SlHB6t7koX8X0I03HQ5oSSimdwtKrwqkoP4nOERSmHUyyexJPMJbHJEn7LMvPeFYV9EJDjusgz
 paIie15kAZwquopcWU1vz8zntEiN8ngwjI5o0uOWvyDcGQ==
X-Received: by 2002:a05:690c:e3ea:b0:7dc:3d2b:2e94 with SMTP id
 00721157ae682-81f9925f965mr15419927b3.13.1785256841411; Tue, 28 Jul 2026
 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 17:40:30 +0100
X-Gm-Features: AUfX_mwFAeP7NnN_Wz4s0okq-OoazT8xWM-g3TVrt-5pna4ESXV1N_IMSs-HQkY
Message-ID: <CAFEAcA_njzMzV-9MqRLA-eY+cB0_y-fGB2P9DaMzTmyt1kuTzw@mail.gmail.com>
Subject: Re: [PATCH 00/20] target/arm: Implement FEAT_SVE_{BFSCALE, BitPerm,
 AES2}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260719174905.420725-1-richard.henderson@linaro.org
> ("[PATCH for-11.2 0/6] target/arm: Implement FEAT_SME2p2")
>
> I believe these are the last 3 SVE extensions present in
> the ARM revision M.c.

>   target/arm: Implement PMULL, PMLAL

Patch 19 here is the only one of these I had any comments on.

thanks
-- PMM

