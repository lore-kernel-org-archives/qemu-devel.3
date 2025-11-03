Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FC4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuIK-0007O5-SW; Mon, 03 Nov 2025 08:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuII-0007N6-Uo
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:08:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuI2-0006rf-U9
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762175277;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jir3vW3kh1gec9YkQYXcoufMCQ2NIgSa4+jj69QVwoo=;
 b=VYry4EbhD3gc5REs9aKU/XU5TVQEQAMPmtC2vbqrNPAUzOFP7uob9VmdXEfkaSOEu9hIku
 96hd4EeGfVyVLsJnY3DEvviYrLFiWtQ8SVQWirgOP495HZb5bP2CClb6x8FnLUHFIyBBEf
 NGksbsd9XwN7C+geIKcfuQ2jU6Iyf/Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-D5KIpfGhM0OUBAhphk_g6g-1; Mon, 03 Nov 2025 08:07:56 -0500
X-MC-Unique: D5KIpfGhM0OUBAhphk_g6g-1
X-Mimecast-MFC-AGG-ID: D5KIpfGhM0OUBAhphk_g6g_1762175275
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429c61b0ef7so927915f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762175275; x=1762780075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jir3vW3kh1gec9YkQYXcoufMCQ2NIgSa4+jj69QVwoo=;
 b=stYiKqhhEFE10zqbpIoI5tPHo+05HWLJJkPyHWsRVLPg0DOi7MlJIJ8+lYj90N4v1W
 vMbp0vGUC9PIEYxHpgUbK+izVSp9kd6jSNyXNN6/y1smF8qdDfHo8uoWbVdrJnREzV31
 K7cnuYQiu1Nf22Asr30FaUnUYG+xNTobfjLsWvbuPG8A+8LpE5EwH2WOyPCY3xj+cpZp
 A9NV3auOc9+wVcn8Zgd5xEagTWyGR5wTiID6+4pag+ed8sUGquhYpTEqgFcPTLGayEla
 DWvBzADcB3tPx53vlBokqE/60zZi6jL40uIAAxAyCkh7bI3E0NL2k2Rdie98/gc0aWsd
 TY8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlGoZYAxPZ9NlTrV/JHJbc4yaJwpvhNlL0BQF6Rj+U0dqw19MYLrDvWwxm9gZe7JL8upTJc1fQwrVJ@nongnu.org
X-Gm-Message-State: AOJu0Yw09BycSMZCvnKAflPTTWS5CU8n1SjRhN2NpexyNyVlyWONpvwi
 UiwWyEdehppf1FcUDVAQCBwXwUizAU/u0G8jshreRAMdX/UfM4HXuZ/1W5ThpBv5FpvLuubU1AG
 BE10ov41a7hR7ociuICVqryK9NLCpK3E56VccXaOgjkkn2gD/18bqmCuf
X-Gm-Gg: ASbGnctpAPc0uipX5RB9lkGLM2JNVY3sQ4losGzu439/Xf2+qGU+RzyPuN9qim/czLI
 XLWHpho4Sdwmq2TREN2vPviOifGb/vwlgnxT97TI+RCfJJz83PmBjwCY2HAkDlNgtvs553O+1Dz
 mB4iJ4OjiOKislIqwh7aZ/9qWLL3K0/3h7M2bsvvJFUS2WgxzgkoF8ZXo/roBgkbmzyot0Gad+i
 KVax30WtOJshFfQt5aiRUdEFdVJvb5llwV5fEyTy8DWR/LKcknJ+6CEhdNECOjFVzYvJrQzGALu
 dgJ7Tw7TNLPuZGKVI77VfF6+ceI6+bzdyFW6D0C8zSD4N5G3J355G1EWpTIOMg4CcEPJAipyNq8
 pGU7GR3GC/2DTMKA0wz1cjMsJJj2CBaMqWFbHL7z9du76+A==
X-Received: by 2002:a05:6000:2410:b0:3ee:3dce:f672 with SMTP id
 ffacd0b85a97d-429bd676a03mr9985273f8f.4.1762175275340; 
 Mon, 03 Nov 2025 05:07:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkBI+5OKIiFV984u/HuyUHjc0Cpa0y1QoXSRcuM1KeCcB1Dx8F8mTKCxvTzJ825I2/+YqR4g==
X-Received: by 2002:a05:6000:2410:b0:3ee:3dce:f672 with SMTP id
 ffacd0b85a97d-429bd676a03mr9985242f8f.4.1762175274887; 
 Mon, 03 Nov 2025 05:07:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e0325sm21149745f8f.29.2025.11.03.05.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:07:53 -0800 (PST)
Message-ID: <8b344a67-3017-4bce-9482-09b957eafd2b@redhat.com>
Date: Mon, 3 Nov 2025 14:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/23] vfio: Bypass readonly region for dirty tracking
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-21-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-21-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> When doing ditry tracking or calculating dirty tracking range, readonly
dirty tracking or when ...
> regions can be bypassed, because corresponding DMA mappings are readonly
> and never become dirty.
>
> This can optimize dirty tracking a bit for passthrough device.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/listener.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 0862b2b834..cbd86c79af 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -828,7 +828,8 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>          container_of(listener, VFIODirtyRangesListener, listener);
>      hwaddr iova, end;
>  
> -    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
> +    /* Bypass readonly section as it never become dirty */
> +    if (!vfio_listener_valid_section(section, true, "tracking_update") ||
>          !vfio_get_section_iova_range(dirty->bcontainer, section,
>                                       &iova, &end, NULL)) {
>          return;
> @@ -1087,6 +1088,12 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      if (!mr) {
>          goto out_unlock;
>      }
> +
> +    if (!(iotlb->perm & IOMMU_WO) || mr->readonly) {
> +        rcu_read_unlock();
> +        return;
This change is less obvsious compared to the others. Might be worth
explaining why you add it.
> +    }
> +
>      translated_addr = memory_region_get_ram_addr(mr) + xlat;
>  
>      ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> @@ -1222,7 +1229,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (vfio_listener_skipped_section(section, false)) {
> +    if (vfio_listener_skipped_section(section, true)) {
the false -> true change might be squashed into the 18/23 patch while
explainig why you set this value.

Eric
>          return;
>      }
>  


