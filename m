Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE99CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5nL-0000jZ-55; Fri, 09 Oct 2026 04:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF5n7-0000eK-6w
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF5n2-0004Tj-HR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791533834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eHVmr1MPAoCD3vmXYw7Ap0VK3eXGT1tlc4pscDYDLqA=;
 b=Xl9uPjsQebOb/JKBewFfiwRqZlE+2gH7txXOlWjF7KmbBK6U2KiGaUp+OJ8ZA9Xw+BQfy9
 Nr/SfEHQGX3Fqq++5gO6H+LWx0KaPS2XtpsQR03khnRYpccH4jahS1qORk97l99CGof7MF
 FP4hsaTJixsSSkYfm/q2BOjQNOTk7vI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-gVnixQyCOry5VjsbkrwvRg-1; Fri, 09 Oct 2026 04:17:13 -0400
X-MC-Unique: gVnixQyCOry5VjsbkrwvRg-1
X-Mimecast-MFC-AGG-ID: gVnixQyCOry5VjsbkrwvRg_1791533832
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c4445512dso4471305f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 01:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791533832; x=1792138632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eHVmr1MPAoCD3vmXYw7Ap0VK3eXGT1tlc4pscDYDLqA=;
 b=aX2Z2YsSHUritbKwbX+rwil9M7J4qf/0SdAllFfvGZ5o6FzTdU5ci/ahd/cubNVbJ5
 Jbm9kkcO0vgusbE+yVjCsSaWLY6DeIolF/wevfDSdS3Za5WLvmWUVJ2zx84ELANtgPOS
 bFFvQ8jZAcfEpgoRbmfDLoi94VEoZ0FQfJyqfi4TYuHD+sxA+yGczC6TCAFKZliRCO5R
 vCMetuMEonDerNtkDp3iPMozbbZEpnM11t3Mcvan70Kz7rvsm4XaB2qE8ylEBeEDEtMe
 h/R4H/4NDvFgsIxt6PFTFbG8JfgZQW9AYALP0ehw+iBMEW+ctcvFH+87rapWVyD5jBo7
 ZhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791533832; x=1792138632;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eHVmr1MPAoCD3vmXYw7Ap0VK3eXGT1tlc4pscDYDLqA=;
 b=dY9CFKbf7+F5CQnZf4qbU4/rHdf8DzIo+s69J5gpIvoTN6u6OeNC8RBWGC3nzMmn7F
 Y0ADrTZrJ5W/skWKEbUvTxL/yKiPi445fqNXkINM47FzVWf6POwyz4G0b4gki82dvksy
 wwqV/1CS9eYACRJp+hUhI0Ez1Vt9fn93jH6Rjd7vjWNPLUmpfbFlPcFyUdTLbMYgsp7Q
 MnlbcdQqF6wuMgnBzK2rCGXaQ7YPE+apt+HyU2EnrE3V175SORev+t0dsbVSo5Kk5gNH
 Sj0SdIgZtDtKcZrgDppCa0FrC3KAJQBTIIMkQmLHKdbic++uQlniZNv4v1C8TgTII8rt
 sNTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl/ajdeRZCS+9zjf5vjxCFKXRFLbJqTg0J2PECIcMRClLx3ywT4BaMa07LkTmvVUVj3oC7IK6mxFKa@nongnu.org
X-Gm-Message-State: AFq9FYLCkMyxAwHV8lLmQYTZIfaeqCy6vUpOwte3Xy6HpHsJlI6ZLOy2
 3Yb48a0LAkc7Gsn1KfkcsxjtQuKjFSnuhaLSEmEWB6lKZdJMhz6x6tCGBF75qi3ToDoBjYQIpYu
 01HdqpIUmjfS4WiTYXW+eavewA9OoNF5lyxYW/y+rGcESWBKAJuzyOGcN
X-Gm-Gg: AYBFou04J9fyorZ/yuFO3ihbAok85Kamy+OD+TD66i/g9XUUVe8/zQbanZTDJXYFQsS
 0TCJkx2DV7ZHaSfv8U1+F357i05521eOf9jOLcT/d9NiZfi5QvtaX4Sil9T8cEbWshh+PBl6ZFd
 JeRNIWnyN+9pL0thMyxlU0I9wNHZGozYROqzNFFufhtPg9W8oTZPhUa0IoKnXTzi8N5T2pFcw/o
 C+PIA/POlPl7WbZhF8WbBjC2kD6H00ioL0KRXnmHCXYechiic64KHEba0acUYtajwQacc6Rnx3k
 2WAdPLJBZivfjuvmJPW+bKVXd2bjgMFig4dbYIKpg6q3CcmIqE4ZlxjtyN0qiKLetYCmjIfUBnx
 hK3syp9om180VupFHntCWi9ElqdpawHR9vSxMtq+S
