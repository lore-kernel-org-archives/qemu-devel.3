Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416A8CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 01:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urRY2-0007g7-Pa; Wed, 27 Aug 2025 21:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRXx-0007ba-BF; Wed, 27 Aug 2025 21:35:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRXt-0008IE-JW; Wed, 27 Aug 2025 21:35:25 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57S1YsKm013695
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 10:34:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TX4gaAO7qqjuXyY+dfbUSqFY9Xv6KipvhG9syPR9VNU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756344895; v=1;
 b=cdKm6rUNna6Hl0Kmu94Kgd9GrdM6WG+Tp51ZKjkODlZYapyYw5zwIUuEoveBwks4
 OpPbJE4Cbs7BhcuywqZYL4vpTONlszcgr/bYTFToxXJmUG+dmqTajZzHd549AXgX
 HmLPBxOu4HPIn991nuF2oYpHa69MXUezgwX1DyzH/ghYb4YesqROul8eaWN6Zfmj
 oSH8XSRZvAwwEUzqT2BILDm32Yd0r35d4jGkpl9/+U7jLqxEHOD/X4NpzBUgIvnQ
 idI0ckRzM3Jk7+8ax1C5YhwD7Z18+FVrP6vIxhcvL0IPdpd0FUtT+7k5GF/Kqugj
 pfaT7l3v/49PYyxV2s+6FQ==
Message-ID: <2f079847-8b78-4db0-b14e-a3f643b6cc98@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 Aug 2025 10:34:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/27] migration: push Error **errp into
 vmstate_load_state()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
 <20250821-propagate_tpm_error-v12-2-72b803e707dc@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250821-propagate_tpm_error-v12-2-72b803e707dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/08/21 17:43, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load_state() must report an error
> in errp, in case of failure.
> 
> The errors are temporarily reported using warn_report_err().
> This is removed in the subsequent patches in this series,
> when we are actually able to propagate the error to the calling
> function using errp. Whereas, if we want the function to exit on
> error, then error_fatal is passed.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/display/virtio-gpu.c     |  2 +-
>   hw/pci/pci.c                |  3 ++-
>   hw/s390x/virtio-ccw.c       |  2 +-
>   hw/scsi/spapr_vscsi.c       |  4 ++-
>   hw/vfio/pci.c               |  5 +++-
>   hw/virtio/virtio-mmio.c     |  3 ++-
>   hw/virtio/virtio-pci.c      |  2 +-
>   hw/virtio/virtio.c          |  7 +++--
>   include/migration/vmstate.h |  2 +-
>   migration/cpr.c             |  3 +--
>   migration/savevm.c          |  8 ++++--
>   migration/vmstate-types.c   | 22 +++++++++++----
>   migration/vmstate.c         | 65 +++++++++++++++++++++++++++++++--------------
>   tests/unit/test-vmstate.c   | 63 ++++++++++++++++++++++++++++++++++++-------
>   ui/vdagent.c                |  5 +++-
>   15 files changed, 147 insertions(+), 49 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5dc31bc6bfb0272e29a4364ab10de2595a4bedf7 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>       }
>   
>       /* load & apply scanout state */
> -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
>   
>       return 0;
>   }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..6be932d3bb67ff0c4808707db2a7b6378a90e82b 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>   int pci_device_load(PCIDevice *s, QEMUFile *f)
>   {
>       int ret;
> -    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> +    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> +                             &error_fatal);
>       /* Restore the interrupt status bit. */
>       pci_update_irq_status(s);
>       return ret;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..6a9641a03d5d3a38a4de7ceb9deffc0cc303bcff 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>   static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>   {
>       VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
>   }
>   
>   static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 20f70fb2729de78b9636a6b8c869695dab4f8902..8622419497db650523d51bcb41557bbca254eaa3 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -642,15 +642,17 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
>       VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(bus->qbus.parent);
>       vscsi_req *req;
>       int rc;
> +    Error *local_err = NULL;
>   
>       assert(sreq->tag < VSCSI_REQ_LIMIT);
>       req = &s->reqs[sreq->tag];
>       assert(!req->active);
>   
>       memset(req, 0, sizeof(*req));
> -    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> +    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
>       if (rc) {
>           fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
> +        warn_report_err(local_err);
>           return NULL;
>       }
>       assert(req->active);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..a65e34b6979eadfa0851666aeae7cf731a00fa40 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2790,13 +2790,16 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>       PCIDevice *pdev = &vdev->pdev;
>       pcibus_t old_addr[PCI_NUM_REGIONS - 1];
>       int bar, ret;
> +    Error *local_err = NULL;
>   
>       for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
>           old_addr[bar] = pdev->io_regions[bar].addr;
>       }
>   
> -    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
> +                             &local_err);
>       if (ret) {
> +        warn_report_err(local_err);
>           return ret;
>       }
>   
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..0a688909fc606a3c9fde933667ae8c309ab527d0 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -34,6 +34,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/log.h"
>   #include "trace.h"
> +#include "qapi/error.h"
>   
>   static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>   {
> @@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
>   {
>       VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
>   
> -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
>   }
>   
>   static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 767216d795998708f5716a23ae16c79cd90ff489..b04faa1e5c91b5cef40e54ec41d92422d16bfc13 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
>   {
>       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>   
> -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
>   }
>   
>   static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9a81ad912e013fc254899c4e55cff1f76a6112a4..419f3516c9f0a3df43831eebc77aa1e6dfcd0f41 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3235,6 +3235,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>       BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>       VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> +    Error *local_err = NULL;
>   
>       /*
>        * We poison the endianness to ensure it does not get used before
> @@ -3327,15 +3328,17 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>       }
>   
>       if (vdc->vmsd) {
> -        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> +        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
>           if (ret) {
> +            warn_report_err(local_err);

I think error_report_err() should be used instead because this is 
replacing error_report().

If I read correctly, warn_report_err() is essentially error_report_err() 
prefixing the message with "warning: ". However, the error messages 
handled in this series do not have such prefixes so you shouldn't add 
them in intemediate changes.

Regards,
Akihiko Odaki

