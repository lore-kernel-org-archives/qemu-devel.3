Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC03E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVb8w-0007F8-Vd; Wed, 08 Jan 2025 13:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVb8v-0007Ef-En
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVb8s-0006pV-Sc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736362257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DXQyhQtnkPJlGQcNItM1TPyUDQzP1Dq/iPzO9bXCa4A=;
 b=iDihMtyRj1+/Ek1uiHw959Pwz78317g18NOjeMcBlT86q8s0QNh1+GdB4WST0odW9N+brx
 q5rdd4hO8R3YnMnjBVuZgxhoe9RrCCRUIFyB1JIBBFj/4yALVumdf3bm+4ASk6kgy70bY5
 0TudzKhEeEhzU38o+7XRqsIglkTlFNs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-rKnyfBY4P7WOd17adEsV7Q-1; Wed, 08 Jan 2025 13:50:55 -0500
X-MC-Unique: rKnyfBY4P7WOd17adEsV7Q-1
X-Mimecast-MFC-AGG-ID: rKnyfBY4P7WOd17adEsV7Q
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3cb2e6c42so23011a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736362254; x=1736967054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXQyhQtnkPJlGQcNItM1TPyUDQzP1Dq/iPzO9bXCa4A=;
 b=OAZ7+M9NAw2I4OfEFmvi2hQTHxnJE00dJD7HLW0OGbUrYqbOLenVyI7vl4cT5euQa1
 qt+4R3I/VEMY2ZJI3whD70KStuNxcPs5Myz7+asD4kbgFibN+7kpfqCWB/MDaZ5NPWSP
 h/ZKaqENQt46fAAqx5v4yzElbqRhhBIJ6iXBRfWPabAYkFb6ujIN05Pw99bkFxnKL7oM
 N0KIaXZSfae/IAjubtfPniPlRcp7GGAKvMlPCo065t927pGC6JpyScbrQU+ItNqT8nfw
 edXF+DgZOnGZ1t8I2AE2D/Lha572eHdyCYQqzkVtZ9hGDIL779CUA30ZWD8kYVF5Mjt+
 r+2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDuukBYuvmuKRVy0Y1ut1Ta79srWusHeoRSWaeQKlP4tpUci/4Eq7rpMlAy2Z9ydgRconcgP/CCH5p@nongnu.org
X-Gm-Message-State: AOJu0YzQ75lb5DiLgYI8Cc/+S+deW1IKBf9lWJ2U9aMJ2wXn5TI4g99l
 oSX9sZAvbN7/TPtOjhKm/aiyWJ/wZaFouAsKi/9ZDfSXVlpbv8mDXHo6PLwyLdSJ6OCIdTrOo4n
 z8UJxQHTn1YmUo643FSYgSX+Kj/BjnOP3P9jTK9chkkrpdmWvK4SC
X-Gm-Gg: ASbGncvrCStIp1kRLBynpvp7q+2QJ7SYtvdrO8dunBKeHPtM6DFB3DoLbfs5wF2Js0s
 ZoMj9msDHpqBZX3OsqXtYNMWzaLvY/7d588T5mb+5PTfl8ZeL34JfI+RwaamxhRQTWK76J6kb7F
 eEufEQxx/Wnr2XFfDJpizfZ0Pq57lWwdgz0+Obt5aDh4qsC9qYbVukWKRr4eRWUy5N19r7S/S51
 kxbeCMMfxR4gjiObMqHUwNQw0YzO5rItzMtBoC2mcSlM+OG+Yo=
X-Received: by 2002:a05:6402:3899:b0:5d0:e2f0:d578 with SMTP id
 4fb4d7f45d1cf-5d972e0b05bmr3617800a12.14.1736362254157; 
 Wed, 08 Jan 2025 10:50:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3xK3ai3QN0n/OcnU3zS0XSFagP5HbToq3QCmYMg/MaRbD8yh01ShNJKa9jypHtvYcLZwvZQ==
X-Received: by 2002:a05:6402:3899:b0:5d0:e2f0:d578 with SMTP id
 4fb4d7f45d1cf-5d972e0b05bmr3617782a12.14.1736362253713; 
 Wed, 08 Jan 2025 10:50:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80701c89asm25351899a12.79.2025.01.08.10.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:50:52 -0800 (PST)
Date: Wed, 8 Jan 2025 13:50:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Patrick Leis <venture@google.com>
Cc: peter.maydell@linaro.org, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org,
 Nabih Estefan <nabihestefan@google.com>
