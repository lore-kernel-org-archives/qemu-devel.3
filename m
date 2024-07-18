Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25E9C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPwe-0005Bb-5R; Thu, 18 Jul 2024 08:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUPwX-0004vJ-Hj
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:09:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUPwU-0000F2-Mg
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:09:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368380828d6so489674f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721304523; x=1721909323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GLztguu0/1A4o5v5HJNeEefOunzrp4ZbpPmNFDAgcPg=;
 b=nWsQzqkhZIrqgzx6v/f3tpUREwcihXC/VXt4IE6otDDF5e3leMAQEsxt2ufdkFD+z+
 SNrPmNe5nRnyCN061nGQE7y9XMX/wyPCHZFUePPG3PpaXQ/AEi43ejOTkABso8zgwrPG
 1jSSdVFU9votgGmw7H5Iydc3BOiBzs7o+Gb7rBwe3I0o12TCwCQqa+jnEiYGRbUHUhsX
 E3kZNJ9tfFu0AIhc6E+Iyrc+VamecmU0wCr4qhSsVabf7zZRQpojQOpGqKQQLzn/LdQZ
 HPS6yXkbOeK5HvaaYHocLw4I5zvOLPgVMdwYtP+8PzAXCtN3DbHUHOJaTiK4djGY86ef
 vVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721304523; x=1721909323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLztguu0/1A4o5v5HJNeEefOunzrp4ZbpPmNFDAgcPg=;
 b=rX1mqD1qAjhS487Xe2vGVEJ6xCQ81jU+CFh7naC/NvPr3dM64SGTHYRKOvHCGg7A8p
 N5XRL5P/LolOEm7l94ulv89cZ7/2+YmYNGpWhHN4hXiZ1e6ezapDEUUs8YE+9z102EUe
 HTI9fv83VGMWzosYc5I120t4RbSSoTrR/FIpn3ZBZmKbW6tQE8AeM1dLWwlf7raB/R5u
 oE1xvz4YMTDpGz+iS4AUuNaZIlZEcDwTigqHVyS/+yg4YEHRhQrDmSUK/Bx5FJFyFNnt
 HHHH1iddja4soTRxKU8X+Ox4BzHU1NMoMw5FyT+bpsr895FBVxQKFEhuaLTK9NYX1Ae+
 mr1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQy/YuSDuXrtL0vBVzO3Pjq6tr2IX6+rUuZXmM0HYsQnPqaxJw7S7Wj5tNVXFouHKAujRNobMEvgGziEXjaOwi3N3TMvU=
X-Gm-Message-State: AOJu0YyPq2AQIP5IS5YEBnN9C7EKSb85kdOJkfuNgcwfas4UPh25YIUY
 0aprRlQTTh8bc78g7Mu6nuqp2K2fENVzvlYbkg+4jpCZ7oVB5CAzdflTGnRkJS17AhmR7KWTMp+
 y6t8qhxPiVnuuGLaeU3r/Bk8H2EJVlV1jOvmg+g==
X-Google-Smtp-Source: AGHT+IFZi/ClEd1999CMZYBhdXDHi2vXXiykQQ5Z65X5NS9p1qChrm7Xj9mXD3K9UBh7qPuKeG1NYWHBprbDW8HJ3DU=
X-Received: by 2002:a5d:54d2:0:b0:367:8847:5bf4 with SMTP id
 ffacd0b85a97d-368315f3197mr3207156f8f.10.1721304523412; Thu, 18 Jul 2024
 05:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
 <20240716-pmu-v3-3-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-3-8c7c1858a227@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 13:08:32 +0100
Message-ID: <CAFEAcA-5J-ra-gHTcC54eOP9qUFCtXzKhePhkRhjj=Q7HyFqVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] target/arm: Always add pmu property for Armv8
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

On Tue, 16 Jul 2024 at 13:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property for
> Armv8. Note that the property is added only for Armv8 as QEMU emulates
> PMUv3, which is part of Armv8.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 14d4eca12740..64038e26b2a9 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1744,6 +1744,8 @@ void arm_cpu_post_init(Object *obj)
>      }
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
> +        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> +
>          object_property_add_uint64_ptr(obj, "rvbar",
>                                         &cpu->rvbar_prop,
>                                         OBJ_PROP_FLAG_READWRITE);
> @@ -1770,7 +1772,6 @@ void arm_cpu_post_init(Object *obj)
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>          cpu->has_pmu = true;
> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>      }

This regresses the ability to disable the PMU emulation on
CPUs like "cortex-a8", which are not v8 but still set
ARM_FEATURE_PMU.

thanks
-- PMM

