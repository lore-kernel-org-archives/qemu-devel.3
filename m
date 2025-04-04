Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A27C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0iAJ-0000wa-Mo; Fri, 04 Apr 2025 10:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0iAH-0000vw-CN
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0iAE-00029c-5C
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743777417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4DuafotzhlmFXcoU5Vm6dvUdEKfV+kSq9fyVU48y/zQ=;
 b=IrQ+Z2wffgTOOkEKGlLZT/C3JcIeTGF8zzq3k9Z4EPXvh55FGBQQY2cMjh9oP/jSiFPo3q
 lbNAjAf/1kD42z+I7zpPCYTU+k/XBcZUD8GnDLxvYNwljiTlefpD2bOEj5GswcN3QjJOUw
 aveawl6mu4Ui98L0uME7Ji1vE+Yw/60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-n1rlu-eFPHuDg_uFA5vxUw-1; Fri, 04 Apr 2025 10:36:55 -0400
X-MC-Unique: n1rlu-eFPHuDg_uFA5vxUw-1
X-Mimecast-MFC-AGG-ID: n1rlu-eFPHuDg_uFA5vxUw_1743777414
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d3b211d0eso16915725e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 07:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743777410; x=1744382210;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DuafotzhlmFXcoU5Vm6dvUdEKfV+kSq9fyVU48y/zQ=;
 b=tlcaP2vsEOZGWVB9/fSlgYgV10rLRNu49U1LMyDSFqb6AzzAHBG+sM7conMfptc7ZB
 0omhEoHb97DS0gz4XJMsvz939oTwD3KLl8i2LsH4rZYAgRiYUAkA5buvE3etX21qwKxH
 jAGyundRhRCNHBb1lfFykaDpLRGdxkru00XKmT0yrRIo0hZQTQ7QrBJ7fEOfeq4BJIWH
 CYbDFs2P/LgwKHdoHZvXRN0LkFqQNZLPLD1WKJGIY+BiKUVMpuAINFFPe/G8Dw9PpyYV
 bNZokFroT49EED2k84ba10/3A8rgwV3gvfvPpllzHj5AmG/tR2J5v8Qq7rHyiik3t4Se
 xPmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8gw4wXFuLpuaK6XIohqh+3wibvKl2UcXv5kCqJbhs8oCMwgyrFP+ojnZS4g4oxLgWzFKTu0fA1dTb@nongnu.org
X-Gm-Message-State: AOJu0Yzd0FkW1c6ZeK3clrmGXkA2x7uD5zQhlirZpebkDYUyLsCQHw1K
 vL6JqsSiXtkKnKkIqLyaXe2od6Y/Fth2XHzU8X9QdnMvPXaYgUJ8jlDjiwXmrexT/dz3Xgu/fHZ
 Bze75xuap5zTielLnGiccGJ8xWUXentYrtf7iN96DLm5u0P2gvvG7
X-Gm-Gg: ASbGncvcMDQJaeJhL8OFr7fWD44jWF1Lo4d9QwUqy5m1ryypdgl/MkF7lvmwnFUjSo4
 UCvBXRskFyi08NH9BXRw5Jg7FcGBa0XUzFfng62OuN5QmS3IpB2/PJJ1otNRd2yArbvfGUdrwSI
 8sOJKXxuyQDRs4lprmhUcr5XvZGeZlBS2vu4a4qDlYlpt1Sxu40qlpygmZ7Ts4m/s4pm7jAz+o0
 1QkNudE8PJPBfTUDx+xuNfFexteDcckgP0AZEe5lGjZdZM2WYcWO5fN6gQ4H0dyGVlzKT0Zg2Cm
 e8q/mnc5cuQFH+7lV6Rc6wHlpgfmMCpm8YMUB2869AonnKtMWerZjg==
X-Received: by 2002:a5d:59a5:0:b0:39c:13fd:e6cd with SMTP id
 ffacd0b85a97d-39c2e65aa4amr5807168f8f.29.1743777410105; 
 Fri, 04 Apr 2025 07:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVOXMIHna7isbqLJvl/s1Oh7jZf5LKySCkhRLV7iX0EixV8cGcRwxUsiaJmvOhoLk3VDrzew==