Subject: Re: [PATCH v2] hw/pci-bridge: Create PLX Virtual Switch Device
Message-ID: <20250108134652-mutt-send-email-mst@kernel.org>
References: <20241218194320.2832636-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218194320.2832636-1-venture@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Dec 18, 2024 at 07:43:19PM +0000, Patrick Leis wrote:
> From: Nabih Estefan <nabihestefan@google.com>
> 
> Create a PLX PEX PCIe Virtual Switch implementation that can be used
> for modeling trays. This is a generalized version of the xio3130 switch where
> we can set the PCI information on creation, allowing us to model different
> trays without creating specific devices for all of them. It is used the same
> way the xio3130 switch is used + the PCI Signature information
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Signed-off-by: Patrick Leis <venture@google.com>
> ---
> v2: fix reset function assignment
> ---
>  hw/pci-bridge/Kconfig                  |   5 +
>  hw/pci-bridge/meson.build              |   1 +
>  hw/pci-bridge/plx_vswitch_downstream.c | 187 +++++++++++++++++++++++++
>  hw/pci-bridge/plx_vswitch_upstream.c   | 177 +++++++++++++++++++++++
>  include/hw/pci-bridge/plx_vswitch.h    |  41 ++++++
>  5 files changed, 411 insertions(+)
>  create mode 100644 hw/pci-bridge/plx_vswitch_downstream.c
>  create mode 100644 hw/pci-bridge/plx_vswitch_upstream.c
>  create mode 100644 include/hw/pci-bridge/plx_vswitch.h



Are you going to maintain this?

