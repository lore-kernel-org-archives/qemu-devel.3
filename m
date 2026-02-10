Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE86EA3F14
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpiFn-0003wg-7s; Tue, 10 Feb 2026 02:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vpiFl-0003wX-1o
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:33:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vpiFh-00036o-FQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:33:44 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61A7X7GO073164
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 10 Feb 2026 16:33:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/KPGNDlg3H9U9EGyHz+5fk83Elj2Len5kCZWXLB0N+M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1770708810; v=1;
 b=Zmzi20astjwp14D1Rv5KAxx00a9NPq7d5PIWr9/RkMw4bBCqM4doNq08jJ5aTnv9
 PmIEiZmMAphvDrQSY9AoR9POgZwU97Da3RYSUT4HdnlQ++cOnq0aHxS6eSosLrje
 W0CugGshrar1QaofT0qx0gaYqy5RY8yVtyUcJ21qxk872mq+8W8uub2mr92HxWkh
 J6iw9ahFi+DoBuXWtoRCOQtvG8o/Zphxl8duWRUmoYOe46baWgR+oHlOCeE1+yp9
 kOcI8N6CpShzS+kZSdLtqXJmKJwu5fMqMpJ46Lm0veGppdy7fhcZKyHoyNupC655
 SCVc9XXK8rUHX0fsdwMb8Q==
Message-ID: <15ad210e-1464-461e-b113-7fa01f4ece3e@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 10 Feb 2026 16:33:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] virtio-gpu-dmabuf: Improve error handling by
 introducing 'Error **'
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-7-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260210070155.1176081-7-vivek.kasireddy@intel.com>
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
> Make the error handling more robust in virtio_gpu_init_udmabuf()
> by passing in 'Error **' parameter to capture errors from
> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> And, since they now take in 'Error **' parameter, have them
> return a bool to adhere to best practices.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu-dmabuf.c | 45 ++++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index 8d67ef7c2a..d9b2ecaf31 100644
> --- a/hw/display/virtio-gpu-dmabuf.c
> +++ b/hw/display/virtio-gpu-dmabuf.c
> @@ -27,7 +27,8 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> -static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
> +static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
> +                                      Error **errp)
>   {
>       g_autofree struct udmabuf_create_list *list = NULL;
>       RAMBlock *rb;
> @@ -36,7 +37,8 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   
>       udmabuf = udmabuf_fd();
>       if (udmabuf < 0) {
> -        return;
> +        error_setg(errp, "udmabuf device not available");
> +        return false;
>       }
>   
>       list = g_malloc0(sizeof(struct udmabuf_create_list) +
> @@ -45,7 +47,10 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       for (i = 0; i < res->iov_cnt; i++) {
>           rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
>           if (!rb || rb->fd < 0) {
> -            return;
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Could not find valid ramblock\n",
> +                          __func__);
> +            return false;
>           }
>   
>           list->list[i].memfd  = rb->fd;
> @@ -58,20 +63,26 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   
>       res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>       if (res->dmabuf_fd < 0) {
> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> -                    strerror(errno));
> +        error_setg_errno(errp, -res->dmabuf_fd,
> +                         "Could not create dmabuf fd via udmabuf driver");

This is a guest error since it indicates that the guest specified wrong 
addresses.

Regards,
Akihiko Odaki

> +        return false;
>       }
> +    return true;
>   }
>   
> -static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
> +static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
> +                                    Error **errp)
>   {
> -    res->remapped = mmap(NULL, res->blob_size, PROT_READ,
> -                         MAP_SHARED, res->dmabuf_fd, 0);
> -    if (res->remapped == MAP_FAILED) {
> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> -                    strerror(errno));
> +    void *map;
> +
> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
> +    if (map == MAP_FAILED) {
> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
>           res->remapped = NULL;
> +        return false;
>       }
> +    res->remapped = map;
> +    return true;
>   }
>   
>   static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
> @@ -125,6 +136,7 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> +    Error *local_err = NULL;
>       void *pdata = NULL;
>   
>       res->dmabuf_fd = -1;
> @@ -132,12 +144,15 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>           res->iov[0].iov_len < 4096) {
>           pdata = res->iov[0].iov_base;
>       } else {
> -        virtio_gpu_create_udmabuf(res);
> -        if (res->dmabuf_fd < 0) {
> +        if (!virtio_gpu_create_udmabuf(res, &local_err)) {
> +            if (local_err) {
> +                error_report_err(local_err);
> +            }
>               return;
>           }
> -        virtio_gpu_remap_dmabuf(res);
> -        if (!res->remapped) {
> +
> +        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
> +            error_report_err(local_err);
>               return;
>           }
>           pdata = res->remapped;


