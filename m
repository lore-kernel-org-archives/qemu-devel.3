Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05CBCD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUE9Z-0002QI-UY; Mon, 01 Jun 2026 21:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE9Y-0002K2-Ap
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:42:48 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE9W-0001j0-8R
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbeBMBY4TW2olEdWKex74soIOTccxYbb0vDsXomj9xDalCJ6VV5Ljs+gkFKrbbzE4f415p3Y11qBkNZa4f5cNv9qySARYwqxZanhQhDFFPTijK+r3V2w1oKqgrMLmIJTz+5VN9dq6RxmFZoO+OasUnIQX30Q4E9Yuj8XwBYERmK5NN/+SZwXvtMOTpZcaG/fosrpvn+H+cv2z4miEddXntDnBrsEqW8xGbfpy/b3EWiOMLWLKgVRnDNz3kMbEwcAGUPqjB6hqzwhAu+TgSLCd1O1supyxKOhkJ35FykXTLbHg+F6s4vd7WA7CUqe5waHwd4UV/G23YhrAB/Lg+pwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyRzP44qOxrLO6Udo18NHrYY5pnThxy+9lySaYEJkVI=;
 b=JI3KDQ/XLZlxwSwWuuNhGIWSA2qL6FWNNFoWbBt8Px4DJ4N+oO3sAlFAzH7viMR5fEzrOdvGtGUZiyzG8Rr7GwmFEYD06EOXl9rGX70GAcqqweHUEj/SmZfIYiYVztjbaHXeGv/1lNqSmEsR8X3Jtd3NSA8iLk7cYGDumC4VLccZ64HgBvAr+TfM5aDvHWhCe3gauwqVB373w8rsiivLV5FQJBqj5ZpfzT73ThUSvbhHpEoC7Ip7Ky+2CatNCorZZO9SdOkebSnaXv/+VfA2cR+2JfphVs+FRVn/kZ9I0ITGBiHdvMg1juNvMO/dhTHFrJgBQ49bhk5dU+uMFbajog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyRzP44qOxrLO6Udo18NHrYY5pnThxy+9lySaYEJkVI=;
 b=n5M6dyw8Reb+BU0IQJVpuf4di4leslHkAmyJHSpBsPCm1qxW6JCgAe+TBo5iUZ/ROJK3Zfaw23lAJuC4V+HPgRjUf8l/mRGwwO9+XDvyl52t95VNAXDpPxV/Ak9rzzqbFqedijXSi0iP4NgkSsHCeClh41+yvADuEJs5M6SE3N8=
Received: from PH7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::20)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 01:42:37 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::7) by PH7P222CA0017.outlook.office365.com
 (2603:10b6:510:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 01:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 01:42:36 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 20:42:36 -0500
Date: Mon, 1 Jun 2026 20:40:16 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 06/12] memory: Rename memory_region_has_guest_memfd()
 to *_private()
