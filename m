Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD05F506C1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w279J-00081U-NV; Mon, 16 Mar 2026 08:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w21RQ-0008Ca-8V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 02:28:40 -0400
Received: from mail-northcentralusazon11010025.outbound.protection.outlook.com
 ([52.101.193.25] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w21RN-0002fN-U0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 02:28:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fleRVoM2FiLrCOjdfUtj69IFDuXudLlETxn6HrbyBhs7JxDPNyZFaBYyOqgtWzK8O8TwfqyP7NUzY8EsXHD+40b6IN62V0tnWp5LDgeMTV8YMGZAExbwsJMWJcvCSANWe3g5CQTWtgkIIQETdUmnM54W8yTwm4OxAbx6qvJqklMgMA+zTIL6F3eLpK1Jpdc5lDoCfoeE5hTD/PbVocI2o9PZUe6Zbks/Ektsfn7u2k/K43BB0v2fyfKQvK9hP0bDkcCoUhhsivy0HfSPJoICAEGn5AMlQe052ZzEU1MgToM2Yjt59qhX1yBFIiT2lVCTid9V3+2A51RjSpa4yBerdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK8Ilyqnw8aHOlGF2kD4ZVm2iM597SV5kwlHyuJDnUg=;
 b=MH2q7/e2QvDmdBCNe+xoQHT5troOff3ccZw45Q+gqmBnQuwF+p+ZebA/orFWd3qUyul3nmPWYH4uf24OVpGItF/0raoxo5TURURXDt4sZjzEY+VSJboJZXBgG6F7+irsqOvIx8BC8/tIaMC9Mkf3S/tM/lO8iAde0wb81WWR6T07JGbWmgxnonOjvaS5s/RxPb2WMRo4wEEg644EZtttDY8uHOiCsfXn+nsJ0xR64oBySixflSqMKYouv3F/3sCfE2mXJtamPaz051fUNUOjRZkPN3nJvc9vUIy9NWp/j6XXEsbuGihzEdiIZxCnWRUGXw7IoPusS+WlDgYBoUzegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK8Ilyqnw8aHOlGF2kD4ZVm2iM597SV5kwlHyuJDnUg=;
 b=hH+mJqx8mIwHETTYPUvAjCqZ4m8O+ZfoswqjJN/qFA6FO9VfGaHFQgNgINknf72ISwKvZTvIaQ7/7qOlnA6mSNsuGMplIMx06MB71Z5AmYG1jaDDiNa5195emxJsHVPMioKQ2dsEafjALG0l3+Uncj5iKeiFjZzn1orEAdMJWyM=
Received: from BN9PR03CA0783.namprd03.prod.outlook.com (2603:10b6:408:13f::8)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 06:23:28 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::85) by BN9PR03CA0783.outlook.office365.com
 (2603:10b6:408:13f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 06:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 06:23:27 +0000
Received: from hjbog-srdc-36.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 01:23:26 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <qemu-devel@nongnu.org>
CC: <Emily.Deng@amd.com>, <PengJu.Zhou@amd.com>, <guoqing.zhang@amd.com>
Subject: [PATCH] migration/rdma: add x-rdma-chunk-shift parameter
Date: Mon, 16 Mar 2026 14:23:08 +0800
Message-ID: <20260316062308.1240426-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 239fae9d-7432-4aee-515b-08de83248949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: eMMxucKHEtbmjC+/wD0eu3LFqiUQVu6gO4YG1V/UiyAjEJGLW0XdF+ds1aQXrlrv4ZfvQ+TmwPtJn1Hhk1j0blVyCo1vRrLD80NdjeMzsUjydrm9xvLZoi2w0Tu1PjUmZxX6K5BG8+I3j9n3cQ+jA767VwfzeaNou3j/qxX9mTKawnT3D+rQaNjfT9FQQiPFTVK/ZNrxvSVGwKEQX5Opq5gW4/azR6BtW6PcrjQUs2aEmn26M14lhuGRU5fKijIymhYPToYRi5xVWLlhdD1wh1sU72KK1i7Ik9e83N9BfgIESrSSYql8NyR/iRDW6pBl2HVd36vHexzJx/QRBXeCd9+P12CUb4OaWlnPZZWC2Au5LSqEVQMqWAKpYW3qu0IonIIrqsgoOw+IJycaMTvO3BSq16iBzJqFxX7mPViwsIHBPbjprMHgIZgkKIiutylVmJZcS06Rjy705DHIt+HhPgx6IUEydpQ7jsrpsc5YvvdP02vQX/5q60FuCzD2xlgjPxrzXpI6i243w9KiF7ZRF45RGwphbNeuIFenG5u6lKoSgAGiP5ufkByji4mzAe3H4fyYaNylCYDWpLh4SDzQGIWHHP4y4Vh60IqSYu7uQ5HFREFQr3B6MSum/A9JhT7Zt9kMT/DJqRwpQGGcfy8gFid05a8wCJUCbsvjkCn7ey6f74/XtQj4as19SOTtANdVtxQSIK26nqLMWyds0QbeZQhw3qEhYdyNkV9ELM1ZIMPo9r/qwHUfWbVw+dEwOAxFkHPF6Tz46+MnWNhgdz41cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tw5NqQ6Vkb9iyww+9Q5OJ/0UL37Rj22xhNNh4hZVJ4RXdsLBJiV5W2sL967gtReVYI+4A+pa0ZvxUj4oGoO5odGIprYHlJ8WLjeAq1NIo6OZBVfiLBRhB7q6hKUO4Jmu7rzW+7Q+JLjQ+4BZIHCBxVrcs2Eibn8oeKlDVpIyR4yrWYpMtYmEJ/twDq9E+Imqw1OY2IJ+Aid1FSSwUvj7/VVxXEkf5wupmODucfq/pRnplpom/433MrV2D3wV8Ln3C6GqPt5QOZlW2oJyzPz98TXiB+bjavKO0OOoWVVV0LWQa0ueRBQLgJSBQG01fJfPq9lDydGqBynv1VkR1ozwqCroH46aS4iYR37AXyT2MwBNUIsm1d345YLBAj/SQwetwK9QZLVPRNqlajNunKE0t6rjaxIULMIa1zzPv/DEyz7+JCTfjnW8dJPnzw8Uy6ey
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 06:23:27.8112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239fae9d-7432-4aee-515b-08de83248949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
Received-SPF: permerror client-ip=52.101.193.25;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Mar 2026 08:34:18 -0400
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

The default 1MB RDMA chunk size causes slow live migration because
each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
1MB chunks produce ~15000 flushes vs ~3700 with 1GB chunks.

Add x-rdma-chunk-shift parameter to configure the RDMA chunk size
(2^N bytes) for faster migration.
Usage: -global migration.x-rdma-chunk-shift=30

Performance with RDMA live migration of 8GB RAM VM:

| x-rdma-chunk-shift | chunk size | time (s) | throughput (Mbps) |
|--------------------|------------|----------|-------------------|
| 20 (default)       | 1 MB       | 37.915   | 1,007             |
| 25                 | 32 MB      | 17.880   | 2,260             |
| 30                 | 1 GB       |  4.368   | 17,529            |

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 migration/options.c | 13 +++++++++++++
 migration/options.h |  1 +
 migration/rdma.c    | 37 ++++++++++++++++++++++---------------
 qapi/migration.json |  9 ++++++++-
 4 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index f33b297929..1503ae35a2 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -90,6 +90,7 @@ const PropertyInfo qdev_prop_StrOrNull;
 
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
+#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SHIFT          20      /* 1MB */
 
 const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
@@ -183,6 +184,9 @@ const Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_UINT8("x-rdma-chunk-shift", MigrationState,
+                      parameters.x_rdma_chunk_shift,
+                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SHIFT),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -993,6 +997,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
+uint8_t migrate_rdma_chunk_shift(void)
+{
+    MigrationState *s = migrate_get_current();
+    uint8_t chunk_shift = s->parameters.x_rdma_chunk_shift;
+
+    assert(20 <= chunk_shift && chunk_shift <= 30);
+    return chunk_shift;
+}
+
 /* parameters helpers */
 
 AnnounceParameters *migrate_announce_params(void)
diff --git a/migration/options.h b/migration/options.h
index b502871097..3f214465a3 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+uint8_t migrate_rdma_chunk_shift(void);
 
 /* parameters helpers */
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 55ab85650a..d914a7cd3b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -44,11 +44,18 @@
 
 #define RDMA_RESOLVE_TIMEOUT_MS 10000
 
-/* Do not merge data if larger than this. */
-#define RDMA_MERGE_MAX (2 * 1024 * 1024)
-#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
+#define RDMA_SIGNALED_SEND_MAX 512
+
+static inline uint64_t rdma_chunk_size(void)
+{
+    return 1UL << migrate_rdma_chunk_shift();
+}
 
-#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
+/* Do not merge data if larger than this. */
+static inline uint64_t rdma_merge_max(void)
+{
+    return rdma_chunk_size() * 2;
+}
 
 /*
  * This is only for non-live state being migrated.
@@ -527,21 +534,21 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 static inline uint64_t ram_chunk_index(const uint8_t *start,
                                        const uint8_t *host)
 {
-    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SHIFT;
+    return ((uintptr_t) host - (uintptr_t) start) >> migrate_rdma_chunk_shift();
 }
 
 static inline uint8_t *ram_chunk_start(const RDMALocalBlock *rdma_ram_block,
                                        uint64_t i)
 {
     return (uint8_t *)(uintptr_t)(rdma_ram_block->local_host_addr +
-                                  (i << RDMA_REG_CHUNK_SHIFT));
+                                  (i << migrate_rdma_chunk_shift()));
 }
 
 static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
                                      uint64_t i)
 {
     uint8_t *result = ram_chunk_start(rdma_ram_block, i) +
-                                         (1UL << RDMA_REG_CHUNK_SHIFT);
+                                         rdma_chunk_size();
 
     if (result > (rdma_ram_block->local_host_addr + rdma_ram_block->length)) {
         result = rdma_ram_block->local_host_addr + rdma_ram_block->length;
@@ -1841,6 +1848,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     struct ibv_send_wr *bad_wr;
     int reg_result_idx, ret, count = 0;
     uint64_t chunk, chunks;
+    uint64_t chunk_size = rdma_chunk_size();
     uint8_t *chunk_start, *chunk_end;
     RDMALocalBlock *block = &(rdma->local_ram_blocks.block[current_index]);
     RDMARegister reg;
@@ -1861,22 +1869,21 @@ retry:
     chunk_start = ram_chunk_start(block, chunk);
 
     if (block->is_ram_block) {
-        chunks = length / (1UL << RDMA_REG_CHUNK_SHIFT);
+        chunks = length / chunk_size;
 
-        if (chunks && ((length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
+        if (chunks && ((length % chunk_size) == 0)) {
             chunks--;
         }
     } else {
-        chunks = block->length / (1UL << RDMA_REG_CHUNK_SHIFT);
+        chunks = block->length / chunk_size;
 
-        if (chunks && ((block->length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
+        if (chunks && ((block->length % chunk_size) == 0)) {
             chunks--;
         }
     }
 
     trace_qemu_rdma_write_one_top(chunks + 1,
-                                  (chunks + 1) *
-                                  (1UL << RDMA_REG_CHUNK_SHIFT) / 1024 / 1024);
+                                  (chunks + 1) * chunk_size / 1024 / 1024);
 
     chunk_end = ram_chunk_end(block, chunk + chunks);
 
@@ -2176,7 +2183,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
     rdma->current_length += len;
 
     /* flush it if buffer is too large */
-    if (rdma->current_length >= RDMA_MERGE_MAX) {
+    if (rdma->current_length >= rdma_merge_max()) {
         return qemu_rdma_write_flush(rdma, errp);
     }
 
@@ -3522,7 +3529,7 @@ int rdma_registration_handle(QEMUFile *f)
                 } else {
                     chunk = reg->key.chunk;
                     host_addr = block->local_host_addr +
-                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT));
+                        (reg->key.chunk * rdma_chunk_size());
                     /* Check for particularly bad chunk value */
                     if (host_addr < (void *)block->local_host_addr) {
                         error_report("rdma: bad chunk for block %s"
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..0521bf3d69 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1007,9 +1007,14 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @x-rdma-chunk-shift: RDMA memory registration chunk shift.
+#     The chunk size is 2^N bytes where N is the value.
+#     Defaults to 20 (1 MiB).  Only takes effect for RDMA migration.
+#     (Since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @x-rdma-chunk-shift, @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1045,6 +1050,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
+            '*x-rdma-chunk-shift': { 'type': 'uint8',
+                                     'features': [ 'unstable' ] },
             '*direct-io': 'bool',
             '*cpr-exec-command': [ 'str' ]} }
 
-- 
2.43.7


