Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83BFD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vmI-0007St-5n; Mon, 04 Nov 2024 07:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7vm3-0007RQ-8k
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7vm0-0004C9-SA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730721690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlBjU40AvSzxs9TK6e4jRiQtRN3I9IKBYGARY5ZXZ1g=;
 b=fLL6eBr43rb+sWdkm9X9m7rklzunoZNmxdRrIiZgnFgXND+tCN0Fd/h2S4/FIqVQGN0Ty/
 t9jlZCpXguJeRPaZoleD7QKfkeXvYzSY55Hm17SKREXarykC8JhmEyO0a6yZHJrclCs3j+
 vD8P04KBruX5ZGww2rpHqSFVyoXOF78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Oul6jm3SMiyE3N2st6j4ww-1; Mon, 04 Nov 2024 07:01:28 -0500
X-MC-Unique: Oul6jm3SMiyE3N2st6j4ww-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so29582235e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730721687; x=1731326487;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SlBjU40AvSzxs9TK6e4jRiQtRN3I9IKBYGARY5ZXZ1g=;
 b=IvLcye8wG7v0R8VVgFB7gr3GTFJVsH4QsWvRAWVq8Gw2KxgN58FJkC43Ub5FTDcSMO
 ZfKzSrOIaZ0XD8JL6udEDnPEQuBBOREKFNgMcyLrYIeyCmJ1jFWisXi0/aSG+l9NF6jF
 sTL17smHx4AEHAifiiQgT9Qhk1LURbYtp5F+bbOOKgRNXBnYxO+1k+SvYaa35k63bLCD
 3vpn8Ow0+/t8mxTBOn6MwWqJUbHCsnV4/AV1Leq36yFdIEMMSBLRpg3ndbgipqxdSmmf
 cLg1o+as199dH9mOzzhUY/1e+kRCvNuJyjjcSPtnX5yEjYtk2y5/KOjmEKNINgBlgiyy
 JTnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPriGkNGO4Kee3nhmKZCxDg8ax9Ei0KkG/yvBK+Ko17cfhrpFoRwG5vHyatXB/WwO67/ovt8J1thFW@nongnu.org
X-Gm-Message-State: AOJu0Yx6b3llpxzcQm5VsflzKmi5+L9/PuI0BB5LB2bRazFaS8IuTH0t
 kJbGpT3tejLLlzDlMlKfqwu0viSixllOEsnHeIG4W/YzIH7wVTQUTk1buqynbyj8Kt9E8qxYYF2
 80O2l9fQ9Yg5L92+c87087PkoFYJQHwhINS78jUEr2f1VvCfMWjO2
X-Received: by 2002:a5d:598d:0:b0:37c:d4ba:1127 with SMTP id
 ffacd0b85a97d-381be776e4amr13859797f8f.16.1730721687345; 
 Mon, 04 Nov 2024 04:01:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6P7mI2yUz/o5jEETO/nZ1s5o1NJamutDZtWKoPoVwH1VmesJdNOM4HduF1xR+6rhZyYr14Q==
X-Received: by 2002:a5d:598d:0:b0:37c:d4ba:1127 with SMTP id
 ffacd0b85a97d-381be776e4amr13859746f8f.16.1730721686793; 
 Mon, 04 Nov 2024 04:01:26 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:aecb:5a54:cf63:d69d:19ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d40d5sm12967216f8f.25.2024.11.04.04.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 04:01:25 -0800 (PST)
Date: Mon, 4 Nov 2024 07:01:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Message-ID: <20241104070102-mutt-send-email-mst@kernel.org>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-5-zhenzhong.duan@intel.com>
 <3bb9da3b-f1de-4a3a-bdd8-37937ed15d50@intel.com>
 <14799ff1-8da4-4b42-921a-ad1198de1bdb@eviden.com>
 <119078eb-81f0-47a7-81b0-aaf6b7878581@intel.com>
 <SJ0PR11MB674422638A5915D608E9A80992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20241104065029-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB6744765C7F68ABF7449E73F492512@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB6744765C7F68ABF7449E73F492512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 04, 2024 at 11:55:39AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Michael S. Tsirkin <mst@redhat.com>
