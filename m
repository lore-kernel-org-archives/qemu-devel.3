Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C85E7718D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 01:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQFki-0001Uj-2f; Tue, 24 Dec 2024 19:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkd-0001Tc-9R
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:52 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkb-0000Pg-5Y
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:51 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso79634216d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 16:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735088388; x=1735693188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upM+cjemWcaNph2ST/TlynQVO4tS3ztYu3BsZHDmLAQ=;
 b=W7WfylZnEdvVqUBlVTuB1URKgfspmajeGf1spaB7wEye49kpnu03PQeB84MckYB6Hb
 6slocQ/bYhcEBzIJrhHL6c+RTbe2qXrQbhdpJoaxCaRr1NS4rv7ZtxOWk0HMCXqfVkOv
 bYRbmAbdw6jrsA6DrgBnwPm1EDQNjICylcbiwBhbgk1QgYPG/PoDiTxpTHSj0hhc3YiQ
 tHh5G80T+p44ZgJQ1lPYa+ZtTtU1hVWNHsKUumM7aEIw3LsSdgd+BaxBI8x8jm/SZ/GJ
 r81z4h7+dQHAlAwVqKMxQT2lfnHazA7gvThqjea/XMcXIgLMP5IY6KjshWZJMJtC7gd2
 6oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735088388; x=1735693188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upM+cjemWcaNph2ST/TlynQVO4tS3ztYu3BsZHDmLAQ=;
 b=QwxdohXrtmSYtFr1FuEw9CYbL9oyLTYMHpL6+z33J8s7JYV/0zeKTPIEXZBh/yz72X
 DUH4Gebj0p8cy4VcmvRs9+qpSnWTm8c07JE292cd1YHvJj9piTh22ZicTsxP4pF+W7vU
 66AUQlHHvZZdvieB5OQeAZa937y6DQkP/TBfzO6DOJSFwHwTmm+I/TKHdoyhBYcYfvB+
 0vPL0j1QrkDiXoPUo20WiyFzSKP9+kmaHeL2cxLexmY2hZavy0M5qO2wQyNpo7Z08KI6
 JCOkrhp6wYoTQaKOSgbdsWSsPcVVYiOMs6eY1QjuFlNI+ebmK6w3YxRzvN6nsXZ2Ty5j
 XcYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbd4/Y393vyRVcvTNvJDufNwef/N57yda+BPJK/yFG8TdPYVI9V+K3FlYHcimrZ+Rkynlj/c+yW2GE@nongnu.org
X-Gm-Message-State: AOJu0YzAfMdyFi2RKwMOk4jqIF21Z0SqHiLXg6V95XywSfCSS2AIXobb
 cA19Nk+64S8FAZGmBKw/BTzAHj8akMqEhibZTYuAzqEJoz6ymBWFbcbLLSuqzfg=
X-Gm-Gg: ASbGnct7O/WuYXIOyS5V4Ywa1poFugqrE5CnHVSY7wRLCYJK70mXEi19SLeqF/dqe48
 L0lxLkYoWKKhOosny+0zMCwMgIu77cOky7aU3n5g7LQMl3Xero1IDaGDdByhqGDi+9DADaqoSPT
 fmbKvzUhICs3DJ0kQ1uaf4LMcKlDfGjG57hbngAIKzNH7tSWklUNilt54ep/sBH4Or7NPMPXq2N
 EGOQV4mUsI9zdInQHQSgMxvJtrYz5sRZ2NTFLWN446SI3LNwHLxM7tOEr93iuJ7S2efXZfV8vHu
 7E+sa83CJ2rHxRM8LRBaowHRkQ==
X-Google-Smtp-Source: AGHT+IHCmrf7R8NNd99Psh/m/hD3iaIa1ibmD+v+bvrI8E+NpDQbzDiLHl9+V51aivRYKkcHU6YM+g==
X-Received: by 2002:a05:6214:1316:b0:6d8:87cc:73a5 with SMTP id
 6a1803df08f44-6dd2338d1demr359340956d6.38.1735088388199; 
 Tue, 24 Dec 2024 16:59:48 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:1799:4ca4:2dd7:ba38:ecbd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm57318206d6.98.2024.12.24.16.59.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 16:59:47 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v9 08/12] migration/multifd: Add new migration option for
 multifd DSA offloading.
Date: Tue, 24 Dec 2024 16:59:15 -0800
Message-Id: <20241225005919.26853-9-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241225005919.26853-1-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf33.google.com
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
accel-path="dsa:<dsa_dev_path1> dsa:[dsa_dev_path2] ..."

