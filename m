Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C62CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzRQ-0007FX-LJ; Tue, 23 Jun 2026 07:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wbzRP-0007FO-Pz
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wbzRN-000783-WF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782214635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j8BiA4guYFM/MXleWFCVShEP25sPyTxoU8t0O2mbvjQ=;
 b=FEKv+7b+xEjAD/LgfpY1dcmgYDh8l9M+ox2ZTS4UZaxM6saWkaVMhx9xE40Olwv3VRpm0g
 2R+LEqD/H5yrh4fkLE/HTaMF8ndwNMmOuCmfVhtbYetL9hPS23pMgrRYAdzkgZJxwFTOOs
 7PcDGcncFUognIbES0UzGqV9GBE52fM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-JawfkCdLPtCCAXKM-0jlCA-1; Tue, 23 Jun 2026 07:37:13 -0400
X-MC-Unique: JawfkCdLPtCCAXKM-0jlCA-1
X-Mimecast-MFC-AGG-ID: JawfkCdLPtCCAXKM-0jlCA_1782214632
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b4d3d3e6so34866355e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782214632; x=1782819432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=j8BiA4guYFM/MXleWFCVShEP25sPyTxoU8t0O2mbvjQ=;
 b=e0GMn3JiigPbpGtiLkF8r3nD6ZTG6/M7m8LuIhJv4OmN1KVkYsbA0XTB+jKWRIdCEL
 X2crNe1HotNvE6DdCSU7NQ5hmVNi2dx8dCl5vuMRG4F2XJuHFkqtBM/GSdrbRm1KkiX8
 0xfqB288X3zUFRSYY84y34koJbwrnH0fIwrFT/FBN3YwXJKkR76xZXbIDA0U6BqGiUDA
 5rHeinAx8F6Uyt4eKN/TUEGTVOC4ARPcLA9wjtxwDNq9OvwhgFEND9gi1iTiNtdFZgrv
 V4cRw3CG2zanI0Q8zsI/L2ISTfzxKKGuHBI8iGXg0DbQ+/z2K1keAisijybsx0cYLijq
 IHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782214632; x=1782819432;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8BiA4guYFM/MXleWFCVShEP25sPyTxoU8t0O2mbvjQ=;
 b=S/CQlJ4LRXtTCTgb7N3BYSRXvwqepjOxuJoW2QhM2Sl6pnUQtZWZMHaQOJsAQ3eSWM
 tgOv6dSLOUJyekR/jPmms/k85DKANz43zCZ86KRoTU0FSrmnNQMC+HNrxVVBcDdj3VEY
 Dv7eaNOmrmCv/QzDWFVjxoTOViCaPpyuFukC/aGeKLonfmsm7a+N3tGCaFc1ZBD8DssH
 a4qz31yTH8/7Gaz756M4dtodLyXCk+jzDDlI1m3N3PCT+Afwl1toT00UinufWOgGRQX/
 nLj334cm4qGCm2eh45KbaHOwOu7OJTagfxkwsCPFRjqq2Fatv0lFYAcVnVI5kazTaAWr
 LTJQ==
X-Gm-Message-State: AOJu0Yz66MfzKUdl9/rxQgZ7MZyDdrs2kLbH3D8sMPXo7pdpvWaW0wF/
 JhoeUa82Ta/TPGrPdK0XFEqdphtf6yBFPiqOLeLKp0P5m7sn/woeXpwaV2l+1BzoOlP6ipPiZSR
 vN0WbadbRiI8mtsp0hJ6cPF6gqk2aa3vaNgCtQbtttQFNHmBFkoE+T7/O3qoq3ngQaN3SlNqNAk
 XHjqR9GTDeMRPpac6+FWsQGAkNDTd95+jpng==
X-Gm-Gg: AfdE7ckEA5yx43sUTVHn2CZ9BE1mkCtV1FgZkDMvgERFWUQJSoi7bLzejOxBjzHKheq
 j0KxkWIrOVxo4FHaYQaA7PBOR8aeWEXo/Wzqi+xAhVmWG52Q1j5w5EL2Gis+8GqRrdP4lT8nbfl
 SFKLvisYbLRcTdhNlhGj+W1U1LheFO0Qzb15bclSTehxS+T1qUCEpmkFZlv/HGjh2q0Z/FaQALF
 UYEP5C/kFublyJ3LU9x/MmXoe+k2K0qASqM/ShIDZqr+6Lr3FpN6j7E0ZK7wJW7DOjBXrDfVqj0
 bP1gD8bh8+TncHUMGguRtF9Y7MYFc28Ndfa+j9Yw+/adYvGrkslLuop+Czq9XMRtp4VGJiB+AIb
 gf1e5kBoDsegj6TO+WoQfamYhUzY0e4YYCynzgM/zThrJsgNhgCRTsYM=
