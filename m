Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C47E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 17:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIszb-0004oD-GT; Wed, 04 Dec 2024 12:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tIszW-0004nZ-Sm
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 12:16:46 -0500
Received: from mail-dm6nam04on2077.outbound.protection.outlook.com
 ([40.107.102.77] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tIszT-0001Af-7a
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 12:16:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSSTI8pR3Z/HaHvmm7t0wqSBvElIhuIZEdbeDgenybAMci1ZtbonNaDZnHM1SkLT8GTiwudeHdCloeEzYRkFGwVjVYldhCEFw21HQZfxgLkHp9DRXxaAoXFA7L2eTPV68xGV7oYQuFTJK6bnUG6+S+RfG4P5/ZtCuf8LNBhRbkhu2cJ2BzV5/1p2EdwrOFYarfIPUDaRu7FtfTBCornLXkPd0T9C56oMpho92/6i9vTid6KZZGg9ZF+HW3FJZsgG/+adSlxwsRxpASu7bojgRK4E74hHs7fTPPWXgHpikaJCmtVe+l4c5gOtEkyiUr6zFpDFtA6cgXQj+gJRSUsS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAY1xUG30EjiQIbycn3JIikJhjk0I+U9WDzHzIMNJR8=;
 b=Ct1DVM6yrgp9oUnpU4g29mo8eH8/+pGsTK7Da4rdR50x4AOQn2ZYQ8IzJtBrJCPvHt4h98VNvzswpLINNvFU1gTrrGfhRkmq1ORyc5Oh0mH58PyNYaZpwL0GoF6Lw3JGrGwVncw+2JwMDHsIqNfGUJnT5B4ALNjsgbMJVgOF96uMOw4E/1o9PKPes6bb76alFIOj4lY3gwyUaLr6GOWRfpfW9J824GMf6U55sUQkE1N4UfljmRTln6gNjA+G2ApLokN5qhhYzEb9Y0NVTldRn4RP6Z1SeoiG/bV7LJwq22ZlQpdzQvemn1boJEGHocMcTYt2A1Dy9XpQJ48WdNxvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAY1xUG30EjiQIbycn3JIikJhjk0I+U9WDzHzIMNJR8=;
 b=sF8qHGIeWOnMatsNGg1Z12yhMHAp221NnQqboVoojIVrSz0ZYN+4qlUWYBbOqYYRpfScLDzEQvOKiHbYcXJ6OIaT04Zpdt8YO758D7dSGnUwnS1hsKFngEkJMAya9S/21seOCW/mE14K4d7pGTGfchKjPFCchFyJh4jwyIeCHeA=
Received: from PH7PR17CA0045.namprd17.prod.outlook.com (2603:10b6:510:323::10)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 17:11:31 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::a9) by PH7PR17CA0045.outlook.office365.com
 (2603:10b6:510:323::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 17:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 17:11:30 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 11:11:29 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kraxel@redhat.com>, <zhigang.luo@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH] hostmem-file: add the 'hmem' option
