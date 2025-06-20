Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7519BC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSb9V-00052n-EH; Fri, 20 Jun 2025 08:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSb99-0004po-L0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSb97-0002Cs-TW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750423623;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0C0/uBOy9LQw8tyUzFgxbdAmLImyNng4Xrc8ywCdCTE=;
 b=I6f219z6BxQYyBdVCeVk+GHrOPf8DkFGS3l4jwq1Eom94Ley9paTyuUp8FMvK7R15LxYmd
 Csv5u9bZXixHKVbbrZQbHC/txjXjXyTU6+W4q2NT+c906mhmmoRCTOr98CLqkEfE5ALXDC
 kgaOOBdxQDHHRhloAaEoautZr3DZSkQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ecLac6lTM02p8RXDDb1aKw-1; Fri, 20 Jun 2025 08:47:02 -0400
X-MC-Unique: ecLac6lTM02p8RXDDb1aKw-1
X-Mimecast-MFC-AGG-ID: ecLac6lTM02p8RXDDb1aKw_1750423621
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso10984745e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750423621; x=1751028421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0C0/uBOy9LQw8tyUzFgxbdAmLImyNng4Xrc8ywCdCTE=;
 b=KiYyW8XeqP908i0NQ32DUMBsTIUKNVh+wD/NcLh831ZEypvF3A1AGFSNHxgOX1fSde
 b9b8Q7LIt8DAVawPEjHzP1ZLVMOCdFkzPpyLx23lMLcTeWqWSxyVufBYjX68M9DzBO1S
 Ad8lYPeT5pb5V1DbCt2rEKHy+ddIzjJc6EAyHjaAwlEPUmzycmsAKxSVznd33oE4b/JZ
 cGJ5jxVhAX3gw4UTBbO3qRBDhXfbObImNiFSfgcy3hyoy/iQcRcRFE7WL5bIqPrjFeIa
 5zCdS+CUwKfJ8Freil1X+EsAeW2rtPwAJpEZa+/4w2jgAu/WmoSUEaznxHOW5rJs8s8c
 tVJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRO65JyClKm7VCYpCHYjzWOoe2bWsaFgZIZiLNPh9S1bwPjA8ScJnq1jUYE2yDbcrj+NRCEpUehFUC@nongnu.org
X-Gm-Message-State: AOJu0YxLpWzQWpOg1wmmnlVZodT7kGyV5hCiJTSKy57PdpLqWJC85JGg
 kuqc6GZQMuKq+PxVg0NZWwUcA1nfs2sT4ioMVueG+/rEHXshn+g8Cn/cg9KxISbDPBzgZuBPUMy
 nHfoA5ZXjuvaPc3Ju9b7soUz/SdS6c4jQuPcPw0VAIeTXpnEWiry+PtV4
X-Gm-Gg: ASbGncu1Mb16GUP3DQMJqGp38emTXvKk27OWlw4+ZraSZ1zW1UJjEgLXF6bEHa1cPSZ
 UjZr3gQHADGDE1b0MgPrwfCjXEX52nW65A8SZVlT5bUGP/NABi2+vQUYFTVqD3lww7rDHdzUEQp
 yuclnjgimeQoRErtuFHF7udqCo3miVgT109vIeRPk/fiptc0m9YlmyA6P6EtzyAlXRotj+F6nIz
 ntDH6OUBpMJAC2rJnDF9IP+Ldb3PhxnqdrQ1sBiStqI4I+lPBHkZl98ehbicto6boXXyFlcQmih
 gtd0sqNUxZUkexl+84qrZpj0WDSrd0i5zKvLDvh+Z89hanQQMhxL1zilTtwajeD3DNhDIQ==
X-Received: by 2002:a05:600c:c3c1:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-453658ba35amr16834185e9.16.1750423621020; 
 Fri, 20 Jun 2025 05:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLUsGSS+igMz1Y3JUnS/qu2ed24tRi2uVZaqB48dH1paQrwaiLIMpR0nB/n6N+Z6mFhv25ww==
X-Received: by 2002:a05:600c:c3c1:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-453658ba35amr16833865e9.16.1750423620529; 
 Fri, 20 Jun 2025 05:47:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd642sm23809385e9.21.2025.06.20.05.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 05:46:59 -0700 (PDT)
Message-ID: <3babbbd5-23e3-4b6b-9f9c-e879d4ddb125@redhat.com>
Date: Fri, 20 Jun 2025 14:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/19] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> PCI device supports two request types, Requests-without-PASID and
> Requests-with-PASID. Requests-without-PASID doesn't include a PASID TLP
> prefix, IOMMU fetches rid_pasid from context entry and use it as IOMMU's
> pasid to index pasid table.
>
> So we need to translate between PCI's pasid and IOMMU's pasid specially
> for Requests-without-PASID, e.g., PCI_NO_PASID(-1) <-> rid_pasid.
> For Requests-with-PASID, PCI's pasid and IOMMU's pasid are same value.
>
> vtd_as_from_iommu_pasid_locked() translates from BDF+iommu_pasid to vtd_as
> which contains PCI's pasid vtd_as->pasid.
>
> vtd_as_to_iommu_pasid_locked() translates from BDF+vtd_as->pasid to iommu_pasid.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 9d4adc9458..8948b8370f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1602,6 +1602,64 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>      return 0;
>  }
>  
> +static inline int vtd_as_to_iommu_pasid_locked(VTDAddressSpace *vtd_as,
> +                                               uint32_t *pasid)
Is it meaningful to use inline here and below? Below I guess you do so
to avoid "defined but not used" compilation error but I don't think it
should
stay as is.

I don't really understand the iommu_pasid terminology. Either it is a
pasid passed through the PCI transaction or it is the default pasid
found in rid2passid ce field. So that's a pasid both ways ;-) can't you
simply call it pasid.
> +{
> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
> +    uint8_t devfn = vtd_as->devfn;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
> +        ce = cc_entry->context_entry;
> +    } else {
> +        ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
if the above pattern is used at many locations I still think it may be
valuable to have a _locked helper.
> +
> +    /* Translate to iommu pasid if PCI_NO_PASID */
> +    if (vtd_as->pasid == PCI_NO_PASID) {
> +        *pasid = VTD_CE_GET_RID2PASID(&ce);
> +    } else {
> +        *pasid = vtd_as->pasid;
> +    }
> +
> +    return 0;
> +}
> +
> +static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
> +                                                   gpointer user_data)
> +{
> +    VTDAddressSpace *vtd_as = (VTDAddressSpace *)value;
> +    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
why target? can't you name it key instead?
> +    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
> +    uint32_t pasid;
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        return false;
> +    }
> +
> +    return (pasid == target->pasid) && (sid == target->sid);
> +}
> +
> +/* Translate iommu pasid to vtd_as */
same here
> +static inline
> +VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
> +                                                uint16_t sid, uint32_t pasid)
> +{
> +    struct vtd_as_raw_key key = {
> +        .sid = sid,
> +        .pasid = pasid
> +    };
> +
> +    return g_hash_table_find(s->vtd_address_spaces,
> +                             vtd_find_as_by_sid_and_iommu_pasid, &key);
> +}
> +
>  static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>                                       void *private)
>  {
Thanks

Eric


