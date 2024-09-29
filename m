Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6264CF6497
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 17:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suxVZ-0007xF-45; Sun, 29 Sep 2024 13:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVU-0007ha-Ug
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suxVT-0003Zq-3N
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 13:14:52 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so3186218a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727630089; x=1728234889;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lct2qG6Dr1J/Ztgltsu8rr9H+Svw6tNcIbTwP/vog4Y=;
 b=UnSNkSeOqiuFMB+uvia+aY7X5SIqhxLhDn7MbtUX+tMtcVWhYbCQ4GYkaZXw/TK4g3
 lk22LjqZy6XUHAwXTq60MoYUC5YB8/BLcveM35sV8WOTn4Obyq6pdV2B1avyPYB4vSss
 w9gDDORjJoLzEES5lA3GruKZmqV5Eqikwh9Px2rMwkDm9PsGtmae4MVL1oQRdaoa9urb
 672Q1eoN82jxSSaAJWu8UQ+H0XKPzeSkroQ9Cmetm5aOeSHJF/0DWpZ6r2gVPYNUsbYZ
 udJ3PFnodFZL/lYzC0vC1t0EzH6rVpLW6dBPTvXqjPqzClWOs24V8+8jszllytEr1lDg
 3Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727630089; x=1728234889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lct2qG6Dr1J/Ztgltsu8rr9H+Svw6tNcIbTwP/vog4Y=;
 b=LUcQvK1NucBE/x83HYxg9cS7s6La7YCMywHd8F2SOrGhMy8Jn+FT5GsmQBvJmeqMB4
 8aiho5Tfc+/8enjZQbcqiTzWKNDhoAnhZEhNT34iqIDqdhjsZYqDjpeVifC0v4tHhwWl
 FiOkppoG8RUKqZVO1r2/XaJE4FCYQXhw4jYi/VJCvQ79u/BPsMy2mPTmZAkp+QwnS7wj
 iunQEyaLn/aHzvtE/JKkDSuPoQkXBzHSEetnD8DKGprZiQVmSHtn7orRXTw8ORATH7SL
 MMFmcTniAfDo9f0eq8OvHkZvi7dNXdVfrXvnCRxYwxEyYLtI6KwnbSzhyDeAUT6nXt6p
 0k5w==
X-Gm-Message-State: AOJu0YxIK2Ze8F8TuwgQWUtc6lykMS5XNwcm0YBIHqmdl8xLAnkD9NCV
 zPo5Iz0Zd7XQxyoy4Mv0js1spRvwPNP646QNwAIZL5DlLxkQiZFTuIMAW4gUD05oiqVdewUk8sN
 D1t8=
X-Google-Smtp-Source: AGHT+IEys5TL+ki4JGSvJ3ApkUnwu2Pcw64XyFhbq1WYeQv3iYqy1KnTKXjyyo4gLaL+yBXjeikr0w==
X-Received: by 2002:a17:90b:104:b0:2d3:c088:9c54 with SMTP id
 98e67ed59e1d1-2e0b876d788mr10752186a91.6.1727630088876; 
 Sun, 29 Sep 2024 10:14:48 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e1e09e2sm9597408a91.32.2024.09.29.10.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 10:14:48 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 3/3] migration: Support responsive CPU throttle
Date: Mon, 30 Sep 2024 01:14:28 +0800
Message-Id: <3a383e563cc57c77320af805c8b8ece4e68eebea.1727630000.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1727630000.git.yong.huang@smartx.com>
References: <cover.1727630000.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x531.google.com
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

Currently, the convergence algorithm determines that the migration
cannot converge according to the following principle:
The dirty pages generated in current iteration exceed a specific
percentage (throttle-trigger-threshold, 50 by default) of the number
of transmissions. Let's refer to this criteria as the "dirty rate".
If this criteria is met more than or equal to twice
(dirty_rate_high_cnt >= 2), the throttle percentage increased.

In most cases, above implementation is appropriate. However, for a
VM with high memory overload, each iteration is time-consuming.
The VM's computing performance may be throttled at a high percentage
and last for a long time due to the repeated confirmation behavior.
Which may be intolerable for some computationally sensitive software
in the VM.

As the comment mentioned in the migration_trigger_throttle function,
in order to avoid erroneous detection, the original algorithm confirms
the criteria repeatedly. Put differently, the criteria does not need
to be validated again once the detection is more reliable.

