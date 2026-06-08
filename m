Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44D5CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdSM-0002qd-Jd; Mon, 08 Jun 2026 13:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdS3-0002p5-0G
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdRo-0003sr-Vf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780938451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZDkanoGBeNHxRFpe38dioH94SZNXmwZ1kX5QQsmg+8=;
 b=T39AY7NL5GlcivOuQ239Ezki8G6YbboFkX/b5v1uavGkjxxBW3SPp5KTFhuHnhnc9USypT
 Vck+Wt4+7HoJiUk0Q2LRO3RuhgCvLHqnv0zgv20CH4qGNIUrWpksEFcV4F8cT7U+qNtbTz
 IlkKwD9C7dpCgE7e/7Jw1i9tixX3S58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-QE03ByihPBWtnea_U1tomQ-1; Mon, 08 Jun 2026 13:07:24 -0400
X-MC-Unique: QE03ByihPBWtnea_U1tomQ-1
X-Mimecast-MFC-AGG-ID: QE03ByihPBWtnea_U1tomQ_1780938443
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490cc1ae292so13722355e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780938443; x=1781543243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FZDkanoGBeNHxRFpe38dioH94SZNXmwZ1kX5QQsmg+8=;
 b=AuVbfV2gdGWb6i70ooEUaiJOYlJDItoAKP2bIomkSf7lpG7n/m6bMjndfzOouM36VT
 O0a8no5gt9v2/ZVkiQUSk/qBFhjsvES1XDodzgsbOe7G3LiotR4JyY6GyFx0u8IU1pFN
 H5/zu5m+BL/jHssIbAqwcUq6PcLraAxKB3GNYPZ4WGHwgSNf7ZM20qAbuwtqd0BL7zU2
 nasZjboYV2uHz02BkwiM03/3IwwypE7E86TicBOY927/gSD9LEsso1CCfszu/TjqwXvW
 XKil8l6gycdn7bLtdq9ggnle+wmAYO10nsvBGABZp9hKrILPRyCXxxBeEcl8talj+wOQ
 D6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938443; x=1781543243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZDkanoGBeNHxRFpe38dioH94SZNXmwZ1kX5QQsmg+8=;
 b=E0zwZn4iqOL1jIXPEAJUw66icp8me8NhGv5xblGcLP1jcSoP7ZqfOtGLmodxj+RTu4
 b4JWmfbbwuAj1glT6mBXlp5OFJj1d46g8WcxvGZWLGsfKuOu3g8kw54rJk0lgCsmAmRx
 wYl47cyW3Srvp6luOQ63dyiCSeaEQI/8QnUMuoEb/vcfCTIcyhwOndDdLbX021QvhBmp
 +BxoivUXeJUaQAoR913flx/JUS6HCnU5khOJBf3Bry9zKa2HLiZhAiDyIQyvCWfPAmHd
 e+4XZ0gh8qT3pVSkfVYxjuPeiRzXOJeePQN5Xs+5VBD+De54g5IhskaeZ0cev0VWWpgu
 I6Ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F7PcrvH2J8N/2uaAg5wdLSxr1PCfGEhenW56t8vb5H43/Q1coKCZul43Ia3ZlfFnj3hvlY9U/XuUJ@nongnu.org
X-Gm-Message-State: AOJu0Yz58u2h41+V4ihEeVZWRGpo2zr5uJ1jbmQ7A2aMiw9DmCyClcKk
 oRSh/pUqP/p0buBGx6h31qzq21gzU2XO2vNgZW7BQgb1Qw3JZBCooysSkM4zKZ9PGBTkRVzCvPj
 tU4wusvg5Rf0p0s6UqIfBug7nQU47MlVG2dA4zMGZbyUvJl1ST9iJf+lp
X-Gm-Gg: Acq92OEh64k+BdNeeN8pYOPF927klMdH+vYBB0YiGILId2QA4lMhhGOzedx+ubLVYmr
 8ieiTlJ8d26n72El2Jaz2j2oGNtdgPlGIhMEnBsOi80C0S7rDWQGpv2YFiw9X+Emd/bKEgywkYZ
 sU691AveH3vxAAgx4NCEkyA0XgRCUUPVZkOXi5h4ww3KopvLBLRn64eVXcc+y3RZHXqN3NS4wFU
 SLeZxOksIbjncv6nRxNF2KtXNzc99L0EmB9raEc6bAZMHsB6y3NPwAugM46DD2Hillmxzcd12BR
 6rNhSNs5li/2b9ARMuRh3zUXo70h+pO4lnwjIbeGgkrA5aQogGm/myV1JhUs1kIeQKbv50bLTmz
 JT/abaVmAzLjfTan4JVHWHU6BuKpJLnydtnyey5kzVl7CVk6+mpJYVeF8mydbZUJY4o8lVBnLD2
 c=