> 
> diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
> index 449ec98643..dbba09d8b3 100644
> --- a/hw/pci-bridge/Kconfig
> +++ b/hw/pci-bridge/Kconfig
> @@ -27,6 +27,11 @@ config IOH3420
>      default y if PCI_DEVICES
>      depends on PCI_EXPRESS && MSI_NONBROKEN
>  
> +config PLX_VSWITCH
> +    bool
> +    default y if PCI_DEVICES
> +    depends on PCI_EXPRESS && MSI_NONBROKEN
> +
>  config I82801B11
>      bool
>      default y if PCI_DEVICES
> diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
> index 2e0eb0d233..02c18558bd 100644
> --- a/hw/pci-bridge/meson.build
> +++ b/hw/pci-bridge/meson.build
> @@ -7,6 +7,7 @@ pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
>  pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
>                                 if_false: files('pci_expander_bridge_stubs.c'))
>  pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
> +pci_ss.add(when: 'CONFIG_PLX_VSWITCH', if_true: files('plx_vswitch_upstream.c', 'plx_vswitch_downstream.c'))
>  pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
>  
>  # Sun4u
> diff --git a/hw/pci-bridge/plx_vswitch_downstream.c b/hw/pci-bridge/plx_vswitch_downstream.c
> new file mode 100644
> index 0000000000..a00d393657
> --- /dev/null
> +++ b/hw/pci-bridge/plx_vswitch_downstream.c
> @@ -0,0 +1,187 @@
> +/*
> + * PLX PEX PCIe Virtual Switch - Downstream
> + *
> + * Copyright 2024 Google LLC
> + * Author: Nabih Estefan <nabihestefan@google.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + *
> + * Based on xio3130_downstream.c and guest_only_pci.c
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci_ids.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_port.h"
> +#include "hw/pci-bridge/plx_vswitch.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/registerfields.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +
> +#define TYPE_PLX_VSWITCH_DOWNSTREAM_PCI "plx-vswitch-downstream-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(PlxVSwitchPci, PLX_VSWITCH_DOWNSTREAM_PCI)
> +
> +
> +static void plx_vswitch_downstream_write_config(PCIDevice *d, uint32_t address,
> +                                         uint32_t val, int len)
> +{
> +    pci_bridge_write_config(d, address, val, len);
> +    pcie_cap_flr_write_config(d, address, val, len);
> +    pcie_aer_write_config(d, address, val, len);
> +}
> +
> +static void plx_vswitch_downstream_reset(DeviceState *qdev)
> +{
> +    PCIDevice *d = PCI_DEVICE(qdev);
> +
> +    pcie_cap_deverr_reset(d);
> +    pcie_cap_arifwd_reset(d);
> +    pci_bridge_reset(qdev);
> +}
> +
> +static void plx_vswitch_downstream_realize(PCIDevice *d, Error **errp)
> +{
> +    PlxVSwitchPci *vs = PLX_VSWITCH_DOWNSTREAM_PCI(d);
> +    PCIEPort *p = PCIE_PORT(d);
> +    int rc;
> +
> +    if (vs->vendor_id == 0xffff) {
> +        error_setg(errp, "Vendor ID invalid, it must always be supplied");
> +        return;
> +    }
> +    if (vs->device_id == 0xffff) {
> +        error_setg(errp, "Device ID invalid, it must always be supplied");
> +        return;
> +    }
> +
> +    if (vs->subsystem_vendor_id == 0xffff) {
> +        error_setg(errp,
> +                   "Subsystem Vendor ID invalid, it must always be supplied");
> +        return;
> +    }
> +
> +    uint16_t ssvid = vs->subsystem_vendor_id;
> +    uint16_t ssdid = vs->subsystem_device_id;
> +
> +    pci_set_word(&d->config[PCI_VENDOR_ID], vs->vendor_id);
> +    pci_set_word(&d->config[PCI_DEVICE_ID], vs->device_id);
> +    pci_set_long(&d->config[PCI_CLASS_REVISION], vs->class_revision);
> +
> +    pci_bridge_initfn(d, TYPE_PCIE_BUS);
> +    pcie_port_init_reg(d);
> +
> +    rc = msi_init(d, PLX_VSWITCH_MSI_OFFSET, PLX_VSWITCH_MSI_NR_VECTOR,
> +                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
> +                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
> +                  errp);
> +    if (rc < 0) {
> +        assert(rc == -ENOTSUP);
> +        goto err_bridge;
> +    }
> +
> +    rc = pci_bridge_ssvid_init(d, PLX_VSWITCH_SSVID_OFFSET, ssvid, ssdid,
> +                               errp);
> +    if (rc < 0) {
> +        goto err_msi;
> +    }
> +
> +    rc = pcie_cap_init(d, PLX_VSWITCH_EXP_OFFSET, PCI_EXP_TYPE_DOWNSTREAM,
> +                       p->port, errp);
> +    if (rc < 0) {
> +        goto err_msi;
> +    }
> +    pcie_cap_flr_init(d);
> +    pcie_cap_deverr_init(d);
> +    pcie_cap_arifwd_init(d);
> +
> +    rc = pcie_aer_init(d, PCI_ERR_VER, PLX_VSWITCH_AER_OFFSET,
> +                       PCI_ERR_SIZEOF, errp);
> +    if (rc < 0) {
> +        goto err;
> +    }
> +
> +    return;
> +
> +err:
> +    pcie_cap_exit(d);
> +err_msi:
> +    msi_uninit(d);
> +err_bridge:
> +    pci_bridge_exitfn(d);
> +}
> +
> +static void plx_vswitch_downstream_exitfn(PCIDevice *d)
> +{
> +    pcie_aer_exit(d);
> +    pcie_cap_exit(d);
> +    msi_uninit(d);
> +    pci_bridge_exitfn(d);
> +}
> +
> +static const VMStateDescription vmstate_plx_vswitch_downstream = {
> +    .name = PLX_VSWITCH_DOWNSTREAM,
> +    .priority = MIG_PRI_PCI_BUS,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
> +        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log,
> +                       PCIEPort, 0, vmstate_pcie_aer_log, PCIEAERLog),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property plx_vswitch_downstream_pci_properties[] = {
> +    DEFINE_PROP_UINT16("vendor-id", PlxVSwitchPci, vendor_id, 0xffff),
> +    DEFINE_PROP_UINT16("device-id", PlxVSwitchPci, device_id, 0xffff),
> +    DEFINE_PROP_UINT16("subsystem-vendor-id", PlxVSwitchPci,
> +                       subsystem_vendor_id, 0),
> +    DEFINE_PROP_UINT16("subsystem-device-id", PlxVSwitchPci,
> +                       subsystem_device_id, 0),
> +    DEFINE_PROP_UINT32("class-revision", PlxVSwitchPci, class_revision,
> +                       0xff000000 /* Unknown class */),
> +    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> +                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void plx_vswitch_downstream_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->desc = "Downstream Port of PLX PEX PCIe Virtual Switch";
> +    device_class_set_legacy_reset(dc, plx_vswitch_downstream_reset);
> +    dc->vmsd = &vmstate_plx_vswitch_downstream;
> +    device_class_set_props(dc, plx_vswitch_downstream_pci_properties);
> +
> +    k->config_write = plx_vswitch_downstream_write_config;
> +    k->realize = plx_vswitch_downstream_realize;
> +    k->exit = plx_vswitch_downstream_exitfn;
> +}
> +
> +static const TypeInfo plx_vswitch_downstream_pci_types[] = {
> +    {
> +        .name = TYPE_PLX_VSWITCH_DOWNSTREAM_PCI,
> +        .parent = TYPE_PCIE_PORT,
> +        .class_init = plx_vswitch_downstream_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { }
> +        }
> +    },
> +};
> +DEFINE_TYPES(plx_vswitch_downstream_pci_types)
> diff --git a/hw/pci-bridge/plx_vswitch_upstream.c b/hw/pci-bridge/plx_vswitch_upstream.c
> new file mode 100644
> index 0000000000..ba23e90bd6
> --- /dev/null
> +++ b/hw/pci-bridge/plx_vswitch_upstream.c
> @@ -0,0 +1,177 @@
> +/*
> + * PLX PEX PCIe Virtual Switch - Upstream
> + *
> + * Copyright 2024 Google LLC
> + * Author: Nabih Estefan <nabihestefan@google.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + *
> + * Based on xio3130_upstream.c and guest_only_pci.c
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci_ids.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_port.h"
> +#include "hw/pci-bridge/plx_vswitch.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/registerfields.h"
> +#include "migration/vmstate.h"
> +#include "qemu/module.h"
> +
> +#define TYPE_PLX_VSWITCH_UPSTREAM_PCI "plx-vswitch-upstream-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(PlxVSwitchPci, PLX_VSWITCH_UPSTREAM_PCI)
> +
> +static void plx_vswitch_upstream_write_config(PCIDevice *d, uint32_t address,
> +                                          uint32_t val, int len)
> +{
> +    pci_bridge_write_config(d, address, val, len);
> +    pcie_cap_flr_write_config(d, address, val, len);
> +    pcie_aer_write_config(d, address, val, len);
> +}
> +
> +static void plx_vswitch_upstream_reset(DeviceState *qdev)
> +{
> +    PCIDevice *d = PCI_DEVICE(qdev);
> +
> +    pci_bridge_reset(qdev);
> +    pcie_cap_deverr_reset(d);
> +}
> +
> +static void plx_vswitch_upstream_realize(PCIDevice *d, Error **errp)
> +{
> +    PlxVSwitchPci *vs = PLX_VSWITCH_UPSTREAM_PCI(d);
> +    PCIEPort *p = PCIE_PORT(d);
> +    int rc;
> +
> +    if (vs->vendor_id == 0xffff) {
> +        error_setg(errp, "Vendor ID invalid, it must always be supplied");
> +        return;
> +    }
> +    if (vs->device_id == 0xffff) {
> +        error_setg(errp, "Device ID invalid, it must be specified");
> +        return;
> +    }
> +
> +    if (vs->subsystem_vendor_id == 0xffff) {
> +        error_setg(errp, "Subsystem Vendor ID invalid, it must be specified");
> +        return;
> +    }
> +
> +    uint16_t ssvid = vs->subsystem_vendor_id;
> +    uint16_t ssdid = vs->subsystem_device_id;
> +
> +    pci_set_word(&d->config[PCI_VENDOR_ID], vs->vendor_id);
> +    pci_set_word(&d->config[PCI_DEVICE_ID], vs->device_id);
> +    pci_set_long(&d->config[PCI_CLASS_REVISION], vs->class_revision);
> +
> +    pci_bridge_initfn(d, TYPE_PCIE_BUS);
> +    pcie_port_init_reg(d);
> +
> +    rc = msi_init(d, PLX_VSWITCH_MSI_OFFSET, PLX_VSWITCH_MSI_NR_VECTOR,
> +                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
> +                  PLX_VSWITCH_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
> +                  errp);
> +    if (rc < 0) {
> +        assert(rc == -ENOTSUP);
> +        goto err_bridge;
> +    }
> +
> +    rc = pci_bridge_ssvid_init(d, PLX_VSWITCH_SSVID_OFFSET, ssvid, ssdid, errp);
> +    if (rc < 0) {
> +        goto err_msi;
> +    }
> +
> +    rc = pcie_cap_init(d, PLX_VSWITCH_EXP_OFFSET, PCI_EXP_TYPE_UPSTREAM,
> +                       p->port, errp);
> +    if (rc < 0) {
> +        goto err_msi;
> +    }
> +    pcie_cap_flr_init(d);
> +    pcie_cap_deverr_init(d);
> +
> +    rc = pcie_aer_init(d, PCI_ERR_VER, PLX_VSWITCH_AER_OFFSET,
> +                       PCI_ERR_SIZEOF, errp);
> +    if (rc < 0) {
> +        goto err;
> +    }
> +
> +    return;
> +
> +err:
> +    pcie_cap_exit(d);
> +err_msi:
> +    msi_uninit(d);
> +err_bridge:
> +    pci_bridge_exitfn(d);
> +}
> +
> +static void plx_vswitch_upstream_exitfn(PCIDevice *d)
> +{
> +    pcie_aer_exit(d);
> +    pcie_cap_exit(d);
> +    msi_uninit(d);
> +    pci_bridge_exitfn(d);
> +}
> +
> +static const VMStateDescription vmstate_plx_vswitch_upstream = {
> +    .name = PLX_VSWITCH_UPSTREAM,
> +    .priority = MIG_PRI_PCI_BUS,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
> +        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,
> +                       vmstate_pcie_aer_log, PCIEAERLog),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property plx_vswitch_upstream_pci_properties[] = {
> +    DEFINE_PROP_UINT16("vendor-id", PlxVSwitchPci, vendor_id, 0xffff),
> +    DEFINE_PROP_UINT16("device-id", PlxVSwitchPci, device_id, 0xffff),
> +    DEFINE_PROP_UINT16("subsystem-vendor-id", PlxVSwitchPci,
> +                       subsystem_vendor_id, 0xffff),
> +    DEFINE_PROP_UINT16("subsystem-device-id", PlxVSwitchPci,
> +                       subsystem_device_id, 0xffff),

What is the story here? Making users specify these IDs is too fagile,
they can easily get it wrong.

> +    DEFINE_PROP_UINT32("class-revision", PlxVSwitchPci, class_revision,
> +                       0xff000000 /* Unknown class */),

