Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1056CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGmH-0004n9-UK; Mon, 01 Jul 2024 09:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sOGmE-0004mI-PM; Mon, 01 Jul 2024 09:09:02 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sOGmC-0005CC-2R; Mon, 01 Jul 2024 09:09:02 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7514A45F19;
 Mon,  1 Jul 2024 15:08:49 +0200 (CEST)
Message-ID: <ce81d0ec-688d-4545-b008-123cd01cbd5a@proxmox.com>
Date: Mon, 1 Jul 2024 15:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: Don't ignore most usb-storage properties
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org
References: <20240131130607.24117-1-kwolf@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240131130607.24117-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi,

we got a user report about bootindex for an 'usb-storage' device not
working anymore [0] and I reproduced it and bisected it to this patch.

Am 31.01.24 um 14:06 schrieb Kevin Wolf:
> @@ -399,11 +397,10 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>      object_property_add_child(OBJECT(bus), name, OBJECT(dev));
>      g_free(name);
>  
> +    s = SCSI_DEVICE(dev);
> +    s->conf = *conf;
> +
>      qdev_prop_set_uint32(dev, "scsi-id", unit);
> -    if (bootindex >= 0) {
> -        object_property_set_int(OBJECT(dev), "bootindex", bootindex,
> -                                &error_abort);
> -    }

The fact that this is not called anymore means that the 'set' method for
the property is also not called. Here, that method is
device_set_bootindex() (as configured by scsi_dev_instance_init() ->
device_add_bootindex_property()). Therefore, the device is never
registered via add_boot_device_path() meaning that the bootindex
property does not have the desired effect anymore.

Is it necessary to keep the object_property_set_{bool,int} and
qdev_prop_set_enum calls around for these potential side effects? Would
it even be necessary to introduce new similar calls for the newly
supported properties? Or is there an easy alternative to
s->conf = *conf;
that does trigger the side effects?

>      if (object_property_find(OBJECT(dev), "removable")) {
>          qdev_prop_set_bit(dev, "removable", removable);
>      }
> @@ -414,19 +411,12 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>          object_unparent(OBJECT(dev));
>          return NULL;
>      }
> -    if (!object_property_set_bool(OBJECT(dev), "share-rw", share_rw, errp)) {
> -        object_unparent(OBJECT(dev));
> -        return NULL;
> -    }
> -
> -    qdev_prop_set_enum(dev, "rerror", rerror);
> -    qdev_prop_set_enum(dev, "werror", werror);
>  
>      if (!qdev_realize_and_unref(dev, &bus->qbus, errp)) {
>          object_unparent(OBJECT(dev));
>          return NULL;
>      }
> -    return SCSI_DEVICE(dev);
> +    return s;
>  }
>  
>  void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
[0]: https://forum.proxmox.com/threads/149772/post-679433

Best Regards,
Fiona


