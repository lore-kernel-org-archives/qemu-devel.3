Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C611EC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x61a7-0006RY-Df; Mon, 14 Sep 2026 03:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x61a5-0006Qg-4r
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x61ZC-000520-Io
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789372649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k5QCEbOB6Zr28+3sr+mvUJZpkwgWGkcnYdhHZODz710=;
 b=DR8VYrFABnbjLZRK4o60lNoALgpBjO3Hjc6bRLZyW6W/pSWiBLnji0tSfYv+HCHb59hraz
 bhTm1qMsgxOu64JI95IIWaFcR+5KY9Z6Bnj2X/a5jFYT83uV4EeJa5PXu9mUHspNyp6Zyp
 7wLOP5FCjhGCAOC4Qg4lDr4f2alHXPQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-u4F4ypdCMTSmjOFhW1oT6Q-1; Mon, 14 Sep 2026 03:57:27 -0400
X-MC-Unique: u4F4ypdCMTSmjOFhW1oT6Q-1
X-Mimecast-MFC-AGG-ID: u4F4ypdCMTSmjOFhW1oT6Q_1789372646
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e745d5dabso10830015e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789372646; x=1789977446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k5QCEbOB6Zr28+3sr+mvUJZpkwgWGkcnYdhHZODz710=;
 b=ZqJqMR/aSPBNuGa9NeO2XAiHgBn1iwzW/bcAA5ii9k84EU3POqmynG2qXV4iwn80gL
 ze/zOdDByLTL7TcC6BgzMqUeXrmw2Xhpzl02vjsfhI/qy06Q+EiFjgjB9M8vtTo7GTGL
 gWup+16K5+ZzVCo/ct0iQowKYa2iPczJPWLEU9tr7Ky4ve5W77FO4vvUKwAmfuEpoXC8
 JfWqNDhZxjjrhckZEv0k8IDixwt/wucM4TmASX9P3bBhKS5rbGe4k53ktZnbGOaBXeXF
 v3oXIQxREoNut4IQ5sFlEGVXzsMPezw+eppDrPQo94T9n+ftTBUjAIEDjaU8xlPBHGHr
 wsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789372646; x=1789977446;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k5QCEbOB6Zr28+3sr+mvUJZpkwgWGkcnYdhHZODz710=;
 b=BiBU/mHLaxD50OvhVXSQUFxwpngp78I9OKLMN9V8tdXWLi5C8cGsz/ZvNCXwwvuLQI
 ymFs8l0z3i+zFXyCz+/t9264Jow2abiydpx6lIyojOwy3Ktl/pgNCG30+4qTFVPVg3jS
 r4QwzZhznJpca0LABTR7SNNB/ntzYKngyHIY+XR1/TuWPmNpgai7p2DiiV/HcHAl6sJX
 jxNaRlp52xxhKMCWNnTziAOxC5uRtYcI+t2CfIOVo+UJUjPczg74/5vdKUEqhMhdIEPW
 ZDIF2Lgg/oCLLFlegirLHILl9EEwUkVW8VnFiaMCrsarhGUpU7n6YB+RvmOT/vIbdU0i
 WO2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBybvuKUWBJgxCXpzkT5hkjG0P3pP+VVT+a+qztiXxPokYmSBpwAPfLqSJZi+ljyFThHYaAqgnrDw7oT@nongnu.org
X-Gm-Message-State: AFuF++k2JzAxYBBDksEhTplD6MOoS/aahxffFtUReifia6cI6tBkjMIE
 m9pE4p4vThn8I7N6qAl2Y6Ha5HLAUJnM9EOaSfED00kx7k0zTx1WtvqJKLgLLEbL3/wntK0YQMb
 anjd85Bl4Uh0HLRgk7ZyiBxf78zSY04FlPoKYQrt6V+io3IdSjVF+zvEl
X-Gm-Gg: AYBFou2NqltU5tv+LOh5hQPOyBL7wGFUtZ+IchHhwAEgYc7/aMKaCZ0idUaCvJhZP9g
 az5PTW/U2MYLFH4yODlnswJOpSp7W2c1nOT7P2+n/yMicTtoG08dpUMrJiwy5PWalsRbR9gUNTK
 9tTJEAee1G8WkCPDoh8dcQvkSHOBfo2l/JeWetKCN3+WhkgN4UKtRkTpLa7Xaw4aO5JZMV5COvm
 5zJlzEy6ITQ23Qmg6KPXYqvQN0WkZSfDC4RKYo13mvHEaClDN6VPm+rSCa5hCTDVHv4Zo48l2KT
 jJ3rwx5LH9hFpgBLOTlZXshdHmbqvPRGhqNZ6jrQCGP4zJtUYNZqZzZ2JknLFv9t0fLqmLLAx7k
 B3rnvwRMRZ4nFddbbSmhkcj+LrOO4C9apl9oGDPfiaw==
X-Received: by 2002:a05:600c:3b08:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49e7a66af45mr30122195e9.11.1789372646271; 
 Mon, 14 Sep 2026 00:57:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3b08:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49e7a66af45mr30121875e9.11.1789372645872; 
 Mon, 14 Sep 2026 00:57:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm185429595e9.2.2026.09.14.00.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 00:57:25 -0700 (PDT)
Message-ID: <a0cdc67f-721c-492f-9c22-8f9e4c56e222@redhat.com>
Date: Mon, 14 Sep 2026 09:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] vfio: route device_reset through io_ops
To: Hugo Komatsu <hugo.komatsu@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>, Thanos Makatos
 <thanos.makatos@nutanix.com>, Tony Krowiak <akrowiak@linux.ibm.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
 <20260911140710.2348139-5-hugo.komatsu@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260911140710.2348139-5-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/11/26 16:19, Hugo Komatsu wrote:
