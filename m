Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA83AECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfLD-00018R-RL; Mon, 09 Sep 2024 10:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLC-00011H-10
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:06 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLA-0004Tq-1H
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:05 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7cd8d2731d1so2959409a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891962; x=1726496762;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLPpduPp6Uoo3uoV/VinR4B0oEyxm97ZfJYte9O4FBw=;
 b=oDBxL4LjzODSBDdYoQLCrUfP0ioGD3R4iLTJUCLRIzwL+/wC5Z2bpeixePzWEbbxcA
 QZGBGgiop8DiYqcvdHRJn2u4sMCO6V8rkYppg8RqM6EC6aukVEMWVxp0jGBJyh/paCXG
 duv7g2LKOG9Lr+33uStaspd7MGF77yxfDa3eJZPWYEHE9Zf0/Ma49Ico5++m9+B3Tkz9
 tunZPN49zvAfZ9C2Dk+OquACAhRhDqP+OIMluw5LiUIUAhJfNLXt/DKDLx3M96qYyyOj
 4wuJGufFP4P2EdDS+gpzZd82k+CksqykC6sQIfUMCJUIdr04uZ+ofz944wUqhW43sbcC
 Pgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891962; x=1726496762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLPpduPp6Uoo3uoV/VinR4B0oEyxm97ZfJYte9O4FBw=;
 b=QvNau0kIT4k48209J0FPOg2cGRShCEfzUyWr9WOZxDZA1WXYrOP9coppM6+JLLCxpQ
 O2S6Y1tum2QXS5MVEhI7kmO6jQrZ3TsVsOVzDWnzU9oTQOEYEX2wOqF22iPgTwGhcVbB
 4ToWxsnckyN3bp794VpBxEN7qhuun2IsZ52O215dBCZ2C/wEjFWj0EKyemfVvQzCJBpZ
 S6cd79iq+fnyx6K6RUtaYu3PokJ4KewEjs5WKhAmiO3WmhGLN5ZtePD1L81+YcmVPnJs
 3nbGMKCUTRfDmU+gmgbxdGqlZXclXpoCYqFBRaJmrK7SXcHnOiqYEuN0JHXRexoN5fZQ
 YkPA==
X-Gm-Message-State: AOJu0Yxa9JXgD6F9PHhgJQbuxz23wS2AKhwR7kfB9/skvWu09mbhaKWA
 qYThk/Ip3lACskPvIvL0r0JGHDhFwrbYHx9SUiLXWNSc2RWdsZgpfOaKHfz/UId5jQgbwL+wMRZ
 46dmh+g==
X-Google-Smtp-Source: AGHT+IHQjcSyCU3TNl5IMUggJXSSC14PnBXkU4skGSVoyXB2YrF93iI4EvKwqafNN3iXCCXRwU1f9A==
X-Received: by 2002:a05:6a21:6e4a:b0:1cf:440a:d449 with SMTP id
 adf61e73a8af0-1cf440ad611mr1789675637.42.1725891961885; 
 Mon, 09 Sep 2024 07:26:01 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:26:01 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 03/10] qapi/migration: Introduce periodic CPU
 throttling parameters
Date: Mon,  9 Sep 2024 22:25:36 +0800
Message-Id: <0bbcdfd86f35830e0a398220663aac5afd8b7e1e.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

To activate the periodic CPU throttleing feature, introduce
the cpu-periodic-throttle.

To control the frequency of throttling, introduce the
cpu-periodic-throttle-interval.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration-hmp-cmds.c | 17 +++++++++++
 migration/options.c            | 54 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  2 ++
 qapi/migration.json            | 25 +++++++++++++++-
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7d608d26e1..f7b8e06bb4 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -264,6 +264,15 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
             params->cpu_throttle_tailslow ? "on" : "off");
+        assert(params->has_cpu_periodic_throttle);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_CPU_PERIODIC_THROTTLE),
+            params->cpu_periodic_throttle ? "on" : "off");
+        assert(params->has_cpu_periodic_throttle_interval);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(
+                MIGRATION_PARAMETER_CPU_PERIODIC_THROTTLE_INTERVAL),
+            params->cpu_periodic_throttle_interval);
         assert(params->has_max_cpu_throttle);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
@@ -512,6 +521,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_cpu_throttle_tailslow = true;
         visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
         break;
+    case MIGRATION_PARAMETER_CPU_PERIODIC_THROTTLE:
+        p->has_cpu_periodic_throttle = true;
+        visit_type_bool(v, param, &p->cpu_periodic_throttle, &err);
+        break;
+    case MIGRATION_PARAMETER_CPU_PERIODIC_THROTTLE_INTERVAL:
+        p->has_cpu_periodic_throttle_interval = true;
+        visit_type_uint8(v, param, &p->cpu_periodic_throttle_interval, &err);
+        break;
     case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
         p->has_max_cpu_throttle = true;
         visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
diff --git a/migration/options.c b/migration/options.c
index 645f55003d..2dbe275ba0 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -44,6 +44,7 @@
 #define DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD 50
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT 10
+#define DEFAULT_MIGRATE_CPU_PERIODIC_THROTTLE_INTERVAL 5
 #define DEFAULT_MIGRATE_MAX_CPU_THROTTLE 99
 
 /* Migration XBZRLE default cache size */
