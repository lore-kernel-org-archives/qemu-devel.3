Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43102CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsWS-00031m-FI; Tue, 26 May 2026 10:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsWO-00031W-Ut
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:12:41 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsWN-000469-3b
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:12:40 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so10462655d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804756; cv=none;
 d=google.com; s=arc-20240605;
 b=RJCXubd5DDteL4bc5/+04DwUczdZBN5uTpaE1AurtBDb4WbsheU+v0xHvj0sy2yTbt
 XgFV7bXtqx7Oua5kTkrBkG0Q0o32p+AKxRbo4WQVwa5onimF5ftLf8RAwLveb1IzXDYY
 FG2BU9gkqq0FbCRs0AptbDaJru2KWKiZhxsYT85b7YV3nU7C1xssFoi3I1JYX/lbJSsj
 mdAqlsREXCjr4cFuko4ZmKVMXK8ax2wif5D9it8BuVUiaqWgFF9D2W8Lx/crxVrYJTMX
 BFJI/TkxB4aUIWDkGcRBW/qjWEBu4mikH9tsQH2+wecJlYtI5m+V1ovfGMtd6/wcRrSN
 iI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VBeifboEUg5LMYpz9aI8MoR3EAQZCeF3gbfvGQLX/VU=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=ZmmORo3JrgXPZ/BukXzMyrENsNXMVRybjpF+fNKw2QYqr0hAsU/dnvHlO+tpG7VGQ+
 iQxVU6DYAjCblkXYSi+Dt9UN6HJqOKKEeMMgKOQx6JQdjTtvUV08Qdw1ZQZVU8stUxrT
 IHdVaOcFPfFhpcMJDmFpscAm4wL8uRplWCGUX04/fCgtRYF3BPtvBodG+0arV1BgXeGq
 WoFfybWFDQ6jhknTq91n5rtvjBs7ey8ZE8NJzDxmPR+Stg52SFn1P5PUz5ly5WzRoEv7
 IDElmF0+WoHNJYaNyfUdvYSBio+7Jkcm8BIRjpusGHiBY4fN1/g2YnvUtLZrmPhM0oVx
 KH5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779804756; x=1780409556; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VBeifboEUg5LMYpz9aI8MoR3EAQZCeF3gbfvGQLX/VU=;
 b=Dz6aZRtj334C8EDcRf8CCNffw51HTS1hdsIzHVKHJX6gjpAN5txsMDzmmNwLWK+Sr7
 WF+eCat3EO63DY6Csv33R+a5V0KaITM/EAbyfQwHBhwqPAKMLSUyf+VBQgbBUbIPIxmS
 mul5HdIEQEQqy8keqZRyu9nVlUYEtovGdw5kBu1ZMjYYZQa9wEioLKazxAjzwz95mJj6
 K4pcoBwHQoyUqyhyQnU8jr/nKM5md5n+qCWQbuR8VZGiPreDVlWrfECLNB3ePQSbl5Gk
 nW/9p8XUJ15+Kn2CLBxPZ2T79FGcaD45QTBi5w1d16Ylwv7jgg2h1GhJ5bg2Fz9E/cJJ
 S2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804756; x=1780409556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBeifboEUg5LMYpz9aI8MoR3EAQZCeF3gbfvGQLX/VU=;
 b=BufCqQZlvV537mKcmNnblQf10bKpQXphSxW3GVTrT9ywmvdGAJRj1TN3UCgepzH5/P
 9jFWaqfq/WCfXSJ94FZ1nq3+PDcWKw7u2lsMwoYaDBazzTcJEtuwbqkIHAfql/kZCapO
 +6EUErmZ1FweucotUmONPWpo4SdV5M3WBEJkn54bYfmeZa1jK+lTX3qRpjuXeCevROsC
 mxPNzTmy+lV6q8+ddw/YYrVw6IIav9UleobCqEEqbbLVhV9pcu6YO8UbTAAQ+aRLOPeW
 nf1XX+swPIbDk0KXKgE5JkLcnngV5pXnFgG0Nfuj7tnNWTi7I38nQmj/VPf9lM7AY30U
 Okog==
X-Gm-Message-State: AOJu0Yy1K1nBdnruQCxey6KpRft510cawIl2ER0msP+WrZY9r1MOtvQq
 N5BOaiW2eGUa4ZDHIzupKe1gSeE7kT/4WsYrPLBWzyGq6psV2jJFLKzuny7HXm1t9JBJxixu9Up
 e3jWoDEcNf+nhrrtUwemOx3q1VlwLIUZM+8z6R/B4nw==
