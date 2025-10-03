Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ED4CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huz-0005Tb-VI; Fri, 03 Oct 2025 11:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hup-0005LV-4I
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htw-0007jQ-Dk
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8fiQy3aRmI+o7fGIb+2xDZQqme3fu7Xru005U7h37U=;
 b=EBW/7ete8qQhLSWsXVYzGisGLV2vpj+UKSg6qxm0w7GWOPRoet7fGNJO9OMSvYRTqKJlje
 I/uJxWWSX/9VL9l03JrHWKxgjTS4SgU5+SHRJ2zuiC5XdF2UU6mO4ptcf3PQQAHAsm2dI1
 pYHqEmJrDBv9ab1T6snXr30l+mpKkBE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-U5MtzlEGMEOxeKedH1l9Aw-1; Fri, 03 Oct 2025 11:40:45 -0400
X-MC-Unique: U5MtzlEGMEOxeKedH1l9Aw-1
X-Mimecast-MFC-AGG-ID: U5MtzlEGMEOxeKedH1l9Aw_1759506044
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-818bf399f8aso58421916d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506044; x=1760110844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8fiQy3aRmI+o7fGIb+2xDZQqme3fu7Xru005U7h37U=;
 b=KYxzbV4tcOWwfxwSs3pVpcfAxsiQv2NSvVq8UC71kuj2bz09G6gnUD77Z0z5Twts51
 Z6ick8ksL8YCzUXhbJcqTdm92qyhJynd1yxTGc2W8Dnj6e9v12UeFivSkzlHoCcgWn8d
 cbJRyUh8cvvNvEAS+gtRnfUyeonfqA9bDYeG2rra0o7OH4Dtk+m6aTgEdIMUGlE0gEL1
 7uc803PgwIRddoEPYczvRP6LztGJvvQUOcRPVI2+z4Ald04d6B6WEsran5aFlH/A4Cyt
 XFFUWxX3HP3nOWFbBRiasIyMLETGNzClZWJGfELqjn9AH6CHizD4L11SVd72CRL+ga8A
 vBGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOVb7rrF7GIlwGe4IqZZ2De4gDK0cOIdu64vZBMuu1Anvn9XwqWwtR9wNWRoYrpspkjrFK1SVUn5ph@nongnu.org
X-Gm-Message-State: AOJu0YxFGvDzs/k/E5FNbVHHSAeO94HOs4zU8sUc1QEx7lTTC4JUO3Nz
 2oFYcPYRnJQPnQR9RGW+XkNpit+VAgBlS0xIMUzJoECuxAtvJBGIuDo0f9mmxnY6mVJClTvozlk
 b9u2ucrmZlzIzHdbpEvy32i0uYXF0rFDK5lq2mxa+bs65OOVGtkke0pAk
X-Gm-Gg: ASbGncsYQUkdnQSlNxly+wsS76sbEdSuluW24E/dC+eaKQPL9H4psoZ0UB+UxoDUuuj
 b3zsKp9h2rkH8+AJUltremdujf2HsDcCOEnyAZJ00WhRcpxypn00UIUTjt1ZolXFMOlZxbvt7kj
 nWhjlNGwBi5J+7vuqmjTFfe2iplVRwbtYkqJyLDciaIltw97/JaKYqangaFK5/HA0zDfae2ImJz
 H/NyPyT0yT5HPMtXAuEM4/uU9jKogM8G6L/wnudWw7OzZ/e2nZD/hbjlPtVzMVHzp3hgU+6fmQ5
 p30U0ULHjI2mpsPq3L7Fsy5SlXgH8chEv1dryg==
X-Received: by 2002:a05:6214:da8:b0:83a:661:ff55 with SMTP id
 6a1803df08f44-879dc842c69mr45847666d6.35.1759506044369; 
 Fri, 03 Oct 2025 08:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTu56m9p+KDxvYCC9Lgk67M+MVU8Rb+KbbNGkQGAHVm4nP9/GL7gV1w/dDkyTrH7Fbdp4GwQ==
