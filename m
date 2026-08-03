Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7424C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0pp-0006Qf-6N; Mon, 03 Aug 2026 18:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0pi-0006NL-4D
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0pf-0000yX-8b
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785794903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GT9XZPEYwT4F8AfZ4JukXnfD9oDVOGnbh7YcQwfqk4k=;
 b=b2fo2U1hocH5BvUKdjkZv4I0bUcc2FJHv/m7Jz050zauCKzbxr1Tjkk8iyMz9LE1IqnumE
 Lbtn7GwHqI/6qCm6W9u9FQmVTDsipKh/nwAXNWM2/zQhZWE4zo5ZrLGrogljKeTbc4gBnb
 v2PydUu4Bm+MVKHS0z4u4KR5CmIJvxk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-UBV2SeIpNbmu6xp7Ub_O0A-1; Mon, 03 Aug 2026 18:08:22 -0400
X-MC-Unique: UBV2SeIpNbmu6xp7Ub_O0A-1
X-Mimecast-MFC-AGG-ID: UBV2SeIpNbmu6xp7Ub_O0A_1785794901
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c15fff01a30so273717366b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785794901; x=1786399701; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GT9XZPEYwT4F8AfZ4JukXnfD9oDVOGnbh7YcQwfqk4k=;
 b=VuhfbwSf5Qaa/m4VVtf7+8Iv0TzlB509cqo1MfAIMGG6wa+wtGXIzuvv3avAlAZS6s
 YgwpqAC6Z8VoHmqLyPSGjZQ8xQhZqn3nVqSPPXIw9p8J7eBHLu3qMKkwh1ik1F6SG0uA
 M7pTNLbLd6Z2dyM7/UYGLt7YVJlpTfM3DbzTbXcrBCVW6dbZkiOs+3j2tnxkLUucA1+T
 66MyqhvjNuewkxveFdc9CxD7ie0BTOJxbEOMPyAb53K3XC6PbsILBECA687L2PWp+7kC
 ANS7PCRYdXahGGwE4FI8BYUwptp3aBk32ZN4dMCRy4mfuNvzlZukQ7FDDfp+iVTbRRou
 DlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785794901; x=1786399701;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GT9XZPEYwT4F8AfZ4JukXnfD9oDVOGnbh7YcQwfqk4k=;
 b=Y6Tw00lxK1uZ4bs7Ey/98eMMuxqdH4HLp/uX8NKim08/98WZej6S6YE1vjod5beJ11
 jbs48ZecVsNLvqvyT9BgLsvc25UnwO79GQBqekAH8NsDE1NQbqlphIOuUkYUbDdrYN+T
 nCA+Urt+qGT2xBv7TmWi5+2wQlX5PtbyRWimA/R9sBechSM/KosV6tTuvKkn7ZMaEU8Q
 JvY4IjDqRLqQQWJ3upWkQpBQcGIclJ2bZDES795z7DdiocLOKNJ0h5vAiGcq9YhaWXXd
 Q/xit/gQoFeCZmnSlyXtg+8xTenkUvUTqi9hPnYWxyNUMhGBkRq6m5+ReXCfMFR595Bo
 x6ug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rql7YicGtOWTy0kUB20gbYq2yAbhExmH+0xlkvsq1TNrFoTdpcDzUmScMiTYgc7XsN0Boe6GcEiXI7A@nongnu.org
X-Gm-Message-State: AOJu0YwrCK+/CqdmHw7dHls0zvlPM7bfsxc2d0X5e2avrQL7jqvdN9ER
 HpkXUIfz2MaU6xKw6JzOj2nK8rca8yjUWlL6rvtt8nKy/D+rV4CBk1/qx/UBQGCAhmda/KemrH/
 87SzLzOZKPsINr6BcouCxAbFKRYup6p3+0prYYqfsU38Pv//1IuVDbXDe
