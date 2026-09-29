Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78909CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhgf-0000cZ-Um; Tue, 29 Sep 2026 19:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhge-0000YO-6T
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:40 -0400
Received: from mail-eastus2azon11011056.outbound.protection.outlook.com
 ([52.101.57.56] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhgc-00087x-6i
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:56:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwquXSIuKt3ZfYsZNz2yq5ERlYxF7ZCftWKY1OKALKFUs8kbPGzSnpf9LpyMppUGg4EuUgy0Nqu1UyBzMjH/v2LLTjXXqj7YKaBG+v12x9kZAeOniKFGw3RTRMuOOwVNiCznU3BxmLJMWxNrJMWFbPcyirR/fSKqSB9x9ZWvHWoZ6ZpZ/OS/bRQ90iQVgWjJ3USbha4iYw/7hkkKFAkIdRZ6wVFsxTTK050syPUAGKtsTcdEHXaeuMcl+1Dw/hOKj9omtiHpStKib6Myx/49z1U/mDYpmD4IVbbRA4hvDGY/3OVQre9MX0y2RQ09hPwzjNuRsiiw0RfaG6YGwEugrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alBSg339oD0X0tXU8yrztCP+ucf1ltvMwcUalYmBLII=;
 b=Ju+3gbTgryxlItbhLkwmmT4A1uar0o2z/eGdi8hcX+H8kzv4PitpFX66BTKTFeTKRoAn2TgmH2HS3aAj8ylnydz6LH991QWMvthkqOU5DOBwwt5LN94TyE3d4sDaUSd8ZVCutvgqu9Hp//aLWIA5lsBzXbFYqsNo/2rtC5O5kGHBkwQpXIyHG92e4eSCI7kaMK0jYblAmeeOYo+B9TkL9qjHyn23/T1LKHleVeb3vX9+ZJibkXLjZu/Op1tdoYBIH/NYG0HCS9pBMjFRIai79zhK8cNRMLRMQIx5nR4DoVyqo2GT0Cx8N8F+8GSBYvRM+bQlBZKl2zsN6iA6HttK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alBSg339oD0X0tXU8yrztCP+ucf1ltvMwcUalYmBLII=;
 b=WsitBd4xI3jzfnClZnRc0YGiy8wXjg+ePo9haS6xfS+Nyd54ZDwS8dwSFoxRdgYwKJctqEp/blha7sAbf+UDfDv+RJ5laYv+/RgMeukjAlgSAWOR37y8V9caZMXzrIOVEiW8eNw1UjeLbqAAMlphXH8xvOIpBq2rG9T24/CJu8g=
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 23:51:31 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::66) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 29
 Sep 2026 23:51:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:51:31 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:51:30 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v7 07/12] hostmem: Rename guest_memfd to guest_memfd_private
Date: Tue, 29 Sep 2026 18:50:13 -0500
Message-ID: <20260929235109.1398509-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235109.1398509-1-michael.roth@amd.com>
References: <20260929235109.1398509-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a28baa-c8c5-4084-9f2a-08df1e849641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ovd3U4rdsePG3c1sOkeIJKiNFRgCmN/L1Cm7Z2iaXSqiZXSttgsM0cBzpKZEzg5rlEH2ahv3sYbIYL7lg5JvRUXDzQR1BuRjX3RIj8Z0WzQCC/dYzX/bAj8hUjyNFG+EntTAlq8vUEj6g4NfmWw6H+pTVR3sQ51IESgwvI6o0fJKlfxkNifdFebhW9Wf66trW4pATVQycpDIjRce11pGNBFHG+U2FfxM/TIrsBGDgEo4G50KaUHqS6/5gPk3C1ALKtYOxPHmKz+nj7kVWMgwgc7zRstzAjir6eHGIpi4MMrwKcYQWpewXWcIQwFQeN4vhekDmIxzfCxzKYUFNhVq0RrPpDOGp99USNOB5wH0O9dc738UeXCGs+MeVlgh+slplG7THS5bwJzPYqAy+3DPYVkiL9wYRJUu3eeyxsVQxR5upoTgXYu29uWO2RJbbM34EdJsN4GzByLnsw0bPsSyn1oma1ZzV6xBJxX7oC6rbAFVnSYCAWaVjS7IqnRbAku0/QgcvwZKXjN4uvknyY5fxxCweB14EmytcX+QSHjlIcWBIKimas3HglL1C5UF3yWQatdLEdj4AVaqA0qg5oMW2OfquNTMuQ9BnyDtTVOoRtlsZlaeRmKUYN9EqCTDERj0lnGSJKZO0DRsR8FtEB2OMIDUGdu1viozLf9xOjdGL9gKiGuGhDzCL3GLxyM2YIPLcRa10mYJ9BF1kvP/RXCaEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KbaQj7MXedSiirvDFmxC41bBSFtXHfiYe4wSf66zD9RHcQs+QM/eJisXnLSvFCSTwmtrzSO5SQ5JU+W8Z4qkh9rSi0t0jRd9rdGWY9GA+lzsiFCC7wdU4FZhfVwMYqCSzp+U08TmfwyIwve846i1i3dOKMWh5vbaoqv2q9lzbbTxad+NTLPqCffjFv0Aq1BHMy+2M36hNFQhUxfndg2hRWmPzkIVS8ET5v1upyI7Pll8gljolaXsJFGWgGpmQ6r8wptgf+C8glmwVODay0QTs76cJWpIf8FPYD8BOInLZISKxiCxP+TFQq8tLIqjgFI/Sc2rj2Ol2ykULEGTfwClDixs07yU2iPIxtCZvTTJaAqib4N499eXFf88t9JtGzfkXzuedutrCFFG4LhrzYrsU1oiZryNfk5B/5UACk11vfMjB6Tg5YVxL6Jg5U2BdsuE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:51:31.4016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a28baa-c8c5-4084-9f2a-08df1e849641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787
Received-SPF: permerror client-ip=52.101.57.56;
 envelope-from=Michael.Roth@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: David Hildenbrand <david@kernel.org>
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
index bb7323d2bf..7efecf71f5 100644
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
index d917a94d73..7a7855aaab 100644
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
index 02846b597d..a41540d50d 100644
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


