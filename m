Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0061CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uomMZ-00068k-RA; Wed, 20 Aug 2025 13:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomMY-00067u-CV
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomMV-0004hO-JO
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755709949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bz7N8Hr9bnFzhnMbkHi0/Ke04Op8hQAzuCWT/rb+7AQ=;
 b=ENjsufG0wnnfangznSeRmO6CNTSUmC9kWgnFzl35I3sJ93dom91YJbww2l+ubyW2jNcwho
 rGQxROUMN6MapeY4pSFK5HqkvAINKr1JWmPOQVszfi6URtQCylyVlnN5bKoKu3FtQGS3D+
 9COCHLUnb+8FEYiA+Ze9h3tUS6c8IBA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-CNv3vzjuPs-NcPV5ER1kyg-1; Wed, 20 Aug 2025 13:08:03 -0400
X-MC-Unique: CNv3vzjuPs-NcPV5ER1kyg-1
X-Mimecast-MFC-AGG-ID: CNv3vzjuPs-NcPV5ER1kyg_1755709682
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-32326e09c5fso121998a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 10:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755709682; x=1756314482;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bz7N8Hr9bnFzhnMbkHi0/Ke04Op8hQAzuCWT/rb+7AQ=;
 b=IZ9p1ZBslOqJo8kGKVHDACx1vbmQcXhWxgSwJa90QROuctmGIBGEPmEn474nrte/p9
 PhLAIjCHy1uIbCH6zZOp32S9auqAJotlkCnqRcrolO1L9cishlDupd7fYfNpe96shu9u
 ELleysE4BYyjPT/YCmhm0EtJ6ix9UlLwUgdP89kAM4hj+ecE4GGARYwJuQWL0lBOyzye
 ZS6KYhiaVvw8OOFyZv2RLvU92EXXYL1LZ0fOG8AnJF934iKU2jabYBI8YF5AjmNATAX8
 soROt17fnLXSbSCE5gt5HogNk8x8LHppvlGcq8NTD5pirGAQwrCIRt2UVb7ahgiaNa5k
 IUQg==
X-Gm-Message-State: AOJu0YwRrZW8nCGcdYOMb5apkh2RMLHit2DbcR54/2o05HLnixferlGy
 BXP97tWuJxm8NKAAYk1aoRsI9jYX3j0lmWKkCmuSjZgY+1urY8g/GSlSmRn7TYUUP+Zb9BgY1OA
 0s0WUpcIj7+RD5ZLk/wcypcFXVAa+Y1dC+APnC2BWsbRGhQPUNo1/GqMz
X-Gm-Gg: ASbGnctkfV0BCdHcTL2BgqRY6lLsEc2lplr9NSyfQPRi/bjbVRgB32cJljYLPnZSHBJ
 nJEUcW6AUYy6tm0a7sQKKoY44st2pZI7hLfzSoffaUIQJ5Dx5vgYO8I27kWNTdzWv5+9YODT9e4
 mT+dGVMiaLL5HmnYGES1YrvSkqV4Hr7agy+3AdTqefQlspccQcSlthuodxwIm0/sJt2jbQGKsmY
 i5geP+AUTwGBFXIE1fICRNeDU4mKyhmGC1h36SwJfY5qVaJP9Tcneevjez+8hGtbYU2u6FaH1AF
 mpvodoFoJvbkmtl4xcg4aMyHmDuME7a9A9gnXXno7iTRHkvfEPvk
X-Received: by 2002:a17:90b:4f81:b0:321:96da:79f9 with SMTP id
 98e67ed59e1d1-324e146f76dmr4530363a91.34.1755709681984; 
 Wed, 20 Aug 2025 10:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEafk7cXXNrEo6NzfA3lIpYkWPUuNyf8Nw1I9yoFRzLp5WrvIudMC7RfrXIbHx28u6ccAcghw==
X-Received: by 2002:a17:90b:4f81:b0:321:96da:79f9 with SMTP id
 98e67ed59e1d1-324e146f76dmr4530301a91.34.1755709681217; 
 Wed, 20 Aug 2025 10:08:01 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-324e259497fsm2786965a91.30.2025.08.20.10.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 10:08:00 -0700 (PDT)
Date: Wed, 20 Aug 2025 22:37:48 +0530
From: Arun Menon <armenon@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v11 02/27] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aKYA5FtB-v3H6iGN@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-2-b470a374b42d@redhat.com>
 <87o6sgzj5t.fsf@suse.de>
 <aKWDWabj0wJJXanL@armenon-kvm.bengluru.csb>
 <87ldnevwvy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldnevwvy.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 20, 2025 at 12:24:49PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > Hi Fabiano,
