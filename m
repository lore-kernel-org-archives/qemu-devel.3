Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA7F1091932
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYd-0001RU-Rs; Thu, 19 Mar 2026 19:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYb-0001Qz-PA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYa-0001cq-8Q
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JQi7Vu+t66NBcDJkYGi6DnBUrFvI6/hQpALCINNvLc=;
 b=jCDyBBtxd29JeHNR422vdc6vxsdHc6jt73X7hlGhyosQXYFC5TxZo92TuNUPc1ACCxJVP+
 KVY9emOo8UHjdy+tvv3CbCefliW0eM0TvLlY+DrnAlrWtyUYjFFgvTReSy/5XLD7jFWuhB
 qr+Y6l64vV2jqMsEasR8Ur5TEKxcAOU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-hSbwh8HSO5uVRAD9QB5GoQ-1; Thu, 19 Mar 2026 19:13:34 -0400
X-MC-Unique: hSbwh8HSO5uVRAD9QB5GoQ-1
X-Mimecast-MFC-AGG-ID: hSbwh8HSO5uVRAD9QB5GoQ_1773962014
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-899eacb58a5so7196346d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962013; x=1774566813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JQi7Vu+t66NBcDJkYGi6DnBUrFvI6/hQpALCINNvLc=;
 b=imFri8WHKmcL1H4bqwwDBSJc2grzVsFxdr15q2pw7rZrkvYobzpdqh1KZIMRdZCso7
 mdTJs+hS5G78JBvoe50+OEAAS14FBqdmggnCg5Qnmu5YrY15WO2fcN35ualjarJ0yIm/
 7GSdHc/e/tPDl0RH3DyyK8tU0ctQBziH4G1S88KnsVQ/wNW/tPjoDuT4loFjOOYUA4r8
 RhOYMZ3RE1bisRxVQ2Ggn0JmnVRo47GsugdvOU/bBKIOPhc4Fe/OXiDRzvHw/R83Ld+4
 RVAUGr4/hIUxbttop6Lq743qbsB76moiDtd05KOaZnHzdgHTGcHFaFmsGRV95MMemNY3
 D0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962013; x=1774566813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9JQi7Vu+t66NBcDJkYGi6DnBUrFvI6/hQpALCINNvLc=;
 b=FsX1uvbWvPwjPbW/veRt26FsQe+s4BKvTr/eawnPmt0B7tAm7Dy2C9Kp0aHIfu8UHD
 4C0onFFGwutuMRhV+pYkUqhgu1gYC70xW2cEnA6AqTqUgkVTv3XSATpAM/LJ6VDiohng
 flJDL2PN8YuFMW1WAhbt4avEvxuH9RYJ2ttO84ngM5M1kUMBTmQA8mmJXHI2RUY8EoZq
 fLTQEyCeH7E8NpwG/B2liltsNReUS7outCTgFu7azjh5I9THFsqnUaRePSwpYsHD5e4F
 pK1dWzkcCZHoC2bZmXr36ITkcyQlm8U3PpI0qKlxFhTkRBusLHMvUzzcw2eRiHHeOw/c
 rPMQ==
X-Gm-Message-State: AOJu0YzcY0FZ8MAzDPss4DR+8zOigQEsJ18Me0JbUNl+e5KiRi5Rm595
 nEqf1n3divtgkQBoHrIRp1KQKaPrpkXlNikms/5v69Qr973+KCyctH0ah79Ma/PK6fARkc81w+E
 eG+aDthOCRjaApl0gu1FrJPgD0AXNL+foCtYZUmzcbtEy5iPoStDZK733IZkXEjOAry9lB113Iu
 H4qSaliHQ4ZKfYkvQr7xoG4/qEJb082o8qKalhaw==
X-Gm-Gg: ATEYQzzohKgxCdRp610GPyt2e2oE9xxnrT6UxNwHUICJm8UE2Z9CkouMqXiKlqvHXmC
 Mu+xzx8KG9m7UyCbRSrRIzNNtUwy2wrhQ9zPeRahRX9ltdmJITFU5L4rYMuQihHHp/sNyy6Noy7
 ebSUD+GGmG2J2dl+J10tCja7RWcJwJWv4ABcwnn1Wy8ZqA2qNzcyv27ZuhrQBu5WiL/1ysXmu/f
 E139FBuVBTccsgnkQw5MypIk8ViFEgds+IGj/SMKpk4/fCPJOlLiMoSjbKOWdYLvjFgHCJeYInc
 ICWJi82hUyfHPrgrvEO65krdmBC+/lANv47vRgliMETkbH91K668VtrL86B2vKdEGreNGUfUGYk
 FKR+MbrhfuJfu9g==