X-Gm-Gg: AR+sD13YcDPBZ74SqfJMzyb6nNpQpwiVO4zR2OBcLyxOj/UTqlL+0ZGsYptD5dR1vuG
 Up4kvpzWGXeSf9CBS16GVZFY/GoBPv8NgO6eb2hVsR3QcAVs94DoSQJEonyb6eygsBKrsEmTefn
 775qqcn/V0ACmsklKLZEu8OL2E4IerKW8XubLnI/QEOFdsXaesb1MuiVnwgUyV1bIT1StLkML9F
 wb0N7UCEaIF55m3J2+L5Qaw41peQWT+veHFebKUGC3ddOZMTJeVXmv1I5a8EEe/9BruQGH3Ti79
 Z51b2P1ntR7k6NbolLB/BmaObP72Swlry/LWL3POkMJHDD3Sna1KV+/CUrfJ0nZnooug
X-Received: by 2002:a17:906:1d1a:b0:c17:cf99:6154 with SMTP id
 a640c23a62f3a-c1fe7eec7afmr783488766b.16.1785794900772; 
 Mon, 03 Aug 2026 15:08:20 -0700 (PDT)
X-Received: by 2002:a17:906:1d1a:b0:c17:cf99:6154 with SMTP id
 a640c23a62f3a-c1fe7eec7afmr783486466b.16.1785794900273; 
 Mon, 03 Aug 2026 15:08:20 -0700 (PDT)