X-Received: by 2002:a05:6214:da8:b0:83a:661:ff55 with SMTP id
 6a1803df08f44-879dc842c69mr45847236d6.35.1759506043794; 
 Fri, 03 Oct 2025 08:40:43 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 37/45] migration: multi-mode notifier
Date: Fri,  3 Oct 2025 11:39:40 -0400
Message-ID: <20251003153948.1304776-38-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow a notifier to be added for multiple migration modes.
To allow a notifier to appear on multiple per-node lists, use
a generic list type.  We can no longer use NotifierWithReturnList,
because it shoe horns the notifier onto a single list.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1759332851-370353-2-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 12 ++++++++
 migration/migration.c    | 60 +++++++++++++++++++++++++++++++---------
 2 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index a261f99d89..592b93021e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -95,7 +95,19 @@ void migration_add_notifier(NotifierWithReturn *notify,
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
+/*
+ * Same as migration_add_notifier, but applies to all @mode in the argument
+ * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
+ * the notifier is added for all modes.
+ */
+void migration_add_notifier_modes(NotifierWithReturn *notify,
+                                  MigrationNotifyFunc func, MigMode mode, ...);
+
+/*
+ * Remove a notifier from all modes.
+ */
 void migration_remove_notifier(NotifierWithReturn *notify);
+
 void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
diff --git a/migration/migration.c b/migration/migration.c
index edb8ff0d46..a399735f02 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -74,11 +74,7 @@
 
 #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
 
-static NotifierWithReturnList migration_state_notifiers[] = {
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
-    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
-};
+static GSList *migration_state_notifiers[MIG_MODE__MAX];
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1675,23 +1671,51 @@ void migration_cancel(void)
     }
 }
 
+static int get_modes(MigMode mode, va_list ap);
+
+static void add_notifiers(NotifierWithReturn *notify, int modes)
+{
+    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+        if (modes & BIT(mode)) {
+            migration_state_notifiers[mode] =
+                g_slist_prepend(migration_state_notifiers[mode], notify);
+        }
+    }
+}
+
+void migration_add_notifier_modes(NotifierWithReturn *notify,
+                                  MigrationNotifyFunc func, MigMode mode, ...)
+{
+    int modes;
+    va_list ap;
+
+    va_start(ap, mode);
+    modes = get_modes(mode, ap);
+    va_end(ap);
+
+    notify->notify = (NotifierWithReturnFunc)func;
+    add_notifiers(notify, modes);
+}
+
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode)
 {
-    notify->notify = (NotifierWithReturnFunc)func;
-    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
+    migration_add_notifier_modes(notify, func, mode, -1);
 }
 
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func)
 {
-    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
+    migration_add_notifier_modes(notify, func, MIG_MODE_NORMAL, -1);
 }
 
 void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
-        notifier_with_return_remove(notify);
+        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+            migration_blockers[mode] =
+                g_slist_remove(migration_state_notifiers[mode], notify);
+        }
         notify->notify = NULL;
     }
 }
@@ -1701,13 +1725,23 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 {
     MigMode mode = s->parameters.mode;
     MigrationEvent e;
+    NotifierWithReturn *notifier;
+    GSList *elem, *next;
     int ret;
 
     e.type = type;
-    ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
-                                           &e, errp);
-    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
-    return ret;
+
+    for (elem = migration_state_notifiers[mode]; elem; elem = next) {
+        next = elem->next;
+        notifier = (NotifierWithReturn *)elem->data;
+        ret = notifier->notify(notifier, &e, errp);
+        if (ret) {
+            assert(type == MIG_EVENT_PRECOPY_SETUP);
+            return ret;
+        }
+    }
+
+    return 0;
 }
 
 bool migration_has_failed(MigrationState *s)
-- 
2.50.1