@@ -104,6 +105,11 @@ Property migration_properties[] = {
                       DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
     DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
                       parameters.cpu_throttle_tailslow, false),
+    DEFINE_PROP_BOOL("x-cpu-periodic-throttle", MigrationState,
+                      parameters.cpu_periodic_throttle, false),
+    DEFINE_PROP_UINT8("x-cpu-periodic-throttle-interval", MigrationState,
+                      parameters.cpu_periodic_throttle_interval,
+                      DEFAULT_MIGRATE_CPU_PERIODIC_THROTTLE_INTERVAL),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
     DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
@@ -695,6 +701,20 @@ uint8_t migrate_cpu_throttle_initial(void)
     return s->parameters.cpu_throttle_initial;
 }
 
+uint8_t migrate_periodic_throttle_interval(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.cpu_periodic_throttle_interval;
+}
+
+bool migrate_periodic_throttle(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.cpu_periodic_throttle;
+}
+
 bool migrate_cpu_throttle_tailslow(void)
 {
     MigrationState *s = migrate_get_current();
@@ -874,6 +894,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
+    params->has_cpu_periodic_throttle = true;
+    params->cpu_periodic_throttle = s->parameters.cpu_periodic_throttle;
+    params->has_cpu_periodic_throttle_interval = true;
+    params->cpu_periodic_throttle_interval =
+        s->parameters.cpu_periodic_throttle_interval;
     params->tls_creds = g_strdup(s->parameters.tls_creds);
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
     params->tls_authz = g_strdup(s->parameters.tls_authz ?
@@ -940,6 +965,8 @@ void migrate_params_init(MigrationParameters *params)
     params->has_cpu_throttle_initial = true;
     params->has_cpu_throttle_increment = true;
     params->has_cpu_throttle_tailslow = true;
+    params->has_cpu_periodic_throttle = true;
+    params->has_cpu_periodic_throttle_interval = true;
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
@@ -996,6 +1023,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (params->has_cpu_periodic_throttle_interval &&
+        (params->cpu_periodic_throttle_interval < 2 ||
+         params->cpu_periodic_throttle_interval > 10)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "cpu_periodic_throttle_interval",
+                   "an integer in the range of 2 to 10");
+        return false;
+    }
+
     if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "max_bandwidth",
@@ -1163,6 +1199,15 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
     }
 
+    if (params->has_cpu_periodic_throttle) {
+        dest->cpu_periodic_throttle = params->cpu_periodic_throttle;
+    }
+
+    if (params->has_cpu_periodic_throttle_interval) {
+        dest->cpu_periodic_throttle_interval =
+            params->cpu_periodic_throttle_interval;
+    }
+
     if (params->tls_creds) {
         assert(params->tls_creds->type == QTYPE_QSTRING);
         dest->tls_creds = params->tls_creds->u.s;
@@ -1271,6 +1316,15 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
     }
 
+    if (params->has_cpu_periodic_throttle) {
+        s->parameters.cpu_periodic_throttle = params->cpu_periodic_throttle;
+    }
+
+    if (params->has_cpu_periodic_throttle_interval) {
+        s->parameters.cpu_periodic_throttle_interval =
+            params->cpu_periodic_throttle_interval;
+    }
+
     if (params->tls_creds) {
         g_free(s->parameters.tls_creds);
         assert(params->tls_creds->type == QTYPE_QSTRING);
diff --git a/migration/options.h b/migration/options.h
index a2397026db..efeac01470 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -68,6 +68,8 @@ bool migrate_has_block_bitmap_mapping(void);
 uint32_t migrate_checkpoint_delay(void);
 uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
+uint8_t migrate_periodic_throttle_interval(void);
+bool migrate_periodic_throttle(void);
 bool migrate_cpu_throttle_tailslow(void);
 bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 7324571e92..8281d4a83b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -724,6 +724,12 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-periodic-throttle: Make CPU throttling periodically.
+#     (Since 9.1)
+#
+# @cpu-periodic-throttle-interval: Interval of the periodic CPU throttling.
+#     (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -844,7 +850,8 @@
            'announce-rounds', 'announce-step',
            'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
-           'cpu-throttle-tailslow',
+           'cpu-throttle-tailslow', 'cpu-periodic-throttle',
+           'cpu-periodic-throttle-interval',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
@@ -899,6 +906,12 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-periodic-throttle: Make CPU throttling periodically.
+#     (Since 9.1)
+#
+# @cpu-periodic-throttle-interval: Interval of the periodic CPU throttling.
+#     (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1026,6 +1039,8 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
+            '*cpu-periodic-throttle': 'bool',
+            '*cpu-periodic-throttle-interval': 'uint8',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
@@ -1107,6 +1122,12 @@
 #     be excessive at tail stage.  The default value is false.  (Since
 #     5.1)
 #
+# @cpu-periodic-throttle: Make CPU throttling periodically.
+#     (Since 9.1)
+#
+# @cpu-periodic-throttle-interval: Interval of the periodic CPU throttling.
+#     (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1227,6 +1248,8 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
+            '*cpu-periodic-throttle': 'bool',
+            '*cpu-periodic-throttle-interval': 'uint8',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
             '*tls-authz': 'str',
-- 
2.39.1


