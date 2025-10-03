Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE843CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv6-0005Vj-39; Fri, 03 Oct 2025 11:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hup-0005M7-7S
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hty-0007ke-NE
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9pyhoFiM3epXPrFs48uoibYrGGgxuvPdNdfsLuFmoQ=;
 b=Q2lHdR2YoInq8iLcld9K6sW34snuB+jJuRIIVFgrxP/Xwi+F0BfL7PjABhpFcM+b0WKQOM
 GnCoMVdH6dDHH0lRiobO8TtXHL7b+JX85HiDzaROh22x+9IRRTZ80SWud646EFdQPYrM7f
 Mb4+e0nNF8pYv9tLNO/SDzsxJY7GBUI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-MdCp5EAkOOOzcn1vwXbUrQ-1; Fri, 03 Oct 2025 11:40:49 -0400
X-MC-Unique: MdCp5EAkOOOzcn1vwXbUrQ-1
X-Mimecast-MFC-AGG-ID: MdCp5EAkOOOzcn1vwXbUrQ_1759506048
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-876ee102b44so66407526d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506048; x=1760110848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9pyhoFiM3epXPrFs48uoibYrGGgxuvPdNdfsLuFmoQ=;
 b=p5z1cHR0Dklk9osVOOKQxaOYARK2kfUdg79U079wU4QE9CWwxiZSaIhqyJHmt1AeQv
 ZgzZMDbGzea62lc52Op/wQNIv3kRQZiV5cnDkcg9qc6/S5pvkui0ZoIxmG56QNTZDkC0
 HMLeSAXKYH1hR/Su4/TyYOQSxswhxdQxgYefwtsWo8r1ol2i3uPlgKpVrv2NF3+QcXuG
 +O28YQfqijKnwx1qQTTb/d8ZaVTclzj2s8PXkn9JY4jTWYYPxV63BVC/aAWfdJrSHDr6
 OfgTn/qXqImMigTi3xlsXFZeAEjpUjlfumNjxj6B89kbLuAh9BvtSfrACgfou3+hb9nQ
 Ouag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMfv36JjPejR0t115ux7cgg4/OzmTTjAjAReL9BRe07TH886s+Ky9fsK6gvq/eDYLi4YJBiOSVuhtW@nongnu.org
X-Gm-Message-State: AOJu0Yx+mFRZZSoLRce7pGSDd84DkvwYBC3/NH4yYVQ85rJF9yOLuICN
 EfVAdjWji3F44fVYgYdmKpAvnD63Gpa8lxm3U6FyLzLF1kXtElFcSj5/YPs3MkxBo3VcOeiJN81
 7iW76T3Da0mYR2hzDhSMxPpI7cDDv1tOS/mJMpIVT8Qpqi7hj/g9e2YnY
X-Gm-Gg: ASbGncss5x4D3LOB0zg4oQ/GFha4RN7buv9e7e6NR7AzcavKoet2zhmNFlETFNiEUcu
 39lU+XP9VfIkIhpY7trryOBA2slsNJsmUVi9gMYUJES2Lg/7KzdTIWjPZlbLWuMp0AUL+f+shxl
 QXRK7HM/9aEQiehOh+0YidN5OgMwwUZsTp/WeSw+2b+9zUR91WzJL2JrgzisB4M6AWhtq/dgEoJ
 CqPbuSU0FuZaacALLsS70Oq/P6WbrbHVeQhQ9E0y98/njQWSwjDARv3PGLFC2pO5oUJ44KB/+CP
 MgTwGQPZpTm7aOefqXGk+AxkgQLfHA+4xG1sUw==
X-Received: by 2002:a05:6214:4015:b0:7a7:b219:635f with SMTP id
 6a1803df08f44-879dc4434dbmr40017366d6.16.1759506047884; 
 Fri, 03 Oct 2025 08:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+n9c5IZBaDxE8cbXOT08INkmFvKzFjkNtJeNZNM7oTTpBlzz0J+hImaerzKuURWoUo1KAVw==
X-Received: by 2002:a05:6214:4015:b0:7a7:b219:635f with SMTP id
 6a1803df08f44-879dc4434dbmr40016946d6.16.1759506047201; 
 Fri, 03 Oct 2025 08:40:47 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 40/45] migration: cpr-exec-command parameter
