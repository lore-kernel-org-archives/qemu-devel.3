Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BEF109E542
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5b3K-0005Hy-Uo; Wed, 25 Mar 2026 23:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w5b3G-0005HY-Hv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:06:30 -0400
Received: from mail-westus3azon11012021.outbound.protection.outlook.com
 ([40.107.209.21] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w5b3D-0003DZ-TK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6RC5U9kYMYR3AMyBVO4tZHwIPo4igaGqJzVe9FR3lNFU5Hf15y7TJgkmGj5o4nSwKd4wvl/Ab55Hxv+5JPYc3ZQKn4ZCsEH99DNrJaDnRDink/BNsJROEhJyAAAE6eFmmDMSU4VypkwN7l98CGPDo2YRpFOas+RH73Ob1gShGI53NDgRmMikim9g2cMTeKp24FhJ3JfMDh/G1HJ21Pbzs6aKXHqBHNLNXl661Xm4SKhT5OV2lJa4o/6NRMOwPrbJG11TJE+P0qdmuD2soYUyuOUQ8Gerq7VFVxzRAfei/AQwytB4PlVFJ5+a6JTs05FOVR9l9Qeq+OVovXaojmUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5jNeoglcJ4wWFOfFnUybZnO23avIOsxiLGWkT5+szc=;
 b=gIIVZBxxh/6x9io/+NToj6hzcAhpgE++URq0a1Zit8LGz4JkWtf52f/uBNlogmc9f5k6p2hkgoqdMA7vTsIfrwQUI0A/OAWQ9ZoxGcBMyxbx7BH73UY75bFntoIC8wFbO/6piElI7v2zRRe4XmzW+rMTKucTr+7AAWWxjb8JUR8lDUcCMgKohkKQWG/KHC4n/Q1yOcbZ6bfm/O4+WDn7kjpofo+nZ24sl+AruXC1vWekYY7QIbSyZucyyzkd4wgTmebvr9cnH1OXP05DaxgPAmGoPbAnhP0HSTx2h2M7H4tlCIul5+dTJ3RddODASpUByKDhkwVegH1us3vrb2/0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5jNeoglcJ4wWFOfFnUybZnO23avIOsxiLGWkT5+szc=;
 b=Nl3ArU10/9PBL7rEYqjxHLsqblb41odW+TRifUVYVwsgZAEs5/WrRf1T/MZhahuiWRh5cFfzfev+z/0UBurflgQpiR6RcpKP/p2r8t/BNWnj+udJtZtNDctiRDYKOmvM0vl1YFbF3DAVQFHgEptv1BIEo20cqiQjjxgcKogu/pM=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 03:01:18 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::93) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:18 +0000
Received: from hjbog-srdc-36.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:14 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <PengJu.Zhou@amd.com>, <Qing.Ma@amd.com>, Samuel Zhang
 <guoqing.zhang@amd.com>
