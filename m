Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B2FF483DE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jRR-0004cG-1R; Mon, 23 Mar 2026 13:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4jRO-0004bq-Ck
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4jRM-0008NI-75
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774288306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=56u0Jm2jDVinjrl+Zm1hNNoxlHNlpH3GHIFv6LGwH/w=;
 b=R/Wkp4oNcxKFe5RPcq0JaLE7V3vwEp/1LecykZHVmS7AQrw3TnzU2fV/J+JARsSGkOCFvp
 tAw5c+3xaoVA6jgt4YuZ7jWYMSuNa5YLkwXiXm/u4eU/hQfiLhN2FQf1Kxy+I5NPOMzny9
 Tpqp5oT+Ro3aRsbvCkWQyeF7hiRk2mA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-KmlX5nWvPuqMJGsMXw0uyg-1; Mon, 23 Mar 2026 13:51:44 -0400
X-MC-Unique: KmlX5nWvPuqMJGsMXw0uyg-1
X-Mimecast-MFC-AGG-ID: KmlX5nWvPuqMJGsMXw0uyg_1774288303
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-486fa35b005so7051935e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774288303; x=1774893103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=56u0Jm2jDVinjrl+Zm1hNNoxlHNlpH3GHIFv6LGwH/w=;
 b=j9mT13xVZsQu44wUyZ7kyFef0UEpU4eiTfncnirSrfifOI6ubuLgBsPeCMQd2aPfgS
 SO0JaPW7rtRXRpklHay7HcB83LFBuQxNMESU5kG8JpkzN5jbWqxLS18U4g0fEJSutIOj
 j06RmYC30BTvMl13XsGgBB+yLLq5PZVVFxR2DA99NDLszlF3mRM/pQPpYA4fEyz8SdgR
 t9GmHkCLlfn30aGFBohYS9yDYpsk5TUT/1KXeTNej7JFnjFMI5u7XZKwM0IGsQjpvnMb
 y3ghZyg6eYzPOOomBogmun9ij7LUah1cOT81aV25jbXyat0BwnuqK2OINuMuQhJZ2cdU
 gEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774288303; x=1774893103;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56u0Jm2jDVinjrl+Zm1hNNoxlHNlpH3GHIFv6LGwH/w=;
 b=pVvm7Hep9ZAJeH/zHZiapkfdv/bSH9ozCS2ubRr8sHRLlaOa2Pf5ftpIcbuuEAKtDD
 NM0oSSnj6cDzFsdCyno95+0TDc2OvEVGASB71hUeRS1ems5bdPTUpY6iKEPRrbndAsi/
 1r6nSRGKRn65ZkeKYfk+IZj+jKx1zlmDM4YL8tewf9ERgLcrkyGZ9riwYcIuRp8ylDiU
 m/+alUzBNHdDkDFi1jjA7LvHWUl3fc+Zz+TVlavlbx9qAarfJG1YB/c/vU7Kre/7/g5w
 gOBVgj2ZqG8qIy6/A0Yt7KRbNI7yCyjSAXzf7mrBRXjNAn7oHz2irQxjpftB/2/djL9p
 b0fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOw6thQAuVzUWlgpAOh33oVDrBTFRew2B0g08O8HvisCcFo3EuGt6Ft8Yo729LwZwTy2Djuo70K7ee@nongnu.org
X-Gm-Message-State: AOJu0Yx5Dxb5Iv/y/v3uF/IP72vhCU6f9jEPyvhCWIxL0k3FsMV81574
 oJLhrf5eu41a/GChjW322Z1d/k6fqD79CqzQVXJOlET/hiwDe1yzf68m0d9QK0UIkRlDbXB24+f
 PDlRjhLJdMgbzyguYMakEcxOV6FavBK803K5iM380f0WBeYF3f8YP5Pq2
X-Gm-Gg: ATEYQzzkdek9+9ovSM7keboNMKax6COZRmlDe4VyPdCPFb+tK7QEG7Hk3bAAN5MqzY2
 d3UuKu3RX7+Hiq8LD/9U+Y+WbojYi/p+NQjfL9d4YZDelO45tU6+lsUqpnT8zpLAJLtOqKHaS7t
 jWSa8oMCjVyhTYce8Hp3s7nuq42gcViRDlQBOulbp5Cc+LfWkJHWuPSKhCa4WD1g+bwPiFOC5T+
 BDUsnJKz4KJqiFr3Dp/JkZxSP/sg+8dvsqot8+15BSZDIcQxywBVg69mi8goqldouE9i3GYegBU
 BVzp5citO3YgE0RAV2KmCE1n2qu84vVOJTrBwrrPIQPya2//menZqYrbs8tCIFQapnR/aQHbdyd
 Oh5MSJNFsvrPNwIyPXh8DtWHhDsvaDmRANTlsBH/uA+uYn0Psf6JFeIreld/G
X-Received: by 2002:a05:600c:3554:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-486ff01cc5bmr190655425e9.27.1774288302809; 
 Mon, 23 Mar 2026 10:51:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3554:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-486ff01cc5bmr190655115e9.27.1774288302386; 
 Mon, 23 Mar 2026 10:51:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644addfbsm32238446f8f.3.2026.03.23.10.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 10:51:41 -0700 (PDT)
Message-ID: <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
Date: Mon, 23 Mar 2026 18:51:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260319052023.2088685-10-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/19/26 06:15, Vivek Kasireddy wrote:
> Make the error handling more robust in virtio_gpu_init_udmabuf()
> by introducing 'Error **' parameter to capture errors and using
> an enum from VFIO to categorize different errors. This allows for
> better error reporting and handling of errors from
> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
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
>   hw/display/virtio-gpu-dmabuf.c | 67 +++++++++++++++++++++++-----------
>   1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index e35f7714a9..89aa487654 100644
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

The function virtio_gpu_create_udmabuf() is returning VFIO_DMABUF_* enum
values, which is problematic because the function creates a udmabuf, not
a VFIO dmabuf.

This creates a layering violation. The virtio-gpu-dmabuf code (which
handles both udmabuf and VFIO dmabuf creation) is using error codes
defined in the VFIO-specific header.

Please find another solution.



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
> @@ -56,22 +60,28 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
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
>   static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
> @@ -125,22 +135,35 @@ bool virtio_gpu_have_udmabuf(void)
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

Why not report the error in the QEMU log below ?

> +
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Cannot create dmabuf: incompatible memory\n");
> +            return;
> +        } else if (res->dmabuf_fd >= 0) {
> +            pdata = virtio_gpu_remap_dmabuf(res, &local_err);
> +            if (!pdata) {
> +                virtio_gpu_destroy_dmabuf(res);
> +            }
> +        } else {
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


