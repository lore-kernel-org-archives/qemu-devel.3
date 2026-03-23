Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34206EC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dBt-0003vW-WD; Mon, 23 Mar 2026 07:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dBo-0003tt-CF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:11:20 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dBk-00039B-OZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:11:19 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64c31ca77b4so3773920d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774264275; cv=none;
 d=google.com; s=arc-20240605;
 b=PHvohycdO5u5q+2iwLZvAI5PHkW3BMdwhmPlQUqZlSmhlBa8Cs7+xGL4qnqEGHBy5R
 6VAYecL8VJnyKaEQlCp87m+WL0yALgqnjXcRSd4aUfKiGxl04ujM3JsP6q71qCagTevQ
 XcL0kSkKLLSuL4BLCr88OihfAbtWEJUQu95x8MUaTumjPewvwldIy6ISALisKrD/oOAB
 qqi+zyQrrHdrKIgJEUL3Be7h9s4SEab5ydiL3HCxYW8mRwPORx2zXR+PAjP1jPde6ya5
 PtwkyhwW0bQiwC61L6zIsb0+B9tZNFP7bzLVyYEjpBjsr5FylMvNcinPsb8wrWqm/uAC
 CmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2F2lEXMb2/G//JV0DrWIHHuQfVGU6SP/uEXKNBCtlDE=;
 fh=ga66zpwei4Dgcd14qbVFwhpQ9QjhHSTSE3h85D9jdRY=;
 b=O9YoQcEuAGa/iwb7n508ZXgVMpPafjohbqkdtA7PRnA8dztLsbha8pisqbzSuM8kok
 UBytrMTGjKtIVDw7NPzHgjStVEGwPrQlDd0Tm6YmHoNjVBTgrqAQzPBMEGWmpmM2c3jU
 Fw4T/9gqUiJ4q27Lju3BsLmIYifxHyDEg+JCWJ9KVGfOzg+sufbPh2yoMyS+EPBDtfCM
 JFUPYkeflWbLSGLebz7UWooIXtjM/ALHPz6iHBaEEx4GEmH68ClukhIvjf6eYXv6us/a
 GH1eDvmSdp6AJfIH2gRjWEphNfTRmJcGcCoGiyXBGBFSsA2pRjF1wtA+q6kPQBHNUHXt
 bC3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774264275; x=1774869075; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2F2lEXMb2/G//JV0DrWIHHuQfVGU6SP/uEXKNBCtlDE=;
 b=EIEs0BeM868/RSIcaNY0Fq8atXw9XYocnSIR1B3GJO9CdgNXsEgnuQTwhRSQ0DUfFZ
 xAG92SDBAT/kxHhIxgE2fIWR5ys7rLt6fSYnPw4+9aASguFz6pexlNB4eEs6125cvIDM
 RHwsk917lX3vSzIC3gXz4N1l0J7/RjOxHuRtfTOZu2zGUjJVo5Y3N5njFWQ0pY7U3M8c
 uNSiXzutyPUUPTM2hGR660yKhKLCLLK6HEKKVpGlIy8RL11EZ+6I9ZZmHhIm//OeRdHI
 9Z5pDBJj9C0m2YOmMOUuEbuwQ0aVaoxcG581ISFNlQoYbg3pg2fdadkyax/ETnraGIaO
 rqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774264275; x=1774869075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2F2lEXMb2/G//JV0DrWIHHuQfVGU6SP/uEXKNBCtlDE=;
 b=Kezz3TgXiB3DQ8/RMyfZS+kDJeG3t8k2vGE5YCUQkpm40ivejKDc68QtO/WMbblAc+
 +Ojf41c4yUwBdv+pTh/IWBdsanpKQCcj4AKdo9ahfOs4hi88TjvqLpQlM0BG7iAgpv9C
 sdYC1MlYkVZXEQK7/1WiyQIQyFkuIj0CHirePGTyCPygHNhIz4exTMbmMI1au2YgsKNq
 LC0yI0LeSQ35a3wmm+k0PZfgXry6U71scMqLNz4hpShqWsom9H2CY3AwQnfN2KxYmBUT
 babqxVxIOqjjhBo5gGTv9P9FEmpsKzrnozpRdsamTqQGNh773tjA3+/cj7ll8VvtkqR0
 kQjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWilNBKLNWicEsXQrcAA1Pf6tSomRyXEtJEdjywAl5cdG8XP9mWZJgU+2JrZ4o7Ai16w5lN8NG9l5NK@nongnu.org