X-Received: by 2002:a05:600c:8b03:b0:492:45a0:dcef with SMTP id
 5b1f17b1804b1-49249083cb4mr198289835e9.5.1782214632193; 
 Tue, 23 Jun 2026 04:37:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8b03:b0:492:45a0:dcef with SMTP id
 5b1f17b1804b1-49249083cb4mr198288625e9.5.1782214630875; 
 Tue, 23 Jun 2026 04:37:10 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd30078sm369708985e9.7.2026.06.23.04.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 04:37:10 -0700 (PDT)
Message-ID: <2b70ae68-aee7-4c81-8799-6610a582dcb8@redhat.com>
Date: Tue, 23 Jun 2026 13:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 28/41] vfio/listener: Add missing dirty tracking in
 region_del
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <20260113093637.1549214-1-clg@redhat.com>
 <20260113093637.1549214-29-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260113093637.1549214-29-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hello Zhenzhong,

On 1/13/26 10:36, Cédric Le Goater wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> If a VFIO device in guest switches from passthrough(PT) domain to block
> domain, the whole memory address space is unmapped, but we passed a NULL
> iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
> dirty pages.
> 
> By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
> set dirty bits correctly.
> 
> For IOMMU address space, we still send NULL iotlb because VFIO don't know
> the actual mappings in guest. It's vIOMMU's responsibility to send actual
> unmapping notifications, e.g., vtd_address_space_unmap_in_dirty_tracking().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-8-zhenzhong.duan@intel.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/listener.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 62699cb772d786c1510318dff73973ef4d297177..813621f22f8b5ec284388f9c5f719525ec5f282c 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -713,14 +713,34 @@ static void vfio_listener_region_del(MemoryListener *listener,
>   
>       if (try_unmap) {
>           bool unmap_all = false;
> +        IOMMUTLBEntry entry = {}, *iotlb = NULL;
>   
>           if (int128_eq(llsize, int128_2_64())) {
>               assert(!iova);
>               unmap_all = true;
>               llsize = int128_zero();
>           }
> +
> +        /*
> +         * Fake an IOTLB entry for identity mapping which is needed by dirty
> +         * tracking when switch out of PT domain. In fact, in unmap_bitmap,
> +         * only translated_addr field is used to set dirty bitmap.
> +         *
> +         * Note: When switch into PT domain from DMA domain, the whole IOMMU
> +         * MR is deleted without iotlb, before that happen, we depend on
> +         * vIOMMU to send unmap notification with accurate iotlb entry to
> +         * VFIO. See vtd_address_space_unmap_in_dirty_tracking() for example,
> +         * it is triggered during switching to block domain because vtd does
> +         * not support direct switching from DMA to PT domain.
> +         */
> +        if (global_dirty_tracking && memory_region_is_ram(section->mr)) {
> +            entry.iova = iova;
> +            entry.translated_addr = iova;

In an experiment involving a nested setup with L1 + intel_iommu,
an L2 VM with an assigned igb VF can trigger the following QEMU
segv :

   bitmap_set_atomic(map=NULL, start=1, nr=1)
   physical_memory_set_dirty_range(start=0x380004040000, length=4096)
   physical_memory_set_dirty_lebitmap(start=0x380004040000, pages=3)
   vfio_container_query_dirty_bitmap(translated_addr=0x380004040000)
   vfio_legacy_dma_unmap_one(iova=0x380004040000, size=12288)
   vfio_listener_region_del()

The VT-d interrupt-remapping table is mapped pretty high and
translated_addr ends up as a very large value. It seems that
the correct value should be :

   translated_addr = memory_region_get_ram_addr(section->mr) +
                     section->offset_within_region;

as found in vfio_iommu_map_dirty_notify() and
and vfio_ram_discard_query_dirty_bitmap().

Is that correct ?

Thanks,

C.


> +            iotlb = &entry;
> +        }
> +
>           ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
> -                                       NULL, unmap_all);
> +                                       iotlb, unmap_all);
>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",


