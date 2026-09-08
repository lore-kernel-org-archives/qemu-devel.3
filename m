Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071C8C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3w09-0006eV-1A; Tue, 08 Sep 2026 09:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3w06-0006a5-FZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:36:38 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vzt-0006md-8y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:36:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECGTwYmIat1MtYutlaVZQHzSYrb9akAbZUqO6meJcOj45YSvJOBkw3CWswABsM3q+AS7YQ3Wb8ImcQbkF7uXhITYid9gmMU7tGeFt/AzzGoIjBA6HP/iJ2zO0Bl2WN4GwLFU3XRv234RBWzu2O0rHCXVJ0wCILBTtFUV+euN6KicQiINu4CaV75AHVMh5igc6mz5sBLtnultpc1QQI94+Nf22Sr8GSWqOu2JdSj3ja0lsldIeJTX3iUgTRBuFOYyKd/iCe3j8WrEUmQyVOoki6mWhPRrGKspRbH5uqBgHlVrZszVBVDlrhha7OILDfLeV2qPiKDXgqFhNOMgOjlxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu87Hx3zUOrMFjP/ynpQZtBZmzleqgnG5yAtLT/HR7k=;
 b=d9jUthJTAWSYbP9Ir+jDRUeF4jr3fpQ5K/O0bva8SoQdSrW7Tf8vH0YUErKvnLzTNkGX7OinGzZueE0vR9xcHxOLvj5Hpeq/Vlj52ak57kY3bmDtYn21WUiyF8ARjwZhafxZwjznz9gCmGrNM9uvWHCUOqZv/BRluF+ITaQ2jLiJyN6ZtM0mAgxk93q9iOpk4yxMjdUqKwvpxE8En8UXLqwJeSWB7s05bRdMeqonfCTmr3escT5nRMKpBTzzZ/ofUKGyOlrdy4hoiFVqQMdPB1FU4KPOwlECtVavdDed2C+8MVQ54OtOQHMuCJ9J+C3h+Ny0TkSKnTkvd7al7VTfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu87Hx3zUOrMFjP/ynpQZtBZmzleqgnG5yAtLT/HR7k=;
 b=pT791DZU3J3SCdlzScFnHkKo3WA2j8qx9jEY4SeNluuJZx7rQdK2Be32zNKcUjVsNz/P40fGfrFhQvwjXUZwszqxrlqM0IaVIdmKtEchhEqa2WrE4qTIcXuvfe7LidzPjqBHkzk1dw3QKNnGAdJlrq+T4IITsP6WHN/G0oJUmVU=
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:36:16 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::43) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:36:15 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:36:14 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>
Subject: [PATCH v5 07/12] hostmem: Rename guest_memfd to guest_memfd_private
Date: Tue, 8 Sep 2026 08:30:57 -0500
Message-ID: <20260908133151.836685-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6797b9-3343-4c43-3e22-08df0dae27cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +uOSs/SzbNnpgwPj72je3UVso7w6AMLsoZD5canhS09cqL+E3ruVzq/NVCjLGvrZfc1MDW16km/QvaymtPratF1VEf7W+sJmi6kcJrBU7tLjkHRrI78exxDrUwIUuj7YWfAAQ88DNt7xKQix9QchVgY2YUhPEfot1sbfUlltrx1fkkioj94FfinjCSKJGuxgRkxlDd39mvnvhj65W+UOG+xc7qLODa6mphwu23hvJUzsKzPjQtEQy2QUZj6loiPowGW5PqMDgzToM983NkRr5w0z3rcSR8njfpcY5mqeQRQLWUNyL148z1ekEI1lCwqbwSGn5EJiKc1AEJ5SWGSDW6lWzMZ6JXhk/VpWvazW4by78W3ZpoIdUYQt9JiRRQ7tzeOvbPHohQYMOKBFKxwBBGzST0XJXklpPkaCqSKMFcskvNSUafdQlMWDFHnK+ZRSnDHzBNfefjqqnLxfNteA3VxN0rbnsT1PpPE980PJvv0NNo7mYehw2Lx2O/u8ih4UKTPAtyPOwIJjfajqBNuOMWDZyTgjrsvH/x1tB6lMJOaNiEA8y3+uDgJzPnz8jX2/5fpeb/nOYDhE8N1U0C8vaoakXkdzThK5uBdypltsJotynhqsxYiiooVe83LDPnvTxnk05Nde3v4A0PgkvXQJHIVIr2oMIMvpenWLOtFfJPBgSPtRUUxuW01eXqxV0HBuYwZ1lP12ghXPmle4n3Sv6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mcOP64npq4fEhRHW4TLqWZYu0yPZBYJY4uBrXvVQqqPc3c0OSDT1o3Zavvd7eKZapP/oBueH6RvoDpYF+7FEtJnyjFrkqMaAlLRspC/W+p7YaGbMKYeh9UEOf+hMbu+/4Lzm+vWiUzjEL0WNPfHq9Mp0seDO2zexlljpy9150TuvVYSOJCz7XoOGnk/opgsIyKF5RxZPwZNMdB236hmWC4E7J01y/sAnrN/a2vTUYoWDo0Hwl+Vs2F2iacuQbOV+XAP6UxfIqUhBjTIM2OqRdLdacxcYerCMLttRj0LeqIs8bJuKQ0kBLB0esmjPYjoZqP8EYJCmXkgfyGl6cwoF+y97jB/22Ic6V5eoSC2n4wdXK609jeMXziz2HGMlw5YAKlv+9v2wZoo6tbmksEk/R1g3ZARoirbkxQoEeSXEJgcss39oKQ4/6/z3Hrl6fgyt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:36:15.2695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6797b9-3343-4c43-3e22-08df0dae27cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Michael.Roth@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Peter Xu <peterx@redhat.com>

Rename the HostMemoryBackend.guest_memfd field to reflect what it really
means: whether it needs guest_memfd to back its private guest memory.
This will help avoid conflicts when we introduce supported for using
guest_memfd for shared guest memory via hostmem.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-file.c  | 2 +-
 backends/hostmem-memfd.c | 2 +-
 backends/hostmem-ram.c   | 2 +-
 backends/hostmem-shm.c   | 2 +-
 backends/hostmem.c       | 2 +-
 include/system/hostmem.h | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 1f20cd8fd6..0e4cfd6dc6 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -86,7 +86,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 3f3e485709..ea93f034e4 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -60,7 +60,7 @@ have_fd:
     backend->aligned = true;
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 96ad29112d..6a507fad77 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -30,7 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
                                                   name, backend->size,
                                                   ram_flags, errp);
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index e86fb2e0aa..4766db6aad 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -54,7 +54,7 @@ have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
-    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD_PRIVATE : 0;
+    ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
 
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                               backend_name, backend->size,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 5dd5fb155c..d54d9091c3 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -290,7 +290,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->guest_memfd = machine_require_guest_memfd(machine);
+    backend->guest_memfd_private = machine_require_guest_memfd(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 88fa791ac7..dcbf81aeae 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -76,7 +76,7 @@ struct HostMemoryBackend {
     uint64_t size;
     bool merge, dump, use_canonical_path;
     bool prealloc, is_mapped, share, reserve;
-    bool guest_memfd, aligned;
+    bool guest_memfd_private, aligned;
     uint32_t prealloc_threads;
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
-- 
2.43.0


