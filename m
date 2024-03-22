Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC69C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 19:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnk7u-0004Lv-36; Fri, 22 Mar 2024 15:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rnk7r-0004IF-RE
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:00:23 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com
 ([40.107.243.41] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rnk7f-0003F3-UP
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyEkDi3m0KKKAfxyhvlNs0mHXJesa8rDdK26eTiDvP8zriKGBbSKqA+MeGiFLjAfoqWjztI8G4ziOFuHJumJsSRWWqweMrcwOxBUIedhgh3yZTBxtjebZ/jl2+aldLKHNkxg0N5jw2ppc3R1LtUit6wHTLT+GirNgh0hTLYZOs6opuSus8sfTpDiqCE7nvDfMphylLI9U0jE7kNrwhdA43dDo6iJDjeuZk0+D4Vepl+9jYgHe+gkVTvQ3pPZOKScoX9C1+eNh2m2oS0NHKTBpv10nDxcptkjBLoSQRMxHpE2r1+Ow2+1swJdIH+msf9VJDJs92WeXWoiWtbxMsa97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRsxw2tr/2B85LefQpqos3x1aZUmyjyzc0j0VvKcM9w=;
 b=ZoKEKZrUobU4fmQSt/5WH1/oBu1rQCL3Y+/4LpLEELEAxVzuhzXTnso5KzebZpHCjBA+AXaTZiG/xGidaSDNYRRxtaDsWCpG202KFbIdWBicO91lcvACHV3IpU5l9YNQD9NY3oUjPCOJvxqBDAoSPEG14X+dQodxFP+OvGgZFd5K8/agDo7T4ZM+kBZgfrHx8+V+BG3qOmV9p9JkFF/pdYW0CaylvnZESndpZL0wJuYo+YTiBvJWGOW1/v4y7p1lTa0H0q9Vm4QTQNDHFBkBpuJrMI2Fnlf9v5TzlzT+WT6ikbu+sIhkkYjXZ3uYHreWNjKVkzycNAPKYGfL1idFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRsxw2tr/2B85LefQpqos3x1aZUmyjyzc0j0VvKcM9w=;
 b=GpVlr4XgUhPaf/cKXPiWoTaW18uYzISebMVgB7g/ItRmPYgSktDRybRnLNIVynGQWDx862c13XpK9r3UL584p4Va+N+//pdbJ+KX2bg2ZICbyA2URlfsXpyGegEVN4UGiuJY/GafR5E3jNTlT2H382wvvUpWUuwTI2b9evpgYQ4=
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 18:55:04 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::cc) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Fri, 22 Mar 2024 18:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 18:55:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 13:55:03 -0500
Date: Fri, 22 Mar 2024 13:53:03 -0500
From: Michael Roth <michael.roth@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <xiaoyao.li@intel.com>, <david@redhat.com>
Subject: Re: [PATCH 19/26] RAMBlock: Add support of KVM private guest memfd
Message-ID: <20240322185303.mouevwg2h4g3anth@amd.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-20-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240322181116.1228416-20-pbonzini@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e956ab1-88f2-44d7-07c1-08dc4aa195cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqkeONxPEY/0xTpCiB+//YYbQk7xfgvVM23N8vD95/xzeg5rL0xsvDVJXkEHRjeuWkBMyt8EoyxJkA6gjh0yHneSz//qJAY+asmDHQge8jTyYr/KErfSDQSb4zVJv+uoWwS/vjNu1bVq9xg5m9HRdScEyCDP//PHv+EROQwWFU+Cv2q1VkYZdTMoCI8yM8TNVc81VO2q6XxogQ+Nixb6uUihYfLerC1pldiSqkZrd4L9ckK/GHODpP6MBUT7dciNEZV1MOUQCh3s68Mef5girx8gNefVj161SQ75labHrxTrAeQqdvWmqRHKT1/FK3YX6Pde/dLMctcdoxGypK+dbvNStNcoePgHW736YS/thH8+A/lObgqmYgTioYyzoI5Og+7SqnAHYBhErPCqTntwCU0OZpj0VLG6FZ9PshCsp59zYhp7vmjSCpea/cNX9GtWkGbEExLxOWHePa6R6qpNtAErnpYbChJTRm7NHXRLlESL+mTeHtjxj/ValhbAZU6N8vu/cL4/zy2D1LxG3ENAVhVffmKP8+Nbs2wGu9i6Ff0SfxpdWyIL+UiuE3Rg9z2rWVeDKBcx9kDm4CAzOPkLqj9XqrhcLMRqWL1O3L4IGRGk1aZj7c/K9MnQNxtjpoUQauW7wCroE5ikyaBkei1ztjJ5l+ZczHG/vjm0phg6eKBrg1EXQIkN0jxtkthNLguItEqLxLXpxvyMYTnghcwQDFC67YpZpe5fZZ3p0Rse0MAHb14ay4gC0KGJ8kUF+WT2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 18:55:04.0206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e956ab1-88f2-44d7-07c1-08dc4aa195cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
Received-SPF: permerror client-ip=40.107.243.41;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 22, 2024 at 07:11:09PM +0100, Paolo Bonzini wrote:
> From: Michael Roth <michael.roth@amd.com>