X-Received: by 2002:a05:6000:2685:b0:48c:6724:b67d with SMTP id
 ffacd0b85a97d-48dbacddb35mr1966583f8f.38.1791533832061; 
 Fri, 09 Oct 2026 01:17:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2685:b0:48c:6724:b67d with SMTP id
 ffacd0b85a97d-48dbacddb35mr1966290f8f.38.1791533828919; 
 Fri, 09 Oct 2026 01:17:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ade914sm2387718f8f.54.2026.10.09.01.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 01:17:08 -0700 (PDT)
Message-ID: <7494cc4f-469f-4f3b-9bf8-ec6d4e7a5f1a@redhat.com>
Date: Fri, 9 Oct 2026 10:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 8/9] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-9-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261007201222.648687-9-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/7/26 22:09, Vivek Kasireddy wrote:
> Make the error handling more robust in virtio_gpu_init_udmabuf()
> by introducing 'Error **' parameter to capture errors and using
> an enum from VFIO to categorize different errors. This allows for
> better error reporting and handling of errors from
> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> 
> Furtheremore, the main reason for using the VFIO enum is to handle
> the special INVALID_IOV case which can happen in two scenarios:
> 1) When the Blob resource's memory is backed by a VFIO region. This
>     would cause INVALID_IOV error when we try to create a dmabuf via
>     udmabuf driver but we can recover from this error by having the
>     dmabuf be created by the VFIO driver instead.
> 2) When the Blob resource's memory is not backed by memfd or VFIO
>     region. In this case, since the error can be attributed to the
>     guest, we should use qemu_log_mask() instead of error_report_err()
>     and emit a message that can be used to debug the guest error.
> 
> Note that, to diagnose errors, a common pattern is to return -errno
> to enable the caller to implement specific error handling. However, in
> this case, since we want to distinguish the INVALID_IOV error from other
> errors, using the VFIO enum allows us to do so and is very convenient.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu-dmabuf.c | 69 ++++++++++++++++++++++------------
>   1 file changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index 6f05f367d0..c9de8e9ba3 100644
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
> @@ -27,28 +28,32 @@
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

return -ENODEV

> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>       }
>   
>       list = g_try_malloc0(sizeof(struct udmabuf_create_list) +
>                            sizeof(struct udmabuf_create_item) * res->iov_cnt);
>       if (!list) {
> -        return;
> +        error_setg(errp, "failed to allocate udmabuf create list");

return -ENOMEM;
          
> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>       }
>   
>       for (i = 0; i < res->iov_cnt; i++) {
>           rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
>           if (!rb || rb->fd < 0) {
> -            return;
> +            error_setg(errp, "IOV memory address incompatible with udmabuf ");
> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;

return -EINVAL;
          
>           }
>   
>           list->list[i].memfd  = rb->fd;
> @@ -59,22 +64,28 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       list->count = res->iov_cnt;
>       list->flags = UDMABUF_FLAGS_CLOEXEC;
>   
> -    res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> -    if (res->dmabuf_fd < 0) {
> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> -                    strerror(errno));
> +    fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> +    if (fd < 0) {

int saved_errno = errno;

> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl failed");
> +        if (errno == EINVAL || errno == EBADFD) {
> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;

return -EINVAL;

      
> +        }
> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;

return -saved_errno;
>       }
> +    return fd;
>   }
>   
> -static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
> +static void *virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
> +                                     Error **errp)
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
> +        return NULL;
>       }
> +    return map;
>   }
>   
>   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
> @@ -130,6 +141,7 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> +    Error *local_err = NULL;
>       void *pdata = NULL;
>   
>       res->dmabuf_fd = -1;
> @@ -137,17 +149,28 @@ bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>           res->iov[0].iov_len < 4096) {
>           pdata = res->iov[0].iov_base;
>       } else if (res->blob_size) {
> -        virtio_gpu_create_udmabuf(res);
> +        res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
> +        if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {

   if (res->dmabuf_fd == -EINVAL) {

> +            error_free_or_abort(&local_err);
> +
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Cannot create dmabuf: incompatible memory\n");
> +            return false;
> +        } else if (res->dmabuf_fd >= 0) {
> +            pdata = virtio_gpu_remap_dmabuf(res, &local_err);
> +            if (!pdata) {
> +                virtio_gpu_fini_dmabuf(res);
> +            }
> +        } else {
> +            res->dmabuf_fd = -1;
> +        }
> +
>           if (res->dmabuf_fd < 0) {
> -            return false;
> -        }
> -        virtio_gpu_remap_dmabuf(res);
> -        if (!res->remapped) {
> -            virtio_gpu_fini_dmabuf(res);
> +            error_report_err(local_err);
>               return false;
>           }
>           res->share_handle = res->dmabuf_fd;
> -        pdata = res->remapped;
> +        res->remapped = pdata;
>       }
>   
>       res->blob = pdata;


