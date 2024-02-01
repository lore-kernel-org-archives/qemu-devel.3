Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A136C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWMY-0006Qk-AZ; Thu, 01 Feb 2024 07:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rVWMW-0006QE-Q7
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:40:12 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rVWMT-0004HU-4b
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:40:12 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 7799FA00ED; Thu,  1 Feb 2024 13:39:56 +0100 (CET)
Date: Thu, 1 Feb 2024 13:39:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: [PATCH] hw/ide: Add the possibility to disable the CompactFlash
 device in the build
In-Reply-To: <20240201082916.20857-1-thuth@redhat.com>
Message-ID: <alpine.LMD.2.03.2402011326360.16176@eik.bme.hu>
References: <20240201082916.20857-1-thuth@redhat.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024, Thomas Huth wrote:
> For distros like downstream RHEL, it would be helpful to allow to disable
> the CompactFlash device. For making this possible, we need a separate
> Kconfig switch for this device, and the code should reside in a separate
> file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> hw/ide/qdev-ide.h  | 41 ++++++++++++++++++++++++++++++++
> hw/ide/cf.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++
> hw/ide/qdev.c      | 51 ++--------------------------------------
> hw/ide/Kconfig     |  4 ++++
> hw/ide/meson.build |  1 +
> 5 files changed, 106 insertions(+), 49 deletions(-)
> create mode 100644 hw/ide/qdev-ide.h
> create mode 100644 hw/ide/cf.c
>
> diff --git a/hw/ide/qdev-ide.h b/hw/ide/qdev-ide.h
> new file mode 100644
> index 0000000000..3dd977466c
> --- /dev/null
> +++ b/hw/ide/qdev-ide.h

This may be unrelated to this patch but we already have 
include/hw/ide/internal.h which may be a place these should go in but that 
header is in inlcude because some files outside hw/ide include it. I've 
found three places that include ide/internal.h: hw/arm/sbsa-ref.c, 
hw/i386/pc.c and hw/misc/macio.h. Only macio is really needing internal 
IDE parts the other two just uses some functions so macio is probably the 
reason this wasn't cleaned up yet. In any case, maybe this could go in 
include/hw/ide/internal.h to avoid introducing a new header or somehow 
make this a local header where non-public parts of hw/ide/internal.h could 
be moved in the future. Such as rename include/hw/ide/internal.h to ide.h 
and name this one internal.h maybe?

Regards,
BALATON Zoltan

