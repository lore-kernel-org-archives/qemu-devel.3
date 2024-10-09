Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A12CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygQA-0003e6-Bb; Wed, 09 Oct 2024 19:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPX-000361-IP
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:48:14 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPU-0006fP-GL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:48:07 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbcd49b833so2802106d6.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517683; x=1729122483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ig7VZtud++DwJTDivnw0CFSKCXooNbIa4fqqdu6Buo=;
 b=deYBkI0m6Zey0hUef88RKCPRdKRq38/8SEyFTA8Ex9Ii5CzZEs/VbCqaWPL+nNKtJw
 /fG1yt73uQZyL80q7gC3R/H7OrX/NuJRzdCSIGJLlWc3fZ4bIJ7Kef6XuH/xhdDkCZxZ
 yC8kvyK9K8bLJ+Jh65WeZY2He8BK1Gxf0aumlZCgpLmOkBgHZOc1lvJ3WHNp3ZbkimYN
 Bq5dRdhYxdta9vDwiSBSzXjfHIB4D7V9C9fTLDvCCSLe/LeV5RrtLJVjSs5393jXlw6+
 iQwHzZfe3dgPc+9F17lUNYH4JRWQtLEhVYi2gzUMtbeMziDTDtqM7WagHaU0H27RISzA
 9YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517683; x=1729122483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Ig7VZtud++DwJTDivnw0CFSKCXooNbIa4fqqdu6Buo=;
 b=DSHRia0fKlc3iXrCx003+O7E7A6IQFWhn1M2E5aStEtuan6RwSSVaGTKUjDkStaKP3
 SfE4Q2mg6LtaDe+CgMNsbdp+Zd+nhPtZ4enqX9wgsmu+31Kc1jfLTklQSLlurE30FznS
 aMeYafOFJaGy7yz7Pb4i/KHT4I8ETcpblCMSRLEJ8jGL6vI1J5Emj9zymhydY0QKXK4W
 C4f9zL9Daxh/RIEH0/WhfDJsvJVPee5p/2K+0bXyS07U0wsreDEw0yrAPhCqkJUKhcNH
 NvTccYHJR/tyH5PkzbNIMBPHCeWig5rxm9RSUPcb9RKneqweJ8XwDelM7nAhpfXVfY4Z
 SmAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBoYda4YyIodhyjezWbq3ZqVHXqX46TBI7K5PeZ8vI0L+rLYOnhM9UeSILWVOSRwvJYz3IdlxznxoD@nongnu.org
X-Gm-Message-State: AOJu0YzFQ5bvNYa6XYyRnzKC6usFPw0UIR+D4eg5SH9vJC8FGBK4qoH1
 tMUIqlTKl+WaDQ9YBSEiQjqG/wGGu4Ut69Iznc63HaamcgrR7nUaqjRfy5nm/24=
X-Google-Smtp-Source: AGHT+IFlQJUWyvPQBJToiabA9PHYz8GJfsaCBbRMVAZyPSbdhI9yUR8Ew93pBYXklAZjwYn1KbjVhA==
X-Received: by 2002:ad4:46d2:0:b0:6cb:cda0:df6 with SMTP id
 6a1803df08f44-6cbcda00f67mr45735206d6.3.1728517683378; 
 Wed, 09 Oct 2024 16:48:03 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.48.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:48:02 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v6 10/12] migration/multifd: Add migration option set packet
 size.
Date: Wed,  9 Oct 2024 16:46:08 -0700
Message-Id: <20241009234610.27039-11-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hao Xiang <hao.xiang@linux.dev>

During live migration, if the latency between sender and receiver is
high and bandwidth is also high (a long and fat pipe), using a bigger
packet size can help reduce migration total time. The current multifd
packet size is 128 * 4kb. In addition, Intel DSA offloading performs
better with a large batch task.

This change adds an option to set the packet size, which is also useful
for performance tuning. Both sender and receiver needs to set the same
packet size for things to work.

Set the option:
migrate_set_parameter multifd-packet-size 4190208

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  7 ++++++
 migration/multifd-zlib.c       |  6 ++++--
 migration/multifd-zstd.c       |  6 ++++--
 migration/options.c            | 39 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 21 +++++++++++++++---
 6 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 983f13b73c..561ed45250 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -292,6 +292,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE),
