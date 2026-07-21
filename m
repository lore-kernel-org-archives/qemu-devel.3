Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADF0C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmC0i-0007u3-Rb; Tue, 21 Jul 2026 11:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmC0h-0007ra-ON
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmC0d-0003kZ-MT
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784646229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rxw5EJtueRnJrOsxILl/TOeMz7FdjSWvQl+dDOiAj68=;
 b=bO5uOG1HAqxO2XfaPR9DiV2R4JKJwkFSALFhnF3+O1Cubv2FsF0pI/fmCJZjp8gYn9gNnD
 dOHg7pB1zw8f7RFD8fo9l6duT+CXsvrcBv/qc+y02776slDkCdQ7VhtjVy/wQ/zglgQTX8
 f/NDXbzKOijmXADv2T7sjoe8/NCxSuE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-0wVuZdPxOmymhlcjTySCeA-1; Tue, 21 Jul 2026 11:03:44 -0400
X-MC-Unique: 0wVuZdPxOmymhlcjTySCeA-1
X-Mimecast-MFC-AGG-ID: 0wVuZdPxOmymhlcjTySCeA_1784646224
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495517d39fbso19134475e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784646223; x=1785251023; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rxw5EJtueRnJrOsxILl/TOeMz7FdjSWvQl+dDOiAj68=;
 b=VUf6A65PGCVXBaDyJpDi3f+zbXUqQMv2QI5iZ9c9L8qw1hlFML6JqdkmsiHjAmeNUJ
 vwgbeKZ8ONJlPSutCOSnlC2Ld820coa8MPy1cIqi7GEz+3y/CSJGwDCojWSdx6FVxWcI
 NN5zlXp28jK1q9lj1AgCpkB/7Q4EFR+3baNDQFwP6e1rr1FVx4XG/LrM0QWCTbjnnf14
 5tRgeKUYfdIFwDGvWV1NpUK3bhboGq2Hr+6ZGz0mDGXnhaN4RhQ90x8sWFmNrkm0fM0J
 dD6NBeKv7RToIsZ3UuK1LK9Cj5p8gwzlOXSsO7EF6DAEg8yvBguGZzKhNlqgtfdsE91w
 PonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646223; x=1785251023;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rxw5EJtueRnJrOsxILl/TOeMz7FdjSWvQl+dDOiAj68=;
 b=nE+ZucInu3Au8LknQ7OF1iCXGAPe2QP2rtQz/zfz3j8tH9h3NLgSFy7W8oc8gJfxYZ
 Yk9rNCmTZOlT7utrBkJCT8plzF6qHu8UHEti/S5YOaVaTSnaXYYyEd4OG5QGsqQwsXcD
 p2TbVxMU1aZIzJ0O4007LPDlc4Cy72XH9ZYTc04LcyVzpHqyRiIiIZrG0Oqv4vWHN8KQ
 9Cm+xebc7qo2UtuNTdxe1mFBaOcW36BsLEi2T7YGjL4hO6upTWr14RADr1FlkM4ptZjy
 566J0+quyoXQXaxVarTluMoq24lGye+6Id4f1g33rSmdLm+BVl9IYsnVya2STopmyiGO
 P92w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDIZht0wgv1I3j4WjGyr5obc8bX0qmRKyzwJJncwFA1LjVjrXj62UU5iHuCKeNJmykJcWRVoptA2VG@nongnu.org
X-Gm-Message-State: AOJu0YyJQxSdfLqalOOIB+LhdHNYgnI/J2B1pRuQ6sOeYP/eC9XNGGAW
 FZzmnjn05KrgCkAqKrpovlRfvX689QGWFNCBuDisZjw3e0SeaM/pA3EbXK/3hMsstSBrygWwsga
 ATQi15Gj2/TDxz88pt3iXDsgqTmldBr0U4W9GeMeBroSLnJsBixFD2X0U