X-Gm-Gg: Acq92OEP+EhRKy/tOCBg2DO1l5DicbbEhJLYa/2ccAHQMyDy69+O4LKNRbQgZsZWdzb
 S1+3KMRQm9JsrXwtjBo9R8PQuWpzIbqKl9HNaYAbRKVSXfqv2o4kH8LiPgQBxNVHNx4VLVVOuQs
 4e6vaf+NiCtznWO7itFTN+1ypPZoSGcMscKr2pl/0qdC39CW+tedsiukZ7TUQcZLT/2/qKz9foV
 8ZZmHc2u8NvRa46J5zmsRVmY5Osypjy64IAJgMFEmUemIQA9orZKBODNFTDS4SUY0/hKHPpAvzz
 kdmdotGDt7sklcnG6GXSgrpq5gRacrxYqDyWwNWSH321IYPpPCAwM3kLqnzcU4UP+O0=
X-Received: by 2002:a05:690e:4853:b0:64e:f106:60e5 with SMTP id
 956f58d0204a3-65ec995b17fmr14464261d50.52.1779804756212; Tue, 26 May 2026
 07:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260430091832.1846637-1-kchiu@axiado.com>
 <20260430091832.1846637-3-kchiu@axiado.com>
In-Reply-To: <20260430091832.1846637-3-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 15:12:24 +0100
X-Gm-Features: AVHnY4KFyizzwLCkuG1bpkpK_RXFCAOR2SF2YweMOszuwGis1xF0awyMNtecR0I
Message-ID: <CAFEAcA9qQt+HVqZGtH4mjP0sBv9Jxrs3JS+gBHaMevTdYFq+ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/arm: Add Axiado EVK SCM3003
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 30 Apr 2026 at 10:19, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Add EVK axiado-scm3003 built with AX3000 SoC
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>  hw/arm/Kconfig                 |  5 ++++
>  hw/arm/ax3000-boards.c         | 52 ++++++++++++++++++++++++++++++++++
>  hw/arm/ax3000-evk.c            | 27 ++++++++++++++++++
>  hw/arm/meson.build             |  3 ++
>  include/hw/arm/ax3000-boards.h | 28 ++++++++++++++++++
>  5 files changed, 115 insertions(+)
>  create mode 100644 hw/arm/ax3000-boards.c
>  create mode 100644 hw/arm/ax3000-evk.c
>  create mode 100644 include/hw/arm/ax3000-boards.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4fb23122fd..e569d8ee9e 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -699,3 +699,8 @@ config AXIADO_SOC
>      select CADENCE # UART
>      select AXIADO_SDHCI
>      select UNIMP
> +
> +config AXIADO_EVK
> +    bool
> +    default y
> +    select AXIADO_SOC
> diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
> new file mode 100644
> index 0000000000..cadbac8edc
> --- /dev/null
> +++ b/hw/arm/ax3000-boards.c
> @@ -0,0 +1,52 @@
> +/*
> + * Axiado Boards
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/ax3000-boards.h"
> +#include "hw/arm/machines-qom.h"
> +#include "qemu/error-report.h"
> +#include "qom/object.h"
> +
> +static const char *ax3000_machine_get_default_cpu_type(const MachineState *ms)
> +{
> +    return ARM_CPU_TYPE_NAME("cortex-a53");

There's no point in having a function just for this; you can use
  mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a35");
without the indirection.

> +}
> +
> +static void ax3000_machine_init(MachineState *machine)
> +{
> +    Ax3000MachineState *ams = AX3000_MACHINE(machine);
> +
> +    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);

The machine init function for an Arm board always needs to end
by calling arm_load_kernel(). As well as implementing the handling
for the -kernel "load this kernel/image file" option, it also
sets up some things like getting CPU reset to work correctly.

> +}
> +
> +static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->init = ax3000_machine_init;
> +    mc->default_cpus = AX3000_NUM_CPUS;
> +    mc->min_cpus = AX3000_NUM_CPUS;
> +    mc->max_cpus = AX3000_NUM_CPUS;
> +    mc->get_default_cpu_type = ax3000_machine_get_default_cpu_type;
> +}
> +
> +static const TypeInfo ax3000_machine_types[] = {
> +    {
> +        .name          = TYPE_AX3000_MACHINE,
> +        .parent        = TYPE_MACHINE,
> +        .instance_size = sizeof(Ax3000MachineState),
> +        .class_size    = sizeof(Ax3000MachineClass),
> +        .class_init    = ax3000_machine_class_init,
> +        .interfaces    = aarch64_machine_interfaces,
> +        .abstract      = true,
> +    }

Do you really expect to have a lot of boards which are
all different subclasses of AX3000? Unless you really
need this, better to do the simple thing and implement
the MACHINE_TYPE_NAME("axiado-scm3003") without the extra
layer of class structure which is doing nothing at all.

thanks
-- PMM

