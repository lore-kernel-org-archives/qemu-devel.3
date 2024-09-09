Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5191BECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfLd-0002v4-Hr; Mon, 09 Sep 2024 10:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLW-0002Ny-43
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLS-0004V9-3f
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718e5edf270so1398909b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891980; x=1726496780;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0+VMi25/Zc4CDone71m1lCGybIDfbvM1CcXIqSCA9s=;
 b=kgqMy2o6P9hg56cajR/0/6tHLfs1kvvXRHRqn7p6807DHDVqE0i+w2EePEmTCg2hor
 S7M6+USwF+gPkIAEvd10TDvgD+w7GOPTZwynFNfcVgdqKwyL9f8X0h2SBNcUOmgRvAEF
 OtuqMQQI4KiGPC/NlvPI4p48OI7bFmyioduWx2Mi01p6GNkqETKp5hqak9carTtQk11P
 fK1ATrISqVM2Qi929/I4WkZFhaN25wNGDJhREe/mOv1pT97nOWSAgBn9kohcTh8CKzMw
 sXBOb6SafJ4ohCvevW8e2Ze96q6qsTuN0gLsnUkD+6exelqUVK69kJmnhAaQw9WENLCz
 4rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891980; x=1726496780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0+VMi25/Zc4CDone71m1lCGybIDfbvM1CcXIqSCA9s=;
 b=TUg1cVsULnMt0umSjXFBDkGcuWrszraJ21MUVBz/oStF+UCBs7N0MWA76ECM9lHmJS
 YL+QmR/8nXfcVPe8IZvl8xKdtqt7D8KOF5jqs168nSLPg4QlWq5IQiHn85ARMxheYeP0
 CLG+gt5G/MDJc/8gbnjxTRHZzVHQzJI10/C53Hk35DN/oRBQy5ZqHfwcE0s0tjJiycJ8
 q6xU0L/yT0HRWFTwpsbOWs6ouvtRf76fLpqYoSv5a1Vue5uHiWZ1aWjuXHZVIN0+d1ln
 13VLpPCDwPneWNOuJt+jDTkUJ1VbadqEdSneLk2sjtqMeG7wcB94s49Tzf2Wu0/5za+f
 wcgw==
X-Gm-Message-State: AOJu0YyZkCzlXtE0DBgzDmkla3SzaPksaMcVerUEm+rmFN1TlCamOby4
 xIQIEhYt9K8AbM6L1x/6qyNaFVMqiZkqlvOfX0w9i9MsSoosRNMEmXz438nQTvgWWewZmcJBm53
 2mURkew==
X-Google-Smtp-Source: AGHT+IGCoojGvWBCODJCURzuzS3/b9GX3Mwr7CJ9Lbm4C/uXKI17DKKG4k3pWJcK+ENAhCpR2fZB/w==
X-Received: by 2002:a05:6a00:b42:b0:718:d5fb:2fc4 with SMTP id
 d2e1a72fcca58-718d5fb36c3mr12411604b3a.9.1725891979438; 
 Mon, 09 Sep 2024 07:26:19 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:26:18 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 08/10] migration: Introduce cpu-responsive-throttle
 parameter
Date: Mon,  9 Sep 2024 22:25:41 +0800
Message-Id: <08d77dbc95b8836189bae049e82e790ead6c8535.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x432.google.com
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

To enable the responsive throttle that will be implemented
in the next commit, introduce the cpu-responsive-throttle
parameter.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 20 ++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 16 +++++++++++++++-
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index f7b8e06bb4..a3d4d3f62f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -273,6 +273,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(
                 MIGRATION_PARAMETER_CPU_PERIODIC_THROTTLE_INTERVAL),
             params->cpu_periodic_throttle_interval);
+        assert(params->has_cpu_responsive_throttle);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE),
+            params->cpu_responsive_throttle ? "on" : "off");
         assert(params->has_max_cpu_throttle);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
@@ -529,6 +533,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_cpu_periodic_throttle_interval = true;
         visit_type_uint8(v, param, &p->cpu_periodic_throttle_interval, &err);
         break;
+    case MIGRATION_PARAMETER_CPU_RESPONSIVE_THROTTLE:
+        p->has_cpu_responsive_throttle = true;
+        visit_type_bool(v, param, &p->cpu_responsive_throttle, &err);
+        break;
     case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
         p->has_max_cpu_throttle = true;
         visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