X-Gm-Gg: AfdE7cl+3znKrP2iBpWuwmvH0oRzSZmUwA1tRYRjliDo4TvZQba54tQugkjjs1alt8x
 Xqti46rRW1fT20iirDlcFMP1yC85FAAnczAHZrX4D848rrZwQ0xGnTRL4OfNuvWEFPCiAWzNTgc
 xcBjSJ0qtKPmOIqpJngkqQxZlAA5X/te+mpfKp1VxfA80hfuVSopMwV+PCgpkRd0wXUO8DJ6zXz
 i7oa/1Pjc9jQ2jojZf4w0ECr7JhP7NEC1Bveb5VzoC3HxwQ5Nn9h1QKS5fPLEHzTUbQ/nhFcgQI
 0n54AHCGBAzENQpplX8K7Ld+28uG2mdrDezQvBvS8qG3s0/lH6BHvTkOhtZQa6C5dzLleHPAUTg
 Tb7E6gC8tRyxQ3t/aXM8ixQ==
X-Received: by 2002:a05:600c:4f92:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-4954a3d06e4mr207143075e9.5.1784646223297; 
 Tue, 21 Jul 2026 08:03:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4f92:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-4954a3d06e4mr207142265e9.5.1784646222476; 
 Tue, 21 Jul 2026 08:03:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfabesm83911365e9.10.2026.07.21.08.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:03:41 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:03:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Yang Wencheng <east.moutain.yang@gmail.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Yangwencheng <yangwencheng@gmail.com>
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode DMA
 (re)map for passthrough BARs
