Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23E8CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygQ2-0003Ks-66; Wed, 09 Oct 2024 19:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPM-00034p-Bl
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:56 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPK-0006eQ-3M
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:56 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbd57cc35bso6901176d6.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517673; x=1729122473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rh4iSF4JcVdFm8rItOAee3jMjOlBonh6C/ENTJRWd4=;
 b=XEfvbbOZHss6JWlThT/TvcdCCy6eO/fPS3Z+f29cai+qdH0dEuNQ2WDsPd+rZ3Gr4D
 o1aAQqiMiBzzb3Q+AD+Wi8qrLPm3TJ0bm3o5HR0PCDbacuUPuHa1JDKpeF1kpepoIPor
 RBLbaEZsqIZqsmaEVGLh3I+aJmxv+0ZV2hywbarJs1XisnhphxJCqS4CIs9Itm5AhsaR
 Z17n3sdb+1vBcF45tVDDOShXIxdnzac9pL5BVGnlHLI7whss4QaVg2RIYZZ3sMkNZGHi
 GyfFN4n282/KXtU098rTr+WSU/a8OT9+foxBqV9IZaEE0daTLaBE2JwUgWi+w6weoPoz
 6UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517673; x=1729122473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rh4iSF4JcVdFm8rItOAee3jMjOlBonh6C/ENTJRWd4=;
 b=ghWjvIrO7Gu8HrcyawpcPE7bm+JvAnkYIOb9wQ89lGzVzxkMe4yvobXZO0nAvZ8WGB
 AWucE16SjV2r4Snu5B7YE9V7ZimyRM57uYwIJcQ5k+YGWcePtGPMkMVOWankkxANbvKp
 i/KaVvIjyJ/iQlDKEBqpdWvUGwNZSYQ5PQz5+OO8vhLykBBuwV/Lfap5YGayGXh1jYOg
 frgA+3jsGS0WHOKqtUqblAoblFBjGKVfw5EUECAHj/hTHbvEu678TVyxpLi2kTA5gvan
 7pLWNMPn9lOMEGThAzNzTTVBf1arJQKiuOyxQdqeaiF4yVxc4Ivb4olbK1Yk0rS5ORJ5
 /bDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW65bbESjdQ6xPDMjpd9ZT6OpdfL3EH6oWqJczEU7QuQSU2Z7WAJjQx658869rpEU08+LJkZWFi+NKW@nongnu.org
X-Gm-Message-State: AOJu0YxssSXrAzd65LompWbg7Eaesx4mRtUG2aW1y+YXyvYH96rJR4K9
 CLKrhWDCBHrVlgUs8eze7lkpq+ehi0654TXXdh28Z+rIrX1sxVYhnmSrj65JeDI=
X-Google-Smtp-Source: AGHT+IEKMgMaN1oKXDZ4B5dJ1c1frQ5fvuc7hbHG52TAHGsxjFdHYK8kyaf5doskNvebH6Lll4Mp2g==
X-Received: by 2002:a05:6214:2e44:b0:6cb:bf0d:a56d with SMTP id
 6a1803df08f44-6cbe521e0a9mr23184856d6.10.1728517673028; 
 Wed, 09 Oct 2024 16:47:53 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.47.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:47:52 -0700 (PDT)
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
Subject: [PATCH v6 08/12] migration/multifd: Add new migration option for
 multifd DSA offloading.
Date: Wed,  9 Oct 2024 16:46:06 -0700
Message-Id: <20241009234610.27039-9-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2c.google.com
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

Intel DSA offloading is an optional feature that turns on if
proper hardware and software stack is available. To turn on
DSA offloading in multifd live migration by setting:

zero-page-detection=dsa-accel
dsa-accel-path=[dsa_dev_path1] [dsa_dev_path2] ... [dsa_dev_pathX]

