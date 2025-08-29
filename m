Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC87FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNND-0000uK-Lr; Sat, 30 Aug 2025 11:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us0S1-0002RF-6C
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us0Rv-0001OB-4l
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756479088;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJbJa72t1S0OMBXjv4NiG7bOfLdpwCrHt6YR40Uzp2g=;
 b=ezVFCLvy3CEHPI4dZKBJ7OzULjs4fRRi86rjh5av0UN+ERxM0+2arFZmdxzIdAMBFl+++i
 t7F6OILLmXS1UVwlpjyK8mb2ZpPQweJn4x/ah1TwtozY9NcEK3eFSGE06KUphidf15FYoS
 IfiibVjNi21noXq8cfyWCyr5ZdtDYDY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-xMfBPtnaPCuN96ZiZdXfAQ-1; Fri, 29 Aug 2025 10:51:26 -0400
X-MC-Unique: xMfBPtnaPCuN96ZiZdXfAQ-1
X-Mimecast-MFC-AGG-ID: xMfBPtnaPCuN96ZiZdXfAQ_1756479085
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2445803f0cfso29185895ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 07:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756479082; x=1757083882;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vJbJa72t1S0OMBXjv4NiG7bOfLdpwCrHt6YR40Uzp2g=;
 b=OjavcA0V6dLVRBvfoDuidAsdFfUdLrHkK21uTplCz2Es5LAYLI8PkqNkDGf1Ly4kK6
 11DWa/Fy5JCs8Jv5prK9GYkgs3E+L64kpajLEX7crffsW0erSEjsokPyRRRo/2GrXl3Y
 rXYRmO/7oAy8rEVpqhGbpMR/RszcnV157jSZEMI5hRQFqHPKwTsc1VCovwRPuZ+NpP1x
 p3jVywfMrATXujnOUJGkCHBQmcp4lx2ugL7AbZwhwS1xfyAnwv4Sv7buk+7tyyHQ8sww
 BbcycmLSbNa6WM6PtEDi5XJyp0Ucr7vsLg9FyF0hU9Oz+FwddppTVTD/Rers8aurlCHv
 KNDQ==
X-Gm-Message-State: AOJu0YwjTM4ljyJi7MIVaf4WLImk1x/drLNAk5zibhje8KrzEmlGA5la
 mi2ogjr2LRTAIMGTTlmfYZBA2RppLKf3rwWHxRZBQUaFBIVHuXgn5bG9wb2YxZPU24/NgBrKLWp
 k+QafgT3KvpJE5+g7YnEUkKuAbctTy3pLYQ3mcYfsrVrJX7xLX5HEYIeg
X-Gm-Gg: ASbGnctiZTLxbV/mQiI0sehVLKLFa9SFBnT9/WPsC9r0Yd3Ms9EkBGjIMymLgXSpu+C
 OlpmOQaXGaOaNpvxEInMCi2zHuLUcT0so8XfSpDUl7i7Dnq0TR0dz/oZTUgRwupbLiZa+hnqwZa
 SIC24GxT1BiFhZN7JCQe9VD9fwoIOqoqe93+HmsisR5/7VR/BTCs7iO3X54sQxF2BTkHbrCKkAz
 4nXsa0JlWuKeNsAwGszVNLRVaImnqLR6KzGfNr4aX1o1LFteCdw9/iRxfA+GT1ip+KFLud8pAj8
 MwlTXfKE9PmhPxrItZefiKC7gvwPMq1Es5xHQb9AwVvtkQcVEMb/BQ==
X-Received: by 2002:a17:903:2291:b0:242:a0b0:3c12 with SMTP id
 d9443c01a7336-2462ef86891mr365362455ad.52.1756479082092; 
 Fri, 29 Aug 2025 07:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH64QZGTtIPrlBrCGlY/mU7CAsd4dTaq9WtXDpPCsg8bafJau9sQmA0NxW9aRThpiIIxyjzlw==
X-Received: by 2002:a17:903:2291:b0:242:a0b0:3c12 with SMTP id
 d9443c01a7336-2462ef86891mr365361685ad.52.1756479081256; 
 Fri, 29 Aug 2025 07:51:21 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065aaed1sm27550335ad.124.2025.08.29.07.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 07:51:20 -0700 (PDT)
