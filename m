Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A990C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmta-0007fk-JT; Tue, 28 Jan 2025 09:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmtX-0007em-Vl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:48:52 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmtW-0006tM-5l
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:48:51 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e53a5ff2233so10270286276.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738075729; x=1738680529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aJUCYvX3rMcr6GjYeBujEpQOfmkv12NhagSQAFdjln0=;
 b=AKF57XNZtLQMKZjG2IDbx48VO6eSC75oLow9BFXWjdRKmi9TkvEIz9C4q1jqZgKZ97
 rdmnBTlP2D+EubSWzLKByjpfBFGkJFwKB1T9kCVNPwES5oR3EjiLbjsaSHGrezNvAtmY
 gq3gdGMG38X7dpAds8EBknflWEjCRnt2j29iFh7x5ud0GBimvr+/P9W6KwXtHYvXGlIF
 oeEbSNEe3RzU/pOIW8HlGY/mRc8yf2Dxlg3IsHOVo9XjNdf56GZGGefVYzm+oROYWbtk
 AhHV32TdhtyNmWanUsr50KHjSZYRhLW25wjG3G8Anrph3Nv0jW8OH10S3X2OC8LH28IQ
 gNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738075729; x=1738680529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJUCYvX3rMcr6GjYeBujEpQOfmkv12NhagSQAFdjln0=;
 b=HzXnYx1eaOXTdSUiFMqvCKgA5M3mVDAmvQzc8rFVulvIjbjMbm6g8lxw7yTDh8RSZf
 vBXMSpb4wFI5MT4TauzoL9mLDQvPnq2Us3hyD29IuNLqV5/Lkf/DQyRoF0pdEmTdOouK
 Be0u1QWnYB/mR8XYLgIAK9VMDS1wMRg1HJxk4V2S5xMaDtslhwSx9Lu15k0CCwOvvmQi
 LexAWbxedSwt2B9enekrP9FCBSU0SlsirxU6NL0X5IuwPsICMSp3NKcU+DDDEFiHOSoW
 3upJqm5E1nVKXILivSgCYd5aqeZGMOL2doT4fob7wBpx3oCGZfCkMmnPLb9Xfd93i+/s
 spFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ1HdKepgosp1zYPRJ4+3kYfOuDe1sZ5H1oQ0lkWd0ZODvxpB/ScNByZbB5B2wMp4gHG9UkqlTeFKR@nongnu.org
X-Gm-Message-State: AOJu0YwZCgRrjmnpipV92S2MhHMumzapwlRrEXPtRyQAXNY6UrsvqyWU
 eLFuTDD/XbVeiptzWjOkeJXrHOce8Son/Tzguip+pUPyVS+IhQc1ix+gDFjz34t+TYctzKy2zwB
 hRkfS8UiQe3bEt7hhA9H1clvzlpIoe5OmZtCq59BI2c17W/Z8
X-Gm-Gg: ASbGncsuPbbFXd/2Ow2D/vThkzFVwYgL6RgHAb+e44/bsOY514SSzMnOmIm/RI3/XnR
 zOspcvl+UitsXcRPXz2YfWNMI3jZT+/o0KwuBdd7Xu+OmXvWpUU9X7mO3ordSlbX2BFfaKK6zfQ
 ==
X-Google-Smtp-Source: AGHT+IEQuz6Clbv5WDuz0z4V+Bs4pR5STmbY2gDPbv8scEBlvESvGCp6Lmzcd8cdkrnPa7ZBGK2jhs4Cxm1AMb8pc0w=
X-Received: by 2002:a05:6902:20c6:b0:e57:935d:380 with SMTP id
 3f1490d57ef6-e57b13310fcmr32632736276.47.1738075728870; Tue, 28 Jan 2025
 06:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20250104-pmu-v5-1-be9c8777c786@daynix.com>
In-Reply-To: <20250104-pmu-v5-1-be9c8777c786@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 14:48:37 +0000
X-Gm-Features: AWEUYZnuNraVr6I5i3m0D3BjF8hIuL06pYnzzd_BEQCeqolmWGXrA-CVlPFyblg
Message-ID: <CAFEAcA9NzHeo+V8FpXDBjPK9n2i+LDVCxe1AS8z7O9DX9Cvzuw@mail.gmail.com>
Subject: Re: [PATCH v5] target/arm: Always add pmu property for Armv7-A/R+
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 4 Jan 2025 at 07:10, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property for
> Armv7+. Note that the property is added only for Armv7-A/R+ as QEMU
> currently emulates PMU only for such versions, and a different
> version may have a different definition of PMU or may not have one at
> all.

This isn't how we generally handle CPU properties corresponding
to features. The standard setup is:
 * if the CPU can't have feature foo, no property
 * if the CPU does have feature foo, define a property, so the
   user can turn it off

See also my longer explanation in reply to this patch in v4:

https://lore.kernel.org/all/CAFEAcA_HWfCU09NfZDf6EC=rpvHn148avySCztQ8PqPBMFx4_Q@mail.gmail.com/

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> The "pmu" property is added only when the PMU is available. This makes
> tests/qtest/arm-cpu-features.c fail as it reads the property to check
> the availability. Always add the property when the architecture defines
> the PMU even if it's not available to fix this.

This seems to me like a bug in the test.

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index dcedadc89eaf..e76d42398eb2 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1761,6 +1761,10 @@ void arm_cpu_post_init(Object *obj)
>
>      if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
>          qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property);
> +
> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> +        }
>      }
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
> @@ -1790,7 +1794,6 @@ void arm_cpu_post_init(Object *obj)
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>          cpu->has_pmu = true;
> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>      }
>
>      /*

This would allow the user to enable the PMU on a CPU that
says it doesn't have one. We don't generally permit that.

thanks
-- PMM