Subject: [PATCH v2] migration/rdma: add x-rdma-chunk-size parameter
Date: Thu, 26 Mar 2026 10:58:25 +0800
Message-ID: <20260326025825.2427332-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260316062308.1240426-1-guoqing.zhang@amd.com>
References: <20260316062308.1240426-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca5fda3-146d-428d-8706-08de8ae3f3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zy1ty7h3nw4+QIeYJxxBKkbYsow/Rnh9g1T10E7Ex43cBg78r97O1HQjz4brUjGnsJxJThmrMSbv147AIkwucLL1OV3thrTxFO72GSr7Ok8UKecH35eySKLu6nKWQK4kNW8AWyj3nXA9MuAw9NfBp/CJYX/mGH3RKR5MUFL8TeHlFhlyMGRY9/9nuN/IZ0yIgbaaNbGJJm2EL+yZaxpG2VmmFrzlkUKABAxVgDn/7Dbhi2Q+orE+2kCa80tA9MHLLfBSCYxfzOwl2sfJFAtBxtkM4zgbQcFNoiHSDs7R89xID1Hwor50fS10mUTv7wk6MbZUwP4uF7HuI/3GWTRQFTkiBd1HCCtGHtGE9KdZ4a7McSyh+cEEBaj97xw+bGnh8/KUhUmkSouu794jPlm/LhwG/BHGn+QL/5cM5QcmXrSahqAIP6X5RYbUnhrbarmI3gJUCflzeD20fl+CPw4tQIg8WbFjp44iZPFQgCqIt3bk0RYitS39myG6o03hBHfTYv7t+3JXd9BPwOnzG5LsaJ5JmrWft13+iUcTeGCLlhqHrC3IRQUwreq7S/Hp9zllYdwkRNdILxsP54XoFg2vgp3xlmoQI917IGfWtCg0d2MpOdakKvCc3/aKz6jkGqYx3BLnmGhSiDS6nOARa76tiCtC213hHJvKjtFE0Y4du4JaBeKjKz7DosAEt49cpoHLa87/gjqfGaVgIsMVcV24EAwKxO2KZDER7BiJ/0fpyPHmrkzzLwMbUM9P/FqFlo/ySqzTlMKUHr76hYhDcKHOWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7VkW5HM/EaMrp45H07ECuzQr5Vt1yh8Rk+dCGnb/Xn/D6Dl3XyS4c6GhtQBZzd18hKzfZ06EiKJUVwpWRqCDtvyMR7sOB8ypChFYfqtefp9nTL/wzWmYT+Bw52rOyJhCCrB0o6u3ubIlKRU9Y27Y3hqEJrw3WC/tWyK4gG/3JcSw6o4CxMAbukppJEut12eJbII1Q1WSmawH2/jn57zBw5+AUVb0640xaSBsAwoKMI8PY6r0w/aRbNt3MJELkNhVey6AWpevnU7rKwbOZwSGDrzzsHuqURF8UyftFxMHpEes5Xvr4H0oHmIZRrcU1TD3Pqj8XRkxm58LjqPLLu1e5BG2DlCF57lEthowLBhxtBrDuZHNoWGa1LSYuurTql1DvmJPSbgsSdYAuYIVoIlrm7lCPrfNcxBecEopG+gbOvnXZsTRI4RS/P/IqEO0p7fs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:18.2560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca5fda3-146d-428d-8706-08de8ae3f3a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
Received-SPF: permerror client-ip=40.107.209.21;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The default 1MB RDMA chunk size causes slow live migration because
each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
1MB chunk size produce ~15000 flushes vs ~3700 with 1024MB chunk size.

Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
faster migration.
Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`

Performance with RDMA live migration of 8GB RAM VM:

| x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
|-----------------------|----------|-------------------|
| 1M (default)          | 37.915   |  1,007            |
| 32M                   | 17.880   |  2,260            |
| 1024M                 |  4.368   | 17,529            |

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
v2:
- Renamed x-rdma-chunk-shift to x-rdma-chunk-size (byte count)
- Added validation in migrate_params_check()
- Added hmp_migrate_set_parameter() support
- Added hmp_info_migrate_parameters() support
- Added migrate_mark_all_params_present()
- Use qemu_strtosz() for size suffix support

 migration/migration-hmp-cmds.c | 17 +++++++++++++++++
 migration/options.c            | 32 +++++++++++++++++++++++++++++++-
 migration/options.h            |  1 +
 migration/rdma.c               | 30 ++++++++++++++++--------------
 qapi/migration.json            | 11 +++++++++--
 5 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54..2c005c08a6 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -451,6 +451,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                            params->direct_io ? "on" : "off");
         }
 
+        if (params->has_x_rdma_chunk_size) {
+            monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
+                           MigrationParameter_str(
+                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
+                           params->x_rdma_chunk_size);
+        }
+
         assert(params->has_cpr_exec_command);
         monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
     }
@@ -730,6 +737,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_mode = true;
         visit_type_MigMode(v, param, &p->mode, &err);
         break;
+    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
+        p->has_x_rdma_chunk_size = true;
+        ret = qemu_strtosz(valuestr, NULL, &valuebw);
+        if (ret != 0 || valuebw < (1<<20) || valuebw > (1<<30)
+            || !is_power_of_2(valuebw)) {
+            error_setg(&err, "Invalid size %s", valuestr);
+            break;
+        }
+        p->x_rdma_chunk_size = valuebw;
+        break;
     case MIGRATION_PARAMETER_DIRECT_IO:
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
diff --git a/migration/options.c b/migration/options.c
index f33b297929..91dd874b5e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -90,6 +90,7 @@ const PropertyInfo qdev_prop_StrOrNull;
 
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
+#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           (1<<20) /* 1MB */
 
 const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
@@ -183,6 +184,9 @@ const Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_UINT64("x-rdma-chunk-size", MigrationState,
+                      parameters.x_rdma_chunk_size,
+                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -993,6 +997,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
+uint64_t migrate_rdma_chunk_size(void)
+{
+    MigrationState *s = migrate_get_current();
+    uint64_t size = s->parameters.x_rdma_chunk_size;
+
+    assert((1<<20) <= size && size <= (1<<30) && is_power_of_2(size));
+    return size;
+}
+
 /* parameters helpers */
 
 AnnounceParameters *migrate_announce_params(void)
@@ -1055,7 +1068,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1227,6 +1240,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_x_rdma_chunk_size &&
+        (params->x_rdma_chunk_size < (1<<20) ||
+         params->x_rdma_chunk_size > (1<<30) ||
+         !is_power_of_2(params->x_rdma_chunk_size))) {
+        error_setg(errp, "Option x_rdma_chunk_size expects "
+                   "a power of 2 in the range 1M to 1024M");
+        return false;
+    }
+
     if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
         error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
         return false;
@@ -1391,6 +1413,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         dest->direct_io = params->direct_io;
     }
 
+    if (params->has_x_rdma_chunk_size) {
+        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
+    }
+
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
@@ -1517,6 +1543,10 @@ static void migrate_params_apply(MigrationParameters *params)
         s->parameters.direct_io = params->direct_io;
     }
 
+    if (params->has_x_rdma_chunk_size) {
+        s->parameters.x_rdma_chunk_size = params->x_rdma_chunk_size;
+    }
+
     if (params->has_cpr_exec_command) {
         qapi_free_strList(s->parameters.cpr_exec_command);
         s->parameters.cpr_exec_command =
diff --git a/migration/options.h b/migration/options.h
index b502871097..b46221998a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+uint64_t migrate_rdma_chunk_size(void);
 
 /* parameters helpers */
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 55ab85650a..3e37a1d440 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -45,10 +45,12 @@
 #define RDMA_RESOLVE_TIMEOUT_MS 10000
 
 /* Do not merge data if larger than this. */
-#define RDMA_MERGE_MAX (2 * 1024 * 1024)
-#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
+static inline uint64_t rdma_merge_max(void)
+{
+    return migrate_rdma_chunk_size() * 2;
+}
 
-#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
+#define RDMA_SIGNALED_SEND_MAX 512
 
 /*
  * This is only for non-live state being migrated.
@@ -527,21 +529,21 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 static inline uint64_t ram_chunk_index(const uint8_t *start,
                                        const uint8_t *host)
 {
-    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SHIFT;
+    return ((uintptr_t) host - (uintptr_t) start) / migrate_rdma_chunk_size();
 }
 
 static inline uint8_t *ram_chunk_start(const RDMALocalBlock *rdma_ram_block,
                                        uint64_t i)
 {
     return (uint8_t *)(uintptr_t)(rdma_ram_block->local_host_addr +
-                                  (i << RDMA_REG_CHUNK_SHIFT));
+                                  (i * migrate_rdma_chunk_size()));
 }
 
 static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
                                      uint64_t i)
 {
     uint8_t *result = ram_chunk_start(rdma_ram_block, i) +
-                                         (1UL << RDMA_REG_CHUNK_SHIFT);
+                                         migrate_rdma_chunk_size();
 
     if (result > (rdma_ram_block->local_host_addr + rdma_ram_block->length)) {
         result = rdma_ram_block->local_host_addr + rdma_ram_block->length;
@@ -1841,6 +1843,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
     struct ibv_send_wr *bad_wr;
     int reg_result_idx, ret, count = 0;
     uint64_t chunk, chunks;
+    uint64_t chunk_size = migrate_rdma_chunk_size();
     uint8_t *chunk_start, *chunk_end;
     RDMALocalBlock *block = &(rdma->local_ram_blocks.block[current_index]);
     RDMARegister reg;
@@ -1861,22 +1864,21 @@ retry:
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
 
@@ -2176,7 +2178,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
     rdma->current_length += len;
 
     /* flush it if buffer is too large */
-    if (rdma->current_length >= RDMA_MERGE_MAX) {
+    if (rdma->current_length >= rdma_merge_max()) {
         return qemu_rdma_write_flush(rdma, errp);
     }
 
@@ -3522,7 +3524,7 @@ int rdma_registration_handle(QEMUFile *f)
                 } else {
                     chunk = reg->key.chunk;
                     host_addr = block->local_host_addr +
-                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT));
+                        (reg->key.chunk * migrate_rdma_chunk_size());
                     /* Check for particularly bad chunk value */
                     if (host_addr < (void *)block->local_host_addr) {
                         error_report("rdma: bad chunk for block %s"
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..94d2c1c65f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -806,7 +806,7 @@
 #
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -831,6 +831,7 @@
            'mode',
            'zero-page-detection',
            'direct-io',
+           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
            'cpr-exec-command'] }
 
 ##
@@ -1007,9 +1008,13 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
+#     Default is 1M.  Must be a power of 2 in the range [1M, 1024M].
+#     Only takes effect for RDMA migration.  (Since 11.1)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1046,6 +1051,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
+            '*x-rdma-chunk-size': { 'type': 'uint64',
+                                    'features': [ 'unstable' ] },
             '*cpr-exec-command': [ 'str' ]} }
 
 ##
-- 
2.43.7


