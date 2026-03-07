Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C38EFC9EC0
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyipa-0008Sz-Kp; Fri, 06 Mar 2026 22:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyipX-0008Sk-RU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:59:55 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyipV-0007Bx-50
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:59:55 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6273xhnV041804
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 12:59:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=l99rB9b/Fas8AjKuBVc1QobHafYR/e3bjpCxQYwNcBY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772855986; v=1;
 b=Lyk+DZThi72bFGz9USvWgrjXh/IvIeoo4Z7Dcmf/Yd8XUbWbrIjYGwqi2sW5Jhq6
 J3t50qMzrZv2xItZZWjAmIffqqat762P/n6XM6PQmnP5fF33sJ0xr09p9hRunmij
 90sRZI29OXIUuGXnTDRPyguA1v1Fa/5c7cmG1jLRjXkdV6zJ/3P/YPyODxyfHas2
 T/YFhloaoETEvpYxI0724ZVWwAvLlgEUS9R+Goaj/SKVwCWDrcpdaPPNaA8r1Mon
 kdCR1dYCP8tK7HWHxCIulcH1+G+5rFlB9r1YsIioiaHjLtcI/Z989YjU8hzF5N2H
 naQ1kDmwcCTYkAc1vhn/EA==
Message-ID: <0fcb33f3-4d2b-4825-93ea-27dac89c4237@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Mar 2026 12:59:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260307030812.1224392-1-vivek.kasireddy@intel.com>
 <20260307030812.1224392-10-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260307030812.1224392-10-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
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

On 2026/03/07 12:05, Vivek Kasireddy wrote:
> Make the error handling more robust in virtio_gpu_init_udmabuf()
> by introducing 'Error **' parameter to capture errors and using an
> enum from VFIO to categorize Guest and Host errors. This allows
> for better error reporting and handling of errors from
> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu-dmabuf.c | 65 ++++++++++++++++++++++------------
>   1 file changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index 8d67ef7c2a..0a6b54fde5 100644
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
> @@ -27,16 +28,18 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> -static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
> +static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
> +                                     Error **errp)
>   {
>       g_autofree struct udmabuf_create_list *list = NULL;
>       RAMBlock *rb;
>       ram_addr_t offset;
> -    int udmabuf, i;
> +    int udmabuf, i, fd;
>   
>       udmabuf = udmabuf_fd();
>       if (udmabuf < 0) {
> -        return;
> +        error_setg(errp, "udmabuf device not available or enabled");
> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>       }
>   
>       list = g_malloc0(sizeof(struct udmabuf_create_list) +
> @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       for (i = 0; i < res->iov_cnt; i++) {
>           rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
>           if (!rb || rb->fd < 0) {
> -            return;
> +            error_setg(errp, "IOV memory address incompatible with udmabuf ");
> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>           }
>   
>           list->list[i].memfd  = rb->fd;
> @@ -56,22 +60,29 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       list->count = res->iov_cnt;
>       list->flags = UDMABUF_FLAGS_CLOEXEC;
>   
> -    res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> -    if (res->dmabuf_fd < 0) {
> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> -                    strerror(errno));
> +    fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> +    if (fd < 0) {
> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl failed");
> +        if (errno == EINVAL || errno == EBADFD) {
> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> +        }
> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>       }
> +    return fd;
>   }
>   
> -static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
> +static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
> +                                    void **addr, Error **errp)
>   {
> -    res->remapped = mmap(NULL, res->blob_size, PROT_READ,
> -                         MAP_SHARED, res->dmabuf_fd, 0);
> -    if (res->remapped == MAP_FAILED) {
> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> -                    strerror(errno));
> -        res->remapped = NULL;
> +    void *map;
> +
> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
> +    if (map == MAP_FAILED) {
> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> +        return false;
>       }
> +    *addr = map;
> +    return true;
>   }

Following the convention, this function should return the mapped pointer 
if success and return NULL otherwise.

Regards,
Akihiko Odaki

>   
>   static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
> @@ -125,22 +136,32 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> +    Error *local_err = NULL;
>       void *pdata = NULL;
>   
> -    res->dmabuf_fd = -1;
>       if (res->iov_cnt == 1 &&
>           res->iov[0].iov_len < 4096) {
> +        res->dmabuf_fd = -1;
>           pdata = res->iov[0].iov_base;
>       } else {
> -        virtio_gpu_create_udmabuf(res);
> +        res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
> +        if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> +            error_free_or_abort(&local_err);
> +
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Cannot create dmabuf: incompatible memory\n");
> +            return;
> +        } else if (res->dmabuf_fd < 0 ||
> +                   !virtio_gpu_remap_dmabuf(res, &pdata, &local_err)) {
> +            virtio_gpu_destroy_dmabuf(res);
> +            res->dmabuf_fd = -1;
> +        }
> +
>           if (res->dmabuf_fd < 0) {
> +            error_report_err(local_err);
>               return;
>           }
> -        virtio_gpu_remap_dmabuf(res);
> -        if (!res->remapped) {
> -            return;
> -        }
> -        pdata = res->remapped;
> +        res->remapped = pdata;
>       }
>   
>       res->blob = pdata;