Date: Fri, 29 Aug 2025 20:21:07 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
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
Subject: Re: [PATCH v12 02/27] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aLG-Wz0ctMXP3mCU@armenon-kvm.bengluru.csb>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
 <20250821-propagate_tpm_error-v12-2-72b803e707dc@redhat.com>
 <2f079847-8b78-4db0-b14e-a3f643b6cc98@rsg.ci.i.u-tokyo.ac.jp>
 <aLAQqhtqzwaRj7Ar@armenon-kvm.bengluru.csb>
 <ae29f5be-5316-4277-8da1-6c48f469e96f@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae29f5be-5316-4277-8da1-6c48f469e96f@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On Fri, Aug 29, 2025 at 07:37:09PM +0900, Akihiko Odaki wrote:
> On 2025/08/28 17:17, Arun Menon wrote:
> > H Akihiko,
> > 
> > Thanks for the review.
> > 
> > On Thu, Aug 28, 2025 at 10:34:54AM +0900, Akihiko Odaki wrote:
> > > On 2025/08/21 17:43, Arun Menon wrote:
> > > > This is an incremental step in converting vmstate loading
> > > > code to report error via Error objects instead of directly
> > > > printing it to console/monitor.
> > > > It is ensured that vmstate_load_state() must report an error
> > > > in errp, in case of failure.
> > > > 
> > > > The errors are temporarily reported using warn_report_err().
> > > > This is removed in the subsequent patches in this series,
> > > > when we are actually able to propagate the error to the calling
> > > > function using errp. Whereas, if we want the function to exit on
> > > > error, then error_fatal is passed.
> > > > 
> > > > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > > ---
> > > >    hw/display/virtio-gpu.c     |  2 +-
> > > >    hw/pci/pci.c                |  3 ++-
> > > >    hw/s390x/virtio-ccw.c       |  2 +-
> > > >    hw/scsi/spapr_vscsi.c       |  4 ++-
> > > >    hw/vfio/pci.c               |  5 +++-
> > > >    hw/virtio/virtio-mmio.c     |  3 ++-
> > > >    hw/virtio/virtio-pci.c      |  2 +-
> > > >    hw/virtio/virtio.c          |  7 +++--
> > > >    include/migration/vmstate.h |  2 +-
> > > >    migration/cpr.c             |  3 +--
> > > >    migration/savevm.c          |  8 ++++--
> > > >    migration/vmstate-types.c   | 22 +++++++++++----
> > > >    migration/vmstate.c         | 65 +++++++++++++++++++++++++++++++--------------
> > > >    tests/unit/test-vmstate.c   | 63 ++++++++++++++++++++++++++++++++++++-------
> > > >    ui/vdagent.c                |  5 +++-
> > > >    15 files changed, 147 insertions(+), 49 deletions(-)
> > > > 
> > > > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > > > index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5dc31bc6bfb0272e29a4364ab10de2595a4bedf7 100644
> > > > --- a/hw/display/virtio-gpu.c
> > > > +++ b/hw/display/virtio-gpu.c
> > > > @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> > > >        }
> > > >        /* load & apply scanout state */
> > > > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > > > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> > > >        return 0;
> > > >    }
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..6be932d3bb67ff0c4808707db2a7b6378a90e82b 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> > > >    int pci_device_load(PCIDevice *s, QEMUFile *f)
> > > >    {
> > > >        int ret;
> > > > -    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> > > > +    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> > > > +                             &error_fatal);
> > > >        /* Restore the interrupt status bit. */
> > > >        pci_update_irq_status(s);
> > > >        return ret;
> > > > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > > > index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..6a9641a03d5d3a38a4de7ceb9deffc0cc303bcff 100644
> > > > --- a/hw/s390x/virtio-ccw.c
> > > > +++ b/hw/s390x/virtio-ccw.c
> > > > @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> > > >    static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> > > >    {
> > > >        VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > > > -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> > > > +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> > > >    }
> > > >    static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> > > > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> > > > index 20f70fb2729de78b9636a6b8c869695dab4f8902..8622419497db650523d51bcb41557bbca254eaa3 100644
> > > > --- a/hw/scsi/spapr_vscsi.c
> > > > +++ b/hw/scsi/spapr_vscsi.c
> > > > @@ -642,15 +642,17 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
> > > >        VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(bus->qbus.parent);
> > > >        vscsi_req *req;
> > > >        int rc;
> > > > +    Error *local_err = NULL;
> > > >        assert(sreq->tag < VSCSI_REQ_LIMIT);
> > > >        req = &s->reqs[sreq->tag];
> > > >        assert(!req->active);
> > > >        memset(req, 0, sizeof(*req));
> > > > -    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> > > > +    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
> > > >        if (rc) {
> > > >            fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
> > > > +        warn_report_err(local_err);
> > > >            return NULL;
> > > >        }
> > > >        assert(req->active);
> > > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > > index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..a65e34b6979eadfa0851666aeae7cf731a00fa40 100644
> > > > --- a/hw/vfio/pci.c
> > > > +++ b/hw/vfio/pci.c
> > > > @@ -2790,13 +2790,16 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> > > >        PCIDevice *pdev = &vdev->pdev;
> > > >        pcibus_t old_addr[PCI_NUM_REGIONS - 1];
> > > >        int bar, ret;
> > > > +    Error *local_err = NULL;
> > > >        for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
> > > >            old_addr[bar] = pdev->io_regions[bar].addr;
> > > >        }
> > > > -    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> > > > +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
> > > > +                             &local_err);
> > > >        if (ret) {
> > > > +        warn_report_err(local_err);
> > > >            return ret;
> > > >        }
> > > > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > > > index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..0a688909fc606a3c9fde933667ae8c309ab527d0 100644
> > > > --- a/hw/virtio/virtio-mmio.c
> > > > +++ b/hw/virtio/virtio-mmio.c
> > > > @@ -34,6 +34,7 @@
> > > >    #include "qemu/error-report.h"
> > > >    #include "qemu/log.h"
> > > >    #include "trace.h"
> > > > +#include "qapi/error.h"
> > > >    static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
> > > >    {
> > > > @@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
> > > >    {
> > > >        VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> > > > -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> > > > +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
> > > >    }
> > > >    static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > index 767216d795998708f5716a23ae16c79cd90ff489..b04faa1e5c91b5cef40e54ec41d92422d16bfc13 100644
> > > > --- a/hw/virtio/virtio-pci.c
> > > > +++ b/hw/virtio/virtio-pci.c
> > > > @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
> > > >    {
> > > >        VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> > > > -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> > > > +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
> > > >    }
> > > >    static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 9a81ad912e013fc254899c4e55cff1f76a6112a4..419f3516c9f0a3df43831eebc77aa1e6dfcd0f41 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -3235,6 +3235,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> > > >        BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> > > >        VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> > > >        VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> > > > +    Error *local_err = NULL;
> > > >        /*
> > > >         * We poison the endianness to ensure it does not get used before
> > > > @@ -3327,15 +3328,17 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> > > >        }
> > > >        if (vdc->vmsd) {
> > > > -        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> > > > +        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
> > > >            if (ret) {
> > > > +            warn_report_err(local_err);
> > > 
> > > I think error_report_err() should be used instead because this is replacing
> > > error_report().
> > > 
> > > If I read correctly, warn_report_err() is essentially error_report_err()
> > > prefixing the message with "warning: ". However, the error messages handled
> > > in this series do not have such prefixes so you shouldn't add them in
> > > intemediate changes.
> > 
> > If I am not wrong, we have introduced warn_report_err() not as a replacement to
> > error_report(). They are newly added ones. Besides, some of them are not intermediate
> > changes, because they do end up in the final version. for example in hw/virtio/virtio-pci.c
> 
> I referred to the fact that the messages that were emitted with
> error_report() calls in vmstate_load_state() are now printed with
> warn_report_err(). That causes behavioral changes and I suspect that they
> are accidental.
> 
> I especially want to know reasoning behind them if it is not accidental and
> some of them are going to remain after applying the entire series.
> 
> > In some places in the intermediate patches a warn_report_err() is added right after
> > error_report(), both to be replaced with error_setg()/error_prepend() later in the series.
> 
> The appropriate choice will depend on how Errors generated by error_setg()
> are going to be reported to the user in that case. Using warn_report_err()
> for them is inappropriate if they are going to reported with
> error_report_err(). If they are going to be handled in some special way,
> keeping the original behavior is a sensible option, and I think
> error_report_err() does that in most cases, if not all.
> 
> > 
> > Do you want to replace warn_report_err() everywhere with error_report_err()?
> 
> Perhaps so, but I may have missed some cases where warn_report_err(), so let
> me share some sort of guideline I have in my mind:
> 
> - Keeping the original behavior is a safe choice.
> 
> If "warning: " was not prepended in the past, leaving messages without the
> prefix is at least not a regression, so reviewers can give Reviewed-by: more
> easily.
> 
> - Refer to Markus' email, which provides distinctions among "ordinary"
> erros, programming errors, and warnings and I see it reasonable:
> https://lore.kernel.org/qemu-devel/87h5yijh3b.fsf@pond.sub.org/
> ("Abuse of warnings for unhandled errors and programming errors")
> 

Yes most of them are going to be reported with error_report_err() in the end.
So keeping the warning prefix does not make sense.
I agree. I shall amend and send a new version. Thank you so much.

> Regards,
> Akihiko Odaki
> 

Regards,
Arun Menon


