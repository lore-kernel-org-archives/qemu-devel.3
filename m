Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B9AC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xJH-0000lX-JO; Wed, 16 Sep 2026 17:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIk-0000id-O2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIi-0007ax-R3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789594580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruJ34mVTBKFRGqovWKs9/aGpon/uDErFImIoiP6PipI=;
 b=Xj8FjZ5PYddpnrUrIgZwE7BfvOhqH0MWcdkzVj3DscVaE2kbAHXmRwFemPpAQ+5IleQbuw
 L2zNnGEzh+pTs0jgg+SXofI3FW7MI76H2GU0J6ywnQY+IBCpSGxLE2d8W7XSkeofq2mW/y
 QNPn1dLBBeGDx/LRevT9hsJWysF+gGc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-A4ydqzLoN0WDwpGydPG2pQ-1; Wed, 16 Sep 2026 17:36:18 -0400
X-MC-Unique: A4ydqzLoN0WDwpGydPG2pQ-1
X-Mimecast-MFC-AGG-ID: A4ydqzLoN0WDwpGydPG2pQ_1789594578
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-530e89b584cso1364751cf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789594578; x=1790199378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ruJ34mVTBKFRGqovWKs9/aGpon/uDErFImIoiP6PipI=;
 b=ToZCKMwO1uYYVpRLBEVlRjkGOhPvHaTa1+40kU4Yq2NInGhdZH2ViGzo/HO+YPumz9
 QJIRf9to5i/r4RsDtxkYJNqJEfA+WvkGweW1G8zMu4QE0imR47tg4QFC3qtBmPOaCJ9w
 EncpKc8nD+Rg9G45i3YxJfsHPyej7jV/PIP5RXIOLziD3j9wkNwio3dZmKUGnJMpqY+C
 8qRy6EhUig67kOMuRlLxrNFKHk8P7AB6H78eMTgy7qzVgPFAArS7AaQegb6IyolSm3X3
 18/sM6nOAab6laQkr/LaYNiBvuhpCzOwCJVFGtgG2zLyQzJjwFFpwnHUZalv3zTBQwXi
 vKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594578; x=1790199378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ruJ34mVTBKFRGqovWKs9/aGpon/uDErFImIoiP6PipI=;
 b=GXz0cdVP8xm+NcCraBYWmn4ebwaxf/ch2W2KllAkdAg0Aal/dctTGWN/01BZaBZ7Rt
 ykd7oOW3OxfRhEyH5v+zNa8sTAs20ynvAyQhGguC2h15zmZrt35aRDYz5MpYAnuO1UTL
 9lAyzIJxG7/jitXQlYK9t5QUlptP86N7PTEfJJszVrS9nILjl4z/DjEDGjxJ4eUbV1pt
 maE5tSBC4CBULFusTuU0fQQGJN2NrQV40mza6Ou6Lbc8Of2O8E/l7g6Yr+NcjVQziwYn
 oNxsvIP8vQTJHEvrsxFOUJ4BkhlCiaDaL6T8a5GwTTDe01ZBLLNvX6XHcuX/x2pauU4D
 5pHw==
X-Gm-Message-State: AFuF++kKGSYkrg7sUQfAsW6ZfiStZYT3NAiWH54ADgbJh9SBMRlaf7az
 bO5iueTb/K0CqyevGUOzT30d9wvj389vScLBHjygkzwoaLROddd+GJYZ4SlyhkopQgx17Gwpvpf
 ZLWy8QXeZiC6feL7xAlW0g8hdRzJ8MALwo7csApSbt+VEEt3WoDFwuKBSjW6XEYsBFZXrciIMED
 OXI8Gq3vVEMWBpAzE8VnmTb8wYThyPBEwkVcvrRicm
X-Gm-Gg: AYBFou3FTpq0sebx9+HKzaQQv3Wp3MWRqL8Idk1Ame0dI1PRjwUudC3BlsGlxd2UCwx
 +9Z5MEv4C2i8zy3CrmzM7gl3yZ+Btra5gmuhnwCeVOuZN7NhRDvPta+W9NeWyxik+Fhd8xA3vEm
 4L4I1DyFprmzeQNcNyNGEAPRWeigD9Vwh0v7D83gbhLt3QgerttdRTOZZBXqDE6A4gQaRiztTf6
 ol6W+1Ab8Ji5HhN6c5Jc7xLryA3ayemFG9P0OzrIToQQj9Hs3t4QCyNt8emF6WJ/R1DTAh/lwxi
 yAh8WwIlQV3GJu8qm1ZOfkoBvi9LSMypdQPTXQuIOOLaMNsF7Qv05nASkqG5onv4izk2JHwBag5
 mnzxqjt0IB7sySh1LygVvrm2SxRIFvGHKetKruOtDKxJNT/gnCytqe5rAiq0=
