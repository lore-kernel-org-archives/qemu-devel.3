Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B0AC0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgS0V-0000z9-Fr; Fri, 07 Feb 2025 12:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tgS0T-0000yo-BN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tgS0R-0008KZ-Qp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738948747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nStwq22OpXctDsOSbt/iPNtiOytdyJ0UxYP5i0GbOGI=;
 b=bxwGWBDu225OE2wYq+hYhoU2J0fRcli7CHei9SorrqKkD/2bVKlH3HXDT7AHJ6ajSMRQQ6
 tWtaanUXCNLPQ60L/+xKig0Jgq54AXp8tLDV8nqyRgvTvw4TJWHZaZ3IKLNvG3w1hdYl5K
 Mi64LgDAFrUA3HPl5ZDMUbwlfQyMyVo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-vR-GEBLxMtal4c534AUVSQ-1; Fri, 07 Feb 2025 12:19:01 -0500
X-MC-Unique: vR-GEBLxMtal4c534AUVSQ-1
X-Mimecast-MFC-AGG-ID: vR-GEBLxMtal4c534AUVSQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361f371908so19055155e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948740; x=1739553540;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nStwq22OpXctDsOSbt/iPNtiOytdyJ0UxYP5i0GbOGI=;
 b=ui1bOI7+d0zVuofAB4RVZF1KvQdqGpoMzL3P744C1zo35/r3xWa1zJxvFenjU8DGfk
 dm4PiXPUFBkO+mocBeD1X4g+mb4fhtbv/OAT7RZXGniUkGd5ukjxoDUnFePXRNAJTUEM
 yyhnqtaBQtM9CD9k67t9qLSJcUj+8EOfFgxjoqEQKqmk5HwNaPcyzNoiCctOBJrJiiXD
 frQowKmENHcrZoIR39D96mflUFknGd3hXkK+1x75trBBV2VaKHSMVAVN4O+ZLgp1BrF+
 LO2wzNsQRJHtVLrC8BemxXqg3u4wM3dArZ48guOFElLlDZ+G5Qk2NBZ2kLwcgyTdguR1
 TaQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlZu2RLez10vmZIiyFSbRCfhgky84j2HBcUmyQEJp8ydfBkT/1Tor/w7SlqQ8lv0bdMSybCcyidnei@nongnu.org
X-Gm-Message-State: AOJu0YzFKc4iEVXuhinsNP2QJhViAkzD8VjyuF8Ic1TQ7uox3XGtH1JP
 O3NH0K3sSll1z6+9NkQWTralka6CCFXtFbP09CMZJZkwTURikS+pVFKJYItzcsf2Ufbq+0BjSts
 oVqrBs0oSYgND2FsYgG9g1yftJn1wlrxY+UWEPd2trUrVznKyamdV
X-Gm-Gg: ASbGncsTMzJB/AgxQrDDYuuI/x6eRH0iNRSEfwypVCvNyAZC49z3sJ0+lMgYnsSeUzs
 gNN8fir7nLEEt980UClPmv94y549lWbyKIzKGMy4lwcS/nwnjUTl3bzzb3k65YmewjB3RKZoAbu
 bw0Xe94oQql3MS79pjwbl7+9DzyMT3TPIrMZ0QqkapUIGKiCvurzeJGuC2/y6umjwf1OEyRF1LW
 e7yUGovMOU6MEtGlzorHMhd6ruVM241fzmbII+qNIWJaBmtp8B2mnYMNGhld6zP5jTn7HD/6qwD
 QLUK6uFXD7mi+s9AU/saRkeChglfgUfa2gICuH69vbU=
X-Received: by 2002:a05:600c:511f:b0:434:e9ee:c3d with SMTP id
 5b1f17b1804b1-439249a82dcmr34012675e9.20.1738948740494; 
 Fri, 07 Feb 2025 09:19:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEt3YkriBYS31dwhTkCN0PnNs+GXVJeb8KvgekTtUkZtcFK1wQVn3dAha8PB7xqktM1kYkYQ==
X-Received: by 2002:a05:600c:511f:b0:434:e9ee:c3d with SMTP id
 5b1f17b1804b1-439249a82dcmr34012445e9.20.1738948740139; 
 Fri, 07 Feb 2025 09:19:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d96548bsm96332275e9.21.2025.02.07.09.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 09:18:59 -0800 (PST)
Message-ID: <69a1ffd3-98b0-4501-8b3d-b634dae79599@redhat.com>
Date: Fri, 7 Feb 2025 18:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/vfio/common: Add a trace point in
 vfio_reset_handler
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, philmd@linaro.org, zhenzhong.duan@intel.com,
 ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-6-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250206142307.921070-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/6/25 15:21, Eric Auger wrote:
> To ease the debug of reset sequence, let's add a trace point
> in vfio_reset_handler()
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c     | 1 +
>   hw/vfio/trace-events | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f7499a9b74..173fb3a997 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1386,6 +1386,7 @@ void vfio_reset_handler(void *opaque)
>   {
>       VFIODevice *vbasedev;
>   
> +    trace_vfio_reset_handler();
>       QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>           if (vbasedev->dev->realized) {
>               vbasedev->ops->vfio_compute_needs_reset(vbasedev);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index cab1cf1de0..c5385e1a4f 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -120,6 +120,7 @@ vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype
>   vfio_legacy_dma_unmap_overflow_workaround(void) ""
>   vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
> +vfio_reset_handler(void) ""
>   
>   # platform.c
>   vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"