Date: Fri,  3 Oct 2025 11:39:43 -0400
Message-ID: <20251003153948.1304776-41-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Create the cpr-exec-command migration parameter, defined as a list of
strings.  It will be used for cpr-exec migration mode in a subsequent
patch, and contains forward references to cpr-exec mode in the qapi
doc.

No functional change, except that cpr-exec-command is shown by the
'info migrate' command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/1759332851-370353-5-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 21 ++++++++++++++++++---
 migration/migration-hmp-cmds.c | 30 ++++++++++++++++++++++++++++++
 migration/options.c            | 14 ++++++++++++++
 hmp-commands.hx                |  2 +-
 4 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21e9c..2be8fa1d16 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -924,6 +924,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments.  (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -950,7 +954,8 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io',
+           'cpr-exec-command'] }
 
 ##
 # @MigrateSetParameters:
@@ -1105,6 +1110,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments.  (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1146,7 +1155,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-exec-command': [ 'str' ]} }
 
 ##
 # @migrate-set-parameters:
@@ -1315,6 +1325,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @cpr-exec-command: Command to start the new QEMU process when @mode
+#     is @cpr-exec.  The first list element is the program's filename,
+#     the remainder its arguments.  (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1353,7 +1367,8 @@
             '*vcpu-dirty-limit': 'uint64',
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool' } }
+            '*direct-io': 'bool',
+            '*cpr-exec-command': [ 'str' ]} }
 
 ##
 # @query-migrate-parameters:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 814221b260..847d18faaa 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -306,6 +306,18 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
     qapi_free_MigrationCapabilityStatusList(caps);
 }
 
+static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
+{
+    monitor_printf(mon, "%s:",
+        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
+
+    while (args) {
+        monitor_printf(mon, " %s", args->value);
+        args = args->next;
+    }
+    monitor_printf(mon, "\n");
+}
+
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
@@ -437,6 +449,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
                                MIGRATION_PARAMETER_DIRECT_IO),
                            params->direct_io ? "on" : "off");
         }
+
+        assert(params->has_cpr_exec_command);
+        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
     }
 
     qapi_free_MigrationParameters(params);
@@ -718,6 +733,21 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_direct_io = true;
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
+    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
+        g_autofree char **strv = NULL;
+        g_autoptr(GError) gerr = NULL;
+        strList **tail = &p->cpr_exec_command;
+
+        if (!g_shell_parse_argv(valuestr, NULL, &strv, &gerr)) {
+            error_setg(&err, "%s", gerr->message);
+            break;
+        }
+        for (int i = 0; strv[i]; i++) {
+            QAPI_LIST_APPEND(tail, strv[i]);
+        }
+        p->has_cpr_exec_command = true;
+        break;
+    }
     default:
         g_assert_not_reached();
     }
diff --git a/migration/options.c b/migration/options.c
index 4e923a2e07..5183112775 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -959,6 +959,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->zero_page_detection = s->parameters.zero_page_detection;
     params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
+    params->has_cpr_exec_command = true;
+    params->cpr_exec_command = QAPI_CLONE(strList,
+                                          s->parameters.cpr_exec_command);
 
     return params;
 }
@@ -993,6 +996,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_mode = true;
     params->has_zero_page_detection = true;
     params->has_direct_io = true;
+    params->has_cpr_exec_command = true;
 }
 
 /*
@@ -1297,6 +1301,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_direct_io) {
         dest->direct_io = params->direct_io;
     }
+
+    if (params->has_cpr_exec_command) {
+        dest->cpr_exec_command = params->cpr_exec_command;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1429,6 +1437,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_direct_io) {
         s->parameters.direct_io = params->direct_io;
     }
+
+    if (params->has_cpr_exec_command) {
+        qapi_free_strList(s->parameters.cpr_exec_command);
+        s->parameters.cpr_exec_command =
+            QAPI_CLONE(strList, params->cpr_exec_command);
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/hmp-commands.hx b/hmp-commands.hx
index d0e4f35a30..3cace8f1f7 100644
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
-- 
2.50.1


