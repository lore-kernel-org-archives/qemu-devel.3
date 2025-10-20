Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B1CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 07:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAjt5-0008GJ-Le; Mon, 20 Oct 2025 03:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjt3-000899-RV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjt0-0004UF-Qt
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760943648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tvobqeyAEQIKbxgC6IsVvliraQVOZCsHS5HqNL9Vui4=;
 b=Z8F9tUD6H5I7W2gDcCXkPhK2alaxrnD4vLphwwM81LlA8o3xahVg6GtiGLRpRoogN4Ysa8
 GQfAsCrlyi1CirfIO90tKYysXJqByuoxGQnAkCcYdG1d32xnqP8ChzxCYVDDwrb/1F0aU9
 pRkUkXWeBZBZmSNxY6sqOdxCgRXpiIs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Ibwa0cqRONmrqfy2mU6xww-1; Mon, 20 Oct 2025 03:00:39 -0400
X-MC-Unique: Ibwa0cqRONmrqfy2mU6xww-1
X-Mimecast-MFC-AGG-ID: Ibwa0cqRONmrqfy2mU6xww_1760943638
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47113dcc1e0so34054265e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 00:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760943637; x=1761548437;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tvobqeyAEQIKbxgC6IsVvliraQVOZCsHS5HqNL9Vui4=;
 b=id0q7ZiXNBkEnUs/zeLwFPCT92PC3QWR33R7eUY+143bemw3fdcY92ysYWQQTOGT4S
 869ePzb7li+p9heQ7e9h5g8zMLtDGb09au6XL8LuUqPFBDV6ght4DvdnWXDLoVYuvu1x
 g1iEfkj5mm2RMk6bRPD5L0wsZBh+JttFfwETZhKCbSxkgGAwcO2uiQf0Of6VGk8Z9jji
 sh6Q6SBmUTbh3MI25PBpfsmk7wdNLr8rExBkL9TH3uadocjjTeQTbIOlch7QMZMVtqot
 cJSWFpe/MNtSg3qBjoqcLyS1758/VEK2yDyWlme08VlFz+D3aAjNNluzTRICTFMS8nQ+
 kplg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXWM4iMmz5nP+QvL5xz+EHV9+Cx/3Ze1ZhwBtl/toPjd5LhHyWkrHb/WJErWT79qLz36w69b20seBa@nongnu.org
X-Gm-Message-State: AOJu0YyZHlweuv/YWpD/D0u8wzvn/AsbEa6fbJe4jF7r91l5Cu1LDlwf
 bGlKSQ4jdJvKfaVhDfESk1GyIgrfKcENrsHUwbTpByrEuZRYjVZdDb5GE6OvXb1U7IFVcZefkjM
 jpgQY5FCgOPQmVWBop20a1YuG34DC3u8mijIXWZf+aqrraiZen39EBVX+
X-Gm-Gg: ASbGncs2UVHCmVOE7RhaTsxgEV9YDERfbvR0V5jA0bM0mC/bpqSkM39wMQeM79qOhfD
 sPW73Dh7IRVTkUORXmP/Ak5ZTDSfEp+88AM1v+uXewLfaxENdCKKSz0jimURJzmtma+orgVYzDw
 w+V1XJBcEZOXNxBhXLoBZR2TIbW004KuInC8aMRbzmwP2O2+uFdXdrF9stqh0Xbtf8NQZpisYx9
 xUgEz30Jfb2D7nOYIj11MAgAd3pd/WiT/N9CrvkgH6sb2W9yov1u8kxokeAYJTiXuKAr11qmT2x
 Kvb3+KmaVQ9dJG5JlswbUXdskkYOz8bXLEB16kJDgmLQ3B5phps5wx9oddUYsqmRI7OoHN5nciM
 NaZrC32VTQwZSeduWS0cQhE4mVHyexr8O2oY8+Q==
X-Received: by 2002:a05:600c:1d9b:b0:471:a3b:56d with SMTP id
 5b1f17b1804b1-4711792006bmr97929975e9.34.1760943637651; 
 Mon, 20 Oct 2025 00:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Dw0G8aNS53qFMiOUVfYZppZzTa4rL3fmNy2Pekwi3QZP3+oEG2S5KKrKcOOXWsSmznicEg==
X-Received: by 2002:a05:600c:1d9b:b0:471:a3b:56d with SMTP id
 5b1f17b1804b1-4711792006bmr97929595e9.34.1760943637223; 
 Mon, 20 Oct 2025 00:00:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca4931csm113889595e9.0.2025.10.20.00.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 00:00:36 -0700 (PDT)
Message-ID: <b75aa22d-01f6-4da1-8e3d-a261997a903a@redhat.com>
Date: Mon, 20 Oct 2025 09:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251017082234.517827-3-zhenzhong.duan@intel.com>
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
> When a existing mapping is unmapped, there could already be dirty bits
> which need to be recorded before unmap.
> 
> If query dirty bitmap fails, we still need to do unmapping or else there
> is stale mapping and it's risky to guest.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/vfio/iommufd.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 976c0a8814..404e6249ca 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -74,7 +74,13 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> -            /* TODO: query dirty bitmap before DMA unmap */
> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +                                                    iotlb->translated_addr,
> +                                                    &local_err);
> +            if (ret) {
> +                error_report_err(local_err);
> +            }
> +            /* Unmap stale mapping even if query dirty bitmap fails */
>               return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
>           }
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



