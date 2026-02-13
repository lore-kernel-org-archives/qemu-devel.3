Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3DBEEA849
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 01:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqhqi-0003A9-HI; Thu, 12 Feb 2026 20:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqhqf-00039r-H1; Thu, 12 Feb 2026 20:19:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqhqc-00018d-SG; Thu, 12 Feb 2026 20:19:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E08C75969F6;
 Fri, 13 Feb 2026 02:19:48 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GtrPMCm6K5am; Fri, 13 Feb 2026 02:19:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C3085596A0B; Fri, 13 Feb 2026 02:19:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C0BC35969F0;
 Fri, 13 Feb 2026 02:19:46 +0100 (CET)
Date: Fri, 13 Feb 2026 02:19:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com, 
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/3] hw/virtio: add virtio_vdev_is_{modern, legacy}
In-Reply-To: <20260212234602.338131-2-pierrick.bouvier@linaro.org>
Message-ID: <2b9d7a72-0245-35db-094c-48925081d5c1@eik.bme.hu>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <20260212234602.338131-2-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 12 Feb 2026, Pierrick Bouvier wrote:
> This simplifies code compared to having
> virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
> !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
> include/hw/virtio/virtio-access.h |  3 +--
> include/hw/virtio/virtio.h        | 12 +++++++++++-
> hw/net/virtio-net.c               |  2 +-
> hw/virtio/vhost.c                 |  2 +-
> hw/virtio/virtio-pci.c            |  2 +-
> hw/virtio/virtio.c                | 16 ++++++++--------
> 6 files changed, 23 insertions(+), 14 deletions(-)

It's longer than before with two more functions to look up when reading 
the code to understand it so I would not say it's simpler. Maybe more 
readable for some but I don't think it adds much more clarity and so patch 
could just be dropped. But I don't care so if others don't mind or think 
it's better then I don't mind.

Regards,
BALATON Zoltan

> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index cd17d0c87eb..324ba907e93 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -30,8 +30,7 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>     return virtio_is_big_endian(vdev);
> #elif TARGET_BIG_ENDIAN
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +    if (virtio_vdev_is_modern(vdev)) {
>         return false;
>     }
>     return true;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 27cd98d2fe1..8f1e4323599 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -468,9 +468,19 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
>     return virtio_has_feature(vdev->host_features, fbit);
> }
>
> +static inline bool virtio_vdev_is_modern(const VirtIODevice *vdev)
> +{
> +    return virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
> +}
> +
> +static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
> +{
> +    return !virtio_vdev_is_modern(vdev);
> +}
> +
> static inline bool virtio_is_big_endian(VirtIODevice *vdev)
> {
> -    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_legacy(vdev)) {
>         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
>         return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
>     }
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 512a7c02c93..313d3b88400 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -217,7 +217,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>     memcpy(&netcfg, config, n->config_size);
>
>     if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
> -        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> +        virtio_vdev_is_legacy(vdev) &&
>         memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
>         memcpy(n->mac, netcfg.mac, ETH_ALEN);
>         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 52801c1796b..70a112242b0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1168,7 +1168,7 @@ static void vhost_log_stop(MemoryListener *listener,
>  */
> static inline bool vhost_needs_vring_endian(VirtIODevice *vdev)
> {
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_modern(vdev)) {
>         return false;
>     }
> #if HOST_BIG_ENDIAN
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1e8f90df34e..6126187a164 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1449,7 +1449,7 @@ static bool virtio_pci_queue_enabled(DeviceState *d, int n)
>     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
>     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_modern(vdev)) {
>         return proxy->vqs[n].enabled;
>     }
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 77ca54e5206..b0987e66d5b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2279,7 +2279,7 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>     trace_virtio_set_status(vdev, val);
>     int ret = 0;
>
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_modern(vdev)) {
>         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
>             val & VIRTIO_CONFIG_S_FEATURES_OK) {
>             ret = virtio_validate_features(vdev);
> @@ -2365,7 +2365,7 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
>      * be re-enabled for new machine types only, and also after
>      * being converted to LOG_GUEST_ERROR.
>      *
> -    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_legacy(vdev)) {
>         error_report("queue_enable is only supported in devices of virtio "
>                      "1.0 or later.");
>     }
> @@ -2454,7 +2454,7 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
>     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>
>     /* virtio-1 compliant devices cannot change the alignment */
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_modern(vdev)) {
>         error_report("tried to modify queue alignment for virtio-1 device");
>         return;
>     }
> @@ -2753,7 +2753,7 @@ static bool virtio_device_endian_needed(void *opaque)
>     VirtIODevice *vdev = opaque;
>
>     assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> -    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_legacy(vdev)) {
>         return vdev->device_endian != virtio_default_endian();
>     }
>     /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> @@ -3228,7 +3228,7 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
>     }
>     if (!ret) {
>         if (!virtio_device_started(vdev, vdev->status) &&
> -            !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +            virtio_vdev_is_legacy(vdev)) {
>             vdev->start_on_kick = true;
>         }
>     }
> @@ -3446,7 +3446,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>     }
>
>     if (!virtio_device_started(vdev, vdev->status) &&
> -        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        virtio_vdev_is_legacy(vdev)) {
>         vdev->start_on_kick = true;
>     }
>
> @@ -3461,7 +3461,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>              * to calculate used and avail ring addresses based on the desc
>              * address.
>              */
> -            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +            if (virtio_vdev_is_modern(vdev)) {
>                 virtio_init_region_cache(vdev, i);
>             } else {
>                 virtio_queue_update_rings(vdev, i);
> @@ -4019,7 +4019,7 @@ void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
>     error_vreport(fmt, ap);
>     va_end(ap);
>
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +    if (virtio_vdev_is_modern(vdev)) {
>         vdev->status = vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET;
>         virtio_notify_config(vdev);
>     }
>

