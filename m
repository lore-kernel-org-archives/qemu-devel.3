Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09817F44845
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBAVN-0003US-6C; Fri, 10 Apr 2026 07:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAV9-0003Tp-6U
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:58:20 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAV7-0003FA-NG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:58:18 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64e87a81639so1945515d50.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 04:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775822296; cv=none;
 d=google.com; s=arc-20240605;
 b=aV9xOaY5+jvNFI1mcAKxH8ynclLozhRpEpC7yDMs3oBII8RJg3z8uvtokCJNrOFoPb
 x35GZM0gs4cfigJMeFVFjyzTFaG1Qdp4PivTNjdSxA02gim74+JKOSN1EZEtOoDLnWQl
 jmDfFl138m+CK9/B62fPgx2UJvRuINQgvF7MEI07D7m2Xkptr8aCR4pEmz/BKz1GqFHv
 QFfZtEan/aAoB0s8kn/y0gMBr8VQSmorI5kt956HE5IlQItEyGpdgT09KmeFnt9QvPrd
 4dHU34Z3FGw+pNCaAXXXEkfambEV07pc695yKfpMXqxWhhuzN+BtDnOTzsYOc9C0cbL3
 Qs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P5M4KQf/a3YX2BTOkf+nV0Z0qPJzsFCvpoUG3BFiwhI=;
 fh=r/2bf8xhsDC5A1t31av7Vk7+ms3Fw4zOmu2MBXs8xFg=;
 b=MEWN4rUgfhtzcFKZBFMbm9/sBfWcR8rk1rRC1mqB8mn9pUoHhCbkXOmt5+QEEK/byF
 EIp0g3radlTqJ5AkGQ2BvuJVK8GBFOI+foB3/5tswYMXPg+sGdbK0g/zxNlM1cEYUmO0
 LTupIaTniOwc5bgDe8lkepA2yj0W6brkDZVm+jozwtKrMT6oh7nuAcGeNMWn6DwrxWX7
 olcuGR+GFiAXvPPKCbxmq7ijikxCiMMvjkxUdgUDtupFZlF/Kf+04NyTRyrM/fEmNikL
 woclZnxYRjLV5ZN0qcjdK7/Qp6yHefcd/XRpIpmlSWYfTj8dpQSK0M4eto2y+gkVa+jD
 gKdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775822296; x=1776427096; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P5M4KQf/a3YX2BTOkf+nV0Z0qPJzsFCvpoUG3BFiwhI=;
 b=F6HWnD2rx/Ly5LKNTM99+WOzOH+zHxfrtXwttXDrxQ/9yYl7q4xcNF7b6wu3y3KOxP
 ou/6LvSryecsTKgD7S7okGjc2lQzQFtidBLBPFhlpwd6tBUyOhns3eaaP/fnx7UXpV6u
 Q9FOE6VO+5NWgWLm65sufw+3M+u9LJ1SqNKOYnEGxr0VFJJuDJvNskThOfawv3hRsz1C
 d8mZ8BqUyAY3QXJSyQv+C5zgLW8jRbY+H/476qcHo9ZeuQQaGvHEGYtR42n3vLS+v6O5
 Btt4zStzIDlnDnTDBKaMFpTU1A03kZ7JMeClQr45ZFJgg3dHtfr6JNTS72XtqjjdgGcK
 YRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775822296; x=1776427096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5M4KQf/a3YX2BTOkf+nV0Z0qPJzsFCvpoUG3BFiwhI=;
 b=JrosgsWChMCt/o5Mp6aVXg/xC7O5LF81xqTn9n3SusPIInOuNj43h4aviyvRMFgkAT
 sRXQ6Eex2D9lLFxQBOSdjbEVk2lUFg/A93pAGdixHktMGlID12pnyBT28wzzHXcpG8UC
 knXKaoxnX85xQDzYHHY7XF9HmsaqTRG/wHtFCGZYO+tAtYs9+SzBs261XPZwQTK/d/Zd
 j+fdBUKw70ZdbkkimbGigCOJGfNt+5I8plMo8TXxmbZzY9W2Nw/fjS6spFMQPkaTgh64
 D5eXtAcEiU6FTYkXnHjyLgi9ZuwoJP73+Rlv9lmLljshcWP97De+j3Pb9CtNy8MhN4gj
 rTgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs2IjaKSzJBJzTVBQ9NW3ng3Ffx5M7OFC6y1EQzguEMPr5mZ3zGG8s3unJDyo+DELI2vUVopCOQGvM@nongnu.org