Received: from redhat.com ([186.247.166.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd4454472sm595307666b.34.2026.08.03.15.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 15:08:18 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:08:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 5/8] acpi_build: Introduce necessary macros and structs
 for AMD IOMMU IVRS
Message-ID: <20260803175632-mutt-send-email-mst@kernel.org>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-6-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511123937.32743-6-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, May 11, 2026 at 06:09:34PM +0530, Sairaj Kodilkar wrote:
> Introduce necessary macros, along with packed structs which represents
> the AMD IVRS data structure, to hold the necessary information. This
> will improve readability of the current code.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  hw/i386/acpi-build.h | 92 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/amd_iommu.h  |  6 +++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 8ba3c33e4831..9fd60a186db1 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -2,10 +2,102 @@
>  #ifndef HW_I386_ACPI_BUILD_H
>  #define HW_I386_ACPI_BUILD_H
>  #include "hw/acpi/acpi-defs.h"
> +#include "qemu/bitops.h"
>  
>  extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>  
>  void acpi_setup(void);
>  Object *acpi_get_i386_pci_host(void);
>  
> +#define AMD_IVINFO_EFR_SUP       BIT(0)
> +
> +#define AMD_IVHD_FLAG_HT_TUN_EN    BIT(0)
> +#define AMD_IVHD_FLAG_IOTLB_SUP    BIT(4)
> +#define AMD_IVHD_FLAG_PREF_SUP     BIT(6)
> +#define AMD_IVHD_FLAG_PPR_SUP      BIT(7)
> +
> +#define AMD_IVHD_FEATURE_REPORT_XT_SUP_SHIFT      (0)
> +#define AMD_IVHD_FEATURE_REPORT_GT_SUP_SHIFT      (2)
> +#define AMD_IVHD_FEATURE_REPORT_GLX_SUP_SHIFT     (3)
> +#define AMD_IVHD_FEATURE_REPORT_GA_SUP_SHIFT      (6)
> +#define AMD_IVHD_FEATURE_REPORT_GATS_SHIFT        (28)
> +#define AMD_IVHD_FEATURE_REPORT_HATS_SHIFT        (30)
> +
> +#define AMD_IVHD_ATTRIBUTES_HATDIS_SHIFT        (0)
> +
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_RESERVED             (0)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_ALL                  (1)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_SELECT               (2)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_START_RANGE          (3)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE            (4)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_ALIAS_START_RANGE    (0x43)
> +#define AMD_IVHD_DEVICE_ENTRY_TYPE_SPECIAL_DEVICE       (0x48)
> +
> +#define IVHD_VARIETY_IOAPIC (1)
> +#define IVHD_VARIETY_HPET   (2)
> +
> +/*
> + * Vendor(AMD) specific fields in the IVRS header
> + * Excludes fields in ACPI table header
> + */
> +typedef
> +struct AmdIvrsVendorHdr {
> +    uint32_t ivinfo;
> +    uint64_t reserved;
> +} __attribute__((packed)) AmdIvrsVendorHdr;
> +
> +/* IVHD type 10h */
> +typedef
> +struct AmdIvhdHdr10 {
> +    uint8_t type;
> +    uint8_t flags;
> +    uint16_t length;
> +    uint16_t devid;
> +    uint16_t capab_offset;
> +    uint64_t base_addr;
> +    uint16_t pci_seg;
> +    uint16_t iommu_info;
> +    uint32_t iommu_feature_report;
> +} __attribute__((packed)) AmdIvhdHdr10;
> +
> +/* IVHD type 11h */
> +typedef
> +struct AmdIvhdHdr11 {
> +    uint8_t type;
> +    uint8_t flags;
> +    uint16_t length;
> +    uint16_t devid;
> +    uint16_t capab_offset;
> +    uint64_t base_addr;
> +    uint16_t pci_seg;
> +    uint16_t iommu_info;
> +    uint32_t iommu_attributes;
> +    uint64_t efr;
> +    uint64_t efr2;
> +} __attribute__((packed)) AmdIvhdHdr11;
> +
> +typedef
> +struct AmdIvhdDeviceEntry {
> +    uint8_t type;
> +    uint16_t devid;
> +    uint8_t dte_setting;
> +} __attribute__((packed)) AmdIvhdDeviceEntry;
> +
> +typedef
> +struct AmdIvhdDeviceEntryExt {
> +    uint8_t type;
> +    uint16_t devid_a;
> +    uint8_t dte_setting;
> +    union {
> +        struct {
> +            uint8_t handle;
> +            uint16_t devid_b;
> +            uint8_t variety;
> +        } __attribute__((packed));
> +        struct {
> +            uint32_t ext_dte_setting;
> +        } __attribute__((packed));
> +    };
> +} __attribute__((packed)) AmdIvhdDeviceEntryExt;
> +
>  #endif


Pls do not do this is not how we build ACPI tables.
It is completely impossible to match fields and structs to
spec since it does not repeat it verbatim.



Instead of all this write functions matching spec exactly.
Examples:

	/* Table 104: IVHD Device Entry Type Codes (8-byte) */
	build_append_int_noprefix(....) /* Handle */
	build_append_int_noprefix(....) /* DevIDb */
	build_append_int_noprefix(....) /* Variety */


Same with all these numbers they are used exactly once.
Instead of a macro document in a comment:

build_append_int_noprefix(.... (0x0 << 30 /* 00b = 4 levels HATS */) |
			  ....)



You must also find and document for each table the *earliest*
spec that gives the features you are using and where it is in
that spec.
Why earliest? it gives people better idea which guests it can be
compatible with.


> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index fe8f4a6cdc74..d97ddbd612dc 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -175,9 +175,15 @@
>  #define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
>  
>  /* AMDVI paging mode */
> +#define AMDVI_GATS_MODE_SHIFT           (12)
> +#define AMDVI_GATS_MODE_MASK            (3ULL <<  12)
>  #define AMDVI_GATS_MODE                 (2ULL <<  12)
> +#define AMDVI_HATS_MODE_SHIFT           (10)
> +#define AMDVI_HATS_MODE_MASK            (3ULL <<  10)
>  #define AMDVI_HATS_MODE                 (2ULL <<  10)
>  #define AMDVI_HATS_MODE_RESERVED        (3ULL <<  10)
> +#define AMDVI_GLX_SUP_SHIFT             (14)
> +#define AMDVI_GLX_SUP_MASK              (3ULL << 14)
>  
>  /* Page Table format */
>  
> -- 
> 2.34.1


