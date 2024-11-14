Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADB4D6A249
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBhul-0003Qe-0p; Thu, 14 Nov 2024 17:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhue-0003Q2-JU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:02:05 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuc-0007ff-2t
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:02:04 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b148919e82so6585485a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1731621721; x=1732226521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKamMVfAYEStZ//LZHWWiAwcDZtZMVRd0IMX0qbphsU=;
 b=B4qYGS69GJsJQVbxTN7y8FC3rr5T83JolAd+cohw/QC/I4Noqq9MYKl6NrqCVaGjR0
 Bski4FPaC5lNIVRZoak78TAbxfEyTzMYTvAbl+QGgtsF1+4jQ7O5e1l002id17+z0HMN
 S8m76ZUB/hq2+r/eDEbGfCkEcGtKHTNuTASWv4CE6vYK7a3EE1ER2FQa8GY4fkUwGZ6g
 Y8bw7WV3jPYv24xKLHquTsdtlpjs2jo+SJmGVDfOcUUqHmOROwr5CG1kzzz0ruJ8+doY
 xunRX2gP5iAkSxvLJ7uPQYCRdD15K4cissVF32zAD3eLkKNUlHP9GUHjVHiBzO5SBZWr
 fOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731621721; x=1732226521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKamMVfAYEStZ//LZHWWiAwcDZtZMVRd0IMX0qbphsU=;
 b=H8COI9iwQ6S8sD9pv7ZDdRGOPsqWuHqz0z1+swhi/UgGBJ98aGchZ38ovhfO0B8y7w
 XsLVIoMueDsn++VQZXfxonzFaWIkTCFFbTZVcWo29PIim/4qYWvSa9t8ZCWj7w+E26Hm
 8rq+lnIep4m+BCaypufInbtX/dAzVTxpTWy2t4ValGBfz7kJh4q3dREj/0zEx8PtM/t/
 dddudIvG6gLYooTVaVLKjz/JvyBgcfaI6C+caMTHbYcR2riK890AGRsm5gPwgJ78zejH
 1zuxXgWkYwmos29RDtISGQDHnH/asISyn2gn6N14PySEKJIEomvCT6O925P9PUd0pXcA
 b4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNx6IYIpbUtE5tZRrIB+XZHmnZq4mMLBXdr3ma7L8x5+h08Wf+box0OtZ5g1X7k1JtZnrArgljYB6@nongnu.org
X-Gm-Message-State: AOJu0YyeYIfy7PoVhjw3HvB9bZy/aqpdo8MqQmS357JcOm89HwVvf+xr
 1LMSMQ19q+E+h+5/mRGNa4X7qfT9w/4jHmFOtaFYhphwORiqMgzr/RtRUyvFit8=
X-Google-Smtp-Source: AGHT+IHSe9Mzcgu4+AaEwcNdD7+Dt8lHnPvUC3jqOc0g0uWA+uGjS4Rk3SNDz5C8CRPG5pQRudah3Q==
X-Received: by 2002:a05:620a:3f85:b0:7a9:aae5:331 with SMTP id
 af79cd13be357-7b3622b96a4mr81000585a.21.1731621720572; 
 Thu, 14 Nov 2024 14:02:00 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net ([130.44.212.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca308bdsm93742485a.83.2024.11.14.14.01.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 14:02:00 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v7 08/12] migration/multifd: Add new migration option for
 multifd DSA offloading.
Date: Thu, 14 Nov 2024 14:01:28 -0800
Message-Id: <20241114220132.27399-9-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114220132.27399-1-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x72b.google.com
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
dsa-accel-path="dsa:<dsa_dev_path1> dsa:[dsa_dev_path2] ..."

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
index 8284804a32..258860bd20 100644
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
index 20d1a6e219..01c528b80a 100644
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
 
@@ -563,6 +572,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_checkpoint_delay = true;
         visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
         break;
+    case MIGRATION_PARAMETER_ACCEL_PATH:
+        p->has_accel_path = true;
+        g_autofree char **strv = g_strsplit(valuestr ? : "", " ", -1);
+        strList **tail = &p->accel_path;
+        for (int i = 0; strv[i]; i++) {
+            QAPI_LIST_APPEND(tail, strv[i]);
+        }
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a8..ca89fdc4f4 100644
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
index 79084eed0d..3d1e91dc52 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -84,6 +84,7 @@ const char *migrate_tls_creds(void);
 const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
+const strList *migrate_accel_path(void);
 
 /* parameters helpers */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index a605dc26db..389776065d 100644
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
+#     This parameter is default to an empty list.  (Since 9.2)
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
+#     This parameter is default to an empty list.  (Since 9.2)
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
+#     This parameter is default to an empty list.  (Since 9.2)
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
index 50f53ec24b..18ed36e354 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -23,6 +23,7 @@
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
+#include <cpuid.h>
 
 #pragma GCC push_options
 #pragma GCC target("enqcmd")
@@ -689,6 +690,36 @@ static void dsa_completion_thread_stop(void *opaque)
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


