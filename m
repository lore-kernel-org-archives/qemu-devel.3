Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C00C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnef-0005Ny-DP; Mon, 24 Mar 2025 15:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twnec-0005MY-4o
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:40:11 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twneZ-0006rb-1j
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:40:09 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c08f9d0ef3so265992685a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742845205; x=1743450005; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ySVjG553KjvY2oIxkfB87YzxBkchigFhDIe5ZtXhZ8M=;
 b=FkOhz0ZYvJkvaSHbuWpnkHvEXMYNw1EoWLRARsSmUrTXjbgFLNhzGXMmDuxHcCl3SI
 Kl1oUwFMKcpqAwgKfJe7v6kXQLU6oZne3n3TiMLv3lriX5Ef5onrodonwAbm/PtBF6+B
 0BO0Kfuv8eOV9Yw0XNaEzLdzjg5UmC+w+j+runsr00GpyY1cmQ0qg4Db47T00xPcY2qb
 wSjuJ3bOrZAMbDRI4crXGgOekHPxXqyyFT+HJNcf4EyooEmlUdS2o9UOVsgQy6co0HRP
 I8jZYYqef/f32L0bSU0w8FB+kpgnV/wSKONIaHrfCwhKw7HTu+x2oZWz2+NbX00x/65b
 5npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845205; x=1743450005;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ySVjG553KjvY2oIxkfB87YzxBkchigFhDIe5ZtXhZ8M=;
 b=hpr1AUBJpKupFZMo30Oc7JbJHESs87pPCUkzv6Wy89FL77B1b79k4mLwyxje8mB673
 M2biWJyZb1e1l6l8N3mFl0a6OF428eT/88Zn1YdtAVtgTnfquWu9f1Xp+dMF/oz6bu9L
 4FgQSbWBjbhnoOMImvBalph59vKPFUsHdk23F/q3RHPNo2G0O0Dc7McJVLKA6/1Aw6S4
 qy5DuaCNL1VCZAcSGCnXhak90op7Se1MfpylvfOciWNERMLRV/Aly5KC+pPZ9TT5Xutd
 S/ipY8u2rPxXp/dnZMe32Bi79AiLwX5IMd78ufVWO/rGXxwbaXgxoSWzxdwvL8IcC0hs
 TJJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/c7CYPjWzhTLSyJJGb1lAowHteHC9z9clwB6k33lCD2tiMI+jIixth4Pse9aTWSIfQFOwtRd7QYiW@nongnu.org
X-Gm-Message-State: AOJu0Yx5anbasmdbii0VLDe0CIA8PfyhBsNt2Rh7VNp49M3nhtfyy2In
 IpAW0+isRvKm3gXDJwRrn5pZPMvgnBaId0lmx0iz5QSCksOb+iL0
X-Gm-Gg: ASbGncuPXUvV4DbIBLTYCC15IWm8FcPwENkeLF9s2QoAkBsnuVPyLZQvr5/lmIlbO5Z
 Udx8B+/9QvJOSM5uads2y0KSmCxnAw2BW/7n9rzpcv+9An13xcS086B4jcJYlS93MPDFQ/krbZV
 nU8hK0rBDtuwO7KRkGDrWXNrLKO6qJjaTcQluAWBY0S+WhYwCGURmhyx01TzF7wxLuSBntJTWiS
 DI4NbGSJRQrNlXPb8dkKcJsr+V2lPJZM7/zWi+ycV1/QjgKNe8i1rjxDXnjB7nboUq0VLIUSafQ
 lgCw9uCeTda8cL/g53szdAU8BEDOlA13AO++0ozzoedmV3yPXy1hUC9bkSh3FqE=
X-Google-Smtp-Source: AGHT+IH3BRFEC3FjwTGnob+8lH4Zd2lhzKf/fqGF2r8ouUEs7RhI9Nm1dvADVVJN5T22hFgo/eEf8w==
X-Received: by 2002:a05:620a:40c7:b0:7c5:460d:45de with SMTP id
 af79cd13be357-7c5ba133d4cmr2188809785a.8.1742845204913; 
 Mon, 24 Mar 2025 12:40:04 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:319a:7f6b:e6fe:90fa])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm543529985a.61.2025.03.24.12.40.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:40:04 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Damien Hedde'" <damien.hedde@dahe.fr>,
 "'Paolo Bonzini'" <pbonzini@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301172045.1295412-2-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 1/8] hw/intc: Add l2vic interrupt controller
