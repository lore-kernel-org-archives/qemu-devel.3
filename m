Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5613C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0xw-00019n-TE; Mon, 19 Aug 2024 07:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg0xu-00015W-O3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg0xo-0003PT-QB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724068458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQ4480T+9sAW/+BlCugiW96Q9+2PBOd5re6lznyZPSo=;
 b=K4aFxqTN0H1+d9kWKjZvhttGRlcajPzcsoHSHpNVj2FMMBkG7yXOBtEzTOh8fUOV5erSzx
 9dSrEk5LULHwrUWpIvncr3adqTaRIfxPQqhFxzh5XnMNAVxcn5mbibisUMLOGysmKWFvSF
 R8Jx/N1X2X5eVyrN1B6AC4UqHfu0Rg0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-K7GL6NbYMCyDkp-pc9--bw-1; Mon, 19 Aug 2024 07:54:17 -0400
X-MC-Unique: K7GL6NbYMCyDkp-pc9--bw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42809eb7b99so22963825e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 04:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724068456; x=1724673256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQ4480T+9sAW/+BlCugiW96Q9+2PBOd5re6lznyZPSo=;
 b=PjEuKO8VNQlxsRdpqbmjQrhw3tZfOeLdtx7AYJi1ZtBAsn9W5LWY4ptlNLQ/8JkbP4
 0xYz2zCHSEBiKUqtPFxypymm+oTEocSNo34tdDw9NL0HdR5g6BEcSsp83EulYed1xEKi
 iOzIBoIdyxE6yZUtTOIGg+tDaRM8ReUzdDfJsDvwnf3SzMEjOcksB9pWe1JLEZwlys9q
 Or+90fWA07tPDVWVF8znzaWg/XNceHGm06dcxKafWwbGWD++c50oVlyL3aKbRHBysNqF
 7GnIle5CmouXlV851vmo3wRPp3HVS7554Mp/Z9G/HmNVgPplBnBnZbK40TXZpPUbbAv5
 vfAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6N3goi88j4p7nktJgdbmp3obu8PBdlfEY7cxiVyfvpUH0mO8c0tC4ZNy8APxR0mbEB/X8dmVYLOtc@nongnu.org
X-Gm-Message-State: AOJu0YwCi3B7zFHh34IlzpMOcoGDP0c60c+obSUDoWwlUIJUZ+K4G6GR
 /fl/J8zQOjNqV6LV96T5taLB5y9QtjPisCE+k2N4rUaHb14DfF47wCaL2JPW3Vx5S8+agvxDAZo
 e8y0ILvFjUd6FEqGctvawlSflNQXZz9LWX/BfsBYKRM+oQjvQIpQx
X-Received: by 2002:a05:600c:4e91:b0:426:64c1:8388 with SMTP id
 5b1f17b1804b1-429eda23e74mr60067365e9.17.1724068455871; 
 Mon, 19 Aug 2024 04:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvndoydJLrcmx2YYteeIpr3SyROz/F/iRjrkwJ3YAd/EcJZc9t43sl7IXIix5TpJ3EILYtcw==
X-Received: by 2002:a05:600c:4e91:b0:426:64c1:8388 with SMTP id
 5b1f17b1804b1-429eda23e74mr60067165e9.17.1724068455266; 
 Mon, 19 Aug 2024 04:54:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded29303sm159631645e9.15.2024.08.19.04.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 04:54:14 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:54:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 04/13] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20240819135414.7608c519@imammedo.users.ipa.redhat.com>
In-Reply-To: <f25af812712304aa754103250ee45bfcdd8314ce.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <f25af812712304aa754103250ee45bfcdd8314ce.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 16 Aug 2024 09:37:36 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
> 
> The actual GHES code will be added at the followup patch.

