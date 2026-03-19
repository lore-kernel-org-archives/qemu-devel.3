Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB134109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYX-0001Pt-TR; Thu, 19 Mar 2026 19:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYW-0001PZ-Ol
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYV-0001bx-4P
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsHlTUEhhNOjys8kon0snbRzLZZAGqbckreegTmuncE=;
 b=iR/Vjf4wkM1Phij366R6fM/q4WpUEyYSc11EQJ4tJW7bCLKFALtwkTgLkOrhYP74wR58Ke
 UmVuiB/acuIWObe3XAM0D7geQmxoz5mTkiKqLsPEeimISNbkKDWDVXKGe5wMdrk+gQxCUW
 7hVR7Wrwdiw4EvFsfgmGJgDHdPpqnkE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-oDgWHqbxPSGTzaefkCfwYA-1; Thu, 19 Mar 2026 19:13:28 -0400
X-MC-Unique: oDgWHqbxPSGTzaefkCfwYA-1
X-Mimecast-MFC-AGG-ID: oDgWHqbxPSGTzaefkCfwYA_1773962008
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5091ee9f1d8so120914631cf.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962008; x=1774566808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsHlTUEhhNOjys8kon0snbRzLZZAGqbckreegTmuncE=;
 b=tujCAcUQwsBfPjkXU9iPcsuPKfPIsJxF8YEwYJhnHvYEp0zxkZQrG09nb127FcLy36
 D2U/R7K8y623lsSj9DtH5QzyEABSa6yq5xMx75zY5BuMXhPm/lnsVdAnqHnUulFGXYXw
 awsjYrhEVDKWZcEdi+z/spUMsdf+mP4PzqMIVuNnjtQwdXHsTzlnVwy3OuHXDBl/Gs9V
 NwaUZ8LqPQOPuRkIMzpq4UWVGI1j063g4hP1j+jSgFIhfAF45Ap7RsRPkXZgoDEqbhLa
 9N5LMjNAQCjX6ZLuPGrX0VF+CwNWzwzZF8uj5si8SE3yJ1iVOzDYSx2gmwi7PeSnsPJj
 T/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962008; x=1774566808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bsHlTUEhhNOjys8kon0snbRzLZZAGqbckreegTmuncE=;
 b=QmwjI2X9VMI4KvapMaMUnGY6yWfKucxe2bxsXeZ7JaO72ONFZIviym3tr49JhR4Mt2
 YZsyME2BJf9ADbiolZHGC3Pf852FE9ckFvxYpEk89SvENGBZfeq6Cn5hhRdWD8WOs2Ra
 IQ+O+3MrQMgMm6lDoXS85MAdCjrQqck9XT4eGBsQa5RYQV1Xefcf8ydKIXTfB1cZSabV
 7XBELB4omrMwTF9C3poD1duQqBPIlbcIhBJ6hKvlzp86nvrSMW5lkOt3UV8lFMoDSkaA
 TcgQ6ZGBZtdWTYtzgXYasjF4bWoBmK1zNU+gFAYgB7pD2SxWJo5cCNFRCR3Vch9KhkX7
 si1w==
X-Gm-Message-State: AOJu0YwhT6MLp8HCFAyEi5svTKDaNSa/clHSqI221qJ68KVSPL2QPC7S
 t6FCqvGROOkwKrpB5Qbkh1PXEM8MKbukB7YSk9quNLEtanKkxXfDBVzi1P/jPnf19CNQInVbs80
 9j8j7NBiyMvmspUseM6nJ/JcvVJwSrhBHcWUoUYcx/VL75ue4VYgxbsQaS4KmuUnS9yLC/IRXB7
 Ae0w4QHo/ohBg/dv0Lwpg+DM7LsH53ztxkbzI/Wg==
X-Gm-Gg: ATEYQzwmxVypaLObHiySIf0UUEUTiZH4BK8OtejvTGEMkYRcgtwsgtkRB1AgN5r1TnH
 Zam6vC+EHcb+kHZfHSqX2rYtqdfcDk15NljVJFvJoMCnAEku8/Tv2FKUpZfsUMXGc4M0SrCzRRv
 k8rg5Qu2vGWH8WoyEIKGHmwoU7hqTipJj1Pl7hYvQ9muMx1Oc9Ha56GvFPkM/DVE/dOoup7zsxo
 ew5VvtxEWUc9bHn47rYGuMadDlwUdeMIT9u/tbe5rZQdGhqPDL/tLzTr8zPJW7HqAolLChxUcCh
 pEa1gXae/lmiJ19VviphGTWxfTM4PAAJn4LT/uPWSc3xnnBAHQO5uNhY8gn8xQZhdwTBnbJZ7bI
 sjlG3ko8gNy5v6A==
