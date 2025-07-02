Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3CAC83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzuy-0002fr-2i; Wed, 02 Jul 2025 12:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uWzuv-0002d3-DZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uWzus-0007Em-KL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751472150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gxc7yNRts7aJyHDA/9aNDpfX3+EgziLmXAmlrqOu5PA=;
 b=E3i0iGCdta29dMwyQbAkM60/XasHoznnlMCGQ6PM0fReAC1SpJrzNu1vsWsh1k8S3snd7t
 jC4CBr+fMKPLc6pxJXqB2xMAF7SFY+0Aol0II3iAUTBi5GbFjm7obZQv35txkv0lIN+lZI
 DiiP/uRKWIE/2KkZC8aClnNO2mdjku4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-IjzWgOLLMT-Lp-9pMwTNoQ-1; Wed, 02 Jul 2025 12:02:28 -0400
X-MC-Unique: IjzWgOLLMT-Lp-9pMwTNoQ-1
X-Mimecast-MFC-AGG-ID: IjzWgOLLMT-Lp-9pMwTNoQ_1751472148
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-700c2d3f3d6so47651526d6.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 09:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751472148; x=1752076948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gxc7yNRts7aJyHDA/9aNDpfX3+EgziLmXAmlrqOu5PA=;
 b=wf/nIoPEuoeKmC3M0YohOWR9Pq/D37JiRdLZZ5jEq7u3br6DoAd2kt6RkGuY+9gOxE
 FxEW3TJPvCCm/bXX60WquhwmBZxjzjbt3AeAEGE3xRmyzVnEoQ21V1NF5N0ODU0RzOCe
 yaRB8pL8bNeoHqrjtYJSr7z13aPOndus1S9dbfQln0u4KdHfBJQeTjw7yLYetKay1ilL
 I3ZTEvTI8yzIYmk9v8IO+XYCtBx2IT86Ch4Zp8aRv/0oejW1NIIqfPqlnHBvmowHjT2L
 YztFpnHbseKvyqkcVZov6ZH0Sxr7EGdRQCNMP3ByWrIYkVRAgfYgvRVvu3jq6bMoXrP2
 jQng==
X-Gm-Message-State: AOJu0Yw7nYNKg2p0sytYWNTZuISQKRnnolRWQpNfxrzMNCzgH0PGc2Gq
 8QiUTbS+INNH3K4fS6YXjqcNkd/emUv9dy29XxiW7NAVPI0zL/9oteodwFvI84pU1ZmtMGM9/GG
 m05Tai0j7ZajEF3pue6OYFTI3+85/KJS9A9b1Gl741UErBScEvDQwjznL
X-Gm-Gg: ASbGncvKOQlQNFm9vGW7SKgrtV69IMzq8x2zR7PSOEfmGYVAf/uYdeztw+ryEOr/3SW
 EQHCftnyNJWpgnScyQsQMTJfU2Ig4dun6yMx7XLYGHAeKpp0lHo2hXr9EpEhy8Um1wIQnLWWa5Y
 vyo5WzAzje7fkDv6KuuUgtbcc6nL6mi9HuEeZ3+8/wH9cY+DksKQM35OM2+HjBWsU7qOymniiAQ
 2Y2ockV50PPvd08NAsVjtM6CZRk6xLtV8g7J8J4De1a+VtUWFGUi1Giif7gd9pshrXBIGvvCRK4
 0REkORGnbxKPPw==
X-Received: by 2002:a05:6214:1c89:b0:6ff:1636:e797 with SMTP id
 6a1803df08f44-702b1b44e05mr50414256d6.35.1751472147622; 
 Wed, 02 Jul 2025 09:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwcv+6d0Vb0lU+/ihOl5qKnGHleKNMsphn5glO/MIroIHR6fQm5XPydql/2fTc3Vs5Wrud1w==
X-Received: by 2002:a05:6214:1c89:b0:6ff:1636:e797 with SMTP id
 6a1803df08f44-702b1b44e05mr50413706d6.35.1751472146999; 
 Wed, 02 Jul 2025 09:02:26 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772e3f38sm102224296d6.61.2025.07.02.09.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 09:02:26 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:02:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH V5 20/38] migration: close kvm after cpr
Message-ID: <aGVYD1GkOC-LuI1T@x1.local>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
 <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jul 01, 2025 at 11:25:23AM -0400, Steven Sistare wrote:
> Hi Paolo, Peter, Fabiano,
> 
> This patch needs review.  CPR for vfio is broken without it.
> Soft feature freeze July 15.

Sorry to not have tried looking at this more even if this is marked
"migration".. obviously I still almost see it as a KVM change..

