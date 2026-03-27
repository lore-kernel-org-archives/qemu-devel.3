Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733E610BA431
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 06:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w611g-000796-6Z; Fri, 27 Mar 2026 02:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w611e-00078x-T8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 02:50:34 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w611b-0006sK-Vg
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 02:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSPVUK3xqilwCnkIuXa81C04/40nmsBhPC7jgEsZQqtEyBXk3enyR85+PtiVoqEZojLDAPKUkF+XGWXow1Es+nzMp+FzQdIjyIaryFXDKsqEM2FGbDtGLEs7vx91aNAiZXgTwKM2TlWngLljiFT2VDSvImcKm+yrI7A13qIJlgQ2+bFcK5ShvPlGsKmjtH0LMaTczshfiayGoovcucu0X5UdH9/+x96rM6hffOu01CRyyr64naKDUUDuGkTo6JQMrbEFxyNjROfo6WicPhsInoJTn6n11Mg6X1a5XTq/3G0mhuVrKfm9TysDC0XaCo4HyAp3ZhXn5lxctSUjU569Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP9SjyL2lzQjkVSez/ZwwCdgJAf8VPjUvfzptCaOhxo=;
 b=RuwJCvDQ53P8T90hqfk72T8uEhpaHDo53vgyV9wvage2kBPlIZ2ddVfLVkIchLbnRAIByokDsvt8uXDZML87NVCntpF4ZY+lnTSQq9WHool/CnuR5UxTtmqgkfAMV8EkZIb5Zq5Kc7UG/s4kogrpwqRgNdO8iJR03XNn8TPbGOnyezE1++MzobWxpaYsesrqI0Arki9Ich1qqHocn8Nn1saDFxz+E+Igss5BK4AZTP0O0BeIvB+CXMbjJc4+0KMicX0Em+KE5h+78fKE+kA9iCo79jkD/RLUBnU+eZwtFmHglyJWxd7rVs1R230S9d4f9bcrx7tC7mGrPvpx6Q7Ajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP9SjyL2lzQjkVSez/ZwwCdgJAf8VPjUvfzptCaOhxo=;
 b=C5L9fQk/mbSgf/I5QI9VA5yzkCsF6jYieYd0HrHNhyzda0kWX5XDrCe2+PtWTMCUMRrZMGFm3ULZWpJWuFAFhVqWM70y7AbfwWQaKliSg8hDGqArmgmiEYycL3nwDjTZlPyQh/yeDJQ3GMbw02rdxkoG4KtFw6XkazvfklqglqE=
