Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10FECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 21:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSiIm-0005Fe-1k; Thu, 28 May 2026 17:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiIj-0005Ex-IL
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiIh-0003B5-Nj
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780003799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iK2oU4S+42s+otGAIzHzbA0pHikpDmtjFXz49vQJAUM=;
 b=F3PBQoQ3uQcJ8XqyirmRwtWor7oqz8JdzZ4yk2CCvIIRGLrqspRJYQA+A14KTziO8/7OM+
 PnnvMPccxeEO4+Wa3yCSnvv8GLubN5OALYW2GbSBB7M01Ghb/5JNmJ9DRdrrYfqzSMxr/w
 ef32y0jJ/nctgIqCOoZD3q7wdqrEipM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-lZN1ZivuNeegwgJj2sSqQw-1; Thu, 28 May 2026 17:29:57 -0400
X-MC-Unique: lZN1ZivuNeegwgJj2sSqQw-1
X-Mimecast-MFC-AGG-ID: lZN1ZivuNeegwgJj2sSqQw_1780003797
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-914d0204c67so1120642985a.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780003797; x=1780608597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iK2oU4S+42s+otGAIzHzbA0pHikpDmtjFXz49vQJAUM=;
 b=bDCddrBbBS20jfyPNo2q9f6j35FL+40Vgxp7fTO3Up3iDNVOhqdY90XQE+zR6Izx1B
 7ZcYxBgtJgMU7ZYvHNoB3f3jgpsRU0ES3C2Ry8ZtLY4riSOUJ2y083gHMJMJONmrIMbX
 h/XELuL42VNumSltlUv660Kgy99qsIvOKn0zB+kOaI+2nzFbdibj+vItAbUUSNxtMR7n
 MZLKjNh4aBBR3gzNMMvcX9BpAYw+SH4T7B9WRWsvW5GwiGIrr/H37QNS4HY8QFbyjzts
 eTyB7zzzD4m8T6uzhVIu+/jBhrB/xYbDs+Ju4YcPb9ia/AZ07nBHY56ahwNL0zFLzc0N
 buBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780003797; x=1780608597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iK2oU4S+42s+otGAIzHzbA0pHikpDmtjFXz49vQJAUM=;
 b=dRwetQ7dJpnRa+dpCPetRUa4Dn31D8UuKD1vElPWkchSr4QzjOBor2neqgz+E+zJZ2
 AVeX1vG4BcflkJMlp8SCwRjCSDBN2MdeCY9cUHGnKzNlnfSzpuJoCfvIYkk2FKa096+x
 rLsbAZIsrT9LCNnBQV6uGv07i7ediFTFWTAwLOZl2D5nf/bqTmR9sC8xp7860cbIFPUB
 Tjps2hJ8zhVc0xKO/9cYKaVM1ksgaM6TSGE/DZAHqbx6idpgWWv+bnFeitwicsUHBAHr
 L8Itq8PnFHZ8DBLfDPJpQj2DfX9wY6Zpz4ZSTHZZLPsqIAdOm3TXMeBHaQ1qMpYuYVvn
 A0Kg==
X-Gm-Message-State: AOJu0YwBNLpkz2ObWFPOESfdM83yM284hqALVcKMgkVGdKGTYC0lU/B3
 Nd7/NAW+eM8xO+9M3HITkGVLujLP9rpNMT738NklZHIhu0+mBHp9XnC3L1wOOIx+m8DirYmMV8L
 tliSdvzonD9DGdt/71k3b1O2jtrMM9fz+St1her4PQaUIu5UQNcC9wDC/nF+A60aGL6aQDQ0t6B
 z0FyC7lHI95kL6ayyDYoLcTGXoJhAC9kTgTeL8GA==
X-Gm-Gg: Acq92OEr54GoRo6RJ1HJxkZUzdFl+pq54QQus+1OPmxeHJPnQoRJLfqINEDkS3KScMs
 /Yls5HkACDlut/UIxrx6uKBGcDGfObHYC/UboKSeN/j60y0qU3l7gVfNoewWLocP9GZK6wnNwLr
 INenK866DJcCuadX9865Z7+1Um0xNHgqJcEVs/1Js4HoTuLHWO1wY7o5+pTD14UBLqXeSGZCPEm
 Ifp9WeCZgsT2GlkvzBnhVlVvusiTU1vsCV0Z+sSV42Euo6q4C7Px4l8D33FSpykDmVa6G/itmTy
 YE90tJHpG8Iy2BR6rTBBb0PVAgeYu6lmw+vDhojLQ3y/6cWLv8Eb6WgocIfnrw5QdaezLlrtpEM
 ugIKu82V+8ux4qGrfOeqRYvD7j1PCfGR+iZH4ZrSJhAN9NDs4KJyF+Tw=
X-Received: by 2002:a05:620a:4726:b0:914:babf:9f54 with SMTP id
 af79cd13be357-9152fde99d7mr6590185a.34.1780003796609; 
 Thu, 28 May 2026 14:29:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4726:b0:914:babf:9f54 with SMTP id
 af79cd13be357-9152fde99d7mr6584885a.34.1780003796001; 
 Thu, 28 May 2026 14:29:56 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153012a673sm1259385a.46.2026.05.28.14.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:29:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH RFC 2/2] migration/cpr: Opt-in "mode" parameter for early boot
 access
