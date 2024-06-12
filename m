Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23822C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPBW-00089f-Jo; Wed, 12 Jun 2024 10:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBV-00088W-Kg
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBT-0002no-FB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718203362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsoADCMSQ4i2nEI1WsbhXJoTwfNy8aqcbl8X3mzHuV0=;
 b=B693t8RqchIGht29Z9p4hm8OAQmQnnjo/yopM2T+I+ImUUrGh76EzXRd48mjjTpuERNK6C
 fVie2XVnDPYb6lI1PRmeowves6VJ3ePGq670OYeD9H6rzxKibM+16Cndt+qFm7K1ITYWxg
 /b2VSmAnrRmCHeHxCnmizLsWVqLnKoQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-cl2ZhOw0NqWnPWbyw57N1w-1; Wed, 12 Jun 2024 10:42:40 -0400
X-MC-Unique: cl2ZhOw0NqWnPWbyw57N1w-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dfa5b0ee271so1045518276.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203360; x=1718808160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsoADCMSQ4i2nEI1WsbhXJoTwfNy8aqcbl8X3mzHuV0=;
 b=GXIFyoKPexl4O2YgfLTn2c2AUx5xEPERDIHKtEzoSnM0KpM6ar7mGOmvo9vhgc8RTp
 uo86/YcYPU7J9RcuUyrROfEUD20eEy5vrT7yF27l5wIp0jC0MHfjspWerVX29HVykNlt
 uoHksPFPEkE+CUJ6Fsjxvhkwfdpq7cBLahRvg2a6AM9tLkrLK7iTbegzNcMGAD2GZUYB
 OAv4koXx3IadJa4gpI5+IypzGbr5NWSOr8v0OCopIVaR6cm1/KtPxEJ0QsnbcmwcUJNZ
 mg6HiYmelLzNynbQdeGR2PD5Yi0Eb15fsnzFc5YX755N7yv5B7i6hwfWc6+Z5Dk4Hdnx
 B5bQ==
X-Gm-Message-State: AOJu0YzBOvtmsg1k5wh8AtDWnshYD+w6UkUe1/IWBDMTYPuuKCGUvyZx
 WEXJ8caYpmp9KitL/cNRrwMiDaHY5109uLgYujSIxocDWsfHiOoc/glnJ1AFlR6sF3SRWB0lVlD
 Gw0A6CJ2DCwmWQ1Gh4WbsbkZrjPpQkjLX9IlHaUMie36uI1kFWdZwGfVkKJ4i63hmlERkGe/NR0
 9m4+DqJhNWe9plQCDx6cSB/Zj4H9W6sNZf/A==
X-Received: by 2002:a25:86d2:0:b0:dfd:d70b:bbe3 with SMTP id
 3f1490d57ef6-dfe6ac9dfcamr1440823276.5.1718203359427; 
 Wed, 12 Jun 2024 07:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHafHFyGKgBr6TW9ZGmdaUNYMsJqmS9a2n823FCImTsqWNkfsw4SgWiqdz2nexJa6AKx37qJw==
X-Received: by 2002:a25:86d2:0:b0:dfd:d70b:bbe3 with SMTP id
 3f1490d57ef6-dfe6ac9dfcamr1440782276.5.1718203358512; 
 Wed, 12 Jun 2024 07:42:38 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4405e3ded65sm37581681cf.87.2024.06.12.07.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:42:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 4/4] migration/postcopy: Add postcopy-recover-setup phase
Date: Wed, 12 Jun 2024 10:42:28 -0400
Message-ID: <20240612144228.1179240-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240612144228.1179240-1-peterx@redhat.com>
References: <20240612144228.1179240-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch adds a migration state on src called "postcopy-recover-setup".
The new state will describe the intermediate step starting from when the
src QEMU started an postcopy recovery request, until the migration channels
are properly established, but before the recovery process take place.

The request came from Libvirt where Libvirt currently rely on the migration
state events to detect migration state changes.  That works for most of the
migration process but except postcopy recovery failures at the beginning.

Currently postcopy recovery only has two major states:

  - postcopy-paused: this is the state that both sides of QEMU will be in
    for a long time as long as the migration channel was interrupted.

  - postcopy-recover: this is the state where both sides of QEMU handshake
    with each other, preparing for a continuation of postcopy which used to
    be interrupted.

The issue here is when the recovery port is invalid, the src QEMU will take
the URI/channels, noticing the ports are not valid, and it'll silently keep
in the postcopy-paused state, with no event sent to Libvirt.  In this case,
the only thing Libvirt can do is to poll the migration status with a proper
interval, however that's less optimal.

Considering that this is the only case where Libvirt won't get a
notification from QEMU on such events, let's add postcopy-recover-setup
state to mimic what we used to have with the "setup" state of a newly
initialized migration, describing the phase of connection establishment.

With that, postcopy recovery will have two paths to go now, and either path
will guarantee an event generated.  Now the events will look like this
during a recovery process on src QEMU:

  - Initially when the recovery is initiated on src, QEMU will go from
    "postcopy-paused" -> "postcopy-recover-setup".  Old QEMUs don't have
    this event.

  - Depending on whether the channel re-establishment is succeeded:

    - In succeeded case, src QEMU will move from "postcopy-recover-setup"
      to "postcopy-recover".  Old QEMUs also have this event.

    - In failure case, src QEMU will move from "postcopy-recover-setup" to
      "postcopy-paused" again.  Old QEMUs don't have this event.

This guarantees that Libvirt will always receive a notification for
recovery process properly.

