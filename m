Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1A4C3ABA2
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sproG-0002eq-Ct; Sun, 15 Sep 2024 12:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproF-0002aR-7g
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproD-0006OV-EF
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718e285544fso1966124b3a.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726416548; x=1727021348;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxw6C89QI6UbPkGgu8mJTGVSMtVBCh9fCukElZHUmoY=;
 b=OVyu8h/sjH73JizOZRhjloYT6H8vHAIhv20tGmfeMwPx5yMEu81sorrn2Z42xusvK1
 ycGqk9anmdAyTzRXDXukAMUxKPPLYKKg4ASLAHdEr2rfmpGgSI/8GHM/+EB/aENEJgQk
 dqN3rF0XYwbMXxL9py6YWQ/hGWz0LdbPx+dxIPfFu8I1u4htkhwEYP7XzETDPDLMMAVA
 ODHaYez5Akslb6oph2e6mxMaW1uY9b7C00lC+W9wTrrnMxE0bbCMTnOCm3LVSjYTDKIl
 g6RkCc5WMgYeTPWvGzosvPaM3MgvANJ2ycs6cg+zQEvOSDKZvqNV4dElV1P9bwjd3mC+
 EJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726416548; x=1727021348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxw6C89QI6UbPkGgu8mJTGVSMtVBCh9fCukElZHUmoY=;
 b=TK9YbUEB/jmKDymJk5DBQs4fofWJgrPrraeNNvPtnphDiocDDSHoj4hu9sRXq2RR/p
 Cixi/ztNyo/Hbree9LIMOa8JcXRPY2pl5k2ttEce7G+nZnxGDGjZ5ShzWJL902QBn+j7
 WHWOODjFldEdlDTEWv8YPo5PnX/y31BnPZymPHxhf3QLRp6uhVNdOticxejUqrE6sRR0
 jgESb9Sf/bYMYwsrOIA5MuhDQu8DK4f4SY+pF9djjp9y4VuCXMfXj3ft6Y1CApMap2bm
 7W3IwzlfX/TvJR8mVOdlX06woRjhHhG+hmvDZr1KkxDkMMbZNlZiSk3/gE1HhLSvL0BC
 9+qQ==
X-Gm-Message-State: AOJu0YxxL6Xa/jPHifeu7cvWX1Us+PoWC1Ni+heFdZNJt8veFkalx2Uo
 u3j4YXveU9y70HshLHIuTTaQL2KPfuWjc0bA6LRR4ZuPwMK7/C9JEMCj1yqUCm4VOtb2Ga87kNa
 qgjIjCQ==
X-Google-Smtp-Source: AGHT+IHcQgpMzCVLaxZ7nd9l+/mRVcrIgDS1crPkkTQqxVV+tdV0103WWiTUcqtVZvtfVOSToeRgCw==
X-Received: by 2002:a05:6a21:164a:b0:1cf:44ac:7144 with SMTP id
 adf61e73a8af0-1d112e89110mr12537636637.31.1726416547253; 
 Sun, 15 Sep 2024 09:09:07 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bb5967sm2344795b3a.182.2024.09.15.09.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 09:09:07 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 3/7] qapi/migration: Introduce the iteration-count
Date: Mon, 16 Sep 2024 00:08:46 +0800
Message-Id: <654bfad294e2cc3394f744bd8536e0448c0bf550.1726390099.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1726390098.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x434.google.com
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

The original migration information dirty-sync-count could
no longer reflect iteration count due to the introduction
of background synchronization in the next commit;
add the iteration count to compensate.

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
index e205806a5f..ca5a1b5f16 100644
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
@@ -1079,6 +1079,10 @@ static void migration_bitmap_sync(RAMState *rs,
     RAMBlock *block;
     int64_t end_time;
 
+    if (!background) {
+        stat64_add(&mig_stats.iteration_count, 1);
+    }
+
     stat64_add(&mig_stats.dirty_sync_count, 1);
 
     if (!rs->time_last_bitmap_sync) {
@@ -1115,8 +1119,8 @@ static void migration_bitmap_sync(RAMState *rs,
         rs->num_dirty_pages_period = 0;
         rs->bytes_xfer_prev = migration_transferred_bytes();
     }
-    if (migrate_events()) {
-        uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
+    if (!background && migrate_events()) {
+        uint64_t generation = stat64_get(&mig_stats.iteration_count);
         qapi_event_send_migration_pass(generation);
     }
 }
diff --git a/qapi/migration.json b/qapi/migration.json
index b66cccf107..95b490706c 100644
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
index d6768d5d71..b796a90cad 100644
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


