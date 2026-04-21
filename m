Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB55F94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbJ-000111-Ci; Tue, 21 Apr 2026 16:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbG-0000zi-0I
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbE-0008Sh-0G
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+iUFIFI91U4R0IIvcJAwRQAFhDDvnp8eZiPU+UOGonU=;
 b=f/E3Kv3dIiJJPHS/ZzcaTJ3mi/7bo8Ua+gTe5KU+HmJhs1ntNqcoKQj5SBQ8jxOqJz6VlU
 WinctXOthyF4jB3zp5+aqmWs3kxnBzalBz+ot/O2IEOqiAPzSQqJmE9eiRfo8IR30b2YP9
 vsAOHFcPJqXHSNh5MHHGyZ1LSkswsYo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-fBzbHEnEOW6g4QxErzBJww-1; Tue, 21 Apr 2026 16:21:34 -0400
X-MC-Unique: fBzbHEnEOW6g4QxErzBJww-1
X-Mimecast-MFC-AGG-ID: fBzbHEnEOW6g4QxErzBJww_1776802893
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ac04b2fc4eso112819216d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802893; x=1777407693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iUFIFI91U4R0IIvcJAwRQAFhDDvnp8eZiPU+UOGonU=;
 b=KctlUYtGW4Ed9ldJbsLvfP3MBYss83hNRN8Isk4A7b9AQXhGz2vnTb0W8gZHVTlvEF
 4AeNlMTUMgSdd72HyOyNSNa8VbVllJjr6Y3Inmzi3BC+XnRtISw5G7ijKADecfw0QpDx
 bfy/TWpTVD9lmz5r+nCh7/LH18jg7htxoeDRLnr6NgmEpb98jr5JKpDumjiLmipqVI/a
 oL43BHnjRkBTuDbZYRSd9EqUheam8Wf8scO/pwbBtmabs88ILyr5xd69TSJXm5h2Z+HJ
 XVheXUuDCKLMWjSZpCUhrZAkAQjXbaHF02v/d/DNxszzF4tVoMdsECT1kwVXrc0e+JM8
 FpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802893; x=1777407693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+iUFIFI91U4R0IIvcJAwRQAFhDDvnp8eZiPU+UOGonU=;
 b=kP4TvJP0x+e7bZY+DSKfNslS2mIMSeSkGPmgNmjQeetw3SQWYLd7+EHypJpI48F5j7
 gDyhiFiuXnCFh9uiXRDZLyuRlKdGONhGvSyh2UL92O3fNUoxBjD3IMu1lpoyRRvaMmfb
 ZMu2VLEdiaHGzqJ5bKSDyRnZY1L5KdGWnzfVBbmmt9OTZ4DH84F6Jgr4WJsT6QPC9Ebe
 sVM2ygckkRmwpv+cxNckuzLjCuGxhg+Z+ED4GbRCiJywRd9M/7RZsi+zq8yHRQgtt2hd
 V+P9H9O5Vrf2ZUou53p6OXIPse+CrE4Ui5E1naiWdg+ab6iwuKWfJWxBwJ3Dr76Dh1h6
 N5dQ==
X-Gm-Message-State: AOJu0YxWuOi1g25WmhwGFOlLjDh8Hdl4XwDH2GnCSsxb8BNBqEFF8ZF4
 LUlt1LB3sr9fU8pTARwSGICWs+dCwCle+rTKOZc6BsL5yJYSOb2D22YVLnpQI6Gd/Wu0umMQEdH
 mA2CKPh7hBP3uN89sCchboNV13CDj+pzHMUpu4g3wOqX4KW35aJiJ42Il4Ki7AN8p8T06SPo7V9
 JkCtyZkCwTXViodyjKaQgmsKOuM3KeqNBkRx02Bw==
X-Gm-Gg: AeBDieuhM255/n/Oth78spUBjXRjnQnymBhBQq+dNVUZvalRONRJGhSFgvr9KY7NUfq
 NDmSnRbuc6508z8WYJnktE1FfqzAaXcyMGxq4Ee0OlmM9HvjV26HXKN2SLRTOGE+gdAIi0RbYdE
 A2GDaJ+uGJbLtZsxURmg8sy7v3d6y8YqI+YWceNfuwZyPNJ+o9FH+jy2SNHQlYKD4uX+pwg8p1l
 5vxAIm7zaUOtoagd5M0y2esQ55UZXGWw7KkBEnP25vuq7jIpC05Iesy9ImDI7P6kUpYz1kT+nNT
 RQU+c8HO78IPJ780l6lgIjdnHdrLSn9TKQY/YyCnR9lLkxKAA4lfoQF05q2NFMrFQu5cKwW0yV0
 LzOj1rusv3/Ck6nHr44m9B0UILHqp/o6WIImqDaSOjsylose4NBPqyHXT9Q==
X-Received: by 2002:a05:6214:260f:b0:89c:5e33:2cc5 with SMTP id
 6a1803df08f44-8b02812918cmr327405566d6.20.1776802893125; 
 Tue, 21 Apr 2026 13:21:33 -0700 (PDT)
X-Received: by 2002:a05:6214:260f:b0:89c:5e33:2cc5 with SMTP id
 6a1803df08f44-8b02812918cmr327404866d6.20.1776802892443; 
 Tue, 21 Apr 2026 13:21:32 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:31 -0700 (PDT)
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
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 12/16] migration: Fix calculation of expected_downtime to
 take VFIO info
Date: Tue, 21 Apr 2026 16:21:06 -0400
Message-ID: <20260421202110.306051-13-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-stats.h |  8 +++-----
 migration/migration.c       | 11 ++++++++---
 migration/ram.c             |  1 -
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 326ddb0088..1775b916df 100644
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
+     * Number of bytes that were reported dirty after the latest
+     * system-wise synchronization of dirty information.  It is used to do
+     * best-effort estimation on expected downtime.
      */
     uint64_t dirty_bytes_last_sync;
     /*
diff --git a/migration/migration.c b/migration/migration.c
index d4d3534cf1..5d68591215 100644
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