Date: Thu, 28 May 2026 17:29:47 -0400
Message-ID: <20260528212947.368132-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528212947.368132-1-peterx@redhat.com>
References: <20260528212947.368132-1-peterx@redhat.com>
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

Make "mode" to be the first parameter to opt-in for early boot access.  CPR
will start to consume this early boot parameter.  With this, we can remove
the special "incoming_mode" variable together with cpr_get_incoming_mode().

One thing to mention is, to make cpr_is_incoming() work like before, we
need to do extra check on INMIGRATE runstate to make sure it only returns
true while during the incoming migration.  It used to be achieved by a
pretty hackish "cpr_set_incoming_mode(MIG_MODE_NONE)" when incoming
migration destroys.  Now we can remove it.

Another good side effect is, we can finally drop MIG_MODE_NONE: it was
never a valid value, only used by the temp global variable.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  3 ---
 migration/migration.h   |  3 +++
 migration/cpr.c         | 18 +++++++++---------
 migration/migration.c   | 37 ++++++++++++++++++++++++++++++++++++-
 migration/options.c     | 10 +++-------
 5 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 56fb67e6b4..27061ad629 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -12,8 +12,6 @@
 #include "io/channel.h"
 #include "qemu/queue.h"
 
-#define MIG_MODE_NONE           -1
-
 #define QEMU_CPR_FILE_MAGIC     0x51435052
 #define QEMU_CPR_FILE_VERSION   0x00000001
 #define CPR_STATE "CprState"
@@ -38,7 +36,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 typedef bool (*cpr_walk_fd_cb)(int fd);
 bool cpr_walk_fd(cpr_walk_fd_cb cb);
 
-MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
 
diff --git a/migration/migration.h b/migration/migration.h
index 841f49b215..9fa97f6d9a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -609,4 +609,7 @@ void migration_bitmap_sync_precopy(bool last_stage);
 void dirty_bitmap_mig_init(void);
 bool should_send_vmdesc(void);
 
+void migration_parameters_boot_set_mode(MigMode mode);
+MigrationParameters *migration_get_parameters(void);
+
 #endif
diff --git a/migration/cpr.c b/migration/cpr.c
index bca43e9bf3..1f49afe109 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -16,6 +16,7 @@
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "migration/migration.h"
 #include "monitor/monitor.h"
 #include "system/runstate.h"
 #include "trace.h"
@@ -239,21 +240,20 @@ QIOChannel *cpr_state_ioc(void)
     return qemu_file_get_ioc(cpr_state_file);
 }
 
-static MigMode incoming_mode = MIG_MODE_NONE;
-
-MigMode cpr_get_incoming_mode(void)
-{
-    return incoming_mode;
-}
-
 void cpr_set_incoming_mode(MigMode mode)
 {
-    incoming_mode = mode;
+    migration_parameters_boot_set_mode(mode);
 }
 
 bool cpr_is_incoming(void)
 {
-    return incoming_mode != MIG_MODE_NONE;
+    MigMode mode = migrate_mode();
+
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        return false;
+    }
+
+    return mode == MIG_MODE_CPR_EXEC || mode == MIG_MODE_CPR_TRANSFER;
 }
 
 bool cpr_state_save(MigrationChannel *channel, Error **errp)
diff --git a/migration/migration.c b/migration/migration.c
index d918be7a44..d7591571ed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -145,6 +145,42 @@ static void migration_parameters_boot_apply(void)
     }
 }
 
+static void migration_parameters_boot_init(void)
+{
+    if (!mig_boot_params) {
+        mig_boot_params = g_new0(MigrationParameters, 1);
+    }
+}
+
+/*
+ * This should only be used during boot by CPR.  NOTE: This is only needed
+ * to be compatible with old CPR use case, if we decide to have users
+ * switch to -incoming config:mode=cpr-* then this can be removed.
+ */
+void migration_parameters_boot_set_mode(MigMode mode)
+{
+    assert(!current_migration);
+    migration_parameters_boot_init();
+    mig_boot_params->has_mode = true;
+    mig_boot_params->mode = mode;
+}
+
+/*
+ * Get the effective migration parameter object.
+ *
+ * Three possibilities:
+ * - Migration object has been initialized, always use it, or,
+ * - Migration boot parameters are initialized, then use it, or,
+ * - return NULL
+ *
+ * Callers should always check non-NULL pointer first before use.
+ */
+MigrationParameters *migration_get_parameters(void)
+{
+    return current_migration ?
+        &current_migration->parameters : mig_boot_params;
+}
+
 static void migration_downtime_start(MigrationState *s)
 {
     trace_vmstate_downtime_checkpoint("src-downtime-start");
@@ -546,7 +582,6 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_qemufile_dst = NULL;
     }
 
-    cpr_set_incoming_mode(MIG_MODE_NONE);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..c1209cbec3 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -886,16 +886,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
     return s->parameters.max_postcopy_bandwidth;
 }
 
+/* Opt-in "mode" parameter to be available even during boot */
 MigMode migrate_mode(void)
 {
-    MigMode mode = cpr_get_incoming_mode();
+    MigrationParameters *params = migration_get_parameters();
 
-    if (mode == MIG_MODE_NONE) {
-        mode = migrate_get_current()->parameters.mode;
-    }
-
-    assert(mode >= 0 && mode < MIG_MODE__MAX);
-    return mode;
+    return params ? params->mode : MIG_MODE_NORMAL;
 }
 
 int migrate_multifd_channels(void)
-- 
2.53.0


