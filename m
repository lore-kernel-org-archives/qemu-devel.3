Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76665C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubaL0-0008Ed-Jh; Tue, 15 Jul 2025 03:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubaKy-0008Dz-AR
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:44:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubaKq-0002lq-PK
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:44:28 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56F7gmrF023054
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 15 Jul 2025 16:42:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kx29O3j64MckhEwy/8xrLI+WMcwnZ0a/DV+G30DWIt4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752565368; v=1;
 b=EM8wQ8HW2O8SSEOhYmNg3PskWpwOwfaKYdS/xScxjL8o43n2ua8JiFXFbFGzEN87
 GCRt0wfCypl49ZS4Y1xHX5tC/eh9eh6n9Eutc8CwvvDdguSrEDYa17zt5tA6Dp5v
 de13QRh2oVK9ZWfHNw3lr9iAdEV4wFmPhq0m1sM0JjEORML1876fuQtxc0RhWsgE
 6E34F9YMbUxRx1PJlS9UK3YPbFKSNfv/f6+etly4NbpITgZvM4WlWC7/sNuQkyLC
 /wI7Yc4s14XUz9MyB4ek44cxdOEFxWLcTP/+/Uf2ZfWhTOnZN14coQXqAzG0qAbB
 Tu689Fp4DYpsSFfcL//DDQ==
Message-ID: <8af39b78-a95d-4093-b68c-20b556860a09@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 15 Jul 2025 16:42:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/13] virtio-pci: implement support for extended
 features
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <eb1aa9c8442d9b482b5c84fdca54b92c8a824495.1752229731.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <eb1aa9c8442d9b482b5c84fdca54b92c8a824495.1752229731.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/11 22:02, Paolo Abeni wrote:
> Extend the features configuration space to 128 bits, and allow the
> common read/write operation to access all of it.
> 
> On migration, save the 128 bit version of the features only if the
> upper bits are non zero; after load zero the upper bits if the extended
> features were not loaded.
> 
> Note that we must clear the proxy-ed features on device reset, otherwise
> a guest kernel not supporting extended features booted after an extended
> features enabled one could end-up wrongly inheriting extended features.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>    - use separate VMStateDescription and pre/post load to avoid breaking
>      migration
>    - clear proxy features on device reset
> ---
>   hw/virtio/virtio-pci.c         | 101 +++++++++++++++++++++++++++++----
>   include/hw/virtio/virtio-pci.h |   6 +-
>   2 files changed, 96 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index fba2372c93..dc5e7eaf81 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -108,6 +108,39 @@ static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
>       }
>   };
>   
> +static bool virtio_pci_modern_state_features128_needed(void *opaque)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    uint32_t features = 0;
> +    int i;
> +
> +    for (i = 2; i < ARRAY_SIZE(proxy->guest_features128); ++i) {
> +        features |= proxy->guest_features128[i];
> +    }
> +    return !!features;

"!!" is unnecessary; the implicit cast will clamp the value into true/false.

> +}
> +
> +static int virtio_pci_modern_state_features128_post_load(void *opaque,
> +                                                         int version_id)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +
> +    proxy->extended_features_loaded = true;
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_pci_modern_state_features128 = {
> +    .name = "virtio_pci/modern_state/features128",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = &virtio_pci_modern_state_features128_post_load,
> +    .needed = &virtio_pci_modern_state_features128_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(guest_features128, VirtIOPCIProxy, 4),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool virtio_pci_modern_state_needed(void *opaque)
>   {
>       VirtIOPCIProxy *proxy = opaque;
> @@ -115,10 +148,40 @@ static bool virtio_pci_modern_state_needed(void *opaque)
>       return virtio_pci_modern(proxy);
>   }
>   
> +static int virtio_pci_modern_state_pre_load(void *opaque)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +
> +    proxy->extended_features_loaded = false;
> +    return 0;
> +}
> +
> +static int virtio_pci_modern_state_post_load(void *opaque, int version_id)
> +{
> +    VirtIOPCIProxy *proxy = opaque;
> +    int i;
> +
> +    if (proxy->extended_features_loaded) {
> +        return 0;
> +    }
> +
> +    QEMU_BUILD_BUG_ON(offsetof(VirtIOPCIProxy, guest_features[0]) !=
> +                      offsetof(VirtIOPCIProxy, guest_features128[0]));
> +    QEMU_BUILD_BUG_ON(offsetof(VirtIOPCIProxy, guest_features[1]) !=
> +                      offsetof(VirtIOPCIProxy, guest_features128[1]));
> +
> +    for (i = 2; i < ARRAY_SIZE(proxy->guest_features128); ++i) {
> +        proxy->guest_features128[i] = 0;
> +    }
> +    return 0;
> +}
> +

