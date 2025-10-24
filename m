Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD156CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKjd-0003Iu-9y; Fri, 24 Oct 2025 12:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKjb-0003GY-BX
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKjZ-0002Vu-KX
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761323624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eNbB8AEJ5nc9dluS8eIA/NhTfA01eE5PHcMV01Gcj0M=;
 b=RSN+E6w/OaTYeiM27j5lJoCLiSHTqFkQNrkPfRnO+maPWKcdYaqsCbp49LgmWCtZfng0L5
 Cwj5mVeRo8/eBDNEUnpg2WFjcljqOG/NyJStEGAjk8lEHIkf34kpC2HrO7Tha6P7J/Ypnx
 wpVXxm/U2GNhh+t/2gLfxEfQioR1XBk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-9Bvw-rS_OvSCPc5BwDsczw-1; Fri, 24 Oct 2025 12:33:42 -0400
X-MC-Unique: 9Bvw-rS_OvSCPc5BwDsczw-1
X-Mimecast-MFC-AGG-ID: 9Bvw-rS_OvSCPc5BwDsczw_1761323621
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47113dcc15dso12964855e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 09:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761323621; x=1761928421;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eNbB8AEJ5nc9dluS8eIA/NhTfA01eE5PHcMV01Gcj0M=;
 b=kqi+WBqGdoEZMY5D6ZKWs3MSgW1HjZlX+ly8PQpfMC59QMQI9zV6Ak+CyWxUrHK2y0
 qeQrNs/AcF/GoMNL4SJrh+vLam67qc3i8KnKtSh22w8/D9qXCaA8EbWeHykJCL1oUq0j
 hXGexUMgjI07wJv5RLK9MuaP3E9uTEgStL/F0U6PO/UvrmqJoUQYiBaM5BWjzDVNjGd/
 +fPIDYU8kczcsRExG3p2xlrWJCf+RuTZqGH05galvGiUlbmDNP6ECPL9IHh6zAXKuSKq
 aEMIBOYSJBjy2Lx8YXRgfCJFkC190KFN4dBWQltWRD+icO5lSMo2b7JDOg6MJa3NiGIN
 HiEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDtCDgBl2XStS2mAYtgH0ZFEWUwokqmH98dW2BCrI6yKwIJB6SPj8baOl8kCj75kVR6EQMJdDF6VJM@nongnu.org
X-Gm-Message-State: AOJu0Yx0B5lGF7mgxO0RicfijA0+4W09++58WTtdsRW4PUYZG8BQxr44
 4nw7R3kP2anKNFJMk6V4MUI76E6bxT6LRqtyXBKEi95DBfhPNsMqrNP+kApXON/i8NH7f8ec8bR
 82+7grbGzdi/Ldj1vQJzBrJ+40GjHd6nqB16ru13JXGUQvP7s+xQ/TDnt
X-Gm-Gg: ASbGncsewkB3SFeUNYReagWQSokfBqLkXT8vCCw9RIzQf3IxboMWaDlB+BsQx1p9cra
 72zTrGAziTO2WzeLseNRPxJ3s9y2cor0TVBTeqr0Hloj0WOr7ijj2L8++vi0/ehSI7eCORsj6H/
 pji/JxY2giPT2kwJ3tPVzmBcQFrLr2//c0ZZpjJebxR95Yh/AGMbD+536Vc7RDrNK92179lwZOX
 FKY7SMknpn/gt+IlUJif4ifgcrtC14TeFHBllff4jgA4oo/0896b0U+csAtynTEv3a9vwYXQ9zL
 dvj1WIlInv35/QwMLLQf5KwHOxCPBTaK0Zmk6Az5ggnmQmfE1R7on9wxvpcBZ3JH1a4zD2D7
X-Received: by 2002:a05:600c:1e1f:b0:471:d2f:799a with SMTP id
 5b1f17b1804b1-47117877791mr191573405e9.16.1761323621233; 
 Fri, 24 Oct 2025 09:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNKKewo0ZjwpxxXZUgtbtZyRQnARwXvp2V/Sx/KV4isuQYP0uK+B3juwSnFgfcDW7Y1x/L4A==
X-Received: by 2002:a05:600c:1e1f:b0:471:d2f:799a with SMTP id
 5b1f17b1804b1-47117877791mr191573195e9.16.1761323620837; 
 Fri, 24 Oct 2025 09:33:40 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898adf78sm10715396f8f.32.2025.10.24.09.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 09:33:40 -0700 (PDT)
Message-ID: <39faab3a-f65c-471e-a049-d60cc42725e0@redhat.com>
Date: Fri, 24 Oct 2025 18:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/23] vfio: Bypass readonly region for dirty tracking
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-21-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-21-zhenzhong.duan@intel.com>
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

On 10/24/25 10:43, Zhenzhong Duan wrote:
> When doing ditry tracking or calculating dirty tracking range, readonly
> regions can be bypassed, because corresponding DMA mappings are readonly
> and never become dirty.
> 
> This can optimize dirty tracking a bit for passthrough device.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/listener.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 0862b2b834..cbd86c79af 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -828,7 +828,8 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>           container_of(listener, VFIODirtyRangesListener, listener);
>       hwaddr iova, end;
>   
> -    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
> +    /* Bypass readonly section as it never become dirty */
> +    if (!vfio_listener_valid_section(section, true, "tracking_update") ||
>           !vfio_get_section_iova_range(dirty->bcontainer, section,
>                                        &iova, &end, NULL)) {
>           return;
> @@ -1087,6 +1088,12 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if (!mr) {
>           goto out_unlock;
>       }
> +
> +    if (!(iotlb->perm & IOMMU_WO) || mr->readonly) {


In case you resend, please add a trace event.

Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> +        rcu_read_unlock();
> +        return;
> +    }
> +
>       translated_addr = memory_region_get_ram_addr(mr) + xlat;
>   
>       ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> @@ -1222,7 +1229,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>       int ret;
>       Error *local_err = NULL;
>   
> -    if (vfio_listener_skipped_section(section, false)) {
> +    if (vfio_listener_skipped_section(section, true)) {
>           return;
>       }
>   


