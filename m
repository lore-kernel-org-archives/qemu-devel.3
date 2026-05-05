Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060D7CD343B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMN-0004bC-2G; Tue, 05 May 2026 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMB-0004Sa-Mb
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM8-0002co-KO
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MloABw5GE3WIOEB46lkCJz/DCq9G15tQHSXMQreAC9I=;
 b=W2OJLdqCd1+8gEaUf3X59eumjz3vK8+ZFgvaravse+lwtQGw32+4K8fKubStQXIWJOfiXr
 l+gsCizO1GQDbOCcqTiwi3d3VaZQmWfMh+nRiYWwQcftc2gJI91XjWE8oYcTN55Eu/vtiU
 0lhpnGYN9pp9zHmaKjebLkOU1xJ2pHc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-UTfb5-BHNqGE6y2Syc4JWA-1; Tue, 05 May 2026 16:26:58 -0400
X-MC-Unique: UTfb5-BHNqGE6y2Syc4JWA-1
X-Mimecast-MFC-AGG-ID: UTfb5-BHNqGE6y2Syc4JWA_1778012818
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acaea1ffe7so142717196d6.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012818; x=1778617618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MloABw5GE3WIOEB46lkCJz/DCq9G15tQHSXMQreAC9I=;
 b=iFQtbsIv3pLopwKjSYa1ri9MA9S8wfvFDe5Vjd2RGHxLFFtnuJ5KilyRN6td5yvWoT
 SEhessTL6fRDEZfjVHc1mpLPa2YBPL8FXVMnxFAdTu4ngYX3/MNWkeSsn0dykwc1Kd74
 QXnuq11UIQe9vfLe3uzAQnFn/t0q1EIxkjQ7GkScoCh38THOxzQ/BcV3mUZ5zjpxDMaV
 xMP12P3kotfAb/bmk/t2Sq/zSwwwN2j8iA8z5u6ncNesTNX5gjrmwIJ463G1/d9GqVxE
 EYjSn75j77y4t6OmNyDQRR5WBxLtBSyvmRjetn4XWyDNp02fl4sm36HUX419AtYWrqUG
 VIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012818; x=1778617618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MloABw5GE3WIOEB46lkCJz/DCq9G15tQHSXMQreAC9I=;
 b=CrHMeYbpKU21t6hFAa8W+SzHlCtbnbjJqGbOE2cyCa5zdpvC9pNVCjbIMBTPIVzqUD
 xstzZFO8XwojiAjM/KNsNrnCeJox5Smo1S6XVeKps4oqBKRQnVOJ4363K1ReDBV/a6la
 XxklWY2rhnZO5Z2oOfGsOIWAUkc4VMzC18YbK5ydMJCKNIumwWnF7NVe4dnJc0MDlvSz
 eR9pu7w4ZNxUUim+LjZasN1Qhpyoc3nui1fXU5rzAabpS+PuRsOTbg1J0MFvUyHlxHQb
 gV6XRdEFJZUD8fhJ+vOoxGuzGtY3eTZg6dsJ2hbkPJOaRQCKXZpkVzgI4P8K7NsaAj09
 qIdQ==
X-Gm-Message-State: AOJu0YyBtG1bes8j5IFUTWGeA0Y5QSHwJ02W/xWXJXA8PL2qAglemh6A
 Zi+I6pQEQVvH1pvwPDAsK+EmgJb+gL1aq/06vIDP/rgt7Ikv1Fqj94iU0Yt0sTQGCa62jNv4ryC
 1aqUPdWO9/NWRKpea66jPBf/6xCn0XkZ+4W2R17q9QtGAQ+XG5VGRfDV9MVnSy/OMwtGR6HGVX0
 cUldua0u9aAejemk/5mh0fBBPk5lIwY6Krs01Z4Q==
X-Gm-Gg: AeBDievyq8iAG4oMsT//1pjYNsZ4MZlEmmz4tVn4qokqjGoyD5WvYbaikcesNeenqTR
 /DIHJawzHzPWmPSdDi9yN5HiOcyskMVK1w20dcZR2FLCsLZJF57ZtWiVxsaJdsPd+ijcatRAxJn
 Y6VSLcw0buKf8yYOovU61y701YuECO+bz1QY9jbLWTIXSzOmG4vJWhPPy48NiZlt96h2C//vP5E
 8eTOI/n/kK2xVn2BAvvS6OMZg3/uCWOb4Fy18cKJCNgW+QGUtZE5OlY8HiJMp9olVURWPChqsz/
 9c2JQ8wc9ZNlwtxhK4h8WLVwT6Ofj9kXAR7Giwq4sn0sMIr/eX6L6ep1tECP1McCTizTi+hgPBT
 z5tR0IgArUgrHCZwECrcubchAIvyxySB6xQHBW6Agg9yL01L3/U7or3Q=
X-Received: by 2002:a0c:e089:0:b0:8ac:acd6:c988 with SMTP id
 6a1803df08f44-8bc422a67f3mr5318746d6.1.1778012817573; 
 Tue, 05 May 2026 13:26:57 -0700 (PDT)
X-Received: by 2002:a0c:e089:0:b0:8ac:acd6:c988 with SMTP id
 6a1803df08f44-8bc422a67f3mr5318116d6.1.1778012816962; 
 Tue, 05 May 2026 13:26:56 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 11/23] migration: Move iteration counter out of RAM
Date: Tue,  5 May 2026 16:26:28 -0400
Message-ID: <20260505202640.1011006-12-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/r/20260421202110.306051-10-peterx@redhat.com
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
index 049b69fbe7..8abc7e0327 100644
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
@@ -3234,10 +3239,28 @@ static bool migration_iteration_next_ready(MigrationState *s,
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
index 44503bf3f7..ecd4b6165c 100644
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


