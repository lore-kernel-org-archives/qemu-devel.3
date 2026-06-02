Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD9DCD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUE9F-0001TG-9e; Mon, 01 Jun 2026 21:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE9D-0001Sq-6m
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:42:27 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE9A-0001fv-Uo
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:42:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiGHd2BvjaSkj6cAFZGeByqKWZDgS0m8xT0hxoLF5W+cfz3iP8iJvNDExp8VhhWinupJcWKBpQe1+tRDN4h4sGN01/AsGWserxO2ZlcZRXfSgEnj+Esf1msLYArS3uhezuB+honAhdT08q1a4ovRvJe+aNoofnNrLUhfYTYuI703ZuXUGKfP41AQqGLT1B5JiQVfRSWpl/MJGi7fSZl0ZRzjwBNu9tNpXqvmgl1SWsaYWcE5DpDs0xOhF6cgMVVGyKmjz8lXgQOTNd8Bh4jhoO7+NSIOO9cFg/wR7t12BG+knZV425YZiN3R44jSIeyGoR4r0iiO4TUMdRd+kmDXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60yKZ2MKkjcuvz4lHxdFtT5fecayyXKIYuKtEu8iQoU=;
 b=U+UxKmkdRAcvspm2l4CIFH4l85yOPqHUHH5YcYuEV0+lDxCDsaYWgk3Ja3M/utudFgPM0wDEAFZV2vbpLvPWF+lLQTI55K5SALBIXnsEKUkTdmgq8CR3KX3cX6OXcD2vYewB2+94bHeg8TEpjhsZLVpDBAT3Ic9gsZK0UIXYqSBKi0pof9ivIfB7GkK+mlFOujqU52kbWDLQmYCXpw6Z9053RzEe2bHLX18Av80hzW90c4CgLgH6aA2sAY96OYYz9cT98iZ5Qm9Tiun42ZksmBmX1A6C/cVKmbxQAghLCAWW3Nq2rZRBGBb4j/ZgLGsT2fE8cMSgoloVEbIIRvryCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60yKZ2MKkjcuvz4lHxdFtT5fecayyXKIYuKtEu8iQoU=;
 b=cIty53aSyxVRNoYYPC9wNR1Pwibuw7SHqicwJiVjqDQx4C6iCDte3LFUYULiH0+jX7+oTc0EMOq3Bscak8XUM7NBr6hil4nkrCXHaMjQwrsNLarTG9heVvaSKkaTCzqogW6Nvl0tUqrJdShnSc1mP9mpstYgQgfZs63is72YZHk=
