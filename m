Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55492D4117F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMkI-0007BM-0l; Thu, 15 Jan 2026 07:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgMjw-0006Su-Qw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgMjv-0002xn-B8
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768481174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jkfwrlgtk5Mc1U9L+sNdP1t+Swe0SzQXpsOuK+CLbi0=;
 b=fDWkJamKu81whsiqIujWOFBJAu/L9eUWZkHAWS8PXSuQk1rVqNQsqGPtbURnbxvDYZISxF
 lzbvPL3df2xVCza7NcRVr5/jJo/2rHdMwFiyl6g8iKZyrJf579N1Qid77PKv22Pjp+PSse
 CdMbRzINZyqsh0UxWJieFWSusHi5H1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-EbKD3w0_MbGMxp9IFf0Dzw-1; Thu, 15 Jan 2026 07:46:12 -0500
X-MC-Unique: EbKD3w0_MbGMxp9IFf0Dzw-1
X-Mimecast-MFC-AGG-ID: EbKD3w0_MbGMxp9IFf0Dzw_1768481172
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edc79ff28so4771295e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 04:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768481171; x=1769085971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jkfwrlgtk5Mc1U9L+sNdP1t+Swe0SzQXpsOuK+CLbi0=;
 b=exULyH0x+ULCcmrM/zRvvRmHQiG2iixgkUtH3NxfyYCxrTOV+uan3XpAFJLNpxYxir
 2SaZotRVGIFrbpenDORW6K6Y82yjRcnYEgc9+NZU28Lbvns7i8/bSaGXLXnokkh2z3Kp
 x2rfBCpXhltYUDrb2z8WSnarlfmJlJLVWs6wUBXh4hp+h5KDLAlDs/XeK66kL+Z8BNrX
 sDDNEw0COxgeADrKVO6VBy/NLxJIodFk77xlg/w6cLORYU04wXtD12rzFshppuvMHqr1
 hiExoGfD4rQOKtPYELzBHbhRz1jfdref7R7U4jkL4guMdCLVQuGNURV5mrFwN6sSgEG4
 PhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768481171; x=1769085971;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkfwrlgtk5Mc1U9L+sNdP1t+Swe0SzQXpsOuK+CLbi0=;
 b=nGM4PTu8BklrGlW0X1L3hyURhfnW2pGufUX3dFanPi/UcuhY955MVVZVrDKKzXczLW
 6i2SKPndxDs3X2+FyWqivT1bkeVTwo3KMoXOrfn8XYmD1dM+p6eXId72DseAades15iU
 0WjcKUdW1OI/IUu43FmB5SPDIaEcI07iM1RGKFGHdH1nS3gYXDpAvm6HGdsZF0snn6eN
 cDhMzC1aVxOFdqloMBtjKwapeKRqe0OddsKWjm1PI7reSePPx7/1jokKhOsE4bdvpV8D
 Gb5G1yY4YS6V6Hvz42oDCDhcsCtYavP+t87nWnYE2dNGUqpGmX5AayXWoaiAfqfhUaFw
 7cog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAIjYrDtaS1MVSY+pJsLsZkvdZFyBP/MKaCt9Wh658muXk3b8xFMDThdjk6/A22eWipFRtqDeJPBTJ@nongnu.org
X-Gm-Message-State: AOJu0YxUyjnbg1FBt+s/kTGrde6Dy7bHtvzdsgNlXj9PRPEBJM2x91sC
 fPQyvSfNSogTzQBAbkuPXY9rSTEJyYi+MqQ9OH1hAABhSbdEvyJBChS5waUols6/8OLnVs9S6B3
 hNFZzbr9w80hYm2+J82t355c+LqqG1ef1KIwe1G+gF76n1rMWg5fX3C3d
