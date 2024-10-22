Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A8AD2CDFA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HPw-0000Dg-H9; Tue, 22 Oct 2024 12:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HPt-0000Cl-WE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HPq-0001Uc-PN
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729613245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpHqTPG9MnhZBW1ja6qou5cPaboyQUJVUHc5xgQ+NH0=;
 b=K+C4bPF75RVWVjd0GIh6nrxg50Xu5uMI4ikisNeeOX6fa/boyNX3Lqxb7dmwa8PXCv9RG8
 RbkxjWYVN+XM2fySseS3UhbPKOrSz/ac5Bw+pOfjl/+VrouSst+IUwdfA7iIXul6jkmFUG
 3NeDqDC/hoNEBrwqDiQ6KdOrEAQLpDc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-kSh5eqzSNsSSRTAKgDB0FA-1; Tue, 22 Oct 2024 12:07:24 -0400
X-MC-Unique: kSh5eqzSNsSSRTAKgDB0FA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbe4cb4252so24448666d6.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 09:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729613244; x=1730218044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpHqTPG9MnhZBW1ja6qou5cPaboyQUJVUHc5xgQ+NH0=;
 b=ESTQy7nBVIKCDbjOA3GzlXWPtQEvFTewlJbgE6qChpgHKIRfxntGSzSOr1HD3c/ndV
 J5Wdrr/GjZN6maThj3poV+3PyV+uhrXGG5yDKQxxUcbNrPmse4yxQgubQFCFEkfr1EbV
 ZlEJ+4DHQZJ1j9TtDUEGByezCo04s/B2xYi3W9H8S50MtbI3/uQgvaWzwsPWLRWlUVNv
 riEqXxsV9f7suy92xn6d29UCMmekvPiSwVJcmfCc+KFqnHLjKcLd30nf0Co7mHZFKQ1b
 nvA5qLw2UwGiOJB4btC0DEY0xnVn7gB8pRgMs7gEaMSIlxYD2dpF7RsznzNnH5VKHGwA
 C6uw==
X-Gm-Message-State: AOJu0Yywr/M4Aw7dUfHUssjZ/XSj9yz5A0UJxkn8xEiZHTNQgh9dSHx7
 upfo6+pM+m9b95PQmzBWK8BbtotP9jeryazqsN37abOoa48IZAG11hkUoTKC9/NAaTaHYVq7sqQ
 b7+RB7KRUQlud3f651FkY6t9tkivglPcYJ8Rx00Q6TDzcm/xQdumPh4Vnl+MU0EEuQ77VMHutJs
 uhh0CghVwJ3htdFXRYDa0ja/5cEFfOTVF/MA==
X-Received: by 2002:a05:6214:5d83:b0:6cb:8a6a:25cb with SMTP id
 6a1803df08f44-6cde1633993mr211256296d6.43.1729613243811; 
 Tue, 22 Oct 2024 09:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgmT7QRglNeSRLHfyuDZvscafMWNAMFpr1aOX1TivfSKWSzZYemsMmX42RLMTz/TjJaXvmtA==
X-Received: by 2002:a05:6214:5d83:b0:6cb:8a6a:25cb with SMTP id
 6a1803df08f44-6cde1633993mr211255776d6.43.1729613243074; 
 Tue, 22 Oct 2024 09:07:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008fb113sm30224026d6.34.2024.10.22.09.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:07:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 1/2] migration: Make all helpers in misc.h safe to use without
 migration
Date: Tue, 22 Oct 2024 12:07:19 -0400
Message-ID: <20241022160720.1013543-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241022160720.1013543-1-peterx@redhat.com>
References: <20241022160720.1013543-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Migration object can be freed before some other device codes run, while we
do have a bunch of migration helpers exported in migration/misc.h that
logically can be invoked at any time of QEMU, even during destruction of a
VM.

Make all these functions safe to be called, especially, not crashing after
the migration object is freed.

Add a rich comment in the header explaining how to guarantee thread safe on
using these functions, and we choose BQL because fundamentally that's how
it's working now.  We can move to other things (e.g. RCU) whenever
necessary in the future but it's an overkill if we have BQL anyway in
most/all existing callers.

When at it, update some comments, e.g. migrate_announce_params() is
exported from options.c now.

Cc: Cédric Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 33 ++++++++++++++++++++++++++++-----
 migration/migration.c    | 22 +++++++++++++++++++++-
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bfadc5613b..8d6812b8c7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -19,8 +19,26 @@
 #include "qapi/qapi-types-net.h"
 #include "migration/client-options.h"
 
-/* migration/ram.c */
+/*
+ * Misc migration functions exported to be used in QEMU generic system
+ * code outside migration/.
+ *
+ * By default, BQL is required to use below functions to avoid race
+ * conditions (e.g. concurrent free of the migration object).  It's
+ * caller's responsibility to make sure it's thread safe otherwise when
+ * below helpers are used without BQL held.
+ *
+ * One example of the special case is migration_thread(), who will take a
+ * refcount of the migration object.  The refcount will make sure the
+ * migration object will not be freed concurrently when accessing through
+ * below helpers.
+ *
+ * When unsure, always take BQL first before using the helpers.
+ */
 
+/*
+ * migration/ram.c
+ */
 typedef enum PrecopyNotifyReason {
     PRECOPY_NOTIFY_SETUP = 0,
     PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC = 1,
@@ -43,14 +61,19 @@ void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 bool migrate_ram_is_ignored(RAMBlock *block);
 
-/* migration/block.c */
-
+/*
+ * migration/options.c
+ */
 AnnounceParameters *migrate_announce_params(void);
-/* migration/savevm.c */
 
+/*
+ * migration/savevm.c
+ */
 void dump_vmstate_json_to_file(FILE *out_fp);
 
-/* migration/migration.c */
+/*
+ * migration/migration.c
+ */
 void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
diff --git a/migration/migration.c b/migration/migration.c
index bcb735869b..27341eed50 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1121,6 +1121,10 @@ bool migration_is_setup_or_active(void)
 {
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return false;
+    }
+
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
@@ -1136,7 +1140,6 @@ bool migration_is_setup_or_active(void)
 
     default:
         return false;
-
     }
 }
 
@@ -1685,6 +1688,10 @@ bool migration_is_active(void)
 {
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return false;
+    }
+
     return (s->state == MIGRATION_STATUS_ACTIVE ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
@@ -1693,6 +1700,10 @@ bool migration_is_device(void)
 {
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return false;
+    }
+
     return s->state == MIGRATION_STATUS_DEVICE;
 }
 
@@ -1700,6 +1711,11 @@ bool migration_thread_is_self(void)
 {
     MigrationState *s = current_migration;
 
+    /* If no migration object, must not be the migration thread */
+    if (!s) {
+        return false;
+    }
+
     return qemu_thread_is_self(&s->thread);
 }
 
@@ -3077,6 +3093,10 @@ void migration_file_set_error(int ret, Error *err)
 {
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return;
+    }
+
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
             qemu_file_set_error_obj(s->to_dst_file, ret, err);
-- 
2.45.0


