Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50493CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 07:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFoux-0004r6-2F; Mon, 03 Nov 2025 02:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFouv-0004qy-A1
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFous-0003F7-A3
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762154626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfojPNib9awIaqp8abb/PzqLp8hJx6Elpvi0Ue9m3cQ=;
 b=RRfmx6sOTiV07niBqP4WhjmBdtYxP9k8Bt8CkTX6q4jGLJKjK2X88MylOmx5cw2bxty5Ct
 piO8qAlu7uvaEScXaFun2x5ywynFhoRj4B7ksO8z3PepSbK0LpdVj9ny/Bm3LA2lJ1PlZJ
 GXFzYubkY3VRtkBpkQOzi0R+MKsnWMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-nog8pQ6iOz-JbCn9neao0g-1; Mon, 03 Nov 2025 02:23:45 -0500
X-MC-Unique: nog8pQ6iOz-JbCn9neao0g-1
X-Mimecast-MFC-AGG-ID: nog8pQ6iOz-JbCn9neao0g_1762154624
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso48298895e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 23:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762154624; x=1762759424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CfojPNib9awIaqp8abb/PzqLp8hJx6Elpvi0Ue9m3cQ=;
 b=fLf2xhQWgSVBt6FJWwUcm7mqGOK7W1qlvcgGKVB06tbnwIEMXi0PnwinhN5n86ALkZ
 bgVZG0pKBvKkd951bncL6PeKnt+KGuHy82wpIJ2Kh88Uo2rEZZh2JV2SPiW85DNJBCY9
 IVaSmTCQNbbgf20Lm504j36a7PvM3QoiJIKy9ffn7kqfPjmmDtkTZoYC0yIh+Cer+goY
 8IE6RcUAhZ9WCxdo0QdJL0vs0LA/O7E0KB+drcNfXrJdNOfr8F0EvQhU0IE1qHLCmYy0
 L/makvrcujniRudGu8skBqQdIZVrC5i9JBq3W7QD8l3VfkJ/O6TqWFmIZXJ+HgXdSLy0
 V5xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeKHnOYV6LjXM/ytkxsaEIjdg/5NgHq2Lm0Yl5tpxl6N5FhEprcj5Mnys7ff8x18+D7lOkYlT4vpmp@nongnu.org
X-Gm-Message-State: AOJu0YyEZsP8BXjwJvpHEwE/i5JReVRGEJMby+cOc0jd2DBabU0ZBRke
 u4Spwu/t0uG/7WATpaxkZPON7ZElh2N/1CdOsJH068V1rg90Phd1zMKV4HaY9uF32JeOz/Z3Dip
 w4gSjVzvSKxUg71rYuhPh2bVE61lrEPGUEFTUjvwTIDW5boVn0G7lBi/H
X-Gm-Gg: ASbGncu6z7iEVpjPtMO2YuW3X6TA6P1wDycXGqTLx4BkJfIKIdjT1IjNgjAWO5XmtNB
 ODJRPU0Ch7zW5qHpyiyivLTdIqUOz28nLEhudZM2uaVM89Fyv5NTHEct0GSLMDOLWFWqN4n9JQ0
 jqTVvPE76tD3UWVe/c+iW18dtmS0YDEJTVyXy7SWZe5zcqu7cXPxKt37KQeFTrsvHIFyHxLG10d
 txMOTbkkpAHc0MjonByz7EqQo67086mBgp9JRasy6PrOUSyD2JggnBju4dMGwO2U7RR6o4gtel6
 ePy/J9sj0UKcJzRUnzCWiAJyO8If+CRfwMi4Np6xVI3ROCSh6PzPwm+6nyI6g5XVkBlpOBGIx++
 2BgWbI0f6Lps5bjsq9Hfrqn+pUTJ2DLfwVfw3O25ltNhWJw==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-477308ce7b2mr116652825e9.31.1762154623953; 
 Sun, 02 Nov 2025 23:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7OQJHTT60eo6YAYxXnUxTCb/1HQ2uaM/nKT0lHhRQPWmh/GS1BzQc5iNEWVC7SZaIxhGnuQ==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-477308ce7b2mr116652555e9.31.1762154623473; 
 Sun, 02 Nov 2025 23:23:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772ff83182sm80810365e9.4.2025.11.02.23.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 23:23:43 -0800 (PST)
Message-ID: <4876893b-a8d2-47a9-b7b7-9014c84ed110@redhat.com>
Date: Mon, 3 Nov 2025 08:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/23] intel_iommu: Add some macros and inline functions
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-13-zhenzhong.duan@intel.com>
 <1c750d64-efd9-4942-af00-a36267715837@redhat.com>
 <IA3PR11MB913633AC1F9034AA7EDD987292C7A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB913633AC1F9034AA7EDD987292C7A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Zhenzhong,