Date: Wed, 4 Dec 2024 12:11:14 -0500
Message-ID: <20241204171114.20033-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 94666cc8-6ee1-47d6-14f7-08dd1486b274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FFxX719HJ0q+BvoCKicBA0BnRtd1bEbnJzJ+ZrcL7GInhruQtTE/7iSKnMBr?=
 =?us-ascii?Q?HoV5bMD3gPlx6EczmRTKnCAwZHWUP+MPZ1Eo3fY9xy9rE3S7juASu0kR5MDP?=
 =?us-ascii?Q?vF0bGCZCW77dE23v+tVmrkwFJvaqOVF+83kEyKC7AzfCvRrbJQLEWbwaDpJ6?=
 =?us-ascii?Q?aCyQuuxfe3H4cshN7cvY0nXprG0EG6oy5rj+iCTZQNbM1F+jGJ/4qwz6GecM?=
 =?us-ascii?Q?QQYcsKTbu0I28mIg9FgZgogYwOzJlkqATUhsdD/6VLazNIjOmSUf9Fz8yQLT?=
 =?us-ascii?Q?XzOgq99b5h1woFevxxz8JlhdbV5laPGXulAlFEIJOoDmRjZ+v8XbN2EWKROf?=
 =?us-ascii?Q?kpXLcHGLFDdg2G6SLvI3WaIeNuqsgKfm+uJK3pGoU12Ea292TG79E1UU8A0q?=
 =?us-ascii?Q?kIbP9mPU5WoRiYdMAlIjNh0HBJV8R2xnm3mAPx+9Ff0OFa8QBGRZjIZOPYrw?=
 =?us-ascii?Q?sXxi+OPJcpOiYCDb9eWtyN2H6bZgCW8yT1aru2mXw6w7h+xebI6HIqAUlKAl?=
 =?us-ascii?Q?yCBfBBxRtLDmdNjQVO4RdAUTdb/UtNFqH76o54R1OVIlhmQsw3pVXbq2X6Q7?=
 =?us-ascii?Q?7lyoZltV9hdxeuvj5ZtR+ywkWVanXWn+IC5xMDNuEit2uSiDbZpl3xctSqJa?=
 =?us-ascii?Q?+zcl7niIY6wlCoPOgU9TtRFyCpz8Pxr8Mmtt8gz2Y+6FNfz1gk8yXZB81HVT?=
 =?us-ascii?Q?ohrLVHbqNR4SIMUi/GACUbMwh9zzCgzKUyIslWKbfT0ddbmmhP69VWe8aLYg?=
 =?us-ascii?Q?K9kEFQ/zKUaLeeUpT5E+1YAqb7py1pgMPRJiucv5a9PkHN58SmgVos0p1PS4?=
 =?us-ascii?Q?MvQnNse4pRD9LAQ8drfqT3/x0vNO/Iso0eT9Whrsle4O3lXZMmXb8lGy4eNw?=
 =?us-ascii?Q?GARhSy+k3+9JyKmwSO/Z2KhD5VoXsS3rQutAJQ2Qw7O8BrTtMWhhE67k+ybE?=
 =?us-ascii?Q?vrpqQZpWEtsARu+dOfwwYc7kBik1zQaB/tGtIIJmnPygZD8DNoB8M+2Lt6qy?=
 =?us-ascii?Q?PWXuRjBGD1dgbErH5BUzlIRv38qFKHE29KKsUSqyzKokuTqkKAAw0kvwoizL?=
 =?us-ascii?Q?gRNw3MXbAc8bDX10a9+6XD8sTwSGmXxRRzjEbM3tv4bqTruXUEtV1k7ld87G?=
 =?us-ascii?Q?xqd0ouvV8Mi5OSB0uVRH8mIMs6BDPDjuznrLxDfaxurHLgIIHk+p2UBQfcJ6?=
 =?us-ascii?Q?ZJxmQvPHiT9aQMCtvVH1l/nAfc+TAPI5qlVPABZHkeyLq4tJ+a6eq/M6keVX?=
 =?us-ascii?Q?8a2BmTqyX08ZZ4oGYbPoi95IeXriUft2tbFFD5QN4ExtGZvJKu3iQN4KSsx0?=
 =?us-ascii?Q?G3cy9nZRts8Sqa0iyuFU8UfUBWfyRx1cNI4mebrneH0WcfcWu4hpuU8G1sMs?=
 =?us-ascii?Q?mBNbGgsk/o+IgrDqRDtMkWIQzeHQvkicl13Kg4P3zc+S7qH/AxZnifBiDwwn?=
 =?us-ascii?Q?BNp0mWVNkEx9/pRZaBuYyCUOtVosSLps?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:11:30.7822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94666cc8-6ee1-47d6-14f7-08dd1486b274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
Received-SPF: permerror client-ip=40.107.102.77;
 envelope-from=Zhigang.Luo@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This boolean option 'hmem' allows users to set a memory region from
memory-backend-file as heterogeneous memory. If 'hmem=on', QEMU will
set the flag RAM_HMEM in the RAM block of the corresponding memory
region and set the e820 type to E820_SOFT_RESERVED for this region.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 backends/hostmem-file.c      | 23 +++++++++++++++++++++++
 hw/i386/e820_memory_layout.h |  1 +
 hw/i386/pc.c                 | 16 ++++++++++++++++
 include/exec/cpu-common.h    |  1 +
 include/exec/memory.h        |  3 +++
 qapi/qom.json                |  4 ++++
 system/physmem.c             |  7 ++++++-
 7 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 7e5072e33e..5ddfdbaf86 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -32,6 +32,7 @@ struct HostMemoryBackendFile {
     uint64_t offset;
     bool discard_data;
     bool is_pmem;
+    bool is_hmem;
     bool readonly;
     OnOffAuto rom;
 };
