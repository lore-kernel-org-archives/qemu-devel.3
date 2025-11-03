Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F4CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFs4b-0008Mb-SC; Mon, 03 Nov 2025 05:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFs4Y-0008Kq-6I
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFs4V-0001N1-OQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762166753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDb/XEchpE6RVDdMZcyvSZug31Qm8GWotXNT4fcWG1w=;
 b=WVhqIVb4hCECRqWiJlBLeS2/zWQw5sD7ZHCoxvxgEp8s0BvpkSSqlHb1gVB6gGc4S2lfvj
 Na7wq4StthHDP+qtXakNnO/zuBlTZFTIm7SGjhAV3UBesLKz8S4etCbEicnBsHe2Vwq5GI
 m5c0Xhz4+0XyQyITcbWwifNiey8KCog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-0dTsbh9HMoW6ULwCOE78ow-1; Mon, 03 Nov 2025 05:45:52 -0500
X-MC-Unique: 0dTsbh9HMoW6ULwCOE78ow-1
X-Mimecast-MFC-AGG-ID: 0dTsbh9HMoW6ULwCOE78ow_1762166751
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47740c1442dso11332365e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762166751; x=1762771551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fDb/XEchpE6RVDdMZcyvSZug31Qm8GWotXNT4fcWG1w=;
 b=Gcn+tTJ62Ig1ocfwbwa+8jQMK7wNhB8AVctf4CK3pLBOQ+ltYDFQcBUglHvmxq5Svd
 tGjwaA9ONGCiS61AKLpTfXvashEeuQRhaj8vQUIMmKNJ6vDv5Al4B7V1MhIT2mFCP+Qb
 xMQlsvfkeZMPF0PF0soXPiM8I3lWAQvPA9TFsfjQHz63+OL2x3AZjEjiMLWcwJDiJIso
 8t7Gq+bE4tLPlnR5bOY4grgLIkWOHvPuQ2By0068/CgkSKTHHq6aF6cIDqJj3/yYsaZW
 Hgni2GPBzMtr6Unxw1LfF4feVL5fcG/MZZrFZIrW3vNAPHR3BWvNcMSkadveJAyMMZqU
 f6wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEJs8N+WXcczabDF5xIyce/mJ91FRE7/c7pn77nxMHyQPK/zdPpYeH6qzyrxCZdxzOwxFkhLK8QNnV@nongnu.org
X-Gm-Message-State: AOJu0YxPON2vHKalhwES64BnC1kIYypNYEVBgFoXoc+YOqAspRZiW5kC
 cwsgVBe8yC5lkB/CpUowQtHE9TgyojJ3dRLHoR9GBUj0DTJFOFZOpAOVyLNwv1rbHxcA3JkkWpl
 xzbmNdwKcw+ks0lygyadIzrXWHpAGdkq1H3FIwfs8RNSbOfT7tsvY5a4J
X-Gm-Gg: ASbGncvn4xPBxOJZOfSYRy9SeHWgCD1U2SPTNFxC1fQNzUID7aeEJ+SwliZfcf9klWv
 xoG3LXnmlkJQoKyMZx1KMl4rYI+338FdlajzSU38ZLZ3Wr8mH1zIfIb+O5ryAZ80GmNXJkyH5RM
 4btUBnjgyPTzUrHvbZQ7gplZ1qlm6bT2Rcp9Qws3b4Side4E08on98A9q9sWQKJpbmad/opvXKQ
 UY+I6AxrdOOeDMw35AktL58+P/1D41WJMROlCWlOPk/QoDIM86mDNId7GqWiyKUZmlKarbkA2Nn
 WvXXmZfBk8ht2TnQd6PKrXI5jmUdzyu6Vm4RCvh0DpMLTbxfEDofIfa+El1fZz/p0u3PPuIlGqE
 +q+L+aZirRSvEznKfZfNHiaJ49Mi0vYVc4wcQOL3SqYMP4Q==
X-Received: by 2002:a05:600c:1d9a:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-477357cf994mr97129015e9.31.1762166751369; 
 Mon, 03 Nov 2025 02:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhFlWYb2AZDh6oErMCrlfJ+QADPQhEjSn55PNzbDE10Sh/Y3itdghYTGQI4JNjnh9V/arjlQ==
