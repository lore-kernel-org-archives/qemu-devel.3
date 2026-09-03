Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45F3C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29cl-0006VR-5N; Thu, 03 Sep 2026 11:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x29cj-0006V4-UU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x29ch-0003xk-Vi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788450306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b+DK91tTxssu4/0f4X+Jf+ZYsgQzv5sYm6l+mev4xi4=;
 b=FeXmd0dG/okmx5HSq8vb2k6NFW41PXMXK3D4c89aNNVLYSdCeGW7siZOqFn0CenRHBNx44
 juJOcOzs73F8MEbxConAzBwKRDxCryV6jjSQD21s6rdtCZrZ2yOPx1zGSOyk8ckOpx3wjB
 7bsJ4pcRUyZJksSWpZNnFPX/h3S8XLE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-UGzYhYXKNcagWIe5u-EKlA-1; Thu, 03 Sep 2026 11:45:05 -0400
X-MC-Unique: UGzYhYXKNcagWIe5u-EKlA-1
X-Mimecast-MFC-AGG-ID: UGzYhYXKNcagWIe5u-EKlA_1788450304
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so126115e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788450304; x=1789055104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b+DK91tTxssu4/0f4X+Jf+ZYsgQzv5sYm6l+mev4xi4=;
 b=VR5/Rh3/XcR4Mey7qZFFGp6srA4XenLnOnoPkWgSnn6chaiCWVVJCRHdp2Pw5ikfEo
 KisfTHvALF6M7/c/DBeEKHS93SJduoh3g7+8gVDTvWy30RcAi+MfmiwVHk4wa/J5/Q/7
 5OUhjsLzYZbymj15mgeUiecrFbEH59dPDMPFLtblhW7YEW4LEFXOODwG+EMJdjL3LuI1
 aT8wTRS2uUA0MHymO13LF3EsYN4U9m6Gquntnh7jiDRVrMvzli1yDBHCEZiSl5J989/w
 JnPTSuLuFt1kK32vNWLJBvSZBZOtJWqCjrkl/VQSezKmMNk30/OPCe43R0DSN9jP5Bd0
 Qr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450304; x=1789055104;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b+DK91tTxssu4/0f4X+Jf+ZYsgQzv5sYm6l+mev4xi4=;
 b=EuUZIhQXQZfAnE+kFTx1bfbYMnVBFLoSsR3+KR10MveVULb/m0jsFertBTkDqy6vNP
 odxZgE//gGeUvhj8jy7TWOMTxjjOk2fNOy08lMxQfSBGL6mGLMsNiwfF5nmW9r0yoW5Z
 KMRyoPNuSPD2oHJbSHkd+kwwmvyUtNAw5xp3jxzRZS1lCO1u4qTvC9dPqcsjSkPOCgyD
 BDhDSb4d3mWQYsyTs8HNAnFBB4v3iUn2VByxj0e7Tvl9rUHslXHR38JkL4LJeH0/CDA8
 WbOaFVSS1J3wM5CyVduK8c7TSWhwBQEyPCmdviIh+OL+0zC36znYjmQTIAO8BeK7enZM
 Ccog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcncagsIAym0tRK7FewoUaBreRp9qEpRdENNcB+penxpkOLWU5P8wm1wQtvXnfkY5e8F/8cfMMljKe@nongnu.org
X-Gm-Message-State: AFuF++ko+LowJpOt8S1K7SBnnvuZ2wYrfBKUBtETsLvcBvznGnmfvaEr
 E6pK2TPzmdV1q0cd053Xk1WrbHmYys7iiIRWF+UrmdAW8G7T+tm5s+GOnyNBgByXK8h2JiJS/Ti
 gFpNF44f8YvUM6HV6BH9zEod+xqdfycfno+GY+xrZFsWz0w35FBf4wwvh
X-Gm-Gg: AYBFou3mKER4Td8jHLwwwib6rS++jKCiWx3z5DbQgqlxaQIwwFNZmU2m6G7ujL3Xhdb
 XSB3H3xriLzwQoFSczdOzJVqjjQOwpsYKu088nr68lTyoWJ5YAwztuN0Gq2odjBfuFKzDejM07h
 3nudntyk0rdme0eck+hAprRjJjetwcfEnjKnTzehUATN92d2VikKdKNAlZDUA26Hnnryc5e6xZu
 vHTtTmjLbfwg67xtEwiL5oV7VoECqlklQisNdyLGdWELD9YWSHpBdUjzNeiXTXhNDbDUDOVlm9a
 OvX+BsSEuGaNQ5/rOHBZ8LW918NAskJzSGtP5MKKh8QZLO7NZAptlTGIBrMGtjZ1IFujaN8C9S7
 x2arGU68366tzHrlA2aT0Ci6/6AHULkiAQU6QxjA=