X-Received: by 2002:a05:622a:199a:b0:509:2b02:c1b5 with SMTP id
 d75a77b69052e-50b375252ecmr16863811cf.44.1773962013218; 
 Thu, 19 Mar 2026 16:13:33 -0700 (PDT)
X-Received: by 2002:a05:622a:199a:b0:509:2b02:c1b5 with SMTP id
 d75a77b69052e-50b375252ecmr16863301cf.44.1773962012613; 
 Thu, 19 Mar 2026 16:13:32 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:31 -0700 (PDT)
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH RFC 12/12] migration: Fix calculation of expected_downtime to
 take VFIO info
Date: Thu, 19 Mar 2026 19:13:02 -0400
Message-ID: <20260319231302.123135-13-peterx@redhat.com>
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

QEMU will provide an expected downtime for the whole system during
migration, by remembering the total dirty RAM that we synced the last time,
divides the estimated switchover bandwidth.

That was flawed when VFIO is taking into account: consider there is a VFIO
GPU device that contains GBs of data to migrate during stop phase.  Those
will not be accounted in this math.

Fix it by updating dirty_bytes_last_sync properly only when we go to the
next iteration, rather than hide this update in the RAM code.  Meanwhile,
fetch the total (rather than RAM-only) portion of dirty bytes, so as to
include GPU device states too.

Update the comment of the field to reflect its new meaning.

Now after this change, the expected-downtime to be read from query-migrate
should be very accurate even with VFIO devices involved.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-stats.h | 10 +++++-----
 migration/migration.c       | 11 ++++++++---
 migration/ram.c             |  1 -
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 326ddb0088..14b2773beb 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -31,11 +31,11 @@
  */
 typedef struct {
     /*
-     * Number of bytes that were dirty last time that we synced with
-     * the guest memory.  We use that to calculate the downtime.  As
-     * the remaining dirty amounts to what we know that is still dirty
-     * since last iteration, not counting what the guest has dirtied
-     * since we synchronized bitmaps.
+     * Number of bytes that are still dirty after the last whole-system
+     * sync on dirty information.  We use that to calculate the expected
+     * downtime.  As the remaining dirty amounts to what we know that is
+     * still dirty since last iteration, not counting what the guest has
+     * dirtied since then on either RAM or device states.
      */
     uint64_t dirty_bytes_last_sync;
     /*
diff --git a/migration/migration.c b/migration/migration.c
index 23c78b3a2c..1c00572d14 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3240,18 +3240,23 @@ static void migration_iteration_go_next(MigPendingData *pending)
      */
     qemu_savevm_query_pending(pending, false);
 
+    /*
+     * Update the dirty information for the whole system for this
+     * iteration.  This value is used to calculate expected downtime.
+     */
+    qatomic_set(&mig_stats.dirty_bytes_last_sync, pending->total_bytes);
+
     /*
      * Boost dirty sync count to reflect we finished one iteration.
      *
      * NOTE: we need to make sure when this happens (together with the
      * event sent below) all modules have slow-synced the pending data
-     * above.  That means a write mem barrier, but qatomic_add() should be
-     * enough.
+     * above and updated corresponding fields (e.g. dirty_bytes_last_sync).
      *
      * It's because a mgmt could wait on the iteration event to query again
      * on pending data for policy changes (e.g. downtime adjustments).  The
      * ordering will make sure the query will fetch the latest results from
-     * all the modules.
+     * all the modules on everything.
      */
     qatomic_add(&mig_stats.dirty_sync_count, 1);
 
diff --git a/migration/ram.c b/migration/ram.c
index 29e9608715..1bdf121d16 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1148,7 +1148,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
             RAMBLOCK_FOREACH_NOT_IGNORED(block) {
                 ramblock_sync_dirty_bitmap(rs, block);
             }
-            qatomic_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
         }
     }
 
-- 
2.50.1


