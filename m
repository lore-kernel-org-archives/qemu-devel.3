Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1085C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdVq8-0007iH-In; Mon, 12 Aug 2024 10:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdVq6-0007hf-52
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdVq2-0005wS-34
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723472156;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UH8ydXm9bz2h2parXFjgTUBwcqKkC0z4G1MTvG5w+SE=;
 b=PASRREhdkE6OWdD5xoVAZmxIiQ4tPWHH00Dp9OXu3i6gazs7zE5m1PdkbsgL0eHwBcD0qB
 k1aWc9yICb1Eng91q7+Nwymmf5O4kNvDNFU1ihxR7MXmwuU/vz264qGIPFshaPPK4AeacC
 SMAkOLRnid+Rx28CjdBUSQMhPTXtmKY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-20M8SQ7eOMy770C-8H0AUA-1; Mon,
 12 Aug 2024 10:15:52 -0400
X-MC-Unique: 20M8SQ7eOMy770C-8H0AUA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2290019541A9; Mon, 12 Aug 2024 14:15:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.211])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE61F1955D71; Mon, 12 Aug 2024 14:15:44 +0000 (UTC)
Date: Mon, 12 Aug 2024 15:15:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v3 3/5] device/virtio-nsm: Support for Nitro Secure
 Module device
Message-ID: <ZroZDegFxUbLC2KH@redhat.com>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-4-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240810164502.19693-4-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Aug 10, 2024 at 10:45:00PM +0600, Dorjoy Chowdhury wrote:
> Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves for
> stripped down TPM functionality like cryptographic attestation. The
> requests to and responses from NSM device are CBOR[2] encoded.
> 
> This commit adds support for NSM device in QEMU. Although related to
> AWS Nitro Enclaves, the virito-nsm device is independent and can be
> used in other machine types as well. The libcbor[3] library has been
> used for the CBOR encoding and decoding functionalities.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> [2] http://cbor.io/
> [3] https://libcbor.readthedocs.io/en/latest/
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  MAINTAINERS                    |    8 +
>  hw/virtio/Kconfig              |    5 +
>  hw/virtio/meson.build          |    4 +
>  hw/virtio/virtio-nsm-pci.c     |   73 ++
>  hw/virtio/virtio-nsm.c         | 1929 ++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-nsm.h |   59 +
>  6 files changed, 2078 insertions(+)
>  create mode 100644 hw/virtio/virtio-nsm-pci.c
>  create mode 100644 hw/virtio/virtio-nsm.c
>  create mode 100644 include/hw/virtio/virtio-nsm.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8d63031f0..05b66a7f93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2349,6 +2349,14 @@ F: include/sysemu/rng*.h
>  F: backends/rng*.c
>  F: tests/qtest/virtio-rng-test.c
>  
> +virtio-nsm
> +M: Alexander Graf <graf@amazon.com>
> +M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> +S: Maintained
> +F: hw/virtio/virtio-nsm.c
> +F: hw/virtio/virtio-nsm-pci.c
> +F: include/hw/virtio/virtio-nsm.h
> +
>  vhost-user-stubs
>  M: Alex Bennée <alex.bennee@linaro.org>
>  S: Maintained
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index aa63ff7fd4..29fee32035 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -6,6 +6,11 @@ config VIRTIO_RNG
>      default y
>      depends on VIRTIO
>  
> +config VIRTIO_NSM
> +   bool
> +   default y
> +   depends on VIRTIO
> +
>  config VIRTIO_IOMMU
>      bool
>      default y
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 621fc65454..831819eefb 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -48,12 +48,15 @@ else
>    system_virtio_ss.add(files('vhost-stub.c'))
>  endif
>  
> +libcbor = dependency('libcbor', version: '>=0.8.0')
> +
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
> +specific_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm.c'), libcbor])
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
>  specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
> @@ -70,6 +73,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto-pc
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm-pci.c'), libcbor])
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scsi-pci.c'))
> diff --git a/hw/virtio/virtio-nsm-pci.c b/hw/virtio/virtio-nsm-pci.c
> new file mode 100644
> index 0000000000..dca797315a
> --- /dev/null
> +++ b/hw/virtio/virtio-nsm-pci.c
> @@ -0,0 +1,73 @@
> +/*
> + * AWS Nitro Secure Module (NSM) device
> + *
> + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-nsm.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +
> +typedef struct VirtIONsmPCI VirtIONsmPCI;
> +
> +#define TYPE_VIRTIO_NSM_PCI "virtio-nsm-pci-base"
> +DECLARE_INSTANCE_CHECKER(VirtIONsmPCI, VIRTIO_NSM_PCI,
> +                         TYPE_VIRTIO_NSM_PCI)
> +
> +struct VirtIONsmPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIONSM vdev;
> +};
> +
> +static void virtio_nsm_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIONsmPCI *vnsm = VIRTIO_NSM_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&vnsm->vdev);
> +
> +    virtio_pci_force_virtio_1(vpci_dev);
> +
> +    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
> +        return;
> +    }
> +}
> +
> +static void virtio_nsm_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +
> +    k->realize = virtio_nsm_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static void virtio_nsm_initfn(Object *obj)
> +{
> +    VirtIONsmPCI *dev = VIRTIO_NSM_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_NSM);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_nsm_pci_info = {
> +    .base_name             = TYPE_VIRTIO_NSM_PCI,
> +    .generic_name          = "virtio-nsm-pci",
> +    .instance_size = sizeof(VirtIONsmPCI),
> +    .instance_init = virtio_nsm_initfn,
> +    .class_init    = virtio_nsm_pci_class_init,
> +};
> +
> +static void virtio_nsm_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_nsm_pci_info);
> +}
> +
> +type_init(virtio_nsm_pci_register)
> diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
> new file mode 100644
> index 0000000000..1610bcedc6
> --- /dev/null
> +++ b/hw/virtio/virtio-nsm.c
> @@ -0,0 +1,1929 @@
> +/*
> + * AWS Nitro Secure Module (NSM) device
> + *
> + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/guest-random.h"
> +#include "qapi/error.h"
> +#include <cbor.h>
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-nsm.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +
> +#define NSM_PCR_DATA_REQ_MAX_SIZE 512
> +
> +enum NSMResponseTypes {
> +    NSM_SUCCESS = 0,
> +    NSM_INVALID_ARGUMENT = 1,
> +    NSM_INVALID_INDEX = 2,
> +    NSM_READONLY_INDEX = 3,
> +    NSM_INVALID_OPERATION = 4,
> +    NSM_BUFFER_TOO_SMALL = 5,
> +    NSM_INPUT_TOO_LARGE = 6,
> +    NSM_INTERNAL_ERROR = 7,
> +};
> +
> +static bool qemu_cbor_map_add(cbor_item_t *map, cbor_item_t *key,
> +                              cbor_item_t *value)
> +{
> +    bool success = false;
> +    struct cbor_pair pair = (struct cbor_pair) {
> +        .key = cbor_move(key),
> +        .value = cbor_move(value)
> +    };
> +
> +    success = cbor_map_add(map, pair);
> +    if (!success) {
> +        cbor_incref(pair.key);
> +        cbor_incref(pair.value);
> +    }
> +
> +    return success;
> +}

I'd suggest all these 'qemu_cbor_' helper methods could be split off into a
separate file, since this virtio-nsm.c is pretty large with all these helpers
inlines.

> +static bool extend_pcr(VirtIONSM *vnsm, int ind, uint8_t *data, uint16_t len)
> +{
> +    GChecksum *hasher = g_checksum_new(G_CHECKSUM_SHA384);
> +    struct PCRInfo *pcr = &(vnsm->pcrs[ind]);
> +    size_t digest_len = SHA384_BYTE_LEN;
> +    if (!hasher) {
> +        return false;
> +    }
> +
> +    g_checksum_update(hasher, pcr->data, SHA384_BYTE_LEN);
> +    g_checksum_update(hasher, data, len);
> +
> +    g_checksum_get_digest(hasher, pcr->data, &digest_len);
> +
> +    g_checksum_free(hasher);
> +    return true;
> +}

Use the qcrypto hash APIs instead of GChecksum please.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


