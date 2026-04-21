Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74736F94CAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbI-00010y-N4; Tue, 21 Apr 2026 16:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbB-0000xt-6h
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb9-0008Rb-DR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyCQ0G6YIo2w22cNA+aGKrtBN8bxCdOvHJsgQDrXsUI=;
 b=KQ8DF3R/IEKf8XwXg+0n8Rm0QdN0nHfSb2VYnVOwBsn694pISZuSNYEcFeGd3N/rtZnRvB
 9eL2FG29ZnHBlHU+onF1fzdTRDr2K+H8CfVje7PHnX+i7UmD0f0bn/TJ4m9mF5p0lBh1Sx
 aaRAPHkfFhURr5MaIQEj0BRstp2LVyk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-jexQ8lLwPkuCz7eSybJSuA-1; Tue, 21 Apr 2026 16:21:29 -0400
X-MC-Unique: jexQ8lLwPkuCz7eSybJSuA-1
X-Mimecast-MFC-AGG-ID: jexQ8lLwPkuCz7eSybJSuA_1776802889
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca6f796d5so78637766d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802888; x=1777407688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zyCQ0G6YIo2w22cNA+aGKrtBN8bxCdOvHJsgQDrXsUI=;
 b=nYLQ90EBhYSbSvUkcfq/KLtwRF8jBhalbwe8xgMXWPTIL66mwJ8HGehKIPWwJ8NkKE
 JxsvpSTOsp/b3esGCVDL60+gHOIJAnNytknNEaLREs0U7PeHxU3SVJb6CK3ur8Aovfp4
 eWDIQJ/PxoJ40HAoio9CgyzMIMhwuuSRX5mX/apIkUGlD+E4KIUQhX6pjfz+j/JEMdbm
 rJxATpKcqkTnUXbgQ0gXII3yqp/CJagLYTYHiSwkgCme0m3TXyHQlq7zztDOqG/C5ub1
 1bSS/KjXrfUodIPSuXFytOHPpBPn9vbI1Je0EuD5kK1N6fvi8RvqGN3hskJmTA5j0nnD
 /UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802888; x=1777407688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zyCQ0G6YIo2w22cNA+aGKrtBN8bxCdOvHJsgQDrXsUI=;
 b=MVN1wICCpsHlbaCEodk5B506m2DlZe4Yk23XXTGNtedIpl5dyKZxrZUdtzvNlCwi2f
 iSVh7cNvzveaB11zQbIbLSMcUfYbPFRwZao9Pe5LhbkSuDN2ncK2MKW3mm9H1w42XLFq
 KmakjSn9BjHJL4PNJ7bEX9pHqUbTPFGnyzQpWZW8c9u7eqnHpMAtOewHBSvdhPNUr3qX
 H0WaTRi0wHjo0xvW4f4SfNPD6w0moBo8w4VztE1p54PXmRhdhURV8xVAFypEJnhKUd0G
 RAqndTeQNZtd4slzOc40z5JztT4cSylI/t0cw+Go33/9KHFSfKOYuO/5bjfw3KOJHPBa
 EDUw==
X-Gm-Message-State: AOJu0YwY9liU+dA9wvtcIHPKLzaPdYsJ/+ZDjlxbcJN+eTDWGQr7C/JP
 LYcmEzgUOgTjbT0U1BAox3EYizHHkBAGFA3pnRBE6C0etPxTEbHDB9Ry3RU4dve0AdofmbJDqCA
 pBZ6Qc+2KhL1i7PK/ASZtXDeZq0m6Jlh+7tiJc5paVAStFoknNmtg51A06LAVVS6xA2H6q/QdFV
 yIatpFZH6biAlHFcfoY6eBvPRM9AmH4oR/X2gKQw==
X-Gm-Gg: AeBDiesksd/3oaoYPsHorLRU7SMcSdGPd6qjB12VPiLp8udBgoBw4iT+LK9WtjKAkpc
 MiwB2jmFOyFFU2pWo0ZPC4i2kvoyJU0qufhiqEn1SFs+m3sr1A9ScTMGWwfavfQUuAj7FJcbOvN
 B8uwo1nSwW9fHjbhDuBEzXQ6/EvxNZFNeqRijNhDxphXct9y7BAGoncDIR5n+62MbXZDszYKGgm
 W1Yc5J+GzyBBoauouHB4loaWfgnnODVCujc6FaQMDmWaef0a9cSvrZXa11Vz6r6WgAqv1e6zhNt
 YFFCV8bE/ZxhC+TxuUYxeQjvLiO5nYLbu8SH6bY7gNMwBESvCY+p585IrZgCHM/pGQKfC1dqycT
 quYosyFU/OXGxlRT9PVmO855ximiF84gBRECFg+e2rqR/vAr0DRS7/OkM3w==
X-Received: by 2002:a05:6214:d47:b0:89c:8a0f:55a0 with SMTP id
 6a1803df08f44-8b0280923demr315154236d6.16.1776802888418; 
 Tue, 21 Apr 2026 13:21:28 -0700 (PDT)
X-Received: by 2002:a05:6214:d47:b0:89c:8a0f:55a0 with SMTP id
 6a1803df08f44-8b0280923demr315153596d6.16.1776802887829; 
 Tue, 21 Apr 2026 13:21:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 09/16] migration: Move iteration counter out of RAM
Date: Tue, 21 Apr 2026 16:21:03 -0400
Message-ID: <20260421202110.306051-10-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
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
index 4b54fda4d7..e3f82baaac 100644
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
     qemu_savevm_query_pending(pending, true);
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
 
 static bool postcopy_should_start(MigrationState *s, MigPendingData *pending)
diff --git a/migration/ram.c b/migration/ram.c
index e5b7217bf5..686162643d 100644
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
2.53.0