This feature is turned off by default.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 hmp-commands.hx                |  2 +-
 include/qemu/dsa.h             | 13 +++++++++++++
 migration/migration-hmp-cmds.c | 19 ++++++++++++++++++-
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 32 ++++++++++++++++++++++++++++----
 util/dsa.c                     | 31 +++++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0afc..0e04eac7c7 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1009,7 +1009,7 @@ ERST
 
     {
         .name       = "migrate_set_parameter",
-        .args_type  = "parameter:s,value:s",
+        .args_type  = "parameter:s,value:S",
         .params     = "parameter value",
         .help       = "Set the parameter for migration",
         .cmd        = hmp_migrate_set_parameter,
diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index a3b502ee41..b1bb6daad2 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -100,6 +100,13 @@ void qemu_dsa_stop(void);
  */
 void qemu_dsa_cleanup(void);
 
+/**
+ * @brief Check if DSA is supported.
+ *
+ * @return True if DSA is supported, otherwise false.
+ */
+bool qemu_dsa_is_supported(void);
+
 /**
  * @brief Check if DSA is running.
  *
@@ -141,6 +148,12 @@ buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
 
 typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
 
+static inline bool qemu_dsa_is_supported(void)
+{
+    return false;
+}
+
+
 static inline bool qemu_dsa_is_running(void)
 {
     return false;
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 20d1a6e219..983f13b73c 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -312,7 +312,16 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
-
+        if (params->has_dsa_accel_path) {
+            strList *dsa_accel_path = params->dsa_accel_path;
+            monitor_printf(mon, "%s:",
+                MigrationParameter_str(MIGRATION_PARAMETER_DSA_ACCEL_PATH));
+            while (dsa_accel_path) {
+                monitor_printf(mon, " '%s'", dsa_accel_path->value);
+                dsa_accel_path = dsa_accel_path->next;
+            }
+            monitor_printf(mon, "\n");
+        }
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
 
@@ -563,6 +572,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_checkpoint_delay = true;
         visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
         break;
+    case MIGRATION_PARAMETER_DSA_ACCEL_PATH:
+        p->has_dsa_accel_path = true;
+        g_autofree char **strv = g_strsplit(valuestr ? : "", " ", -1);
+        strList **tail = &p->dsa_accel_path;
+        for (int i = 0; strv[i]; i++) {
+            QAPI_LIST_APPEND(tail, strv[i]);
+        }
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/options.c b/migration/options.c
index 147cd2b8fd..a0b3a7d291 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/dsa.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -832,6 +833,13 @@ const char *migrate_tls_creds(void)
     return s->parameters.tls_creds;
 }
 
+const strList *migrate_dsa_accel_path(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.dsa_accel_path;
+}
+
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
@@ -945,6 +953,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->has_dsa_accel_path = true;
+    params->dsa_accel_path = QAPI_CLONE(strList, s->parameters.dsa_accel_path);
 
     return params;
 }
@@ -953,6 +963,7 @@ void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->dsa_accel_path = NULL;
 
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
@@ -1165,6 +1176,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_zero_page_detection &&
+        params->zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
+        if (!qemu_dsa_is_supported()) {
+            error_setg(errp, "DSA acceleration is not supported.");
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -1278,6 +1297,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->has_dsa_accel_path) {
+        dest->has_dsa_accel_path = true;
+        dest->dsa_accel_path = params->dsa_accel_path;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1410,6 +1434,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_direct_io) {
         s->parameters.direct_io = params->direct_io;
     }
+    if (params->has_dsa_accel_path) {
+        qapi_free_strList(s->parameters.dsa_accel_path);
+        s->parameters.has_dsa_accel_path = true;
+        s->parameters.dsa_accel_path =
+            QAPI_CLONE(strList, params->dsa_accel_path);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index a0bd6edc06..8198b220bd 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -86,6 +86,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+const strList *migrate_dsa_accel_path(void);
 
 /* parameters helpers */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index b66cccf107..d8b42ceae6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -626,10 +626,14 @@
 #     multifd migration is enabled, else in the main migration thread
 #     as for @legacy.
 #
+# @dsa-accel: Perform zero page checking with the DSA accelerator
+#     offloading in multifd sender thread if multifd migration is
+#     enabled, else in the main migration thread as for @legacy.
+#
 # Since: 9.0
 ##
 { 'enum': 'ZeroPageDetection',
-  'data': [ 'none', 'legacy', 'multifd' ] }
+  'data': [ 'none', 'legacy', 'multifd', 'dsa-accel' ] }
 
 ##
 # @BitmapMigrationBitmapAliasTransform:
@@ -837,6 +841,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @dsa-accel-path: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator for zero
+#     page detection offloading by setting the @zero-page-detection
+#     to dsa-accel. This parameter defines the dsa device path, and
+#     defaults to an empty list.  (Since 9.2)
+#
 # @direct-io: Open migration files with O_DIRECT when possible.  This
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
@@ -855,7 +865,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
+           'avail-switchover-bandwidth', 'downtime-limit', 'dsa-accel-path',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
@@ -1018,6 +1028,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @dsa-accel-path: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator for zero
+#     page detection offloading by setting the @zero-page-detection
+#     to dsa-accel. This parameter defines the dsa device path, and
+#     defaults to an empty list.  (Since 9.2)
+#
 # @direct-io: Open migration files with O_DIRECT when possible.  This
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
@@ -1063,7 +1079,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*dsa-accel-path': [ 'str' ] } }
 
 ##
 # @migrate-set-parameters:
@@ -1228,6 +1245,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @dsa-accel-path: If enabled, use DSA accelerator offloading for
+#     certain memory operations. Enable DSA accelerator for zero
+#     page detection offloading by setting the @zero-page-detection
+#     to dsa-accel. This parameter defines the dsa device path, and
+#     defaults to an empty list.  (Since 9.2)
+#
 # @direct-io: Open migration files with O_DIRECT when possible.  This
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
@@ -1270,7 +1293,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*dsa-accel-path': [ 'str' ] } }
 
 ##
 # @query-migrate-parameters:
diff --git a/util/dsa.c b/util/dsa.c
index cbaa47c360..eeede3c0c7 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -23,6 +23,7 @@
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
+#include <cpuid.h>
 
 #pragma GCC push_options
 #pragma GCC target("enqcmd")
@@ -691,6 +692,36 @@ static void dsa_completion_thread_stop(void *opaque)
     qemu_sem_destroy(&thread_context->sem_init_done);
 }
 
+/**
+ * @brief Check if DSA is supported.
+ *
+ * @return True if DSA is supported, otherwise false.
+ */
+bool qemu_dsa_is_supported(void)
+{
+    /*
+     * movdir64b is indicated by bit 28 of ecx in CPUID leaf 7, subleaf 0.
+     * enqcmd is indicated by bit 29 of ecx in CPUID leaf 7, subleaf 0.
+     * Doc: https://cdrdv2-public.intel.com/819680/architecture-instruction-\
+     *      set-extensions-programming-reference.pdf
+     */
+    uint32_t eax, ebx, ecx, edx;
+    bool movedirb_enabled;
+    bool enqcmd_enabled;
+
+    __get_cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
+    movedirb_enabled = (ecx >> 28) & 0x1;
+    if (!movedirb_enabled) {
+        return false;
+    }
+    enqcmd_enabled = (ecx >> 29) & 0x1;
+    if (!enqcmd_enabled) {
+        return false;
+    }
+
+    return true;
+}
+
 /**
  * @brief Check if DSA is running.
  *
-- 
Yichen Wang


