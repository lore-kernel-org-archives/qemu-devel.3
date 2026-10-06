Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A81CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENDW-0002nf-E2; Wed, 07 Oct 2026 04:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIet-0005wQ-Mb
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIea-0002Vt-Ce
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791344942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qb5aWMXBksVrUWaPolR+H12gXaZIP/HfLkM4YI5bNC0=;
 b=FG1nXkYXBQ09XgDnwJV1V4QGhEEckWkJaC2P5Z4DRj6J65LWNEe8qb/MJmJ/D6gRTCcndO
 6m1i/31Q5nksc7W7cQQXksRX16Uj3NhFsWeRT80PvOwKOPNoSYwx+EENbL9CQuG7yQdTJ4
 DYTrNzu91J00t3BDNgZbsXe0TDB5ikc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-2P1tNDSYPpGllox8S6zgPQ-1; Tue, 06 Oct 2026 14:20:55 -0400
X-MC-Unique: 2P1tNDSYPpGllox8S6zgPQ-1
X-Mimecast-MFC-AGG-ID: 2P1tNDSYPpGllox8S6zgPQ_1791310855
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5350c2b31c8so60241051cf.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310855; x=1791915655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qb5aWMXBksVrUWaPolR+H12gXaZIP/HfLkM4YI5bNC0=;
 b=TG3hw1l6R26uqa0PnNBGISkfxMWBsFb7mOES05vorJgJ5ZeccXiHgew/hY/2pp951S
 +OTGJ/qCX+BzRcar0youU6bv1MciKD7gwBYA84bajQUFacGv7OWSEb66OzTgSLscdVd6
 AVguAg0qi+VZe1F4QPHMrVQIf49TlgGIAQeIK6BvjQ8nlydkBRpCBXUD6qJq6WsHwL9k
 Sl1vZPfy/5mhKJf7hFuMp/wmzpKpcgXwHE3lOY5SFxLPCMEJgJmiImfTIbSWaPLW2iom
 o9PzPDHtRJckq96XeftuxdLAGkKl2IGnk8nqoN9SC1OYUkVVTg2P/OekjdzlUfr3nOBA
 qP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310855; x=1791915655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qb5aWMXBksVrUWaPolR+H12gXaZIP/HfLkM4YI5bNC0=;
 b=zjYRShu1oo7EjFeCrgkZU4I3FzUK8VBd+KI7daZRcti6J5IzAq+XF0Av0T5yxAepFC
 CPD+ICHi51bmVL9y0YBozJDsixgcIc74aqcB7RFYlPPaJx69zkOsx1DDZwKOkSveus6M
 vxYl7gO0cJmuir97wxZZnKuOOWxfHH22XMQuRoWKOvfAER4LxgI/nKsVXAqd5XqntyDA
 e6FSzJiQWLdiqr7pE4cM1HQ7nJa6Ex1RutvorOsHZgH/f2Oqvar+HP81xYYVGmjNKC76
 cFv+9j9yEQDFAIJ6H+tPiP3e2G3ojUjvfgZ/+C4lBHELzPSO+7TgAx0uSEyIDes2+7GF
 fGCQ==
X-Gm-Message-State: AFuF++nY30YyYRcdJ8HolC2+gCYMhnHZFIqy2NDgnLwt63M5Zdbbkw0i
 SEph5g8fGblVxWKBeOxTq0sZu8bNhKN4epgGCOQxbBnltIjp+6ZomH/rB48jtiVx38I7RlFN2Fw
 Z8h0b07vXh1O5w4l/fStCP/d5PMyioF8T74kNnDHWhbUqAbWui/ufUSe4SkovBpNF5o2UH/TRpl
 N0fNtuserXAEbMLbmz6ucUIjMI8e63iQiS5RCmbA==
X-Gm-Gg: AYBFou1iiI6Dv9ZjETz35eKPIlVlqpgNy8CApWHFKHJ1SoRoBEa1ivu6egUWDgKJ5Su
 jV4ZtZLHHECRj503D09k6CLv/JB1bTkZD5NkFVLJTCKrkh4m7iR8aN8OeD4nHQZJWSVFgLf0W8H
 c9Py+ZwQaIX9uUXt3Rq3NT80Ro3koqkt/Jt9V1X1pegF5UUpdPhv/1J9Fzt3MWNvDImmiS4I2MG
 AJ3+b1vNi2hBxewabh6xy/MJEDrhHTCz2fqPnQOybKO8L8L8942517jl6I0GRMV4dU1DVxCUuPz
 GcdxB6Q+z+B8WS5xDAz3jAl9e+OiAHMiZZ4+xDosHdzP3qWfLPfoYhbP2WlqXrUPhRCyLK0=
X-Received: by 2002:a05:622a:1a8d:b0:535:70c4:9a8e with SMTP id
 d75a77b69052e-53570c49c81mr12559661cf.68.1791310854529; 
 Tue, 06 Oct 2026 11:20:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8d:b0:535:70c4:9a8e with SMTP id
 d75a77b69052e-53570c49c81mr12558861cf.68.1791310853804; 
 Tue, 06 Oct 2026 11:20:53 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91996ba7b65sm115056d6.7.2026.10.06.11.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 4/7] migration: Split migration_channel_process_incoming()
Date: Tue,  6 Oct 2026 14:20:43 -0400
Message-ID: <20261006182046.3767283-5-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006182046.3767283-1-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
index 68bcf12dc7..c93c9f9e75 100644
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


