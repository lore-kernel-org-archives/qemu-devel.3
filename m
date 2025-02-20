Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59285C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 13:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl6YI-0001Bp-4o; Thu, 20 Feb 2025 08:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl6YF-0001Bb-6B
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl6YC-0006Vn-Fm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740057906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xiGuWigvbne/pKzYLnkGasQg/oyWDRI5AxoNQVS1NDI=;
 b=OEjuX16zNSTGfMZMHEhXks9hUejNz9H8MeGSryNC8GkTPNQkYJld9Esud9ZPQ5maa/kAC1
 EC0GM5LWRW1LLef151fw2F3H84RFkzd36KgyM8Fl04GoD4rVrJ38cJSitJu/oZBOsw6u5B
 bFQA6XUPDNlXkqRoG8oRWEmrOZV5kVU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-6uplhF1tPzWy2zyL2o8CAg-1; Thu, 20 Feb 2025 08:25:03 -0500
X-MC-Unique: 6uplhF1tPzWy2zyL2o8CAg-1
X-Mimecast-MFC-AGG-ID: 6uplhF1tPzWy2zyL2o8CAg_1740057903
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e659664db8so32688596d6.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740057902; x=1740662702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xiGuWigvbne/pKzYLnkGasQg/oyWDRI5AxoNQVS1NDI=;
 b=a0kihwE9QSG89Zf35pmiHZRGaYxOr2pF1CDjUt5v/rZRbjhgEOCAE04pADoQxAL3+6
 UDpLGFT5G13za9ajUAo/m/hcUefUvB3DlRgIp7WkiDPR4LHLbqdwW4E/WCPo1/goHU4x
 7AVZQqSN+1xWmwPpicSEQjwY4xcZ/ebk9TjAvQEE2kKZcYRogdx8Vuw0JvBbOmtmYbpZ
 HvUA7PgjqZfrlUGZK1/RsxSc7jnmEpXAWy37CDZcOkhrXNh+bFo2CNhrI1vqfixSUmFt
 CvcmMGqy95HqEMRs7u1vdwDDlkhlnmOjkJHVBsy7X4FaSaez9NxK5pAZpAbZLDAxD5qt
 Dayg==
X-Gm-Message-State: AOJu0Yyuh4dR42Pz9YHWYdCNKPZP1lVudnZYupmDJtiE3HOJ9ueAh1go
 lNM/xnsY9s58K5xbLeHHgeBh42UBvCwSnJXuTdDX2bhiYbowWP/IEuly4AV5barisbB7dTvald5
 L2VBKsrao8QLdku1m2WvBHVhFPOOQYJHcC12xHjIar+LU719k6CHd1UkXwFzg+aQE0jWRhoZzWl
 r4vbDYmdsAXuzzzFpIeftTcvhbcSudZ2RZeQ==
X-Gm-Gg: ASbGncuHLWGetqgORx5mzEB6kSvBsLnxsqbdumKvCFiyqjEkIsaqq2y0iP3EsVTBRwA
 Lv88///VxpVSRnAemrdkIg4JbbVLjFAqEjbWqqeKyDdaed1GAnf5lMziL1/pF1pY+JA1LRlKjmJ
 ZJ/8//g0/LSIHOq6f9gJqw7Jd7mK/L9E8AYovqwHtMxpN0AqCOBbk1OloL4C44jJRhBFT3uEjpT
 qgFMmOYis/hpr78ZdltfXs8rtHIx3geTWg9GyB1AhHxOtSqvi3dS5rT
X-Received: by 2002:a05:6214:2421:b0:6d4:c6d:17fe with SMTP id
 6a1803df08f44-6e66cce7260mr331482516d6.25.1740057902413; 
 Thu, 20 Feb 2025 05:25:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh3gIo4z0KgQnV2P11UkFMXteQBceou7E9uOaO1SBh0b4sYjgsr+OrLQEphXPnAJntWbbiJQ==
X-Received: by 2002:a05:6214:2421:b0:6d4:c6d:17fe with SMTP id
 6a1803df08f44-6e66cce7260mr331482096d6.25.1740057902038; 
 Thu, 20 Feb 2025 05:25:02 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e660f65c5csm80106546d6.117.2025.02.20.05.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:25:01 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Yan Fu <yafu@redhat.com>
Subject: [PATCH] migration: Fix UAF for incoming migration on MigrationState
Date: Thu, 20 Feb 2025 08:24:59 -0500
Message-ID: <20250220132459.512610-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On the incoming migration side, QEMU uses a coroutine to load all the VM
states.  Inside, it may reference MigrationState on global states like
migration capabilities, parameters, error state, shared mutexes and more.

However there's nothing yet to make sure MigrationState won't get
destroyed (e.g. after migration_shutdown()).  Meanwhile there's also no API
available to remove the incoming coroutine in migration_shutdown(),
avoiding it to access the freed elements.