X-Received: by 2002:a05:600c:8b05:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49ce5817bfemr289784405e9.6.1788450303992; 
 Thu, 03 Sep 2026 08:45:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49ce5817bfemr289782505e9.6.1788450303423; 
 Thu, 03 Sep 2026 08:45:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:bf4:da16:e208:c6bd?
 ([2a01:e0a:1292:d530:bf4:da16:e208:c6bd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm137536065e9.1.2026.09.03.08.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 08:45:00 -0700 (PDT)
Message-ID: <9f4314f0-a8db-4d0d-87ba-bc910f683dd3@redhat.com>
Date: Thu, 3 Sep 2026 17:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] vfio: route device_reset through io_ops
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
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
 <20260903130833.1437632-5-hugo.komatsu@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260903130833.1437632-5-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 9/3/26 15:08, Hugo Komatsu wrote:
> Various subsystems across QEMU issue kernel ioctls directly for
> VFIO_DEVICE_RESET. Route these through a new device_reset slot in the
> VFIODeviceIOOps table so an alternate transport (vfio-user) can supply
> its own implementation.
> 
> Implement the kernel version as a thin wrapper around the existing
> ioctl() call. This is a pure preparatory refactor: the kernel path
> is unchanged.
> 
> Co-authored-by: Rafael Castillo <rafael@trfs.me>
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>

This should introduce a vfio_device_reset() wrapper (with the null
guard) just like vfio_device_get_feature(), and all callers should
use it.


> ---
>   hw/vfio/ap.c                  |  4 ++--
>   hw/vfio/ccw.c                 |  2 +-
>   hw/vfio/device.c              | 13 +++++++++++--
>   hw/vfio/migration.c           |  7 ++++---
>   hw/vfio/pci.c                 |  4 ++--
>   include/hw/vfio/vfio-device.h | 11 +++++++++++
>   6 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 6e2a1223ea..3f7652b4e2 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -288,10 +288,10 @@ static void vfio_ap_reset(DeviceState *dev)
>       int ret;
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>   
> -    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
> +    ret = vapdev->vdev.io_ops->device_reset(&vapdev->vdev);
>       if (ret) {
>           error_report("%s: failed to reset %s device: %s", __func__,
> -                     vapdev->vdev.name, strerror(errno));
> +                     vapdev->vdev.name, strerror(-ret));
>       }
>   }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index c3dc7c1962..6d5307e568 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -241,7 +241,7 @@ static void vfio_ccw_reset(DeviceState *dev)
>   {
>       VFIOCCWDevice *vcdev = VFIO_CCW(dev);
>   
> -    ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> +    vcdev->vdev.io_ops->device_reset(&vcdev->vdev);
>   }
>   
>   static void vfio_ccw_crw_read(VFIOCCWDevice *vcdev)
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 4f11959633..e7d293710e 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -578,9 +578,18 @@ int vfio_device_get_feature(VFIODevice *vbasedev,
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
> @@ -659,7 +668,7 @@ static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
>   
>   static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .capabilities = VFIO_IO_CAP_DMA_BUF,
> -

Please keep the empty line.

Thanks,

C.

> +    .device_reset = vfio_device_io_device_reset,
>       .device_feature = vfio_device_io_device_feature,
>       .get_region_info = vfio_device_io_get_region_info,
>       .get_irq_info = vfio_device_io_get_irq_info,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ea6734823b..1941678e29 100644
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
> +    reset_ret = vbasedev->io_ops->device_reset(vbasedev);
> +    if (reset_ret) {
>           hw_error("%s: Failed resetting device, err: %s", vbasedev->name,
> -                 strerror(errno));
> +                 strerror(-reset_ret));
>       }
>   
>       vfio_migration_set_device_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 428ab2f069..12f2974d19 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3785,7 +3785,7 @@ static void vfio_pci_reset(DeviceState *dev)
>   
>       if (vdev->vbasedev.reset_works &&
>           (vdev->has_flr || !vdev->has_pm_reset) &&
> -        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
> +        !vdev->vbasedev.io_ops->device_reset(&vdev->vbasedev)) {
>           trace_vfio_pci_reset_flr(vdev->vbasedev.name);
>           goto post_reset;
>       }
> @@ -3797,7 +3797,7 @@ static void vfio_pci_reset(DeviceState *dev)
>   
>       /* If nothing else works and the device supports PM reset, use it */
>       if (vdev->vbasedev.reset_works && vdev->has_pm_reset &&
> -        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {
> +        !vdev->vbasedev.io_ops->device_reset(&vdev->vbasedev)) {
>           trace_vfio_pci_reset_pm(vdev->vbasedev.name);
>           goto post_reset;
>       }
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 8472420d3f..a8fed550eb 100644
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


