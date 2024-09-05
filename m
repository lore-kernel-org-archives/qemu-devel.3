Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F9CD5BDF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFi5-0003QC-TM; Thu, 05 Sep 2024 12:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1smFi4-0003Pi-Ga
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:51:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1smFi2-0004bx-IR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=Ox3bMJGVpaVktzb8HL9Y9cIdN7npq8hS7ZW48c9sLsg=; b=VXmUFmTG1AQC
 vZ8AhXyM/hwZMeKADEX87FfHrVsakXejVnmuu6QkhcCkDvWytpFrchy3ekjdxZ1sxqRqsCZSATqzO
 i67upWjqUFRa9lUCPLB9jh+tNQLwvGf9X/8WwkkdJ2gM6SAuouuXEUwlhVsso87qUEfCA8+7oQO7d
 x+1Ty2gdQ6O2sNgjNd4Yo6okYMoDe22GXwYJ6Y9WovhXkC15oKmZyJj2VT81l5gq1UEDYgyPUpM0b
 oUDFr/e0gjYRki1iIVyMjQd5hcgShGQwKqN1WLASP0eHmWU3oaagMud9iW+GtQo0eUXa83yCYSzTn
 dNMLfoH1q06kWdF3lFLhKA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1smFfX-001Fc7-08;
 Thu, 05 Sep 2024 18:51:46 +0200
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/1] migration: improve migration_throttle tracepoint
Date: Thu,  5 Sep 2024 18:51:46 +0200
Message-Id: <20240905165146.293586-1-den@openvz.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Right now this tracepoint is just saying that the guest has been
throttled, but this is not that good for debugging purposes. We should
also know how much the guest is throttled in order to understand
consequences for the guest behaviour.

The patch moves the tracepoint from migration_trigger_throttle() to
mig_throttle_guest_down() where this information is really available.
This is not a problem as mig_throttle_guest_down() is called in the
only one place.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c        | 9 ++++++---
 migration/trace-events | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index edec1a2d07..e587f11120 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -548,9 +548,11 @@ static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
     uint64_t throttle_now = cpu_throttle_get_percentage();
     uint64_t cpu_now, cpu_ideal, throttle_inc;
 
+    int new_throttle_pct;
+
     /* We have not started throttling yet. Let's start it. */
     if (!cpu_throttle_active()) {
-        cpu_throttle_set(pct_initial);
+        new_throttle_pct = pct_initial;
     } else {
         /* Throttling already on, just increase the rate */
         if (!pct_tailslow) {
@@ -563,8 +565,10 @@ static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
                         bytes_dirty_period);
             throttle_inc = MIN(cpu_now - cpu_ideal, pct_increment);
         }
-        cpu_throttle_set(MIN(throttle_now + throttle_inc, pct_max));
+        new_throttle_pct = MIN(throttle_now + throttle_inc, pct_max);
     }
+    trace_migration_throttle(new_throttle_pct);
+    cpu_throttle_set(new_throttle_pct);
 }
 
 void mig_throttle_counter_reset(void)
@@ -1032,7 +1036,6 @@ static void migration_trigger_throttle(RAMState *rs)
         (++rs->dirty_rate_high_cnt >= 2)) {
         rs->dirty_rate_high_cnt = 0;
         if (migrate_auto_converge()) {
-            trace_migration_throttle();
             mig_throttle_guest_down(bytes_dirty_period,
                                     bytes_dirty_threshold);
         } else if (migrate_dirty_limit()) {
diff --git a/migration/trace-events b/migration/trace-events
index 0b7c3324fb..099c828535 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -95,7 +95,7 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
-migration_throttle(void) ""
+migration_throttle(int new_throttle_pct)  "guest CPU throttled by %d%%"
 migration_dirty_limit_guest(int64_t dirtyrate) "guest dirty page rate limit %" PRIi64 " MB/s"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
-- 
2.40.1


