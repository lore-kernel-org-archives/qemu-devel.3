Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60D6C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqsg3-0000UM-Fb; Mon, 03 Aug 2026 09:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqsft-0000Sq-KU
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 09:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqsfr-0003PN-Na
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 09:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785763546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOX8diclUwjuyBFzboDXYdU0h5J72iNEgPdSzXC3oyI=;
 b=J1Zi/5ZK828HVw4sLThQl3CnhRTM48XtO9USNY2KrWB+XXk9wXfCfqC8aFZFRK+QjRWfbQ
 F2zOR233GJCqabfOAV6MJkT5zTKqFF3mLGeYKInu49JnWoHtVvcT9Og4c3NP/PWRVUK1CD
 If4JtMj87uwod+qLNY3g1eYrCBVvxoA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-_IRu8O8pObSHBEwDqHUaZA-1; Mon, 03 Aug 2026 09:25:44 -0400
X-MC-Unique: _IRu8O8pObSHBEwDqHUaZA-1
X-Mimecast-MFC-AGG-ID: _IRu8O8pObSHBEwDqHUaZA_1785763544
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495517d39fbso11675495e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785763524; x=1786368324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rOX8diclUwjuyBFzboDXYdU0h5J72iNEgPdSzXC3oyI=;
 b=fBT96mhQEGQk6ERaIrDWwxrX8u6lrSzDZWcxmSl/wdi7AjS2bm0NNMyFdDjwEpzNSq
 Aq/ZgECc3le861dThsSEMzRpeUYc87sAK50Njr6a7qxVdn7vhtByZq0agqxr191Z8IqH
 8Dwh8d0jNLz8U1Jw0A2+HUbqmYt92DPOlMsXaVBT9XhwTmyf37JISpeKoKA43onf9tl6
 MZq2ai5x8mF6geasMEjEAn/jli5yKrO9FQBfOG7nBme6MOOyfHUs7CAsBZAHc/PECaNi
 GPaaEmaQps/QDVYyC16Gd0DgseD+zdbpWdpB0LPiUJWk1MwNxfuu1KYAwQI4nRpGJtUt
 l2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763524; x=1786368324;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rOX8diclUwjuyBFzboDXYdU0h5J72iNEgPdSzXC3oyI=;
 b=J3TXIaEGN2/QUnjhECKQrmQwRZL8HxbmKzqkfcRZKxN08s1IuCYPAjz39qwO3zb0Ph
 yAzdu68qtcc5kOFae0VMfEp34PVVOKCMNp56GahG0bZRCy4NHMmLIn9fTtrwtiJ39CHC
 rY5Bo/E6UeQXrdF3YcyhmbRqKTTLCBDWs9Lb3ZjaIQux1cLJuSBdrJMvIWqwVbRDt2Vn
 8OIf+RR+P1831pPNHrVwLIDmcmyp6MysD0VnUYC/7z6RDuEyh5JL2BKydHQj85MuyXh0
 RzSyEr8B6wSDya6eixd60RN1o4bP/i8mzxgUEHZPlHmEbqtTZ4pw6c4d97fb/CV6PDcd
 4L2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHsOhYq9/fHBKWQuFbEwG5TfMkatLx/6Cq0R2M/TSGNPYeZ0wkpAEj3gl5gCAQYTb56uhaWuYiQgqx@nongnu.org
X-Gm-Message-State: AOJu0YxJ0+EqOmWwA4ouPZqPqNSHCnSVuyMJxVXttD0/8jtgNWOziluK
 IndAYI8SC66k0j+X5MPZAOrhCs1rt98tOwWIiVTyQDCLjsPHm4i6LXISuQsbdOgjTgnjpoZfV8z
 Yt75EnRFC3i6gcne+dX1mqR6/Bbn0J1O2HUFv1S7J43CIhNapf5dP10vY
X-Gm-Gg: AR+sD13gIADTKycIO+Mj8omxUwX8UbhC4JEy3r+CyraYeWX1RRKoOp0yqQVswndJL29
 xLWVmVjgi1cpJuAq3r3j5C6PySW//JbQ1n5z3ry3bJLEgaZxVwNQWo73/QgxUj8klFIliNlJqoq
 j2p78EX0eijD9KUVE7B5z+OWtGULAIMEQW104t/PSwVOqddLfRZ+YpVZix7S9/FiHryHriX7MGF
 797+aHGy9Ks3nAOuNb2eYDt2o59a9+aFiRGb9tTuxOQCEFqR94OmR6sYv4SiDwnRImvv1wphLhl
 Zw+oOxrXTlehIQzstOJHL1eLB9bzoLT14nSNP3U24CVzEZEL2u3gT8ktm2GzHCzzigzm1G1bvL1
 E/mSQej7OfDdyQpHFaggJBAdXFlfhLdHvzcb8lmddv6bPkN6w6ag19Kl98zopJHK4l1ZCaakMaa
 PsRE6HQluAjt5wOQBUbTkbXMZYWgffZg==
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id
 5b1f17b1804b1-4980c66b572mr209023725e9.8.1785763524120; 
 Mon, 03 Aug 2026 06:25:24 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id
 5b1f17b1804b1-4980c66b572mr209022325e9.8.1785763523478; 
 Mon, 03 Aug 2026 06:25:23 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b59a5bsm219618935e9.3.2026.08.03.06.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 06:25:22 -0700 (PDT)