> @@ -0,0 +1,41 @@
> +/*
> + * ide bus support for qdev.
> + *
> + * Copyright (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
> + *
> + * This code is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef QDEV_IDE_H
> +#define QDEV_IDE_H
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/block/block.h"
> +#include "hw/ide/internal.h"
> +
> +typedef struct IDEDrive {
> +    IDEDevice dev;
> +} IDEDrive;
> +
> +#define DEFINE_IDE_DEV_PROPERTIES()                     \
> +    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
> +    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
> +    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
> +    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
> +    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
> +    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
> +
> +void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp);
> +
> +#endif
> diff --git a/hw/ide/cf.c b/hw/ide/cf.c
> new file mode 100644
> index 0000000000..0b4bb57591
> --- /dev/null
> +++ b/hw/ide/cf.c
> @@ -0,0 +1,58 @@
> +/*
> + * ide CompactFlash support
> + *
> + * This code is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/ide/qdev-ide.h"
> +#include "qapi/qapi-types-block.h"
> +
> +static void ide_cf_realize(IDEDevice *dev, Error **errp)
> +{
> +    ide_dev_initfn(dev, IDE_CFATA, errp);
> +}
> +
> +static Property ide_cf_properties[] = {
> +    DEFINE_IDE_DEV_PROPERTIES(),
> +    DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
> +    DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
> +                IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void ide_cf_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
> +
> +    k->realize  = ide_cf_realize;
> +    dc->fw_name = "drive";
> +    dc->desc    = "virtual CompactFlash card";
> +    device_class_set_props(dc, ide_cf_properties);
> +}
> +
> +static const TypeInfo ide_cf_info = {
> +    .name          = "ide-cf",
> +    .parent        = TYPE_IDE_DEVICE,
> +    .instance_size = sizeof(IDEDrive),
> +    .class_init    = ide_cf_class_init,
> +};
> +
> +static void ide_cf_register_type(void)
> +{
> +    type_register_static(&ide_cf_info);
> +}
> +
> +type_init(ide_cf_register_type)
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 1b3b4da01d..a2f2d0ea08 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -24,12 +24,9 @@
> #include "qemu/error-report.h"
> #include "qemu/main-loop.h"
> #include "qemu/module.h"
> -#include "hw/ide/internal.h"
> -#include "hw/qdev-properties.h"
> -#include "hw/qdev-properties-system.h"
> +#include "hw/ide/qdev-ide.h"
> #include "sysemu/block-backend.h"
> #include "sysemu/blockdev.h"
> -#include "hw/block/block.h"
> #include "sysemu/sysemu.h"
> #include "sysemu/runstate.h"
> #include "qapi/visitor.h"
> @@ -158,11 +155,7 @@ int ide_get_bios_chs_trans(BusState *bus, int unit)
>
> /* --------------------------------- */
>
> -typedef struct IDEDrive {
> -    IDEDevice dev;
> -} IDEDrive;
> -
> -static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
> +void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
> {
>     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
>     IDEState *s = bus->ifs + dev->unit;
> @@ -283,19 +276,6 @@ static void ide_cd_realize(IDEDevice *dev, Error **errp)
>     ide_dev_initfn(dev, IDE_CD, errp);
> }
>
> -static void ide_cf_realize(IDEDevice *dev, Error **errp)
> -{
> -    ide_dev_initfn(dev, IDE_CFATA, errp);
> -}
> -
> -#define DEFINE_IDE_DEV_PROPERTIES()                     \
> -    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
> -    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
> -    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
> -    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
> -    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
> -    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
> -
> static Property ide_hd_properties[] = {
>     DEFINE_IDE_DEV_PROPERTIES(),
>     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
> @@ -346,32 +326,6 @@ static const TypeInfo ide_cd_info = {
>     .class_init    = ide_cd_class_init,
> };
>
> -static Property ide_cf_properties[] = {
> -    DEFINE_IDE_DEV_PROPERTIES(),
> -    DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
> -    DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
> -                IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void ide_cf_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
> -
> -    k->realize  = ide_cf_realize;
> -    dc->fw_name = "drive";
> -    dc->desc    = "virtual CompactFlash card";
> -    device_class_set_props(dc, ide_cf_properties);
> -}
> -
> -static const TypeInfo ide_cf_info = {
> -    .name          = "ide-cf",
> -    .parent        = TYPE_IDE_DEVICE,
> -    .instance_size = sizeof(IDEDrive),
> -    .class_init    = ide_cf_class_init,
> -};
> -
> static void ide_device_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *k = DEVICE_CLASS(klass);
> @@ -396,7 +350,6 @@ static void ide_register_types(void)
>     type_register_static(&ide_bus_info);
>     type_register_static(&ide_hd_info);
>     type_register_static(&ide_cd_info);
> -    type_register_static(&ide_cf_info);
>     type_register_static(&ide_device_type_info);
> }
>
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index dd85fa3619..b93d6743d5 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -57,3 +57,7 @@ config IDE_SII3112
>     bool
>     select IDE_PCI
>     select IDE_QDEV
> +
> +config IDE_CF
> +    bool
> +    default y if IDE_QDEV
> diff --git a/hw/ide/meson.build b/hw/ide/meson.build
> index e050eef942..d2e5b45c9e 100644
> --- a/hw/ide/meson.build
> +++ b/hw/ide/meson.build
> @@ -1,6 +1,7 @@
> system_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
> system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
> system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
> +system_ss.add(when: 'CONFIG_IDE_CF', if_true: files('cf.c'))
> system_ss.add(when: 'CONFIG_IDE_CMD646', if_true: files('cmd646.c'))
> system_ss.add(when: 'CONFIG_IDE_CORE', if_true: files('core.c', 'atapi.c'))
> system_ss.add(when: 'CONFIG_IDE_ISA', if_true: files('isa.c', 'ioport.c'))
> -- 
> 2.43.0
>
>
>