X-Received: by 2002:a05:600c:3b04:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490c2cdd2bemr231506995e9.7.1780938442808; 
 Mon, 08 Jun 2026 10:07:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490c2cdd2bemr231506545e9.7.1780938442344; 
 Mon, 08 Jun 2026 10:07:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fcf5bsm489616705e9.9.2026.06.08.10.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:07:21 -0700 (PDT)
Message-ID: <94f63b27-59b2-4f65-99dc-ec3a88780e0c@redhat.com>
Date: Mon, 8 Jun 2026 19:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/21] arm: virt: add support for WDAT based watchdog
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-12-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-12-imammedo@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> And generate WDAT table tailored for sbsa_gwdt and disable
> watchdog entry in GTDT ACPI table if WDAT is enabled,
> since they are mutualy exclusive due to different
> timer resolution of sbsa_gwdt.
> 
> To enable use "-device sbsa-gwdt,wdat=on" option
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/wdat-gwdt.h | 19 ++++++++
>  hw/acpi/meson.build         |  2 +
>  hw/acpi/wdat-gwdt-stub.c    | 16 +++++++
>  hw/acpi/wdat-gwdt.c         | 92 +++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 58 +++++++++++++++++------
>  5 files changed, 172 insertions(+), 15 deletions(-)
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
> index 22290ca835..189bbb0257 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -28,12 +28,14 @@ acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ic
>  acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
>  acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
>  acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
> +acpi_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('wdat-gwdt.c'))
>  if have_tpm
>    acpi_ss.add(files('tpm.c'))
>  endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>  system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-ich9-stub.c'))
> +system_ss.add(when: 'CONFIG_WDT_SBSA', if_false: files('wdat-gwdt-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
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
> index 0000000000..226ba3f01e
> --- /dev/null
> +++ b/hw/acpi/wdat-gwdt.c
> @@ -0,0 +1,92 @@
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
you can add a comment that 0xff must be set for following 3 fields as
not a PCI device.
> +    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
> +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
> +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> +    /*
> +     * WDAT spec suports only 1KHz or more coarse watchdog timer,
> +     * Set resolution to minimum supported 1ms.
> +     * Before starting watchdog Windows set countdown value to 5min.
> +     */
> +    g_assert(freq <= 1000);
> +    build_append_int_noprefix(table_data, 1, 4);/* Timer Period, ms */
it is a bit weird to hardcode the freq while it is passed as parameter.
Why don't you propagate it in the table?
> +    /*
> +     * Needs to be more than 4min, otherwise Windows 11 won't start watchdog.
spec says:
"
The time-out period before the WDT fires is recommended to be at least 5
minutes and is required to be less than 4,294,967,296 count intervals.
"
where does the 4 min come from?
> +     * Set max to limits to arbitrary max 10min and min to 5sec.
> +     */
> +    build_append_int_noprefix(table_data, 600 * freq, 4);/* Maximum Count */
spec says this is in count interval and not in ms, no?
> +    build_append_int_noprefix(table_data, 5 * freq, 4);  /* Minimum Count */
same
> +    /*
> +     * WATCHDOG_ENABLED
and stopped in sleep state?
> +     */
> +    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
> +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> +    /*
> +     * watchdog instruction entries
> +     */
> +    build_append_int_noprefix(table_data, 8, 4);
> +    /* Action table */
> +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
> +        WDAT_INS_READ_VALUE,
> +        wcs, 0x1, 0x1);
> +    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
> +        WDAT_INS_WRITE_VALUE,
> +        wrr, 0x1, 0x7);
why 0x7? where did you get that mask value from

in DEN0094E_BSA_1.2.pdf

"0x000-0x003 WRR Watchdog refresh register. A write to this location
causes the watchdog to refresh and start a new
watch period. A read has no effect and returns 0."
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
> +        WDAT_INS_WRITE_COUNTDOWN,
> +        wor_l, 0, 0xffffffff);
How does the above intrustuction work? How the countdown period is
passed? what does the 0 mean in that case?