Message-ID: <jmdeh7omharcpgvyi6sivvwuhxlsswkizfnu7r4x73n3q5izz5@kgslhh7pw7nb>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-7-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: d121cafd-96c6-4f70-39a2-08dec04839a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: IeGQirjkGtVqdgoVE5Is7DHCFwZg+9DmUoysIt4/u51nFIJ7NdxpqzkDC75Y7KcUiT99J2FYlNC3kI2jeUZM4ntka62yqEvSVEqwYemefNlCiw6otrK13CDmKGBxF2jFJ7NBSadWmTfbXO9ujdJ9H0+buiAoxz1lG+1Ye9fvi3mIxjd995bdpoveIfLHeo0QOGdTMi5lweJ5E5IArExCtqTrCOGNF6DBlA2HQjOSQw3Udrp7bcLweE+FtaGWbGZMskrl23EyixVmWeW6R8DfpaNGgzCWmU0TZ99SO+JJyIWmVdEMa2ZwFsTc/+7C1IixK+g4t/Y3N5dt1DO3s7bf61ZzI2rxr4HEzdc+Wuu4yXp4OwII+fYOYPPM9psl8qDp0F2RxJe9Qmj98HyHPZ5Zx92wTa+VY9LhSsz13Z1zAd/TAnZMc8rU7jYRYLVFuTEKB2V+og2issnUNGvO5uo3PD7fZBL8S36ZZPggMucRiHdXFMVAMuXgH/ZRJzcvVe3VQDmpcOh2ATnyD4NbTKSJLGKh6qNTigSZOrA8wDCsHrZau74FkAQfdQgQCXykgArygsbhf1Gp6mVR1Pg2RcDX1gpHK/f4VaK2VaOeIaQrun3ZFAoythMY69dsZgy44G/ep480TDVtigy9uAPBis2NO1e/c4qarsiLmCGA9iqhUgSWzvG/AVOLI1jTMdY+vVd070wb7SiwxAtNUg0Jwcwh/NpnQxHyyuCUUkcgzbUfKEg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b9vOAt4Ya9MoOX7Cz5E8MXBaepCuvRjoY66AOXvcCvsffAP9WfV6IPxM7+fmlOIbT1b0I9vcFmG+AmltJ+TyA5YbSMu0DSDZTAusFuQ5rr0MkaBCkOVSQix2DlW3gTcBVVM2APV7RF6wW1Rh+uIeImbpMCboLHOStqAFSIdcj0BGkFCHuoiT56vcBbwuKzF15bhF2jCmJHTr9ojT8Oolombqvplk/Nuv2Z15IrQiJrGmGkNZzh19YlMmWNst+aEkU825j9uuxMV0iVmJTM+ySZUXdjbgDqFHwGgLyBgW0dIS8PkLVBvzb9hL22D1MKGgBK22iB94Vfgf9tUskoXIxC3Ma7jc/10455UTDcnBeQgRWuNgb4QzYiDYdocR2HDEi9EfSm/NSq/qE+dl3/5ST6ohDuzM+nqwO6WBmDZ98fYWKwq3l5S5mMAIOuxMHf1r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 01:42:36.9682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d121cafd-96c6-4f70-39a2-08dec04839a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 03:51:57PM -0500, Peter Xu wrote:
> Rename the function with "_private" suffix, to show that it returns true
> only if it has an internal guest-memfd to back private pages (rather than
> fully shared guest-memfd).
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  include/system/memory.h | 4 ++--
>  accel/kvm/kvm-all.c     | 6 +++---
>  system/memory.c         | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1f49f9a0ff..9b58303bb8 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1823,7 +1823,7 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
>  bool memory_region_is_protected(MemoryRegion *mr);
>  
>  /**
> - * memory_region_has_guest_memfd: check whether a memory region has
> + * memory_region_has_guest_memfd_private: check whether a memory region has
>   *     guest_memfd_private associated
>   *
>   * Returns %true if a memory region's ram_block has guest_memfd_private
> @@ -1831,7 +1831,7 @@ bool memory_region_is_protected(MemoryRegion *mr);
>   *
>   * @mr: the memory region being queried
>   */
> -bool memory_region_has_guest_memfd(MemoryRegion *mr);
> +bool memory_region_has_guest_memfd_private(MemoryRegion *mr);
>  
>  /**
>   * memory_region_get_iommu: check whether a memory region is an iommu
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 1126b6f477..0b7ce5a9dd 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -666,7 +666,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
>      if (readonly && kvm_readonly_mem_allowed) {
>          flags |= KVM_MEM_READONLY;
>      }
> -    if (memory_region_has_guest_memfd(mr)) {
> +    if (memory_region_has_guest_memfd_private(mr)) {
>          assert(kvm_guest_memfd_supported);
>          flags |= KVM_MEM_GUEST_MEMFD;
>      }
> @@ -1615,7 +1615,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>              abort();
>          }
>  
> -        if (memory_region_has_guest_memfd(mr)) {
> +        if (memory_region_has_guest_memfd_private(mr)) {
>              err = kvm_set_memory_attributes_private(start_addr, slot_size);
>              if (err) {
>                  error_report("%s: failed to set memory attribute private: %s",
> @@ -3101,7 +3101,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>          return ret;
>      }
>  
> -    if (!memory_region_has_guest_memfd(mr)) {
> +    if (!memory_region_has_guest_memfd_private(mr)) {
>          /*
>           * Because vMMIO region must be shared, guest TD may convert vMMIO
>           * region to shared explicitly.  Don't complain such case.  See
> diff --git a/system/memory.c b/system/memory.c
> index e8c6d484e6..d70968c966 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1897,7 +1897,7 @@ bool memory_region_is_protected(MemoryRegion *mr)
>      return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
>  }
>  
> -bool memory_region_has_guest_memfd(MemoryRegion *mr)
> +bool memory_region_has_guest_memfd_private(MemoryRegion *mr)
>  {
>      return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
>  }
> -- 
> 2.50.1
> 
> 

