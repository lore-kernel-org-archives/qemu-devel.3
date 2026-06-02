Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876F0CD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUE8s-0001Hz-E9; Mon, 01 Jun 2026 21:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE8q-0001HQ-9N
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:42:04 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE8o-0001XP-9R
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7YPMI5sLqJbrUHhXSeeociRqV9p7eiQQqh5/r+OSTDd7GDAsHkXUjgUfiEOpPzltRiHmHGLpJR/a3TWcCzIrV/k1vmiNg1BQf64N9qb1cwMazzoc2CvXLCmh9SDWbObfoYCpFmY1awjvBveqf1rVmp8jiWanhiU83HQSdxvt3Fkw9SiTSVy1N3hAw96rseE1PQo7x4gyl5+aYNE+Sb+0JpoABZNc0JwAEVnkKcf5mvPGO5S/QAlrcWeRuGYzmRmvoquXrCdDDSiwQNZvi/6EN1GaIg9oCHBmKA8WXDSmLN91OeBZx5ILKngQgxGcySU42LzjblPliraiBAM2KlPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCl8fggQRr+Kt/uDCXCs9wkK37Af0ASLX09n4vtzl4w=;
 b=ehZVk1HAl6siqqATvY6bDt1w1gdKxFNqVW8dyycbtQdyPrz0aAmrzLb51D+mvxYKsRX+2NkrecSmSbLsyaFKhJHlN7WQysMc15G3aCE3gO2Hsn5PoZqXqN+Rs59ElSNdOuPbm4+jmzLVYCaFLqdbhWZ1HROoqCw88iE8B4t5IaRL6oefVrKx4lxXyDoIAQV/fz3IneDvk9xAGWJbXN2hAOrJrI2q5xePmpAYeoFdHKuyHnckis3mpr+SmchgY6CaXYpMZVMzlZWc6e+YR5SmkMfUc0d++XdCZKpjrHtLihPvSOLnWfpiaD532yO9I82CyQN/VIGNX/M7N76bMCOntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCl8fggQRr+Kt/uDCXCs9wkK37Af0ASLX09n4vtzl4w=;
 b=vhtN2FflH/vlBbewa5xlhjF3PIZi48WgEK0sPics0pvAvaaeiMGode6KY7u3gxxkDJF9f4v1UD6duos6gTirvp/QzJNhqRhTQ057gS2jTz5ehcsj7O6Y62dcaBO9ZuChXmHQUc7lo5WnoBanTjvOeAzA0HE8e/pdq1PiyGHNT3k=
Received: from SA9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:20::13)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 01:41:56 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::aa) by SA9PR03CA0008.outlook.office365.com
 (2603:10b6:806:20::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 01:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 01:41:55 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 20:41:55 -0500
Date: Mon, 1 Jun 2026 20:37:00 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 04/12] ramblock: Rename guest_memfd to
 guest_memfd_private
