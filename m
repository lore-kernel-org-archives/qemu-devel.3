Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C78FE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ47-0003lO-HN; Mon, 29 Dec 2025 14:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ41-0003dM-Pr
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:58 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ40-0000FL-4B
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:57 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4edb8d6e98aso4444431cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037075; cv=none;
 d=google.com; s=arc-20240605;
 b=PmVUussFUJYIvSLN/xNSnNDYp9HN54afDHsEZkhEyLghTgc8KFPQBY9wVBKvgb5dm1
 h9AILOuNi+583fH/wIbaabPvtm+zqvwAuaR1ZtTqtTEcUSCH4UtqCFwjeG3fbephQb36
 xqgh6EQNiiqHKd3ELZtLGyrxWaolUBxmHFQkD2gTKp7vxJ+vgQHL88BVVGTJmKVRJy6O
 5k0mGk2Lp9KdMErUw3D8eK4lwyNUFVbj0v5R9LQZoD1eCPD7aeahFJtfdvbgfw3mTPeH
 W5BPViPSNjtq0/rnpglSE/PH2QxtMv/qHH6NojKx8GmhLvilTkzBQhfiUaaa+YIsa/X4
 Vctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BNytO7cdekShERP/NUifZdg59yBYmK6PZXPjLqQETPk=;
 fh=aV50DOPZ8U7d7TlrV/yC1arnGA9WAyWMgFzt7hEqegw=;
 b=NrihfWwwBbDFQ3IseYEkEpgTIAGnL0k4elOIhpG4u3tanFeLlZZ8H90mqPoAybvGcy
 M8dviXRosg7lfOhM4hZuAW50WAiWYAganXpm1ab/qiLAJTx9yfKWV91wvAcBYkAjPIov
 QTuyTd3iacnDi+9VeD5neTAGviR33x9xpn/JizUmm/fE5zWLWe7U62qthClyBqbdZ0OZ
 /dSrZZYXZOz11YxnFb/i9NgZMYTKw3efl8TdkdSBjXcHWcec9p1dKn4PBxxDglQUJQJo
 gkomf623JHSECZzhzJ8ChSbpfGWt3MTYc27P7005vKnVOgmHU/wUW0EuXDoVKTdDFLmY
 TWDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037075; x=1767641875; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNytO7cdekShERP/NUifZdg59yBYmK6PZXPjLqQETPk=;
 b=YtGR49szDAWost0fR33H/SdHWg0fgdZ9ZTGKOlynV8wHr+Y3rYKkpQKQapCqntFcn4
 BwOn8UoX5l6gXbdsnA1V1+YEYoMFYADd3J1zGfN54OgH6DMMl9u5Cwc1i6oxhgNN4/Qb
 jqZcNFPvM67LMYU4EAc1BQoMppVRpbW7YFnjMIL3td/DEWNtamfo40SbKEW7454ksMLE
 4nm+33dj6Eo4IAJiV49uJRyyE103D5YrHbRT8VwQra1PsHMTUUShaqUvygP3A0ZGvT7i
 zp+A0BuGZhzwFu0cWpgLas5fENuuw/cYqvu2x7QLt4zA7cgR5h969ZzOnO0KqQN96RO6
 FkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037075; x=1767641875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNytO7cdekShERP/NUifZdg59yBYmK6PZXPjLqQETPk=;
 b=JujO5CApWbqUw79uMJNesHm2KsWolAoVQljxkO9qz2PWGPLSNgBpkIH3ncuuvn/zkL
 qsU66NlEp4r1hme73GAQHglpCjyBTnKJ13MNPtR4gA9QZwV12aXQBcGGjhUyVJMrqMic
 LpkulRD5IeIFCKhguEQqkRhvDt9Nt72GVRCmVSSFxn0pBPHOtweST9bExOcFCQ0/N5QQ
 1Xb6ThEFDVK5ZJqpdCJXlgQVh3hOEJYFx9hY6/737mFP5v0HiDkjzW8HZtTIfy65wA2h
 CjnU7Nbf7AwJMR21VlmeKs2HJ6cXUaSWe8to26tsljIuTTRhHvzYq9jDf7M9+VFc10/K
 oakA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGfNByOaKcQFK7W6ZEKZOmELwijFAsdTsBNrFHvbh3VZ66d7q1Ceanbwo2FmzTxkc2E7R8rIq3nb+n@nongnu.org
X-Gm-Message-State: AOJu0YxZsV6qLWW5J8viAKA2lUyqtYWDjND2NvELqzqBzwkX2Kop3aiG
 37Jx3Ht7mnozEkK8tTcjg0jNaKPrTyT4yyYMvt4uoCF2XOebfw6j8GL3YqY1PC+YHaB1LNUdr4K
 nJ5Hue1xqfjJFKabcwifIK34WgDFtJOhNGlBbWTdQ