X-Received: by 2002:a05:622a:1181:b0:509:205:230f with SMTP id
 d75a77b69052e-50b3702fcbfmr15596941cf.4.1773962007876; 
 Thu, 19 Mar 2026 16:13:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1181:b0:509:205:230f with SMTP id
 d75a77b69052e-50b3702fcbfmr15596521cf.4.1773962007255; 
 Thu, 19 Mar 2026 16:13:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yong Huang <yong.huang@smartx.com>
Subject: [PATCH RFC 09/12] migration: Make iteration counter out of RAM
Date: Thu, 19 Mar 2026 19:12:59 -0400
Message-ID: <20260319231302.123135-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It used to hide in RAM dirty sync path.  Now with more modules being able
to slow sync on dirty information, keeping it there may not be good anymore
because it's not RAM's own concept for iterations: all modules should
follow.

More importantly, mgmt may try to query dirty info (to make policy
decisions like adjusting downtime) by listening to iteration count changes
via QMP events.  So we must make sure the boost of iterations only happens
_after_ the dirty sync operations with whatever form (RAM's dirty bitmap
sync, or VFIO's different ioctls to fetch latest dirty info from kernel).

Move this to core migration path to manage, together with the event
generation, so that it can be well ordered with the sync operations for all
modules.

This brings a good side effect that we should have an old issue regarding
to cpu_throttle_dirty_sync_timer_tick() which can randomly boost iteration
counts (because it invokes sync ops).  Now it won't, which is actually the
right behavior.

Said that, we have code (not only QEMU, but likely mgmt too) assuming the
1st iteration will always shows dirty count to 1.  Make it initialized with
1 this time, because we'll miss the dirty sync for setup() on boosting this
counter now.

Cc: Yong Huang <yong.huang@smartx.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-stats.h |  3 ++-
 migration/migration.c       | 29 ++++++++++++++++++++++++++---
 migration/ram.c             |  6 ------
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 1153520f7a..326ddb0088 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -43,7 +43,8 @@ typedef struct {
      */
     uint64_t dirty_pages_rate;
     /*
-     * Number of times we have synchronized guest bitmaps.
+     * Number of times we have synchronized guest bitmaps.  This always
+     * starts from 1 for the 1st iteration.
      */
     uint64_t dirty_sync_count;
     /*
diff --git a/migration/migration.c b/migration/migration.c
index 42facb16d1..ad8a824585 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1654,10 +1654,15 @@ int migrate_init(MigrationState *s, Error **errp)
     s->threshold_size = 0;
     s->switchover_acked = false;
     s->rdma_migration = false;
+
     /*
-     * set mig_stats memory to zero for a new migration
+     * set mig_stats memory to zero for a new migration.. except the
+     * iteration counter, which we want to make sure it returns 1 for the
+     * first iteration.
      */
     memset(&mig_stats, 0, sizeof(mig_stats));
+    mig_stats.dirty_sync_count = 1;
+
     migration_reset_vfio_bytes_transferred();
 
     s->postcopy_package_loaded = false;
@@ -3230,10 +3235,28 @@ static bool migration_iteration_next_ready(MigrationState *s,
 static void migration_iteration_go_next(MigPendingData *pending)
 {
     /*
-     * Do a slow sync will achieve this.  TODO: move RAM iteration code
-     * into the core layer.
+     * Do a slow sync first before boosting the iteration count.
      */
     qemu_savevm_query_pending(pending, false);
+
+    /*
+     * Boost dirty sync count to reflect we finished one iteration.
+     *
+     * NOTE: we need to make sure when this happens (together with the
+     * event sent below) all modules have slow-synced the pending data
+     * above.  That means a write mem barrier, but qatomic_add() should be
+     * enough.
+     *
+     * It's because a mgmt could wait on the iteration event to query again
+     * on pending data for policy changes (e.g. downtime adjustments).  The
+     * ordering will make sure the query will fetch the latest results from
+     * all the modules.
+     */
+    qatomic_add(&mig_stats.dirty_sync_count, 1);
+
+    if (migrate_events()) {
+        qapi_event_send_migration_pass(mig_stats.dirty_sync_count);
+    }
 }
 
 /*
diff --git a/migration/ram.c b/migration/ram.c
index 89f761a471..29e9608715 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1136,8 +1136,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     RAMBlock *block;
     int64_t end_time;
 
-    qatomic_add(&mig_stats.dirty_sync_count, 1);
-
     if (!rs->time_last_bitmap_sync) {
         rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     }
@@ -1172,10 +1170,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
         rs->num_dirty_pages_period = 0;
         rs->bytes_xfer_prev = migration_transferred_bytes();
     }
-    if (migrate_events()) {
-        uint64_t generation = qatomic_read(&mig_stats.dirty_sync_count);
-        qapi_event_send_migration_pass(generation);
-    }
 }
 
 void migration_bitmap_sync_precopy(bool last_stage)
-- 
2.50.1


