Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B59CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDdQc-0003Ir-6r; Tue, 28 Oct 2025 02:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDdQZ-0003II-JK; Tue, 28 Oct 2025 02:43:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDdQV-0003nV-Eo; Tue, 28 Oct 2025 02:43:31 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59S6gtYm023431
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Oct 2025 15:42:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Q44n9YjAGLDetFGSznqAp3eN6s9rfprtkU6jnf20V+s=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1761633775; v=1;
 b=f6u+wXN9ivmtkVNwh3ct3bAugrRaIGXilC3SdOcQcAE/p7FIgApC1EkPKbpztN4w
 Z6oKhLjAd3opB2WUiKQ8KEU8z3xLsQ6Usvf4DgR2q0+J8/OkQu/inG83pxXMdcBE
 d8wRgEJBPApcLz2Y8hTF1RUsS4QziVAXwZwF7ICD/2NU/mwQNZNmmbge78ZHH+Iy
 8RJqHxIgOWDzx20pfw9NjnKqogvI6dSLRk89nFD/wCz+sQQMcKMuaIFAJGINE8Hn
 CpifAdRxveTeQFbI+HfhyrXWgfrzXNcUDhNA/8FTWtO1UJaLEe2nt+JCmEul/LqO
 vfuCz/AdkWwnZuoIJ2AoJw==
Message-ID: <fba2c2bb-09b8-450a-b4a1-7ecbb997cfff@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Oct 2025 15:42:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] migration: Fix regression of passing error_fatal
 into vmstate_load_state()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20251028-solve_error_fatal_regression-v2-0-dab24c808a28@redhat.com>
 <20251028-solve_error_fatal_regression-v2-1-dab24c808a28@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251028-solve_error_fatal_regression-v2-1-dab24c808a28@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/28 15:21, Arun Menon wrote:
