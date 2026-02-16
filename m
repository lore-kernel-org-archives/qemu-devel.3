Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BC7E63F38
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrtid-0008Hu-Ay; Mon, 16 Feb 2026 03:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrtiZ-0008HZ-Kw
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:12:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrtiW-0007hU-C5
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771229546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gbOSvjbKgU/L/u0eYeyTMFDz1SNfjlskyOhBcCV7gw=;
 b=KghjAiiQQxGVk63+iEUoKckrOFxH4bzKc3+CrGJspr0/ADrCB5fmsEez1k/kxD3nc+lxSq
 LUzQb3pMbpztWBmE38Dr0UQcBmwOviIuJA+aD/+4NB5xsCGWLYT3fBIUItndLK/vvthXTK
 UYK+VXQbcrrP1le9z07qlrsEtv979LU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-PoCODVGSMHGkoDU-DYcn6g-1; Mon, 16 Feb 2026 03:12:24 -0500
X-MC-Unique: PoCODVGSMHGkoDU-DYcn6g-1
X-Mimecast-MFC-AGG-ID: PoCODVGSMHGkoDU-DYcn6g_1771229544
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-506c0231e63so154237761cf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 00:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771229544; cv=none;
 d=google.com; s=arc-20240605;
 b=O9CyjJxcwb8lmjkJHHIG5I6xlGybxpFGAo0bh9U0mk493MNpmmQ3XWcHVKezEeVxEy
 As4/Ik5+5GWGjPx/wFTZNWiX7xM4Io/UJCpbtLKFAMnlhimIQep7yWJKmOhWXga0JAWW
 OLBVi4XMbIMgP2uVMYf7DNi7c/7EPC28fj0wt58OpLQfN9gzxaz+QqKlKAhjdH/zEOdQ
 IHuPch56VeuXt7iDv48JTj9caCd4N5LZ/emSNwWcaN/fJdD1OeKbrZ421TKRpHu/g2b3
 uLsq28Gok/5lhZ8hx7q+CLwaWeUeHdTjzO43fbCxsMduH5xSLdecmajfAcT0pPDl4xwS
 mpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7gbOSvjbKgU/L/u0eYeyTMFDz1SNfjlskyOhBcCV7gw=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=SQMjhsHptz6YeoXhqaN1sPj22oofAIwDBxGEyez4hBd5lcoDOENFnHJITr7+v8+r+T
 oK2fu/6t346IJAEKyInQl9wwb0lwReDKhRHWIu8oSicWrZ597WVyCmBj8K7AKIOvOg8E
 xJ1HJdh4EX8YzgVECv7/KnK+slVu0KMFunDsl7RyQAYGtDXEdUV7Z1Os3KEhnmPY7D1C
 5Rs/jGha8BRXBpBIsNCsge1rBoebMyyEZLnn1LeWlDxo38/GRj7ohO90b+7+Y7tLWNz3
 i0909PtmefQgBXi4j38tXxzOtLExruMfGKA7FiedsYPVH5jGr8Uo4AUOiNOGdqWuFn0J
 voIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771229544; x=1771834344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gbOSvjbKgU/L/u0eYeyTMFDz1SNfjlskyOhBcCV7gw=;
 b=MPqGhYOqhQBlKjEcT2pzbjOyNH/1ploWckLmPysNoqqIB31wSv/VrTm7gbt/OEKBpw
 J7eVEv1QPrb7LWYIwwTcCyZb3Iqfc5O8Y36LZ1C/upgfVUWWxCMY8DuNqYKxpB+18f+o
 JbJytw7FcoOCLeNN74pgKFUr/i3/9VLAsiPoxVmE+ZGP1bty4cBsTVfvMYgKrpRWPX0c
 YKy4Bl5RPIDD4pWltA95OHz5YtMaQ0jgS7j8ghEcvC42oeA3iUNdVX99ZRj54+5mF851
 exPyfEDV6k32ZqJVNVGjXVZL8pmjy7P8eJA5vwS26mV68FhjWPXs9C3Nqrpcixnf8Lb+
 Ls+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771229544; x=1771834344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7gbOSvjbKgU/L/u0eYeyTMFDz1SNfjlskyOhBcCV7gw=;
 b=ffdMPWUOMCtN2gl+v3ccmga0Xu0t3YkzK2oOi55f0RlLytyTN5UlW+hcjpA8gZomrs
 GJFFxEj2gYZ7/52Y1DC8xuBOW0Ag1thlbA10GrMbM/8oPMJzCj2FeMM/ByZI9Uoh6T3D
 9jxtz9K2vGAjJMAzWMJm5tXL25leY4RRSelQt2ix66IfswjbA4Jco7HU5FVb4KFUZClq
 umCncOWVsSlQJPqIgnUv6VBwKTKWOoBU/9Ng58qKGhRRtt4SPdMBtHINmyV/GMENAssQ
 fkT6ZzlAG6VCKZbGwF8rQunqZalqK6tDjRHQIm9xe0XYWFDRwjfgrjZqDxpkBy/zUnm9
 EBJQ==
