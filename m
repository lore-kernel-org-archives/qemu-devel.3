Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC8AC55174
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 01:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqhUF-0007lL-TJ; Sun, 02 Aug 2026 21:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqhUE-0007kn-3x
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 21:29:02 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqhUC-0002Cz-0p
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 21:29:01 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-51c8e2e39easo25307851cf.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 18:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785720539; cv=none;
 d=google.com; s=arc-20260327;
 b=o75jXgZWE18unu/7ZtR3JAPSGGfsiXV61xouPFzgHoUMV1H4GR4Pf9AQpzaICdkCgG
 sY88sSpVE225PlWBNsqAvHBioQ3XveVKuA6IQQ2wlDzjfwiACOO90NBhuECmfnhHFm1u
 bnJew2A1t0RDbWKYpGTxTsaIQm3i2luOMwK2VyTV1wVO/0vghQXwNTlUB6KRI/N1D5UH
 0r0AxYMX3NjlS98YbmZXY1+lo2vmzXYfGXRl1jghGPaYzzw1C5422yHWTMbuOYxUssEZ
 twIL1jmL3eQEHcPWoDoRDVBKpcCjGUFKQBHXRVt5yP0IVnn0jztBCY+nvpJGIIpuLrxE
 JuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BBn0j7iI1Nqb2OtfHct3QoHfOlWs1RAEEWBSgQBWdPQ=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=GwMUrbcI1s1d2t3KArHEm/gllF6w2SNZuW23CnoyqmZ5BPXvC47iC/mvwRY0aSLDfj
 JfGW0k19+FVBWlYHxbR/KrnNV2X7otjn4GZMuzTqOYqcXzSQxH82QH0BPQeyN9CYGX1/
 vuZn5ZCokMCjx2G5/xpJwDdS1OYRmYhSx5FzpnBdctz40wkOcUT1x1eBX4xZPXoLtPw1
 pQOiSzmxYODp/U3jxcTJl/jdtAMQEDkMs8O3wcUfct/tmpwR/XEL4CGDEVh9qwBIva7C
 MRk1xsG31PEPud0j2BFA1reef2B5xcP3LVwwDAxOVxSpItxQfNFDcHGN1doFEqRr0xtn
 XZsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785720539; x=1786325339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BBn0j7iI1Nqb2OtfHct3QoHfOlWs1RAEEWBSgQBWdPQ=;
 b=JWzkWS9LLZsF5OwrJfIdQG+cGPWTlEgJuQGDSXEY5Dk36/jAc9GiOwvDm9kysXSDUT
 aG/R2FZdl/VaHxByv5UuBz2Z3JmJsbhyVCr+2X0bI+gm9ucbOAwJaemZqpcWsVu4Ffij
 y8KpRXhMSwTF56d75keLDtwjZGM6JhQUo4Cw+iassNBCemk0F55wYKiuJyI20CHtFmQS
 82IsKcPpsOYQL1qxhRQAFk1SaTXrT1MBPEZNGO6Qgx05DOuhKqtRc6Px55QqYRag1opm
 SRw79l/AoiVMVwI67rOYGrAiz9z1NqbUTdbmGxIde8Ha3edhC5xf0hN7D7N4vRZRGnYK
 ZBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785720539; x=1786325339;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BBn0j7iI1Nqb2OtfHct3QoHfOlWs1RAEEWBSgQBWdPQ=;
 b=KgRL+f7mbADM0XYoHQZY7S2LkgZSPiIv8HSYNkqfci57TzLf2KNfPe8e1ggGebQHhY
 HEpaZxyS9dJlpGyZP2U66y+n5M2a5YHFaZXDvWr3zltBZ1n4oYjmXuNoZEM2YmZv6mav
 XvBP8n6N0hH9SW6Ia21LJ+zE4mR+B7AuPmwBbXqNER8OtdR9ka/EWgu1AByDc0jLopia
 mrCF/KYFoJJejtTk+iEfUi3DSvnSs1+e1HZRsk6VtKsZLAalPk+xCm4ni2jR4e5Zqyy5
 Gak5z6YyMouKtSDdYlRBivf9KuWbNlThY8h/5vYnL9wXSTg6uxDAUlrGEewE6/Tbjj/J
 6tfw==