Received: from PH8PR22CA0016.namprd22.prod.outlook.com (2603:10b6:510:2d1::9)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 01:42:16 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::8c) by PH8PR22CA0016.outlook.office365.com
 (2603:10b6:510:2d1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 01:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 01:42:16 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 20:42:15 -0500
Date: Mon, 1 Jun 2026 20:39:29 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
Message-ID: <xf5jk6i7k7x56g5lhi6luqmg63doqry5ttwmm2zon325vvdwga@iazq3ed427h6>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-6-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: f515c5f3-8b87-492e-f595-08dec0482d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: e0x4l4TEJI4jlfOy5BWc9HspfXKkIEsfGd7Oqlt1T6hgagySl2+VkGb1Yhd0LmPzzkZFtfuM4gcm5795sjKEMF4qM7jMIS66tqNTpdr2PoeOfZipsmUii6CtLSJlivRObjJFgNz0WiPZn30JKHoSA4JfzF+sNqQQ5sI3M5jSx2QFrQz0tKZW1kB6lXe/DqZNHADBXdkhoINR21lRo7ESAdEwgSYh+Zdd9XyMw1YMb8zXfKiMU+OhDM5dSH27j4RXK0STdmZD+GxlS3yozl8jW3uupXwxDGeOiXX8wSFts1Nl+vzER+sZTcmAJm3Q/oIDFnB2pXlNAfc8qxEXtpZJo4MWJNGajCa7SoOtbc+ubyZeXByQZ6VXoL7E8Kz2EbynpfmT3p3BeBW7e+AqqvzKqtqknNtMoXFcQi+TfTig3UnpmtXKCEWuVb7I42IFHMRkvd/t4m2AnAmWVP3dlwK2o1EYZI5zCysFmtk/w0tbDZ3U+vmciHk8F+4z/0l2NXt4LxHLRuc3AViuSM2m+FZ8TlDZORiTCA0Rml63F5TNb8vgf6cR0DBHygwAbcSrVIx++VSOK1uOzpp+esdmTurj475H6QaFosT+s/9lWaHUP/19QKbY9BZZ2aoaq9+qlSPDkkXaqAhRYbSOcpFZfSsZ98zRAG9rS5d8uJ5wMoUYXRK2IDP734HmcR7Z/3RJBX59bO41BPTcUmPjfYEPdz6FpJUIcWxNVpLjoG7jejULiU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Usn8RzenkjJoV5lwSVdXJmo2PkDQCoH64mv2YLaNslnPEp5D0lmTy4kQNIIHCdvIN0xzODmZX1Kho91Ssjr7eWrCwwyyn4X9/En1wI3ihVnGiSnjHIGj7tyccW8NSjmwuUlkhurqUpqh1FzpBM0TH1OxrzHg+p1M865CebJqVPbqeKx/TBKLB+ia/7P2PtyVsISRJ4jk1uy+TBWLS5qu+TD1ey8JynLxyL5DeUOAn4mL/u3JJf/hNZ88ZOvptddASyj5gw4vBg76bBCd1zRaKXiiDCBdn6RcaElvm4rjh+DjAXQTJKc4brXIC0Pb0ZUn0JpItCEyC37kQnJJuHsgx6zcU34Hib2Bq1O174f6LKmBGJ3+K0T3hfdBmHmFMZkH1Ua63E568mCvaZWXoWyGnga+DhciAZD/BMYBgOOQyisBGN/P7CYFyvIuENBo/O1l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 01:42:16.4211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f515c5f3-8b87-492e-f595-08dec0482d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

On Mon, Dec 15, 2025 at 03:51:56PM -0500, Peter Xu wrote:
> This name is too generic, and can conflict with in-place guest-memfd
> support.  Add a _PRIVATE suffix to show what it really means: it is always
> silently using an internal guest-memfd to back a shared host backend,
> rather than used in-place.
> 
> This paves way for in-place guest-memfd, which means we can have a ramblock
> that allocates pages completely from guest-memfd (private or shared).
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  include/system/memory.h   | 8 ++++----
>  include/system/ram_addr.h | 2 +-
>  backends/hostmem-file.c   | 2 +-
>  backends/hostmem-memfd.c  | 2 +-
>  backends/hostmem-ram.c    | 2 +-
>  backends/hostmem-shm.c    | 2 +-
>  system/memory.c           | 3 ++-
>  system/physmem.c          | 8 ++++----
>  8 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 2384575065..1f49f9a0ff 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -263,7 +263,7 @@ typedef struct IOMMUTLBEvent {
>  #define RAM_READONLY_FD (1 << 11)
>  
>  /* RAM can be private that has kvm guest memfd backend */
> -#define RAM_GUEST_MEMFD   (1 << 12)
> +#define RAM_GUEST_MEMFD_PRIVATE   (1 << 12)
>  
>  /*
>   * In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
> @@ -1401,7 +1401,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>   *        must be unique within any device
>   * @size: size of the region.
>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
> - *             RAM_GUEST_MEMFD.
> + *             RAM_GUEST_MEMFD_PRIVATE.
>   * @errp: pointer to Error*, to store an error if it happens.
>   *
>   * Note that this function does not do anything to cause the data in the
> @@ -1463,7 +1463,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>   *         (getpagesize()) will be used.
>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>   *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
> - *             RAM_READONLY_FD, RAM_GUEST_MEMFD
> + *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
>   * @path: the path in which to allocate the RAM.
>   * @offset: offset within the file referenced by path
>   * @errp: pointer to Error*, to store an error if it happens.
> @@ -1493,7 +1493,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
>   * @size: size of the region.
>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>   *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
> - *             RAM_READONLY_FD, RAM_GUEST_MEMFD
> + *             RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
>   * @fd: the fd to mmap.
>   * @offset: offset within the file referenced by fd
>   * @errp: pointer to Error*, to store an error if it happens.
> diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> index 683485980c..930d3824d7 100644
> --- a/include/system/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -92,7 +92,7 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
>   *  @resized: callback after calls to qemu_ram_resize
>   *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>   *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
> - *              RAM_READONLY_FD, RAM_GUEST_MEMFD
> + *              RAM_READONLY_FD, RAM_GUEST_MEMFD_PRIVATE
>   *  @mem_path or @fd: specify the backing file or device
>   *  @offset: Offset into target file
>   *  @grow: extend file if necessary (but an empty file is always extended).
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 8e3219c061..1f20cd8fd6 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
>      ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
>      ram_flags |= RAM_NAMED_FILE;
>      return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 923239f9cf..3f3e485709 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -60,7 +60,7 @@ have_fd:
>      backend->aligned = true;
>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
>                                            backend->size, ram_flags, fd, 0, errp);
>  }
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 062b1abb11..96ad29112d 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      name = host_memory_backend_get_name(backend);
>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
>                                                    name, backend->size,
>                                                    ram_flags, errp);
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index 806e2670e0..e86fb2e0aa 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -54,7 +54,7 @@ have_fd:
>      /* Let's do the same as memory-backend-ram,share=on would do. */
>      ram_flags = RAM_SHARED;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
>  
>      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
>                                                backend_name, backend->size,
> diff --git a/system/memory.c b/system/memory.c
> index 355b1fa26b..e8c6d484e6 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3755,7 +3755,8 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
>      DeviceState *owner_dev;
>  
>      if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
> -                                                RAM_GUEST_MEMFD, errp)) {
> +                                                RAM_GUEST_MEMFD_PRIVATE,
> +                                                errp)) {
>          return false;
>      }
>      /* This will assert if owner is neither NULL nor a DeviceState.
> diff --git a/system/physmem.c b/system/physmem.c
> index c3c7a81310..d30fd690d1 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2203,7 +2203,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>          }
>      }
>  
> -    if (new_block->flags & RAM_GUEST_MEMFD) {
> +    if (new_block->flags & RAM_GUEST_MEMFD_PRIVATE) {
>          int ret;
>  
>          if (!kvm_enabled()) {
> @@ -2341,7 +2341,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
>      /* Just support these ram flags by now. */
>      assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
>                            RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
> -                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
> +                          RAM_READONLY_FD | RAM_GUEST_MEMFD_PRIVATE |
>                            RAM_RESIZEABLE)) == 0);
>      assert(max_size >= size);
>  
> @@ -2498,7 +2498,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>      ram_flags &= ~RAM_PRIVATE;
>  
>      assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
> -                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
> +                          RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE)) == 0);
>      assert(!host ^ (ram_flags & RAM_PREALLOC));
>      assert(max_size >= size);
>  
> @@ -2581,7 +2581,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>  RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
>                           MemoryRegion *mr, Error **errp)
>  {
> -    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
> +    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD_PRIVATE |
>                            RAM_PRIVATE)) == 0);
>      return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
>  }
> -- 
> 2.50.1
> 
> 

