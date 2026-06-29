Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D57C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfS-0006pk-Bs; Mon, 29 Jun 2026 08:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAf0-0006mE-8o
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:27 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAex-0006sf-0q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:20 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664ae993e4bso2983165d50.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782734417; cv=none;
 d=google.com; s=arc-20260327;
 b=pkmc/JqBeXUDmHw2g/vuDquCa9rLMuljUDRsf6X3OV61pFe+4eoDdgF3HvFbDmZw8Q
 qREcRgEoF9CGkGRZy7KsxtCPZdL0fc5XQzKuC0SXqZ7va7f+g+nRCQBLVM/+JgD7wUTB
 /8p4xfeBbxcYaBb2Edqjenyh7N+3oRgWn0PHkBQMDIwfgr/wT5Gf5q5JAGUR7ov3hy+O
 EmSMz7jAZbymktL+HKDSvXQqxXhcsTY+zG5PWoD2WevBXV1RcHZCjvCXZwTcnunruTPf
 y29LJws1TOZ8K8mXmSo3ThdtjV/Fv4pR+jHUBqjPRcJXWm47YJeaM0ZU0UkNbL9CjNZ+
 auAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gNj4QCOANvhWx9qKYTXiXz06nNeGz0TLkUw63txWXos=;
 fh=OGCmJLUP0SDa9Ex01DM5bZ6kIElysIl2mTkIXt0Fcs0=;
 b=fLKffJfLLrhucj8X8Ojeflpzv/WZCKH6R4bsc3h9gz6/Cepo3C5YsWnja4QQE/C+KX
 iwM3gHDB9kP3X2rUv4aihbeLIxGurREqC4juRJgEEnzu6SQuMO9IBbdgYNCJRqSIEmBK
 4Qo2C5BZ9N+2YMRlxqgif3norfHPP+9VmSvsTYmOL6+/TuHi9F6mMd2N3JYxnmST8ML7
 mTJKNnzgN/OPpOXESQam04ANPsxhkA6FZskSaci6wuLeNeMXCvPBn7av8CpBaY1K38li
 tBGPVRacqn/dKkg+dO+6Cjjb/9jhooKnO1/1XNeyZTmizCVbEJ+LXYC7/nyPfF+We1GK
 NS7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734417; x=1783339217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gNj4QCOANvhWx9qKYTXiXz06nNeGz0TLkUw63txWXos=;
 b=Qi3V57pauWu+0BOGY8TXtth3rl66W1EODe+kO51KIRSoKByOgvlkmbWSjZN0amcltb
 /gZ1b7fpzHSao4HPHRGb2OvPPQ6rxiRj5PQVmvEsakv1s7VrXU5zdihOJyLZbL4PL/bH
 1aDxtl/XQL3dDP3cvL/Lhio/LLjOmXel8Lz2li9qA3MWdWnKCsCL4TK+qaU5ES8k4nJZ
 CnqEIfnKtSxqToo8s/KHPfkAX8k6LWEtBUOIhEODx8SsK/mlHSYPHEEqhjnYdhVzvHLA
 SOjH3yhuN0/KhrWvupUNmCntx3bmYoqEkdX0PDiWGypfTZBopb/CJaFjrBVEpKhiOjJX
 nGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734417; x=1783339217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNj4QCOANvhWx9qKYTXiXz06nNeGz0TLkUw63txWXos=;
 b=fd1S8e/k2MO+ORwL1ispqM2RDhof2wdLqgkEu05LFLf7zsTMVBFbvshKybrIRhhRsa
 JcDCjERMoBMGCHz5WFhPHWZcwY8Jjen7mRH7kQB7UJ9dl4UYhr5rHGpk0sp4KHOI5aYv
 G/udkYZJdsCxU7bH4eDrVgPHhjodRMSgLkVkdBOMqLPmgiRXO2Za2ex6j7oqk5vsfZev
 Coe4JbhNJq3jeMYttTPi9D839KP83E21yoL/IOsCZv8aJNv8nl8+iZpDhMWWsNhUnaqX
 EKr2dpGaBMOAZDtujRsuPN2uXtnRonraR0MGLDr8YHUzyNNDO86iKs/Bsi4UMChVCeH1
 E2tQ==
X-Gm-Message-State: AOJu0YyrYKZaVy3p1QETx+YwKivIs6lSNeumq+bp6vI/1ye/o7TrvmwF
 vGxsYDlPvTH+fT8mFLf2mn/UtgwASovQtEpZ2j8/sHAOquH45pzfEceGoq5qEhN1izrHYZXSMYt
 LmzV+KA5BgHtmYKJSKukn8DhKucF1tFhXQ2u5BMpfFg==
X-Gm-Gg: AfdE7cltb8k26BDswWY+WcW/lbiz8dFahHMwEZk02a2ySC8EKa5RobdhPB4/mxJaA74
 Mp516IsvHb6fDRdGJ3MzqGyFHuPRJLVkobvKKXIce+nNuejypHVxIt6F44Xvu1V8K7wSXFWB9F2
 GOsuF1AnDoxJvbnHFPzhs93ynpcKvPhm9DzNFjAWIT0nJSbzjTzcnNIgj44jYOuNviROiWIA5Gj
 VsKBQdvR3GmwzT9DjdJ/5NpgiYC8XsdgyA+MdFwqOQ2E7msOyf1a0A4/EN1uOQ1ZwQokELFlKg/
 9D8iJnTHQklrCayuvKM+I9l/9TlOgmgxOlk1e2kBu3QVBFfYsbhx+ae0
X-Received: by 2002:a05:690e:1343:b0:660:3a72:87da with SMTP id
 956f58d0204a3-66487968786mr12267308d50.22.1782734417263; Mon, 29 Jun 2026
 05:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
 <20260618-jmac-gpc3b-v3-4-353e546067e7@linaro.org>
In-Reply-To: <20260618-jmac-gpc3b-v3-4-353e546067e7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 13:00:05 +0100
X-Gm-Features: AVVi8Cec08Nts62OHgkdJ2sEo2sOfahiQ5FJk6HaxvArMuLH8YdaSS2yah15vr8
Message-ID: <CAFEAcA_M0Z770FApDyhNcYaP89JP3Q8MDj5bMjYKSpmONYrr7A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] target/arm/cpu-features.h: x-rme now means GPC3
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 18 Jun 2026 at 17:33, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  target/arm/tcg/cpu64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index f7a920a202..75c2027900 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -159,8 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>
> -    /* Enable FEAT_RME_GPC2 */
> -    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
> +    /* Enable FEAT_RME_GPC3 */
> +    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 3 : 0);
>  }

Just noticed this, but does this mean we should now list
FEAT_RME_GPC3 in docs/system/arm/emulation.rst ?
(If so, we can fix that as a followup patch.)

thanks
-- PMM