You can expect the device is in the reset state when migrating so expect 
guest_features128 is initialized as zero; there are already plenty of 
code expecting the reset state.

>   static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>       .name = "virtio_pci/modern_state",
>       .version_id = 1,
>       .minimum_version_id = 1,
> +    .pre_load = &virtio_pci_modern_state_pre_load,
> +    .post_load = &virtio_pci_modern_state_post_load,
>       .needed = &virtio_pci_modern_state_needed,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
> @@ -128,6 +191,10 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>                                vmstate_virtio_pci_modern_queue_state,
>                                VirtIOPCIQueue),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_virtio_pci_modern_state_features128,
> +        NULL
>       }
>   };
>   
> @@ -1493,19 +1560,22 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
>           val = proxy->dfselect;
>           break;
>       case VIRTIO_PCI_COMMON_DF:
> -        if (proxy->dfselect <= 1) {
> +        if (proxy->dfselect < VIRTIO_FEATURES_WORDS) {
>               VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>   
> -            val = (vdev->host_features & ~vdc->legacy_features) >>
> -                (32 * proxy->dfselect);
> +            val = vdev->host_features_array[proxy->dfselect >> 1] >>
> +                  (32 * (proxy->dfselect & 1));
> +            if (proxy->dfselect <= 1) {
> +                val &= (~vdc->legacy_features) >> (32 * proxy->dfselect);
> +            }
>           }
>           break;
>       case VIRTIO_PCI_COMMON_GFSELECT:
>           val = proxy->gfselect;
>           break;
>       case VIRTIO_PCI_COMMON_GF:
> -        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
> -            val = proxy->guest_features[proxy->gfselect];
> +        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features128)) {
> +            val = proxy->guest_features128[proxy->gfselect];
>           }
>           break;
>       case VIRTIO_PCI_COMMON_MSIX:
> @@ -1587,11 +1657,18 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>           proxy->gfselect = val;
>           break;
>       case VIRTIO_PCI_COMMON_GF:
> -        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
> -            proxy->guest_features[proxy->gfselect] = val;
> -            virtio_set_features(vdev,
> -                                (((uint64_t)proxy->guest_features[1]) << 32) |
> -                                proxy->guest_features[0]);
> +        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features128)) {
> +            uint64_t features[VIRTIO_FEATURES_DWORDS];
> +            int i;
> +
> +            proxy->guest_features128[proxy->gfselect] = val;
> +            virtio_features_clear(features);
> +            for (i = 0; i < ARRAY_SIZE(proxy->guest_features128); ++i) {
> +                uint64_t cur = proxy->guest_features128[i];
> +
> +                features[i >> 1] |= cur << ((i & 1) * 32);
> +            }
> +            virtio_set_features_ex(vdev, features);
>           }
>           break;
>       case VIRTIO_PCI_COMMON_MSIX:
> @@ -2310,6 +2387,10 @@ static void virtio_pci_reset(DeviceState *qdev)
>       virtio_bus_reset(bus);
>       msix_unuse_all_vectors(&proxy->pci_dev);
>   
> +    /* be sure to not carry over any feature across reset */

It's obvious so I don't think the comment makes difference.

> +    memset(proxy->guest_features128, 0, sizeof(uint32_t) *
> +           ARRAY_SIZE(proxy->guest_features128));

Simpler:
memset(proxy->guest_features128, 0, sizeof(proxy->guest_features128);

> +
>       for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>           proxy->vqs[i].enabled = 0;
>           proxy->vqs[i].reset = 0;
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index eab5394898..1868e3b106 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -151,6 +151,7 @@ struct VirtIOPCIProxy {
>       uint32_t flags;
>       bool disable_modern;
>       bool ignore_backend_features;
> +    bool extended_features_loaded;
>       OnOffAuto disable_legacy;
>       /* Transitional device id */
>       uint16_t trans_devid;
> @@ -158,7 +159,10 @@ struct VirtIOPCIProxy {
>       uint32_t nvectors;
>       uint32_t dfselect;
>       uint32_t gfselect;
> -    uint32_t guest_features[2];
> +    union {
> +        uint32_t guest_features[2];
> +        uint32_t guest_features128[4];
> +    };

I don't see anything preventing you from directly extending guest_features.

>       VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
>   
>       VirtIOIRQFD *vector_irqfd;