X-Received: by 2002:a5d:59a5:0:b0:39c:13fd:e6cd with SMTP id
 ffacd0b85a97d-39c2e65aa4amr5807107f8f.29.1743777409341; 
 Fri, 04 Apr 2025 07:36:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a75fcsm47030465e9.11.2025.04.04.07.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 07:36:48 -0700 (PDT)
Message-ID: <18613967-0bd5-4a9d-b2d5-37cd179ea0e6@redhat.com>
Date: Fri, 4 Apr 2025 16:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/28] vfio: add device IO ops vector
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-11-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-11-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/19/25 15:48, John Levon wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
> 
> For vfio-user, device operations such as IRQ handling and region
> read/writes are implemented in userspace over the control socket, not
> ioctl() or read()/write() to the vfio kernel driver; add an ops vector
> to generalize this, and implement vfio_dev_io_ioctl for interacting
> with the kernel vfio driver.
> 
> The ops consistently use the "-errno" return style, as the vfio-user
> implementations get their errors from response messages not from the
> kernel; adjust the callers to handle this as necessary.

Please adjust the callers before introducing the new ops.
  
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/ap.c                  |   2 +-
>   hw/vfio/ccw.c                 |   2 +-
>   hw/vfio/common.c              |  13 +--
>   hw/vfio/helpers.c             | 110 ++++++++++++++++++++++---
>   hw/vfio/pci.c                 | 147 ++++++++++++++++++++++------------
>   hw/vfio/platform.c            |   2 +-
>   include/hw/vfio/vfio-common.h |  27 ++++++-
>   7 files changed, 227 insertions(+), 76 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375..1adce1ab40 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -228,7 +228,7 @@ static void vfio_ap_instance_init(Object *obj)
>        * handle ram_block_discard_disable().
>        */
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
> -                     DEVICE(vapdev), true);
> +                     &vfio_dev_io_ioctl, DEVICE(vapdev), true);

Hmm, most of these parameters should be VFIODeviceClass attributes but
it doesn't exist. I don't see any nice improvements. Let's keep it.