> Various subsystems across QEMU issue kernel ioctls directly for
> VFIO_DEVICE_RESET. Add a guarded vfio_device_reset() wrapper and route
> all callers through a new device_reset slot in VFIODeviceIOOps so an
> alternate transport such as vfio-user can supply its own implementation.
> 
> Implement the kernel backend as a thin wrapper around the existing
> ioctl() call. This is a pure preparatory refactor: the kernel path is
> unchanged.
> 
> Co-authored-by: Rafael Castillo <rafael@trfs.me>
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>
> ---
>   hw/vfio/ap.c                  |  4 ++--
>   hw/vfio/ccw.c                 |  2 +-
>   hw/vfio/device.c              | 20 +++++++++++++++++++-
>   hw/vfio/migration.c           |  7 ++++---
>   hw/vfio/pci.c                 |  4 ++--
>   include/hw/vfio/vfio-device.h | 12 ++++++++++++
>   6 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 6e2a1223ea..52d67a01ee 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -288,10 +288,10 @@ static void vfio_ap_reset(DeviceState *dev)
>       int ret;
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>   
> -    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
> +    ret = vfio_device_reset(&vapdev->vdev);
>       if (ret) {
>           error_report("%s: failed to reset %s device: %s", __func__,
> -                     vapdev->vdev.name, strerror(errno));
> +                     vapdev->vdev.name, strerror(-ret));
>       }
>   }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index c3dc7c1962..054121b71d 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -241,7 +241,7 @@ static void vfio_ccw_reset(DeviceState *dev)
>   {
>       VFIOCCWDevice *vcdev = VFIO_CCW(dev);
>   
> -    ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> +    vfio_device_reset(&vcdev->vdev);
>   }
>   
>   static void vfio_ccw_crw_read(VFIOCCWDevice *vcdev)
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 4f11959633..b2123a0443 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -568,6 +568,14 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>       return false;
>   }
>   
> +int vfio_device_reset(VFIODevice *vbasedev)
> +{
> +    if (!vbasedev->io_ops || !vbasedev->io_ops->device_reset) {
> +        return -EINVAL;
> +    }
> +    return vbasedev->io_ops->device_reset(vbasedev);
> +}
> +
>   int vfio_device_get_feature(VFIODevice *vbasedev,
>                               struct vfio_device_feature *feature)
>   {
> @@ -578,9 +586,18 @@ int vfio_device_get_feature(VFIODevice *vbasedev,
>   }
>   
>   /*
> - * Traditional ioctl() based io
> + * VFIODeviceIOOps implementation for the kernel VFIO backend.
>    */
>   
> +static int vfio_device_io_device_reset(VFIODevice *vbasedev)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_RESET);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
>   static int vfio_device_io_device_feature(VFIODevice *vbasedev,
>                                            struct vfio_device_feature *feature)
>   {
> @@ -660,6 +677,7 @@ static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
>   static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .capabilities = VFIO_IO_CAP_DMA_BUF,
>   
> +    .device_reset = vfio_device_io_device_reset,
>       .device_feature = vfio_device_io_device_feature,
>       .get_region_info = vfio_device_io_get_region_info,
>       .get_irq_info = vfio_device_io_get_irq_info,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 6db4c2a216..25acb6dca4 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -142,7 +142,7 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>       struct vfio_device_feature_mig_state *mig_state =
>           (struct vfio_device_feature_mig_state *)feature->data;
> -    int ret;
> +    int ret, reset_ret;
>       g_autofree char *error_prefix =
>           g_strdup_printf("%s: Failed setting device state to %s.",
>                           vbasedev->name, mig_state_to_str(new_state));
> @@ -219,9 +219,10 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>       return 0;
>   
>   reset_device:
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_RESET)) {
> +    reset_ret = vfio_device_reset(vbasedev);
> +    if (reset_ret) {
>           hw_error("%s: Failed resetting device, err: %s", vbasedev->name,
> -                 strerror(errno));
> +                 strerror(-reset_ret));
>       }
>   
>       vfio_migration_set_device_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 428ab2f069..73b4a93fca 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3785,7 +3785,7 @@ static void vfio_pci_reset(DeviceState *dev)
>   
>       if (vdev->vbasedev.reset_works &&
>           (vdev->has_flr || !vdev->has_pm_reset) &&
> -        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
> +        !vfio_device_reset(&vdev->vbasedev)) {
>           trace_vfio_pci_reset_flr(vdev->vbasedev.name);
>           goto post_reset;
>       }
> @@ -3797,7 +3797,7 @@ static void vfio_pci_reset(DeviceState *dev)
>   
>       /* If nothing else works and the device supports PM reset, use it */
>       if (vdev->vbasedev.reset_works && vdev->has_pm_reset &&
> -        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
> +        !vfio_device_reset(&vdev->vbasedev)) {
>           trace_vfio_pci_reset_pm(vdev->vbasedev.name);
>           goto post_reset;
>       }
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 8472420d3f..6dc596c9fc 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -191,6 +191,17 @@ struct VFIODeviceIOOps {
>        */
>       uint64_t capabilities;
>   
> +    /**
> +     * @device_reset
> +     *
> +     * Perform a device reset.
> +     *
> +     * @vdev: #VFIODevice to use
> +     *
> +     * Returns 0 on success or -errno.
> +     */
> +    int (*device_reset)(VFIODevice *vdev);
> +
>       /**
>        * @device_feature
>        *
> @@ -287,6 +298,7 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size);
>   
> +int vfio_device_reset(VFIODevice *vbasedev);
>   int vfio_device_get_feature(VFIODevice *vbasedev,
>                               struct vfio_device_feature *feature);
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


