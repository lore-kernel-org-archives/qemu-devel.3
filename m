Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A0CC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlPpV-0008HP-Uh; Fri, 21 Feb 2025 05:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlPpS-0008H4-QC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:00:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlPpQ-0004IE-Nr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740132014;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsjMaj6XKQQAhMaLb2pn2E7X7ooMP/sl6gDyFMkPCoY=;
 b=fiDwgFHaaxMYaoEWAwF9Skz3lY736OpLS1KRvQgKpUQ29mSZLbszEIVKuoI2YNdcG9wOha
 QcqDI/UX0ZaY2lpQWVuYF5cpMlePXFC/MEuQO5Jj2jtX6DSU+V25m+XKjMLAWc75ouH/PJ
 J/6rIbV/Bxh4RR+f0S/Adrs7zvFZESA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-B3ZICZ1yMBuMWUw27gk_XQ-1; Fri, 21 Feb 2025 05:00:13 -0500
X-MC-Unique: B3ZICZ1yMBuMWUw27gk_XQ-1
X-Mimecast-MFC-AGG-ID: B3ZICZ1yMBuMWUw27gk_XQ_1740132012
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f32ac838cso1667285f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 02:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740132012; x=1740736812;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsjMaj6XKQQAhMaLb2pn2E7X7ooMP/sl6gDyFMkPCoY=;
 b=oEDiuJcRUD13mfr8DzjqU3XO5xNBueynfJJ85x23FozMxDg2+quuqlKVWU7wQQoHj/
 3/ZHTWpr+3ohn7Ek1C74qopJadHg/C2ZfwcPzz3pPDDY3gEb+MCHpX7JWLyUfilfPuIv
 Athbx0VuBMEnipbC1mOEpWfUvoFshuEn8JzhBL1xLJBBcH4x7fBxl/oZM9/7s0iT9pbx
 dvKUjTVpMV+9rnoUBqMV5Fr9w/ihAvOOajsxpmyklAxTzni6WW9Gg0CmrECYNyA95sl6
 YN220y5WJ+N9x00zjRt6pbduwu6/Hh9IQ6gf/RBEnLxRKbgOX4fQAhLX8AWQQwYYoUwa
 DeHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpgg0O0CuWmSX7P5a+du9j0zvrL/N5g7y3j+Ss01eQdGrM58p4EGhzKBF2J9uQ3oxmGX8ZvQJDpj0C@nongnu.org
X-Gm-Message-State: AOJu0Ywni1xB/R8Vla4+5dziDddxi4JgEQAEKtRA/LQs/1KkwupgIKGa
 Fex18DHEU70dThWaDNbwDLlnp9z3u2N0MUnr6OZUD1BXBwre19jCdEr32VX7KA2BU7Px8P81Pqn
 qlbnCIiI6xCdu/wmvAQ8jtVT0RvsikEa9JmMA2oThKR1HJFtyTVR6
X-Gm-Gg: ASbGnctdifUjpTb+ZIcOB0vjAKtfo6DdFMbhbx+mjOOi3NCaySBPctWUKdMka0YExdY
 yBK1Ggucz6ytxAL8whWyOmV/plCReWjbR4LY1Yqo5vJVBWX0aUD1vPq4431CotO8S9HKVWlQpom
 /6kRN0VJtL/HVb8AJruc3+6p7Vo98Bw4hoywDSKMMK5GVck7EFEaAKxOPGo8R2TZxWrp83uCJQv
 HI4DctAOFiYORoGqBC2NbuwLpeFg62phlLQOrxV2wrX2X2NrTiq1ehvPAaR9yyhgAhOJ0P5yzsB
 aqF5TosGkLNrm+5bimNSPaxsFo4DORiBd+n5MFky9mDK2ES6LPF6R1G2CfKMriQ=
X-Received: by 2002:a5d:5254:0:b0:38e:65d8:b677 with SMTP id
 ffacd0b85a97d-38f6f05183bmr2170590f8f.33.1740132012050; 
 Fri, 21 Feb 2025 02:00:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjsXK+Xqmv6WtuUqJo/HVYrRri0giAHKE8eQftkKPC27NnIK88MrfxMm06bWnOOHOjgWpHvw==
X-Received: by 2002:a5d:5254:0:b0:38e:65d8:b677 with SMTP id
 ffacd0b85a97d-38f6f05183bmr2170534f8f.33.1740132011659; 
 Fri, 21 Feb 2025 02:00:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fdce7sm23170448f8f.96.2025.02.21.02.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:00:10 -0800 (PST)
Message-ID: <35c93407-b8ab-4286-a254-c62d39222272@redhat.com>
Date: Fri, 21 Feb 2025 11:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 10/20] intel_iommu: Optimize context entry cache
 utilization
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-11-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> There are many call sites referencing context entry by calling
> vtd_as_to_context_entry() which will traverse the DMAR table.
didn't you mean vtd_dev_to_context_entry? instead
>
> In most cases we can use cached context entry in vtd_as->context_cache_entry
> except it's stale. Currently only global and domain context invalidation
> stales it.
s/states/stale

Eric
>
> So introduce a helper function vtd_as_to_context_entry() to fetch from cache
> before trying with vtd_dev_to_context_entry().
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index df5fb30bc8..7709f55be5 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1597,6 +1597,22 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>      return 0;
>  }
>  
> +static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
> +    uint8_t devfn = vtd_as->devfn;
> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
> +
> +    /* Try to fetch context-entry from cache first */
> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
> +        *ce = cc_entry->context_entry;
> +        return 0;
> +    } else {
> +        return vtd_dev_to_context_entry(s, bus_num, devfn, ce);
> +    }
> +}
> +
>  static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>                                       void *private)
>  {
> @@ -1649,9 +1665,7 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
>          return 0;
>      }
>  
> -    ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
> -                                   pci_bus_num(vtd_as->bus),
> -                                   vtd_as->devfn, &ce);
> +    ret = vtd_as_to_context_entry(vtd_as, &ce);
>      if (ret) {
>          if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
>              /*
> @@ -1710,8 +1724,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>      assert(as);
>  
>      s = as->iommu_state;
> -    if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
> -                                 &ce)) {
> +    if (vtd_as_to_context_entry(as, &ce)) {
>          /*
>           * Possibly failed to parse the context entry for some reason
>           * (e.g., during init, or any guest configuration errors on
> @@ -2443,8 +2456,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> +        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>              vtd_address_space_sync(vtd_as);
>          }
> @@ -2466,8 +2478,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>      hwaddr size = (1 << am) * VTD_PAGE_SIZE;
>  
>      QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
> -        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                       vtd_as->devfn, &ce);
> +        ret = vtd_as_to_context_entry(vtd_as, &ce);
>          if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>              uint32_t rid2pasid = PCI_NO_PASID;
>  
> @@ -2974,8 +2985,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> +        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>              uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
>  
> @@ -4154,7 +4164,7 @@ static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
>      assert(vtd_as->pasid != PCI_NO_PASID);
>  
>      /* Try out best to fetch FPD, we can't do anything more */
> -    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> +    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
>          is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
>          if (!is_fpd_set && s->root_scalable) {
>              vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
> @@ -4491,7 +4501,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      /* replay is protected by BQL, page walk will re-setup it safely */
>      iova_tree_remove(vtd_as->iova_tree, map);
>  
> -    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> +    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
>          trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
>                                    "legacy mode",
>                                    bus_n, PCI_SLOT(vtd_as->devfn),


