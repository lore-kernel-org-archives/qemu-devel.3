Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31189CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 07:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAjt4-000898-3n; Mon, 20 Oct 2025 03:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjt1-00088j-Sj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjsz-0004UP-Dt
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760943650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nPnS977vRtUX7XQYo41fY1RfprVT0/lLAdzhFiqwd6Q=;
 b=gteDn+aib2Np66HH74gLPlq0U1nvNT/+3kCn1gUyTbEciuPZuw/bcIdK1qp24GNEGEBbul
 CRwXSSE7MZoXt3Ce7vvYaa7BnmwzB40sufptPiQKiJiWekjDMKlJvhrRu/LmUrBLYpg+u1
 ykkO6CIHB/G9Qd6LDP8jFlUx5FzLypg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-xwQQ4m2KNBiHnOpwBUuIpA-1; Mon, 20 Oct 2025 03:00:48 -0400
X-MC-Unique: xwQQ4m2KNBiHnOpwBUuIpA-1
X-Mimecast-MFC-AGG-ID: xwQQ4m2KNBiHnOpwBUuIpA_1760943647
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f6b44ab789so1883535f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 00:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760943647; x=1761548447;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nPnS977vRtUX7XQYo41fY1RfprVT0/lLAdzhFiqwd6Q=;
 b=obB98wERtUxBLKdQb+PLsSrP+0Fz9cBQR5cD2KWnvKg4DxEQ0/GX2Q+3lkUluwn7n+
 ocbowlrqxbOPPgZxEV2/G465A6FLhpvwXaug0ctj5DTW+ItpoeQNU5sN3DDcc1kO/9Kp
 2f1eswheIPznmS1OWILbYBIPR1BPu0cUvSMdMsf1K7WD59tbvO5dNn6VRORhqj4QS76K
 Uo6lCNXl7Gwk6cX9NWR/qDhMHsZLR4LSOT35Uo8buwiVY35SeIWvdJVuw6NX7Vnzd3x7
 WjiaEbgVonYDWNEEgCcC4ouaFK3PYagy81jWe4T+rbzJStqWRyTI1Z0VZL3SIzmNNNrf
 iETw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlnJxqyZRgwWkjvPSi+P8esLqN9SBXehQrpJgbNY2aMe4ABnB2KLsvdSwYnkVQgSb7miGMa3plxL09@nongnu.org
X-Gm-Message-State: AOJu0Yyrxiyn25Kus9sjpUb/P4NbGPqeA0djSjZQCGBmjSiTepwFZ3Fc
 j7ygfIYdd5vE7ra2PccNaHAFGb/ruS8W6+H2Mh+WxCfireVDQ9VWb2d8EfJBkxRI9IdHYZAhvHC
 tWaiRLcL50i2NvWEDiDHiVW39WAXLFScIK7EE21YlgMze8vzYf1c5kexV
X-Gm-Gg: ASbGncv6Yi9EL2Pq56S0n9P63tQOVOhrCaQJpmoFiigh9LZxxMkW6476leSpeaB4op5
 +n1kaWB30FwAFtH1P2IS8UWyucInuxGBiLadKTMezqDg06EJF/0wzCtnhA14o7oqss6dGOlA0S1
 aixHVDC5UP+o8rGAxITSSVZOXoYbzNimcGZpajfj87I9kHvG6GUiV+XMYXc4eJ+1826Wb4QS66Z
 VK6XBIHVglywPANQ/FxAYMjobBjTy52i3lqKQEDI8U0nqBt+yJYToTDUZH8d+WTslJCPhUFDrUI
 6UmSrfr4HXOtWlRNQHgI/MyHoT+QG6QLJVDCv9lu8dqeUUfi9TrNThSvP1Ut7zHKxmvJ4d7SY11
 XTH1VMvGh6bHNoDnrv1Hpr2EI6UET1dN3+HkbUA==
X-Received: by 2002:a05:6000:428a:b0:428:3cd7:a340 with SMTP id
 ffacd0b85a97d-4283cd7a42dmr4990543f8f.35.1760943647277; 
 Mon, 20 Oct 2025 00:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWIyqoyr8+NhZCuT0gbnCssRbt4XLCyfjqwm9KfsDegni0EZrLAyuHIx7mUa936jgIpMyA6g==
X-Received: by 2002:a05:6000:428a:b0:428:3cd7:a340 with SMTP id
 ffacd0b85a97d-4283cd7a42dmr4990512f8f.35.1760943646772; 
 Mon, 20 Oct 2025 00:00:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3acfsm13697628f8f.14.2025.10.20.00.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 00:00:46 -0700 (PDT)
Message-ID: <0925d04c-42f5-488d-8c39-7367768610fa@redhat.com>
Date: Mon, 20 Oct 2025 09:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] vfio/container-legacy: rename
 vfio_dma_unmap_bitmap() to vfio_legacy_dma_unmap_get_dirty_bitmap()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-4-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251017082234.517827-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/25 10:22, Zhenzhong Duan wrote:
> This is to follow naming style in container-legacy.c to have low level functions
> with vfio_legacy_ prefix.
> 
> No functional changes.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/container-legacy.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index 8e9639603e..b7e3b892b9 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -68,9 +68,10 @@ static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
>       }
>   }
>   
> -static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
> -                                 hwaddr iova, uint64_t size,
> -                                 IOMMUTLBEntry *iotlb)
> +static int
> +vfio_legacy_dma_unmap_get_dirty_bitmap(const VFIOLegacyContainer *container,
> +                                       hwaddr iova, uint64_t size,
> +                                       IOMMUTLBEntry *iotlb)
>   {
>       const VFIOContainer *bcontainer = VFIO_IOMMU(container);
>       struct vfio_iommu_type1_dma_unmap *unmap;
> @@ -141,7 +142,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> -            return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
> +            return vfio_legacy_dma_unmap_get_dirty_bitmap(container, iova, size,
> +                                                          iotlb);
>           }
>   
>           need_dirty_sync = true;


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



