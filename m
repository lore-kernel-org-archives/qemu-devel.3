Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEA1CD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMN-0004b7-14; Tue, 05 May 2026 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMME-0004Tl-Ct
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMC-0002db-PU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WmFUP5dqUbxMM1tZndsShjc1KEJom3N3hcsbb3ZxQQ=;
 b=MdKK8UXL+/PA/opfipKtkhXQQPQ8Hr4VNcySliNxnIwheDeglvwC7cFsCPgtGTFX4iB5zX
 amoeMm1cFR8GoyiMdy5iio2bjmpjljqYjN5/wxKt08dMbRHOlrGBo6876y8LefPw1xKixq
 BxZHuntCSe+f9/9cGYX1GRslSNGBhUY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-2be3P9BEP_CRO5WP5KF-LA-1; Tue, 05 May 2026 16:27:02 -0400
X-MC-Unique: 2be3P9BEP_CRO5WP5KF-LA-1
X-Mimecast-MFC-AGG-ID: 2be3P9BEP_CRO5WP5KF-LA_1778012822
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b597b14a22so10669136d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012821; x=1778617621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WmFUP5dqUbxMM1tZndsShjc1KEJom3N3hcsbb3ZxQQ=;
 b=DWusmMnTi8JNwRLJ/fzDG33CS+LnDFDdAzMcwPEyhTA8Xy9/77f1J+g5iNbnL5HMvK
 DHR9Jk08LDUl1snuxMnjN8SguPKWGP4WbQcXCeZSdM7FyPQeF1C089ZcKBtRFfLRm/dl
 kLzpnGNEuPAkKP4RWC7UZOgK+ruJ7ck9Qigi0F/kGCGvBIvbALdsQVgojz5rOPiv4Bji
 +ltbdinRtngxPLAFm35LtcE4sSk5qLbpD9qzjKuOKq2NPgOH4k5QdWPKLbn5JjfMg2HD
 pWdUPTwppqpBGVGiVPur3oBay0XvmLJmCOPGbHLgyTrpywECeIbo9cv2Rg4K6eYGaAoC
 yEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012821; x=1778617621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9WmFUP5dqUbxMM1tZndsShjc1KEJom3N3hcsbb3ZxQQ=;
 b=lnR5SZl4TUiBY96bDSGGJPwoWHCwRwiWlrUDTdZPwIsdeYHI7rj9tXDpNlr1w9L4NU
 OczOYTzw3kYTlU2BBuogYDUfpfPhqv+mOlLTxhkl2o83VxhqNKpalZyyM6MrjWWFNrct
 Z3eYoLqKQxEafm9O0Sj1RyWjZaMWYnniQZptGMmUjD49iCJ2TKbZoPMitAfgPMPD/8QM
 SQab1342GXJDa9gIWyskBh8CsMkYHznkvB4+Y9ZabQ54cY+/pVObu2MC8aeTLnr1qJ9F
 iA167JGSWJ7YSF61IRSUzWoG9t7cOI2Lr3fRx8FaE0mV0PxEpGWYMCeXYDdfkbmqHJf6
 QD1g==
X-Gm-Message-State: AOJu0YyZdRy3B62QkCL684f5tszc3JZkjL1X0S7nhY99Bk9duN9Ut3G4
 H1xRgTh2znari4EaXRFmo28QA4Y6kWkcOhTgA4DCamqshUxKmTMp4w5blEoRbC7T+A6r+bLekRu
 qwmSPOeCmxqvE4FWKORfXmgD9T8OXyavuHsJghZkt9V9iSRurEfFEBCnXHl0Vc1WMzImIUO24wQ
 iewFdghFNsoqZV55bnGGiBoJdhsWJh5IzQwxqT7Q==
X-Gm-Gg: AeBDiesKtcf01AHrXdxzYwp8zXKZICS8S2NnndSvdEr4Bumr1x0Hx3/MAvpWWYMcZsK
 0BATt7gHRFt5eT2XNyMBtful8EIoIOkC6fXPLi/mcgNW6ygraENypTF+vpP5mlhoW1LKu33IiXp
 qNdTVW46SnyKNn2tM+0i2j8Py68nvXS1KQs/6sZeGfAiQF+5W+X5pRUVD1cxfASJ4rEX0/PtyrR
 rVh3ADwC1lGdZeCDzAyONC/gPi8iM8czEFiqZPJy0cspuPK1qNrJ9A/UmFggNtCZZLpJgFoBzqu
 xJXSp0hZ0sezjj6eIv5os8VevqV92SBr7ZLz4xGFjnfxVtioOXTcthBcuQzLFi017Q2wmii8IZg
 kIs/bkkBfmQH8s3L38QpiLxY0iEnTKy+wjBr+aJ3qE4QfBdo9zklJfl0=
X-Received: by 2002:a05:6214:5503:b0:896:fb99:f692 with SMTP id
 6a1803df08f44-8bc2a3b6da3mr9953536d6.0.1778012821247; 
 Tue, 05 May 2026 13:27:01 -0700 (PDT)
X-Received: by 2002:a05:6214:5503:b0:896:fb99:f692 with SMTP id
 6a1803df08f44-8bc2a3b6da3mr9952896d6.0.1778012820570; 
 Tue, 05 May 2026 13:27:00 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 14/23] migration: Fix calculation of expected_downtime to take
 VFIO info
Date: Tue,  5 May 2026 16:26:31 -0400
Message-ID: <20260505202640.1011006-15-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-13-peterx@redhat.com
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
index d740d9df85..ab09dcbcf4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3244,18 +3244,23 @@ static void migration_iteration_go_next(MigPendingData *pending)
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
index ecd4b6165c..fc38ffbf8a 100644
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


