Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F90FECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snelO-0001ZS-OB; Mon, 09 Sep 2024 09:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelM-0001PF-PP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:49:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelK-0000Bi-S5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:49:04 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso2923562a91.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725889741; x=1726494541;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0+VMi25/Zc4CDone71m1lCGybIDfbvM1CcXIqSCA9s=;
 b=p26fR4YAEElT+Byzfj/pD3ukk90mrAwxNCHoLIeOXDw0FPKN7Oy6bqLgFLHtC7fSb/
 CMpChNOYCpnpFvnCPCvaniTTtf87aFe/yLIO6WpRABM2IIJ1zRf6MWSm++dwahUh3nfI
 b0ccSi9IywJLFAQPZDLiEFFbHLYROcpwbjD/G0An62r1VzqpM7OK3FItrfAbR9d1LwNQ
 BxrfPSN8c/0PCkqjadU4o7oH9wIYY9/KBdTVON5ncmqnlPx5v8koGsUSlLogNruPONJG
 scIantOiVcNL69R9orhRippqkkPPrSx3qmca1aO/1LpnWbZ83yuBzmHXYUBhjuxQYgT6
 gMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889741; x=1726494541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0+VMi25/Zc4CDone71m1lCGybIDfbvM1CcXIqSCA9s=;
 b=RYgoiIhcCGkik83y3DQGlbDvKUIN1Syif4iCnjq3nol+l1/CfzWR2yXtnJySQS/A3P
 sd28BZSxlrsx2qqlwE7LN0UovfrGZBE4HE5kfyOnSx76ig12L1aY4fzMoD2WJKqvH3lA
 o+cmVsTUTQO09UerIEUUMSPqtQbGBnAM2SfFqvUoKvTo0c096rrz0lcIahaJP6ZSe6n9
 quAE84SyQHtU9St1GaXJ6ufRUP7l18YM1AX8JDjAaOVs9QjMCTtJ+4L7YLDHCYIkmOD1
 qw7hd20ivuejt4VFqkt/CLXOZ2ae60wNxONfDnx03rUHtaxwcoqZFHqZvoDTX9rYmSYr
 sCAg==
X-Gm-Message-State: AOJu0YzbrMOYOJYGEyOrpOtpBrbf+6ZuLdRmXbYW7oO6Dwya9oJZhBht
 1vTmzG3YgaOe6v0pjaTDQX8heA8O/tqTKhrotrhrBgeRa9/SSrSrwhtfm16HFltMNYxOhcjci6u
 1+BjWvg==
X-Google-Smtp-Source: AGHT+IEv0vyqNLBwnpgRZISdlcOecif4whKql3fH/CgRnN1+3UtbJcnUagKcl/aWN4VEJ+LhY92qkg==
X-Received: by 2002:a17:90a:ba93:b0:2d8:a731:7db0 with SMTP id
 98e67ed59e1d1-2daffe2735fmr8929016a91.35.1725889740675; 
 Mon, 09 Sep 2024 06:49:00 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dab2c6b0b9sm7841031a91.0.2024.09.09.06.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:49:00 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 08/10] migration: Introduce cpu-responsive-throttle
 parameter
Date: Mon,  9 Sep 2024 21:47:20 +0800
Message-Id: <24b2598916502ae298fdf6ca296e8c1559710d78.1725889277.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725889277.git.yong.huang@smartx.com>
References: <cover.1725889277.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1035.google.com
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