X-Gm-Gg: AY/fxX6LAvX9fCIoYkRolPHJzmXRDBudFFlZI5HL1wbGTTIUBnt5YMGWhQFJPdhZKmv
 B2m6XzNbkMLrjHCsp1BlpKqhL6d1i7fripxaGhHcZMCr1s3uQDpAOqK/5zg+y/ntNK6uCBiJfUH
 t+ICOL9sHeEH/ijgkmbGAAZ8tRjaAis7AK7TdZxRVtM4bT8NfQ7huIT1JRq0lyTGpJwLvJnZFkJ
 K7sO8SWkEtTfKE/aaOO506YgdsZeHzA1eJ4hztmWOrNbD/XLBiGAWcDfICzT4VgmtExKhLmf3iQ
 p1of2amSenRKGmWKMc24jH4s6g==
X-Google-Smtp-Source: AGHT+IFiyFpQYSOTfcJ/8n71wmHYit33YRiBjX3a0I5VR6xY4a/cLA6LO1ibTrXnGkT1qsqj0gpWcfXTmKE7JCDBZvo=
X-Received: by 2002:ac8:5808:0:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4f4e5f731bcmr38412241cf.9.1767037074458; Mon, 29 Dec 2025
 11:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-5-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-5-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:37:43 -0800
X-Gm-Features: AQt7F2rbJJ6-FnZcQd3_U7ZtCMdFz3B1czUqAtA1wSfVYW5meIqSyqJom3bsF9U
Message-ID: <CA+QoejX3vMnho-crWmvC80uv+SsdrYgvq8u4E7DDyk8MoMbxXw@mail.gmail.com>
Subject: Re: [PATCH v4 04/19] hw/arm/aspeed: Add AST1700 LTPI expander device
 model
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Tue, Dec 23, 2025 at 5:42=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.com=
> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Introduce a minimal QEMU device model for the ASPEED AST1700, an
> MCU-less I/O expander used in the LTPI topology defined by the
> DC-SCM 2.0 specification (see figure 2):
> https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
>
> This initial implementation includes:
>
> * Definition of aspeed.ast1700 as a SysBusDevice
>
> * Setup of a basic memory region to reserve I/O space for future
>   peripheral modeling
>
> This stub establishes the foundation for LTPI-related device emulation,
> without implementing any functional peripherals at this stage.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  include/hw/arm/aspeed_ast1700.h | 23 ++++++++++++++++
>  hw/arm/aspeed_ast1700.c         | 47 +++++++++++++++++++++++++++++++++
>  hw/arm/meson.build              |  1 +
>  3 files changed, 71 insertions(+)
>  create mode 100644 include/hw/arm/aspeed_ast1700.h
>  create mode 100644 hw/arm/aspeed_ast1700.c
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> new file mode 100644
> index 0000000000..2a95ebfe89
> --- /dev/null
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -0,0 +1,23 @@
> +/*
> + * ASPEED AST1700 IO Expander
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ASPEED_AST1700_H
> +#define ASPEED_AST1700_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_ASPEED_AST1700 "aspeed.ast1700"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
> +
> +struct AspeedAST1700SoCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +};
> +
> +#endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> new file mode 100644
> index 0000000000..bb6ca2ce9e
> --- /dev/null
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -0,0 +1,47 @@
> +/*
> + * ASPEED AST1700 IO Expander
> + *
> + * Copyright (C) 2025 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-core.h"
> +#include "qom/object.h"
> +#include "hw/arm/aspeed_ast1700.h"
> +
> +#define AST2700_SOC_LTPI_SIZE        0x01000000
> +
> +static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +
> +    /* Occupy memory space for all controllers in AST1700 */
> +    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
> +                       AST2700_SOC_LTPI_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void aspeed_ast1700_class_init(ObjectClass *klass, const void *da=
ta)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D aspeed_ast1700_realize;
> +}
> +
> +static const TypeInfo aspeed_ast1700_info =3D {
> +    .name          =3D TYPE_ASPEED_AST1700,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(AspeedAST1700SoCState),
> +    .class_init    =3D aspeed_ast1700_class_init,
> +};
> +
> +static void aspeed_ast1700_register_types(void)
> +{
> +    type_register_static(&aspeed_ast1700_info);
> +}
> +
> +type_init(aspeed_ast1700_register_types);

nit: missing trailing empty line.


> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index aeaf654790..175942263d 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -70,6 +70,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>    'aspeed_ast10x0_evb.c',
>    'fby35.c'))
>  arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true=
: files(
> +  'aspeed_ast1700.c',
>    'aspeed_ast27x0.c',
>    'aspeed_ast27x0_evb.c',
>    'aspeed_ast27x0-fc.c',
> --
> 2.43.0
>

