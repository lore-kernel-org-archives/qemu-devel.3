Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E2CE7BD8C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwCh-0008Ut-IQ; Mon, 16 Feb 2026 05:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrwCW-0008UG-VW
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:51:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrwCT-0002Iy-Pb
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771239089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiwLmYj3ETRaXjAqrJhshp93bMiXKIxOG7IVj8R6gNk=;
 b=Pc0bIySUsMkp88pzpmXvvWR+1TToK/xgJVEagq4qoPtq0CW4kgADQjpkgl//5xNqDzLpMq
 fkASb+Z5T/24TqcDd2RA7nvVglJWeQuesfEXCnzA5MXNLd8SwNkuU0RsGKmF6x6YYXf7PL
 cMyngvDqSNQvwOxQEs7pzm8qdD3ut5c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-qvlYLEw4M4q1LQ-Ou5KHzg-1; Mon, 16 Feb 2026 05:51:28 -0500
X-MC-Unique: qvlYLEw4M4q1LQ-Ou5KHzg-1
X-Mimecast-MFC-AGG-ID: qvlYLEw4M4q1LQ-Ou5KHzg_1771239087
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-896fae40578so275951986d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 02:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771239087; cv=none;
 d=google.com; s=arc-20240605;
 b=KKagCaTmYU5n3cqq7Hoz8BMKwX1RwI9/Pw+8Te40jaKH8e5ogybjDBJ5N0PUQW7yd4
 jDzNuqQSphoIxm6BhZQBFU2xFk4Mk1/YjR1sI8gGCVIPR8fFNRSM69mKlybKzhRP4X0S
 2lUEDfvReuJH6yWUJYgR8oCh9LPlrB96XFPYZ4x5+ZEw6EKsRgoDP1gwx+hdFZFJVt0M
 tiOjYDyYO3urlBV234wpcEah8fjh7xRLP9Z0Aan065CUDI405g0qnMg72m4uTmhYnCeL
 4PLIhDnFqf5XELvXQsvk0KUfRv6DdGD1qpPO4TB/N3shFEoMxFmU6NiXiUIZbLNpRIde
 9MMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BiwLmYj3ETRaXjAqrJhshp93bMiXKIxOG7IVj8R6gNk=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=Lj/wOor+iAUwKWQ6gP3ZizmkAYddNl6h5bbZIYAdjWSRA17giJftUXi6vM4OGUhnVs
 v06EuX50OSK9stdOTzFuczRBBKWWJ7sMbXR4cDp1s2dnYtpMtSFfCT5HerP+xCrvJOBO
 Q96gR/9rlUUok+foKnsezbDu6461OQ3lSbBdpdD98c1c+tDYAxhsahEFoxHFODHj1KCj
 7Hu7UqdhODT3VnamU+r0j/VCuUQ2zV7t6jnZrp9YqPCe/nSFP5PTyA5N3vN9q7s8MO1M
 UDzmwgoBpv15YFe5jxel8dyVAulU5OwpLdo0g1alCpdtENXnRj2/dLPXFYHgKIybn2TD
 atgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771239087; x=1771843887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiwLmYj3ETRaXjAqrJhshp93bMiXKIxOG7IVj8R6gNk=;
 b=X7dHOevJCFRPoWzEpOhD1a3hxA1GqdW41Qkvs0RnVMa9H6o2ZfgTtMiyFYiwzqhwdI
 LrJtzR17wXw6/THMCwUyHg9UB0l+4OeOV2EaZUNS/lQcu1DJxxBx5NLrblUsgDpy2TUK
 60qX/TQznHt4xsqgwLVE8IKPi9w6iCb3jcmfdXOEwD564t6fCaZeFWBBp55nf3Dl7ORY
 So8V+Ru+a3KE0UfwRj4nCO9v4BrjRV3BnITMXbjhGYxAnxljzyX1afOxsuaDdjxhXZsi
 t9GVKsElQVmhVyWO7BnNxIPm74hKk/0aCn4IXOkS/L/hWTL+AmDh+XK3lD7bTL/BqnxC
 3yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771239087; x=1771843887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiwLmYj3ETRaXjAqrJhshp93bMiXKIxOG7IVj8R6gNk=;
 b=X36YRG7NoFuCwytrdl550w/G1tsZ79GCC8+KBjAq41+tTIcG9jWC3OU3iavBl4jmHw
 uu1fYksNMRN92xCmv92pplKGjhPxUjx7jClK4Iznt7bAUKrZfn8hfmvW7C717Zt237bg
 S/jiN1zclXF3ITQNVLpyzUHEYqjWpe5xQBaNWa4eLDia899ByOKIw1Z2SudQHuYiE9f5
 AL/0IvTSxzr3PvTIsC8m7bAPd2XqDCmyRw8GbHl0W+leV8+CL/gDcUAlRAdpNM61giHM
 GkkpFyOyIq/F+Ix13NoMe2ftWDIaEQHnMV/Z+MCVj1GD055VrVYjNzv76NWLhq2jwLuq
 tN9w==