There's a bug report showing this can happen and crash dest QEMU when
migration is cancelled on source.

When it happens, the dest main thread is trying to cleanup everything:

  #0  qemu_aio_coroutine_enter
  #1  aio_dispatch_handler
  #2  aio_poll
  #3  monitor_cleanup
  #4  qemu_cleanup
  #5  qemu_default_main

Then it found the migration incoming coroutine, schedule it (even after
migration_shutdown()), causing crash:

  #0  __pthread_kill_implementation
  #1  __pthread_kill_internal
  #2  __GI_raise
  #3  __GI_abort
  #4  __assert_fail_base
  #5  __assert_fail
  #6  qemu_mutex_lock_impl
  #7  qemu_lockable_mutex_lock
  #8  qemu_lockable_lock
  #9  qemu_lockable_auto_lock
  #10 migrate_set_error
  #11 process_incoming_migration_co
  #12 coroutine_trampoline

To fix it, take a refcount after an incoming setup is properly done when
qmp_migrate_incoming() succeeded the 1st time.  As it's during a QMP
handler which needs BQL, it means the main loop is still alive (without
going into cleanups, which also needs BQL).

Releasing the refcount now only until the incoming migration coroutine
finished or failed.  Hence the refcount is valid for both (1) setup phase
of incoming ports, mostly IO watches (e.g. qio_channel_add_watch_full()),
and (2) the incoming coroutine itself (process_incoming_migration_co()).

Note that we can't unref in migration_incoming_state_destroy(), because
both qmp_xen_load_devices_state() and load_snapshot() will use it without
an incoming migration.  Those hold BQL so they're not prone to this issue.

PS: I suspect nobody uses Xen's command at all, as it didn't register yank,
hence AFAIU the command should crash on master when trying to unregister
yank in migration_incoming_state_destroy()..  but that's another story.

Also note that in some incoming failure cases we may not always unref the
MigrationState refcount, which is a trade-off to keep things simple.  We
could make it accurate, but it can be an overkill.  Some examples:

  - Unlike most of the rest protocols, socket_start_incoming_migration()
    may create net listener after incoming port setup sucessfully.
    It means we can't unref in migration_channel_process_incoming() as a
    generic path because socket protocol might keep using MigrationState.

  - For either socket or file, multiple IO watches might be created, it
    means logically each IO watch needs to take one refcount for
    MigrationState so as to be 100% accurate on ownership of refcount taken.

In general, we at least need per-protocol handling to make it accurate,
which can be an overkill if we know incoming failed after all.  Add a short
comment to explain that when taking the refcount in qmp_migrate_incoming().

Bugzilla: https://issues.redhat.com/browse/RHEL-69775
Tested-by: Yan Fu <yafu@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c597aa707e..f57d853e9f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -116,6 +116,27 @@ static void migration_downtime_start(MigrationState *s)
     s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 }
 
+/*
+ * This is unfortunate: incoming migration actually needs the outgoing
+ * migration state (MigrationState) to be there too, e.g. to query
+ * capabilities, parameters, using locks, setup errors, etc.
+ *
+ * NOTE: when calling this, making sure current_migration exists and not
+ * been freed yet!  Otherwise trying to access the refcount is already
+ * an use-after-free itself..
+ *
+ * TODO: Move shared part of incoming / outgoing out into separate object.
+ * Then this is not needed.
+ */
+static void migrate_incoming_ref_outgoing_state(void)
+{
+    object_ref(migrate_get_current());
+}
+static void migrate_incoming_unref_outgoing_state(void)
+{
+    object_unref(migrate_get_current());
+}
+
 static void migration_downtime_end(MigrationState *s)
 {
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
@@ -850,7 +871,7 @@ process_incoming_migration_co(void *opaque)
              * postcopy thread.
              */
             trace_process_incoming_migration_co_postcopy_end_main();
-            return;
+            goto out;
         }
         /* Else if something went wrong then just fall out of the normal exit */
     }
@@ -866,7 +887,8 @@ process_incoming_migration_co(void *opaque)
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
-    return;
+    goto out;
+
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
@@ -883,6 +905,9 @@ fail:
 
         exit(EXIT_FAILURE);
     }
+out:
+    /* Pairs with the refcount taken in qmp_migrate_incoming() */
+    migrate_incoming_unref_outgoing_state();
 }
 
 /**
@@ -1888,6 +1913,17 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    /*
+     * Making sure MigrationState is available until incoming migration
+     * completes.
+     *
+     * NOTE: QEMU _might_ leak this refcount in some failure paths, but
+     * that's OK.  This is the minimum change we need to at least making
+     * sure success case is clean on the refcount.  We can try harder to
+     * make it accurate for any kind of failures, but it might be an
+     * overkill and doesn't bring us much benefit.
+     */
+    migrate_incoming_ref_outgoing_state();
     once = false;
 }
 
-- 
2.47.0


