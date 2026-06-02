Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1310CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUXCf-0007Vs-Hf; Tue, 02 Jun 2026 18:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXCc-0007VT-RB
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:03:15 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXCa-0006yp-NH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:03:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3QbXnKtME9tlMMw8123b89p7fTBoK9CHN7rlTvdr1SKbswhMVFapBgFt7JadoWV0bakD5z5GsNoDle5O82EaqTg3QKgcUeBgn3Y0vN36M/4fZIXNRacId3hMsKXN5INMwGt/1viNmyP4CLSAQ2wyD7szivazpU654RPvRSN58t6Z/59ILZWaFU+4dDTxfiBd2mDNGYmsHxmrRW3YzhXpZ3nKtcKu5hPyv129LasMGmM8LHdOG3ovQVE5Y4vO0wmFSk331h5jzUna4wAYeCdkDMkrXdZln89rtoBno6FboEY1uw2kSeVuJldwlWQcY6qNWFZ0kf48ppk14rqW8CtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nw6JoYBKK4DBGh6tQkpKreExTHCG4NgM0cm96pzV3+4=;
 b=t958mbYi2LY2hn6Dh+4aSkIKlnOI7oMgeq5PJYUEOW+rd0Lu8XDbqT/6A9wV6IUx57myI+q1rwSmQ749tfpGRKgPp1zWu82b7ff95dxbLyoE66EJOgGqSFI1kkwGxIUJijMEp3EHG3CtedDZ0ZrqLkcI0E11fiNcI9P6OI7OPT0JiEHwWwBXJE7/xEI1SqFjuVdUtQja+SbPHm+V0ZMSMgk1weLENvzA7B/nHVhiaMLSZ4zebev1NbYmGrgTCyaHg8AekPYqpc1L2z5Bs8rwXBD7ADQ/RfpRzwLjGWrakdRtOYDcB6t5uPjzLQsokxg0Mn9SiMx6ZTAoFIG4n5fkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw6JoYBKK4DBGh6tQkpKreExTHCG4NgM0cm96pzV3+4=;
 b=BIdXEfzDHx3fOYNwU3eQYq3419qSZQLJ5HL3Jdxn4t4k1VY/mfcfZq5AtHmv7kN+UQoah18bl1wvhVDhPNF5ty8ptfMV36VtytBm3x/Fx54L+s0YZ2K2qZozpvvrVVEDOKeg6MrzeqaJecuosXx6FwoGJCv7zrR12BkI8DkYOag=
Received: from BY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:1d0::25)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 22:03:03 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::68) by BY5PR04CA0015.outlook.office365.com
 (2603:10b6:a03:1d0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 22:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 22:03:03 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 17:03:03 -0500
Date: Tue, 2 Jun 2026 13:56:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 07/12] hostmem: Rename guest_memfd to
 guest_memfd_private