This feature is turned off by default.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hmp-commands.hx                |  2 +-
 include/qemu/dsa.h             | 13 +++++++++++++
 migration/migration-hmp-cmds.c | 20 +++++++++++++++++++-
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 32 ++++++++++++++++++++++++++++----
 util/dsa.c                     | 31 +++++++++++++++++++++++++++++++
 7 files changed, 123 insertions(+), 6 deletions(-)

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
index 4972332bdf..18cb1df223 100644
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
index e8527bef80..6c7264128b 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -312,7 +312,16 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
-
+        if (params->has_accel_path) {
+            strList *accel_path = params->accel_path;
+            monitor_printf(mon, "%s:",
+                MigrationParameter_str(MIGRATION_PARAMETER_ACCEL_PATH));
+            while (accel_path) {
+                monitor_printf(mon, " '%s'", accel_path->value);
+                accel_path = accel_path->next;
+            }
+            monitor_printf(mon, "\n");
+        }
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
 
@@ -563,6 +572,15 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_checkpoint_delay = true;
         visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
         break;
+    case MIGRATION_PARAMETER_ACCEL_PATH:
+        p->has_accel_path = true;
+        char **strv = g_strsplit(valuestr ? : "", " ", -1);
+        strList **tail = &p->accel_path;
+        for (int i = 0; strv[i]; i++) {
+            QAPI_LIST_APPEND(tail, g_strdup(strv[i]));
+        }
+        g_strfreev(strv);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/options.c b/migration/options.c
index b8d5300326..68547b358b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/dsa.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -809,6 +810,13 @@ const char *migrate_tls_creds(void)
     return s->parameters.tls_creds;
 }
 
+const strList *migrate_accel_path(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.accel_path;
+}
+
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
@@ -922,6 +930,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->has_accel_path = true;
+    params->accel_path = QAPI_CLONE(strList, s->parameters.accel_path);
 
     return params;
 }
@@ -930,6 +940,7 @@ void migrate_params_init(MigrationParameters *params)
 {
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->accel_path = NULL;
 
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
@@ -1142,6 +1153,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
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
 
@@ -1255,6 +1274,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->has_accel_path) {
+        dest->has_accel_path = true;
+        dest->accel_path = params->accel_path;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1387,6 +1411,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_direct_io) {
         s->parameters.direct_io = params->direct_io;
     }
+    if (params->has_accel_path) {
+        qapi_free_strList(s->parameters.accel_path);
+        s->parameters.has_accel_path = true;
+        s->parameters.accel_path =
+            QAPI_CLONE(strList, params->accel_path);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 762be4e641..c994b04cb6 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -85,6 +85,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+const strList *migrate_accel_path(void);
 
 /* parameters helpers */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index a605dc26db..76a3920e2e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -629,10 +629,14 @@
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
@@ -840,6 +844,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @accel-path: If enabled, specify the accelerator paths that to be
+#     used in QEMU. For example, enable DSA accelerator for zero page
+#     detection offloading by setting the @zero-page-detection to
+#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
+#     This parameter is default to an empty list.  (Since 10.0)
+#
 # @direct-io: Open migration files with O_DIRECT when possible.  This
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
@@ -858,7 +868,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
+           'avail-switchover-bandwidth', 'downtime-limit', 'accel-path',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
@@ -1021,6 +1031,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @accel-path: If enabled, specify the accelerator paths that to be
+#     used in QEMU. For example, enable DSA accelerator for zero page
+#     detection offloading by setting the @zero-page-detection to
+#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
+#     This parameter is default to an empty list.  (Since 10.0)
+#
 # @direct-io: Open migration files with O_DIRECT when possible.  This
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
@@ -1066,7 +1082,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*accel-path': [ 'str' ] } }
 
 ##
 # @migrate-set-parameters:
@@ -1231,6 +1248,12 @@
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
+# @accel-path: If enabled, specify the accelerator paths that to be
+#     used in QEMU. For example, enable DSA accelerator for zero page
+#     detection offloading by setting the @zero-page-detection to
+#     dsa-accel, and defines the accel-path to "dsa:<dsa_device path>".
+#     This parameter is default to an empty list.  (Since 10.0)
+#
 # @direct-io: Open migration files with O_DIRECT when possible.  This
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
@@ -1273,7 +1296,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*accel-path': [ 'str' ] } }
 
 ##
 # @query-migrate-parameters:
diff --git a/util/dsa.c b/util/dsa.c
index 25efff486e..9bc91f3955 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -23,6 +23,7 @@
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
+#include <cpuid.h>
 
 #pragma GCC push_options
 #pragma GCC target("enqcmd")
@@ -687,6 +688,36 @@ static void dsa_completion_thread_stop(void *opaque)
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