X-Received: by 2002:a05:622a:1453:b0:531:175c:4d11 with SMTP id
 d75a77b69052e-5327f598a2bmr71127091cf.48.1789594578023; 
 Wed, 16 Sep 2026 14:36:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1453:b0:531:175c:4d11 with SMTP id
 d75a77b69052e-5327f598a2bmr71126661cf.48.1789594577501; 
 Wed, 16 Sep 2026 14:36:17 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123be946f0sm34849616d6.27.2026.09.16.14.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:36:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 4/7] migration: Split migration_channel_process_incoming()
Date: Wed, 16 Sep 2026 17:35:55 -0400
Message-ID: <20260916213558.587304-5-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213558.587304-1-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce two smaller functions for it,

- migration_incoming_channel_install(): peek at channels whenever possible,
  and install the channel to one of the slots (main, multifd, preempt)

- migration_incoming_error_propagate(): handling an error happened during
  channel establish phase of an incoming migration.

When at it, move the set channel tracepoint into the 1st helper, replacing
the existing tracepoint with trace_migration_channel_process_incoming().
So far, they should fire almost the same time if the channel peek worked.
This fact will change in follow up refactorings.

I also moved migration_ioc_register_yank() to be after identify, hopefully
it makes more sense: we'd better be careful on registration of yank, or we
should be prepared for explosions.  Previously it worked, my guess is when
error happens we never unregister yank but hang dest QEMU or quit,
depending on exit_on_error value.

No real functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c    | 57 +++++++++++++++++++++++++++++-------------
 migration/trace-events |  1 +
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 266ae8f776..8407ea46cb 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -197,6 +197,42 @@ out:
     return channel;
 }
 
+static void migration_incoming_error_propagate(MigrationIncomingState *mis,
+                                               Error *error)
+{
+    error_report_err(error);
+    migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
+    if (mis->exit_on_error) {
+        exit(EXIT_FAILURE);
+    }
+}
+
+static bool migration_incoming_channel_install(MigrationIncomingState *mis,
+                                               QIOChannel *ioc,
+                                               Error **errp)
+{
+    MigChannelType ch = migration_channel_identify(mis, ioc, errp);
+
+    if (!ch) {
+        assert(*errp);
+        return false;
+    }
+
+    trace_migration_set_incoming_channel(ioc,
+                                         object_get_typename(OBJECT(ioc)));
+    migration_ioc_register_yank(ioc);
+
+    if (migration_incoming_setup(ioc, ch, errp)) {
+        migration_start_incoming();
+    }
+
+    if (*errp) {
+        return false;
+    }
+
+    return true;
+}
+
 /**
  * @migration_channel_process_incoming - Create new incoming migration channel
  *
@@ -209,31 +245,18 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
-    MigChannelType ch;
 
-    trace_migration_set_incoming_channel(
+    trace_migration_channel_process_incoming(
         ioc, object_get_typename(OBJECT(ioc)));
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         migration_tls_channel_process_incoming(ioc, &local_err);
     } else {
-        migration_ioc_register_yank(ioc);
-        ch = migration_channel_identify(mis, ioc, &local_err);
-        if (!ch) {
-            goto out;
-        }
-
-        if (migration_incoming_setup(ioc, ch, &local_err)) {
-            migration_start_incoming();
-        }
+        migration_incoming_channel_install(mis, ioc, &local_err);
     }
-out:
+
     if (local_err) {
-        error_report_err(local_err);
-        migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
-        if (mis->exit_on_error) {
-            exit(EXIT_FAILURE);
-        }
+        migration_incoming_error_propagate(mis, local_err);
     }
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index e755872496..c5fa88fe8f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -207,6 +207,7 @@ migration_start_incoming(void) ""
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
 
 # channel.c
+migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 
-- 
2.55.0