Questions inline below:

> 
> - Steve
> 
> On 6/10/2025 11:39 AM, Steve Sistare wrote:
> > cpr-transfer breaks vfio network connectivity to and from the guest, and
> > the host system log shows:
> >    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
> > which is EBUSY.  This occurs because KVM descriptors are still open in
> > the old QEMU process.  Close them.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >   include/hw/vfio/vfio-device.h |  2 ++
> >   include/migration/cpr.h       |  2 ++
> >   include/system/kvm.h          |  1 +
> >   accel/kvm/kvm-all.c           | 32 ++++++++++++++++++++++++++++++++
> >   accel/stubs/kvm-stub.c        |  5 +++++
> >   hw/vfio/helpers.c             | 10 ++++++++++
> >   hw/vfio/vfio-stubs.c          | 13 +++++++++++++
> >   migration/cpr-transfer.c      | 18 ++++++++++++++++++
> >   migration/cpr.c               |  8 ++++++++
> >   migration/migration.c         |  1 +
> >   hw/vfio/meson.build           |  2 ++
> >   11 files changed, 94 insertions(+)
> >   create mode 100644 hw/vfio/vfio-stubs.c
> > 
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> > index 4e4d0b6..6eb6f21 100644
> > --- a/include/hw/vfio/vfio-device.h
> > +++ b/include/hw/vfio/vfio-device.h
> > @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
> >   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
> >                         DeviceState *dev, bool ram_discard);
> >   int vfio_device_get_aw_bits(VFIODevice *vdev);
> > +
> > +void vfio_kvm_device_close(void);
> >   #endif /* HW_VFIO_VFIO_COMMON_H */
> > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > index 07858e9..d09b657 100644
> > --- a/include/migration/cpr.h
> > +++ b/include/migration/cpr.h
> > @@ -32,7 +32,9 @@ void cpr_state_close(void);
> >   struct QIOChannel *cpr_state_ioc(void);
> >   bool cpr_incoming_needed(void *opaque);
> > +void cpr_kvm_close(void);
> > +void cpr_transfer_init(void);
> >   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
> >   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
> > diff --git a/include/system/kvm.h b/include/system/kvm.h
> > index 7cc60d2..4896a3c 100644
> > --- a/include/system/kvm.h
> > +++ b/include/system/kvm.h
> > @@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
> >   int kvm_has_vcpu_events(void);
> >   int kvm_max_nested_state_length(void);
> >   int kvm_has_gsi_routing(void);
> > +void kvm_close(void);
> >   /**
> >    * kvm_arm_supports_user_irq
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index a317783..3d3a557 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
> >           goto err;
> >       }
> > +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
> > +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
> > +        s->coalesced_mmio_ring = NULL;
> > +    }
> > +
> >       ret = munmap(cpu->kvm_run, mmap_size);
> >       if (ret < 0) {
> >           goto err;
> >       }
> > +    cpu->kvm_run = NULL;
> >       if (cpu->kvm_dirty_gfns) {
> >           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
> >           if (ret < 0) {
> >               goto err;
> >           }
> > +        cpu->kvm_dirty_gfns = NULL;
> >       }
> >       kvm_park_vcpu(cpu);
> > @@ -608,6 +615,31 @@ err:
> >       return ret;
> >   }
> > +void kvm_close(void)
> > +{
> > +    CPUState *cpu;
> > +
> > +    if (!kvm_state || kvm_state->fd == -1) {
> > +        return;
> > +    }
> > +
> > +    CPU_FOREACH(cpu) {
> > +        cpu_remove_sync(cpu);
> > +        close(cpu->kvm_fd);
> > +        cpu->kvm_fd = -1;
> > +        close(cpu->kvm_vcpu_stats_fd);
> > +        cpu->kvm_vcpu_stats_fd = -1;
> > +    }
> > +
> > +    if (kvm_state && kvm_state->fd != -1) {
> > +        close(kvm_state->vmfd);
> > +        kvm_state->vmfd = -1;
> > +        close(kvm_state->fd);
> > +        kvm_state->fd = -1;
> > +    }
> > +    kvm_state = NULL;
> > +}
> > +
> >   /*
> >    * dirty pages logging control
> >    */
> > diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> > index ecfd763..97dacb3 100644
> > --- a/accel/stubs/kvm-stub.c
> > +++ b/accel/stubs/kvm-stub.c
> > @@ -134,3 +134,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> >   {
> >       return -ENOSYS;
> >   }
> > +
> > +void kvm_close(void)
> > +{
> > +    return;
> > +}
> > diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> > index d0dbab1..af1db2f 100644
> > --- a/hw/vfio/helpers.c
> > +++ b/hw/vfio/helpers.c
> > @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
> >   int vfio_kvm_device_fd = -1;
> >   #endif
> > +void vfio_kvm_device_close(void)
> > +{
> > +#ifdef CONFIG_KVM
> > +    if (vfio_kvm_device_fd != -1) {
> > +        close(vfio_kvm_device_fd);
> > +        vfio_kvm_device_fd = -1;
> > +    }
> > +#endif
> > +}
> > +
> >   int vfio_kvm_device_add_fd(int fd, Error **errp)
> >   {
> >   #ifdef CONFIG_KVM
> > diff --git a/hw/vfio/vfio-stubs.c b/hw/vfio/vfio-stubs.c
> > new file mode 100644
> > index 0000000..a4c8b56
> > --- /dev/null
> > +++ b/hw/vfio/vfio-stubs.c
> > @@ -0,0 +1,13 @@
> > +/*
> > + * Copyright (c) 2025 Oracle and/or its affiliates.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/vfio/vfio-device.h"
> > +
> > +void vfio_kvm_device_close(void)
> > +{
> > +    return;
> > +}

Do we really need this stub, and the "include VFIO" headers in CPR as
below?  I thought it would be doable the other way round, that VFIO or KVM
can register migration notifiers for CPR mode only.  After all, the
registration (migration_add_notifier_mode) is in misc.h so it should be
available to QEMU all across.

Besides that, a high level question: what this patch does is trying to
close early the relevant kvm/vfio fds that are used to attach to irq
consumer / providers.  At the meantime, AFAICT, CPR as a whole feature when
used against VFIO available, works only if VFIO can do whatever it wants
(DMA, irq injections) during the whole process of CPR live upgrade,
assuming that all the states are persisted in the fds.  Then, if here we
need to (a) unregister on src QEMU and (b) re-attach on dest QEMU, what
happens if the irqs are generated exactly between (a) and (b)?  Could they
get lost?

> > diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> > index e1f1403..396558f 100644
> > --- a/migration/cpr-transfer.c
> > +++ b/migration/cpr-transfer.c
> > @@ -17,6 +17,24 @@
> >   #include "migration/vmstate.h"
> >   #include "trace.h"
> > +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
> > +                                 MigrationEvent *e,
> > +                                 Error **errp)
> > +{
> > +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> > +        cpr_kvm_close();
> > +    }
> > +    return 0;
> > +}
> > +
> > +void cpr_transfer_init(void)
> > +{
> > +    static NotifierWithReturn notifier;
> > +
> > +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
> > +                                MIG_MODE_CPR_TRANSFER);
> > +}
> > +
> >   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
> >   {
> >       MigrationAddress *addr = channel->addr;
> > diff --git a/migration/cpr.c b/migration/cpr.c
> > index a50a57e..49fb0a5 100644
> > --- a/migration/cpr.c
> > +++ b/migration/cpr.c
> > @@ -7,12 +7,14 @@
> >   #include "qemu/osdep.h"
> >   #include "qapi/error.h"
> > +#include "hw/vfio/vfio-device.h"

[1]

> >   #include "migration/cpr.h"
> >   #include "migration/misc.h"
> >   #include "migration/options.h"
> >   #include "migration/qemu-file.h"
> >   #include "migration/savevm.h"
> >   #include "migration/vmstate.h"
> > +#include "system/kvm.h"
> >   #include "system/runstate.h"
> >   #include "trace.h"
> > @@ -264,3 +266,9 @@ bool cpr_incoming_needed(void *opaque)
> >       MigMode mode = migrate_mode();
> >       return mode == MIG_MODE_CPR_TRANSFER;
> >   }
> > +
> > +void cpr_kvm_close(void)
> > +{
> > +    kvm_close();
> > +    vfio_kvm_device_close();
> > +}
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 4098870..8f23cff 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -337,6 +337,7 @@ void migration_object_init(void)
> >       ram_mig_init();
> >       dirty_bitmap_mig_init();
> > +    cpr_transfer_init();
> >       /* Initialize cpu throttle timers */
> >       cpu_throttle_init();
> > diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> > index 73d29f9..98134a7 100644
> > --- a/hw/vfio/meson.build
> > +++ b/hw/vfio/meson.build
> > @@ -17,6 +17,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
> >   specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> > +system_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-stubs.c'))
> > +
> >   system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
> >   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
> >   system_ss.add(when: 'CONFIG_VFIO', if_true: files(

-- 
Peter Xu