X-Gm-Message-State: AOJu0YzOljSoZ7NC4oUneCuCDYv+3k8t5ejIcZPXpWOSuAy1Z2uLHnS8
 MPKicHkeVyTu+1d2Nkh2mCgKClW0TWK1/jo7ViUY0a2/jRCsN/0GvTpaLZcIWuTDmD+cKn3yMAC
 7Y3QL8R5ufY1W/Rh3n5rfEpN1khpwTRA=
X-Gm-Gg: AR+sD12w8hBDmS+m598/s7ZRRHClzZD6v/JpeWz+IxS4qTHCikr51EbSRSSEWCqoLV/
 lHB2fb2WuWlqSAMOOGrWks4yyGTm0OPKcss8C+ayOBrtP6C3y120MOqkBpN7tSnaap8TT7nHUw2
 mWWKI3Hynzk7hoHo3QL8vEc26efHtRTsKclKDDfkjE8pGbNxsp62gMZo5OPePr8I7z11xsLj+oo
 hp3JMANIXOiya6yXDiauMqE0u7uv5VVTlD0vREcPb67pVm4qdszTv5PhHq366umNjqx2+qm71jf
 R/+cJp3aFae4JQjcxlJImIBxkrOdbzTAQOlIbO5H3yMsvjSCoxpxcUshxRY2dMaoGjV+tjyM8/h
 lxglufUsVka0=
X-Received: by 2002:a05:622a:34a:b0:50d:3e1e:7998 with SMTP id
 d75a77b69052e-52b567b2834mr159101381cf.37.1785720538621; Sun, 02 Aug 2026
 18:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
 <9f5869df-0484-456e-8060-b3a9f74a388b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <9f5869df-0484-456e-8060-b3a9f74a388b@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Sun, 2 Aug 2026 18:28:47 -0700
X-Gm-Features: AUfX_mzZDcm4a9vrCa4Ld9wCsHu6UqJwZERC-Vg76qBXAzrql4EJBxcYlE9h9LA
Message-ID: <CA+spn3oGVk0YNKNcFpiCWqg_EPNjeM9W2UwGwepRND27GP8ydg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Jul 24, 2026 at 5:53=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
...
>
> u->iso_memory is zeroed before they are read here.
>
...
>
> This should be new_entry as per: docs/devel/style.rst
>
...
>
> The check of u->iso_memory.base_addr is redundant;
> cleanup_isolation_regions() performs that check.
>
> cleanup_isolation_regions() also calls vhost_iova_tree_delete(), so the
> duplicate call of the function leads to use-after-free and double-free.
>

Thanks!  Will fix these.

>
> I wonder if it is fine to dismiss return values of
> vhost_iova_tree_map_alloc() and vhost_iova_tree_map_alloc_gpa().
>

It probably makes sense to add a check here and return with the value on er=
ror