Message-ID: <20260721110247-mutt-send-email-mst@kernel.org>
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:
> 
> 
> On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:
> > From: YangWencheng <east.moutain.yang@gmail.com>
> >
> > A passthrough device's own MMIO/BAR range is registered with the IOMMU
> > (VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
> > address space, to support peer-to-peer DMA into that BAR from other
> > devices. Toggling the guest's PCI_COMMAND memory-decode-enable bit off
> > and back on -- something PCI enumeration/attribute code does routinely,
> > sometimes several times for the same device (e.g. disable before
> > reprogramming a BAR then re-enable, or generic driver probing during
> > guest OS boot) -- currently tears down and rebuilds this mapping every
> > single time via vfio_listener_region_del()/region_add(), unconditionally.
> >
> > For devices with very large BARs this is expensive: mapping a 64GB BAR
> > into IOMMU page tables measured at ~8.5s per call on this hardware, and
> > was observed being repeated 3-5 times for the same BAR during a single
> > guest boot, because nothing changed about the underlying mapping between
> > the disable and the following re-enable.
> >
> > Defer the actual VFIO_IOMMU_UNMAP_DMA for "ram device" regions (i.e.
> > passthrough device BARs used for P2P DMA -- explicitly not regular guest
> > RAM or RamDiscardManager-backed regions, so migration/ballooning/
> > virtio-mem are unaffected) instead of issuing it immediately in
> > region_del(). If a matching region_add() for the exact same region
> > (same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
> > the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
> > host-side mapping was never actually removed, so there is nothing to
> > redo. A region_add() for anything that doesn't match maps normally, as
> > before.
> >
> > Nothing is leaked: any mapping still on the pending list is flushed with
> > a real unmap in two places -- vfio_container_instance_finalize(), before
> > the container's fd is closed (VM shutdown / last device in a group removed),
> > and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
> > device's own BARs, so a device hot-unplugged while the container stays
> > alive for other devices can't leave a dangling deferred entry either.
> >
> > This does not weaken the PCI_COMMAND memory-decode security boundary:
> > every guest write to PCI_COMMAND is still forwarded synchronously and
> > unconditionally to the real device's config space in
> > vfio_pci_write_config() (an entirely separate code path, untouched by
> > this change), which is what actually gates whether the physical device
> > claims/responds to transactions targeting its BAR, independent of
> > whatever the IOMMU's routing table still contains. This change only
> > avoids redundant bookkeeping of that routing table when nothing about
> > the mapping has changed.
> 
> Seems like you should focus on huge pfnmap support on your platform rather than hack the VMM to not behave like bare metal.  Thanks,
> 
> Alex

But bare metal does not tweak an iommu during pci enumeration?


> 
> > Signed-off-by: Yangwencheng <yangwencheng@gmail.com>
> > ---
> >  hw/vfio/container.c              | 53 ++++++++++++++++++++++
> >  hw/vfio/listener.c               | 76 ++++++++++++++++++++++++++++++++
> >  hw/vfio/pci.c                    | 11 +++++
> >  include/hw/vfio/vfio-container.h | 28 ++++++++++++
> >  4 files changed, 168 insertions(+)
> >
> > diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> > index d09a663732..00676cadc9 100644
> > --- a/hw/vfio/container.c
> > +++ b/hw/vfio/container.c
> > @@ -298,6 +298,56 @@ GList *vfio_container_get_iova_ranges(const 
> > VFIOContainer *bcontainer)
> >      return g_list_copy_deep(bcontainer->iova_ranges, copy_iova_range, 
> > NULL);
> >  }
> > 
> > +/*
> > + * Actually unmap (and free the bookkeeping for) any deferred "ram
> > + * device" unmaps still pending on this container. Must be called
> > + * before the container's fd is closed/reused, and is safe to call at
> > + * any time (e.g. also from a specific device's exit path, to avoid
> > + * leaking a mapping if that device is hot-unplugged while the
> > + * container otherwise stays alive for other devices).
> > + */
> > +void vfio_flush_pending_ram_device_unmaps(VFIOContainer *bcontainer)
> > +{
> > +    VFIOPendingRamDeviceUnmap *pending, *tmp;
> > +
> > +    QLIST_FOREACH_SAFE(pending, &bcontainer->pending_ram_device_unmap_list,
> > +                       next, tmp) {
> > +        int ret = vfio_container_dma_unmap(bcontainer, pending->iova,
> > +                                            pending->size, NULL, false);
> > +        if (ret) {
> > +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> > +                         "0x%"HWADDR_PRIx") = %d (%s)",
> > +                         bcontainer, pending->iova, pending->size, ret,
> > +                         strerror(-ret));
> > +        }
> > +        QLIST_REMOVE(pending, next);
> > +        g_free(pending);
> > +    }
> > +}
> > +
> > +void vfio_flush_pending_ram_device_unmaps_for_mr(VFIOContainer *bcontainer,
> > +                                                   MemoryRegion *mr)
> > +{
> > +    VFIOPendingRamDeviceUnmap *pending, *tmp;
> > +
> > +    QLIST_FOREACH_SAFE(pending, &bcontainer->pending_ram_device_unmap_list,
> > +                       next, tmp) {
> > +        if (pending->mr != mr) {
> > +            continue;
> > +        }
> > +        int ret = vfio_container_dma_unmap(bcontainer, pending->iova,
> > +                                            pending->size, NULL, false);
> > +        if (ret) {
> > +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> > +                         "0x%"HWADDR_PRIx") = %d (%s)",
> > +                         bcontainer, pending->iova, pending->size, ret,
> > +                         strerror(-ret));
> > +        }
> > +        QLIST_REMOVE(pending, next);
> > +        g_free(pending);
> > +    }
> > +}
> > +
> >  static void vfio_container_instance_finalize(Object *obj)
> >  {
> >      VFIOContainer *bcontainer = VFIO_IOMMU(obj);
> > @@ -312,6 +362,8 @@ static void vfio_container_instance_finalize(Object *obj)
> >          g_free(giommu);
> >      }
> > 
> > +    vfio_flush_pending_ram_device_unmaps(bcontainer);
> > +
> >      g_list_free_full(bcontainer->iova_ranges, g_free);
> >  }
> > 
> > @@ -325,6 +377,7 @@ static void vfio_container_instance_init(Object *obj)
> >      bcontainer->iova_ranges = NULL;
> >      QLIST_INIT(&bcontainer->giommu_list);
> >      QLIST_INIT(&bcontainer->vrdl_list);
> > +    QLIST_INIT(&bcontainer->pending_ram_device_unmap_list);
> >  }
> > 
> >  static const TypeInfo types[] = {
> > diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> > index c19600e980..e6bcfd028e 100644
> > --- a/hw/vfio/listener.c
> > +++ b/hw/vfio/listener.c
> > @@ -49,6 +49,55 @@
> >   * Device state interfaces
> >   */
> > 
> > +/*
> > + * Defer the VFIO_IOMMU_UNMAP_DMA for a "ram device" (passthrough device
> > + * MMIO/BAR) region instead of doing it immediately. See the comment on
> > + * VFIOPendingRamDeviceUnmap in vfio-container.h for why.
> > + */
> > +static void vfio_defer_ram_device_unmap(VFIOContainer *bcontainer,
> > +                                        MemoryRegion *mr, hwaddr iova,
> > +                                        hwaddr size, void *vaddr,
> > +                                        bool readonly)
> > +{
> > +    VFIOPendingRamDeviceUnmap *pending = g_malloc0(sizeof(*pending));
> > +
> > +    pending->mr = mr;
> > +    pending->iova = iova;
> > +    pending->size = size;
> > +    pending->vaddr = vaddr;
> > +    pending->readonly = readonly;
> > +    QLIST_INSERT_HEAD(&bcontainer->pending_ram_device_unmap_list, pending,
> > +                      next);
> > +}
> > +
> > +/*
> > + * If a deferred unmap exactly matching this (mr, iova, size, vaddr,
> > + * readonly) is pending, cancel it (drop it without ever issuing the
> > + * VFIO_IOMMU_UNMAP_DMA) and report success -- the caller should skip
> > + * mapping, since the host-side mapping was never actually removed.
> > + * Returns false if there was no matching pending unmap, in which case
> > + * the caller must map normally.
> > + */
> > +static bool vfio_cancel_pending_ram_device_unmap(VFIOContainer *bcontainer,
> > +                                                 MemoryRegion *mr,
> > +                                                 hwaddr iova, hwaddr size,
> > +                                                 void *vaddr, bool readonly)
> > +{
> > +    VFIOPendingRamDeviceUnmap *pending;
> > +
> > +    QLIST_FOREACH(pending, &bcontainer->pending_ram_device_unmap_list, next) {
> > +        if (pending->mr == mr && pending->iova == iova &&
> > +            pending->size == size && pending->vaddr == vaddr &&
> > +            pending->readonly == readonly) {
> > +            QLIST_REMOVE(pending, next);
> > +            g_free(pending);
> > +            return true;
> > +        }
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > 
> >  static bool vfio_log_sync_needed(const VFIOContainer *bcontainer)
> >  {
> > @@ -608,6 +657,22 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
> >                  pgmask + 1);
> >              return;
> >          }
> > +
> > +        /*
> > +         * If region_del deferred an identical unmap for this exact region
> > +         * (same MemoryRegion, iova, size, vaddr, readonly), the underlying
> > +         * VFIO_IOMMU_MAP_DMA mapping is still live host-side -- cancel the
> > +         * deferred unmap and skip re-mapping. This is what makes toggling
> > +         * a passthrough device's PCI_COMMAND memory-decode bit off and
> > +         * back on (which normal PCI enumeration/attribute code does,
> > +         * sometimes several times per device) cheap instead of repeating
> > +         * a possibly multi-second VFIO_IOMMU_MAP_DMA for huge BARs.
> > +         */
> > +        if (vfio_cancel_pending_ram_device_unmap(bcontainer, section->mr,
> > +                                                 iova, int128_get64(llsize),
> > +                                                 vaddr, section->readonly)) {
> > +            return;
> > +        }
> >      }
> > 
> >      if (memory_region_skip_iommu_map(section->mr)) {
> > @@ -714,6 +779,17 @@ static void 
> > vfio_listener_region_del(MemoryListener *listener,
> > 
> >          pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
> >          try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
> > +
> > +        if (try_unmap) {
> > +            void *vaddr = memory_region_get_ram_ptr(section->mr) +
> > +                         section->offset_within_region +
> > +                         (iova - section->offset_within_address_space);
> > +
> > +            vfio_defer_ram_device_unmap(bcontainer, section->mr, iova,
> > +                                        int128_get64(llsize), vaddr,
> > +                                        section->readonly);
> > +            try_unmap = false;
> > +        }
> >      } else if (memory_region_has_ram_discard_manager(section->mr)) {
> >          vfio_ram_discard_unregister_listener(bcontainer, section);
> >          /* Unregistering will trigger an unmap. */
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index c204706e63..86d61891fe 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -30,6 +30,7 @@
> >  #include "hw/core/qdev-properties.h"
> >  #include "hw/core/qdev-properties-system.h"
> >  #include "hw/vfio/vfio-cpr.h"
> > +#include "hw/vfio/vfio-container.h"
> >  #include "migration/vmstate.h"
> >  #include "migration/cpr.h"
> >  #include "qobject/qdict.h"
> > @@ -2042,6 +2043,16 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
> >          vfio_region_finalize(&bar->region);
> >          if (bar->mr) {
> >              assert(bar->size);
> > +            /*
> > +             * If a PCI_COMMAND memory-decode toggle deferred this BAR's
> > +             * unmap (see vfio_defer_ram_device_unmap()), this device is
> > +             * now really going away -- flush it for real so the mapping
> > +             * isn't leaked for the remaining lifetime of the container.
> > +             */
> > +            if (vdev->vbasedev.bcontainer) {
> > +                vfio_flush_pending_ram_device_unmaps_for_mr(
> > +                    vdev->vbasedev.bcontainer, bar->region.mem);
> > +            }
> >              g_free(bar->mr);
> >              bar->mr = NULL;
> >          }
> > diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> > index a15ee2df2b..24525683fb 100644
> > --- a/include/hw/vfio/vfio-container.h
> > +++ b/include/hw/vfio/vfio-container.h
> > @@ -48,6 +48,7 @@ struct VFIOContainer {
> >      bool dirty_pages_started; /* Protected by BQL */
> >      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> >      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> > +    QLIST_HEAD(, VFIOPendingRamDeviceUnmap) pending_ram_device_unmap_list;
> >      QLIST_ENTRY(VFIOContainer) next;
> >      QLIST_HEAD(, VFIODevice) device_list;
> >      GList *iova_ranges;
> > @@ -76,6 +77,29 @@ typedef struct VFIORamDiscardListener {
> >      QLIST_ENTRY(VFIORamDiscardListener) next;
> >  } VFIORamDiscardListener;
> > 
> > +/*
> > + * A "ram device" region (a passthrough device's own MMIO/BAR range,
> > + * mapped into the IOMMU for peer-to-peer DMA) that region_del wants to
> > + * unmap. The actual VFIO_IOMMU_UNMAP_DMA is deferred: if a matching
> > + * region_add for the identical region shows up again (e.g. the guest
> > + * toggled PCI_COMMAND memory-decode off then back on, which is common
> > + * and can happen several times per device during firmware/OS PCI
> > + * enumeration), the map is still valid host-side and both the unmap and
> > + * the re-map can be skipped entirely. This avoids repeating the
> > + * (potentially multi-second, for huge BARs) VFIO_IOMMU_MAP_DMA ioctl for
> > + * no functional reason. Any mapping still pending here when the
> > + * container is finally torn down gets a real unmap first, so nothing
> > + * is ever leaked.
> > + */
> > +typedef struct VFIOPendingRamDeviceUnmap {
> > +    MemoryRegion *mr;
> > +    hwaddr iova;
> > +    hwaddr size;
> > +    void *vaddr;
> > +    bool readonly;
> > +    QLIST_ENTRY(VFIOPendingRamDeviceUnmap) next;
> > +} VFIOPendingRamDeviceUnmap;
> > +
> >  VFIOAddressSpace *vfio_address_space_get(AddressSpace *as);
> >  void vfio_address_space_put(VFIOAddressSpace *space);
> >  void vfio_address_space_insert(VFIOAddressSpace *space,
> > @@ -267,4 +291,8 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
> >  void vfio_container_region_add(VFIOContainer *bcontainer,
> >                                 MemoryRegionSection *section, bool cpr_remap);
> > 
> > +void vfio_flush_pending_ram_device_unmaps(VFIOContainer *bcontainer);
> > +void vfio_flush_pending_ram_device_unmaps_for_mr(VFIOContainer *bcontainer,
> > +                                                   MemoryRegion *mr);
> > +
> >  #endif /* HW_VFIO_VFIO_CONTAINER_H */
> > -- 
> > 2.43.0


