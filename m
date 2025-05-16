Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDD7C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 17:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFydz-0003AI-Mi; Fri, 16 May 2025 13:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFydx-00038E-Oo
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFydv-0003kr-NF
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747415681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sezJhODZLP35ExpgkpK4iZizeZx9ObSTBgjMb9AaMbY=;
 b=I2nngnhH5qJBhshQSkF7xuOEuUZlOZ2TEyR7wB01R/3ATIj6OrgiogxvDMIIz4lk2eWSze
 p0NWxoYeVlEsV2jFwB/qgy22kwrKN3tA/2j3Gkf/0K3ksuuAWGVUNqbbLFA4p34vrxbENU
 qm8V+kyMO0OuB2/fFYEEPiTprksuyjk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-PqVPXqUyOlShJLxcIlcMNg-1; Fri, 16 May 2025 13:14:40 -0400
X-MC-Unique: PqVPXqUyOlShJLxcIlcMNg-1
X-Mimecast-MFC-AGG-ID: PqVPXqUyOlShJLxcIlcMNg_1747415679
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22e544a4c83so28520565ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 10:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747415679; x=1748020479;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sezJhODZLP35ExpgkpK4iZizeZx9ObSTBgjMb9AaMbY=;
 b=oWSMkkapMRivHCH9hNTgd7TnRoTVEHOeRQIpbSQGbB23MeqX0LoyjyWwyoGph4UasG
 PyQWpa6E7DRS3RBTiekm4a5uuLILxy7mulAWCy6pM8OhJ6omRqq3Kq+kPqyVPV9P46/X
 XQMGHUdKTvvbS4cwt7Wm1vJ2B2pldKxMLNX6JtS0Kv7TUOv2j8dzHhgdO6Lrpcpxd8+j
 o8gLpYw7lplVFSNFVO5d95whocq0EtDFq0rprd7a1ufHBSKu4Brt2/Ojj8Jn4BrgRUPF
 F9Kp+txredcv1H3Ft4A/ASsxLpsQ3GEBObqwJolwWwCQIgtoX9J2Q0Wk2Ik/qfCdYgdm
 sHTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmtctYFYxr7TdF+SA+Gk9rM3mrIfDn4mgC7V8CrbnOtsjhnn0NnLu2/FriOSZAsnl64IfJ/SFN5RrC@nongnu.org
X-Gm-Message-State: AOJu0YzTK1IQjcb3Z6Eo3xyHFFx728ZOsrWG8JXHC29OzA0NC0UEMiJ8
 pV9gh+Q1QT7GomiQ7Sd57f6GbL7P1nuPuOoJmwx4wh81VOvBnd/3P/KfGB7c+P9F8IvarhsIJd4
 4JbL39HtroCsqno+uWnKWozbUR49Iha28MoCRnaGUBp49S4qZk2TCSaXE
X-Gm-Gg: ASbGnctZ2vSYq1JvIEt3Wkv3OAkwWgR4tbM9gkNWaOGR0bdKFQd9XdmswNlIeAtRBs4
 V0AhBoFVKGnLig9VrOHsYwHsmU/jk9NQcVuVwXmXs/hm6+8MM81lrtXwRZsGjsKnOJkKVPC4R4n
 m0lV4pa/3XpdfkVg2uMdHrQc2zJPLOmPSaeaSVe3P0m4cP+L+MhqK+vaDoU9IZ5cqcGBFO9xkJ1
 kYq0eL2t+NYDEEGBmVFtixrqjRPjnn93VtqkaLCbmQ79T5/4Ok5GcSLfvD1wZpiml0niYQZYm6O
 ego=
X-Received: by 2002:a17:902:ccca:b0:221:751f:cfbe with SMTP id
 d9443c01a7336-231d4e64450mr60747085ad.19.1747415679104; 
 Fri, 16 May 2025 10:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAJLwrBRwTmls6fpGl1V4dEm29+Sia2INJZp+/CBdWMhnV2+06yzacfliZhqHC++wAnTjeLg==
X-Received: by 2002:a17:902:ccca:b0:221:751f:cfbe with SMTP id
 d9443c01a7336-231d4e64450mr60746545ad.19.1747415678677; 
 Fri, 16 May 2025 10:14:38 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adbfd6sm16914205ad.67.2025.05.16.10.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 10:14:38 -0700 (PDT)
