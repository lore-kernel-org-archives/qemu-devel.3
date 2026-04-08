Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655E310F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYQs-0006nW-A7; Wed, 08 Apr 2026 15:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY0I-00052P-9b
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCK-00028B-05
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0qTHjD0q4Ya9dJ7GpDTbLPVx/TGmnxCqtBUTkBdLKA=;
 b=Ctbqi8KaGxfcU511hIcWRx04URdljM5DEFzjVbIHTgAkFKsRFEsbqoGxDT+FNnZC3P+Mig
 0jPewPhZjnhdpjzkKhlWN/wo81CvmYGyXdxvpe7YVQIj5lmMd3QXPxRGlBMB+xl2qP9oBd
 Gg1/CTafo9oZ31jgFhMPRs/rG7UmQjE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Yqkji9IZO_iUxmYY7dLeyA-1; Wed, 08 Apr 2026 12:56:10 -0400
X-MC-Unique: Yqkji9IZO_iUxmYY7dLeyA-1
X-Mimecast-MFC-AGG-ID: Yqkji9IZO_iUxmYY7dLeyA_1775667370
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so3214891cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667370; x=1776272170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0qTHjD0q4Ya9dJ7GpDTbLPVx/TGmnxCqtBUTkBdLKA=;
 b=XAmqfikupgATTl82knCH6Rwqo2ftrq4OSOVDxHgBM7PvHKGd1r4+Gw0IJOE6jE/s/e
 qclweKKVwyeiSboI9TkmlIUO3vg58MEzB+GkGEts0BiEXhVNzvWhN5WCrQY5bSfk/0mN
 RPqBJ4dTZsu3RtmkmpxFv83lRB5GOjU3tir2sP28i8HjlTsbWYa9vgCse2ciS3egTbLX
 5wuICgma0+4NPNO14tqsYg/+9vjiwU0s9557DBK1PyoLDPQiDexNR3f5dG7EKCVcpi1z
 KpP/JfMbjApal7YHBUYq3ZMAxdX0wzgZfSmyps+ylxDrtoysY4pXYNuduH0C0QfNCfz6
 dbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667370; x=1776272170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d0qTHjD0q4Ya9dJ7GpDTbLPVx/TGmnxCqtBUTkBdLKA=;
 b=YFe4Ql2Xxy0RpI3F3z0M+2GPT49fZux7fO9mkXhgyDv3f9r7ojbWWjERvX7DEy23GT
 2ggeyHyQ1RVHxLxgdRUZ4JM23XdYFnFCziTNkdeLMZe+Oo2Ft+PRQPfyFL11UhJuLbd+
 4CQwUMbDQlt1RCHisaWQDKkZx5ZGqKo7fTVXMhD+RVMxqbwBOKzjNqUKyFr3S+fxXwJ5
 LuRgm0w9kPCcGC+Hk5yCGBxepyGrnGMTUM5/BaABZY8p/b0qWP69pEvWsYnlX92MQKWZ
 a6InE7TJmGOBuFlGl43hqY/MTK3RBVw1VJ0IjJ57zohECG9Nli3RwdYOpBdwmKXvXl3H
 7Yug==
X-Gm-Message-State: AOJu0Yx2bhVdMUAsJ1MiLM9R5w7i1UbNO+j1jz6RAzu1TAS5vXTYFnpi
 Q4UUJcpbG71fMVVfGTOspVpLWW9IBZXaOyZpWrHGV0ZFE9hAcgqAI/YrfPFysRZJTW3G44zKkXE
 HUUFHSKKhm/BbiZS7OPrzEmkamoGoZEsMFVUy3hUPQllE5RBSAWIxTsAuONclJCA9+LYmn+t+hv
 K/rC7gw31dmGs+0H6xNWl+02lEW6SFvQtlIoueOw==
