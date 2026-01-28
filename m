Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2182FD35690
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 08:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0wM-0001uN-Mh; Wed, 28 Jan 2026 03:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vl0wK-0001sv-SY
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:30:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vl0wH-00083M-Jn
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769589011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PdPi3rftpuy5C0jWtjQg7dLxtU6m4Y4Nu8AMsPNTLwA=;
 b=cD5H02uTheHq4nBNU0BbhwgWbnoCh2oyPEswv6PVNc8L6XscIOLv/ZvErT97TaSSRXd+IW
 JMVsdsbcVWfxuLcq1/U0F3BLT39hxj3pqUpdU5DNwDrM7zuvohezXup4I3r21youpmCn/K
 odIwQhkKVgLPpYghyCJMMZ5znF55Ky0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ayNtuLAiOcKbiYxvr1cDnA-1; Wed, 28 Jan 2026 03:30:09 -0500
X-MC-Unique: ayNtuLAiOcKbiYxvr1cDnA-1
X-Mimecast-MFC-AGG-ID: ayNtuLAiOcKbiYxvr1cDnA_1769589008
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48071615686so913135e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769589008; x=1770193808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PdPi3rftpuy5C0jWtjQg7dLxtU6m4Y4Nu8AMsPNTLwA=;
 b=RFHZuSwU3nI7lVJpSoXWirvPvPjPnGscHpWaCQj05yksIjXdII6hNs3ZVTCAvU9U8Q
 ub0QLtyGHsxfvZqaPujZ0qQ3TMKr0lZVhRtLv7+9dghjqnAtVV00K9mmAv+8dGWm7F2c
 lY+RiGNkZqjQxGBsBsK18V1G07C6YfITvKqrIVD+FUaLWEIa3JF4vy/Wo1tj//eNFoPA
 CLdS/q+KpFeNmw2zUXq8/jwfAOballJAS/q0gI5Ddi2RKJnsFmdHyXoBFtbvwenW8LqI
 yr7EHvUcpG1LfgiH1NYDXYBYHIDQR670pbfCxRUBP6cSGtfrwwsXHDgauI4hzBz+1QBl
 vwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769589008; x=1770193808;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdPi3rftpuy5C0jWtjQg7dLxtU6m4Y4Nu8AMsPNTLwA=;
 b=UBZYNoQ7SSFdCkGssOBnmPcHXKTvtQShOLn7/XIhl4p9edqKm5mFWhH2S9ocCIuhdr
 F9Ts5tTaQHWtFYR/B0lWV8sSFEucEkIj2TQE9tMhHLHgqRhelZT89YldxwU06uqL15no
 znhFXJ24HTxpHFMc1JqGWZ4AhZLY+5VRHVZ9FEVIvTTiM0zFknmMjmsrQJVoevKgoknx
 zDVG6U9xuXAv3UBDmRTNHihUOvv3ghdTA7THJNCib20iW8q/HQ2YSd0iQgF0qlYkxNKH
 akcvMEwVMu5FPlC2pnQs/KlCOUhcSFxPm11ZWYEpMjAN5Hqj82HylyNcW7eKB64Adkwd
 ClYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYKbTtti6Ue9Wxy6FyRqn7s6i+tt5cjzJQM1ZJfKlUu96LMvPeyVMOnutpo/e0T8toc7BS08AoRyVA@nongnu.org
X-Gm-Message-State: AOJu0Yzx6uDiqCSZSdUkfbleBFhK20uL1TRdTgoIiuEYfep/nL0gaTyb
 nRstJuPwImVzAlMPBl6n2x+DspIVRntS+WeYnArzMEXPPd3VLXkWofdHdNv890ddeEvRx/xcRD6
 v30XLvQYUgadpvO34siGtro6Z4UAnmAcApt9J2SzPr4yDkpoGdhqC+M/M
X-Gm-Gg: AZuq6aJFIGG6Q5TtOQZrjOuLYrVdmBfgeH8i0wMhuWACiBMXsh3/Xof0H0vLLOnJ31b
 GnwkEjmy9b3lti+K0H1cpcDkb+9tKkSriRoc7bqWtxAS4mishHywOw5GkBKPtlrJ0i+nAnV+OXe
 hgVWA+No44BWx1AhN0EzC+aCXb/9ZVqRNds2DYQZH69IySUaQw0DcCu1GwHy/klTBlNB97VujXN
 75D+SGtONLyE+hfmGRfjnD+YBQ6AZknziYORNW4u2cEAQtnCkQztR2X9IkYnEdXuO08Yz47Grl8
 FAmZUezsk7Bms6pCSi3O151W/Iwx3hhC7a3PwKKffETAuvC0wThrwEAaMQrkQJcLR4ElKVCiqly
 wxSxq3Gm7/7AaYbZqJXQIl4UmGkT2vuEACITKmccs3RmNGt7Q
X-Received: by 2002:a05:600c:8b6b:b0:47e:e946:3a59 with SMTP id
 5b1f17b1804b1-48069c92effmr54488345e9.34.1769589008371; 
 Wed, 28 Jan 2026 00:30:08 -0800 (PST)
X-Received: by 2002:a05:600c:8b6b:b0:47e:e946:3a59 with SMTP id
 5b1f17b1804b1-48069c92effmr54487945e9.34.1769589007901; 
 Wed, 28 Jan 2026 00:30:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c40e04sm113577385e9.13.2026.01.28.00.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 00:30:07 -0800 (PST)