One thing to mention is, such new status is only needed on src QEMU not
both.  On dest QEMU, the state machine doesn't change.  Hence the events
don't change either.  It's done like so because dest QEMU may not have an
explicit point of setup start.  E.g., it can happen that when dest QEMUs
doesn't use migrate-recover command to use a new URI/channel, but the old
URI/channels can be reused in recovery, in which case the old ports simply
can work again after the network routes are fixed up.

The patch has some touch-ups in the dest path too, but it's because there's
some unclearness on using migrate_set_state(), so the change should make it
crystal clear now by checking current status always.  The next step from
that POV would be making migrate_set_state() not using cmpxchg() but always
update the status, but that's for later.

Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>
Buglink: https://issues.redhat.com/browse/RHEL-38485
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json      |  4 +++
 migration/postcopy-ram.h |  3 ++
 migration/migration.c    | 66 +++++++++++++++++++++++++++++++++++-----
 migration/postcopy-ram.c |  6 ++++
 migration/savevm.c       |  4 +--
 5 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index a351fd3714..a135bbcd96 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -142,6 +142,9 @@
 #
 # @postcopy-paused: during postcopy but paused.  (since 3.0)
 #
+# @postcopy-recover-setup: setup phase for a postcopy recover process,
+#     preparing for a recover phase to start.  (since 9.1)
+#
 # @postcopy-recover: trying to recover from a paused postcopy.  (since
 #     3.0)
 #
@@ -166,6 +169,7 @@
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
+            'postcopy-recover-setup',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
 ##
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ecae941211..a6df1b2811 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_POSTCOPY_RAM_H
 #define QEMU_POSTCOPY_RAM_H
 
+#include "qapi/qapi-types-migration.h"
+
 /* Return true if the host supports everything we need to do postcopy-ram */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
                                     Error **errp);
@@ -193,5 +195,6 @@ enum PostcopyChannels {
 void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
 void postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
+bool postcopy_is_paused(MigrationStatus status);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index bfbd657035..9475dce7dc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -595,6 +595,26 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
     return true;
 }
 
+static bool
+migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
+{
+    MigrationStatus current = mis->state;
+
+    if (current == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        /* Postcopy paused state doesn't change when setup new ports */
+        return true;
+    }
+
+    if (current != MIGRATION_STATUS_NONE) {
+        error_setg(errp, "Illegal migration incoming state: %s",
+                   MigrationStatus_str(current));
+        return false;
+    }
+
+    migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
@@ -633,8 +653,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
-                      MIGRATION_STATUS_SETUP);
+    if (!migration_incoming_state_setup(mis, errp)) {
+        return;
+    }
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
@@ -1070,6 +1091,7 @@ bool migration_is_setup_or_active(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1092,6 +1114,7 @@ bool migration_is_running(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1229,6 +1252,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
@@ -1279,6 +1303,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_COLO:
@@ -1435,9 +1460,30 @@ static void migrate_error_free(MigrationState *s)
 
 static void migrate_fd_error(MigrationState *s, const Error *error)
 {
+    MigrationStatus current = s->state;
+    MigrationStatus next;
+
     assert(s->to_dst_file == NULL);
-    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED);
+
+    switch (current) {
+    case MIGRATION_STATUS_SETUP:
+        next = MIGRATION_STATUS_FAILED;
+        break;
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
+        /* Never fail a postcopy migration; switch back to PAUSED instead */
+        next = MIGRATION_STATUS_POSTCOPY_PAUSED;
+        break;
+    default:
+        /*
+         * This really shouldn't happen. Just be careful to not crash a VM
+         * just for this.  Instead, dump something.
+         */
+        error_report("%s: Illegal migration status (%s) detected",
+                     __func__, MigrationStatus_str(current));
+        return;
+    }
+
+    migrate_set_state(&s->state, current, next);
     migrate_set_error(s, error);
 }
 
@@ -1538,6 +1584,7 @@ bool migration_in_postcopy(void)
     switch (s->state) {
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         return true;
     default:
@@ -1936,6 +1983,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             return false;
         }
 
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
+
         /* This is a resume, skip init status */
         return true;
     }
@@ -2968,9 +3018,9 @@ static MigThrError postcopy_pause(MigrationState *s)
          * We wait until things fixed up. Then someone will setup the
          * status back for us.
          */
-        while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        do {
             qemu_sem_wait(&s->postcopy_pause_sem);
-        }
+        } while (postcopy_is_paused(s->state));
 
         if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
             /* Woken up by a recover procedure. Give it a shot */
@@ -3666,7 +3716,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
     Error *local_err = NULL;
     uint64_t rate_limit;
-    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    bool resume = migration_in_postcopy();
     int ret;
 
     /*
@@ -3733,7 +3783,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 
     if (resume) {
         /* Wakeup the main migration thread to do the recovery */
-        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
                           MIGRATION_STATUS_POSTCOPY_RECOVER);
         qemu_sem_post(&s->postcopy_pause_sem);
         return;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 97701e6bb2..1c374b7ea1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1770,3 +1770,9 @@ void *postcopy_preempt_thread(void *opaque)
 
     return NULL;
 }
+
+bool postcopy_is_paused(MigrationStatus status)
+{
+    return status == MIGRATION_STATUS_POSTCOPY_PAUSED ||
+        status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
+}
diff --git a/migration/savevm.c b/migration/savevm.c
index e71410d8c1..deb57833f8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2864,9 +2864,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     error_report("Detected IO failure for postcopy. "
                  "Migration paused.");
 
-    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+    do {
         qemu_sem_wait(&mis->postcopy_pause_sem_dst);
-    }
+    } while (postcopy_is_paused(mis->state));
 
     trace_postcopy_pause_incoming_continued();
 
-- 
2.45.0


