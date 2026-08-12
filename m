Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0230C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFWC-0004EW-PF; Wed, 12 Aug 2026 16:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFVv-0003xK-Nw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:25:29 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFVt-0007kb-Nk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYbkZhGqeweRSckr1CqxyRcXZsa9Bpg610mmhLaCWgw01IBFyLCm01FKEl+VVHX4KM0lVBf18Vmurz/4fuZisc+hwfkWL0FxKTkE4ydI4xpQDzEE0keW3uFu19ORn6k+MBAvMnpmkSNIiF5MflGcqpnIVkjUOiR7fBLEfysdgD7ePAiJpVgSCEwDB/QpiR91khJrAUx4erfSwfkmCVUztgkQF7Zu8JLDYWiG8gSQUbTheLHpfrAhyu91+uP7HO4jm8zr5coor0VnsjiX74LQebFmsAXDtLnUcX6SJDNiZV+vOiwidY3ZA4DZKfk8JWqhkG3AOZQ5PznZqGsbUOgAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu87Hx3zUOrMFjP/ynpQZtBZmzleqgnG5yAtLT/HR7k=;
 b=eI+IIqirhyA49Mw3ki68Iw+Ftu7WYp9w+IIrsc7cCdlWgYxNNjIYF0j5m9i+aEqg2rHA3nRDPaFmAHd6qW97HekJaHzvyq5IVFYF2UQDLSKcaDnlumwsmIsHxOlvaBLSoXEzZWH5bPB3Wmt4+V2BnTyNHX/ngDIn6XfHXiRLxx+gbfzgT3HdBp4vOKoKa3sFrHWKFuSQyfyaYXTnKNNc86zjAcnIYZnU07Ciu5tEku/pMIbAlRdvwEBPmTgkOQQuP9UL++ZXNqMkOe7qYIBI/WHL5SLevAEcgcxuDM9kprxwLMTnN30QVHxKIbvYFHvHNR0MEoyW0b+7xLy4AReAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu87Hx3zUOrMFjP/ynpQZtBZmzleqgnG5yAtLT/HR7k=;
 b=iQ+7TGhv3o2G5VpX60CoLPC21In7s/7DJ5Rj6mf7yGViul8YbHzIspgGieylvi9w61G7gKaF8sLO/CWQgtfNeJY+pkr8SZCv57ukxsQ0ulkyQLqzm4CdXQ6v/5vayGxOmF0S5rdPKLeYTjydh2mzEgifzWHMhqdEsNrf2BjheC8=
Received: from DS7P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::14) by
 DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Wed, 12 Aug 2026 20:25:14 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:25b:cafe::28) by DS7P221CA0005.outlook.office365.com
 (2603:10b6:8:25b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:25:14 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:25:13 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 07/12] hostmem: Rename guest_memfd to guest_memfd_private
Date: Wed, 12 Aug 2026 15:16:45 -0500
Message-ID: <20260812201938.198915-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: ea663b18-6ac7-4a49-837c-08def8afd0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IqEF6y/xvtBu8N+NzxvyeNCpFgBRwKAHM7qyrrQxk5Eo9BgnWi0xaNoOILrGwPJVtz8TheqOmlackYXlJ1+n/JwiY0KTpX6u4OaTLXY8WRhr3LL9l2pqtVb7louPzh5bggUdJzi0EDKc6aNU2n4Iu89kxUx70NCsHqMox9/NXIK0X6Y6lbgIAapKLstOEluw2zYOv44uxLheVxeRz/WlIcWduh6qjUHN0PF3XcmAcrqwwj00/8QBcHS6GT0+4snqgD38b5yKppKdKBNXO34Y/ENBwz1ryFiRwyUj64jK49cLGbFGY49JsoSHgfNuEVwjSv8QfrGvdHi1jyS9jcmjk0aDfL51Uni0Oqame5tfuHxcV5TW9ierqmhvUqoowR3IBO0m86kKla+HEASVllYS/qRzKPCqreqWvsXTnLQr+RZYtazi9GzME4H0g3lw7a+uyZfacinxZd53Pcyg+rsU8H7zxMcRTRffwXHg5itnCRnu0ROjwNylsi9SiCNr2HQbOMs476ea1M4/sg65+4ozKh+tlKi9o1d4ZiV0De9Yh18gTBB5sMiIcNzTybOX+Yh704nC991MdAA8bgzzBa1RXQeh+yJM9mS9wz+wHN9xnjTqmhZGkUF0zu/cbZJvxxvmMv9gAgS7LAk8K3aP+Z1jAZ5s3Bnwa2wupgThPWEz+VnEbQnvgA0LwrzLEHnXDJ7gClQFdUfjTuy5FT0Tki17hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IxmTnwGTG8/F3JHD77QfFDe66PCjr+wChSTeBqVfcGm3PtLZCPdwNRaMGBeSKrA8K0EjxSpGqMrHk0VhNH5t6+lNCq6n+JcJFOdvz/9jeKPJ/8YnME8zt/3pciPSLUf0tOzOKfEC8d90nVoLie3lyCbSmafrE13/yTzqM86fpBr2rfFJ5N/eF77JOZZTTd7b/mB71GWq1e6slV4orvLlbTI7fFDmeQM3A8G73dI9Xg1F4DatchTW1EoH+s/7mGcrGl+643Hb7k8ehoNJmMlSsu6IH5UoRn3QVXW4+oIBp+m4RKmcXSNC4T36RvRFWR0QaznV6Tmgla1YtTB/58KML4mTsttdVbXVw6uUdNtYftunAhBmaxFe7RtIWw5p/4bLb5reyaqogA1kqOhLsOts+q19+C1bgBFfPO2wJ0r2wWv7kqRFFlRLNjwxOUZxClFp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:25:14.0836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea663b18-6ac7-4a49-837c-08def8afd0ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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