Message-ID: <1bddcc61-9640-4d63-a972-ab16b0061611@redhat.com>
Date: Wed, 28 Jan 2026 09:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-9-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260123062042.568703-9-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/23/26 07:17, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Since, there is no effective way
> to determine where the backing storage is located, we first try to
> create a dmabuf assuming it is in memfd. If that fails, we try to
> create a dmabuf assuming it is in VFIO device region.
> 
> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> backing storage is located in a memfd or not. If it is not, we call
> vfio_create_dmabuf() which identifies the right VFIO device and
> eventually invokes the vfio_device_create_dmabuf_fd() API to have
> a dmabuf fd created.
> 
> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> use the VFIO device fd directly to create the CPU mapping.
> 
> While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> from virtio_gpu_create_udmabuf() and also replace warn_report()
> with qemu_log_mask().
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/Kconfig             |   5 ++
>   hw/display/virtio-gpu-dmabuf.c | 117 ++++++++++++++++++++++++++++++---
>   2 files changed, 113 insertions(+), 9 deletions(-)
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
> index c34d4c85bc..2dfe70d7eb 100644
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
> @@ -27,6 +28,38 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource *res)

Could you please not use the 'vfio_' prefix ? Its confusing as there
routines are part of the virtio component.


> +{
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    VFIODevice *vbasedev;
> +    RAMBlock *first_rb;
> +    ram_addr_t offset;
> +
> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +    if (!first_rb) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Could not find ramblock\n", __func__);

Error handling is quite poor. Can't we have an 'Error *' parameter ?

> +        return;
> +    }
> +
> +    vbasedev = vfio_device_lookup(first_rb->mr);
> +    if (!vbasedev) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: No VFIO device found to create dmabuf from\n",
> +                      __func__);
> +        return;
> +    }

vfio_dmabuf_mmap() does the same sequence of code to query the VFIODevice.
May be a common helper would help.

> +
> +    res->dmabuf_fd = vfio_device_create_dmabuf_fd(vbasedev,
> +                                                  res->iov, res->iov_cnt);
> +    if (res->dmabuf_fd < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> +                      __func__, strerror(errno));
> +    }
> +#endif
> +}
> +
>   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       struct udmabuf_create_list *list;
> @@ -43,10 +76,7 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>                        sizeof(struct udmabuf_create_item) * res->iov_cnt);
>   
>       for (i = 0; i < res->iov_cnt; i++) {
> -        rcu_read_lock();
>           rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> -        rcu_read_unlock();
> -

The rcu un/lock removal needs some explanations. It deserves a separate patch
I would say.


>           if (!rb || rb->fd < 0) {
>               g_free(list);
>               return;
> @@ -62,17 +92,84 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   
>       res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>       if (res->dmabuf_fd < 0) {
> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> -                    strerror(errno));
> +        qemu_log_mask(LOG_GUEST_ERROR,

Is it a guest error ?

> +                      "%s: UDMABUF_CREATE_LIST: %s\n",
> +                      __func__, strerror(errno));
>       }
>       g_free(list);
>   }
>   
> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res)

please use a "virtio" prefix.

> +{
> +    struct vfio_region_info *info = NULL;
> +    VFIODevice *vbasedev = NULL;
> +    ram_addr_t offset, len = 0;
> +    RAMBlock *first_rb, *rb;
> +    void *map, *submap;
> +    int i, ret = -1;
> +
> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +    if (!first_rb) {
> +        return MAP_FAILED;
> +    }
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    vbasedev = vfio_device_lookup(first_rb->mr);
> +#endif
> +    if (!vbasedev) {
> +        return MAP_FAILED;
> +    }
> +
> +    /*
> +     * We first reserve a contiguous chunk of address space for the entire
> +     * dmabuf, then replace it with smaller mappings that correspond to the
> +     * individual segments of the dmabuf.
> +     */
> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vbasedev->fd, 0);
> +    if (map == MAP_FAILED) {
> +        return map;
> +    }
> +
> +    for (i = 0; i < res->iov_cnt; i++) {
> +        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> +        if (rb != first_rb) {
> +            goto err;
> +        }
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +        ret = vfio_get_region_index_from_mr(rb->mr);
> +        if (ret < 0) {
> +            goto err;
> +        }
> +
> +        ret = vfio_device_get_region_info(vbasedev, ret, &info);
> +#endif
> +        if (ret < 0 || !info) {
> +            goto err;
> +        }
> +
> +        submap = mmap(map + len, res->iov[i].iov_len, PROT_READ,
> +                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
> +                      info->offset + offset);
> +        if (submap == MAP_FAILED) {
> +            goto err;
> +        }
> +
> +        len += res->iov[i].iov_len;
> +    }
> +    return map;
> +err:
> +    munmap(map, res->blob_size);
> +    return MAP_FAILED;
> +}
> +
>   static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>                            MAP_SHARED, res->dmabuf_fd, 0);
>       if (res->remapped == MAP_FAILED) {
> +        res->remapped = vfio_dmabuf_mmap(res);
> +        if (res->remapped != MAP_FAILED) {
> +            return;
> +        }
>           warn_report("%s: dmabuf mmap failed: %s", __func__,
>                       strerror(errno));
>           res->remapped = NULL;
> @@ -139,8 +236,12 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>       } else {
>           virtio_gpu_create_udmabuf(res);
>           if (res->dmabuf_fd < 0) {

Why test dmabuf_fd ? Can virtio_gpu_init_dmabuf() be called mulmtiple times ?


Thanks,

C.


> -            return;
> +            vfio_create_dmabuf(res);
> +            if (res->dmabuf_fd < 0) {
> +                return;
> +            }
>           }
> +
>           virtio_gpu_remap_dmabuf(res);
>           if (!res->remapped) {
>               return;
> @@ -153,9 +254,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
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