X-Gm-Gg: AeBDieuqVeDV64vyGI43TU2VjSkgQYKvwRKQSSn43Ok3wMl+2MVT+e8BuWioBalSVOw
 ST+J5v0vFb9C0XV0YenAWY+GCiSQ6Fqo9J94j+aCwQsrrBHzB8lso5sMGfsxK8qQdE5/Xn7eqkg
 MvTu0qvD+CDfAI5jhuUI8SYvAoUWQ+ex6EXbp8/vNbYJTBw1ZXECp18VXlluWfVLcG3OMl6SiqY
 RuypcryiCFIXJaFK0jBnwfbcE06DeIkyUpzKeWoC5o4Ul0RhG4lmozsezFL9Qy+A1IvqSPlzw6y
 q3Dw3McHKJmq+q0HiPdGbi7HRTSzmSKiqcHPF+ZCKDHyM1htiSDDZSl+ncmeMTIvPVbMYVkmQe4
 jxXCPeE1dqemYW1AD2hd1cWWMV2fR3p1ggLGMxJBLP9Ga
X-Received: by 2002:a05:622a:1aaa:b0:50d:7e1f:9cbd with SMTP id
 d75a77b69052e-50dc21d7d2cmr1424321cf.25.1775667369466; 
 Wed, 08 Apr 2026 09:56:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1aaa:b0:50d:7e1f:9cbd with SMTP id
 d75a77b69052e-50dc21d7d2cmr1423691cf.25.1775667368648; 
 Wed, 08 Apr 2026 09:56:08 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH 05/14] migration: Use the new save_query_pending() API directly
Date: Wed,  8 Apr 2026 12:55:49 -0400
Message-ID: <20260408165559.157108-6-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

It's easier to use the new API directly in the migration iterations.  This
also paves way for follow up patches to add new data to report directly to
the iterator function.

When at it, merge the tracepoints too into one.

No functional change intended.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h     |  4 ----
 migration/migration.c  | 16 +++++++---------
 migration/savevm.c     | 23 ++---------------------
 migration/trace-events |  3 +--
 4 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index e4efd243f3..96fdf96d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -46,10 +46,6 @@ void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s);
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
-void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
-                                     uint64_t *can_postcopy);
-void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-                                        uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index dfc60372cf..68cfe2d3bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3204,17 +3204,17 @@ typedef enum {
  */
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
-    uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
     bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
                         s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
+    MigPendingData pending = { };
+    uint64_t pending_size;
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
-    pending_size = must_precopy + can_postcopy;
-    trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
+    qemu_savevm_query_pending(&pending, false);
+    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
 
     if (in_postcopy) {
         /*
@@ -3243,14 +3243,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * during postcopy phase.
          */
         if (pending_size <= s->threshold_size) {
-            qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
-            pending_size = must_precopy + can_postcopy;
-            trace_migrate_pending_exact(pending_size, must_precopy,
-                                        can_postcopy);
+            qemu_savevm_query_pending(&pending, true);
+            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
         }
 
         /* Should we switch to postcopy now? */
-        if (must_precopy <= s->threshold_size &&
+        if (pending.precopy_bytes <= s->threshold_size &&
             can_switchover && qatomic_read(&s->start_postcopy)) {
             if (postcopy_start(s, &local_err)) {
                 migrate_error_propagate(s, error_copy(local_err));
diff --git a/migration/savevm.c b/migration/savevm.c
index 392d840955..397f602257 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1778,28 +1778,9 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
         }
         se->ops->save_query_pending(se->opaque, pending, exact);
     }
-}
-
-void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-                                        uint64_t *can_postcopy)
-{
-    MigPendingData pending;
-
-    qemu_savevm_query_pending(&pending, false);
-
-    *must_precopy = pending.precopy_bytes;
-    *can_postcopy = pending.postcopy_bytes;
-}
-
-void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
-                                     uint64_t *can_postcopy)
-{
-    MigPendingData pending;
-
-    qemu_savevm_query_pending(&pending, true);
 
-    *must_precopy = pending.precopy_bytes;
-    *can_postcopy = pending.postcopy_bytes;
+    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
+                                    pending->postcopy_bytes);
 }
 
 void qemu_savevm_state_cleanup(void)
diff --git a/migration/trace-events b/migration/trace-events
index 60e5087e38..f8995b8d0d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
+qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", postcopy=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
@@ -159,8 +160,6 @@ migration_cleanup(void) ""
 migrate_error(const char *error_desc) "error=%s"
 migration_cancel(void) ""
 migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
-migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
-migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
 migration_completion_file_err(void) ""
-- 
2.53.0


