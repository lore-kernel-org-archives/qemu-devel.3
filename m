Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50029D1951E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUG6-0003l1-J4; Mon, 26 Jan 2026 16:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG3-0003iq-7M
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG1-0003Lt-Eo
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769463384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etRNZB/RqPeas23lqicq1TZAYZsK5mKaexzj8oDSS3I=;
 b=JH9+YXGamlgyFTDgF4EMkmoeilQT2ItVGyFvrozuDGmH/ZcS9DEQjnB2KkSQ8YAXMYpJ+i
 kg9FZjPQ22XWDnIUqo56CCwJ2lw/doXbYJsdhjH5uKpcOZVh+Mg0+LzB1uulLFqwjbqs4G
 GcAp8iDWKC0T1NkSZAhGT1GeVr/zufA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-dc8OTwWVNvy5DBXyVBNw6A-1; Mon, 26 Jan 2026 16:36:22 -0500
X-MC-Unique: dc8OTwWVNvy5DBXyVBNw6A-1
X-Mimecast-MFC-AGG-ID: dc8OTwWVNvy5DBXyVBNw6A_1769463382
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5013c19b92dso145539301cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769463381; x=1770068181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etRNZB/RqPeas23lqicq1TZAYZsK5mKaexzj8oDSS3I=;
 b=r46td/hapYjrnFCmqG+3JmqwKsxfVK92zq1PVJq+8/f5fGS0VJuQTrrZ6aMMFob0bG
 FBLFmPev/unN1oy0pK5CjHCMZH6TEPaku63j1otEUJMloHXNmZoQku27ecs6Y0hfCyT9
 JQeQLPjXREJOfU5cvA3QNUOXExcQYIRtRiHSdYIOJOczZQ8LoJCBRcPQq+wREP04mkD6
 t4X5Ob056iCeKmu/8kOdkY/BSillu3f8HUxR43JlfMs+dRcdrQ75Bo1jC8A8X0zfFzkf
 5TC/BzZCLxDaO1tEP0xS6AlUUdfEy6By5McOgiScqoLHcPgef/am50P1fzTLjhtcU1Ir
 GEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769463381; x=1770068181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=etRNZB/RqPeas23lqicq1TZAYZsK5mKaexzj8oDSS3I=;
 b=OaafJV2Xt43Y5GUNGpWZLxkneJ0mWnpliVRTY4++SRs+ZbmN3kJcV/ovugEVtfGOSw
 eIaLHkZyNNhwFyMtLNpWOvEVWW7YoKBoBvk7IKONWg8LLASV+GREHzQfaUudc+GL6mMm
 bK9CFk832XAiJg6PD2pgO9OyhmlCQ4znCX4TmXbdzMI+DrCABTU/kJfbaPGyWEq3TSQ1
 vKIT+U602h4W8/2khI6cskkV01VGE16YRst2GZt6d7X8FLc4jBKrbSBK4vC2EF9MX1wH
 11DpqSRMLDC12/bbK/ydHLIP5D1X+r4Pr+13NT7N+C8MHRUwkctQPt4ZPXqPlrH+7BTc
 FUkQ==
X-Gm-Message-State: AOJu0Ywp9GUr1TlORyQh9ypXX8C75gTSjlhEn4Gqpbhp2bkMQFE49rHE
 QdRr9GHl4iokdN6xvwyzo/NoR9PgJnZSV+eZNrUCkgQsTuz3ahABL78INX4CXAMys1ySXhCVzGv
 VxwGNrJgWvKyZahwLOspkuAhCaJksHXBMdferiwfMjGayAWiYBcfb5ei4U4uVHo7IE5sNiL6dRD
 hti6zCTAY2IPQdUFMcItzK9Trzk7nAeMHYOoyvYg==
X-Gm-Gg: AZuq6aJMJfysozluq3gHFdiFKgMlN3HaF6vd6q64fPw3rZFeajeb5Uc7TRMOFUYv4Fb
 n54+N6OL9SitaqmnjsKN/BzuAc/fRjhRt3bifWS8ytN8J5utGdbsrFYp+IHltQOq2VwqlSJ28iz
 fycEI+e76yfp0L4rnMyNPQUBcPEkwmEPaMYwSWIqaj6YftyonzWq6lE8bX5E0AHkOnPYLlg3J2/
 9dRF3HUpALwcuGbbys1wp9V0n0JA745TuP/7E1ietT55ntpDDyqLTdITbqVN2ocOerNY2fBJ8Ks
 L4NWFolTmc4Dh5u3GKaC71oy6mA+pZVOslxmdD+ZakXHQMqdyl/FVIQwN8on4uukIrxxKuqIZZa
 8
