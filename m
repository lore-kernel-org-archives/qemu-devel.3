Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9F6CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtSV-0004Iz-9c; Fri, 15 May 2026 10:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtRt-0004DT-Lt
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:23:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtRr-0008Gu-IY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:23:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so47391385e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855010; cv=none;
 d=google.com; s=arc-20240605;
 b=O/eZVA5hFGWELQgrWCyqo/Fe4MxLsDWsVEsLdZlGuPC74JYq7meRTg7Y8G68aKzm1+
 zt4GMaHq782/oPqERq4NxCG//t6JHJkJD+OBhuHOhdszRA2M8fyhKLhq8c76Pem26kRk
 eUUI1lucGrwlPaM5+WzZeZWvIXaN0r/KESimTjEv57JDSDnBuTsTx9VUHqcnH/5UUktN
 By33t+GXSz96+WWS/ECOzP0WnTV71k0GMLaMSQ32Tt1VsuqIh7RGkfPQBP7j3AT2otuK
 MeHUHIph/7KGV4VHZLvDfMzjTdtmMpfwyx4bDAYt3EZrSOEtZFJKyiHpmBBeC6Z4/khK
 Ejjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pS6+hIU7k2tWi+tHU0YDo8T8AoOJIkTgkEACRJxPM3g=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=dMkrVGhJwluyUUIrhi2AS3mdj5rgP45tybH4GhWkQym8ch/Xe/jE5JGvkbU/xq/27l
 RTi0tWvGBkU/DVZgYo+al53JV9C188lqAgiZmc2LZNyfhy3ZG4mY1cgL33/sXMt1fKll
 ACl4nxu7YYCpC/P1Wr0r76UaT5TyFNhgqfmmT+0QuHQ5NYdQKV6fe14zDjowF4uo8COK
 iAju4qiVvlSwu0Xe82Zql0ycSTTX/w9daoT+iznD4RU2OVVnEea7NMtUgH05KfYUFG+Z
 q5xMPPn9mUpDP0l23Eqe6JUn5MHmGjYlgETUPgTdHDOjXaX02vUVwvPWetvZUk6DgQBJ
 uOJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855010; x=1779459810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS6+hIU7k2tWi+tHU0YDo8T8AoOJIkTgkEACRJxPM3g=;
 b=ITdKyJIbMBcZV/JLpFX/5ZOVwv4fhqCH5zpm3AGZcYqxHbZFwcSvPXveNhHHUgfwJZ
 cWWVI8NZjWQ9nh+yfA/KRlCi+JRWd7Ba+I3rA3rb/xSksLt08arilrwCNMm3ihh0JaDJ
 F7BvDusszhT/WsKWOFoKctLJ5jFc5sK/Y2UPcXGh08eUPCl8SrXgXuF4oqQ+y5O+6KBb
 WDvdSq4yOIdD2pjaH1MhmgD/GsRgK5Pvr/PyiCGLEV5MK3pNutoJpcMY6qR5w2FvBxU1
 VEBZqvvDWjA8cE83oM3S5yh2CLF84dlNgtkdLn2h+W2oqosNd+74wgV++vsBuHMEUAoR
 SrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855010; x=1779459810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pS6+hIU7k2tWi+tHU0YDo8T8AoOJIkTgkEACRJxPM3g=;
 b=Ew73aLVFVWSyQB162LtQvVNLY0iWQOOpFPXH7f+6ydnwm0S6PVeE2oHNQsjfKqNsl5
 CvocrtifiHNBak4IjMzPCexWvsPfpf435/RzdSBGHLpj9VAwGHpi19Hgx32k6L8L4QvD
 lnyEfPaGBAbPjkO+hf3AbrdOYFzf2oXuhWe5BJIws2xt9qboXII5LvpNYc8UJITpcTJo
 PLVopamUyI6mE+bpeINg8bXsdK7a1pWKqxxQS6T59bzMtX0iTV4U9xlLW5BEFIeIzILI
 uWthjIZq9XBW6vyEIocteNPbGVmGcOnb1n18RA+bXeITuDqCnss7FDcZDRcJp+BSkzYD
 aVeg==
