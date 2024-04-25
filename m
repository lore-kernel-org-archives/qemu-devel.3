Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E308C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzolE-0000aQ-OG; Wed, 24 Apr 2024 22:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzolC-0000Zh-QC
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:54 -0400
Received: from out-171.mta1.migadu.com ([95.215.58.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzolA-0005W8-OJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:54 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSyTylQQ31rsJQfAL2357Ree+ThKdOMHtL686KJImlE=;
 b=e+EIoVTx/vOJ1z4Tucuzr1PPLLqlaXPz0kHyzPTxmF7DouyhzUmeGNmTz9TOPNlNonM5D0
 bepfM8Y1KzEFwuSqOrQ/7mzDNOzSuPsIhPmGeChE2y+9WLs/n5HNxnknxZpv8s5F5w+Pfv
 lShAIawzrO+UgIhXgxpNq1pavU0RulA=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: [PATCH v4 12/14] migration/multifd: Enable set packet size migration
 option.
Date: Thu, 25 Apr 2024 02:21:15 +0000
Message-Id: <20240425022117.4035031-13-hao.xiang@linux.dev>
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.171; envelope-from=hao.xiang@linux.dev;
 helo=out-171.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During live migration, if the latency between sender and receiver
is high and bandwidth is also high (a long and fat pipe), using a bigger
packet size can help reduce migration total time. In addition, Intel
DSA offloading performs better with a large batch task. Providing an
option to set the packet size is useful for performance tuning.

Set the option:
migrate_set_parameter multifd-packet-size 4190208

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 migration/migration-hmp-cmds.c | 7 +++++++
 migration/multifd-zlib.c       | 6 ++++--
 migration/multifd-zstd.c       | 6 ++++--
 migration/multifd.c            | 6 ++++--
 migration/multifd.h            | 3 ---
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e9bb278c9..053ad0283a 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
             params->block_incremental ? "on" : "off");
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE),
+            params->multifd_packet_size);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
@@ -630,6 +633,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->multifd_dsa_accel->type = QTYPE_QSTRING;
         visit_type_str(v, param, &p->multifd_dsa_accel->u.s, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE:
+        p->has_multifd_packet_size = true;
+        visit_type_size(v, param, &p->multifd_packet_size, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 737a9645d2..2880d35841 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -49,6 +49,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
     const char *err_msg;
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
 
     zs->zalloc = Z_NULL;
     zs->zfree = Z_NULL;
@@ -58,7 +59,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_z;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         err_msg = "out of memory for zbuff";
@@ -193,6 +194,7 @@ out:
  */
 static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
 
@@ -207,7 +209,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         inflateEnd(zs);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 256858df0a..edc738afbb 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -49,6 +49,7 @@ struct zstd_data {
  */
 static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
@@ -69,7 +70,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = ZSTD_compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeCStream(z->zcs);
@@ -182,6 +183,7 @@ out:
  */
 static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
 
@@ -203,7 +205,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     }
 
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeDStream(z->zds);
diff --git a/migration/multifd.c b/migration/multifd.c
index 7316643d0a..2796646087 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1154,7 +1154,8 @@ bool multifd_send_setup(void)
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
     int thread_count, ret = 0;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
@@ -1577,7 +1578,8 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_recv_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
     const char *dsa_parameter = migrate_multifd_dsa_accel();
diff --git a/migration/multifd.h b/migration/multifd.h
index b3717fae24..97d4095b6a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -42,9 +42,6 @@ MultiFDRecvData *multifd_get_recv_data(void);
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
 
-/* This value needs to be a multiple of qemu_target_page_size() */
-#define MULTIFD_PACKET_SIZE (512 * 1024)
-
 typedef struct {
     uint32_t magic;
     uint32_t version;
-- 
2.30.2


