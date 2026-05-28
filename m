Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE50CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 21:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSiIC-0005AE-EV; Thu, 28 May 2026 17:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiI9-00059M-AY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiI6-00033R-AR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780003760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIDQ2kvQqYtnxLEwqYnl1da/aYo+rT6/BzRSOHGERy0=;
 b=McwVsD+L0OuqEXCXGsvw8ilqLBS1fStn1a9Up4mlaCPoVCJdIJ/6wrhJl+gpYbs5c/yJsg
 n3RHedFAU4ZPMG+/8UHZK5LJTANj6h4gnPOGbCxtqQdKHXjS1N2gJNPdbdRo35qsTvqcj2
 jqD55Kbimt78v//MPmPNmwNt2EWoY5s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-2TPtvBQXO9Cxse-zPbo4SA-1; Thu, 28 May 2026 17:29:19 -0400
X-MC-Unique: 2TPtvBQXO9Cxse-zPbo4SA-1
X-Mimecast-MFC-AGG-ID: 2TPtvBQXO9Cxse-zPbo4SA_1780003759
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-914b56ea791so38265585a.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780003759; x=1780608559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIDQ2kvQqYtnxLEwqYnl1da/aYo+rT6/BzRSOHGERy0=;
 b=UCyZds0zagyX9N9M70MpXOAklfFmGpNPq0GQoBCi5F/+dCL9s+9GQhtRh3bBO2ogec
 xnNzbUEYBJcfOHjFJ23N1MgKDf/aEY5z+clQu+Zkv9gUkjL8ryzoAY8msTs2qaCi+OaU
 +Go9HpMo2YONhWB6BjL7nrNjlKdlfXGqbCyLwn6cnp16v2VtK7SrWoSFCtbcyBMVQL9I
 X+V0DRj7eG5aOwAdBjppNoHgJqnwiCfRQHtxLmJy2bH1YttQ55JL9awNkS1zYHaLgI1v
 IfSrNB+DXH0UkMkGZgTyIj4OfRQ2libTt/N5/r9sVRfY2kdWeELJjOpCudOQ+JBZ7uOC
 J8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780003759; x=1780608559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FIDQ2kvQqYtnxLEwqYnl1da/aYo+rT6/BzRSOHGERy0=;
 b=P21jSDY+9fK2stYTdzbe2aES3Y0NfAi42HjQujfAEpdFKRa2bccOrkJGV9Y1xsjSyR
 ZuA+N+cYZYXCYrapW9uUf+7YXGsHiWAiRX/KNYSpnc3ylJ+edMRGU9MWHHLRgx030Qyz
 /TNe+IoKns9NBWAwWlqGXPb/b74FNsXLDMCd3Uwa0C4rZjdkA1murHWQNS+LjZ0srRGz
 KMgsLUnOYUgTMBN5KPUyIP52BD5sJksKQ7sH9dV+qKIxi2Y0qpS1I556I4sbQQoHF/2S
 H6E2jeq105kTG65k5p+cY99Od4ZDHb3S2qyWX/jR+QPphWP0toMLGGJtEfUi5hSvGoY9
 P/LQ==
X-Gm-Message-State: AOJu0YznUiJmIGCu/KAMWdEHThTpvHviukWGsahKKGdr+3hJAdcktAjd
 F1frZJnIWS29ctalLqQ3Kim5n+PL9ykuMWBXe0Cf4qCD0ZD6iBueTf/fvb7/WjnMz3o6oZVyP++
 p4N1OgE+iyxk/sJMKub67XJN8q25AHOggwKM0UMno5bD5p6v3G1/w3y5R8j3ZjtiyXDpkvYoIbO
 uQEb+Fxpjrm/QBPutdxu8ckBkkINlsxD+ymJTJLA==