X-Gm-Message-State: AOJu0Yw6b19lUKmgjE4Mu4VEZ+X3z+rDwt7B5x7nV2mhtT6R6nx9mmp7
 +Y0yoUXsAoRrd8FwU3BkgFhaaG4TDpw/GmlO83HMWWIKZJ5LOH0DvQNj1VG5BGGfXqPELsyQqt5
 /yIGXV/idzQEFeOHf4TEYpNDp7rR1GxVyP3U0CJqz83U77YaKirE1ZAEgaT9xWfeW2dMJbQ61yV
 SRAIu67gdyFYH3qlDmOZDFvfBBnEF82EU=
X-Gm-Gg: AZuq6aIE8QffdO3Lge0rDVVbvAymbyNtKHQuACVk82cbFgl4+3X3Y9gxKlz8dTgOI4O
 DQbtZjTHFAOordVcPDA39YPwoL9AxFwqIrgj3H0JKVWozrKL4jkRurfDx+79AAh+/jKPzpKi9Lx
 Hmx6AWUBHKg37OUp7m4//Ojs3W9k7tmBVwDPEiT6Gamzs8K/dKZgsCIO/rOu49X5M8OpNBvVQII
 ZKBOsseuGmiyS6LXpAfGHy23iIZziaGFSCR
X-Received: by 2002:a05:622a:144c:b0:4ff:a8c1:b00e with SMTP id
 d75a77b69052e-506b25fbdd3mr108550491cf.2.1771229544151; 
 Mon, 16 Feb 2026 00:12:24 -0800 (PST)
X-Received: by 2002:a05:622a:144c:b0:4ff:a8c1:b00e with SMTP id
 d75a77b69052e-506b25fbdd3mr108550271cf.2.1771229543614; Mon, 16 Feb 2026
 00:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-2-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-2-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 16 Feb 2026 13:42:12 +0530