Date: Mon, 24 Mar 2025 14:40:02 -0500
Message-ID: <04b401db9cf4$8a44ce80$9ece6b80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQBnRK9gH0BRY5vrCSddsvIJtQ/qNAJ3v9YTtleXY3A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250324-4, 3/24/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Saturday, March 1, 2025 11:21 AM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Damien Hedde <damien.hedde@dahe.fr>; Paolo
> Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/8] hw/intc: Add l2vic interrupt controller
>=20
> From: Sid Manning <sidneym@quicinc.com>
>=20
> Co-authored-by: Matheus Tavares Bernardino
> <quic_mathbern@quicinc.com>
> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                    |   2 +
>  docs/devel/hexagon-l2vic.rst   |  59 +++++
>  docs/devel/index-internals.rst |   1 +
>  include/hw/intc/l2vic.h        |  37 +++
>  hw/intc/l2vic.c                | 417 =
+++++++++++++++++++++++++++++++++
>  hw/intc/Kconfig                |   3 +
>  hw/intc/meson.build            |   2 +
>  hw/intc/trace-events           |   4 +
>  8 files changed, 525 insertions(+)
>  create mode 100644 docs/devel/hexagon-l2vic.rst  create mode 100644
> include/hw/intc/l2vic.h  create mode 100644 hw/intc/l2vic.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 804c07bcd5..a842f7fe1b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -232,6 +232,7 @@ Hexagon TCG CPUs
>  M: Brian Cain <brian.cain@oss.qualcomm.com>
>  S: Supported
>  F: target/hexagon/
> +F: hw/intc/l2vic.[ch]

Consider naming all the files outside target/hexagon as hex_* or =
hexagon_*
That will make it clear they belong to hexagon and you can use an easy =
wild card in the MAINTAINERS file.
Ditto for the docs files.