X-Gm-Message-State: AOJu0YwAIRUyvXqU2N2Jj1xyBzXF/5oxiqd5REtE84Y//AAngsMs1qno
 Eit4RQJPqdFRDtrPeJ/tmG9J4aSGyGaAPJRirW7Cq/BXbd0nhbn+wwbufHNxH9nOyKkXzNdoBtI
 r4dvjJrRdrCKlbM+nU5SzwkrWrGnGyTORJK5Os4GD7A==
X-Gm-Gg: AeBDieuL8hjDqQ/Pd678RLiQ6nmkLYa9SZf9mbsa2MNczi6cItoClWLN44scViOKvus
 eEFiYaHQEqK7N5d72R27D6uXrBUtHGXjduI6YRJ8bxmjPInKL/y0BedjiSYY09RDWG5Dz7KwAQn
 b+FUIZiJi5Qa4BUbNNtX12jS0Nu4Mh2/nyy2vBWyAgPvWRCKcqmlnV5vo1AY3FI2gOLJFdVVdlH
 5oqQX/R3oVZ3DobJgPp0CAATfK2YNk248rxuud8FxUWujRBt9zlXQ6SRWdVsu90xiyVQYa3k8w7
 cryjr8Z107FKFdt2f6KwWW3Wowbgc2dS6rkBBp9vB5yXhYrWV52+rIPI+GdXQ39rkGE=
X-Received: by 2002:a53:ca4b:0:b0:650:4a79:f3a9 with SMTP id
 956f58d0204a3-65198c34dffmr1676618d50.69.1775822296268; Fri, 10 Apr 2026
 04:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150302.203112-1-eric.auger@redhat.com>
 <20260306150302.203112-4-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 12:58:04 +0100
X-Gm-Features: AQROBzCwi0If5Qo_L8yIdVvf835y5bsPRe4x_VJ2Fdocg-8V3ZjqR28uv2x-n2M
Message-ID: <CAFEAcA_0GwsiEG-A_OGTCz4QAs5K2hEU2z8t1pEG7mp0MLO7nA@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] target/arm/cpu64: Mitigate migration failures due
 to spurious TCR_EL1, PIRE0_EL1 and PIR_EL1
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> Before linux v6.13 those registers were erroneously unconditionally
> exposed and this was fixed by commits:
> - 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace when
>                  disabled for guests")
> - a68cddbe47ef ("KVM: arm64: Hide S1PIE registers from userspace
>                  when disabled for guests")
> in v6.13.
>
> This means if we migrate from an old kernel host to a >= 6.13 kernel
> host, migration currently fails.
>
> Declare cpreg migration tolerance for those registers.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/cpu64.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d6feba220e8..4cfddc6e8c0 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -810,6 +810,31 @@ static void aarch64_a53_initfn(Object *obj)
>      define_cortex_a72_a57_a53_cp_reginfo(cpu);
>  }
>
> +static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
> +{
> +    /*
> +     * Registers that may be in the incoming stream and not exposed
> +     * on the destination
> +     */
> +
> +    /*
> +     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
> +     * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
> +     * when disabled for guests")
> +     */
> +    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
> +                                     0, 0, ToleranceNotOnBothEnds);
> +    /*
> +     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
> +     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
> +     * S1PIE registers from userspace when disabled for guests")
> +     */
> +    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
> +                                     0, 0, ToleranceNotOnBothEnds);
> +    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
> +                                     0, 0, ToleranceNotOnBothEnds);
> +}
> +
>  static void aarch64_host_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -822,6 +847,7 @@ static void aarch64_host_initfn(Object *obj)
>  #endif
>
>  #if defined(CONFIG_KVM)
> +    kvm_arm_set_cpreg_mig_tolerances(cpu);
>      kvm_arm_set_cpu_features_from_host(cpu);
>      aarch64_add_sve_properties(obj);
>  #elif defined(CONFIG_HVF)


If your only callsite for a static function is guarded by an ifdef then
you need to also guard the function definition with the matching ifdef.
Otherwise you get compilation errors (either clang complains but gcc
is happy, or the other way around -- I forget which).

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

