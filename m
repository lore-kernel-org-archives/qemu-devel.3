Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAA6CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMM4-0004PT-R7; Tue, 05 May 2026 16:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM1-0004Mr-OZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMLz-0002aC-9m
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebiyZAuHPg80vY31UF8UVr2ykPbfE9ba9kbGfZ1Nazg=;
 b=JWTAGjxS1ToXoQvpui3Dupgaj2hyo1Si2cXTz7OEDv03A3VK0cY7YK3zWTWgtNkDEheUmD
 Q/A6TYXsMsVhMVjvdoN/u66wlKnKPRBWEE980yGZaMxh1dYmFxmUPLyeh2M19RPsKJJ5ks
 H4uCztQNhhQSaE2rcLLZivpPfhmbl8g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-8H0zrU3yOfu0u8sEeOm6vg-1; Tue, 05 May 2026 16:26:49 -0400
X-MC-Unique: 8H0zrU3yOfu0u8sEeOm6vg-1
X-Mimecast-MFC-AGG-ID: 8H0zrU3yOfu0u8sEeOm6vg_1778012809
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b597b14a22so10660946d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012808; x=1778617608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebiyZAuHPg80vY31UF8UVr2ykPbfE9ba9kbGfZ1Nazg=;
 b=N81xyfGaCY6GEF5Iazf6zunBof6FYYZ2GOl5Z2JCBDzb/Ge2lcFSMY3OVdSVmzXzTX
 +EcLFTzgDJ40DYLwUbXLes7jTP/hm+ECfTFiu8/iJHoER9fzMixmr1hBpBiGFOhcyU7+
 pEQqBiLaHvkXIA2sYK6UW/gWDnynL5oY/CDoccUSi2w7ahY/VCSjciy5Wt36B4X7UTY1
 vpFzJty//3NFcJvibe7Y5FLmkfSazyhRBLEsaab3x33q0Laexo1ZZaPF3FsxSzTTs+3r
 WdYmhV9NcAAa39ZTTirqJjDwgsynRi7aZfshl+UTjoDl2G79C0XB+L9APtJbmz0DQQuN
 ZADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012808; x=1778617608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ebiyZAuHPg80vY31UF8UVr2ykPbfE9ba9kbGfZ1Nazg=;
 b=KiB69Y+saiVpLxhaGAELl3LpBsJN3ngnDkYU2xMomZau8+p83MYYtnk74md2fwV9YV
 sockiZydswhFnmfy1rVUepdAiq4yTA3cWYx3OUCZ5GNM55eXxT1v+G+WIbQFx0+1+JAt
 HxdMVhXnQzn8z7MQQPx4IIS8oAwB45eo3oD+zG3Q1hQeX5Rk7Oz5Z+WESyrFh4lF9xEE
 2Re09L7KB1XPZcRnk4+PeUEi2zbiP+98nwHm8RuVkg0wFDlJw9o0s1Opbq54ga1ETbN9
 loTuKYXNcjBcU+B0l+gaSdFnBxZKqfp8y67Iy4jOVFkN9pl7iGEJSgdPz//uSko/O2ys
 Cp8Q==
X-Gm-Message-State: AOJu0YxefgB32wrP+OuE7JupyPhUCyc89xAESYQa3+A0TozH+7F2EGF7
 bTyzIdzxTZ8NxHHDoc8Yb3uB5iM7EsMbch8wLYv9z8PGx7MBhVVPB+CE5oeZtZGliXGWdJWyi4k
 Q0b+v/RHoIXwwSFzyfaG8vbv29gPwOE0964Bzwu6Jtc+nXmq4LxSf5QeVKpKv2oKd4yqb6F1qPJ
 I34L5gfK9yRYXTSKPWWIK0hS05mO/FzFbq7nFHWw==
X-Gm-Gg: AeBDieskUnQpXVrCwEoSKtp2b1NcfnbujzK2w5kBcASGndsm84eAuwfEsZTqqu4gNIJ
 RmQSx+tiWb9H1by4UrSNcKiezFFznIYn0DNNEc1E6rS2W4uQ/XcR6hEDz7Tphjqx64kszatnQ8G
 vYfloAa2uhw0lCa+cLRezBb2eJvZNAbWiNdlCcxPlTNstjBxIqsNbPCC1P37r0AlWADxR6Jkczz
 s+1nPVSiLx4ErYHmupKqU3bU3cc5LJj2adyLtH50WvZwMfyScIzxOhkrMW/0DufH9kLmw0RUxad
 RjShk/wZbJbVoINcyHYM6IpKZsZi3MVUr82VU20gA0FWYAyKD17QGFyQdUUwONKoO2yPrLqDnEu
 373yNFoIjzI5l7TD9BLeewAoIvctsDiMenGc0eV2XdxG7rDplgPaPClQ=
X-Received: by 2002:a05:6214:e86:b0:89c:3f06:537a with SMTP id
 6a1803df08f44-8baa05bda05mr77133536d6.21.1778012808182; 
 Tue, 05 May 2026 13:26:48 -0700 (PDT)
X-Received: by 2002:a05:6214:e86:b0:89c:3f06:537a with SMTP id
 6a1803df08f44-8baa05bda05mr77133006d6.21.1778012807498; 
 Tue, 05 May 2026 13:26:47 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 03/23] migration/rdma: add x-rdma-chunk-size parameter
Date: Tue,  5 May 2026 16:26:20 -0400
Message-ID: <20260505202640.1011006-4-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Samuel Zhang <guoqing.zhang@amd.com>

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
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Li Zhijian <lizhijian@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260427031401.3895523-1-guoqing.zhang@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 13 +++++++++++--
 migration/options.h            |  1 +
 migration/migration-hmp-cmds.c | 11 +++++++++++
 migration/options.c            | 33 ++++++++++++++++++++++++++++++++-
 migration/rdma.c               | 30 ++++++++++++++++--------------
 5 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..0db115ec5e 100644
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
@@ -1007,9 +1008,15 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
+#     Default is 1MiB.  Must be a power of 2 in the range
+#     [1MiB, 1024MiB].  Only applies when migrating via RDMA.
+#     Must be set to the same value on both source and destination
+#     before migration starts.  (Since 11.1)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
+# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
@@ -1046,6 +1053,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
+            '*x-rdma-chunk-size': { 'type': 'uint64',
+                                    'features': [ 'unstable' ] },
             '*cpr-exec-command': [ 'str' ]} }
 
 ##
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
index 68441f0276..5cbfd29099 100644
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
+#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
 
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
@@ -1000,6 +1005,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
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
@@ -1062,7 +1076,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1273,6 +1287,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
 
@@ -1393,6 +1416,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         dest->direct_io = params->direct_io;
     }
 
+    if (params->has_x_rdma_chunk_size) {
+        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
+    }
+
     if (params->has_cpr_exec_command) {
         qapi_free_strList(dest->cpr_exec_command);
         dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
@@ -1520,6 +1547,10 @@ static void migrate_params_apply(MigrationParameters *params)
         s->parameters.direct_io = params->direct_io;
     }
 
+    if (params->has_x_rdma_chunk_size) {
+        s->parameters.x_rdma_chunk_size = params->x_rdma_chunk_size;
+    }
+
     if (params->has_cpr_exec_command) {
         qapi_free_strList(s->parameters.cpr_exec_command);
         s->parameters.cpr_exec_command =
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
-- 
2.53.0