>  X: target/hexagon/idef-parser/
>  X: target/hexagon/gen_idef_parser_funcs.py
>  F: linux-user/hexagon/
> diff --git a/include/hw/intc/l2vic.h b/include/hw/intc/l2vic.h new =
file mode
> 100644 index 0000000000..ed8ccf33b1
> --- /dev/null
> +++ b/include/hw/intc/l2vic.h
> @@ -0,0 +1,37 @@
> +/*
> + * QEMU L2VIC Interrupt Controller
> + *
> + * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
> +
> +#define L2VIC_VID_GRP_0 0x0 /* Read */
> +#define L2VIC_VID_GRP_1 0x4 /* Read */
> +#define L2VIC_VID_GRP_2 0x8 /* Read */
> +#define L2VIC_VID_GRP_3 0xC /* Read */
> +#define L2VIC_VID_0 0x10 /* Read SOFTWARE DEFINED */ #define
> +L2VIC_VID_1 0x14 /* Read SOFTWARE DEFINED NOT YET USED */ #define
> +L2VIC_INT_ENABLEn 0x100 /* Read/Write */ #define
> +L2VIC_INT_ENABLE_CLEARn 0x180 /* Write */ #define
> L2VIC_INT_ENABLE_SETn
> +0x200 /* Write */ #define L2VIC_INT_TYPEn 0x280 /* Read/Write */
> +#define L2VIC_INT_STATUSn 0x380 /* Read */ #define L2VIC_INT_CLEARn
> +0x400 /* Write */ #define L2VIC_SOFT_INTn 0x480 /* Write */ #define
> +L2VIC_INT_PENDINGn 0x500 /* Read */ #define L2VIC_INT_GRPn_0 0x600
> /*
> +Read/Write */ #define L2VIC_INT_GRPn_1 0x680 /* Read/Write */ #define
> +L2VIC_INT_GRPn_2 0x700 /* Read/Write */ #define L2VIC_INT_GRPn_3
> 0x780
> +/* Read/Write */
> +
> +#define L2VIC_INTERRUPT_MAX 1024
> +#define L2VIC_CIAD_INSTRUCTION -1
> +/*
> + * Note about l2vic groups:
> + * Each interrupt to L2VIC can be configured to associate with one of
> + * four groups.
> + * Group 0 interrupts go to IRQ2 via VID 0 (SSR: 0xC2, the default)
> + * Group 1 interrupts go to IRQ3 via VID 1 (SSR: 0xC3)
> + * Group 2 interrupts go to IRQ4 via VID 2 (SSR: 0xC4)
> + * Group 3 interrupts go to IRQ5 via VID 3 (SSR: 0xC5)  */
> diff --git a/hw/intc/l2vic.c b/hw/intc/l2vic.c new file mode 100644 =
index
> 0000000000..9df6575214
> --- /dev/null
> +++ b/hw/intc/l2vic.c
> @@ -0,0 +1,417 @@
> +/*
> + * QEMU L2VIC Interrupt Controller
> + *
> + * Arm PrimeCell PL190 Vector Interrupt Controller was used as a =
reference.
> + * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
> +
> +#include "qemu/osdep.h"
> +#include "hw/irq.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/intc/l2vic.h"
> +#include "trace.h"
> +
> +#define L2VICA(s, n) (s[(n) >> 2])
> +
> +#define TYPE_L2VIC "l2vic"
> +#define L2VIC(obj) OBJECT_CHECK(L2VICState, (obj), TYPE_L2VIC)
> +
> +#define SLICE_MAX (L2VIC_INTERRUPT_MAX / 32)
> +
> +typedef struct L2VICState {
> +    SysBusDevice parent_obj;
> +
> +    QemuMutex active;
> +    MemoryRegion iomem;
> +    MemoryRegion fast_iomem;
> +    uint32_t level;
> +    /*
> +     * offset 0:vid group 0 etc, 10 bits in each group
> +     * are used:
> +     */
> +    uint32_t vid_group[4];
> +    uint32_t vid0;
> +    /* Clear Status of Active Edge interrupt, not used: */
> +    uint32_t int_clear[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* Enable interrupt source */
> +    uint32_t int_enable[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* Clear (set to 0) corresponding bit in int_enable */
> +    uint32_t int_enable_clear;
> +    /* Set (to 1) corresponding bit in int_enable */
> +    uint32_t int_enable_set;
> +    /* Present for debugging, not used */
> +    uint32_t int_pending[SLICE_MAX] QEMU_ALIGNED(16);

Consider using DECLARE_BITMAP32 since you use =
test_bit/set_bit/clear_bit.
Are these alignments needed?

> +    /* Generate an interrupt */
> +    uint32_t int_soft;
> +    /* Which enabled interrupt is active */
> +    uint32_t int_status[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* Edge or Level interrupt */
> +    uint32_t int_type[SLICE_MAX] QEMU_ALIGNED(16);
> +    /* L2 interrupt group 0-3 0x600-0x7FF */
> +    uint32_t int_group_n0[SLICE_MAX] QEMU_ALIGNED(16);
> +    uint32_t int_group_n1[SLICE_MAX] QEMU_ALIGNED(16);
> +    uint32_t int_group_n2[SLICE_MAX] QEMU_ALIGNED(16);
> +    uint32_t int_group_n3[SLICE_MAX] QEMU_ALIGNED(16);
> +    qemu_irq irq[8];
> +} L2VICState;
> +



> +
> +static void l2vic_set_irq(void *opaque, int irq, int level) {
> +    L2VICState *s =3D (L2VICState *)opaque;
> +    if (level) {
> +        qemu_mutex_lock(&s->active);
> +        set_bit(irq, (unsigned long *)s->int_pending);

Here's an example of the set_bit mentioned above.

> +        qemu_mutex_unlock(&s->active);
> +    }
> +    l2vic_update(s, irq);
> +}
> +
> +static void l2vic_reset_hold(Object *obj, G_GNUC_UNUSED ResetType
> +res_type) {
> +    L2VICState *s =3D L2VIC(obj);
> +    memset(s->int_clear, 0, sizeof(s->int_clear));
> +    memset(s->int_enable, 0, sizeof(s->int_enable));
> +    memset(s->int_pending, 0, sizeof(s->int_pending));
> +    memset(s->int_status, 0, sizeof(s->int_status));
> +    memset(s->int_type, 0, sizeof(s->int_type));
> +    memset(s->int_group_n0, 0, sizeof(s->int_group_n0));
> +    memset(s->int_group_n1, 0, sizeof(s->int_group_n1));
> +    memset(s->int_group_n2, 0, sizeof(s->int_group_n2));
> +    memset(s->int_group_n3, 0, sizeof(s->int_group_n3));
> +    s->int_soft =3D 0;
> +    s->vid0 =3D 0;

How about a single memset(s, 0, sizeof(L2VICState))?

> +
> +    l2vic_update_all(s);
> +}


