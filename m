Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D40C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAmW-0000xp-Pg; Mon, 29 Jun 2026 08:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weAm0-0000b5-Bm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weAlw-0002ug-KP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782734851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezUFCbGzc3lk4+mFKS+bGA0pzqv/MmFJyII6s6pxVBA=;
 b=EduXWmxf4pjTzN61fStSH062+pYBRQIQcRRjO8mvleylMPbsXfq5iR6vYTkno9kgOZ6Q3T
 l6hx95fLl6Tp5gP9OYsscwrnOJu+yUWRo7RyofyWGW2QxY2Po6vnlWeKaPENmpbopSaHYV
 If1FFfODM6ouY5EKPdHYyCxOEuvntco=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-fCQD4H82Mt6Srg_dZWjqBg-1; Mon, 29 Jun 2026 08:07:29 -0400
X-MC-Unique: fCQD4H82Mt6Srg_dZWjqBg-1
X-Mimecast-MFC-AGG-ID: fCQD4H82Mt6Srg_dZWjqBg_1782734848
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-bf481a6e4e6so215024766b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782734848; x=1783339648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ezUFCbGzc3lk4+mFKS+bGA0pzqv/MmFJyII6s6pxVBA=;
 b=Wca18xm63191vIvJfKM8pRIEXYIESeDMlCtJBYvPlplV/nGlCRieWYkmEHZOlj0ONz
 VPF1hm1/5IWpFr4oId6lkkBaw1D7zspaUHruIaajWNfX5ID+3s6SRdn0TMxcZfCEMmTl
 lClw9E1kZrUcUfnT5NmuAeeNmV+FQOkhLgXbsT87cPOcsz4wBSY42ie/CPwxoR7fNH5C
 QVIjv4ufxC4DDJ6oLWoWt6ck7XCPsxntAaKNF/FrThM+6wT9dc4fYxamliYimcpYgmEb
 lKiIyo8Azy1E+q2eqeqU/xqe2QlKEMIf7Qic9Ydmsp73KTcdyaF/BuW+2fVAujy3g6ME
 luew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734848; x=1783339648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ezUFCbGzc3lk4+mFKS+bGA0pzqv/MmFJyII6s6pxVBA=;
 b=QkHG/NQxlc1yNOd2mRQShHpc8Zu8btDc8t6b+jhTG0gfJSu+gCM6p/131O/30TQ8h6
 tTi4zsl9VW3/1nSob5bYOSCUh8M6Kna7DgmqNvZ4Mv2FRDXwQbRjidjXodXeAs7hrAtv
 ErqJI7Me7WEHwuSyjAaHfd2xirKxPqKeK2KB96pZjXIowsPuPaTWpZqvzyVpgL09L6qX
 B5BoYREYk1m7lpRCUuYd1ouSG78O0bOu85cZvalF1ZyBKc/LrJXGG6RWglBl3ZvH4prD
 X8HfKrc54ctziBHe1MotEYJ7hqDoXYYsH64IF2tuQiS5hThFAry/0gzDfQhjQhN5DHNe
 fsSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiDn+Ic+7QuNM32e7nQoRCePRmmNVaKvgM2bgx+x9S8DjrPbgWlXnfGEmNypVqBl+Ef7mHKN+3kh+6@nongnu.org
X-Gm-Message-State: AOJu0Yz9MzmgksBYNF4gFtqvwUx9ofaaraYieWw55QhiKLe4X/1/5NLa
 KbmQ8vsgaM2nTbJMdVL/dzKvUiJCls4Wpb4foFbuMgD8dAuLkZwhFyjfA9ThllnmDtaE+7LbChL
 bzGRI+Bi1Ln3a+GM+91pb8kaiSIlzQ88G81xxpBFnmATLZ91uWD/D/ZUG