+            params->multifd_packet_size);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
@@ -580,6 +583,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
             QAPI_LIST_APPEND(tail, strv[i]);
         }
         break;
+    case MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE:
+        p->has_multifd_packet_size = true;
+        visit_type_size(v, param, &p->multifd_packet_size, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 8cf8a26bb4..58c278533a 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -39,6 +39,7 @@ static int multifd_zlib_send_setup(MultiFDSendParams *p, Error **errp)
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
     const char *err_msg;
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
 
     zs->zalloc = Z_NULL;
     zs->zfree = Z_NULL;
@@ -48,7 +49,7 @@ static int multifd_zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_z;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         err_msg = "out of memory for zbuff";
@@ -162,6 +163,7 @@ out:
 
 static int multifd_zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
 
@@ -176,7 +178,7 @@ static int multifd_zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         inflateEnd(zs);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index abed140855..1f97a5417c 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -39,6 +39,7 @@ struct zstd_data {
 
 static int multifd_zstd_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
@@ -58,7 +59,7 @@ static int multifd_zstd_send_setup(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = ZSTD_compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeCStream(z->zcs);
@@ -149,6 +150,7 @@ out:
 
 static int multifd_zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
 
@@ -170,7 +172,7 @@ static int multifd_zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     }
 
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeDStream(z->zds);
diff --git a/migration/options.c b/migration/options.c
index a0b3a7d291..b1eaf1c095 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -80,6 +80,13 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
+/*
+ * Parameter for multifd packet size.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (128 * 4 * 1024)
+/* DSA device supports up to 1024 batches, i.e. 1024 * 4K pages */
+#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1024 * 4 * 1024)
+
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
@@ -173,6 +180,9 @@ Property migration_properties[] = {
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
                        ZERO_PAGE_DETECTION_MULTIFD),
+    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
+                     parameters.multifd_packet_size,
+                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -783,6 +793,13 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
 
+uint64_t migrate_multifd_packet_size(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_packet_size;
+}
+
 MultiFDCompression migrate_multifd_compression(void)
 {
     MigrationState *s = migrate_get_current();
@@ -911,6 +928,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->has_multifd_packet_size = true;
+    params->multifd_packet_size = s->parameters.multifd_packet_size;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -973,6 +992,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
+    params->has_multifd_packet_size = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1055,6 +1075,19 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
+    if (params->has_multifd_packet_size &&
+        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size % qemu_target_page_size() != 0))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                    "multifd_packet_size",
+                    "an integer in the range of "
+                    stringify(DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE)
+                    " to "stringify(MAX_MIGRATE_MULTIFD_PACKET_SIZE)", "
+                    "and must be a multiple of guest VM's page size.");
+        return false;
+    }
+
     if (params->has_multifd_channels && (params->multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
@@ -1236,6 +1269,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->x_checkpoint_delay = params->x_checkpoint_delay;
     }
 
+    if (params->has_multifd_packet_size) {
+        dest->multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1364,6 +1400,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         colo_checkpoint_delay_set();
     }
 
+    if (params->has_multifd_packet_size) {
+        s->parameters.multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
diff --git a/migration/options.h b/migration/options.h
index 8198b220bd..8158d4879d 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -87,6 +87,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 const strList *migrate_dsa_accel_path(void);
+uint64_t migrate_multifd_packet_size(void);
 
 /* parameters helpers */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index d8b42ceae6..1d14d8e82f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -851,6 +851,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest page size.
+#     The default value is 524288 and max value is 4190208.  (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -877,7 +881,8 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io',
+           'multifd-packet-size'] }
 
 ##
 # @MigrateSetParameters:
@@ -1038,6 +1043,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest page size.
+#     The default value is 524288 and max value is 4190208.  (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1080,7 +1089,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*dsa-accel-path': [ 'str' ] } }
+            '*dsa-accel-path': [ 'str' ],
+            '*multifd-packet-size' : 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1255,6 +1265,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest page size.
+#     The default value is 524288 and max value is 4190208.  (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1294,7 +1308,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*dsa-accel-path': [ 'str' ] } }
+            '*dsa-accel-path': [ 'str' ],
+            '*multifd-packet-size': 'uint64' } }
 
 ##
 # @query-migrate-parameters:
-- 
Yichen Wang