On 11/3/25 4:44 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
> I showed the planed change inline, let me know if I misunderstood.
>
> Thanks
> Zhenzhong
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v7 12/23] intel_iommu: Add some macros and inline
>> functions
>>
>> Hi Zhenzhong,
>>
>> On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
>>> Add some macros and inline functions that will be used by following
>>> patch.
>>>
>>> This patch also make a cleanup to change macro
>> VTD_SM_PASID_ENTRY_DID
>>> and VTD_SM_PASID_ENTRY_FSPM to use extract64() just like what smmu
>> does,
>>> because they are either used in following patches or used indirectly by
>>> new introduced inline functions. But we doesn't aim to change the huge
>>> amount of bit mask style macro definitions in this patch, that should be
>>> in a separate patch.
>>>
>>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>>  hw/i386/intel_iommu_internal.h |  8 +++++--
>>>  hw/i386/intel_iommu.c          | 38
>> +++++++++++++++++++++++++++-------
>>>  2 files changed, 37 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index 09edba81e2..df80af839d 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -642,10 +642,14 @@ typedef struct VTDPASIDCacheInfo {
>>>  #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>>>
>>>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted
>> guest-address-width */
>>> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) &
>> VTD_DOMAIN_ID_MASK)
>>> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>>>
>>> -#define VTD_SM_PASID_ENTRY_FSPM          3ULL
>>>  #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
>>> +#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
>>> +/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
>> the above comment is not that useful along with bitmask definition. I
>> would rather move it along with VTD_PE_GET_FS_LEVEL(pe)
> OK, will move it like below:
>
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -56,6 +56,7 @@
>
>  /* pe operations */
>  #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> +/* 4: 4-level paging, 5: 5-level paging */
I think I would rather put quote the spec
paging mode for first-stage translation. • 00: 4-level paging  • 01:
5-level paging

>  #define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
>  #define VTD_PE_GET_SS_LEVEL(pe) \
>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>
>
>>> +#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2,
>> 2)
>>> +#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4,
>> 1)
>>> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
>> I would get rid of _BIT suffix to make it consistent with other fields.
> OK
>
>>>  /* First Stage Paging Structure */
>>>  /* Masks for First Stage Paging Entry */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 56abbb991d..871e6aad19 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -52,8 +52,7 @@
>>>
>>>  /* pe operations */
>>>  #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] &
>> VTD_SM_PASID_ENTRY_PGTT)
>>> -#define VTD_PE_GET_FS_LEVEL(pe) \
>>> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
>>> +#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) +
>> 4)
>>>  #define VTD_PE_GET_SS_LEVEL(pe) \
>>>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>>>
>>> @@ -837,6 +836,31 @@ static inline bool
>> vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>>>      }
>>>  }
>>>
>>> +static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
>>> +{
>>> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
>> also introduce a define for FSPPTR using extract64((x)->val[2]
> Will change like below:
>
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -650,7 +650,7 @@ typedef struct VTDPIOTLBInvInfo {
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>  #define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>
> -#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_FSPTPFN       extract64((x)->val[2], 12, 52)

VTD_SM_PASID_ENTRY_FSPTPFN(x)?

>  #define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
>  /* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
>  #define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a3a4a8a72b..f801458649 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -850,7 +851,7 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>
>  static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
>  {
> -    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
> +    return VTD_SM_PASID_ENTRY_FSPTPFN << 12;
ditto
>  }
>
>
>>> +}
>>> +
>>> +/*
>>> + * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
>>> + *                                 57 bits for 5-level
>> paging(FSPM=01)
>>> + */
>>> +static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
>>> +{
>>> +    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
>> can you add a comment refering to the spec here?
> OK
>
>>> +}
>>> +
>>> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
>>> +{
>>> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
>>> +}
>>> +
>>> +/* check if pgtt is first stage translation */
>>> +static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
>>> +{
>>> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FST);
>>> +}
>>> +
>>>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>>>  {
>>>      return pdire->val & 1;
>>> @@ -1625,7 +1649,7 @@ static uint16_t
>> vtd_get_domain_id(IntelIOMMUState *s,
>>>      if (s->root_scalable) {
>>>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>>> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>>> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>>>      }
>>>
>>>      return VTD_CONTEXT_ENTRY_DID(ce->hi);
>>> @@ -1707,7 +1731,7 @@ static bool
>> vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>>>               */
>>>              return false;
>>>          }
>>> -        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
>>> +        return vtd_pe_pgtt_is_pt(&pe);
>>>      }
>>>
>>>      return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
>>> @@ -3146,9 +3170,9 @@ static void
>> vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>>>          /* Fall through */
>>>      case VTD_INV_DESC_PASIDC_G_DSI:
>>>          if (pc_entry->valid) {
>>> -            did =
>> VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
>>> +            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>>>          } else {
>>> -            did = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>>> +            did = VTD_SM_PASID_ENTRY_DID(&pe);
>>>          }
>>>          if (pc_info->did != did) {
>>>              return;
>>> @@ -5267,7 +5291,7 @@ static int
>> vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>>>          return -EINVAL;
>>>      }
>>>      pgtt = VTD_PE_GET_TYPE(&pe);
>>> -    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>>> +    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
>>>      ret = 0;
>>>      switch (pgtt) {
>>>      case VTD_SM_PASID_ENTRY_FST:
>> Otherwise looks good to me
>>
>> Thanks
>>
>> Eric


