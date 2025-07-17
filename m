Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3023C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUR3-0007Al-A7; Thu, 17 Jul 2025 15:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRuy-0001qx-0Q
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:57:18 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRuw-0000TV-2I
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:57:11 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8bbb02b887so1188774276.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752771429; x=1753376229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ARB4JdYsa8Oh5u9xlWRsX05TYSJaYdv5MyXQ9Vhff4=;
 b=YyXY3BTmyatlzQkYL0sD3wi+SGg3aSt+ALSR/iHiTypiptXM+NpxGcBYqrLnajCYUU
 IQtVSgsMH5MVnGEF06pOGFFvrDg+3kqvbnywQROJc8QlRpoREyA0YsSNETbor7mjBNdz
 jAkxM+uh0J1qliLaMyiiJYXXpZWeks5qpmu7gjjNtTxq4h6bU034k2E08WHkIe7iEluF
 gBXpBvPYLWIzu/F3WNOEAprWOr3lP7gnupz2jmUu4M3d2Vj+u9WB8vEEC2t2ZEQiXWL7
 PvI20sXXo4uCHw6dYhfuvkwLfAHI3rkledIgO3NrZpNNE/30+PCqC4IU2vgoS2R/aBga
 50QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771429; x=1753376229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ARB4JdYsa8Oh5u9xlWRsX05TYSJaYdv5MyXQ9Vhff4=;
 b=wm69gCEY2h8hW6UL9JU/ttJVGJtGRW4/xaMy99sUNkcS6TAyzIQ4ARwSCFCXX0tQJb
 BE8t5Z1j8VgfDd0eyLFtXZpg9yVXbUN3UAsjES0FXwUfI9dmUYDqddwiaZvfamV+6pfd
 86WaZ8q149A8rNduNKvsMlwQYBS8IvK+xPDq+4CdS77l0iD25TPSU6fbxi8uMF0FsoRV
 b3k0iu8ojyC5e220Ve9yL0J3VHScafW58awSRSqgvh7/5VPdl8gECz+yyF8Myi7d0+a+
 qb3aWlHFynH63oL1HKqb8GMnqmI8YVWVQ0VD88AI89JuapdHmo75qNk8XtC4ItqVaoR0
 NeGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9rLu/rS06JbkpBDMjLs5thz9u3A5gW3jVnLiSXNUvnvoBSq40wliYKazd2ktVmmYGScc+lQaateBZ@nongnu.org
X-Gm-Message-State: AOJu0Yzrn/c1j17EYUkkEn/3fWkqrR7Uu5VY+DyC4eu//ON841kAZ+45
 0NWVAh27BKxJYUPqcPcbfAPScBOgzHGhJr4hSn4hgPAvCPNWT76Il4oYeWb0VzO1oxwSjUrkR4G
 7PCjLvGVfqS8eY9nCVPqjQW0+09hAEdWrMvlmCp1FfA==
X-Gm-Gg: ASbGncs9I7mt5g9D0/4OIunUdD+oELfjPr+YdLtJewCH2ZDejcwWWpNSALugu8zeFbx
 o81X+pxGpnviTUNT+Jl2NQBuNSwB+P4OpSRhuyLagGYFMDYh1D3AvHeUl8HOEaasqgL40BewVzS
 EsdOBI4uTCzaSf/StqRIiV0JEKIx9FTpPAZs8YD+ZrEXi8bXN6wFjwBo5x/dIu9LIc98zPtvM/r
 YKscFPfRxGcp/KogD8=
X-Google-Smtp-Source: AGHT+IFXXkLZjSEwMjKBiCq0eLSrKJdwNolOoeosHJnfC5AgCQWlp7U3rV8RK8/ZahUn6cYvCarM3K2aa4g/WBZ+Syk=
X-Received: by 2002:a05:690c:4913:b0:70e:2c7f:2ee7 with SMTP id
 00721157ae682-71834fa7319mr108023257b3.12.1752771428749; Thu, 17 Jul 2025
 09:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250714135152.1896214-1-peter.maydell@linaro.org>
 <0b438773-01b9-42e1-8edf-2330e50387f8@linaro.org>
 <95b00393-bdd2-4db3-ac39-02a09f83b4d7@linaro.org>
In-Reply-To: <95b00393-bdd2-4db3-ac39-02a09f83b4d7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 17:56:57 +0100
X-Gm-Features: Ac12FXzjET16YqXZs-qsF_MikTfwwMTcngVAjP_a6kVAWH90nMd3IWzhu4zw1XI
Message-ID: <CAFEAcA_Hbpg0wkQ9frt+MUj7x7uR+p7+8o4SLLx=GwhWvfCzaQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Provide always-false kvm_arm_*_supported()
 stubs for usermode
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 14 Jul 2025 at 16:41, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> As folding is not guaranteed by C standard, I'm not sure it's really
> possible to file a bug. However, since we rely on this behaviour in
> other parts, maybe it would be better to rewrite the condition on our side.
>
> By changing the code to this, the folding happens as expected.
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 26cf7e6dfa2..af5788dafab 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -318,9 +318,11 @@ static void cpu_arm_set_sve(Object *obj, bool
> value, Error **errp)
>   {
>       ARMCPU *cpu = ARM_CPU(obj);
>
> -    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
> -        error_setg(errp, "'sve' feature not supported by KVM on this
> host");
> -        return;
> +    if (value) {
> +        if (kvm_enabled() && !kvm_arm_sve_supported()) {
> +            error_setg(errp, "'sve' feature not supported by KVM on
> this host");
> +            return;
> +        }
>       }
>
>       FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);
>
> If you prefer keeping your patch, I'm ok, but fixing the condition looks
> better to me (as we already rely on constant folding in other places).

I'm not really a fan of relying on the compiler to fold stuff
away -- it's fragile and there's no guarantee the compiler
will actually do it. In this example it would be really easy
for somebody coming along to tidy this up later to put the
nested if()s back into a single if() condition and reintroduce
the problem, for instance.

I've applied this patch to target-arm.next; thanks for the review.

-- PMM