X-Gm-Gg: AY/fxX522Pd656MWUZZHrfM+RZK+dKJuOAdT/5/WK1rnt3hqu+VIeKS4X0ZRPVr5I8e
 gVYo5vLd12M8PQMfHZbzVZPVYHbNWX4GqZ7KCf86H/qYe5Ej1ne6N913FjTUHnHDJ08ESfHoybr
 HP1+PTFeOl+ZePFuXfscqcLPontGl0LGZdECtbNrUgBIKGk0bKInMwhwztSPMtQqULBzeWn+yxz
 RRWNa2O0bQiDlcH3ZJSjfkzEEIGSW9qezBjg9kwYsmhlD12u9QVDhSEZS33gPfyu77ZrxJsicrQ
 Tql8cw/S768O0QTldWmXzjiWkCoj9qVrMCgdoVDT+SBec54Q2Zo+BD9BgMw8DeO9PJpQc2G407D
 R06TJBHdmlvRNQmj+DnlOhkOC7ygURylSIahM0g3BsvMYWkie
X-Received: by 2002:a05:600c:1f89:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-47ee33184c2mr69721235e9.4.1768481171460; 
 Thu, 15 Jan 2026 04:46:11 -0800 (PST)
X-Received: by 2002:a05:600c:1f89:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-47ee33184c2mr69720845e9.4.1768481171040; 
 Thu, 15 Jan 2026 04:46:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b267661sm45933115e9.13.2026.01.15.04.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 04:46:10 -0800 (PST)
Message-ID: <785b611e-c26c-4d94-bc2d-d429f16f488b@redhat.com>
Date: Thu, 15 Jan 2026 13:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/vfio: Add helper to retrieve device feature
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, kjaju@nvidia.com
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
 <20260113113754.1189-4-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260113113754.1189-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/13/26 12:37, Shameer Kolothum wrote:
> Add vfio_device_get_feature() as a common helper to retrieve
> VFIO device features.
> 
> No functional change intended.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/vfio/container.c           |  2 +-
>   hw/vfio/device.c              | 10 ++++++++++
>   hw/vfio/listener.c            |  4 ++--
>   include/hw/vfio/vfio-device.h |  3 +++
>   4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 5993d90545..b0cbcf0f4a 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -208,7 +208,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>       feature->flags = VFIO_DEVICE_FEATURE_GET |
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
>   
> -    return vbasedev->io_ops->device_feature(vbasedev, feature);
> +    return vfio_device_get_feature(vbasedev, feature);
>   }
>   
>   static int vfio_container_iommu_query_dirty_bitmap(
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 100532f35d..0d9f42a1f0 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -516,6 +516,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>       vbasedev->bcontainer = NULL;
>   }
>   
> +
>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>   {
>       VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> @@ -527,6 +528,15 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>       return false;
>   }
>   
> +int vfio_device_get_feature(VFIODevice *vbasedev,
> +                            struct vfio_device_feature *feature)
> +{
> +    if (!vbasedev->io_ops || !vbasedev->io_ops->device_feature) {
> +        return -EINVAL;
> +    }
> +    return vbasedev->io_ops->device_feature(vbasedev, feature);
> +}
> +
>   /*
>    * Traditional ioctl() based io
>    */
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 7af0107535..d00fc87f3b 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -879,7 +879,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *bcontainer)
>               continue;
>           }
>   
> -        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
> +        ret = vfio_device_get_feature(vbasedev, feature);
>   
>           if (ret != 0) {
>               warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> @@ -984,7 +984,7 @@ static bool vfio_devices_dma_logging_start(VFIOContainer *bcontainer,
>               continue;
>           }
>   
> -        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
> +        ret = vfio_device_get_feature(vbasedev, feature);
>           if (ret) {
>               error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
>                                vbasedev->name);
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 0bc877ff62..315dbb742a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -259,6 +259,9 @@ void vfio_device_unprepare(VFIODevice *vbasedev);
>   
>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
>   
> +int vfio_device_get_feature(VFIODevice *vbasedev,
> +                            struct vfio_device_feature *feature);
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info);
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