X-Gm-Gg: AfdE7cmoQvBjMBhf1I6f8Z6QYjKDoPpACItgmxPuv/nGshnWEB7zjwDaa339PAgbJ2W
 wExg7YqJOxW6FN+oFgD30dCY+8ttrgUn+W4gD0MeO+dDjRtGNTRhIiL/U6/XpaCNmHFQjnVl0Zu
 5olH53pN0FrxR70M4yMT4474XTE0CqNdUN0oN+e3m0L2UfKvrJKFTJ59jKImCNLRA21nCIVpK/4
 pCyKGOTDh2kcWFWxBLZC6s734C1w7mGOCLReWvLokOy/t8uYVJ8ko+gt8tgHXo8/Filnb+OvZ5b
 UjFm8am2VqgQuKUbCs1DjkfXTVoGW59cxdREIAEmDw6rEd6wpkSSfow/y1DCaUOoqsEg2hLPyu1
 PAgYfxemE2zSdg+UVVWVnm5mb93ha4hWd9aVRLFv63IvGdFx+2aa1Pw==
X-Received: by 2002:a17:907:72d2:b0:c12:77ee:4416 with SMTP id
 a640c23a62f3a-c1277ee4a9cmr75512866b.43.1782734847999; 
 Mon, 29 Jun 2026 05:07:27 -0700 (PDT)
X-Received: by 2002:a17:907:72d2:b0:c12:77ee:4416 with SMTP id
 a640c23a62f3a-c1277ee4a9cmr75510966b.43.1782734847454; 
 Mon, 29 Jun 2026 05:07:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1252b4e6e0sm249885766b.2.2026.06.29.05.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 05:07:26 -0700 (PDT)