Message-ID: <dmdubeudidatup74yhz7sppk2fgxqtj4dxvg3dxg26fwf4iqbg@xxpbkizbvmh7>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-5-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e34e8a7-89f1-4b08-8e48-08dec0482120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: P20xyWVQ38DkH2cD7KTM8eoS5FEEd6znAMo0B+Qab+sNrRSfWvpafVYXvVsydNL+KfggMC/XtVRcbEdAJAhjSC8d3j3a2e279OPfmtZO1uOYaB0hCl8Xxce+AJPt00Wen9AWqhfkfpswx9GaPkHygFQIFY5mj73l1FmHIQT3A69RrntagIKCD7pgbbAulUH6K/Jx8va0k51t4grb/fbof+lv1R+pQ/oKbpffPTcCFuQR78+6wbGkTGZdjbmGK89Mj/cBhdLt+q/EqnWx+hdF/2MZ5EdPN3hllHcWyjcAlXYYyYOD3FBhswWXekcYFP5dLYBa09bdRUuPGpaUFl7PjzlhjRMvLzTRGfYCcLEBnl7vMqErtQcYJDA6OnzCU/WoFoOMrtfhaOt7KWqcI6sezOfhEYiwTL/ROyAp0jrYTWWtaA9zyFfhepKgBGxi22W8Je2B4BMaRNAg5Clhk82A8DuAo9tvkFIr06LCpUugE7kiTSPzXU3Bpm0jqfRqOLfRnM4Ay4VekVUOPKlWBpYZqxml4vSPT4tEe6qPs7V4CXgodn2cIFma+iwtduVtohHwB+AyB3hB80Uk9ZmXhdTSH1tvkiPgvHL9HIqBSxX6GD5Fa4cD+FZNWCd9lvIUf5FAxS/0Qxut6X/gYjRJVOddNeZApARVx60aUGaF7/lvAe+345ZjB0pdfePjtIZzjIR+rpQugPNXH2WS3b97mEeWVO44yIz9qznr4i9qXAKtUFE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MgH2c00NVm7Q6IkECepb3FICSuTF9C1uK+5fHN5q+j0ow8GLWKzP/e85uVRlbKk8/EAZrK1J8zrXbXqqnKlT1P9lt18RgSuzZ2mAxgGNd8XcrMrcrKvzOYKzSx/AfAJNVUVd4ptc6xPg2ZDt+PbNYmiT8Nc6L2tN/DJXeDp13cvJA0gKeJTRi1UeHz+hh1lZY+aPkrYpfNnZASgdAQePSa1jXBJZwIdHaJYr4hW/13ve8Q4U+8K3uPZnIKllV0iz2F1JOZJqd4ROr2OLvIlVLMSXlAbcDPq81Jm6X2gdGj8lm5c2N2VFSjAhQaQMn6uRwlsjt3vGNuJBRBbFz+5eYPmYNeZMkCGPC9e+jjhFejvynFnMs/71zM3lRxFQhcAAlT7282sVa9NtZwBGKYtsBOCnpRrV4kDKDv0/+Y0s3BoAZyOVAkd4HaOzvdW+8ryO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 01:41:55.8507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e34e8a7-89f1-4b08-8e48-08dec0482120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 03:51:55PM -0500, Peter Xu wrote:
> Rename the field to reflect the fact that the guest_memfd in this case only
> backs private portion of the ramblock rather than all of it.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  include/system/memory.h   |  7 ++++---
>  include/system/ramblock.h |  7 ++++++-
>  accel/kvm/kvm-all.c       |  2 +-
>  system/memory.c           |  2 +-
>  system/physmem.c          | 21 +++++++++++----------
>  5 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 3bd5ffa5e0..2384575065 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1823,10 +1823,11 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
>  bool memory_region_is_protected(MemoryRegion *mr);
>  
>  /**
> - * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
> - *     associated
> + * memory_region_has_guest_memfd: check whether a memory region has
> + *     guest_memfd_private associated
>   *
> - * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
> + * Returns %true if a memory region's ram_block has guest_memfd_private
> + * assigned.
>   *
>   * @mr: the memory region being queried
>   */
> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> index 76694fe1b5..9ecf7f970c 100644
> --- a/include/system/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -40,7 +40,12 @@ struct RAMBlock {
>      Error *cpr_blocker;
>      int fd;
>      uint64_t fd_offset;
> -    int guest_memfd;
> +    /*
> +     * When RAM_GUEST_MEMFD_PRIVATE flag is set, this ramblock can have
> +     * private pages backed by guest_memfd_private specified, while shared
> +     * pages are backed by the ramblock on its own.
> +     */
> +    int guest_memfd_private;
>      RamBlockAttributes *attributes;
>      size_t page_size;
>      /* dirty bitmap used during migration */
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c32fbcf9cc..1126b6f477 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1603,7 +1603,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>          mem->ram_start_offset = ram_start_offset;
>          mem->ram = ram;
>          mem->flags = kvm_mem_flags(mr);
> -        mem->guest_memfd = mr->ram_block->guest_memfd;
> +        mem->guest_memfd = mr->ram_block->guest_memfd_private;
>          mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
>                                    (uint8_t*)ram - mr->ram_block->host : 0;
>  
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae3..355b1fa26b 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1899,7 +1899,7 @@ bool memory_region_is_protected(MemoryRegion *mr)
>  
>  bool memory_region_has_guest_memfd(MemoryRegion *mr)
>  {
> -    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
> +    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
>  }
>  
>  uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
> diff --git a/system/physmem.c b/system/physmem.c
> index 3555d2f6f7..c3c7a81310 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2219,7 +2219,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              goto out_free;
>          }
>  
> -        assert(new_block->guest_memfd < 0);
> +        assert(new_block->guest_memfd_private < 0);
>  
>          ret = ram_block_coordinated_discard_require(true);
>          if (ret < 0) {
> @@ -2229,9 +2229,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              goto out_free;
>          }
>  
> -        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
> -                                                        0, errp);
> -        if (new_block->guest_memfd < 0) {
> +        new_block->guest_memfd_private =
> +            kvm_create_guest_memfd(new_block->max_length, 0, errp);
> +        if (new_block->guest_memfd_private < 0) {
>              qemu_mutex_unlock_ramlist();
>              goto out_free;
>          }
> @@ -2248,7 +2248,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>          new_block->attributes = ram_block_attributes_create(new_block);
>          if (!new_block->attributes) {
>              error_setg(errp, "Failed to create ram block attribute");
> -            close(new_block->guest_memfd);
> +            close(new_block->guest_memfd_private);
>              ram_block_coordinated_discard_require(false);
>              qemu_mutex_unlock_ramlist();
>              goto out_free;
> @@ -2385,7 +2385,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
>      new_block->max_length = max_size;
>      new_block->resized = resized;
>      new_block->flags = ram_flags;
> -    new_block->guest_memfd = -1;
> +    new_block->guest_memfd_private = -1;
>      new_block->host = file_ram_alloc(new_block, max_size, fd,
>                                       file_size < offset + max_size,
>                                       offset, errp);
> @@ -2558,7 +2558,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      new_block->used_length = size;
>      new_block->max_length = max_size;
>      new_block->fd = -1;
> -    new_block->guest_memfd = -1;
> +    new_block->guest_memfd_private = -1;
>      new_block->page_size = qemu_real_host_page_size();
>      new_block->host = host;
>      new_block->flags = ram_flags;
> @@ -2609,9 +2609,9 @@ static void reclaim_ramblock(RAMBlock *block)
>          qemu_anon_ram_free(block->host, block->max_length);
>      }
>  
> -    if (block->guest_memfd >= 0) {
> +    if (block->guest_memfd_private >= 0) {
>          ram_block_attributes_destroy(block->attributes);
> -        close(block->guest_memfd);
> +        close(block->guest_memfd_private);
>          ram_block_coordinated_discard_require(false);
>      }
>  
> @@ -4222,7 +4222,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
>  
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>      /* ignore fd_offset with guest_memfd */
> -    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +    ret = fallocate(rb->guest_memfd_private,
> +                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                      offset, length);
>  
>      if (ret) {
> -- 
> 2.50.1
> 
> 