X-Gm-Message-State: AOJu0YzDgrFUl/9kKM1dQ8TyV5A369fFrr98GzxYkix+heeEIsAN/3UO
 YV70njCshzqYOc14anyIWwRC91pWoI5G4QL9rF7Dov87DO2OXRuwYCQ9wT6FIojLFoQiGpCGpV1
 grVzQn82IGez2otE9MLZSff6NXGti3DQVTL0v1CpPzZIl3xgXhcOpBBHDHYkCrOzG5wwgCwPFp/
 gsYHVzg0DnLyt+kKkRv7OKZXeBMAX1SeE=
X-Gm-Gg: AZuq6aJ6cIDUiGmfVp6Yh8jL9ODPEm7Jn+N/FgiJEzK/jD7rh6OAZlKyIMccthk+W9h
 foxJNlYvm5PgMxvBFrHul08LJG6TTDZgW+ggBldymcpwrZ+9VIW56R3pIZ9+DEnbtdS4p8HGODk
 Cnq3fHg0042Js2zloDuPEYoyFW0b0qRfjk/ktxng33dBnvjrbdKeOgjvQwencG1YYjk5oiwHWFb
 QR4s5kJ7poI7HMkazhujWBzCPObVZfEYf3P
X-Received: by 2002:a05:6214:2261:b0:786:8f81:42f with SMTP id
 6a1803df08f44-89736234ac1mr141396446d6.39.1771239087484; 
 Mon, 16 Feb 2026 02:51:27 -0800 (PST)
X-Received: by 2002:a05:6214:2261:b0:786:8f81:42f with SMTP id
 6a1803df08f44-89736234ac1mr141396256d6.39.1771239087074; Mon, 16 Feb 2026
 02:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-4-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-4-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 16 Feb 2026 16:21:15 +0530
X-Gm-Features: AaiRm51BTzghxpH3-s-q1zWUY2HDzVID9IAmb0kaZdLjdyuLzYI-Et6Ks4Kyegw
Message-ID: <CAK3XEhMQ83KH54L6qJ+JPH5nhH-Tv6+MJFZ3-yXq8OnwCEic4w@mail.gmail.com>
Subject: Re: [PATCH 03/11] x86: q35: generate WDAT ACPI table
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 6, 2026 at 6:45=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:
>
> It will generate WDAT table [1] customized for TCO watchdog.
> This allows Windows guests (Windows Server 2008/Vista+) to
> use TCO watchdog using built-in generic driver, which
> aleviates need to install vendor specific drivers.
 ^^^^^^^^^^
typo.