@@ -88,6 +89,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
+    ram_flags |= fb->is_hmem ? RAM_HMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
                                             backend->size, fb->align, ram_flags,
@@ -256,6 +258,25 @@ static void file_memory_backend_set_rom(Object *obj, Visitor *v,
     visit_type_OnOffAuto(v, name, &fb->rom, errp);
 }
 
+static bool file_memory_backend_get_hmem(Object *o, Error **errp)
+{
+    return MEMORY_BACKEND_FILE(o)->is_hmem;
+}
+
+static void file_memory_backend_set_hmem(Object *o, bool value, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property 'hmem' of %s.",
+                   object_get_typename(o));
+        return;
+    }
+
+    fb->is_hmem = value;
+}
+
 static void file_backend_unparent(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
@@ -295,6 +316,8 @@ file_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "pmem",
         file_memory_backend_get_pmem, file_memory_backend_set_pmem);
 #endif
+    object_class_property_add_bool(oc, "hmem",
+        file_memory_backend_get_hmem, file_memory_backend_set_hmem);
     object_class_property_add_bool(oc, "readonly",
         file_memory_backend_get_readonly,
         file_memory_backend_set_readonly);
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..8af6a9cfac 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -15,6 +15,7 @@
 #define E820_ACPI       3
 #define E820_NVS        4
 #define E820_UNUSABLE   5
+#define E820_SOFT_RESERVED  0xEFFFFFFF
 
 struct e820_entry {
     uint64_t address;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 317aaca25a..41e9cc276c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -785,6 +785,21 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
     return pc_above_4g_end(pcms) - 1;
 }
 
+static int pc_update_hmem_memory(RAMBlock *rb, void *opaque)
+{
+    X86MachineState *x86ms = opaque;
+    ram_addr_t offset;
+    ram_addr_t length;
+
+    if (qemu_ram_is_hmem(rb)) {
+        offset = qemu_ram_get_offset(rb) + (0x100000000ULL - x86ms->below_4g_mem_size);
+        length = qemu_ram_get_used_length(rb);
+        e820_add_entry(offset, length, E820_SOFT_RESERVED);
+    }
+
+    return 0;
+}
+
 /*
  * AMD systems with an IOMMU have an additional hole close to the
  * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
@@ -895,6 +910,7 @@ void pc_memory_init(PCMachineState *pcms,
         e820_add_entry(x86ms->above_4g_mem_start, x86ms->above_4g_mem_size,
                        E820_RAM);
     }
+    qemu_ram_foreach_block(pc_update_hmem_memory, x86ms);
 
     if (pcms->sgx_epc.size != 0) {
         e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, E820_RESERVED);
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5..1b2dfb31e8 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -98,6 +98,7 @@ ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
 ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
+bool qemu_ram_is_hmem(RAMBlock *rb);
 bool qemu_ram_is_noreserve(RAMBlock *rb);
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
 void qemu_ram_set_uf_zeroable(RAMBlock *rb);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d..18c593a00b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -246,6 +246,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM can be private that has kvm guest memfd backend */
 #define RAM_GUEST_MEMFD   (1 << 12)
 
+/* RAM is a heterogeneous kind memory */
+#define RAM_HMEM (1 << 13)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24cd8d..7b8632697f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -669,6 +669,9 @@
 #     in host persistent memory that can be accessed using the SNIA
 #     NVM programming model (e.g. Intel NVDIMM).
 #
+# @hmem: specifies whether the backing file specified by @mem-path is
+#     in host heterogeneous memory.
+#
 # @readonly: if true, the backing file is opened read-only; if false,
 #     it is opened read-write.  (default: false)
 #
@@ -696,6 +699,7 @@
             '*discard-data': 'bool',
             'mem-path': 'str',
             '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
+            '*hmem': 'bool',
             '*readonly': 'bool',
             '*rom': 'OnOffAuto' } }
 
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..f703398359 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1584,6 +1584,11 @@ bool qemu_ram_is_noreserve(RAMBlock *rb)
     return rb->flags & RAM_NORESERVE;
 }
 
+bool qemu_ram_is_hmem(RAMBlock *rb)
+{
+    return rb->flags & RAM_HMEM;
+}
+
 /* Note: Only set at the start of postcopy */
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb)
 {
@@ -1951,7 +1956,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     int64_t file_size, file_align;
 
     /* Just support these ram flags by now. */
-    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
+    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_HMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
                           RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
 
-- 
2.25.1