This should be:

  From: Xiaoyao Li <xiaoyao.li@intel.com>

Looks like the author got reset in my tree for some reason and I failed to
notice it before posting. Sorry for the mix-up.

-Mike

> 
> Add KVM guest_memfd support to RAMBlock so both normal hva based memory
> and kvm guest memfd based private memory can be associated in one RAMBlock.
> 
> Introduce new flag RAM_GUEST_MEMFD. When it's set, it calls KVM ioctl to
> create private guest_memfd during RAMBlock setup.
> 
> Allocating a new RAM_GUEST_MEMFD flag to instruct the setup of guest memfd
> is more flexible and extensible than simply relying on the VM type because
> in the future we may have the case that not all the memory of a VM need
> guest memfd. As a benefit, it also avoid getting MachineState in memory
> subsystem.
> 
> Note, RAM_GUEST_MEMFD is supposed to be set for memory backends of
> confidential guests, such as TDX VM. How and when to set it for memory
> backends will be implemented in the following patches.
> 
> Introduce memory_region_has_guest_memfd() to query if the MemoryRegion has
> KVM guest_memfd allocated.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Message-ID: <20240320083945.991426-7-michael.roth@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/exec/memory.h   | 20 +++++++++++++++++---
>  include/exec/ram_addr.h |  2 +-
>  include/exec/ramblock.h |  1 +
>  include/sysemu/kvm.h    |  3 ++-
>  accel/kvm/kvm-all.c     | 28 ++++++++++++++++++++++++++++
>  accel/stubs/kvm-stub.c  |  5 +++++
>  system/memory.c         |  5 +++++
>  system/physmem.c        | 34 +++++++++++++++++++++++++++++++---
>  8 files changed, 90 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 8626a355b31..679a8476852 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -243,6 +243,9 @@ typedef struct IOMMUTLBEvent {
>  /* RAM FD is opened read-only */
>  #define RAM_READONLY_FD (1 << 11)
>  
> +/* RAM can be private that has kvm guest memfd backend */
> +#define RAM_GUEST_MEMFD   (1 << 12)
> +
>  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         IOMMUNotifierFlag flags,
>                                         hwaddr start, hwaddr end,
> @@ -1307,7 +1310,8 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: size of the region.
> - * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE.
> + * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
> + *             RAM_GUEST_MEMFD.
>   * @errp: pointer to Error*, to store an error if it happens.
>   *
>   * Note that this function does not do anything to cause the data in the
> @@ -1369,7 +1373,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>   *         (getpagesize()) will be used.
>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>   *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
> - *             RAM_READONLY_FD
> + *             RAM_READONLY_FD, RAM_GUEST_MEMFD
>   * @path: the path in which to allocate the RAM.
>   * @offset: offset within the file referenced by path
>   * @errp: pointer to Error*, to store an error if it happens.
> @@ -1399,7 +1403,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
>   * @size: size of the region.
>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>   *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
> - *             RAM_READONLY_FD
> + *             RAM_READONLY_FD, RAM_GUEST_MEMFD
>   * @fd: the fd to mmap.
>   * @offset: offset within the file referenced by fd
>   * @errp: pointer to Error*, to store an error if it happens.
> @@ -1722,6 +1726,16 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
>   */
>  bool memory_region_is_protected(MemoryRegion *mr);
>  
> +/**
> + * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
> + *     associated
> + *
> + * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
> + *
> + * @mr: the memory region being queried
> + */
> +bool memory_region_has_guest_memfd(MemoryRegion *mr);
> +
>  /**
>   * memory_region_get_iommu: check whether a memory region is an iommu
>   *
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index de45ba7bc96..07c8f863750 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -110,7 +110,7 @@ long qemu_maxrampagesize(void);
>   *  @mr: the memory region where the ram block is
>   *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>   *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
> - *              RAM_READONLY_FD
> + *              RAM_READONLY_FD, RAM_GUEST_MEMFD
>   *  @mem_path or @fd: specify the backing file or device
>   *  @offset: Offset into target file
>   *  @errp: pointer to Error*, to store an error if it happens
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 848915ea5bf..459c8917de2 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -41,6 +41,7 @@ struct RAMBlock {
>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
>      int fd;
>      uint64_t fd_offset;
> +    int guest_memfd;
>      size_t page_size;
>      /* dirty bitmap used during migration */
>      unsigned long *bmap;
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index bda309d5ffa..2cb31925091 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -537,7 +537,8 @@ void kvm_mark_guest_state_protected(void);
>   */
>  bool kvm_hwpoisoned_mem(void);
>  
> +int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
> +
>  int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
>  int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
> -
>  #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 36e39fd6514..6aa0608805b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -92,6 +92,7 @@ static bool kvm_has_guest_debug;
>  static int kvm_sstep_flags;
>  static bool kvm_immediate_exit;
>  static uint64_t kvm_supported_memory_attributes;
> +static bool kvm_guest_memfd_supported;
>  static hwaddr kvm_max_slot_size = ~0;
>  
>  static const KVMCapabilityInfo kvm_required_capabilites[] = {
> @@ -2413,6 +2414,11 @@ static int kvm_init(MachineState *ms)
>      }
>  
>      kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> +    kvm_guest_memfd_supported =
> +        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> +        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> +        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
>      kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
>      s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
>  
> @@ -4131,3 +4137,25 @@ void kvm_mark_guest_state_protected(void)
>  {
>      kvm_state->guest_state_protected = true;
>  }
> +
> +int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> +{
> +    int fd;
> +    struct kvm_create_guest_memfd guest_memfd = {
> +        .size = size,
> +        .flags = flags,
> +    };
> +
> +    if (!kvm_guest_memfd_supported) {
> +        error_setg(errp, "KVM doesn't support guest memfd\n");
> +        return -1;
> +    }
> +
> +    fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
> +    if (fd < 0) {
> +        error_setg_errno(errp, errno, "Error creating kvm guest memfd");
> +        return -1;
> +    }
> +
> +    return fd;
> +}
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index ca381728840..8e0eb22e61c 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -129,3 +129,8 @@ bool kvm_hwpoisoned_mem(void)
>  {
>      return false;
>  }
> +
> +int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> +{
> +    return -ENOSYS;
> +}
> diff --git a/system/memory.c b/system/memory.c
> index a229a79988f..c756950c0c0 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1850,6 +1850,11 @@ bool memory_region_is_protected(MemoryRegion *mr)
>      return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
>  }
>  
> +bool memory_region_has_guest_memfd(MemoryRegion *mr)
> +{
> +    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
> +}
> +
>  uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>  {
>      uint8_t mask = mr->dirty_log_mask;
> diff --git a/system/physmem.c b/system/physmem.c
> index a4fe3d2bf89..f5dfa20e57e 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1808,6 +1808,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>      const bool shared = qemu_ram_is_shared(new_block);
>      RAMBlock *block;
>      RAMBlock *last_block = NULL;
> +    bool free_on_error = false;
>      ram_addr_t old_ram_size, new_ram_size;
>      Error *err = NULL;
>  
> @@ -1837,6 +1838,19 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                  return;
>              }
>              memory_try_enable_merging(new_block->host, new_block->max_length);
> +            free_on_error = true;
> +        }
> +    }
> +
> +    if (new_block->flags & RAM_GUEST_MEMFD) {
> +        assert(kvm_enabled());
> +        assert(new_block->guest_memfd < 0);
> +
> +        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
> +                                                        0, errp);
> +        if (new_block->guest_memfd < 0) {
> +            qemu_mutex_unlock_ramlist();
> +            goto out_free;
>          }
>      }
>  
> @@ -1888,6 +1902,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>          ram_block_notify_add(new_block->host, new_block->used_length,
>                               new_block->max_length);
>      }
> +    return;
> +
> +out_free:
> +    if (free_on_error) {
> +        qemu_anon_ram_free(new_block->host, new_block->max_length);
> +        new_block->host = NULL;
> +    }
>  }
>  
>  #ifdef CONFIG_POSIX
> @@ -1902,7 +1923,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      /* Just support these ram flags by now. */
>      assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
>                            RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
> -                          RAM_READONLY_FD)) == 0);
> +                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
>  
>      if (xen_enabled()) {
>          error_setg(errp, "-mem-path not supported with Xen");
> @@ -1939,6 +1960,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block->used_length = size;
>      new_block->max_length = size;
>      new_block->flags = ram_flags;
> +    new_block->guest_memfd = -1;
>      new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>                                       errp);
>      if (!new_block->host) {
> @@ -2018,7 +2040,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      int align;
>  
>      assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
> -                          RAM_NORESERVE)) == 0);
> +                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
>      assert(!host ^ (ram_flags & RAM_PREALLOC));
>  
>      align = qemu_real_host_page_size();
> @@ -2033,6 +2055,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      new_block->max_length = max_size;
>      assert(max_size >= size);
>      new_block->fd = -1;
> +    new_block->guest_memfd = -1;
>      new_block->page_size = qemu_real_host_page_size();
>      new_block->host = host;
>      new_block->flags = ram_flags;
> @@ -2055,7 +2078,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>  RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
>                           MemoryRegion *mr, Error **errp)
>  {
> -    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE)) == 0);
> +    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
>      return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
>  }
>  
> @@ -2083,6 +2106,11 @@ static void reclaim_ramblock(RAMBlock *block)
>      } else {
>          qemu_anon_ram_free(block->host, block->max_length);
>      }
> +
> +    if (block->guest_memfd >= 0) {
> +        close(block->guest_memfd);
> +    }
> +
>      g_free(block);
>  }
>  
> -- 
> 2.44.0
> 