X-Gm-Message-State: AOJu0YyY7gEBnFq0hbs56VwdX2BhCwWgXU0cJfQpvFx7gtUPTyoWyqTi
 PXDC7+1jfVydufEUChilf3scsHXHnRsKy2KL9gG92jylEs2K15Zc3/JUv5Gthoz9JjV0B7J5UCj
 EW0xl1wDtNZ01ICjirJ96gDa+SUO2AqkWryNPkV42jg==
X-Gm-Gg: Acq92OFhsvuUefNbIb+D67XK+FBuQkuTqtvFt4mNIqLnYA7RRz3NVoZcPBRqkl43bc+
 O57g3VwTVMs+qh8rU3Ii2sao5Vm+Usl4GgZq6qXAXrNaCTQ2CEyEadNbwmvcwWi/3v/Hr0rJlXy
 5N3Ux67Stqx+u0Ti5ZbqS6ECPWxttpHBL2nLWV90OWqBLTNsRheOBv5/WHfVEP+hvjZsdUN1lp+
 HNwdlnRCXpxsGG3s5HOT7eIxzjHTqn/xSQUD6ClFw1FJV2zZYsLF/tprAMjAvZKDxAWJgbHX5Zh
 BfHI9Q7ki6strsgoxoMpFfpOpA7wOw2h7+nlXAmGJd74Mpbp4w==
X-Received: by 2002:a05:600c:1389:b0:48f:de4e:882b with SMTP id
 5b1f17b1804b1-48fe60e524dmr57072865e9.6.1778855009122; Fri, 15 May 2026
 07:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-11-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-11-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:23:02 +0300
X-Gm-Features: AVHnY4KIvkL0_0vfP15IKf7_TLPd1zEFm2dUQHg-ZrUWyiN0LpAFGxbdNQQFHMY
Message-ID: <CAAjaMXYJr7Xg+0xSVNaxkG+5ykzJCL=uNwpmeN=GYbbGd34ZjQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/20] target/arm: Restrict IDAU interface to TCG
 namespace
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Fri, May 15, 2026 at 5:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Emphasis the IDAU interface is restricted to TCG by

Emphasis?