X-Gm-Gg: Acq92OFeO/0oJa6aml/7cPwuUrIyPEmp5g5HV7XmtSG8QfBi08GpZLDlWNr23Y3DR4o
 dJKQ0WTkHTurblQANBqJeWfL+PQRgw0AHnq41oNQ9nP3kLKZSTEwhnC0ke+uAIuaq31wlPKQtXa
 8VxrphbLUpVuIgBy7M27LZBDVrdf2eoFrxIIufGt8oRimUjGsA/u5kS0BhBWWwwOhjR9MiGmXLN
 5t5jF6IN+zewGE+ZzpGIBlnLHXBdVFH8z+6mjJ+Dycni7tPSFfMp9vfjLjTmltL04hrMQb6sVVe
 iSntl2sYpfDmE4AXHjdjytISjb7fBZLWj9LqlneFZMR7sWU03u/tDCVE8iiiQO8ys2w27W6j/bW
 mg50KBWBp28JO+W2m22cJ9AJmTX7BZtgUXY3U3fc/3yQYB4fYruNE944=
X-Received: by 2002:a05:620a:29c9:b0:914:babf:9f40 with SMTP id
 af79cd13be357-9152fdea256mr7863085a.28.1780003758693; 
 Thu, 28 May 2026 14:29:18 -0700 (PDT)
X-Received: by 2002:a05:620a:29c9:b0:914:babf:9f40 with SMTP id
 af79cd13be357-9152fdea256mr7856285a.28.1780003758066; 
 Thu, 28 May 2026 14:29:18 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9152fd10282sm5770085a.7.2026.05.28.14.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:29:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, peterx@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v2 1/2] migration/vl: Allow set parameters with -incoming
 config:*
Date: Thu, 28 May 2026 17:29:11 -0400
Message-ID: <20260528212912.367967-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528212912.367967-1-peterx@redhat.com>
References: <20260528212912.367967-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QEMU doesn't yet have a good way to specify migration parameters so that
they can be available even during early stage of QEMU boots.  It is because
the migration object (who owns the migration parameters) will only be
created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
reading migration parameters is illegal.

However, QEMU does have special use cases for such, namely only-migratable
flag, and cpr-transfer. Recently, we have one more possible user to read a
to-be-introduced new migration parameters during backend initialization
phase.  We can introduce yet another global variable (or per-device
parameter) to bypass this limitation, but we can also seek for a generic
solution that we can setup migration parameters very early, even during
backend initializations.

See this discussion for more details on the context of the problem:

  https://lore.kernel.org/r/ahdI7Vl5KraK566D@x1.local

This patch wants to take the latter approach.

As a start, introduce a new way to specify migration parameters in QEMU
boot commandline, as proposed in the above discussion:

  -incoming config:key1=value1,key2=value2,...

When specified, QEMU will parse a string formatted MigrationParameters and
keep it.  When migration object is created, it will apply all the settings
as initial value.

Since the application of boot parameters will be after object_new()
completes, it means it happens after all machine compat properties or
-global settings (which should be done during instance_post_init()).

So far, it's still only a way to specify parameters.  All parameters are
not visible before migration object created, like before.  Any parameter
that needs to be visible during boot will need to opt-in this feature.
Follow up patches will switch the current users to use this model.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  5 ++++
 migration/migration.c    | 54 ++++++++++++++++++++++++++++++++++++++++
 system/vl.c              |  7 ++++++
 qemu-options.hx          | 18 ++++++++++++--
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 3159a5e53c..aff79b1380 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -133,6 +133,11 @@ bool migrate_is_uri(const char *uri);
 /* Parse @uri and return @channel, returning true on success */
 bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                        Error **errp);
