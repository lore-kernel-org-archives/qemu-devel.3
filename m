Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA4BECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfLG-0001M8-PX; Mon, 09 Sep 2024 10:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLF-0001Fc-DO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:09 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLD-0004U1-MC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:09 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e033e66a31so1521596b6e.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891966; x=1726496766;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4+6JdQYvda/1Hm0Qzqic1h3nzIQOs1z0LtM+uvLl5s=;
 b=uhnqUVhsAthcEiwJUVBVWETejxaOcKdm/BU33CZJzDMZcpohdMmpwamR9CziX6twRb
 bZj1evOzyXB1w9EJbIazl3TSHDWKZ4VPKcDkhqd79Jovlra4RxfgjWxJI+LxJD+2NYNm
 X+WEb9zRDdxMgQYg4krn2J6PtaI24vktYUi5s/zAFxFrzbWO8LQfSjj6MgceidchdbWr
 nNnuudeskXIODWaKZU0fRV7dBMa6QTycekAU8PjpemRuwKAd9dKJCpc9DCVElhb9hACu
 DPsnnHQbivVa5s8WTk69wSbKgRxsy9pb4bXqC3ARBVu0gt6bQS6Fmi9FZnn5udUBaxIW
 4jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891966; x=1726496766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4+6JdQYvda/1Hm0Qzqic1h3nzIQOs1z0LtM+uvLl5s=;
 b=ar3ppsClkDErwg+I1eR7uQB/cjYjHQslr/vY+2Uiu2MZO0QDeNrtzH3s/hDa8W5f5Z
 dp+BArZJ9n2X3YhJnPpuD6AbIRRTO4QSB4Ayhs12Mrd/033KpsOvJtOaHLorfbed3P10
 MJKELAbGRZnU0cDhmBAcBL3/4S70EV+L44rizkw+49VdgtunOqZZkmRKgEu8awAOGG7t
 C+33KpB2k48g3V6+OJwfNM27tuaKm6pMWjfvD3XQQ5vJH8VJV6axClbyUvaeBcSlcsaw
 rNbJlk/6okGrD9to5qS/pDhThbE/T6BFNCqzNqx+xJyNQDwNHk7rQoLy3XpTVf+sqp10
 nQ1g==
X-Gm-Message-State: AOJu0YwfTbGvharxwnmYe5U7DDLUTrzI+HQOhuBNv3S+Az6uS2lNMg6r
 +2uMTZwofvMOsynpm2Y8NRscIdX3kSi21WnWDp/Y+f/YeSfiNalneUSWITk/azb76gw0V7xiY37
 GTf0vlQ==
X-Google-Smtp-Source: AGHT+IH76pZoBbETP32Ke1fH3vmV1055l/ejb7q4fQ43imhs6kNFFnvibA9y9NCOnvzO5+Luij3Fow==
X-Received: by 2002:a05:6870:9f08:b0:277:e641:5659 with SMTP id
 586e51a60fabf-27b9daecd2cmr3397826fac.35.1725891965569; 
 Mon, 09 Sep 2024 07:26:05 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:26:05 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 04/10] qapi/migration: Introduce the iteration-count
Date: Mon,  9 Sep 2024 22:25:37 +0800
Message-Id: <9f16a57bd430fd99807a57454780c7e0a90e739c.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The original migration information dirty-sync-count
could no longer reflect iteration count due to the
introduction of periodic synchronization in the next
commit; add the iteration count to compensate.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration-stats.h  |  4 ++++
 migration/migration.c        |  1 +
 migration/ram.c              | 12 ++++++++----
 qapi/migration.json          |  6 +++++-
 tests/qtest/migration-test.c |  2 +-
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 05290ade76..43ee0f4f05 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -50,6 +50,10 @@ typedef struct {
      * Number of times we have synchronized guest bitmaps.
      */
     Stat64 dirty_sync_count;
+    /*
+     * Number of migration iteration processed.
+     */
+    Stat64 iteration_count;
     /*
      * Number of times zero copy failed to send any page using zero
      * copy.
diff --git a/migration/migration.c b/migration/migration.c
index 3dea06d577..055d527ff6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1197,6 +1197,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count =
         stat64_get(&mig_stats.dirty_sync_count);
+    info->ram->iteration_count = stat64_get(&mig_stats.iteration_count);
     info->ram->dirty_sync_missed_zero_copy =
         stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
     info->ram->postcopy_requests =
diff --git a/migration/ram.c b/migration/ram.c
index a56634eb46..23471c9e5a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -594,7 +594,7 @@ static void xbzrle_cache_zero_page(ram_addr_t current_addr)
     /* We don't care if this fails to allocate a new cache page
      * as long as it updated an old one */
     cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
-                 stat64_get(&mig_stats.dirty_sync_count));
+                 stat64_get(&mig_stats.iteration_count));
 }
 
 #define ENCODING_FLAG_XBZRLE 0x1
@@ -620,7 +620,7 @@ static int save_xbzrle_page(RAMState *rs, PageSearchStatus *pss,
     int encoded_len = 0, bytes_xbzrle;
     uint8_t *prev_cached_page;
     QEMUFile *file = pss->pss_channel;
-    uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
+    uint64_t generation = stat64_get(&mig_stats.iteration_count);
 
     if (!cache_is_cached(XBZRLE.cache, current_addr, generation)) {
         xbzrle_counters.cache_miss++;
@@ -1075,6 +1075,10 @@ static void migration_bitmap_sync(RAMState *rs,
     RAMBlock *block;
     int64_t end_time;
 
+    if (!periodic) {
+        stat64_add(&mig_stats.iteration_count, 1);
+    }
+
     stat64_add(&mig_stats.dirty_sync_count, 1);
 
     if (!rs->time_last_bitmap_sync) {
@@ -1111,8 +1115,8 @@ static void migration_bitmap_sync(RAMState *rs,
         rs->num_dirty_pages_period = 0;
         rs->bytes_xfer_prev = migration_transferred_bytes();
     }
-    if (migrate_events()) {
-        uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
+    if (!periodic && migrate_events()) {
+        uint64_t generation = stat64_get(&mig_stats.iteration_count);
         qapi_event_send_migration_pass(generation);
     }
 }
diff --git a/qapi/migration.json b/qapi/migration.json
index 8281d4a83b..6d8358c202 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -60,6 +60,9 @@
 #     between 0 and @dirty-sync-count * @multifd-channels.  (since
 #     7.1)
 #
+# @iteration-count: The number of iterations since migration started.
+#     (since 9.2)
+#
 # Since: 0.14
 ##
 { 'struct': 'MigrationStats',
@@ -72,7 +75,8 @@
            'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
            'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
            'postcopy-bytes': 'uint64',
-           'dirty-sync-missed-zero-copy': 'uint64' } }
+           'dirty-sync-missed-zero-copy': 'uint64',
+           'iteration-count' : 'int' } }
 
 ##
 # @XBZRLECacheStats:
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9d08101643..2fb10658d4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -278,7 +278,7 @@ static int64_t read_migrate_property_int(QTestState *who, const char *property)
 
 static uint64_t get_migration_pass(QTestState *who)
 {
-    return read_ram_property_int(who, "dirty-sync-count");
+    return read_ram_property_int(who, "iteration-count");
 }
 
 static void read_blocktime(QTestState *who)
-- 
2.39.1


