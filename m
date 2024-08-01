Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846C0C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXlR-00087X-J9; Thu, 01 Aug 2024 11:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sZXlQ-00086u-3P
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:30:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sZXlN-00087n-I6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:30:47 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C6E444E6013;
 Thu, 01 Aug 2024 17:30:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id TmfR3gtvcsa2; Thu,  1 Aug 2024 17:30:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C7E524E6010; Thu, 01 Aug 2024 17:30:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C5FE174577C;
 Thu, 01 Aug 2024 17:30:38 +0200 (CEST)
Date: Thu, 1 Aug 2024 17:30:38 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-for-9.1 v3 1/2] hw/pci-host/gt64120: Reset config registers
 during RESET phase
In-Reply-To: <20240801150021.52977-2-philmd@linaro.org>
Message-ID: <5e765e4d-5314-0737-fccf-635d9365f796@eik.bme.hu>
References: <20240801150021.52977-1-philmd@linaro.org>
 <20240801150021.52977-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-602474402-1722526238=:15560"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-602474402-1722526238=:15560
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 1 Aug 2024, Philippe Mathieu-Daudé wrote:
> Reset config values in the device RESET phase, not only once
> when the device is realized, because otherwise the device can
> use unknown values at reset.
>
> Mention the datasheet referenced. Remove the "Malta assumptions
> ahead" comment since the reset values from the datasheet are used.
>
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/pci-host/gt64120.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index e02efc9e2e..b68d647753 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -1,6 +1,8 @@
> /*
>  * QEMU GT64120 PCI host
>  *
> + * (Datasheet GT-64120 Rev 1.4 from Sep 14, 1999)
> + *
>  * Copyright (c) 2006,2007 Aurelien Jarno
>  *
>  * Permission is hereby granted, free of charge, to any person obtaining a copy
> @@ -1211,19 +1213,24 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
>     empty_slot_init("GT64120", 0, 0x20000000);
> }
>
> -static void gt64120_pci_realize(PCIDevice *d, Error **errp)
> +static void gt64120_pci_reset_hold(Object *obj, ResetType type)
> {
> -    /* FIXME: Malta specific hw assumptions ahead */
> +    PCIDevice *d = PCI_DEVICE(obj);
> +
> +    /* Values from chapter 17.16 "PCI Configuration" */
> +
>     pci_set_word(d->config + PCI_COMMAND, 0);
>     pci_set_word(d->config + PCI_STATUS,
>                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
>     pci_config_set_prog_interface(d->config, 0);
> +
>     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x1f000000);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_4, 0x14000000);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_5, 0x14000001);
> +
>     pci_set_byte(d->config + 0x3d, 0x01);
> }
>
> @@ -1231,8 +1238,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
> {
>     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>     DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>
> -    k->realize = gt64120_pci_realize;
> +    rc->phases.hold = gt64120_pci_reset_hold;

Why reset_hold and not a simple reset method which is more usual?  If 
there's an explanation maybe it could be mentioned in the commit message. 
Other than that this should work so you can add:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

if that helps but I don't know much about this chip (even if it's similar 
to mv6436x).

Regards,
BALATON Zoltan

>     k->vendor_id = PCI_VENDOR_ID_MARVELL;
>     k->device_id = PCI_DEVICE_ID_MARVELL_GT6412X;
>     k->revision = 0x10;
>
--3866299591-602474402-1722526238=:15560--