Received: from MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 06:50:23 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::73) by MN2PR19CA0056.outlook.office365.com
 (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 06:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 06:50:22 +0000
Received: from hjbog-srdc-36.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 01:50:19 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <PengJu.Zhou@amd.com>, <Qing.Ma@amd.com>, Samuel Zhang
 <guoqing.zhang@amd.com>
Subject: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
Date: Fri, 27 Mar 2026 14:50:06 +0800
Message-ID: <20260327065006.2567463-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 81273d27-c117-453d-1a0b-08de8bcd1e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ACEFdJSj6pfshc/2nfvYyBikVYNX9SU4DiOOplsrS5Xenn4gVUop+oCBJcUjcsAa8a5L6PyyQH8VeO0/j0Odtt9vlxyWwHBW0TDm47jr3ajKNfdOb+JvX4BDcLG3y0bdLrBcpmFgxuuPUyFbuOTZkzgkMtaWWUVg5exmG6xOU6HHRqP62h5RuXyx0k01tm8wDxLroaPyTpWKo8iqBTlarzNF+em0lusLDJ2QmTyRtmWpQY38LEZvrX4OARFonMkNRMwJMoLiCv2PyEFaWqtiqrSjgf7Ur7NioLjVR04ZSoOU4z7pKFRggf+n02uTxheL3OHtbxcsTKwyaV0p+l3D3c8OIdeZ4StfUznD/eRXQ0RYgFRRENEHxtt987d3NDPV7y3WApVrKAWyV1UnF3UgpKcu0ktToM8x6rrJOmQMYgkh3r/xl5eSHuxhPXSgW82/IXw+BtRS/Hevpmr16SCIV4DmvPeikguEs0AvAGSrn6nmAPQuVGOj+fvwsT2l8ZQNND75SPh8qXjYJVAxEu+C8OJvtJTyA4ys/R1RaKvDc1aOwnJhkh072/F5CyMEWS5Bju0UCzwyyNwex5MkWQaQsSGtPjG3wT202hi68yCbpbtSbqD4ILqyplwUcanMqYdEhau7TFpi9HCBnLGMhtkzb98/5C86jP7GKDdJ8WoqeLQ97WNQVs1rDDq5HRFJa9ke8ELx9TCVfkV/grozWzw8OYYR+65Wr6o9tuqnv65dCArCs8PJroeMyQOVItqNAx+qWuL6uxlAK56kP4yjd2HYaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ihTC1SLe8I/MTpBUhSAeZjmasojza83g6Ef8DALWkcDdUgYF2WAvzPuhx2sNt5nkMJ7ZMOkCYjwbK2MBrEg3Bvnbt/tsrPt4KeUOVXJLO7MSJLB4kc1Bz8q0EFP6eTNnmVQrBiNIRQLaVokRP35fucOCrVR74fgFR2h0uDSG3UULDZZrT5KhhMK0gpyh4adSdBxHYgePbmpCAww7gw5U/iwn26QdqbT/jCpi26LEn3iRNyglUAkcfddWSP3LyKl3BB8Ri0PoO01U2wLCMgs5mPwPPqPLT6KKtpDCD+0NQA7c+tnIwydjJWPSAC2k6xR4LhImrHncgHLFqJnNLO9Gf4vJE/n2Oeoxc+lwztcFIUdfIsEruCV8EE7H3raEGayU1CkBP765XulZ51OH9ntduIzLDSm5MuYVE6KBzNAF1nGzDcy5E7Z2o2hAGxGtUWw0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:50:22.6453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81273d27-c117-453d-1a0b-08de8bcd1e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.

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
v3:
- Use visit_type_size() in HMP set parameter
- Use MiB/GiB constants

 migration/migration-hmp-cmds.c | 11 +++++++++++
 migration/options.c            | 33 ++++++++++++++++++++++++++++++++-
 migration/options.h            |  1 +
 migration/rdma.c               | 30 ++++++++++++++++--------------
 qapi/migration.json            | 12 ++++++++++--
 5 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54..4f6c1dbf89 100644
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
@@ -734,6 +741,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
+    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
+        p->has_x_rdma_chunk_size = true;
+        visit_type_size(v, param, &p->x_rdma_chunk_size, &err);
+        break;
     case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
         /*
          * NOTE: g_autofree will only auto g_free() the strv array when
diff --git a/migration/options.c b/migration/options.c
index f33b297929..bc61c8665d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -90,6 +91,7 @@ const PropertyInfo qdev_prop_StrOrNull;
 
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
+#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB     /* 1MB */
 
 const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
@@ -183,6 +185,9 @@ const Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_UINT64("x-rdma-chunk-size", MigrationState,
+                      parameters.x_rdma_chunk_size,
+                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -993,6 +998,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
     return s->parameters.zero_page_detection;
 }
 
+uint64_t migrate_rdma_chunk_size(void)
+{
+    MigrationState *s = migrate_get_current();
+    uint64_t size = s->parameters.x_rdma_chunk_size;
+
+    assert(MiB <= size && size <= GiB && is_power_of_2(size));
+    return size;
+}
+
 /* parameters helpers */
 
 AnnounceParameters *migrate_announce_params(void)
@@ -1055,7 +1069,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1266,6 +1280,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_x_rdma_chunk_size &&
+        (params->x_rdma_chunk_size < MiB ||
+         params->x_rdma_chunk_size > GiB ||
+         !is_power_of_2(params->x_rdma_chunk_size))) {
+        error_setg(errp, "Option x_rdma_chunk_size expects "
+                   "a power of 2 in the range 1MiB to 1024MiB");
+        return false;
+    }
+
     return true;
 }
 
@@ -1391,6 +1414,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         dest->direct_io = params->direct_io;
     }
 
+    if (params->has_x_rdma_chunk_size) {
+        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
+    }
+
     if (params->has_cpr_exec_command) {
         dest->cpr_exec_command = params->cpr_exec_command;
     }
@@ -1517,6 +1544,10 @@ static void migrate_params_apply(MigrationParameters *params)
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
index 7134d4ce47..292d96c95a 100644
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
@@ -1007,9 +1008,14 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
+#     Default is 1MiB.  Must be a power of 2 in the range
+#     [1MiB, 1024MiB].  Only takes effect for RDMA migration.
+#     (Since 11.1)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1046,6 +1052,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
+            '*x-rdma-chunk-size': { 'type': 'uint64',
+                                    'features': [ 'unstable' ] },
             '*cpr-exec-command': [ 'str' ]} }
 
 ##
-- 
2.43.7


