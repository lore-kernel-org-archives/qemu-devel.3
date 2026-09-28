Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D101ACA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDgf-00005E-JP; Mon, 28 Sep 2026 11:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDgd-0008Vp-Lm
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:54:39 -0400
Received: from mail-yx2-x24.google.com ([2607:f8b0:4864:41::24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDgc-0005wl-4h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:54:39 -0400
Received: by mail-yx2-x24.google.com with SMTP id
 00721157ae682-8aa75b33a26so11992937b3.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610877; cv=none;
 d=google.com; s=arc-20260327;
 b=q/2+utLcT4qc9jF22Y+4lfjOSltEAHGUZWcd3jCQ2FHehxNieBeML7kyudchtyJrlu
 2PlwDksYddwK5QoD1IYs57YAnpuYiyy0r/HAJSIiqxZ1MXMD6zF6k85RCCKxaxuXU0Pf
 uq9usbCkV/nA5r6lvEuruuZ/RGWGO0hsfuAgJbAfsbyLQLJu42xYjlr1RZqwiliRH/MW
 L0gZn59wqqNwHbroOznFtqHU3dx/JyVGVLzhvJMPp9lw8NmpnrhRHkGG1rac+Bm4BItq
 GdXbaTZGYtKNZsxl01kiXukqMlALfXP2KlDTzBTAIOM8xCfz6N+GKCxUSLiJq1fp1ygP
 djVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ax2F1D2PX1uU1uXDqD9Xp0uVTUshi6eeZ/YVpCH+MSs=;
 fh=i3rBYYijT2aYETyU4VvPNoz9Z8DK3pW4GWvZ1JKSgwc=;
 b=Lj8VHQQwiGryYcMSuKZn4o7jVGrLHMu9Pk+DtCyXSCf0/ACWAK/VpXvW4P+xVj7xZm
 2qSwP5WOSH4zTd24/yrazwoqOsZqV787219loPcvvOoQw9GP77VD0QZ4ikpXg7t+QGcS
 RETbFCzF1D1IMRDKT8OoRwQ1wae65RvDdSetSnbWVBYaQAL8+/E6XK2rhvUaVt2AcYT7
 oFXK4eXmcn+c5QlqGvnrOXG3esCHd/QOHxeZWUTu2XYl/bhoaDjn9z0TmgoAARvcc17j
 tSMHv6XYgmkEzpSuFTCqoyLlHfsGl5kOAqVUKVO3Qo1fTjRV5eV6ICDbWs0XrZMX+9yA
 oqZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790610877; x=1791215677; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ax2F1D2PX1uU1uXDqD9Xp0uVTUshi6eeZ/YVpCH+MSs=;
 b=IeifQbP0oCXO3HsOFTCY8mrF9OgfxGfI8OW03qwml4bNSbiqXfMkeukIaYwXJf07Tv
 npUG3HzcywJzwutYi3B4vMHjPbLsElFP1yOPABCUo6bLDgYu3jNqkJ2Y2WWrbiyxoAVP
 9Kz3WpVjvAEdiGgJnGeotINPyzRMDdJF/sULWziOhQM9uqPsPBMCNasKlnNOigyyA8sw
 gWFIgyNMmnm0frS+/ASqZVAOk1f8l3itN2q9s4qGNn1kdJuVtiWnNaWTnsZ05HmvpRw2
 3iy+kKsoRUARQL4HEhPKP0H60TkrDKsA0SQ0SeNg5dSXikK++2IRkgaIDcUl32wHZCSX
 OW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610877; x=1791215677;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ax2F1D2PX1uU1uXDqD9Xp0uVTUshi6eeZ/YVpCH+MSs=;
 b=W8SEV+e6m80uw/gwFpqArACq5l5DG1FeC6UmNoWHvT7xY+Eawyahk3gyWFBBxkUfmz
 v6Y2GOBLVxy8LiVZ2D2RzFELTKy0rNryof81FYqMoICGKBbnO2xOCsR9JNFTYLdV5CgH
 9CdHnWiCIaxTZ8dQDWU+B+LXMRO09GL8JtExOdCXnEWXucbKxI/9KMF+ZvqQkzqxatSH
 oLQ5nnu0GsYJj/dONdCiYE/mDJcGridy8s8IGMR+MF29ff6EjcSMcUbHFxNrz/L3YuVF
 obgkxRM5XpW+S+McRzBS67uKtp4ZqvBdU8LVNc/zB3ko3uB6piO3QysGMrx/Mkp7RbW4
 aMzQ==
X-Gm-Message-State: AFq9FYID3EY8PhMCYBDMfTnzoIcaLQn0JF3OlvvZ4kj5Uwfy8vlpzAKr
 IlAJ1BQBqSQArpPUY90viaF1cP75SovQy5V8AbOdTRDf8/WZ/lITIyEvOo1iJX8UlHE7yXcWjIH
 /C1k5rFbhFEoOMg+YLDfE3BA7zcZ5tHExCbP2l3qwGfHgmj7IACtSlXM=
X-Gm-Gg: AYBFou2iiCFZLTbwCQXUJQXR44U/GqIdhuRQUStx7fs9nwCwFOlkx73nHE46u4ukqtR
 QuFpA+7+SqkZIobvvQG1ftV/iQX+JIDwHae2jXmKcOzuxh2M77Wf4bGzfNU8RgQPb4jYmo6gWuw
 KL6BXZEMBTgpD6hDlbP8+CP/F1kl/ix4xUNtL/9tAVy6bKYRBKAEeW+xaMifUMHMppIcLCkk8WC
 PzsoTkMLaSL4wG4p2o3flcR6IwqgTvBNc7jfthfSOn1P5NRLj0It4qjCSWTdXYsdXAPwx1Qb6r6
 lD7cTzJjUAxW2vv8W8BYSzsjQzjvhHTyeLOYYqUsQVCskVV+qOTVNgyZY6AkYD3ZD7w9Zp8UZ9T
 fDzrWpCjP+xA7i8n6PUzs45zztuR28BFFnRzzePk=
X-Received: by 2002:a05:690e:4383:b0:671:2ab1:899c with SMTP id
 956f58d0204a3-672ed50c6c5mr4645316d50.89.1790610876515; Mon, 28 Sep 2026
 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
 <20260904043742.96613-2-mohamed@unpredictable.fr>
In-Reply-To: <20260904043742.96613-2-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 16:54:24 +0100
X-Gm-Features: AclHuK8hiTp7wdex--eqxPA2GUbHVI9vSkxHVsbO9w2KsIOrj8Tqob0Z4uEB4Vw
Message-ID: <CAFEAcA8XVZVehzwCAfy_a3V+KFfxOErhxo3dg1NObmco9kEj1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::24;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x24.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 4 Sept 2026 at 05:37, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> For the kernel-irqchip=on case, advertise ID_AA64PFR0_EL1.GIC.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index da3ec521fc..f881d6cc67 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1229,6 +1229,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
>      }
>
> +    /*
> +     * On HVF, kernel-irqchip implies GICv3.
> +     * The kernel-irqchip=off,gic-version=3 legacy case also supports
> +     * the host CPU interface but advertising it in ID_AA64PFR0_EL1
> +     * is not implemented yet.
> +     */
> +
> +    if (hvf_irqchip_in_kernel()) {
> +        /* Advertise the GIC system register interface */
> +        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, GIC, 1);
> +    }

How does this interact with the existing code in
hvf_arch_init_vcpu() that does:

    pfr = GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
    pfr |= env->gicv3state ? (1 << 24) : 0;
    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);

?

env->gicv3state should be non-NULL for both HVF and TCG
GICv3, I think, so aren't we already advertising the GIC
in ID_AA64PFR0 ?

thanks
-- PMM

