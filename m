Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D0310F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSq-0004bx-FM; Wed, 08 Apr 2026 15:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY3l-00063V-60
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCQ-000292-NX
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hD/iKEkJCQLVYmt/ko9Id263R4U72ejWLOEm2tj8VI=;
 b=RZh6bLeVQXv3MOxziswUAT/s968LXLq+5h9U0XkYL+TfM1F/L79vv157LTKSVD6/1FU8ED
 hz8MiNLapkq5Dtzwc3qb2nRo/mGAXY+PG31alFF81GxG7oor8e+/pWRUZlaoPkPmW1O4xH
 Ag24i2FXwbtOC7r3dfsHnozUMX7lNO4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-4x2l-3FPNV-p47qJrOZcDA-1; Wed, 08 Apr 2026 12:56:17 -0400
X-MC-Unique: 4x2l-3FPNV-p47qJrOZcDA-1
X-Mimecast-MFC-AGG-ID: 4x2l-3FPNV-p47qJrOZcDA_1775667376
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4987c698so2805501cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667376; x=1776272176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hD/iKEkJCQLVYmt/ko9Id263R4U72ejWLOEm2tj8VI=;
 b=MxCI426jDoyLbdOQKgMuAG/PP9y/DgZORY5K/ukK6F/08c2R/xLDcVjPDqQTLrdfik
 MFMPr7V4RSjNk7OZx18V4HI1B9cl7WLixToHp/3D7/UCxFNhGoMSR4E/jQi3x9KVRsCO
 DNtZsufLCO/nGxa3Gx3SU3CQg4mZS+R7PLsB9h2L/p+TysDCEEI3j5JMFwabP08NLPEM
 9P6Up2wdJSA0ULn6btyqoKiM1foidKQihpqQ4LHbHO2zLaebKYQkImXoxCajsCo2X/+9
 cY4IJvxFuNpmQ3pmnAZYzUWxars4OhCoMDEiu9Oaz9m2gkPJNqawfKo/kjvQj1ncpy66
 885w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667376; x=1776272176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5hD/iKEkJCQLVYmt/ko9Id263R4U72ejWLOEm2tj8VI=;
 b=WnLuTE+oTRduMtJXoNkRGLgf95lvmBxdW74DCYgBzAKGxQBA9GdN+FLwqA/osxHe7W
 5l0msz5Oz32eqHbZM5ndhb1QXW2zTIgMiHVWQAnQ3mYs0MpNPfi4SNQ5VhHtQq9kS8Lm
 hUINoB0QLnkG7Ean9/3Gj6FF6O3zJudW0IuBN/atPAaEIMgFCdthH4nUcbANBPmIkhMl
 gEdo5CH9cQpuFezcdbaYrzQmCcOl1NSBCFSi3cOTv2zAejvm1KNqDMRf2e1dIp0Fzltm
 KPR/El5HLK1atUPUGDc/DEhwKiiz462CNoHOhv/0WiH8nmNqz2Hbq/ek/munyyAylzHC
 QMrg==
X-Gm-Message-State: AOJu0YzD9oXLQbMMp80j5AMJ6j5jaTqRKRxUFLgqwuZdh3xgB0LxO538
 ocMPwlJcRF+262C4wLjgKA7ULgucCJkrqZJZDv11XqO7Bdow7iCzwA+arPDjVfxUyLK49tJVI4D
 YYBLlLnXPEGMhX4oBgSDc0SZRIyhCcxPOYq7GAgzElcGtl2xpXnVpLkgf6jBgieSuTRiSsMVolU
 swG6huKqa9elpvoAksmgh97qjh/GAuyMxZXj8vIQ==
X-Gm-Gg: AeBDieuh+8oiRFi1KS45S0v4GiXb0nkEWwg4U6BYhJGt/bno/ff0+uFEWwPfktEhNMH
 JfvtYHvPsmedDBeOFU8xV5erMwx/Qqujp6Hx0RUcXikoentq8bBe3Lv/Hv76A6gnHtGwsVQah0M
 9gX/kPzFVL5BUmD9lNS4J02c+v6PNh7RFwb2MzfS/NyMF36xsfuN32R06F1zKoDnU8XfWuWEmKN
 RUC9pF09KnZJC6y77ATFC4RMPJIOGpzINzkttbSX2ehxb/oBvKMVS88OBK/9G5jltnOsazjrCTE
 W0pLInSqAgdfzsXo3BOl/oViDPahyUmUDBSnRA8GRvzL556OKj9EC6YYsKlryuOYB2EIzFtqExS
 0ei3NCSnf7sDNx46jYgXLrxwAMQQGTCR4DB6viyXoY80q
X-Received: by 2002:a05:622a:1207:b0:4ff:b32b:cdf9 with SMTP id
 d75a77b69052e-50dc1a1b80bmr3300321cf.14.1775667375838; 
 Wed, 08 Apr 2026 09:56:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1207:b0:4ff:b32b:cdf9 with SMTP id
 d75a77b69052e-50dc1a1b80bmr3299731cf.14.1775667375169; 
 Wed, 08 Apr 2026 09:56:15 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Hyman Huang <yong.huang@smartx.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 09/14] migration: Move iteration counter out of RAM
Date: Wed,  8 Apr 2026 12:55:53 -0400
Message-ID: <20260408165559.157108-10-peterx@redhat.com>
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
index a9ee3360e1..57d91ad9e3 100644
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
 
 /*
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