> >
> > Thanks for the review.
> >
> > On Fri, Aug 15, 2025 at 12:41:50PM -0300, Fabiano Rosas wrote:
> >> Arun Menon <armenon@redhat.com> writes:
> >> 
> >> > This is an incremental step in converting vmstate loading
> >> > code to report error via Error objects instead of directly
> >> > printing it to console/monitor.
> >> > It is ensured that vmstate_load_state() must report an error
> >> > in errp, in case of failure.
> >> >
> >> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> > Signed-off-by: Arun Menon <armenon@redhat.com>
> >> > ---
> >> >  hw/display/virtio-gpu.c     |  2 +-
> >> >  hw/pci/pci.c                |  3 ++-
> >> >  hw/s390x/virtio-ccw.c       |  2 +-
> >> >  hw/scsi/spapr_vscsi.c       |  2 +-
> >> >  hw/vfio/pci.c               |  3 ++-
> >> >  hw/virtio/virtio-mmio.c     |  3 ++-
> >> >  hw/virtio/virtio-pci.c      |  2 +-
> >> >  hw/virtio/virtio.c          |  4 +--
> >> >  include/migration/vmstate.h |  2 +-
> >> >  migration/cpr.c             |  5 ++--
> >> >  migration/savevm.c          |  6 +++--
> >> >  migration/vmstate-types.c   | 22 ++++++++++++----
> >> >  migration/vmstate.c         | 61 ++++++++++++++++++++++++++++++-------------
> >> >  tests/unit/test-vmstate.c   | 63 ++++++++++++++++++++++++++++++++++++++-------
> >> >  ui/vdagent.c                |  3 ++-
> >> >  15 files changed, 136 insertions(+), 47 deletions(-)
> >> >
> >> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >> > index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5dc31bc6bfb0272e29a4364ab10de2595a4bedf7 100644
> >> > --- a/hw/display/virtio-gpu.c
> >> > +++ b/hw/display/virtio-gpu.c
> >> > @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> >> >      }
> >> >  
> >> >      /* load & apply scanout state */
> >> > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> >> > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> >> >  
> >> >      return 0;
> >> >  }
> >> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> > index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..6be932d3bb67ff0c4808707db2a7b6378a90e82b 100644
> >> > --- a/hw/pci/pci.c
> >> > +++ b/hw/pci/pci.c
> >> > @@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> >> >  int pci_device_load(PCIDevice *s, QEMUFile *f)
> >> >  {
> >> >      int ret;
> >> > -    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> >> > +    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> >> > +                             &error_fatal);
> >> >      /* Restore the interrupt status bit. */
> >> >      pci_update_irq_status(s);
> >> >      return ret;
> >> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> >> > index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..6a9641a03d5d3a38a4de7ceb9deffc0cc303bcff 100644
> >> > --- a/hw/s390x/virtio-ccw.c
> >> > +++ b/hw/s390x/virtio-ccw.c
> >> > @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> >> >  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> >> >  {
> >> >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> >> > -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> >> > +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> >> >  }
> >> >  
> >> >  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> >> > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> >> > index 20f70fb2729de78b9636a6b8c869695dab4f8902..8c896022d324f51962605288d6d6df1648c83cde 100644
> >> > --- a/hw/scsi/spapr_vscsi.c
> >> > +++ b/hw/scsi/spapr_vscsi.c
> >> > @@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
> >> >      assert(!req->active);
> >> >  
> >> >      memset(req, 0, sizeof(*req));
> >> > -    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> >> > +    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &error_fatal);
> >> >      if (rc) {
> >> >          fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
> >> >          return NULL;
> >> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> > index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..0be54762cdcbdb4780b8228b0bdf7fc6bd74dd57 100644
> >> > --- a/hw/vfio/pci.c
> >> > +++ b/hw/vfio/pci.c
> >> > @@ -2795,7 +2795,8 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> >> >          old_addr[bar] = pdev->io_regions[bar].addr;
> >> >      }
> >> >  
> >> > -    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> >> > +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
> >> > +                             &error_fatal);
> >> >      if (ret) {
> >> >          return ret;
> >> >      }
> >> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> >> > index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..0a688909fc606a3c9fde933667ae8c309ab527d0 100644
> >> > --- a/hw/virtio/virtio-mmio.c
> >> > +++ b/hw/virtio/virtio-mmio.c
> >> > @@ -34,6 +34,7 @@
> >> >  #include "qemu/error-report.h"
> >> >  #include "qemu/log.h"
> >> >  #include "trace.h"
> >> > +#include "qapi/error.h"
> >> >  
> >> >  static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
> >> >  {
> >> > @@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
> >> >  {
> >> >      VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> >> >  
> >> > -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> >> > +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
> >> >  }
> >> >  
> >> >  static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> >> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> > index 767216d795998708f5716a23ae16c79cd90ff489..b04faa1e5c91b5cef40e54ec41d92422d16bfc13 100644
> >> > --- a/hw/virtio/virtio-pci.c
> >> > +++ b/hw/virtio/virtio-pci.c
> >> > @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
> >> >  {
> >> >      VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> >> >  
> >> > -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> >> > +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
> >> >  }
> >> >  
> >> >  static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> >> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> > index 9a81ad912e013fc254899c4e55cff1f76a6112a4..6bcafb338d1b5becadcacf092ba33a6ae4c3d194 100644
> >> > --- a/hw/virtio/virtio.c
> >> > +++ b/hw/virtio/virtio.c
> >> > @@ -3327,14 +3327,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >> >      }
> >> >  
> >> >      if (vdc->vmsd) {
> >> > -        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> >> > +        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &error_fatal);
> >> >          if (ret) {
> >> >              return ret;
> >> >          }
> >> >      }
> >> >  
> >> >      /* Subsections */
> >> > -    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> >> > +    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &error_fatal);
> >> >      if (ret) {
> >> >          return ret;
> >> >      }
> >> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >> > index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b32adfd674 100644
> >> > --- a/include/migration/vmstate.h
> >> > +++ b/include/migration/vmstate.h
> >> > @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
> >> >      }
> >> >  
> >> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> > -                       void *opaque, int version_id);
> >> > +                       void *opaque, int version_id, Error **errp);
> >> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> >                         void *opaque, JSONWriter *vmdesc);
> >> >  int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
> >> > diff --git a/migration/cpr.c b/migration/cpr.c
> >> > index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..bdb24736f44e91ba59b6e622a315597c97e7f64d 100644
> >> > --- a/migration/cpr.c
> >> > +++ b/migration/cpr.c
> >> > @@ -202,6 +202,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
> >> >  
> >> >  int cpr_state_load(MigrationChannel *channel, Error **errp)
> >> >  {
> >> > +    ERRP_GUARD();
> >> >      int ret;
> >> >      uint32_t v;
> >> >      QEMUFile *f;
> >> > @@ -233,9 +234,9 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
> >> >          return -ENOTSUP;
> >> >      }
> >> >  
> >> > -    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> >> > +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
> >> >      if (ret) {
> >> > -        error_setg(errp, "vmstate_load_state error %d", ret);
> >> > +        error_prepend(errp, "vmstate_load_state error %d: ", ret);
> >> >          qemu_fclose(f);
> >> >          return ret;
> >> >      }
> >> > diff --git a/migration/savevm.c b/migration/savevm.c
> >> > index fabbeb296ae987d0c06ba6dafda63720205fecfd..cb64f2855d46aaa7c617b3e4079a2c9e566079b2 100644
> >> > --- a/migration/savevm.c
> >> > +++ b/migration/savevm.c
> >> > @@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
> >> >      if (!se->vmsd) {         /* Old style */
> >> >          return se->ops->load_state(f, se->opaque, se->load_version_id);
> >> >      }
> >> > -    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
> >> > +    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
> >> > +                              &error_fatal);
> >> >  }
> >> >  
> >> >  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> >> > @@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)
> >> >              error_report("Configuration section missing");
> >> >              return -EINVAL;
> >> >          }
> >> > -        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
> >> > +        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> >> > +                                 &error_fatal);
> >> >  
> >> >          if (ret) {
> >> >              return ret;
> >> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> >> > index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..f41670cc853c5b41ccc8def354886a8e5c1451fd 100644
> >> > --- a/migration/vmstate-types.c
> >> > +++ b/migration/vmstate-types.c
> >> > @@ -19,6 +19,7 @@
> >> >  #include "qemu/error-report.h"
> >> >  #include "qemu/queue.h"
> >> >  #include "trace.h"
> >> > +#include "qapi/error.h"
> >> >  
> >> >  /* bool */
> >> >  
> >> > @@ -543,13 +544,17 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size,
> >> >                     const VMStateField *field)
> >> >  {
> >> >      int ret;
> >> > +    Error *local_err = NULL;
> >> >      const VMStateDescription *vmsd = field->vmsd;
> >> >      int version_id = field->version_id;
> >> >      void *tmp = g_malloc(size);
> >> >  
> >> >      /* Writes the parent field which is at the start of the tmp */
> >> >      *(void **)tmp = pv;
> >> > -    ret = vmstate_load_state(f, vmsd, tmp, version_id);
> >> > +    ret = vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
> >> > +    if (ret < 0) {
> >> > +        warn_report_err(local_err);
> >> > +    }
> >> >      g_free(tmp);
> >> >      return ret;
> >> >  }
> >> > @@ -626,6 +631,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
> >> >                        const VMStateField *field)
> >> >  {
> >> >      int ret = 0;
> >> > +    Error *local_err = NULL;
> >> >      const VMStateDescription *vmsd = field->vmsd;
> >> >      /* size of a QTAILQ element */
> >> >      size_t size = field->size;
> >> > @@ -649,8 +655,9 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
> >> >  
> >> >      while (qemu_get_byte(f)) {
> >> >          elm = g_malloc(size);
> >> > -        ret = vmstate_load_state(f, vmsd, elm, version_id);
> >> > +        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
> >> >          if (ret) {
> >> > +            warn_report_err(local_err);
> >> >              return ret;
> >> >          }
> >> >          QTAILQ_RAW_INSERT_TAIL(pv, elm, entry_offset);
> >> > @@ -772,6 +779,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
> >> >      GTree *tree = *pval;
> >> >      void *key, *val;
> >> >      int ret = 0;
> >> > +    Error *local_err = NULL;
> >> >  
> >> >      /* in case of direct key, the key vmsd can be {}, ie. check fields */
> >> >      if (!direct_key && version_id > key_vmsd->version_id) {
> >> > @@ -803,18 +811,20 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
> >> >              key = (void *)(uintptr_t)qemu_get_be64(f);
> >> >          } else {
> >> >              key = g_malloc0(key_size);
> >> > -            ret = vmstate_load_state(f, key_vmsd, key, version_id);
> >> > +            ret = vmstate_load_state(f, key_vmsd, key, version_id, &local_err);
> >> >              if (ret) {
> >> >                  error_report("%s : failed to load %s (%d)",
> >> >                               field->name, key_vmsd->name, ret);
> >> > +                warn_report_err(local_err);
> >> >                  goto key_error;
> >> >              }
> >> >          }
> >> >          val = g_malloc0(val_size);
> >> > -        ret = vmstate_load_state(f, val_vmsd, val, version_id);
> >> > +        ret = vmstate_load_state(f, val_vmsd, val, version_id, &local_err);
> >> >          if (ret) {
> >> >              error_report("%s : failed to load %s (%d)",
> >> >                           field->name, val_vmsd->name, ret);
> >> > +            warn_report_err(local_err);
> >> >              goto val_error;
> >> >          }
> >> >          g_tree_insert(tree, key, val);
> >> > @@ -872,6 +882,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
> >> >                       const VMStateField *field)
> >> >  {
> >> >      int ret = 0;
> >> > +    Error *local_err = NULL;
> >> >      const VMStateDescription *vmsd = field->vmsd;
> >> >      /* size of a QLIST element */
> >> >      size_t size = field->size;
> >> > @@ -892,10 +903,11 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
> >> >  
> >> >      while (qemu_get_byte(f)) {
> >> >          elm = g_malloc(size);
> >> > -        ret = vmstate_load_state(f, vmsd, elm, version_id);
> >> > +        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
> >> >          if (ret) {
> >> >              error_report("%s: failed to load %s (%d)", field->name,
> >> >                           vmsd->name, ret);
> >> > +            warn_report_err(local_err);
> >> >              g_free(elm);
> >> >              return ret;
> >> >          }
> >> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> > index 6108c7fe283a5013ce42ea9987723c489aef26a2..1cd609a1d598995af1e51d1f4d58d68133f1426d 100644
> >> > --- a/migration/vmstate.c
> >> > +++ b/migration/vmstate.c
> >> > @@ -132,29 +132,34 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
> >> >  }
> >> >  
> >> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> > -                       void *opaque, int version_id)
> >> > +                       void *opaque, int version_id, Error **errp)
> >> >  {
> >> > +    ERRP_GUARD();
> >> >      const VMStateField *field = vmsd->fields;
> >> >      int ret = 0;
> >> >  
> >> >      trace_vmstate_load_state(vmsd->name, version_id);
> >> >      if (version_id > vmsd->version_id) {
> >> > -        error_report("%s: incoming version_id %d is too new "
> >> > -                     "for local version_id %d",
> >> > -                     vmsd->name, version_id, vmsd->version_id);
> >> > +        error_setg(errp, "%s: incoming version_id %d is too new "
> >> > +                   "for local version_id %d",
> >> > +                   vmsd->name, version_id, vmsd->version_id);
> >> >          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
> >> >          return -EINVAL;
> >> >      }
> >> >      if  (version_id < vmsd->minimum_version_id) {
> >> > -        error_report("%s: incoming version_id %d is too old "
> >> > -                     "for local minimum version_id  %d",
> >> > -                     vmsd->name, version_id, vmsd->minimum_version_id);
> >> > +        error_setg(errp, "%s: incoming version_id %d is too old "
> >> > +                   "for local minimum version_id %d",
> >> > +                   vmsd->name, version_id, vmsd->minimum_version_id);
> >> >          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
> >> >          return -EINVAL;
> >> >      }
> >> >      if (vmsd->pre_load) {
> >> >          ret = vmsd->pre_load(opaque);
> >> >          if (ret) {
> >> > +            error_setg(errp, "VM pre load failed for: '%s', "
> >> 
> >> "VM" pre load is a little ambiguous. Simply "pre load" or "pre load
> >> hook" is better.
> > Sure, will do this.
> >> 
> >> > +                       "version_id: %d, minimum version_id: %d, ret: %d",
> >> > +                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
> >> > +                       ret);
> >> >              return ret;
> >> >          }
> >> >      }
> >> > @@ -192,13 +197,20 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> >  
> >> >                  if (inner_field->flags & VMS_STRUCT) {
> >> >                      ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> >> > -                                             inner_field->vmsd->version_id);
> >> > +                                             inner_field->vmsd->version_id,
> >> > +                                             errp);
> >> >                  } else if (inner_field->flags & VMS_VSTRUCT) {
> >> >                      ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> >> > -                                             inner_field->struct_version_id);
> >> > +                                             inner_field->struct_version_id,
> >> > +                                             errp);
> >> >                  } else {
> >> >                      ret = inner_field->info->get(f, curr_elem, size,
> >> >                                                   inner_field);
> >> > +                    if (ret < 0) {
> >> > +                        error_setg(errp,
> >> > +                                   "Failed to get info for %s: %d",
> >> > +                                   inner_field->name, ret);
> >> 
> >> "get info" is not correct. This is the type-specific getter
> >> invocation. Because the migration (for the most part) is a stream, each
> >> type provides it's own getter which knows about the size of the field
> >> and any particularities such as magic values. So:
> >> 
> >> error_setg(errp, "Failed to load element of type %s for %s: %d",
> >>            info->name, inner_field->name, ret);
> > yes, will change the message. Thanks.
> >> 
> >> > +                    }
> >> >                  }
> >> >  
> >> >                  /* If we used a fake temp field.. free it now */
> >> > @@ -208,30 +220,42 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> >  
> >> >                  if (ret >= 0) {
> >> >                      ret = qemu_file_get_error(f);
> >> > +                    if (ret < 0) {
> >> > +                        error_setg(errp, "Failed to load %s state: %d",
> >> > +                                   vmsd->name, ret);
> >> 
> >> We could go a little more specific here, it's useful to know whether the
> >> error was on the transport side, rather than something logical with the
> >> migrated data. I don't really care about the actual string, but one
> >> suggestion is "stream error":
> >> 
> >> error_setg(errp, "Failed to load %s state: stream error: %d",
> >>            vmsd->name, ret);
> > yes, will add stream error. Thanks.
> >> 
> >> > +                    }
> >> >                  }
> >> >                  if (ret < 0) {
> >> >                      qemu_file_set_error(f, ret);
> >> > -                    error_report("Failed to load %s:%s", vmsd->name,
> >> > -                                 field->name);
> >> > +                    error_prepend(errp,
> >> > +                                  "Failed to load %s:%s version_id: %d: ",
> >> 
> >> Usage of : is inconsistent with below /
> > Since we used error_prepend here, we need an extra space after the colon ':'
> > That way the next error string looks readable.
> 
> Right, that's not what I'm talking about. What's inconsistent is: %s:%s
> vs. %s/%s
> 
> >> 
> >> > +                                   vmsd->name, field->name, vmsd->version_id);
> >> >                      trace_vmstate_load_field_error(field->name, ret);
> >> >                      return ret;
> >> >                  }
> >> >              }
> >> >          } else if (field->flags & VMS_MUST_EXIST) {
> >> > -            error_report("Input validation failed: %s/%s",
> >> > -                         vmsd->name, field->name);
> >> > +            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
> 
> here^
I see, I shall amend. It was copied as is from error_report().
Thanks.
> 


Regards,
Arun