X-Received: by 2002:a05:600c:1d9a:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-477357cf994mr97128615e9.31.1762166750907; 
 Mon, 03 Nov 2025 02:45:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fcf439bsm83577165e9.10.2025.11.03.02.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 02:45:50 -0800 (PST)
Message-ID: <d02dc164-007a-4fe8-82d7-28d61c662e54@redhat.com>
Date: Mon, 3 Nov 2025 11:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/23] intel_iommu: Replay pasid bindings after context
 cache invalidation
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-17-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This replays guest pasid bindings after context cache invalidation.
> Actually, programmer should issue pasid cache invalidation with proper
> granularity after issuing context cache invalidation.
>
> We see old linux such as 6.7.0-rc2 not following the spec, it sends
> pasid cache invalidation before context cache invalidation, then QEMU
> depends on context cache invalidation to get pasid entry and setup
> binding.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 47 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/trace-events  |  1 +
>  2 files changed, 48 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1f78274204..edd1416382 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -93,6 +93,8 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>  static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s);
> +static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
> +                                        gpointer user_data);
>  
>  static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>  {
> @@ -2388,6 +2390,13 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>       * VT-d emulation codes.
>       */
>      vtd_iommu_replay_all(s);
> +    /*
> +     * Same for pasid cache invalidation, per VT-d spec 6.5.2.1, a global
> +     * context cache invalidation should be followed by global PASID cache
> +     * invalidation. In order to work with guest not following spec,
> +     * handle global PASID cache invalidation here.
> +     */
> +    vtd_replay_pasid_bindings_all(s);
>  }
>  
>  #ifdef CONFIG_IOMMUFD
> @@ -2589,6 +2598,35 @@ vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>  }
>  #endif
>  
> +static void vtd_pasid_cache_devsi(VTDAddressSpace *vtd_as)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    PCIBus *bus = vtd_as->bus;
> +    uint8_t devfn = vtd_as->devfn;
> +    struct vtd_as_key key = {
> +        .bus = bus,
> +        .devfn = devfn,
> +        .pasid = vtd_as->pasid,
> +    };
> +    VTDPASIDCacheInfo pc_info;
> +
> +    if (!s->fsts || !s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    trace_vtd_pasid_cache_devsi(pci_bus_num(bus),
> +                                VTD_PCI_SLOT(devfn), VTD_PCI_FUNC(devfn));
> +
> +    /* We fake to be global invalidation just to bypass all checks */
can you clarify which checks and why you want to bypass them?
> +    pc_info.type = VTD_INV_DESC_PASIDC_G_GLOBAL;
> +
> +    /*
> +     * We already get vtd_as of the device whose PASID cache is invalidated,
s/get/got. Not sure the comment is worth.
> +     * so just call vtd_pasid_cache_sync_locked() once.
> +     */
> +    vtd_pasid_cache_sync_locked(&key, vtd_as, &pc_info);
> +}
> +
>  /* Do a context-cache device-selective invalidation.
>   * @func_mask: FM field after shifting
>   */
> @@ -2647,6 +2685,15 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
>               * happened.
>               */
>              vtd_address_space_sync(vtd_as);
> +            /*
> +             * Per spec 6.5.2.1, context flush should be followed by PASID
> +             * cache and iotlb flush. In order to work with a guest which does
> +             * not follow spec and missed PASID cache flush, e.g., linux
> +             * 6.7.0-rc2, we have vtd_pasid_cache_devsi() to invalidate PASID
> +             * cache of passthrough device. Host iommu driver would flush
> +             * piotlb when a pasid unbind is pass down to it.
passed
> +             */
> +            vtd_pasid_cache_devsi(vtd_as);
>          }
>      }
>  }
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 5a3ee1cf64..5fa5e93b68 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -28,6 +28,7 @@ vtd_pasid_cache_reset(void) ""
>  vtd_inv_desc_pasid_cache_gsi(void) ""
>  vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
>  vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
> +vtd_pasid_cache_devsi(uint8_t bus, uint8_t dev, uint8_t fn) "Dev selective PC invalidation dev: %02"PRIx8":%02"PRIx8".%02"PRIx8
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