On Fri, Jul 24, 2026 at 5:53=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/24 7:30, Connor Kite wrote:
> > If memory isolation mode is active for the vhost-user device adds
> > features to:
> > - Gather the size required for bounce buffers and vrings in shared
> >    isolation region
> > - Allocate the required space in an anonymous file
> > - Create a vhost-iova-tree with space to map entire isolation region
> > - Map guest memory regions and shared vrings into the tree
> > - Release these resources upon backend cleanup
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >   hw/virtio/vhost-user.c | 129 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 129 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index f296b63fb9..710cf966f8 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -18,6 +18,7 @@
> >   #include "hw/virtio/vhost-backend.h"
> >   #include "hw/virtio/virtio.h"
> >   #include "hw/virtio/virtio-net.h"
> > +#include "hw/virtio/vhost-iova-tree.h"
> >   #include "chardev/char-fe.h"
> >   #include "io/channel-socket.h"
> >   #include "system/kvm.h"
> > @@ -25,6 +26,7 @@
> >   #include "qemu/main-loop.h"
> >   #include "qemu/uuid.h"
> >   #include "qemu/sockets.h"
> > +#include "qemu/memfd.h"
> >   #include "system/runstate.h"
> >   #include "system/cryptodev.h"
> >   #include "migration/postcopy-ram.h"
> > @@ -320,6 +322,13 @@ static VhostUserMsg m __attribute__ ((unused));
> >   /* The version of the protocol we support */
> >   #define VHOST_USER_VERSION    (0x1)
> >
> > +typedef struct IsolationRegion {
> > +    uint64_t base_addr;
> > +    uint64_t vring_base_addr;
> > +    uint64_t size;
> > +    int iso_fd;
> > +} IsolationRegion;
> > +
> >   struct vhost_user {
> >       struct vhost_dev *dev;
> >       /* Shared between vhost devs of the same virtio device */
> > @@ -353,6 +362,10 @@ struct vhost_user {
> >        * by the backend (see @features).
> >        */
> >       uint64_t protocol_features;
> > +
> > +    /* Isolated memory data*/
> > +    struct IsolationRegion iso_memory;
> > +    VhostIOVATree *iso_iova_tree;
> >   };
> >
> >   struct scrub_regions {
> > @@ -1109,6 +1122,121 @@ static int vhost_user_set_mem_table_postcopy(st=
ruct vhost_dev *dev,
> >       return 0;
> >   }
> >
> > +/* TODO: Is there any notifier cleanup required here?*/
> > +static void cleanup_isolation_regions(struct vhost_dev *dev)
> > +{
> > +    struct vhost_user *u =3D dev->opaque;
> > +    if (u->iso_memory.base_addr) {
> > +        vhost_iova_tree_delete(u->iso_iova_tree);
> > +        u->iso_iova_tree =3D NULL;
> > +        memset(&u->iso_memory, 0, sizeof(IsolationRegion));
> > +        qemu_memfd_free((gpointer) u->iso_memory.base_addr, u->iso_mem=
ory.size,
> > +                         u->iso_memory.iso_fd);
>
> u->iso_memory is zeroed before they are read here.
>
> > +        u->iso_memory.base_addr =3D 0;
> > +    }
> > +}
> > +
> > +__attribute__((unused))
> > +static int init_isolation_regions(struct vhost_dev *dev,
> > +                                  VhostUserMsg *msg,
> > +                                  int *fds, size_t *fd_num)
> > +{
> > +    Error *err =3D NULL;
> > +    struct vhost_user *u =3D dev->opaque;
> > +    uint32_t nregions =3D dev->mem->nregions;
> > +    uint64_t buffer_reg_size =3D 0;
> > +    DMAMap newEntry =3D {
>
> This should be new_entry as per: docs/devel/style.rst
>
> > +        .perm =3D IOMMU_RW
> > +    };
> > +    g_autoptr(GArray) buffer_regions =3D
> > +        g_array_new(FALSE, TRUE, sizeof(DMAMap));
> > +
> > +    msg->hdr.request =3D VHOST_USER_SET_MEM_TABLE;
> > +
> > +    /* In case of reset, clear old regions*/
> > +    if (u->iso_memory.base_addr !=3D 0) {
> > +        cleanup_isolation_regions(dev);
> > +        vhost_iova_tree_delete(u->iso_iova_tree);
> > +    }
>
> The check of u->iso_memory.base_addr is redundant;
> cleanup_isolation_regions() performs that check.
>
> cleanup_isolation_regions() also calls vhost_iova_tree_delete(), so the
> duplicate call of the function leads to use-after-free and double-free.
>
> > +
> > +    /* Gather information for bounce buffers to be mapped */
> > +    for (int i =3D 0; i < nregions; i++) {
> > +        struct vhost_memory_region *dev_region =3D &dev->mem->regions[=
i];
> > +        hwaddr size =3D ROUND_UP(dev_region->memory_size,
> > +                      qemu_real_host_page_size());
> > +        newEntry.translated_addr =3D dev_region->guest_phys_addr;
> > +        newEntry.size =3D size - 1;
> > +        buffer_reg_size +=3D size;
> > +        g_array_append_val(buffer_regions, newEntry);
> > +    }
> > +
> > +    int num;
> > +    size_t desc_size;
> > +    size_t avail_size;
> > +    size_t driver_area_size;
> > +    size_t device_area_size;
> > +    size_t total_vring_size =3D 0;
> > +    size_t total_mmap_size;
> > +
> > +    /* Get space required for all vrings */
> > +    for (int j =3D 0; j < dev->nvqs; j++) {
> > +        num =3D virtio_queue_get_num(dev->vdev, dev->vq_index + j);
> > +        desc_size =3D sizeof(vring_desc_t) * num;
> > +        avail_size =3D offsetof(vring_avail_t, ring[num]) +
> > +                        sizeof(uint16_t);
> > +        driver_area_size =3D ROUND_UP(desc_size + avail_size,
> > +                            qemu_real_host_page_size());
> > +        device_area_size =3D ROUND_UP(offsetof(vring_used_t, ring[num]=
) +
> > +                                    sizeof(uint16_t),
> > +                                    qemu_real_host_page_size());
> > +        total_vring_size +=3D driver_area_size + device_area_size;
> > +    }
> > +
> > +    total_mmap_size =3D buffer_reg_size + total_vring_size;
> > +
> > +    /* Allocate and map an anonymous file to hold the isolation region=
 */
> > +    u->iso_memory.base_addr =3D (uint64_t) qemu_memfd_alloc("iso_r",
> > +                              total_mmap_size,
> > +                              F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEA=
L,
> > +                              &u->iso_memory.iso_fd, &err);
> > +    u->iso_memory.size =3D total_mmap_size;
> > +
> > +    if (err) {
> > +        error_report_err(err);
> > +        cleanup_isolation_regions(dev);
> > +        return -1;
> > +    }
> > +
> > +    uint64_t last_addr =3D int128_get64(int128_add(u->iso_memory.base_=
addr,
> > +                                                 total_mmap_size - 1))=
;
> > +
> > +    /*
> > +     * Instantiates iova tree sized to map bounce buffers and vrings t=
o the
> > +     * isolation region in host va.
> > +     */
> > +    u->iso_iova_tree =3D vhost_iova_tree_new(u->iso_memory.base_addr, =
last_addr);
> > +
> > +    assert(&u->iso_memory.iso_fd >=3D 0);
> > +    DMAMap *map;
> > +    DMAMap vring_map =3D {
> > +        .perm =3D IOMMU_RW,
> > +        .size =3D total_vring_size - 1,
> > +        /*vrings are allocated on tree first, so will be assigned base=
 addr*/
> > +        .translated_addr =3D u->iso_memory.base_addr
> > +    };
> > +
> > +    vhost_iova_tree_map_alloc(u->iso_iova_tree, &vring_map,
> > +                              vring_map.translated_addr);
> > +    u->iso_memory.vring_base_addr =3D vring_map.iova;
> > +    for (int i =3D 0; i < buffer_regions->len; i++) {
> > +        map =3D &g_array_index(buffer_regions, DMAMap, i);
> > +        vhost_iova_tree_map_alloc_gpa(u->iso_iova_tree, map,
> > +                                      map->translated_addr);
>
> I wonder if it is fine to dismiss return values of
> vhost_iova_tree_map_alloc() and vhost_iova_tree_map_alloc_gpa().
>
> Regards,
> Akihiko Odaki
>
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >   static int vhost_user_set_mem_table(struct vhost_dev *dev,
> >                                       struct vhost_memory *mem)
> >   {
> > @@ -2681,6 +2809,7 @@ static int vhost_user_backend_cleanup(struct vhos=
t_dev *dev)
> >       g_free(u->region_rb_offset);
> >       u->region_rb_offset =3D NULL;
> >       u->region_rb_len =3D 0;
> > +    cleanup_isolation_regions(dev);
> >       g_free(u);
> >       dev->opaque =3D 0;
> >
> >
>