>
> Given that enabling it might change guest behaviour
> (both Windows/Linux) the feature is disabled by default.
>
> Users that need it can enable the feature with
> following CLI option.
>     -machine 'acpi-watchdog=3Don'
>
> 1)
>    "Hardware Watchdog Timers Design Specification"
>     https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Other than below,
Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  include/hw/acpi/wdat-ich9.h | 15 +++++++
>  hw/acpi/meson.build         |  3 +-
>  hw/acpi/wdat-ich9-stub.c    | 15 +++++++
>  hw/acpi/wdat-ich9.c         | 87 +++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c        | 12 +++++
>  5 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/acpi/wdat-ich9.h
>  create mode 100644 hw/acpi/wdat-ich9-stub.c
>  create mode 100644 hw/acpi/wdat-ich9.c
>
> diff --git a/include/hw/acpi/wdat-ich9.h b/include/hw/acpi/wdat-ich9.h
> new file mode 100644
> index 0000000000..60a2a6a112
> --- /dev/null
> +++ b/include/hw/acpi/wdat-ich9.h
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QEMU_HW_ACPI_WDAT_ICH9_H
> +#define QEMU_HW_ACPI_WDAT_ICH9_H
> +
> +#include "hw/acpi/aml-build.h"
> +
> +void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char =
*oem_id,
> +                     const char *oem_table_id, uint64_t tco_base);
> +
> +#endif /* QEMU_HW_ACPI_WDAT_ICH9_H */
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 56b5d1ec96..ba974b2f0f 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -24,7 +24,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: fi=
les('pci-bridge.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug=
-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco=
.c', 'ich9_timer.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco=
.c', 'ich9_timer.c', 'wdat-ich9.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
>  acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: fil=
es('ipmi-stub.c'))
>  acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
> @@ -33,6 +33,7 @@ if have_tpm
>  endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-b=
uild-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridg=
e-stub.c'))
> +system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-ich9-stub.=
c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.=
c'))
> diff --git a/hw/acpi/wdat-ich9-stub.c b/hw/acpi/wdat-ich9-stub.c
> new file mode 100644
> index 0000000000..7c30ef3558
> --- /dev/null
> +++ b/hw/acpi/wdat-ich9-stub.c
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/wdat-ich9.h"
> +
> +void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char =
*oem_id,
> +                const char *oem_table_id, uint64_t tco_base)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/acpi/wdat-ich9.c b/hw/acpi/wdat-ich9.c
> new file mode 100644
> index 0000000000..b1930dc71d
> --- /dev/null
> +++ b/hw/acpi/wdat-ich9.c
> @@ -0,0 +1,87 @@
> +/*
> + * TCO Watchdog Action Table (WDAT)
> + *
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/wdat.h"
> +#include "hw/acpi/wdat-ich9.h"
> +#include "hw/southbridge/ich9.h"
> +
> +#define TCO_REG(base, reg_offset, reg_width) { .space_id =3D AML_AS_SYST=
EM_IO, \
> +            .address =3D base + reg_offset, .bit_width =3D reg_width, \
> +            .access_width =3D AML_WORD_ACC, };
> +
> +/*
> + *   "Hardware Watchdog Timers Design Specification"
> + *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
> + *
> + *   ICH9 specific implementation.
> + */
> +void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char =
*oem_id,
> +                     const char *oem_table_id, uint64_t tco_base)
> +{
> +    AcpiTable table =3D { .sig =3D "WDAT", .rev =3D 1, .oem_id =3D oem_i=
d,
> +                        .oem_table_id =3D oem_table_id };
> +    struct AcpiGenericAddress tco_rld =3D  TCO_REG(tco_base, 0x0, 16);
> +    struct AcpiGenericAddress tco2_sts =3D TCO_REG(tco_base, 0x6, 16);
> +    struct AcpiGenericAddress tco1_cnt =3D TCO_REG(tco_base, 0x8, 16);
> +    struct AcpiGenericAddress tco_tmr =3D  TCO_REG(tco_base, 0x12, 16);
> +
> +    acpi_table_begin(&table, table_data);
> +    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header L=
ength */
> +    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number=
 */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Numb=
er */
> +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> +    build_append_int_noprefix(table_data, 0x258, 4);/* Timer Period, ms =
*/
> +    build_append_int_noprefix(table_data, 0x3ff, 4);/* Maximum Count */
> +    build_append_int_noprefix(table_data, 0x4, 4);  /* Minimum Count */

How are you getting the values for the above three (timer period, min
count and max count)? A comment will help here.


> +    /*
> +     * WATCHDOG_ENABLED & WATCHDOG_STOPPED_IN_SLEEP_STATE
> +     */
> +    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
> +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> +    /*
> +     * watchdog instruction entries
> +     */
> +    build_append_int_noprefix(table_data, 10, 4);

It might help to add a comment that we are adding 10 (decimal 10 even
though other values above are in hex) instruction entries below.

> +    /* Action table */
> +    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
> +        WDAT_INS_WRITE_VALUE,
> +        tco_rld, 0x1, 0x1ff);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
> +        WDAT_INS_READ_VALUE,
> +        tco1_cnt, 0x0, 0x800);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        tco1_cnt, 0, 0x800);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
> +        WDAT_INS_READ_VALUE,
> +        tco1_cnt, 0x800, 0x800);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        tco1_cnt, 0x800, 0x800);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
> +        WDAT_INS_WRITE_COUNTDOWN,
> +        tco_tmr, 0x0, 0x3FF);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_COUNTDOWN_PERIOD=
,
> +        WDAT_INS_READ_COUNTDOWN,
> +        tco_tmr, 0x0, 0x3FF);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
> +        WDAT_INS_READ_VALUE,
> +        tco2_sts, 0x2, 0x2);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        tco2_sts, 0x2, 0x2);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        tco2_sts, 0x4, 0x4);
> +
> +    acpi_table_end(linker, &table);
> +}
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 19c62362e3..abb3e936fd 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -77,6 +77,7 @@
>
>  #include "hw/acpi/hmat.h"
>  #include "hw/acpi/viot.h"
> +#include "hw/acpi/wdat-ich9.h"
>
>  #include CONFIG_DEVICES
>
> @@ -109,6 +110,7 @@ typedef struct AcpiPmInfo {
>      uint16_t cpu_hp_io_base;
>      uint16_t pcihp_io_base;
>      uint16_t pcihp_io_len;
> +    uint64_t tco_io_base;
>  } AcpiPmInfo;
>
>  typedef struct AcpiMiscInfo {
> @@ -203,6 +205,7 @@ static void acpi_get_pm_info(MachineState *machine, A=
cpiPmInfo *pm)
>      pm->pcihp_io_len =3D 0;
>      pm->smi_on_cpuhp =3D false;
>      pm->smi_on_cpu_unplug =3D false;
> +    pm->tco_io_base =3D 0;
>
>      assert(obj);
>      init_common_fadt_data(machine, obj, &pm->fadt);
> @@ -224,6 +227,8 @@ static void acpi_get_pm_info(MachineState *machine, A=
cpiPmInfo *pm)
>              !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));
>          pm->smi_on_cpu_unplug =3D
>              !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)=
);
> +        pm->tco_io_base =3D object_property_get_uint(obj, ACPI_PM_PROP_P=
M_IO_BASE,
> +            NULL) + ICH9_PMIO_TCO_RLD;
>      }
>      pm->pcihp_io_base =3D
>          object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> @@ -2079,6 +2084,13 @@ void acpi_build(AcpiBuildTables *tables, MachineSt=
ate *machine)
>      acpi_add_table(table_offsets, tables_blob);
>      build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_ta=
ble_id);
>
> +    if (machine->acpi_watchdog) {
> +        g_assert(pm.tco_io_base);
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_ich9_wdat(tables_blob, tables->linker, x86ms->oem_id,
> +                        x86ms->oem_table_id, pm.tco_io_base);
> +    }
> +
>      /* Add tables supplied by user (if any) */
>      for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)) {
>          unsigned len =3D acpi_table_len(u);
> --
> 2.47.3
>