Date: Fri, 16 May 2025 13:14:32 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V3 24/42] migration: close kvm after cpr
Message-ID: <aCdyeKdIZaTqaEzY@x1.local>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
 <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, May 16, 2025 at 10:35:44AM +0200, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
> > cpr-transfer breaks vfio network connectivity to and from the guest, and
> > the host system log shows:
> >    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
> > which is EBUSY.  This occurs because KVM descriptors are still open in
> > the old QEMU process.  Close them.
> > 

[1]

> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> This patch doesn't build.
> 
> /usr/bin/ld: libcommon.a.p/migration_cpr.c.o: in function `cpr_kvm_close':
> ./build/../migration/cpr.c:260: undefined reference to `kvm_close'

And it'll be also good if this patch can keep copying the kvm maintainer
(Paolo)..  I have Paolo copied.  So this patch is more of a kvm change not
migration, afaict.  Maybe we should split this into two patches.

Steve, you could attach a cc line in this patch to make sure it won't be
forgotten when you repost (at [1] above, I think git-send-email would
remember that then):

Cc: Paolo Bonzini <pbonzini@redhat.com>

Some other questions below.

> 
> 
> 
> Thanks,
> 
> C.
> 
> 
> 
> > ---
> >   accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
> >   hw/vfio/helpers.c             | 10 ++++++++++
> >   include/hw/vfio/vfio-device.h |  2 ++
> >   include/migration/cpr.h       |  2 ++
> >   include/qemu/vfio-helpers.h   |  1 -
> >   include/system/kvm.h          |  1 +
> >   migration/cpr-transfer.c      | 18 ++++++++++++++++++
> >   migration/cpr.c               |  8 ++++++++
> >   migration/migration.c         |  1 +
> >   9 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 278a506..d619448 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
> >           goto err;
> >       }
> > +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */

Are these "reset to NULL" below required or cleanup?  It's not yet clear to
me when coalesced_mmio_ring isn't owned by the current CPU state.  Maybe
also better to split this chunk with some commit message?

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
> > @@ -600,6 +607,27 @@ err:
> >       return ret;
> >   }
> > +void kvm_close(void)
> > +{
> > +    CPUState *cpu;
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
> > index fc6aa33..5f1ff10 100644
> > --- a/include/migration/cpr.h
> > +++ b/include/migration/cpr.h
> > @@ -31,7 +31,9 @@ void cpr_state_close(void);
> >   struct QIOChannel *cpr_state_ioc(void);
> >   bool cpr_needed_for_reuse(void *opaque);
> > +void cpr_kvm_close(void);
> > +void cpr_transfer_init(void);
> >   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
> >   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
> > diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> > index bde9495..a029036 100644
> > --- a/include/qemu/vfio-helpers.h
> > +++ b/include/qemu/vfio-helpers.h
> > @@ -28,5 +28,4 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
> >                                uint64_t offset, uint64_t size);
> >   int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
> >                              int irq_type, Error **errp);
> > -
> >   #endif
> > diff --git a/include/system/kvm.h b/include/system/kvm.h
> > index b690dda..cfaa94c 100644
> > --- a/include/system/kvm.h
> > +++ b/include/system/kvm.h
> > @@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
> >   int kvm_has_vcpu_events(void);
> >   int kvm_max_nested_state_length(void);
> >   int kvm_has_gsi_routing(void);
> > +void kvm_close(void);
> >   /**
> >    * kvm_arm_supports_user_irq
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
> > index 0b01e25..6102d04 100644
> > --- a/migration/cpr.c
> > +++ b/migration/cpr.c
> > @@ -7,12 +7,14 @@
> >   #include "qemu/osdep.h"
> >   #include "qapi/error.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "migration/cpr.h"
> >   #include "migration/misc.h"
> >   #include "migration/options.h"
> >   #include "migration/qemu-file.h"
> >   #include "migration/savevm.h"
> >   #include "migration/vmstate.h"
> > +#include "system/kvm.h"
> >   #include "system/runstate.h"
> >   #include "trace.h"
> > @@ -252,3 +254,9 @@ bool cpr_needed_for_reuse(void *opaque)
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
> > index 4697732..89e2026 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -337,6 +337,7 @@ void migration_object_init(void)
> >       ram_mig_init();
> >       dirty_bitmap_mig_init();
> > +    cpr_transfer_init();
> >       /* Initialize cpu throttle timers */
> >       cpu_throttle_init();
> 

-- 
Peter Xu