> >Sent: Monday, November 4, 2024 7:51 PM
> >Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PASID-
> >selective PASID-based iotlb invalidation
> >
> >On Mon, Nov 04, 2024 at 11:46:00AM +0000, Duan, Zhenzhong wrote:
> >>
> >>
> >> >-----Original Message-----
> >> >From: Liu, Yi L <yi.l.liu@intel.com>
> >> >Sent: Monday, November 4, 2024 4:45 PM
> >> >Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PASID-
> >> >selective PASID-based iotlb invalidation
> >> >
> >> >On 2024/11/4 15:37, CLEMENT MATHIEU--DRIF wrote:
> >> >>
> >> >>
> >> >> On 04/11/2024 03:49, Yi Liu wrote:
> >> >>> Caution: External email. Do not open attachments or click links, unless
> >> >>> this email comes from a known sender and you know the content is safe.
> >> >>>
> >> >>>
> >> >>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
> >> >>>> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
> >> >>>> flush stage-2 iotlb entries with matching domain id and pasid.
> >> >>>
> >> >>> Also, call out it's per table Table 21. PASID-based-IOTLB Invalidation of
> >> >>> VT-d spec 4.1.
> >> >>>
> >> >>>> With scalable modern mode introduced, guest could send PASID-selective
> >> >>>> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.
> >> >>>>
> >> >>>> By this chance, remove old IOTLB related definitions which were unused.
> >> >>>
> >> >>>
> >> >>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> >>>> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> >> >>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >> >>>> ---
> >> >>>>    hw/i386/intel_iommu_internal.h | 14 ++++--
> >> >>>>    hw/i386/intel_iommu.c          | 88
> >+++++++++++++++++++++++++++++++++-
> >> >>>>    2 files changed, 96 insertions(+), 6 deletions(-)
> >> >>>>
> >> >>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/
> >> >>>> intel_iommu_internal.h
> >> >>>> index d0f9d4589d..eec8090190 100644
> >> >>>> --- a/hw/i386/intel_iommu_internal.h
> >> >>>> +++ b/hw/i386/intel_iommu_internal.h
> >> >>>> @@ -403,11 +403,6 @@ typedef union VTDInvDesc VTDInvDesc;
> >> >>>>    #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
> >> >>>>    #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
> >> >>>>    #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) &
> >> >>>> VTD_PASID_ID_MASK)
> >> >>>> -#define
> >VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
> >> >>>>
> >> >>>>    /* Mask for Device IOTLB Invalidate Descriptor */
> >> >>>>    #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) &
> >> >>>> 0xfffffffffffff000ULL)
> >> >>>> @@ -433,6 +428,15 @@ typedef union VTDInvDesc VTDInvDesc;
> >> >>>>    #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
> >> >>>>            (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> >> >>>>
> >> >>>> +/* Masks for PIOTLB Invalidate Descriptor */
> >> >>>> +#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
> >> >>>> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
> >> >>>> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
> >> >>>> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) &
> >> >>>> VTD_DOMAIN_ID_MASK)
> >> >>>> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
> >> >>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
> >> >>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
> >> >>>> +
> >> >>>>    /* Information about page-selective IOTLB invalidate */
> >> >>>>    struct VTDIOTLBPageInvInfo {
> >> >>>>        uint16_t domain_id;
> >> >>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> >>>> index 9e6ef0cb99..72c9c91d4f 100644
> >> >>>> --- a/hw/i386/intel_iommu.c
> >> >>>> +++ b/hw/i386/intel_iommu.c
> >> >>>> @@ -2656,6 +2656,86 @@ static bool
> >> >>>> vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
> >> >>>>        return true;
> >> >>>>    }
> >> >>>>
> >> >>>> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
> >> >>>> +                                         gpointer user_data)
> >> >>>> +{
> >> >>>> +    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
> >> >>>> +    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
> >> >>>> +
> >> >>>> +    return ((entry->domain_id == info->domain_id) &&
> >> >>>> +            (entry->pasid == info->pasid));
> >> >>>> +}
> >> >>>> +
> >> >>>> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
> >> >>>> +                                        uint16_t domain_id, uint32_t
> >> >>>> pasid)
> >> >>>> +{
> >> >>>> +    VTDIOTLBPageInvInfo info;
> >> >>>> +    VTDAddressSpace *vtd_as;
> >> >>>> +    VTDContextEntry ce;
> >> >>>> +
> >> >>>> +    info.domain_id = domain_id;
> >> >>>> +    info.pasid = pasid;
> >> >>>> +
> >> >>>> +    vtd_iommu_lock(s);
> >> >>>> +    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
> >> >>>> +                                &info);
> >> >>>> +    vtd_iommu_unlock(s);
> >> >>>> +
> >> >>>> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> >> >>>> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> >> >>>> +                                      vtd_as->devfn, &ce) &&
> >> >>>> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> >> >>>> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> >> >>>> +
> >> >>>> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> >> >>>> +                vtd_as->pasid != pasid) {
> >> >>>> +                continue;
> >> >>>> +            }
> >> >>>> +
> >> >>>> +            if (!s->scalable_modern) {
> >> >>>> +                vtd_address_space_sync(vtd_as);
> >> >>>> +            }
> >> >>>> +        }
> >> >>>> +    }
> >> >>>> +}
> >> >>>> +
> >> >>>> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> >> >>>> +                                    VTDInvDesc *inv_desc)
> >> >>>> +{
> >> >>>> +    uint16_t domain_id;
> >> >>>> +    uint32_t pasid;
> >> >>>> +
> >> >>>> +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
> >> >>>> +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1) ||
> >> >>>> +        inv_desc->val[2] || inv_desc->val[3]) {
> >> >>>> +        error_report_once("%s: invalid piotlb inv desc val[3]=0x%"PRIx64
> >> >>>> +                          " val[2]=0x%"PRIx64" val[1]=0x%"PRIx64
> >> >>>> +                          " val[0]=0x%"PRIx64" (reserved bits unzero)",
> >> >>>> +                          __func__, inv_desc->val[3], inv_desc->val[2],
> >> >>>> +                          inv_desc->val[1], inv_desc->val[0]);
> >> >>>> +        return false;
> >> >>>> +    }
> >> >>>
> >> >>> Need to consider the below behaviour as well.
> >> >>>
> >> >>> "
> >> >>> This
> >> >>> descriptor is a 256-bit descriptor and will result in an invalid descriptor
> >> >>> error if submitted in an IQ that
> >> >>> is setup to provide hardware with 128-bit descriptors (IQA_REG.DW=0)
> >> >>> "
> >> >>>
> >> >>> Also there are descriptions about the old inv desc types (e.g.
> >> >>> iotlb_inv_desc) that can be either 128bits or 256bits.
> >> >>>
> >> >>> "If a 128-bit
> >> >>> version of this descriptor is submitted into an IQ that is setup to provide
> >> >>> hardware with 256-bit
> >> >>> descriptors or vice-versa it will result in an invalid descriptor error.
> >> >>> "
> >> >>>
> >> >>> If DW==1, vIOMMU fetches 32 bytes per desc. In such case, if the guest
> >> >>> submits 128bits desc, then the high 128bits would be non-zero if there is
> >> >>> more than one desc. But if there is only one desc in the queue, then the
> >> >>> high 128bits would be zero as well. While, it may be captured by the
> >> >>> tail register update. Bit4 is reserved when DW==1, and guest would use
> >> >>> bit4 when it only submits one desc.
> >> >>>
> >> >>> If DW==0, vIOMMU fetchs 16bytes per desc. If guest submits 256bits desc,
> >> >>> it would appear to be two descs from vIOMMU p.o.v. The first 128bits
> >> >>> can be identified as valid except for the types that does not requires
> >> >>> 256bits. The higher 128bits would be subjected to the desc sanity check
> >> >>> as well.
> >> >>>
> >> >>> Based on the above, I think you may need to add two more checks. If
> >DW==0,
> >> >>> vIOMMU should fail the inv types that requires 256bits; If DW==1, you
> >> >>> should check the inv_desc->val[2] and inv_desc->val[3]. You've already
> >> >>> done it in this patch.
> >> >>>
> >> >>> Thoughts are welcomed here.
> >> >>
> >> >> Good catch,
> >> >> I think we should write the check in vtd_process_inv_desc
> >> >> rather than updating the handlers.
> >> >>
> >> >> What are your thoughts?
> >> >
> >> >the first check can be done in vtd_process_inv_desc(). The second may
> >> >be better in the handlers as the handlers have the reserved bits check.
> >> >But given that none of the inv types use the high 128bits, so it is also
> >> >acceptable to do it in vtd_process_inv_desc(). Do add proper comment.
> >>
> >> Thanks Yi and Clement's suggestion, I'll send a small series to fix that
> >> for upstream.
> >>
> >> BRs.
> >> Zhenzhong
> >
> >Ok so you will send v5?
> 
> No, what Yi pointed out is an upstream issue, I'll send a small series(3 patches)
> to fix that issue for upstream.
> 
> Thanks
> Zhenzhong

Also ok. There's still gonnu be v5 because of other comments, right?