>   
>       /* AP device is mdev type device */
>       vbasedev->mdev = true;
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 22378d50bc..8c16648819 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -682,7 +682,7 @@ static void vfio_ccw_instance_init(Object *obj)
>        * ram_block_discard_disable().
>        */
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_CCW, &vfio_ccw_ops,
> -                     DEVICE(vcdev), true);
> +                     &vfio_dev_io_ioctl, DEVICE(vcdev), true);
>   }
>   
>   #ifdef CONFIG_IOMMUFD
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 1866b3d3c5..cc0c0f7fc7 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -971,7 +971,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>               continue;
>           }
>   
> -        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +        if (vbasedev->io->device_feature(vbasedev, feature)) {
>               warn_report("%s: Failed to stop DMA logging, err %d (%s)",
>                           vbasedev->name, -errno, strerror(errno));
>           }
> @@ -1074,10 +1074,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>               continue;
>           }
>   
> -        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +        ret = vbasedev->io->device_feature(vbasedev, feature);
>           if (ret) {
> -            ret = -errno;
> -            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
> +            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
>                                vbasedev->name);
>               goto out;
>           }
> @@ -1145,6 +1144,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>       struct vfio_device_feature_dma_logging_report *report =
>           (struct vfio_device_feature_dma_logging_report *)feature->data;
> +    int ret;
>   
>       report->iova = iova;
>       report->length = size;
> @@ -1155,8 +1155,9 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>       feature->flags = VFIO_DEVICE_FEATURE_GET |
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -        return -errno;
> +    ret = vbasedev->io->device_feature(vbasedev, feature);
> +    if (ret) {
> +        return -ret;
>       }
>   
>       return 0;
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 94bbc5747c..bef1540295 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -44,7 +44,7 @@ void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
>           .count = 0,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io->set_irqs(vbasedev, &irq_set);
>   }
>   
>   void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
> @@ -57,7 +57,7 @@ void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
>           .count = 1,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io->set_irqs(vbasedev, &irq_set);
>   }
>   
>   void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
> @@ -70,7 +70,7 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
>           .count = 1,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io->set_irqs(vbasedev, &irq_set);
>   }
>   
>   static inline const char *action_to_str(int action)
> @@ -117,6 +117,7 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       int argsz;
>       const char *name;
>       int32_t *pfd;
> +    int ret;
>   
>       argsz = sizeof(*irq_set) + sizeof(*pfd);
>   
> @@ -129,7 +130,9 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       pfd = (int32_t *)&irq_set->data;
>       *pfd = fd;
>   
> -    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +    ret = vbasedev->io->set_irqs(vbasedev, irq_set);
> +
> +    if (!ret) {
>           return true;
>       }
>   
> @@ -161,6 +164,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           uint32_t dword;
>           uint64_t qword;
>       } buf;
> +    int ret;
>   
>       switch (size) {
>       case 1:
> @@ -180,11 +184,12 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           break;
>       }
>   
> -    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
> +    ret = vbasedev->io->region_write(vbasedev, region->nr, addr, size, &buf);
> +    if (ret != size) {
>           error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
> -                     ",%d) failed: %m",
> +                     ",%d) failed: %s",
>                        __func__, vbasedev->name, region->nr,
> -                     addr, data, size);
> +                     addr, data, size, ret < 0 ? strerror(ret) : "short write");
>       }
>   
>       trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
> @@ -212,11 +217,13 @@ uint64_t vfio_region_read(void *opaque,
>           uint64_t qword;
>       } buf;
>       uint64_t data = 0;
> +    int ret;
>   
> -    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
> -        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
> +    ret = vbasedev->io->region_read(vbasedev, region->nr, addr, size, &buf);
> +    if (ret != size) {
> +        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
>                        __func__, vbasedev->name, region->nr,
> -                     addr, size);
> +                     addr, size, ret < 0 ? strerror(ret) : "short read");
>           return (uint64_t)-1;
>       }
>       switch (size) {
> @@ -561,6 +568,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                            struct vfio_region_info **info)
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
> +    int ret;
>   
>       /* create region cache */
>       if (vbasedev->regions == NULL) {
> @@ -579,10 +587,11 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>   retry:
>       (*info)->argsz = argsz;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
> +    ret = vbasedev->io->get_region_info(vbasedev, *info);
> +    if (ret != 0) {
>           g_free(*info);
>           *info = NULL;
> -        return -errno;
> +        return ret;
>       }
>   
>       if ((*info)->argsz > argsz) {
> @@ -689,11 +698,12 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>   }
>   
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
> -                      DeviceState *dev, bool ram_discard)
> +                      VFIODeviceIO *io, DeviceState *dev, bool ram_discard)
>   {
>       vbasedev->type = type;
>       vbasedev->ops = ops;
>       vbasedev->dev = dev;
> +    vbasedev->io = io;
>       vbasedev->fd = -1;
>   
>       vbasedev->ram_block_discard_allowed = ram_discard;
> @@ -749,3 +759,77 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
>           return NULL;
>       }
>   }
> +
> +/*
> + * Traditional ioctl() based io
> + */
> +
> +static int vfio_io_device_feature(VFIODevice *vbasedev,
> +                                  struct vfio_device_feature *feature)

'vfio_device' prefix ? vfio_device_io_device_feature. Minor since it's
local to the file.

> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_io_get_region_info(VFIODevice *vbasedev,
> +                                   struct vfio_region_info *info)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_io_get_irq_info(VFIODevice *vbasedev,
> +                                struct vfio_irq_info *info)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_io_set_irqs(VFIODevice *vbasedev, struct vfio_irq_set *irqs)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_io_region_read(VFIODevice *vbasedev, uint8_t index, off_t off,
> +                               uint32_t size, void *data)
> +{
> +    struct vfio_region_info *info = vbasedev->regions[index];
> +    int ret;
> +
> +    ret = pread(vbasedev->fd, data, size, info->offset + off);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
> +                                uint32_t size, void *data)
> +{
> +    struct vfio_region_info *info = vbasedev->regions[index];
> +    int ret;
> +
> +    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +VFIODeviceIO vfio_dev_io_ioctl = {

vfio_device_io_ops_ioctl

> +    .device_feature = vfio_io_device_feature,
> +    .get_region_info = vfio_io_get_region_info,
> +    .get_irq_info = vfio_io_get_irq_info,
> +    .set_irqs = vfio_io_set_irqs,
> +    .region_read = vfio_io_region_read,
> +    .region_write = vfio_io_region_write,
> +};
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 812743e9dd..a9cc9366fb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -45,6 +45,14 @@
>   #include "migration/qemu-file.h"
>   #include "system/iommufd.h"
>   
> +/* convenience macros for PCI config space */
> +#define VDEV_CONFIG_READ(vbasedev, off, size, data) \
> +    ((vbasedev)->io->region_read((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
> +                                 (off), (size), (data)))
> +#define VDEV_CONFIG_WRITE(vbasedev, off, size, data) \
> +    ((vbasedev)->io->region_write((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
> +                                  (off), (size), (data)))
> +

Pease introduce these helpers in a separate patch.

>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>   
>   /* Protected by BQL */
> @@ -379,6 +387,7 @@ static void vfio_msi_interrupt(void *opaque)
>   static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>   {
>       g_autofree struct vfio_irq_set *irq_set = NULL;
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       int ret = 0, argsz;
>       int32_t *fd;
>   
> @@ -394,7 +403,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>       fd = (int32_t *)&irq_set->data;
>       *fd = -1;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    ret = vbasedev->io->set_irqs(vbasedev, irq_set);
>   
>       return ret;
>   }
> @@ -453,7 +462,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>           fds[i] = fd;
>       }
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    ret = vdev->vbasedev.io->set_irqs(&vdev->vbasedev, irq_set);
>   
>       g_free(irq_set);
>   
> @@ -763,7 +772,8 @@ retry:
>       ret = vfio_enable_vectors(vdev, false);
>       if (ret) {
>           if (ret < 0) {
> -            error_report("vfio: Error: Failed to setup MSI fds: %m");
> +            error_report("vfio: Error: Failed to setup MSI fds: %s",
> +                         strerror(-ret));
>           } else {
>               error_report("vfio: Error: Failed to enable %d "
>                            "MSI vectors, retry with %d", vdev->nr_vectors, ret);
> @@ -879,14 +889,17 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> +    int ret;
>   
> -    if (vfio_get_region_info(&vdev->vbasedev,
> -                             VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
> -        error_report("vfio: Error getting ROM info: %m");
> +    ret = vfio_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX, &reg_info);
> +
> +    if (ret != 0) {
> +        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
>           return;
>       }
>   
> @@ -911,18 +924,19 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       memset(vdev->rom, 0xff, size);
>   
>       while (size) {
> -        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
> -                      size, vdev->rom_offset + off);
> +        bytes = vbasedev->io->region_read(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
> +                                          off, size, vdev->rom + off);
>           if (bytes == 0) {
>               break;
>           } else if (bytes > 0) {
>               off += bytes;
>               size -= bytes;
>           } else {
> -            if (errno == EINTR || errno == EAGAIN) {
> +            if (bytes == -EINTR || bytes == -EAGAIN) {
>                   continue;
>               }
> -            error_report("vfio: Error reading device ROM: %m");
> +            error_report("vfio: Error reading device ROM: %s",
> +                         strerror(-bytes));
>               break;
>           }
>       }
> @@ -1010,10 +1024,9 @@ static const MemoryRegionOps vfio_rom_ops = {
>   
>   static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
> -    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
>       char *name;
> -    int fd = vdev->vbasedev.fd;
>   
>       if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>           /* Since pci handles romfile, just print a message and return */
> @@ -1030,11 +1043,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>        * Use the same size ROM BAR as the physical device.  The contents
>        * will get filled in later when the guest tries to read it.
>        */
> -    if (pread(fd, &orig, 4, offset) != 4 ||
> -        pwrite(fd, &size, 4, offset) != 4 ||
> -        pread(fd, &size, 4, offset) != 4 ||
> -        pwrite(fd, &orig, 4, offset) != 4) {
> -        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
> +    if (VDEV_CONFIG_READ(vbasedev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
> +        VDEV_CONFIG_WRITE(vbasedev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
> +        VDEV_CONFIG_READ(vbasedev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
> +        VDEV_CONFIG_WRITE(vbasedev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
> +
> +        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
>           return;
>       }
>   
> @@ -1214,6 +1228,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>   
>       memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
> @@ -1226,12 +1241,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>       if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
>           ssize_t ret;
>   
> -        ret = pread(vdev->vbasedev.fd, &phys_val, len,
> -                    vdev->config_offset + addr);
> +        ret = VDEV_CONFIG_READ(vbasedev, addr, len, &phys_val);
>           if (ret != len) {
> -            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
> -                         __func__, vdev->vbasedev.name, addr, len);
> -            return -errno;
> +            const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
> +                         __func__, vbasedev->name, addr, len, err);
> +            return -1;
>           }
>           phys_val = le32_to_cpu(phys_val);
>       }
> @@ -1247,15 +1263,19 @@ void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t val_le = cpu_to_le32(val);
> +    int ret;
>   
>       trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
>   
>       /* Write everything to VFIO, let it filter out what we can't write */
> -    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
> -                != len) {
> -        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
> -                     __func__, vdev->vbasedev.name, addr, val, len);
> +    ret = VDEV_CONFIG_WRITE(vbasedev, addr, len, &val_le);
> +    if (ret != len) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short write";
> +
> +        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
> +                     __func__, vbasedev->name, addr, val, len, err);
>       }
>   
>       /* MSI/MSI-X Enabling/Disabling */
> @@ -1343,9 +1363,12 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       int ret, entries;
>       Error *err = NULL;
>   
> -    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
> -              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
> -        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
> +    ret = VDEV_CONFIG_READ(&vdev->vbasedev, pos + PCI_CAP_FLAGS,
> +                           sizeof(ctrl), &ctrl);
> +    if (ret != sizeof(ctrl)) {
> +        const char *errmsg = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS %s", errmsg);
>           return false;
>       }
>       ctrl = le16_to_cpu(ctrl);
> @@ -1549,34 +1572,43 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>    */
>   static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint8_t pos;
>       uint16_t ctrl;
>       uint32_t table, pba;
> -    int ret, fd = vdev->vbasedev.fd;
>       struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
>                                         .index = VFIO_PCI_MSIX_IRQ_INDEX };
>       VFIOMSIXInfo *msix;
> +    int ret;
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
>       if (!pos) {
>           return true;
>       }
>   
> -    if (pread(fd, &ctrl, sizeof(ctrl),
> -              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
> +    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_FLAGS,
> +                           sizeof(ctrl), &ctrl);
> +    if (ret != sizeof(ctrl)) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed to read PCI MSIX FLAGS: %s", err);
>           return false;
>       }
>   
> -    if (pread(fd, &table, sizeof(table),
> -              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
> +    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_TABLE,
> +                           sizeof(table), &table);
> +    if (ret != sizeof(table)) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed to read PCI MSIX TABLE: %s", err);
>           return false;
>       }
>   
> -    if (pread(fd, &pba, sizeof(pba),
> -              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
> +    ret = VDEV_CONFIG_READ(vbasedev, pos + PCI_MSIX_PBA, sizeof(pba), &pba);
> +    if (ret != sizeof(pba)) {
> +        const char *err = ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_setg(errp, "failed to read PCI MSIX PBA: %s", err);
>           return false;
>       }
>   
> @@ -1591,7 +1623,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>       msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vdev->vbasedev.io->get_irq_info(&vdev->vbasedev, &irq_info);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
>           g_free(msix);
> @@ -1735,10 +1767,12 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>       }
>   
>       /* Determine what type of BAR this is for registration */
> -    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
> -                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
> +    ret = VDEV_CONFIG_READ(&vdev->vbasedev, PCI_BASE_ADDRESS_0 + (4 * nr),
> +                           sizeof(pci_bar), &pci_bar);
>       if (ret != sizeof(pci_bar)) {
> -        error_report("vfio: Failed to read BAR %d (%m)", nr);
> +        const char *err =  ret < 0 ? strerror(-ret) : "short read";
> +
> +        error_report("vfio: Failed to read BAR %d: %s", nr, err);
>           return;
>       }
>   
> @@ -2438,21 +2472,25 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>   
>   void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       Error *err = NULL;
> -    int nr;
> +    int ret, nr;
>   
>       if (!vfio_intx_enable(vdev, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
>       for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
> -        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
> +        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
>           uint32_t val = 0;
>           uint32_t len = sizeof(val);
>   
> -        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
> -            error_report("%s(%s) reset bar %d failed: %m", __func__,
> -                         vdev->vbasedev.name, nr);
> +        ret = VDEV_CONFIG_WRITE(vbasedev, addr, len, &val);
> +        if (ret != len) {
> +            const char *errmsg = ret < 0 ? strerror(-ret) : "short write";
> +
> +            error_report("%s(%s) reset bar %d failed: %s", __func__,
> +                         vbasedev->name, nr, errmsg);
>           }
>       }
>   
> @@ -2794,10 +2832,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   
>       irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
>       if (ret) {
>           /* This can fail for an old kernel or legacy PCI dev */
> -        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
> +        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
>       } else if (irq_info.count == 1) {
>           vdev->pci_aer = true;
>       } else {
> @@ -2915,8 +2953,11 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (ioctl(vdev->vbasedev.fd,
> -              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
> +    if (vdev->vbasedev.io->get_irq_info(&vdev->vbasedev, &irq_info) < 0) {
> +        return;
> +    }
> +
> +    if (irq_info.count < 1) {
>           return;
>       }
>   
> @@ -3368,7 +3409,7 @@ static void vfio_instance_init(Object *obj)
>       vdev->host.function = ~0U;
>   
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_pci_ops,
> -                     DEVICE(vdev), false);
> +                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
>   
>       vdev->nv_gpudirect_clique = 0xFF;
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index f491f4dc95..51534fd941 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -648,7 +648,7 @@ static void vfio_platform_instance_init(Object *obj)
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PLATFORM, &vfio_platform_ops,
> -                     DEVICE(vdev), false);
> +                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
>   }
>   
>   #ifdef CONFIG_IOMMUFD
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 304030e71d..3512556590 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -116,6 +116,7 @@ typedef struct VFIOIOMMUFDContainer {
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>   
>   typedef struct VFIODeviceOps VFIODeviceOps;
> +typedef struct VFIODeviceIO VFIODeviceIO;

I suggest VFIODeviceIOOps
    
>   typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) next;
> @@ -136,6 +137,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       bool migration_events;
>       VFIODeviceOps *ops;
> +    VFIODeviceIO *io;

io_ops

>       unsigned int num_irqs;
>       unsigned int num_regions;
>       unsigned int flags;
> @@ -186,6 +188,29 @@ struct VFIODeviceOps {
>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>   };
>   
> +#ifdef CONFIG_LINUX
> +
> +/*
> + * How devices communicate with the server.  The default option is through
> + * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
> + * process.
> + */
> +struct VFIODeviceIO {
> +    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
> +    int (*get_region_info)(VFIODevice *vdev,
> +                           struct vfio_region_info *info);
> +    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
> +    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
> +    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> +                       void *data);
> +    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> +                        void *data);
> +};
> +
> +extern VFIODeviceIO vfio_dev_io_ioctl;

vfio_dev_io_ops_ioctl

> +> +#endif /* CONFIG_LINUX */
> +
>   typedef struct VFIOGroup {
>       int fd;
>       int groupid;
> @@ -317,6 +342,6 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
> -                      DeviceState *dev, bool ram_discard);
> +                      VFIODeviceIO *io, DeviceState *dev, bool ram_discard);

VFIODeviceIOOps *io_ops

>   int vfio_device_get_aw_bits(VFIODevice *vdev);
>   #endif /* HW_VFIO_VFIO_COMMON_H */

Just minor changes. Looks good.

Thanks,

C.



