Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA5310F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJz-0001L4-SX; Wed, 08 Apr 2026 15:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAYHL-0005lA-Kq
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCU-00029W-An
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3AUfIp5hhwSuzshcuDyBJj3UN6iMbkU2aTwINm6YxQ=;
 b=W8wjzC1tFbNZnUWzEGHWZ2sjc8Zk4RS+os+5pErowD+WSAtH2S8M/2hf8YegUh35wLueM+
 Ih0cFpDN0gkzdAyIZA9ippmYGpGonCYj7fxUZ4oAtDpZ5Z4Ek/4byQixnnn787PMGLnwje
 RTcRBTvcqCj/LWMNraitsu+hoQeypiY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-TrcK_ewpO_mM-uwv1n1J7g-1; Wed, 08 Apr 2026 12:56:20 -0400
X-MC-Unique: TrcK_ewpO_mM-uwv1n1J7g-1
X-Mimecast-MFC-AGG-ID: TrcK_ewpO_mM-uwv1n1J7g_1775667380
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d812c898cso3469351cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667380; x=1776272180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3AUfIp5hhwSuzshcuDyBJj3UN6iMbkU2aTwINm6YxQ=;
 b=Q3fryF58KvtwuXxYSulS37QYyiJzGUWz92WgEHqe/Wl9gp2MPyWAQ3xf4T6mUjf5ie
 ypXPLgM4ModjThEqy/ygN2y5JvsGEAnwmIjLQimyeDZeDt92UXl6sr423tWD/N7ZGTvu
 4u2ecPVQ01LzMOBCoMDBush+9rY1Csjk29pQqaQmwnNI0GRnsSyj+I52REz8NsZixWd1
 SIztbqzi3rrxOkQ1SDEbVszJYgQItJYTXvpW3uYB4x5FDBOnvea7UKdxA4z5M4Xnw71h
 7ThcBECtzWE84c2n4fuCItGvlPOWM1HYeiC2GNnmBkbs24u6bUO3rhBL6wRw9fVmJvJe
 ijUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667380; x=1776272180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3AUfIp5hhwSuzshcuDyBJj3UN6iMbkU2aTwINm6YxQ=;
 b=f7lOO062fQzE2BTCm2lKxjXkEyXpwPgFKUanvWAy8HqAC4vWD8gVo6Gu61orIQ9EwT
 ziJIVhaVsT945GiSB/6p4jS1NuFkQxgc4ODffXGAE8IYSWhxD/Sbt3NZ8k2O8rEH6NB4
 UHg5zDdZfwKTVom1FPtdLpbGSqbND/ZCgNmayrO2a4VUnmBRBK74doWXawF+JteGI/SS
 /+G2QlRGrZocsTJYJG8KU64qsHSqhQl1cGf0iQcKRDFRvpaSh9jJMdWyNzdebDAU2gcw
 bWoaA9XuEZx+3ix1BYGDoJ4UWi7twjSGgr0jhd3XjnI6zLki1q3fmWo9ipRNTYNYCkw8
 FICA==
X-Gm-Message-State: AOJu0YyAYBpaUB7Q54ZlMqWc8ngL2sBtBCJm/GW/RLsgvFA0FsyIxNPF
 L0X3LVZSWp35160MyXdJdR9J/VnqJhxeph6YdKHQTwY0VZLLifryP6hsHwGhUakvReiZ2lXDmTu
 mG1MtSHME4zpy+dCuyY+aAPDYhm/UhA1+77ooyHM1dirtYVpDt9FCtMLYtkHDvTIIBuUNoIqAJd
 CBMx9hD5CE3vwnqpzg0iNfQCTQAMRYVm4suu555Q==
X-Gm-Gg: AeBDieuZThkbOJyLTR3u3Z8pTF4vr/DBnJEzlJTY8lk2b49Wv0pnXO504jzXPq1QWXP
 5cw/xlfxE0F1cJManaXyYfYuPPh/fa/QLuMPGzo/4oWRuISYfU+8rTio+3+dEeUNFvhDSqzKyTG
 KIx37Cwj7FB8ndijJhxr/mg7QVNg1qvvoA3ye4Dvv0pzM06fU4WF6dWD48J2YP89fkHcAaM7Ldx
 y7LdFL9YRT7sca53q4doHa+Hld+89s1FHlfyuCLrVG+YDjIToD3gMqig6HK5maDgoRH63SxyWEI
 8S3m3MJjo3NWUPPanjsvzO+4Yvjib+I/RADa3vWgQcFIZcjMZ5r5rafORy9sNmp++TYvmsxZevE
 rvCBilHIihFcYtIBj39mQrl1i+i/5JkHTM78jD70uWVjM
X-Received: by 2002:a05:622a:229f:b0:50d:7b0c:35e7 with SMTP id
 d75a77b69052e-50d7b0c40a9mr260168291cf.43.1775667379767; 
 Wed, 08 Apr 2026 09:56:19 -0700 (PDT)
X-Received: by 2002:a05:622a:229f:b0:50d:7b0c:35e7 with SMTP id
 d75a77b69052e-50d7b0c40a9mr260167531cf.43.1775667379154; 
 Wed, 08 Apr 2026 09:56:19 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:18 -0700 (PDT)
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
Subject: [PATCH 12/14] migration: Fix calculation of expected_downtime to take
 VFIO info
Date: Wed,  8 Apr 2026 12:55:56 -0400
Message-ID: <20260408165559.157108-13-peterx@redhat.com>
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
 migration/migration-stats.h |  8 +++-----
 migration/migration.c       | 11 ++++++++---
 migration/ram.c             |  1 -
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 326ddb0088..1447316802 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -31,11 +31,9 @@
  */
 typedef struct {
     /*
-     * Number of bytes that were dirty last time that we synced with
-     * the guest memory.  We use that to calculate the downtime.  As
-     * the remaining dirty amounts to what we know that is still dirty
-     * since last iteration, not counting what the guest has dirtied
-     * since we synchronized bitmaps.
+     * Number of bytes that were reported dirty after the lastest
+     * system-wise synchronization on dirty information.  It is used to
+     * do best-effort estimation on expected downtime.
      */
     uint64_t dirty_bytes_last_sync;
     /*
diff --git a/migration/migration.c b/migration/migration.c
index f12cd9efd3..4010e5dcf5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3240,18 +3240,23 @@ static void migration_iteration_go_next(MigPendingData *pending)
      */
     qemu_savevm_query_pending(pending, true);
 
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
index 686162643d..d927ad7508 100644
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
2.53.0


