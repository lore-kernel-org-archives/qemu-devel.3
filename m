Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B4CF6497
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 17:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suxVV-0007gn-7H; Sun, 29 Sep 2024 13:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVR-0007fH-3E
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:50 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVO-0003ZU-B3
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:48 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so2414647a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727630085; x=1728234885;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMUK60BHzdd41nGJHCrCQ2l0xWbjtZ+iMy5zgCcNfzA=;
 b=fN9qEhmH60yiyPhauUbUw2El1EmuYxy51Wd/qbDcBkKqJem9JFElpWx6N1VwGyK83W
 G9jrqweVhsnp4A2L2O78qjVtMYNzu47Z2MjqzYWLDeZmDF9F60BQXs5ovWEJ5PoPmCfd
 Yk0SitRT9+QOKRuW/YTFqJuSC10nuQsgxhNEBGguM3tvjF7ZDX8bk8+qUPek+7rzz5Mv
 1satDz0hv/4qFJUmI79y7ODtia4JZLPkZUtguqqUiEHFEdRJeTK+A/b/qZA3bTV9ozsT
 Qgd+ahpyRo6Ha9tIGFBZp97MN0qYb4fiQkHhiO+tFtpL/qM4TrcLv2eLc2q7xRM3d/ZD
 N2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727630085; x=1728234885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMUK60BHzdd41nGJHCrCQ2l0xWbjtZ+iMy5zgCcNfzA=;
 b=Uo7zVVvUIitijvVgN5uqiLB/k+wIZMmRk4kMmGqR+egnk3qp0EgGZ+0rLR/tSwdcGU
 P/0DU/50YfdhXROfJ8XeSJtE3Mr+o3FfTZp689jFz78+z23tFJgU2/EmZu/Qe9gJE1uW
 ttVW3LrTqtAHLFvGTSRn8MNUvV48z7HsIcWIcUnJrk4YUSwY51oRlG96++BarCElTiR3
 J2bxSOWM69DG+UrOHAsT0KatoRtGV5F4RWzsb1NdxFJLixmQAJEdSCAydyPVWDbfQbeW
 ciIg7KqL9jGABIlvSK7OYYPgtEGCWCWgTt3u1yHLTH0qiy7z2Jsddkm6k75jtWAFbnCi
 twyw==
X-Gm-Message-State: AOJu0YzJ6bdr2HGLF669/A8BeBBQgiFqZOsFObi2pgALsM3hgD5i79qB
 ozAXGbolX2U3F5NH9tkBcJkhbo7RB58CfklhAopikIKvOC9qjqJW48ZBlIuW+Wx9N82oLMNWsnZ
 8xi4=
X-Google-Smtp-Source: AGHT+IE84jKi99Yjr52RRHifsVzqdD41n5wri0OIcP/DAPobeX3cuJTuhG9AcylrqB3ovdZOETumrg==
X-Received: by 2002:a17:90a:fc85:b0:2e0:8dbc:3ead with SMTP id
 98e67ed59e1d1-2e0b8ed3968mr11545707a91.33.1727630084126; 
 Sun, 29 Sep 2024 10:14:44 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e1e09e2sm9597408a91.32.2024.09.29.10.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 10:14:43 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 1/3] migration: Support background ramblock dirty sync
Date: Mon, 30 Sep 2024 01:14:26 +0800
Message-Id: <f36590f60307ce9647d3506e55dcbc2405c98ee2.1727630000.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1727630000.git.yong.huang@smartx.com>
References: <cover.1727630000.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

When VM is configured with huge memory, the current throttle logic
doesn't look like to scale, because migration_trigger_throttle()
is only called for each iteration, so it won't be invoked for a long
time if one iteration can take a long time.

The background dirty sync aim to fix the above issue by synchronizing
the ramblock from remote dirty bitmap and, when necessary, triggering
the CPU throttle multiple times during a long iteration.

This is a trade-off between synchronization overhead and CPU throttle
impact.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 include/migration/misc.h     |  3 ++
 migration/migration.c        | 11 +++++++
 migration/ram.c              | 64 ++++++++++++++++++++++++++++++++++++
 migration/ram.h              |  3 ++
 migration/trace-events       |  1 +
 system/cpu-timers.c          |  2 ++
 tests/qtest/migration-test.c | 29 ++++++++++++++++
 7 files changed, 113 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bfadc5613b..67c00d98f5 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -111,4 +111,7 @@ bool migration_in_bg_snapshot(void);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