I would rather group instructions on wcs and then instructions using wor
or wrr
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
reflects the status of WS1 only (and not WS0). Can you explain why this
is what we want?
> +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
> +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> +        wrr, 0x4, 0x4);

> +
> +    acpi_table_end(linker, &table);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9c14b1d4d5..e9670b1a2b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -65,6 +65,7 @@
>  #include "target/arm/cpu.h"
>  #include "target/arm/multiprocessing.h"
>  #include "hw/watchdog/sbsa_gwdt.h"
> +#include "hw/acpi/wdat-gwdt.h"
>  
>  #define ARM_SPI_BASE 32
>  
> @@ -849,12 +850,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_table_end(linker, &table);
>  }
>  
> +static void virt_get_wdt_options(VirtMachineState *vms, Object *wdt,
> +                                 hwaddr *rbase, hwaddr *cbase, int *irq)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
> +    hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> +    *rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
> +    *cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
> +    *irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
> +           platform_bus_get_irqn(pbus, sd, 0);
> +}
> +
>  /*
>   * ACPI spec, Revision 6.5
>   * 5.2.25 Generic Timer Description Table (GTDT)
>   */
>  static void
> -build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms,
> +           Object *wdt, bool add_watchdog)
>  {
>      /*
>       * Table 5-117 Flag Definitions
> @@ -865,7 +879,6 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
>      uint32_t gtdt_start = table_data->len;
> -    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
>  
>      acpi_table_begin(&table, table_data);
>  
> @@ -898,12 +911,12 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
>  
>      /* Platform Timer Count */
> -    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
> +    build_append_int_noprefix(table_data,  add_watchdog ? 1 : 0, 4);
>      /* Platform Timer Offset */
>      build_append_int_noprefix(table_data,
> -        wdt ? (table_data->len - gtdt_start) +
> -              4 + 4 + 4 /* len of this & following 2 fields to skip */
> -            : 0, 4);
> +        add_watchdog ? (table_data->len - gtdt_start) +
this patch is big. You could easily move the add_wathdog +
virt_get_wdt_options() helper in a different patch
> +                       4 + 4 + 4 /* len of this & following 2 fields to skip */
> +                     : 0, 4);
>  
>      if (vms->ns_el2_virt_timer_irq) {
>          /* Virtual EL2 Timer GSIV */
> @@ -916,14 +929,10 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
> -    if (wdt) {
> -        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> -        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
> -        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> -        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
> -        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
> -        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
> -                  platform_bus_get_irqn(pbus, sd, 0);
> +    if (add_watchdog) {
> +        int irq;
> +        hwaddr rbase, cbase;
> +        virt_get_wdt_options(vms, wdt, &rbase, &cbase, &irq);
>  
>          build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
>          build_append_int_noprefix(table_data, 28 /* Length */, 2);
> @@ -1282,8 +1291,14 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      GArray *table_offsets;
>      unsigned dsdt, xsdt;
> +    bool has_wdat = false;
>      GArray *tables_blob = tables->table_data;
>      MachineState *ms = MACHINE(vms);
> +    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
> +
> +    if (wdt) {
> +        has_wdat = object_property_get_bool(wdt, "wdat", &error_abort);
> +    }
>  
>      table_offsets = g_array_new(false, true /* clear */,
>                                          sizeof(uint32_t));
> @@ -1303,6 +1318,19 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_madt(tables_blob, tables->linker, vms);
>  
> +    acpi_add_table(table_offsets, tables_blob);
> +    if (wdt && has_wdat) {
> +        int irq;
> +        hwaddr rbase, cbase;
> +        uint64_t freq = object_property_get_uint(wdt, "clock-frequency",
> +                                                 &error_abort);
> +        virt_get_wdt_options(vms, wdt, &rbase, &cbase, &irq);
> +
> +        build_gwdt_wdat(tables_blob, tables->linker,
> +                        vms->oem_id, vms->oem_table_id,
> +                        rbase, cbase, freq);
> +    }
> +
>      if (!vmc->no_cpu_topology) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_pptt(tables_blob, tables->linker, ms,
> @@ -1310,7 +1338,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      }
>  
>      acpi_add_table(table_offsets, tables_blob);
> -    build_gtdt(tables_blob, tables->linker, vms);
> +    build_gtdt(tables_blob, tables->linker, vms, wdt, wdt && !has_wdat);
>  
>      acpi_add_table(table_offsets, tables_blob);
>      {
Thanks

Eric