> error_fatal is passed to vmstate_load_state() and vmstate_save_state()
> functions. This was introduced in commit c632ffbd74. This would exit(1)
> on error, and therefore does not allow to propagate the error back to
> the caller.
> 
> To maintain consistency with prior error handling i.e. either propagating
> the error to the caller or reporting it, we must set the error within a
> local Error object instead of using error_fatal.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/display/virtio-gpu.c | 19 ++++++++++++++-----
>   hw/pci/pci.c            | 13 +++++++++++--
>   hw/s390x/virtio-ccw.c   | 15 +++++++++++++--
>   hw/scsi/spapr_vscsi.c   |  9 +++++++--
>   hw/virtio/virtio-mmio.c | 15 +++++++++++++--
>   hw/virtio/virtio-pci.c  | 15 +++++++++++++--
>   hw/virtio/virtio.c      | 10 +++++++---
>   7 files changed, 78 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 3a555125be60aa4c243cfb870caa517995de8183..63263ecc5bda889e5327aa59ada53cb41b0219cb 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1225,7 +1225,9 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
>   {
>       VirtIOGPU *g = opaque;
>       struct virtio_gpu_simple_resource *res;
> +    Error *err = NULL;
>       int i;
> +    int ret = 0;

I prefer not to have a variable initialized unless necessary because it 
suppresses compiler warnings to tell accidental usage of variable.

Besides, the code change for other files in this patch and the existing 
code in this file doesn't initialize such variables, making the code 
style inconsistent.

That said, I feel it is too nitpicky so I give:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

You may or may not resend this patch to drop the initialization.

>   
>       /* in 2d mode we should never find unprocessed commands here */
>       assert(QTAILQ_EMPTY(&g->cmdq));
> @@ -1248,8 +1250,12 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
>       }
>       qemu_put_be32(f, 0); /* end of list */
>   
> -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
> -                              &error_fatal);
> +    ret = vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
> +                             &err);
> +    if (ret < 0) {
> +        error_report_err(err);
> +    }
> +    return ret;
>   }
>   
>   static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> @@ -1289,6 +1295,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>       struct virtio_gpu_simple_resource *res;
>       uint32_t resource_id, pformat;
>       int i;
> +    int ret = 0;
>   
>       g->hostmem = 0;
>   
> @@ -1348,9 +1355,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>       }
>   
>       /* load & apply scanout state */
> -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> -
> -    return 0;
> +    ret = vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &err);
> +    if (ret < 0) {
> +        error_report_err(err);
> +    }
> +    return ret;
>   }
>   
>   static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index acc03fd4707cdb843ba8ed8ff0e2cc8c4830932c..0090c72560de313db160f71ff494d206859ec796 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -925,8 +925,13 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>        * in irq_state which we are saving.
>        * This makes us compatible with old devices
>        * which never set or clear this bit. */
> +    int ret;
> +    Error *local_err = NULL;
>       s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
> -    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_fatal);
> +    ret = vmstate_save_state(f, &vmstate_pci_device, s, NULL, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
>       /* Restore the interrupt status bit. */
>       pci_update_irq_status(s);
>   }
> @@ -934,8 +939,12 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>   int pci_device_load(PCIDevice *s, QEMUFile *f)
>   {
>       int ret;
> +    Error *local_err = NULL;
>       ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> -                             &error_fatal);
> +                             &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
>       /* Restore the interrupt status bit. */
>       pci_update_irq_status(s);
>       return ret;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 4cb1ced001ae241c53c503ebfd7c90e336799c37..41c7d62a482de3c618e71dd07c0cd23e1bcd5578 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1130,13 +1130,24 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
>   static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>   {
>       VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
> +    int ret;
> +    Error *local_err = NULL;
> +    ret = vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
>   }
>   
>   static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>   {
>       VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> +    int ret;
> +    Error *local_err = NULL;
> +    ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>   }
>   
>   static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index f0a7dd2b882a13deec4a4c6d2eb4aae6d2fdbeb9..af4debc2f8638a0b64b5701d3d15ee9c3966cea7 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -628,10 +628,15 @@ static const VMStateDescription vmstate_spapr_vscsi_req = {
>   static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
>   {
>       vscsi_req *req = sreq->hba_private;
> +    int rc;
> +    Error *local_err = NULL;
>       assert(req->active);
>   
> -    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &error_fatal);
> -
> +    rc = vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &local_err);
> +    if (rc < 0) {
> +        error_report_err(local_err);
> +        return;
> +    }
>       trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
>                                      req->cur_desc_offset);
>   }
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index fb58c36452730cfc92a0d26ff13e01e2d6654960..ffdda63e279fd1795a447cd32effe9dcdced6120 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -612,15 +612,26 @@ static const VMStateDescription vmstate_virtio_mmio = {
>   static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
>   {
>       VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> +    Error *local_err = NULL;
> +    int ret;
>   
> -    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_fatal);
> +    ret = vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
>   }
>   
>   static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
>   {
>       VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> +    int ret;
> +    Error *local_err = NULL;
>   
> -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
> +    ret = vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>   }
>   
>   static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 937e22f08a2005d5d9e96764358a4afc09078613..f245f5c3c5e5d469e08e9e7a27f83496e90c8f59 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -187,15 +187,26 @@ static bool virtio_pci_has_extra_state(DeviceState *d)
>   static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
>   {
>       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> +    int ret;
> +    Error *local_err = NULL;
>   
> -    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_fatal);
> +    ret = vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
>   }
>   
>   static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
>   {
>       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> +    int ret;
> +    Error *local_err = NULL;
>   
> -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
> +    ret = vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>   }
>   
>   static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 153ee0a0cf1dd45c3e2246e431b696856d29b161..257cda506a40403ea1c0dbcc0de38b9854372193 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3030,7 +3030,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>       VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>       uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
> -    int i;
> +    int i, ret;
>       Error *local_err = NULL;
>   
>       if (k->save_config) {
> @@ -3075,7 +3075,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>       }
>   
>       if (vdc->vmsd) {
> -        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &local_err);
> +        ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &local_err);
>           if (ret) {
>               error_report_err(local_err);
>               return ret;
> @@ -3083,7 +3083,11 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>       }
>   
>       /* Subsections */
> -    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &error_fatal);
> +    ret = vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>   }
>   
>   /* A wrapper for use as a VMState .put function */
> 