X-Gm-Message-State: AOJu0Yzi4GbdoP0p2XvkGfOZ3jLj3MyDZnQ9HKc0/zzTBcz+LXK//Pdw
 iUOc1mQ/+uR7Z1KqaiDbr34qda4jV15vog21I7Zt4gQwq7/JTODw4FLWiwAH6TPx4Qz1T58gXT8
 1NYCwDbYAtljW627kkxXgb+58MHhsdD8uNkM4pdoL/g==
X-Gm-Gg: ATEYQzyyJltXxIoqNEICUg4BYXFozFWBW8UVvLTTJHObInSSGP0zEkrgyz05nE2oEaY
 k/s1nghc+RobAhr87yixxGpLw0nTUPunHm7OwSc62XTNdzxgxJGAgrszSlHHcdSAoVC2CrHAJ8s
 81rsrvmZywnESsHF9fAsNmiRzbcJWPgKQCmLPEczJTSPd31L7IV0FnjwgLJe/Vv/qcQnQrt/6rE
 OAwHnqNDAfW3iLf6UpbRotLUw7Gqe4HfEz6Ifj4QSQsWPPKGiErKHxC3H3JNVvAqCDHiLu0XaAV
 rgYG3RVNbNTJCmi/QnJ+rpzmJiwmw75yYkqYIP+OWJPuuaoe2fCPuYpXy0clueZsM2kSkb0UCWu
 3XA==
X-Received: by 2002:a05:690c:c512:b0:795:254a:b433 with SMTP id
 00721157ae682-79a90aa2ff3mr120726397b3.6.1774264275316; Mon, 23 Mar 2026
 04:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260321231916.2852653-1-josemartins90@gmail.com>
In-Reply-To: <20260321231916.2852653-1-josemartins90@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 11:11:03 +0000
X-Gm-Features: AaiRm53yESZKrfXMaSfsowO89gNJuIYZLeLjHY7bpNduVs5mKJRogDbPfNkbf-k
Message-ID: <CAFEAcA8N4kMYW1zNmSpiMPXG-MUjh2awiZbZuFtOnqzRW+ir=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: fix s2prot not set for two-stage PMSA
 translations
To: Jose Martins <josemartins90@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sat, 21 Mar 2026 at 23:19, Jose Martins <josemartins90@gmail.com> wrote:
>
> commit 015cefc0ed65 ("target/arm: Add in_prot_check to S1Translate")
> changed get_phys_addr_twostage() to combine stage 1 and stage 2
> permissions using the new s2prot field:
>
>   result->f.prot = s1_prot & result->s2prot;

Hmm? That commit doesn't add the s2prot field or touch the
get_phys_addr_twostage() function. I guess you mean
a811c5dafb7 ("target/arm: Implement get_S2prot_indirect") ?

> The LPAE stage 2 path sets result->s2prot explicitly, but the PMSA
> stage 2 path (get_phys_addr_pmsav8) only sets result->f.prot, leaving
> s2prot at zero. This causes the combined permission to be zero,
> resulting in addr_read being set to -1 in the TLB entry and triggering
> an assertion in atomic_mmu_lookup() when the guest executes an atomic
> instruction on a two-stage PMSA platform (e.g. Cortex-R52 with EL2).
>
> Set s2prot from f.prot after the PMSA stage 2 lookup, consistent with
> what the LPAE path does.
>
> Fixes: 015cefc0ed65 ("target/arm: Add in_prot_check to S1Translate")
> Signed-off-by: Jose Martins <josemartins90@gmail.com>


> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8b8dc09e72..e289f88124 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3200,6 +3200,13 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
>
>      ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
>                              mmu_idx, secure, result, fi, NULL);
> +    /*
> +     * For two-stage PMSA translations, s2prot holds the stage 2
> +     * permissions to be combined with stage 1 in get_phys_addr_twostage().
> +     */
> +    if (regime_is_stage2(mmu_idx)) {
> +        result->s2prot = result->f.prot;
> +    }
>      if (sattrs.subpage) {
>          result->f.lg_page_size = 0;
>      }

The code change looks correct:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

and we should
Cc: qemu-stable@nongnu.org

thanks
-- PMM