Message-ID: <b6bc052c-1bf5-449b-85d0-e1c4624a5d99@redhat.com>
Date: Mon, 3 Aug 2026 15:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24.07.26 00:30, Connor Kite wrote:
> If memory isolation mode is active for the vhost-user device adds
> features to:
> - Gather the size required for bounce buffers and vrings in shared
>    isolation region
> - Allocate the required space in an anonymous file
> - Create a vhost-iova-tree with space to map entire isolation region
> - Map guest memory regions and shared vrings into the tree
> - Release these resources upon backend cleanup
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 129 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index f296b63fb9..710cf966f8 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -18,6 +18,7 @@
>   #include "hw/virtio/vhost-backend.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/vhost-iova-tree.h"
>   #include "chardev/char-fe.h"
>   #include "io/channel-socket.h"
>   #include "system/kvm.h"
> @@ -25,6 +26,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/uuid.h"
>   #include "qemu/sockets.h"
> +#include "qemu/memfd.h"
>   #include "system/runstate.h"
>   #include "system/cryptodev.h"
>   #include "migration/postcopy-ram.h"
> @@ -320,6 +322,13 @@ static VhostUserMsg m __attribute__ ((unused));
>   /* The version of the protocol we support */
>   #define VHOST_USER_VERSION    (0x1)
>   
> +typedef struct IsolationRegion {
> +    uint64_t base_addr;
> +    uint64_t vring_base_addr;
> +    uint64_t size;
> +    int iso_fd;
> +} IsolationRegion;
> +

Going beyond Stefan, I would say please document each field with a 
proper doc comment, and ideally the whole struct, too.