+/* migration/ram.c */
+void bg_ram_dirty_sync_init(void);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 3dea06d577..224b5dfb4f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3285,6 +3285,9 @@ static void migration_iteration_finish(MigrationState *s)
 {
     /* If we enabled cpu throttling for auto-converge, turn it off. */
     cpu_throttle_stop();
+    if (migrate_auto_converge()) {
+        bg_ram_dirty_sync_timer_enable(false);
+    }
 
     bql_lock();
     switch (s->state) {
@@ -3526,6 +3529,14 @@ static void *migration_thread(void *opaque)
 
     trace_migration_thread_setup_complete();
 
+    /*
+     * Tick the background ramblock dirty sync timer after setup
+     * phase.
+     */
+    if (migrate_auto_converge()) {
+        bg_ram_dirty_sync_timer_enable(true);
+    }
+
     while (migration_is_active()) {
         if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
             MigIterateState iter_state = migration_iteration_run(s);
diff --git a/migration/ram.c b/migration/ram.c
index 67ca3d5d51..995bae1ac9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -110,6 +110,12 @@
  */
 #define MAPPED_RAM_LOAD_BUF_SIZE 0x100000
 
+/* Background ramblock dirty sync trigger every five seconds */
+#define BG_RAM_SYNC_TIMESLICE_MS 5000
+#define BG_RAM_SYNC_TIMER_INTERVAL_MS 1000
+
+static QEMUTimer *bg_ram_dirty_sync_timer;
+
 XBZRLECacheStats xbzrle_counters;
 
 /* used by the search for pages to send */
@@ -4543,6 +4549,64 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
     }
 }
 
+static void bg_ram_dirty_sync_timer_tick(void *opaque)
+{
+    static int prev_pct;
+    static uint64_t prev_sync_cnt = 2;
+    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
+    int cur_pct = cpu_throttle_get_percentage();
+
+    if (prev_pct && !cur_pct) {
+        /* CPU throttle timer stopped, so do we */
+        return;
+    }
+
+    /*
+     * The first iteration copies all memory anyhow and has no
+     * effect on guest performance, therefore omit it to avoid
+     * paying extra for the sync penalty.
+     */
+    if (sync_cnt <= 1) {
+        goto end;
+    }
+
+    if (sync_cnt == prev_sync_cnt) {
+        int64_t curr_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        assert(ram_state);
+        if ((curr_time - ram_state->time_last_bitmap_sync) >
+            BG_RAM_SYNC_TIMESLICE_MS) {
+            trace_bg_ram_dirty_sync();
+            WITH_RCU_READ_LOCK_GUARD() {
+                migration_bitmap_sync_precopy(ram_state, false);
+            }
+        }
+    }
+
+end:
+    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
+    prev_pct = cpu_throttle_get_percentage();
+
+    timer_mod(bg_ram_dirty_sync_timer,
+        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
+            BG_RAM_SYNC_TIMER_INTERVAL_MS);
+}
+
+void bg_ram_dirty_sync_timer_enable(bool enable)
+{
+    if (enable) {
+        bg_ram_dirty_sync_timer_tick(NULL);
+    } else {
+        timer_del(bg_ram_dirty_sync_timer);
+    }
+}
+
+void bg_ram_dirty_sync_init(void)
+{
+    bg_ram_dirty_sync_timer =
+        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
+                     bg_ram_dirty_sync_timer_tick, NULL);
+}
+
 static RAMBlockNotifier ram_mig_ram_notifier = {
     .ram_block_resized = ram_mig_ram_block_resized,
 };
diff --git a/migration/ram.h b/migration/ram.h
index bc0318b834..9c1a2f30f1 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);
 int ram_write_tracking_start(void);
 void ram_write_tracking_stop(void);
 
+/* Background ramblock dirty sync */
+void bg_ram_dirty_sync_timer_enable(bool enable);
+
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index c65902f042..3f09e7f383 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 qemu_file_fclose(void) ""
 
 # ram.c
+bg_ram_dirty_sync(void) ""
 get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
 get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
 migration_bitmap_sync_start(void) ""
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 0b31c9a1b6..64f0834be4 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "migration/vmstate.h"
+#include "migration/misc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
@@ -274,4 +275,5 @@ void cpu_timers_init(void)
     vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
 
     cpu_throttle_init();
+    bg_ram_dirty_sync_init();
 }
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d6768d5d71..3296f5244d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -468,6 +468,12 @@ static void migrate_ensure_converge(QTestState *who)
     migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
 }
 
+static void migrate_ensure_iteration_last_long(QTestState *who)
+{
+    /* Set 10Byte/s bandwidth limit to make the iteration last long enough */
+    migrate_set_parameter_int(who, "max-bandwidth", 10);
+}
+
 /*
  * Our goal is to ensure that we run a single full migration
  * iteration, and also dirty memory, ensuring that at least
@@ -2791,6 +2797,7 @@ static void test_migrate_auto_converge(void)
      * so we need to decrease a bandwidth.
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
+    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
 
     if (test_migrate_start(&from, &to, uri, &args)) {
         return;
@@ -2827,6 +2834,28 @@ static void test_migrate_auto_converge(void)
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
+
+    /* Make sure the iteration last a long time enough */
+    migrate_ensure_iteration_last_long(from);
+
+    /*
+     * End the loop when the dirty sync count greater than 1.
+     */
+    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
+        usleep(1000 * 1000);
+    }
+
+    prev_dirty_sync_cnt = dirty_sync_cnt;
+
+    /*
+     * The dirty sync count must changes in 5 seconds, here we
+     * plus 1 second as error value.
+     */
+    sleep(5 + 1);
+
+    dirty_sync_cnt = get_migration_pass(from);
+    g_assert_cmpint(dirty_sync_cnt, != , prev_dirty_sync_cnt);
+
     /* Now, when we tested that throttling works, let it converge */
     migrate_ensure_converge(from);
 
-- 
2.27.0