Message-ID: <ee804443-50ec-4384-8b05-478d4946d4eb@redhat.com>
Date: Mon, 29 Jun 2026 14:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] acpi: introduce WDAT table for GWDT
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-7-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260624102830.1355552-7-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/24/26 12:28 PM, Igor Mammedov wrote:
> Add build_gwdt_wdat() to generate a Watchdog Action Table
> tailored for the SBSA Generic Watchdog Timer.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>   (Eric)
>     - split '[PATCH v2 11/21] arm: virt: add support for WDAT based watchdog'
>       on smaller chunks.
>     - add/improve  comments where requested
>     - actualy use 'freq' argument passed down by caller
>     - simplify magic val on WRR write and add comment
>     - group table records by used register
> ---
>  include/hw/acpi/wdat-gwdt.h | 19 +++++++
>  hw/acpi/meson.build         |  2 +
>  hw/acpi/wdat-gwdt-stub.c    | 16 ++++++
>  hw/acpi/wdat-gwdt.c         | 99 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 136 insertions(+)
>  create mode 100644 include/hw/acpi/wdat-gwdt.h
>  create mode 100644 hw/acpi/wdat-gwdt-stub.c
>  create mode 100644 hw/acpi/wdat-gwdt.c
> 
> diff --git a/include/hw/acpi/wdat-gwdt.h b/include/hw/acpi/wdat-gwdt.h
> new file mode 100644
> index 0000000000..42339e031e
> --- /dev/null
> +++ b/include/hw/acpi/wdat-gwdt.h
> @@ -0,0 +1,19 @@
> +/*
> + * GWDT Watchdog Action Table (WDAT) definition
> + *
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QEMU_HW_ACPI_WDAT_GWDT_H
> +#define QEMU_HW_ACPI_WDAT_GWDT_H
> +
> +#include "hw/acpi/aml-build.h"
> +#include "hw/watchdog/sbsa_gwdt.h"
> +
> +void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> +                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
> +                     uint64_t freq);
> +
> +#endif /* QEMU_HW_ACPI_WDAT_GWDT_H */
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 0c7bfb278a..09ad488a04 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -31,11 +31,13 @@ acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
>  acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
>  stub_ss.add(files('ipmi-stub.c'))
>  stub_ss.add(files('acpi-x86-stub.c'))
> +acpi_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('wdat-gwdt.c'))
>  if have_tpm
>    acpi_ss.add(files('tpm.c'))
>  endif
>  stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
>  stub_ss.add(files('pci-bridge-stub.c'))
> +stub_ss.add(files('wdat-gwdt-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
>  stub_ss.add(files('ghes_cper_stub.c'))
> diff --git a/hw/acpi/wdat-gwdt-stub.c b/hw/acpi/wdat-gwdt-stub.c
> new file mode 100644
> index 0000000000..4d43783f70
> --- /dev/null
> +++ b/hw/acpi/wdat-gwdt-stub.c
> @@ -0,0 +1,16 @@
> +/*
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/wdat-gwdt.h"
> +
> +void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> +                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
> +                     uint64_t freq)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/acpi/wdat-gwdt.c b/hw/acpi/wdat-gwdt.c
> new file mode 100644
> index 0000000000..b30566ef6a
> --- /dev/null
> +++ b/hw/acpi/wdat-gwdt.c
> @@ -0,0 +1,99 @@
> +/*
> + * SBSA GWDT Watchdog Action Table (WDAT)
> + *
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/wdat-gwdt.h"
> +#include "hw/acpi/wdat.h"
> +#include "hw/watchdog/sbsa_gwdt.h"
> +
> +#define GWDT_REG(base, reg_offset, reg_width) { \
> +                 .space_id = AML_AS_SYSTEM_MEMORY, \
> +                 .address = base + reg_offset, .bit_width = reg_width, \
> +                 .access_width = AML_DWORD_ACC };
> +
> +/*
> + *   "Hardware Watchdog Timers Design Specification"
> + *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
nit: alignment is a bit strange + leading blanks
> + */
> +void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
> +                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
> +                     uint64_t freq)
> +{
> +    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
> +                        .oem_table_id = oem_table_id };
> +
> +    struct AcpiGenericAddress wrr =  GWDT_REG(rbase, 0x0, 32);
> +    struct AcpiGenericAddress wor_l =  GWDT_REG(cbase, SBSA_GWDT_WOR, 32);
> +    struct AcpiGenericAddress wcs =  GWDT_REG(cbase, SBSA_GWDT_WCS, 32);
> +
> +    acpi_table_begin(&table, table_data);
> +    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
> +    /*
> +     * PCI location fields are set to 0xff to indicate
> +     * that the watchdog is not a PCI device.
> +     */
> +    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
> +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> +    /*
> +     * WDAT spec: "The clock interval that the WDT uses must be
> +     * greater than or equal to 1 millisecond."
> +     */
> +    g_assert(freq <= 1000);
> +    /* Timer Period, ms */
> +    build_append_int_noprefix(table_data, 1000 / freq, 4);
> +    /*
> +     * WDAT spec: "The time-out period before the WDT fires is recommended
> +     * to be at least 5 minutes."
> +     * Set max count to 10min and min count to 5sec.
> +     */
> +    build_append_int_noprefix(table_data, 600 * freq, 4); /* Maximum Count */
> +    build_append_int_noprefix(table_data, 5 * freq, 4);   /* Minimum Count */
> +    /*
> +     * WATCHDOG_ENABLED | WATCHDOG_STOPPED_IN_SLEEP_STATE
> +     */
> +    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
> +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> +    /*
> +     * watchdog instruction entries
> +     */
> +    build_append_int_noprefix(table_data, 8, 4);
> +    /* Action table: WCS (control/status) register actions */
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
> +        WDAT_INS_READ_VALUE,
> +        wcs, 0x1, 0x1);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        wcs, 1, 0x00000001);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
> +        WDAT_INS_READ_VALUE,
> +        wcs, 0x0, 0x00000001);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        wcs, 0x0, 0x00000001);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
> +        WDAT_INS_READ_VALUE,
> +        wcs, 0x4, 0x00000004);
> +    /* WOR (offset) and WRR (refresh) register actions */
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
> +        WDAT_INS_WRITE_COUNTDOWN,
> +        wor_l, 0, 0xffffffff);
> +    /* WRR: any write refreshes the watchdog, value is ignored */
> +    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
> +        WDAT_INS_WRITE_VALUE,
> +        wrr, 0x1, 0x1);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        wrr, 0x4, 0x4);
> +
> +    acpi_table_end(linker, &table);
> +}

Besides, looks good to me after your additional information on my
comments/questions on v2

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