this is even more questionable

> +    DEFINE_PROP_END_OF_LIST(),

we no longer use these.

> +};
> +
> +static void plx_vswitch_upstream_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->desc = "Upstream Port of PLX PEX PCIe Virtual Switch";
> +    device_class_set_legacy_reset(dc, plx_vswitch_upstream_reset);
> +    dc->vmsd = &vmstate_plx_vswitch_upstream;
> +    device_class_set_props(dc, plx_vswitch_upstream_pci_properties);
> +    k->config_write = plx_vswitch_upstream_write_config;
> +    k->realize = plx_vswitch_upstream_realize;
> +    k->exit = plx_vswitch_upstream_exitfn;
> +}
> +
> +static const TypeInfo plx_vswitch_upstream_pci_types[] = {
> +    {
> +        .name = TYPE_PLX_VSWITCH_UPSTREAM_PCI,
> +        .parent = TYPE_PCIE_PORT,
> +        .class_init = plx_vswitch_upstream_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { INTERFACE_PCIE_DEVICE },
> +            { }
> +        }
> +    },
> +};
> +DEFINE_TYPES(plx_vswitch_upstream_pci_types)
> diff --git a/include/hw/pci-bridge/plx_vswitch.h b/include/hw/pci-bridge/plx_vswitch.h
> new file mode 100644
> index 0000000000..4542ecf5e0
> --- /dev/null
> +++ b/include/hw/pci-bridge/plx_vswitch.h
> @@ -0,0 +1,41 @@
> +/*
> + * PLX PEX PCIe Virtual Switch
> + *
> + * Copyright 2024 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#ifndef HW_PCI_BRIDGE_PLX_VSWITCH
> +#define HW_PCI_BRIDGE_PLX_VSWITCH
> +
> +#define PLX_VSWITCH_DOWNSTREAM "plx-vswitch-downstream"
> +#define PLX_VSWITCH_UPSTREAM "plx-vswitch-upstream"
> +
> +#define PLX_VSWITCH_MSI_OFFSET              0x70
> +#define PLX_VSWITCH_MSI_SUPPORTED_FLAGS     PCI_MSI_FLAGS_64BIT
> +#define PLX_VSWITCH_MSI_NR_VECTOR           1
> +#define PLX_VSWITCH_SSVID_OFFSET            0x80
> +#define PLX_VSWITCH_EXP_OFFSET              0x90
> +#define PLX_VSWITCH_AER_OFFSET              0x100
> +
> +typedef struct PlxVSwitchPci {
> +    PCIDevice parent;
> +
> +    /* PCI config properties */
> +    uint16_t vendor_id;
> +    uint16_t device_id;
> +    uint16_t subsystem_vendor_id;
> +    uint16_t subsystem_device_id;
> +    uint32_t class_revision;
> +} PlxVSwitchPci;
> +
> +#endif
> -- 
> 2.47.1.613.gc27f4b7a9f-goog


