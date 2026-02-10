Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B0EA810A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpn4h-0004fj-FO; Tue, 10 Feb 2026 07:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vpn4f-0004er-5m
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:42:37 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vpn4c-0007cn-0C
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:42:36 -0500
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61ACgGJV076848
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 10 Feb 2026 21:42:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Y+z+RzWh9L0qVCKvlcVCOTj66olaZTS8LrbVlJRRZVM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1770727348; v=1;
 b=Z04RuXQOMBKnUnX/btmH64pgUhUsEzZ9uvrDP5kyDEjVkajw9htHWPRJLBMwt2Z4
 jo0ucOzfhVBolAxIDTYxl/ay8Sn+7vjvDZwg4uDmzuSCrK9eQZkDWtrWIUAcIkZf
 VVICnnu/hkiIxr5iUOIV548q3ZP2pmewYVaHm7hUefBpHMK5GWI67QUO1zoPDZ49
 cHomlZlehoeiCGX3XOXMaXAQQOc0Jlaq+4VwXO/khYNWDOkonkgV8zAWddV+CR15
 Ju1OEw8j46KyHSuQXgyJfc4NDTfl3EllIcURRRL8mCRqmsQhm767ZPFiRwvuYuDu
 SuZSNI1BlCjYbxCue63Zfw==
Message-ID: <c7c03384-4815-4032-89bd-de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 10 Feb 2026 21:42:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-12-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260210070155.1176081-12-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/02/10 15:59, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Since, there is no effective way
> to determine where the backing storage is located, we first try to
> create a dmabuf assuming it is in memfd. If that fails, we try to
> create a dmabuf assuming it is in VFIO device region.
> 
> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> backing storage is located in a memfd or not. If it is not, we invoke
> the vfio_device_create_dmabuf() API which identifies the right VFIO
> device and eventually creates a dmabuf fd.
> 
> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> created for the dmabuf.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/Kconfig             |  5 ++++
>   hw/display/virtio-gpu-dmabuf.c | 50 ++++++++++++++++++++++++++++------
>   2 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1e95ab28ef..0d090f25f5 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -106,6 +106,11 @@ config VIRTIO_VGA
>       depends on VIRTIO_PCI
>       select VGA
>   
> +config VIRTIO_GPU_VFIO_BLOB
> +    bool
> +    default y
> +    depends on VFIO
> +
>   config VHOST_USER_GPU
>       bool
>       default y
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index d9b2ecaf31..54d010b995 100644
> --- a/hw/display/virtio-gpu-dmabuf.c
> +++ b/hw/display/virtio-gpu-dmabuf.c
> @@ -18,6 +18,7 @@
>   #include "ui/console.h"
>   #include "hw/virtio/virtio-gpu.h"
>   #include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "trace.h"
>   #include "system/ramblock.h"
>   #include "system/hostmem.h"
> @@ -27,6 +28,27 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> +static bool virtio_gpu_create_vfio_dmabuf(struct virtio_gpu_simple_resource *r,
> +                                          Error **errp)
> +{
> +    bool ret = false;
> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> +    Error *local_err = NULL;
> +    int fd;
> +
> +    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd, &local_err)) {
> +        error_report_err(*errp);
> +        *errp = NULL;
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
> +    ret = true;
> +    r->dmabuf_fd = fd;
> +#endif
> +    return ret;
> +}
> +
>   static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
>                                         Error **errp)
>   {
> @@ -73,16 +95,28 @@ static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
>   static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
>                                       Error **errp)
>   {
> +    Error *local_err = NULL;
> +    bool ret = true;
>       void *map;
>   
>       map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
>       if (map == MAP_FAILED) {
>           error_setg_errno(errp, errno, "dmabuf mmap failed");
> -        res->remapped = NULL;
> -        return false;
> +        map = NULL;
> +        ret = false;
> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> +        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> +                                    res->blob_size, &local_err)) {
> +            ret = true;
> +        } else {
> +            error_report_err(*errp);
> +            *errp = NULL;
> +        }
> +#endif
> +        error_propagate(errp, local_err);
>       }
>       res->remapped = map;
> -    return true;
> +    return ret;
>   }
>   
>   static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
> @@ -145,8 +179,10 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>           pdata = res->iov[0].iov_base;
>       } else {
>           if (!virtio_gpu_create_udmabuf(res, &local_err)) {

virtio_gpu_create_udmabuf() will log "Could not find valid ramblock" 
even for VFIO, which shouldn't happen.

This logic should look like as follows:

virtio_gpu_create_udmabuf(res);
if (it turned out the memory is incompatible with udmabuf) {
     virtio_gpu_create_vfio_dmabuf(res);
     if (it turned out the memory is not backed by VFIO) {
         qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
         return;
     }
}

Regards,
Akihiko Odaki

> -            if (local_err) {
> -                error_report_err(local_err);
> +            if (!virtio_gpu_create_vfio_dmabuf(res, &local_err)) {
> +                if (local_err) {
> +                    error_report_err(local_err);
> +                }
>               }
>               return;
>           }
> @@ -163,9 +199,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   
>   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> -    if (res->remapped) {
> -        virtio_gpu_destroy_dmabuf(res);
> -    }
> +    virtio_gpu_destroy_dmabuf(res);
>   }
>   
>   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