+/*
+ * Parse @config_str in form of "config:key1=value1,..." to initialize
+ * migration parameters.
+ */
+bool migration_parameters_boot_parse(const char *config_str, Error **errp);
 
 /* migration/multifd-device-state.c */
 typedef struct SaveCompletePrecopyThreadData {
diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..d918be7a44 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -41,6 +41,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qobject/qnull.h"
 #include "qemu/rcu.h"
 #include "postcopy-ram.h"
@@ -94,6 +95,9 @@ enum mig_rp_message_type {
 static MigrationState *current_migration;
 static MigrationIncomingState *current_incoming;
 
+/* Only used during boot, destroyed after migration object initialized */
+static MigrationParameters *mig_boot_params;
+
 static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
@@ -102,6 +106,45 @@ static bool stop_return_path_thread_on_source(MigrationState *s);
 static void migration_release_dst_files(MigrationState *ms);
 static void migration_completion_end(MigrationState *s);
 
+bool migration_parameters_boot_parse(const char *config_str, Error **errp)
+{
+    Visitor *v;
+
+    if (mig_boot_params) {
+        error_setg(errp, "Only one -incoming config:* is allowed.");
+        return false;
+    }
+
+    v = qobject_input_visitor_new_str(config_str, NULL, errp);
+    if (!v) {
+        goto fail;
+    }
+
+    if (!visit_type_MigrationParameters(v, NULL, &mig_boot_params, errp)) {
+        goto fail;
+    }
+
+    visit_free(v);
+    return true;
+
+fail:
+    visit_free(v);
+    return false;
+}
+
+static void migration_parameters_boot_apply(void)
+{
+    if (mig_boot_params) {
+        /*
+         * This can fail, because qobject visitor doesn't do sanity check
+         * on values while parsing.  It's not too late; we're still in boot
+         * phase.
+         */
+        qmp_migrate_set_parameters(mig_boot_params, &error_abort);
+        g_clear_pointer(&mig_boot_params, qapi_free_MigrationParameters);
+    }
+}
+
 static void migration_downtime_start(MigrationState *s)
 {
     trace_vmstate_downtime_checkpoint("src-downtime-start");
@@ -322,6 +365,17 @@ void migration_object_init(void)
 
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
 
+    /*
+     * Apply boot migration parameters in case the user specified some via
+     * command line "-incoming config:*". NOTE: this will overwrite machine
+     * type compat properties and -global settings!
+     */
+    migration_parameters_boot_apply();
+
+    /*
+     * The boot parameters should have been verified already, but leave it
+     * after applying boot parameters to do one check for everything.
+     */
     migration_object_check(current_migration, &error_fatal);
 
     ram_mig_init();
diff --git a/system/vl.c b/system/vl.c
index da36b2c6e1..49f5fa0c7b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1838,6 +1838,13 @@ static void incoming_option_parse(const char *str)
 
     if (!strcmp(str, "defer")) {
         channel = NULL;
+    } else if (!strncmp(str, "config:", 7)) {
+        /*
+         * This is not a channel setup, but configuration to incoming
+         * migration parameters to make them available during early boot.
+         */
+        migration_parameters_boot_parse(str + 7, &error_fatal);
+        return;
     } else if (migrate_is_uri(str)) {
         migrate_uri_parse(str, &channel, &error_fatal);
     } else {
diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..1fc92a409a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5366,11 +5366,15 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "-incoming <channel>\n" \
     "                accept incoming migration on the migration channel\n" \
     "-incoming defer\n" \
-    "                wait for the URI to be specified via migrate_incoming\n",
+    "                wait for the URI to be specified via migrate_incoming\n"
+    "-incoming config:key1=value1,key2=value2,...\n" \
+    "                specify migration parameters valid even during boot\n",
     QEMU_ARCH_ALL)
 SRST
+
 The -incoming option specifies the migration channel for an incoming
-migration.  It may be used multiple times to specify multiple
+migration, or can also be used to setup migration parameters for the
+incoming migration.  It may be used multiple times to specify multiple
 migration channel types.  The channel type is specified in <channel>,
 or is 'main' for all other forms of -incoming.  If multiple -incoming
 options are specified for a channel type, the last one takes precedence.
@@ -5411,6 +5415,16 @@ options are specified for a channel type, the last one takes precedence.
     Wait for the URI to be specified via migrate\_incoming. The monitor
     can be used to change settings (such as migration parameters) prior
     to issuing the migrate\_incoming to allow the migration to begin.
+
+``-incoming config:key1=value1[,key2=value2,...]``
+
+    Specify migration parameters in QEMU commandlines, so that these
+    parameters will be available even during very early boot of QEMU.
+    They will be applied properly after QEMU boots and when the migration
+    core is initialized.  From that POV, it has similar effect as setting
+    these parameters using QMP command ``migrate-set-parameters`` or HMP
+    command ``migrate_set_parameter``.
+
 ERST
 
 DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
-- 
2.53.0