> moving the header under target/arm/tcg/. Move the
> definition to cpu-v7m.c which also contains v7/v8
> hardware (NVIC), keeping only CPU types in cpu32.c.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  include/hw/arm/armv7m.h     |  2 +-
>  include/hw/misc/tz-msc.h    |  2 +-
>  target/arm/{ =3D> tcg}/idau.h |  4 ++--
>  hw/arm/armv7m.c             |  2 +-
>  target/arm/cpu.c            |  2 +-
>  target/arm/ptw.c            |  2 +-
>  target/arm/tcg/cpu-v7m.c    | 11 +++++++++++
>  target/arm/tcg/cpu32.c      |  8 --------
>  8 files changed, 18 insertions(+), 15 deletions(-)
>  rename target/arm/{ =3D> tcg}/idau.h (97%)
>
> diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
> index 98ad08db036..70555962bb9 100644
> --- a/include/hw/arm/armv7m.h
> +++ b/include/hw/arm/armv7m.h
> @@ -13,7 +13,7 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/intc/armv7m_nvic.h"
>  #include "hw/misc/armv7m_ras.h"
> -#include "target/arm/idau.h"
> +#include "target/arm/tcg/idau.h"
>  #include "qom/object.h"
>  #include "hw/core/clock.h"
>
> diff --git a/include/hw/misc/tz-msc.h b/include/hw/misc/tz-msc.h
> index 07112d8caa3..6cf4c6b09eb 100644
> --- a/include/hw/misc/tz-msc.h
> +++ b/include/hw/misc/tz-msc.h
> @@ -51,7 +51,7 @@
>  #define TZ_MSC_H
>
>  #include "hw/core/sysbus.h"
> -#include "target/arm/idau.h"
> +#include "target/arm/tcg/idau.h"
>  #include "qom/object.h"
>
>  #define TYPE_TZ_MSC "tz-msc"
> diff --git a/target/arm/idau.h b/target/arm/tcg/idau.h
> similarity index 97%
> rename from target/arm/idau.h
> rename to target/arm/tcg/idau.h
> index 0ef5251971d..e5736ad848d 100644
> --- a/target/arm/idau.h
> +++ b/target/arm/tcg/idau.h
> @@ -25,8 +25,8 @@
>   * connected to the CPU using a link property.
>   */
>
> -#ifndef TARGET_ARM_IDAU_H
> -#define TARGET_ARM_IDAU_H
> +#ifndef TARGET_ARM_TCG_IDAU_H
> +#define TARGET_ARM_TCG_IDAU_H
>
>  #include "qom/object.h"
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index a29eab6c915..68a1cbd6316 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -20,7 +20,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/log.h"
> -#include "target/arm/idau.h"
> +#include "target/arm/tcg/idau.h"
>  #include "target/arm/cpu.h"
>  #include "target/arm/cpu-features.h"
>  #include "target/arm/cpu-qom.h"
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 31e0a12a986..76f5909e902 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -24,7 +24,6 @@
>  #include "qemu/log.h"
>  #include "exec/page-vary.h"
>  #include "system/whpx.h"
> -#include "target/arm/idau.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> @@ -42,6 +41,7 @@
>  #include "hw/intc/arm_gicv5_stream.h"
>  #ifdef CONFIG_TCG
>  #include "hw/intc/armv7m_nvic.h"
> +#include "target/arm/tcg/idau.h"
>  #endif /* CONFIG_TCG */
>  #endif /* !CONFIG_USER_ONLY */
>  #include "system/tcg.h"
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8706dd59dd6..a4842a4b62b 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -17,7 +17,7 @@
>  #include "cpu.h"
>  #include "internals.h"
>  #include "cpu-features.h"
> -#include "idau.h"
> +#include "target/arm/tcg/idau.h"
>
>  typedef struct S1Translate {
>      /*
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index dc249ce1f14..02abd831e6a 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -11,6 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "accel/tcg/cpu-ops.h"
> +#include "target/arm/tcg/idau.h"
>  #include "internals.h"
>
>  #if !defined(CONFIG_USER_ONLY)
> @@ -40,6 +41,16 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, i=
nt interrupt_request)
>      return ret;
>  }
>
> +static const TypeInfo arm_v8m_types[] =3D {
> +    {
> +        .name =3D TYPE_IDAU_INTERFACE,
> +        .parent =3D TYPE_INTERFACE,
> +        .class_size =3D sizeof(IDAUInterfaceClass),
> +    }
> +};
> +
> +DEFINE_TYPES(arm_v8m_types)
> +
>  #endif /* !CONFIG_USER_ONLY */
>
>  static void cortex_m0_initfn(Object *obj)
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 2127d456ad6..73d21c6cf7d 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -12,7 +12,6 @@
>  #include "cpu.h"
>  #include "accel/tcg/cpu-ops.h"
>  #include "internals.h"
> -#include "target/arm/idau.h"
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/core/boards.h"
>  #endif
> @@ -899,17 +898,10 @@ static const ARMCPUInfo arm_tcg_cpus[] =3D {
>  #endif
>  };
>
> -static const TypeInfo idau_interface_type_info =3D {
> -    .name =3D TYPE_IDAU_INTERFACE,
> -    .parent =3D TYPE_INTERFACE,
> -    .class_size =3D sizeof(IDAUInterfaceClass),
> -};
> -
>  static void arm_tcg_cpu_register_types(void)
>  {
>      size_t i;
>
> -    type_register_static(&idau_interface_type_info);
>      for (i =3D 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
>          arm_cpu_register(&arm_tcg_cpus[i]);
>      }
> --
> 2.53.0
>