X-Received: by 2002:a05:622a:d4:b0:4f0:24e2:8de6 with SMTP id
 d75a77b69052e-50314c9379dmr79323921cf.64.1769463381541; 
 Mon, 26 Jan 2026 13:36:21 -0800 (PST)
X-Received: by 2002:a05:622a:d4:b0:4f0:24e2:8de6 with SMTP id
 d75a77b69052e-50314c9379dmr79323431cf.64.1769463380984; 
 Mon, 26 Jan 2026 13:36:20 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f9cd9esm89769281cf.33.2026.01.26.13.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:36:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 2/5] migration: Fix double notification of DONE/FAIL for
 postcopy
Date: Mon, 26 Jan 2026 16:36:11 -0500
Message-ID: <20260126213614.3815900-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260126213614.3815900-1-peterx@redhat.com>
References: <20260126213614.3815900-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Migration notifiers will notify at any of three places: (1) SETUP
phase, (2) migration completes, (3) migration fails.

There's actually a special case for spice: one can refer to
b82fc321bf ("Postcopy+spice: Pass spice migration data earlier").  It
doesn't need another 4th event because in commit 9d9babf78d ("migration:
MigrationEvent for notifiers") we merged it together with the DONE event.

The merge makes some sense if we treat "switchover" of postcopy as "DONE",
however that also means for postcopy we'll notify DONE twice..  The other
one at the end of postcopy when migration_cleanup().

In reality, the current code base will also notify FAILED for postcopy
twice.  It's because an (maybe accidental) change in commit
4af667f87c ("migration: notifier error checking").

First of all, we still need that notification when switchover as stated in
Dave's commit, however that's only needed for spice.  To fix it, introduce
POSTCOPY_START event to differenciate it from DONE.  Use that instead in
postcopy_start().  Then spice will need to capture this event too.

Then we remove the extra FAILED notification in postcopy_start().

If one wonder if other DONE users should also monitor POSTCOPY_START
event.. We have two more DONE users:

  - kvm_arm_gicv3_notifier
  - cpr_exec_notifier

Both of them do not need a notification for POSTCOPY_START, but only when
migration completed.  Actually, both of them are used in CPR, which doesn't
support postcopy.

When at this, update the notifier transition graph in the comment, and move
it from migration_add_notifier() to be closer to where the enum is defined.

I didn't attach Fixes: because I am not aware of any real bug on such
double reporting.  I'm wildly guessing the 2nd notify might be silently
ignored in many cases.  However this is still worth fixing.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 16 ++++++++++++----
 migration/migration.c    |  3 +--
 ui/spice-core.c          |  3 ++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e26d418a6e..1cd6cfd7f7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -59,10 +59,22 @@ void migration_shutdown(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
+/*
+ * Notifiers may receive events in any of the following orders:
+ *
+ *    - MIG_EVENT_PRECOPY_SETUP [-> MIG_EVENT_POSTCOPY_START]
+ *      -> MIG_EVENT_PRECOPY_DONE
+ *
+ *    - MIG_EVENT_PRECOPY_SETUP [-> MIG_EVENT_POSTCOPY_START]
+ *      -> MIG_EVENT_PRECOPY_FAILED
+ *
+ *    - MIG_EVENT_PRECOPY_FAILED
+ */
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
     MIG_EVENT_PRECOPY_DONE,
     MIG_EVENT_PRECOPY_FAILED,
+    MIG_EVENT_POSTCOPY_START,
     MIG_EVENT_MAX
 } MigrationEventType;
 
@@ -81,10 +93,6 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
 /*
  * Register the notifier @notify to be called when a migration event occurs
  * for MIG_MODE_NORMAL, as specified by the MigrationEvent passed to @func.
- * Notifiers may receive events in any of the following orders:
- *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_DONE
- *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_FAILED
- *    - MIG_EVENT_PRECOPY_FAILED
  */
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
diff --git a/migration/migration.c b/migration/migration.c
index 341b9be80e..bd24006c1a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2591,7 +2591,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
+    migration_call_notifiers(MIG_EVENT_POSTCOPY_START, NULL);
 
     migration_downtime_end(ms);
 
@@ -2640,7 +2640,6 @@ fail:
         migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
     }
     migration_block_activate(NULL);
-    migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
 }
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 8a6050f4ae..ce3c2954e3 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -585,7 +585,8 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
 
     if (e->type == MIG_EVENT_PRECOPY_SETUP) {
         spice_server_migrate_start(spice_server);
-    } else if (e->type == MIG_EVENT_PRECOPY_DONE) {
+    } else if (e->type == MIG_EVENT_PRECOPY_DONE ||
+               e->type == MIG_EVENT_POSTCOPY_START) {
         spice_server_migrate_end(spice_server, true);
         spice_have_target_host = false;
     } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
-- 
2.50.1


