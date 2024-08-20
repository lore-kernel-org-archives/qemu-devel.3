Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7BBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSMQ-0006hj-Ow; Tue, 20 Aug 2024 13:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMG-00065u-HB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:24 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSME-0007hR-D8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:24 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5dc93fa5639so546216eaf.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724173761; x=1724778561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2FNfKDzMZxfg4pOzrkj4+uW04/Ixn8FgpzoQ4+CoKU=;
 b=E7gjH17Rb71UR+IY1EcIbjgZN1+zXr4btX8B7jIa2/gVfxVuJkz/m2Kl4c/3xNScUg
 EtXdi23u4U7vi21cjkf16VsZNi2IKg3nQm2vX10+qsKLW4Ucv6pSJcNP2Icx2mp8suS6
 tKvqggkzxSk9tzwus5o4F3o/XGSQFn5mikGMRRVsCSU4RmYzo3kUtFftsKTYLPoJH2jj
 4dj9LBA4xRI+kfwAR8X/bPi2yPF3V247nuWTvu3G1ZDpQU6CtSl0TKKpesgBRPPXhhy8
 OF21vnLaYFw+Ul61177UGjmX0JktYlVuFuOYBWehwIR9d2f2JrR1yPs2Ch9BtyZvWphD
 dhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724173761; x=1724778561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2FNfKDzMZxfg4pOzrkj4+uW04/Ixn8FgpzoQ4+CoKU=;
 b=n0NV4pCPOnYJO6Fqo4ioksmrGr07HqX7+oXdUjoS4nnzVRTieem8faly0FtUOCwxa7
 27xhVAJ4aytVmhgD0NEnGCdD8hMvlFQVLLCfDRYEwMT0SZG1ItOTmFwGjN+995kDVRd4
 jFHnFDMhY1iHbSAPCRGHEzhHmN/XdTwTBq5Bcuh+PtrlcdA4mD1/lKOC6DedkV69HMt2
 95zrELnsooXhn+b8BK+N49UhWjXMvI5XLZynsSQEwA8rMri3ivfByUt7lXHShpZK3Lqi
 aUxvTyjTlJUy7VgRPmnbloeY1G0wpK31CqlCocpfKfCe5jJI4acQJDODdHe0gUpMDUp8
 sqzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJVPJ0MT0FVjnOXhbra2GGez63G5tm4mjYlQsEektvJWVIIB4Ud1w8JFlDb+bgu2uJpbVMBVOyEO6+@nongnu.org
X-Gm-Message-State: AOJu0YyHwh+s9xrl+f524+Bp/9r8Ma5QSN5Oo8WGAUFPrHM0gho1jNE7
 WnJWRQEksUR+u3GyXvo4F570INDPXqB6UlSIKcSRaJfT7MrTuyzuhaUGNY2HZVI=
X-Google-Smtp-Source: AGHT+IF3WjjNerTUoexoLvBeoWzAchG2CgTW5Y0MWQ7oMMcUiPtKqyoYlHy/qo7yzN34+Zb9Y+lRdA==
X-Received: by 2002:a05:6820:622:b0:5da:a830:482a with SMTP id
 006d021491bc7-5dca066f025mr6458eaf.7.1724173760824; 
 Tue, 20 Aug 2024 10:09:20 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fef2372sm53599576d6.114.2024.08.20.10.09.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Aug 2024 10:09:20 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 "Xiaoning Ding" <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v8 3/5] migration: Add migration parameters for QATzip
Date: Tue, 20 Aug 2024 10:09:05 -0700
Message-Id: <20240820170907.6788-4-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240820170907.6788-1-yichen.wang@bytedance.com>
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds support for migration parameters to control QATzip compression
level and to enable/disable software fallback when QAT hardware is
unavailable. This is a preparatory commit for a subsequent commit that
will actually use QATzip compression.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  4 ++++
 migration/options.c            | 34 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 18 ++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7d608d26e1..28165cfc9e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -576,6 +576,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_multifd_zlib_level = true;
         visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
+        p->has_multifd_qatzip_level = true;
+        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
         p->has_multifd_zstd_level = true;
         visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
diff --git a/migration/options.c b/migration/options.c
index 645f55003d..147cd2b8fd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -55,6 +55,13 @@
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
+/*
+ * 1: best speed, ... 9: best compress ratio
+ * There is some nuance here. Refer to QATzip documentation to understand
+ * the mapping of QATzip levels to standard deflate levels.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
+
 /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
 #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
 
@@ -123,6 +130,9 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
                       parameters.multifd_zlib_level,
                       DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
+    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
+                      parameters.multifd_qatzip_level,
+                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
     DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
                       parameters.multifd_zstd_level,
                       DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
@@ -787,6 +797,13 @@ int migrate_multifd_zlib_level(void)
     return s->parameters.multifd_zlib_level;
 }
 
+int migrate_multifd_qatzip_level(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_qatzip_level;
+}
+
 int migrate_multifd_zstd_level(void)
 {
     MigrationState *s = migrate_get_current();
@@ -892,6 +909,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->multifd_compression = s->parameters.multifd_compression;
     params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
+    params->has_multifd_qatzip_level = true;
+    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
     params->has_multifd_zstd_level = true;
     params->multifd_zstd_level = s->parameters.multifd_zstd_level;
     params->has_xbzrle_cache_size = true;
@@ -946,6 +965,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
+    params->has_multifd_qatzip_level = true;
     params->has_multifd_zstd_level = true;
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
@@ -1038,6 +1058,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_multifd_qatzip_level &&
+        ((params->multifd_qatzip_level > 9) ||
+        (params->multifd_qatzip_level < 1))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
+                   "a value between 1 and 9");
+        return false;
+    }
+
     if (params->has_multifd_zstd_level &&
         (params->multifd_zstd_level > 20)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
@@ -1195,6 +1223,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_qatzip_level) {
+        dest->multifd_qatzip_level = params->multifd_qatzip_level;
+    }
     if (params->has_multifd_zlib_level) {
         dest->multifd_zlib_level = params->multifd_zlib_level;
     }
@@ -1315,6 +1346,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_qatzip_level) {
+        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
+    }
     if (params->has_multifd_zlib_level) {
         s->parameters.multifd_zlib_level = params->multifd_zlib_level;
     }
diff --git a/migration/options.h b/migration/options.h
index a2397026db..a0bd6edc06 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -78,6 +78,7 @@ uint64_t migrate_max_postcopy_bandwidth(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
+int migrate_multifd_qatzip_level(void);
 int migrate_multifd_zstd_level(void);
 uint8_t migrate_throttle_trigger_threshold(void);
 const char *migrate_tls_authz(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 7324571e92..f4c27426c8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -792,6 +792,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -852,6 +857,7 @@
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level', 'multifd-zstd-level',
+           'multifd-qatzip-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
@@ -967,6 +973,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1040,6 +1051,7 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
@@ -1171,6 +1183,11 @@
 #     speed, and 9 means best compression ratio which will consume
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
+# @multifd-qatzip-level: Set the compression level to be used in live
+#     migration. The level is an integer between 1 and 9, where 1 means
+#     the best compression speed, and 9 means the best compression
+#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
@@ -1241,6 +1258,7 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
+            '*multifd-qatzip-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-- 
Yichen Wang