diff --git a/migration/options.c b/migration/options.c
index 2dbe275ba0..aa233684ee 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -110,6 +110,8 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("x-cpu-periodic-throttle-interval", MigrationState,
                       parameters.cpu_periodic_throttle_interval,
                       DEFAULT_MIGRATE_CPU_PERIODIC_THROTTLE_INTERVAL),
+    DEFINE_PROP_BOOL("x-cpu-responsive-throttle", MigrationState,
+                      parameters.cpu_responsive_throttle, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
     DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
@@ -715,6 +717,13 @@ bool migrate_periodic_throttle(void)
     return s->parameters.cpu_periodic_throttle;
 }
 
+bool migrate_responsive_throttle(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.cpu_responsive_throttle;
+}
+
 bool migrate_cpu_throttle_tailslow(void)
 {
     MigrationState *s = migrate_get_current();
@@ -899,6 +908,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_cpu_periodic_throttle_interval = true;
     params->cpu_periodic_throttle_interval =
         s->parameters.cpu_periodic_throttle_interval;
+    params->has_cpu_responsive_throttle = true;
+    params->cpu_responsive_throttle = s->parameters.cpu_responsive_throttle;
     params->tls_creds = g_strdup(s->parameters.tls_creds);
     params->tls_hostname = g_strdup(s->parameters.tls_hostname);
     params->tls_authz = g_strdup(s->parameters.tls_authz ?
@@ -967,6 +978,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_cpu_throttle_tailslow = true;
     params->has_cpu_periodic_throttle = true;
     params->has_cpu_periodic_throttle_interval = true;
+    params->has_cpu_responsive_throttle = true;
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
@@ -1208,6 +1220,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
             params->cpu_periodic_throttle_interval;
     }
 
+    if (params->has_cpu_responsive_throttle) {
+        dest->cpu_responsive_throttle = params->cpu_responsive_throttle;
+    }
+
     if (params->tls_creds) {
         assert(params->tls_creds->type == QTYPE_QSTRING);
         dest->tls_creds = params->tls_creds->u.s;
@@ -1325,6 +1341,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
             params->cpu_periodic_throttle_interval;
     }
 
+    if (params->has_cpu_responsive_throttle) {
+        s->parameters.cpu_responsive_throttle = params->cpu_responsive_throttle;
+    }
+
     if (params->tls_creds) {
         g_free(s->parameters.tls_creds);
         assert(params->tls_creds->type == QTYPE_QSTRING);
diff --git a/migration/options.h b/migration/options.h
index efeac01470..613d675003 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -70,6 +70,7 @@ uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 uint8_t migrate_periodic_throttle_interval(void);
 bool migrate_periodic_throttle(void);
+bool migrate_responsive_throttle(void);
 bool migrate_cpu_throttle_tailslow(void);
 bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 6d8358c202..9f52ed1899 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -734,6 +734,10 @@
 # @cpu-periodic-throttle-interval: Interval of the periodic CPU throttling.
 #     (Since 9.1)
 #
+# @cpu-responsive-throttle: Make CPU throttling more responsively by
+#                           introduce an extra detection metric of
+#                           migration convergence. (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -855,7 +859,7 @@
            'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow', 'cpu-periodic-throttle',
-           'cpu-periodic-throttle-interval',
+           'cpu-periodic-throttle-interval', 'cpu-responsive-throttle',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
@@ -916,6 +920,10 @@
 # @cpu-periodic-throttle-interval: Interval of the periodic CPU throttling.
 #     (Since 9.1)
 #
+# @cpu-responsive-throttle: Make CPU throttling more responsively by
+#                           introduce an extra detection metric of
+#                           migration convergence. (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1045,6 +1053,7 @@
             '*cpu-throttle-tailslow': 'bool',
             '*cpu-periodic-throttle': 'bool',
             '*cpu-periodic-throttle-interval': 'uint8',
+            '*cpu-responsive-throttle': 'bool',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
@@ -1132,6 +1141,10 @@
 # @cpu-periodic-throttle-interval: Interval of the periodic CPU throttling.
 #     (Since 9.1)
 #
+# @cpu-responsive-throttle: Make CPU throttling more responsively by
+#                           introduce an extra detection metric of
+#                           migration convergence. (Since 9.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
@@ -1254,6 +1267,7 @@
             '*cpu-throttle-tailslow': 'bool',
             '*cpu-periodic-throttle': 'bool',
             '*cpu-periodic-throttle-interval': 'uint8',
+            '*cpu-responsive-throttle': 'bool',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
             '*tls-authz': 'str',
-- 
2.39.1