Message-ID: <ndwoq5egngr6dcqmtxtaancpha6kyd3b4gxtzwaivxuttxhyyy@pcv35majwrt7>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-8-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 609b8a48-21e4-4a6d-e899-08dec0f2b7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: SM4CTfmIIbC9ulCzFrRfIl1eYKQrtFLEdyh7qGslVM8gatBArL/LXv+091ZWpe9H+xj89brZ9Cv6rHLB/MiGxWv4NOMSoiE+w0C7ZoMUAo+NOBwSCgispc9rqXGVdANHnxjSytsi4bHbPC7KJpn3d5iKUgmmcmc3RtD4/cwWz8/eS9/k9B4DMQpHT3vaASycHBVxjvz49dKv5znHPHF5hqlDX0L8ecvOyyM1q4t2cIZ0tNC8owPRVBbCvHtTFoS9mTJk9Tha88HDFAQYk8e9lY0ZuvMDRV6we5hIjL1Gqr58om7lrP2RaikLK/CrrI8ibumxDGQPkiGez6s9i2jvcLm23GPOcVbKhLcWN1VB/5YSXZq3hDpBBeEStk8gWgkgiNMJpmdWBmLjLwD/B33znTBAdEthJwh02f+zH2TQt6v51gpLBO8psGikUciYUBm1qMXFG1Eucc3OG55Iu33MXncQ0/elLYgmuYgHNdPU7xP9qQS4OyLmIcebY5lHVrbw+6GQ/QVUOdws/dkc8qNr6Ho3PnRoA8mGGre0kIr04ZJiVsVx68+TgNsIHBqaqEMjPuIPJGXbnLv702FSbv5nO3ombiGAwScgi2MBx3YQ5H/3MveTxt0yCoocewlsUPRcNi/PxSaD79CSrC3dUrguMpN2PTx/z1LO1oJETJVxfcZBHPQAHTYQl+Voqw4LqW21yWc55OhSZvO67xwZ3vkyrfPGOaglyHUzFzu45yj6E3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VDfMLYhG87k6QJFZMoQGzewH2BO7KIlxj7TXSriv3OByZ5pZxqcXgFe43aK4UDnLmWTnwJCUoUvqGPufb10rSjmt1Cc7xyHczTEHBAtlIieSdgsIVzWjcLTe09YDDFD6qdJAWOCKZku1IqEzLzLvLVKqyNRNs2jUWP2HkNZlxOI0bmbDlIPusvoWroyrxy+ZTJDSV6O2PU57lNcO2xTXoFsI/VR7P+RDfLhTEGsiXkTqzB88MPtaZPfFT88mB9xRCgNcsQ8PE7fRXJr4Kj58cf0WZQtre6t5TPp7Zxn5FXzpffI6DJT7UKV0+G/w2xBHhySJEX9635ggmaAnDYOm3omE/2nukHoVZ9nwWR5rj1c4LnMUDU/0cTpInN7/0nkR/fU3GKSr7hjiTZmzUjF1bAmBjc4Ql+nItlz8TrIQu/uYKwy91gqoPTDEvDehmD/f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 22:03:03.3700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609b8a48-21e4-4a6d-e899-08dec0f2b7ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Dec 15, 2025 at 03:51:58PM -0500, Peter Xu wrote:
> Rename the HostMemoryBackend.guest_memfd field to reflect what it really
> means, on whether it needs guest_memfd to back its private portion of
> mapping.  This will help on clearance when we introduce in-place
> guest_memfd for hostmem.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  include/system/hostmem.h | 2 +-
>  backends/hostmem-file.c  | 2 +-
>  backends/hostmem-memfd.c | 2 +-
>  backends/hostmem-ram.c   | 2 +-
>  backends/hostmem-shm.c   | 2 +-
>  backends/hostmem.c       | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/hostmem.h b/include/system/hostmem.h
> index 88fa791ac7..dcbf81aeae 100644
> --- a/include/system/hostmem.h
> +++ b/include/system/hostmem.h
> @@ -76,7 +76,7 @@ struct HostMemoryBackend {
>      uint64_t size;
>      bool merge, dump, use_canonical_path;
>      bool prealloc, is_mapped, share, reserve;
> -    bool guest_memfd, aligned;
> +    bool guest_memfd_private, aligned;
>      uint32_t prealloc_threads;
>      ThreadContext *prealloc_context;
>      DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 1f20cd8fd6..0e4cfd6dc6 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
>      ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
>      ram_flags |= RAM_NAMED_FILE;
>      return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 3f3e485709..ea93f034e4 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -60,7 +60,7 @@ have_fd:
>      backend->aligned = true;
>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
>                                            backend->size, ram_flags, fd, 0, errp);
>  }
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 96ad29112d..6a507fad77 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      name = host_memory_backend_get_name(backend);
>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
>                                                    name, backend->size,
>                                                    ram_flags, errp);
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index e86fb2e0aa..4766db6aad 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -54,7 +54,7 @@ have_fd:
>      /* Let's do the same as memory-backend-ram,share=on would do. */
>      ram_flags = RAM_SHARED;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> -    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
> +    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>  
>      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
>                                                backend_name, backend->size,
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 35734d6f4d..70450733db 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
>      /* TODO: convert access to globals to compat properties */
>      backend->merge = machine_mem_merge(machine);
>      backend->dump = machine_dump_guest_core(machine);
> -    backend->guest_memfd = machine_require_guest_memfd(machine);
> +    backend->guest_memfd_private = machine_require_guest_memfd(machine);
>      backend->reserve = true;
>      backend->prealloc_threads = machine->smp.cpus;
>  }
> -- 
> 2.50.1
> 
> 