modulo inconsistency in comments (see below), LGTM

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS              |  7 +++++++
>  hw/acpi/Kconfig          |  5 +++++
>  hw/acpi/ghes_cper.c      | 33 +++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 19 +++++++++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/Kconfig           |  5 +++++
>  include/hw/acpi/ghes.h   |  3 +++
>  qapi/acpi-hest.json      | 36 ++++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  10 files changed, 112 insertions(+)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3584d6a6c6da..1d8091818899 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2077,6 +2077,13 @@ F: hw/acpi/ghes.c
>  F: include/hw/acpi/ghes.h
>  F: docs/specs/acpi_hest_ghes.rst
>  
> +ACPI/HEST/GHES/ARM processor CPER
> +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +S: Maintained
> +F: hw/arm/ghes_cper.c
> +F: hw/acpi/ghes_cper_stub.c
> +F: qapi/acpi-hest.json
> +
>  ppc4xx
>  L: qemu-ppc@nongnu.org
>  S: Orphan
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index e07d3204eb36..73ffbb82c150 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -51,6 +51,11 @@ config ACPI_APEI
>      bool
>      depends on ACPI
>  
> +config GHES_CPER
> +    bool
> +    depends on ACPI_APEI
> +    default y
> +
>  config ACPI_PCI
>      bool
>      depends on ACPI && PCI
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> new file mode 100644
> index 000000000000..92ca84d738de
> --- /dev/null
> +++ b/hw/acpi/ghes_cper.c
> @@ -0,0 +1,33 @@
> +/*
> + * CPER payload parser for error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/base64.h"
> +#include "qemu/error-report.h"
> +#include "qemu/uuid.h"
> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(const char *qmp_cper,
> +                   Error **errp)
> +{
> +
> +    uint8_t *cper;
> +    size_t  len;
> +
> +    cper = qbase64_decode(qmp_cper, -1, &len, errp);
> +    if (!cper) {
> +        error_setg(errp, "missing GHES CPER payload");
> +        return;
> +    }
> +
> +    /* TODO: call a function at ghes */
> +}
> diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
> new file mode 100644
> index 000000000000..36138c462ac9
> --- /dev/null
> +++ b/hw/acpi/ghes_cper_stub.c
> @@ -0,0 +1,19 @@
> +/*
> + * Stub interface for CPER payload parser for error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(const char *cper, Error **errp)
> +{
> +    error_setg(errp, "GHES QMP error inject is not compiled in");
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db9068..6cbf430eb66d 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -34,4 +34,6 @@ endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
>  system_ss.add(files('acpi-qmp-cmds.c'))
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1ad60da7aa2d..bed6ba27d715 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -712,3 +712,8 @@ config ARMSSE
>      select UNIMP
>      select SSE_COUNTER
>      select SSE_TIMER
> +
> +config GHES_CPER
> +    bool
> +    depends on ARM
> +    default y if AARCH64
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 419a97d5cbd9..b977d65564ba 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
>  #include "qemu/notify.h"
>  
>  extern NotifierList acpi_generic_error_notifiers;
> @@ -77,6 +78,8 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             enum AcpiGhesNotifyType notify, Error **errp);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
> diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
> new file mode 100644
> index 000000000000..91296755d285
> --- /dev/null
> +++ b/qapi/acpi-hest.json
> @@ -0,0 +1,36 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = GHESv2 CPER Error Injection
> +#
> +# Defined since ACPI Specification 6.2,
> +# section 18.3.2.8 Generic Hardware Error Source version 2. See:
earliest definition, I've found was 6.1, so this should be fixed up here

> +#
> +# https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10
make it consistent with above spec version

> +##
> +
> +
> +##
> +# @ghes-cper:
> +#
> +# Inject a CPER error data to be filled according to ACPI 6.2
ditto

> +# spec via GHESv2.
> +#
> +# @cper: contains a base64 encoded string with raw data for a single CPER
> +#     record with Generic Error Status Block, Generic Error Data Entry and
> +#     generic error data payload, as described at
> +#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.2
> +##
> +{ 'command': 'ghes-cper',
> +  'data': {
> +    'cper': 'str'
> +  },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..35cea6147262 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -59,6 +59,7 @@ qapi_all_modules = [
>  if have_system
>    qapi_all_modules += [
>      'acpi',
> +    'acpi-hest',
>      'audio',
>      'cryptodev',
>      'qdev',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..baf19ab73afe 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -75,6 +75,7 @@
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
> +{ 'include': 'acpi-hest.json' }
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }


