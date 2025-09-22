Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C25CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fsb-0002za-GT; Mon, 22 Sep 2025 08:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0fsW-0002xT-DD
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0fsS-0006wv-37
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758544961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fe91+EOYyaLY+vFu1TWoznWYYazoLnnVetoNocTbs5Y=;
 b=ahBB+fVEKpx6cPfCXfP+qLIB990o8aPD3U0XHgHMkDYbXhryqPJazT0cFFkaCeeP7Co/5J
 TIWBnuC6bSkJHIQyxznSVKrfsCAmmDdB3uOywErkUztC8XRxoh7dRLA/L+pS3nIMHcRXeG
 ImunoOQDid0bN4S4naTf10EKjSIPC1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-AnIr0ryBPRKhFLq9HoSK_A-1; Mon, 22 Sep 2025 08:42:34 -0400
X-MC-Unique: AnIr0ryBPRKhFLq9HoSK_A-1
X-Mimecast-MFC-AGG-ID: AnIr0ryBPRKhFLq9HoSK_A_1758544953
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e19f00bc2so3779835e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758544953; x=1759149753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fe91+EOYyaLY+vFu1TWoznWYYazoLnnVetoNocTbs5Y=;
 b=lkP3Ts97+IDnvEJOxc+okxWu/2FL1+3LDBoPfGhyyi8I8mxYeJ+9x9ycSPEAfDi2IP
 aBfXHOK6VGrYHQTaHcZZsuDTG8ygsX0L46l6cfBgj5920T0o4/kV/iPROipo6tGxemGv
 X4+bORcHIs5nRLBhbkYrqW0/v12tqVO1GFgSf3AfofYnjQp1KdUR6Amffs+zC4ZHDSAV
 wfpOaZAwnAQBSghVCQnr/J9yHaIo/256qpb3DtmJZqEskhyZDumd9aOOq4Qn5qwao99D
 7FUmetUknyUGM53PvAE0ExjfgGtPREdWaWySBi0MqmxKGwyTnBHd4IKM0+Kou3c79guC
 zyfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjyStU2OZEJqd46Npv+XJcXNZom4lgvzv+NhrYPHbK+TqsULMqmV/q70GT0XQq914aMgX6qLbhn7g3@nongnu.org
X-Gm-Message-State: AOJu0Ywkr4sKhoQFunj5PVqkXblBWbMYNaj5EfK2+kfFij9iX8vSAfW+
 AwVZjjCHt6UUnO+L4W88/EtRl5vpGFfwk0xGASIJlBdbQ6UT9FlnZSav7tN62F9rx4R5kelIAXW
 YwLt8Le9Lem18IlT+G1wd1ck/zZHf6cLEcYvIc8Y6sQFxfAo6yWpO4cAI
X-Gm-Gg: ASbGncvdFV/OYs+WpqbwzzXkuRiI3ESbaKSCp1twpWuyFGIM2KLs5R/sJ+d8UvuA2YP
 7uOqOmNkmPEf2782yXn5hx6xoHaMbhNbKk7Ld0R51zd7AO3W/AFbZPUWGOnrNiCNCOjTZ2IarPp
 vgDZkBOLFWLwIF8bTggU4lGzGUOKw583Mu/3DQ5P8pFmAXUDADC/OmAZwK/fIT2aECGZxyJSjaW
 d/uf1FOmabUW6Vq5K1GGxgA/x5PHs345M+50svBeLv8wqKVsWoH5JFSPBY0xhFXQnnFASnIF9bQ
 BNlsjhTlAIp3mjnnIpgjabAGXm5dxNQQ53A=
X-Received: by 2002:a05:600c:5248:b0:46d:3576:2895 with SMTP id
 5b1f17b1804b1-46d35762b25mr35996485e9.24.1758544952917; 
 Mon, 22 Sep 2025 05:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcAZtyDmG+nYQ4fgu8WZbfYa9uYijInMzWx9IixL/Jrg1dCn1NuGA/FyypC5GR1Q5vqtdk0w==
X-Received: by 2002:a05:600c:5248:b0:46d:3576:2895 with SMTP id
 5b1f17b1804b1-46d35762b25mr35995965e9.24.1758544952286; 
 Mon, 22 Sep 2025 05:42:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-467fc818e00sm163413815e9.0.2025.09.22.05.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:42:31 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:42:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH v11 13/17] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20250922083810-mutt-send-email-mst@kernel.org>
References: <cover.1757084668.git.mchehab+huawei@kernel.org>
 <e9a1277fd306a30c9e6f1582a83944a3f4a4aeff.1757084668.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a1277fd306a30c9e6f1582a83944a3f4a4aeff.1757084668.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 05, 2025 at 05:09:20PM +0200, Mauro Carvalho Chehab wrote:
> Creates a QMP command


should be "Create" - imperative mood for commit log

> to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2, and add support for it for ARM guests.
> 
> Error injection uses ACPI_HEST_SRC_ID_QMP source ID to be platform
> independent. This is mapped at arch virt bindings, depending on the
> types supported by QEMU and by the BIOS. So, on ARM, this is supported
> via ACPI_GHES_NOTIFY_GPIO notification type.
> 
> This patch is co-authored:

was, I guess

>     - original ghes logic to inject a simple ARM record by Shiju Jose;
>     - generic logic to handle block addresses by Jonathan Cameron;
>     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> 
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS              |  7 +++++++
>  hw/acpi/Kconfig          |  5 +++++
>  hw/acpi/ghes.c           |  2 +-
>  hw/acpi/ghes_cper.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 20 ++++++++++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/virt-acpi-build.c |  1 +
>  hw/arm/virt.c            |  7 +++++++
>  include/hw/acpi/ghes.h   |  1 +
>  include/hw/arm/virt.h    |  1 +
>  qapi/acpi-hest.json      | 36 ++++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  13 files changed, 122 insertions(+), 1 deletion(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ae28e880424..e609678ba9d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2165,6 +2165,13 @@ F: hw/acpi/ghes.c
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
> index 1d4e9f0845c0..daabbe6cd11e 100644
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
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 0135ac844bcf..1d02ef6dcb70 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -553,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      /* Write the generic error data entry into guest memory */
>      cpu_physical_memory_write(cper_addr, cper, len);
>  
> -    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
> +    notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
>  }
>  
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> new file mode 100644
> index 000000000000..1a391d85fc61
> --- /dev/null
> +++ b/hw/acpi/ghes_cper.c
> @@ -0,0 +1,39 @@
> +/*
> + * CPER payload parser for error injection
> + *
> + * Copyright(C) 2024-2025 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +void qmp_inject_ghes_v2_error(const char *qmp_cper, Error **errp)
> +{
> +    AcpiGhesState *ags;
> +
> +    ags = acpi_ghes_get_state();
> +    if (!ags) {
> +        return;
> +    }
> +
> +    uint8_t *cper;
> +    size_t  len;
> +


Coding style violation - declarations at the beginning of the block.


> +    cper = qbase64_decode(qmp_cper, -1, &len, errp);

cper allocated here ...

> +    if (!cper) {
> +        error_setg(errp, "missing GHES CPER payload");
> +        return;
> +    }
> +
> +    ghes_record_cper_errors(ags, cper, len, ACPI_HEST_SRC_ID_QMP, errp);

used here but never freed - ghes_record_cper_errors gets cper as a const
pointer.

this will leak memory.


> +}
> diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
> new file mode 100644
> index 000000000000..b16be73502db
> --- /dev/null
> +++ b/hw/acpi/ghes_cper_stub.c
> @@ -0,0 +1,20 @@
> +/*
> + * Stub interface for CPER payload parser for error injection
> + *
> + * Copyright(C) 2024-2025 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_inject_ghes_v2_error(const char *cper, Error **errp)
> +{
> +    error_setg(errp, "GHES QMP error inject is not compiled in");
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 73f02b96912b..56b5d1ec9691 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -34,4 +34,6 @@ endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
>  system_ss.add(files('acpi-qmp-cmds.c'))
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 2080d535c476..47a49d4e01b3 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1017,6 +1017,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
>  
>  static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +    { ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO },
>  };
>  
>  static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index dc6634a6a6c5..1e904432be3b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1050,6 +1050,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>  
>  static void virt_generic_error_req(Notifier *n, void *opaque)
>  {
> +    uint16_t *source_id = opaque;
> +
> +    /* Currently, only QMP source ID is async */
> +    if (*source_id != ACPI_HEST_SRC_ID_QMP) {
> +        return;
> +    }
> +
>      VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
>  
>      acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 390943e46d99..df2ecbf6e4a9 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -65,6 +65,7 @@ enum AcpiGhesNotifyType {
>   */
>  enum AcpiGhesSourceID {
>      ACPI_HEST_SRC_ID_SYNC,
> +    ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
>  };
>  
>  typedef struct AcpiNotificationSourceId {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 91e2ac7e3e80..67fa2cdf408d 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -33,6 +33,7 @@
>  #include "exec/hwaddr.h"
>  #include "qemu/notify.h"
>  #include "hw/boards.h"
> +#include "hw/acpi/ghes.h"
>  #include "hw/arm/boot.h"
>  #include "hw/arm/bsa.h"
>  #include "hw/block/flash.h"
> diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
> new file mode 100644
> index 000000000000..2e1cdf34847d
> --- /dev/null
> +++ b/qapi/acpi-hest.json
> @@ -0,0 +1,36 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# == GHESv2 CPER Error Injection
> +#
> +# Defined since ACPI Specification 6.1,
> +# section 18.3.2.8 Generic Hardware Error Source version 2. See:
> +#
> +# https://uefi.org/sites/default/files/resources/ACPI_6_1.pdf
> +##
> +
> +
> +##
> +# @inject-ghes-v2-error:
> +#
> +# Inject an error with additional ACPI 6.1 GHESv2 error information
> +#
> +# @cper: contains a base64 encoded string with raw data for a single
> +#     CPER record with Generic Error Status Block, Generic Error Data
> +#     Entry and generic error data payload, as described at
> +#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 10.0

Needs an update?


> +##
> +{ 'command': 'inject-ghes-v2-error',
> +  'data': {
> +    'cper': 'str'
> +  },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index ca6b61a608d0..a46269b5a0c9 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -59,6 +59,7 @@ if have_system
>    qapi_all_modules += [
>      'accelerator',
>      'acpi',
> +    'acpi-hest',
>      'audio',
>      'cryptodev',
>      'qdev',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 82f111ba063c..b93dd68d94c6 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -68,6 +68,7 @@
>  { 'include': 'misc-i386.json' }
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
> +{ 'include': 'acpi-hest.json' }
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }
> -- 
> 2.51.0