X-Gm-Features: AaiRm52xrxds_-Yq2R40hnHa12yvRvByvKvKRBn3KJdzGSS6o04e8194FvTutQw
Message-ID: <CAK3XEhOzZH8VUoFZTN7GuZt1Sn8PRZtsMEvq9Gs4p8CfKwX2pw@mail.gmail.com>
Subject: Re: [PATCH 01/11] acpi: add API to build WDAT instructions
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
> Add definitions for WDAT[1] actions/instructions
> and build_append_wdat_ins() API to build table entries.
>
> 1)
> "Hardware Watchdog Timers Design Specification"
>   https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  include/hw/acpi/wdat.h | 118 +++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/aml-build.c    |  14 +++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 include/hw/acpi/wdat.h
>
> diff --git a/include/hw/acpi/wdat.h b/include/hw/acpi/wdat.h
> new file mode 100644
> index 0000000000..89803eef4b
> --- /dev/null
> +++ b/include/hw/acpi/wdat.h
> @@ -0,0 +1,118 @@
> +/*
> + * Watchdog Action Table (WDAT) definitions
> + *
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QEMU_HW_ACPI_WDAT_H
> +#define QEMU_HW_ACPI_WDAT_H
> +
> +#include "hw/acpi/acpi-defs.h"
> +
> +/*
> + * Watchdog actions as described in
> + *  "Hardware Watchdog Timers Design Specification"
> + * for link to spec see https://uefi.org/acpi
> + *     'Watchdog Action Table (WDAT)'
> + */
> +typedef enum {
> +    /*
> +     * Restarts the watchdog timer's countdown. This action is
> +     * required.
> +     */
> +    WDAT_ACTION_RESET =3D 0x1,
> +    /*
> +     * Returns the current countdown value of the watchdog hardware
> +     * (in count intervals).
> +     */
> +    WDAT_ACTION_QUERY_CURRENT_COUNTDOWN_PERIOD =3D 0x4,
> +    /*
> +     * Returns the countdown value the watchdog hardware is
> +     * configured to use when reset (in count intervals).
> +     */
> +    WDAT_ACTION_QUERY_COUNTDOWN_PERIOD =3D 0x5,
> +    /*
> +     * Sets the countdown value (in count intervals) to be used when
> +     * the watchdog timer is reset. This action is required if
> +     * WDAT_ACTION_RESET does not explicitly write a new
> +     * countdown value to a register during a reset. Otherwise, this
> +     * action is optional.
> +     */
> +    WDAT_ACTION_SET_COUNTDOWN_PERIOD =3D 0x6,
> +    /*
> +     * Determines if the watchdog hardware is currently in enabled/
> +     * running state. The same result must occur when performed from
> +     * both from enabled/stopped state and enabled/running state. If
> +     * the watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_QUERY_RUNNING_STATE =3D 0x8,
> +    /*
> +     * Starts the watchdog, if not already in running state. If the
> +     * watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_SET_RUNNING_STATE =3D 0x9,
> +    /*
> +     * Determines if the watchdog hardware is currently in enabled/
> +     * stopped state. The same result must occur when performed from
> +     * both the enabled/stopped state and enabled/running state. If
> +     * the watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_QUERY_STOPPED_STATE =3D 0xA,
> +    /*
> +     * Stops the watchdog, if not already in stopped state. If the
> +     * watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_SET_STOPPED_STATE =3D 0xB,
> +    /*
> +     * Determines if the watchdog hardware is configured to perform a
> +     * reboot when the watchdog is fired.
> +     */
> +    WDAT_ACTION_QUERY_REBOOT =3D 0x10,
> +    /*
> +     * Configures the watchdog hardware to perform a reboot when it
> +     * is fired.
> +     */
> +    WDAT_ACTION_SET_REBOOT =3D 0x11,
> +    /*
> +     * Determines if the watchdog hardware is configured to perform a
> +     * system shutdown when fired.
> +     */
> +    WDAT_ACTION_QUERY_SHUTDOWN =3D 0x12,
> +    /*
> +     * Configures the watchdog hardware to perform a system shutdown
> +     * when fired.
> +     */
> +    WDAT_ACTION_SET_SHUTDOWN =3D 0x13,
> +    /*
> +     * Determines if the current boot was caused by the watchdog
> +     * firing. The boot status is required to be set if the watchdog
> +     * fired and caused a reboot. It is recommended that the
> +     * Watchdog Status be set if the watchdog fired and caused a
> +     * shutdown. This action is required.
> +     */
> +    WDAT_ACTION_QUERY_WATCHDOG_STATUS =3D 0x20,
> +    /*
> +     * Sets the watchdog's boot status to the default value. This
> +     * action is required.
> +     */
> +    WDAT_ACTION_SET_WATCHDOG_STATUS =3D 0x21,
> +} WDATAction;
> +
> +#define WDAT_INS_READ_VALUE 0x0
> +#define WDAT_INS_READ_COUNTDOWN 0x1
> +#define WDAT_INS_WRITE_VALUE 0x2
> +#define WDAT_INS_WRITE_COUNTDOWN 0x3
> +#define WDAT_INS_PRESERVE_REGISTER 0x80
> +
> +void build_append_wdat_ins(GArray *table_data,
> +                           WDATAction action, uint8_t flags,
> +                           struct AcpiGenericAddress as,
> +                           uint32_t val, uint32_t mask);
> +
> +#endif /* QEMU_HW_ACPI_WDAT_H */
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index ea1c415b21..9f9ce28dcc 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -32,6 +32,7 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "qemu/cutils.h"
> +#include "hw/acpi/wdat.h"
>
>  static GArray *build_alloc_array(void)
>  {
> @@ -2647,3 +2648,16 @@ Aml *aml_error_device(void)
>
>      return dev;
>  }
> +
> +void build_append_wdat_ins(GArray *table_data,
> +                           WDATAction action, uint8_t flags,
> +                           struct AcpiGenericAddress as,
> +                           uint32_t val, uint32_t mask)
> +{
> +    build_append_int_noprefix(table_data, action, 1);    /* Watchdog Act=
ion */
> +    build_append_int_noprefix(table_data, flags, 1);     /* Instruction =
Flags */
> +    build_append_int_noprefix(table_data, 0, 2);         /* Reserved */
> +    build_append_gas_from_struct(table_data, &as);       /* Register Reg=
ion */
> +    build_append_int_noprefix(table_data, val, 4);       /* Value */
> +    build_append_int_noprefix(table_data, mask, 4);      /* Mask */
> +}
> --
> 2.47.3
>