>   struct vhost_user {
>       struct vhost_dev *dev;
>       /* Shared between vhost devs of the same virtio device */
> @@ -353,6 +362,10 @@ struct vhost_user {
>        * by the backend (see @features).
>        */
>       uint64_t protocol_features;
> +
> +    /* Isolated memory data*/

In general: Please put spaces after the leading /* and before the 
trailing */.

> +    struct IsolationRegion iso_memory;
> +    VhostIOVATree *iso_iova_tree;

Patch 13 adds more variables to this, so I think it may make sense to 
have a dedicated struct for these fields.

>   };
>   
>   struct scrub_regions {
> @@ -1109,6 +1122,121 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>       return 0;
>   }
>   
> +/* TODO: Is there any notifier cleanup required here?*/
> +static void cleanup_isolation_regions(struct vhost_dev *dev)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    if (u->iso_memory.base_addr) {
> +        vhost_iova_tree_delete(u->iso_iova_tree);
> +        u->iso_iova_tree = NULL;
> +        memset(&u->iso_memory, 0, sizeof(IsolationRegion));
> +        qemu_memfd_free((gpointer) u->iso_memory.base_addr, u->iso_memory.size,
> +                         u->iso_memory.iso_fd);

As Akihiko said, the memset() should come after this, and also...

> +        u->iso_memory.base_addr = 0;

...this is just a subset of the memset().

> +    }
> +}
> +
> +__attribute__((unused))
> +static int init_isolation_regions(struct vhost_dev *dev,
> +                                  VhostUserMsg *msg,
> +                                  int *fds, size_t *fd_num)
> +{
> +    Error *err = NULL;
> +    struct vhost_user *u = dev->opaque;
> +    uint32_t nregions = dev->mem->nregions;
> +    uint64_t buffer_reg_size = 0;
> +    DMAMap newEntry = {
> +        .perm = IOMMU_RW
> +    };
> +    g_autoptr(GArray) buffer_regions =
> +        g_array_new(FALSE, TRUE, sizeof(DMAMap));
> +
> +    msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
> +
> +    /* In case of reset, clear old regions*/
> +    if (u->iso_memory.base_addr != 0) {
> +        cleanup_isolation_regions(dev);
> +        vhost_iova_tree_delete(u->iso_iova_tree);
> +    }

(What Akihiko said)

> +
> +    /* Gather information for bounce buffers to be mapped */
> +    for (int i = 0; i < nregions; i++) {
> +        struct vhost_memory_region *dev_region = &dev->mem->regions[i];
> +        hwaddr size = ROUND_UP(dev_region->memory_size,
> +                      qemu_real_host_page_size());
> +        newEntry.translated_addr = dev_region->guest_phys_addr;
> +        newEntry.size = size - 1;
> +        buffer_reg_size += size;
> +        g_array_append_val(buffer_regions, newEntry);
> +    }
> +
> +    int num;
> +    size_t desc_size;
> +    size_t avail_size;
> +    size_t driver_area_size;
> +    size_t device_area_size;
> +    size_t total_vring_size = 0;
> +    size_t total_mmap_size;

Please do not mix variable declarations and normal code (style.rst calls 
it “Mixed declarations”).

> +
> +    /* Get space required for all vrings */
> +    for (int j = 0; j < dev->nvqs; j++) {

Why j here and i above and below?

> +        num = virtio_queue_get_num(dev->vdev, dev->vq_index + j);
> +        desc_size = sizeof(vring_desc_t) * num;
> +        avail_size = offsetof(vring_avail_t, ring[num]) +
> +                        sizeof(uint16_t);
> +        driver_area_size = ROUND_UP(desc_size + avail_size,
> +                            qemu_real_host_page_size());
> +        device_area_size = ROUND_UP(offsetof(vring_used_t, ring[num]) +
> +                                    sizeof(uint16_t),
> +                                    qemu_real_host_page_size());
> +        total_vring_size += driver_area_size + device_area_size;
> +    }
> +
> +    total_mmap_size = buffer_reg_size + total_vring_size;
> +
> +    /* Allocate and map an anonymous file to hold the isolation region */
> +    u->iso_memory.base_addr = (uint64_t) qemu_memfd_alloc("iso_r",
> +                              total_mmap_size,
> +                              F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                              &u->iso_memory.iso_fd, &err);
> +    u->iso_memory.size = total_mmap_size;
> +
> +    if (err) {
> +        error_report_err(err);
> +        cleanup_isolation_regions(dev);
> +        return -1;
> +    }
> +
> +    uint64_t last_addr = int128_get64(int128_add(u->iso_memory.base_addr,
> +                                                 total_mmap_size - 1));

I would like a comment why you went for a 128-bit operation here. I 
assume it is because it checks for overflow, turning overflow into an 
assertion failure, and it can be assumed `qemu_memfd_alloc()` must 
naturally return a pointer such that adding the length of the allocated 
area to it (minus one) will never overflow?

The question is, do we even need to check for overflow then. Not that I 
mind it, in principle, I just find it non-obvious. (The more obvious 
check (imho) would be to just do a 64-bit operation and then 
assert(last_addr >= u->iso_memory.base_addr).)

> +
> +    /*
> +     * Instantiates iova tree sized to map bounce buffers and vrings to the
> +     * isolation region in host va.
> +     */
> +    u->iso_iova_tree = vhost_iova_tree_new(u->iso_memory.base_addr, last_addr);
> +
> +    assert(&u->iso_memory.iso_fd >= 0);
> +    DMAMap *map;
> +    DMAMap vring_map = {
> +        .perm = IOMMU_RW,
> +        .size = total_vring_size - 1,
> +        /*vrings are allocated on tree first, so will be assigned base addr*/
> +        .translated_addr = u->iso_memory.base_addr
> +    };
> +
> +    vhost_iova_tree_map_alloc(u->iso_iova_tree, &vring_map,
> +                              vring_map.translated_addr);
> +    u->iso_memory.vring_base_addr = vring_map.iova;
> +    for (int i = 0; i < buffer_regions->len; i++) {
> +        map = &g_array_index(buffer_regions, DMAMap, i);

God, I *really*, *really* hate this, and find it really disgusting that 
the documentation actually recommends doing this (`&g_array_index()`) 
instead of just offering a separate macro to get a reference.

And existing qemu code does it all over the place, too.

So I cannot really fault you for it.

Still. Too ugly for me to keep completely silent about it.

</rant>

Hanna

> +        vhost_iova_tree_map_alloc_gpa(u->iso_iova_tree, map,
> +                                      map->translated_addr);
> +    }
> +
> +    return 0;
> +}
> +
>   static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                       struct vhost_memory *mem)
>   {
> @@ -2681,6 +2809,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
>       g_free(u->region_rb_offset);
>       u->region_rb_offset = NULL;
>       u->region_rb_len = 0;
> +    cleanup_isolation_regions(dev);
>       g_free(u);
>       dev->opaque = 0;
>   
>