In the refinement, in order to make the detection more accurate, we
introduce another criteria, called the "dirty ratio" to determine
the migration convergence. The "dirty ratio" is the ratio of
bytes_xfer_period and bytes_dirty_period. When the algorithm
repeatedly detects that the "dirty ratio" of current sync is lower
than the previous, the algorithm determines that the migration cannot
converge. For the "dirty rate" and "dirty ratio", if one of the two
criteria is met, the penalty percentage would be increased. This
makes CPU throttle more responsively and therefor saves the time of
the entire iteration and therefore reduces the time of VM performance
degradation.

In conclusion, this refinement significantly reduces the processing
time required for the throttle percentage step to its maximum while
the VM is under a high memory load.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/ram.c              | 55 ++++++++++++++++++++++++++++++++++--
 migration/trace-events       |  1 +
 tests/qtest/migration-test.c |  1 +
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 995bae1ac9..c36fed5135 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -420,6 +420,12 @@ struct RAMState {
      * RAM migration.
      */
     unsigned int postcopy_bmap_sync_requested;
+
+    /*
+     * Ratio of bytes_dirty_period and bytes_xfer_period in the
+     * previous sync.
+     */
+    uint64_t dirty_ratio_pct;
 };
 typedef struct RAMState RAMState;
 
@@ -1019,6 +1025,43 @@ static void migration_dirty_limit_guest(void)
     trace_migration_dirty_limit_guest(quota_dirtyrate);
 }
 
+static bool migration_dirty_ratio_high(RAMState *rs)
+{
+    static int dirty_ratio_high_cnt;
+    uint64_t threshold = migrate_throttle_trigger_threshold();
+    uint64_t bytes_xfer_period =
+        migration_transferred_bytes() - rs->bytes_xfer_prev;
+    uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
+    bool dirty_ratio_high = false;
+    uint64_t prev, curr;
+
+    /* Calculate the dirty ratio percentage */
+    curr = 100 * (bytes_dirty_period * 1.0 / bytes_xfer_period);
+
+    prev = rs->dirty_ratio_pct;
+    rs->dirty_ratio_pct = curr;
+
+    if (prev == 0) {
+        return false;
+    }
+
+    /*
+     * If current dirty ratio is greater than previouse, determine
+     * that the migration do not converge.
+     */
+    if (curr > threshold && curr >= prev) {
+        trace_migration_dirty_ratio_high(curr, prev);
+        dirty_ratio_high_cnt++;
+    }
+
+    if (dirty_ratio_high_cnt >= 2) {
+        dirty_ratio_high = true;
+        dirty_ratio_high_cnt = 0;
+    }
+
+    return dirty_ratio_high;
+}
+
 static void migration_trigger_throttle(RAMState *rs)
 {
     uint64_t threshold = migrate_throttle_trigger_threshold();
@@ -1026,6 +1069,11 @@ static void migration_trigger_throttle(RAMState *rs)
         migration_transferred_bytes() - rs->bytes_xfer_prev;
     uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
     uint64_t bytes_dirty_threshold = bytes_xfer_period * threshold / 100;
+    bool dirty_ratio_high = false;
+
+    if (migrate_cpu_throttle_responsive() && (bytes_xfer_period != 0)) {
+        dirty_ratio_high = migration_dirty_ratio_high(rs);
+    }
 
     /*
      * The following detection logic can be refined later. For now:
@@ -1035,8 +1083,11 @@ static void migration_trigger_throttle(RAMState *rs)
      * twice, start or increase throttling.
      */
     if ((bytes_dirty_period > bytes_dirty_threshold) &&
-        (++rs->dirty_rate_high_cnt >= 2)) {
-        rs->dirty_rate_high_cnt = 0;
+        ((++rs->dirty_rate_high_cnt >= 2) || dirty_ratio_high)) {
+
+        rs->dirty_rate_high_cnt =
+            rs->dirty_rate_high_cnt >= 2 ? 0 : rs->dirty_rate_high_cnt;
+
         if (migrate_auto_converge()) {
             trace_migration_throttle();
             mig_throttle_guest_down(bytes_dirty_period,
diff --git a/migration/trace-events b/migration/trace-events
index 3f09e7f383..19a1ff7973 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -96,6 +96,7 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
+migration_dirty_ratio_high(uint64_t cur, uint64_t prev) "current ratio: %" PRIu64 " previous ratio: %" PRIu64
 migration_throttle(void) ""
 migration_dirty_limit_guest(int64_t dirtyrate) "guest dirty page rate limit %" PRIi64 " MB/s"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3296f5244d..acdc1d6358 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2807,6 +2807,7 @@ static void test_migrate_auto_converge(void)
     migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
     migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
     migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+    migrate_set_parameter_bool(from, "cpu-throttle-responsive", true);
 
     /*
      * Set the initial parameters so that the migration could not converge
-- 
2.27.0


