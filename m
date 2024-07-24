Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2B5C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 11:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWaNR-0000Rj-0R; Wed, 24 Jul 2024 07:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sWaNN-0000Qy-HD
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:41:45 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sWaNJ-0003c5-He
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:41:44 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so3500203a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1721821177; x=1722425977;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YY4VnD1TgCD23aObslpf6n5BvhxyB2Ve9mnZMmGrs20=;
 b=aGiZqnNWE27Uvkt+2fp7+aWaOBMycN010ifpIwyRzA0/+v6sEEr78/SyDnkgEDmzfG
 agB6IOt7E9i1wGdq2x6TWRtAQT7i/9rs95RsrMcPvnHDD9cYYv3yGfXHwQfDvhL+LxBd
 uI5MgVxgjscIdMPm5bQmjrlyFXBlou8RT3gi03P+D0TWdPimtxLVZE+SPZRbcZmDFIqd
 WrS6jASTQR0/de5xkzPGV1iwItyQ3Rqo0m9umvcXDqZ+yxZN6Tr2yCuGgtRk5NJOrXoO
 HgZH3SLJ9fUCqNCjNP7zABT7dX3TN1VNe7M15RR9+mPw0JorbK/4XHq9R740wkop3UYv
 ExEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721821177; x=1722425977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YY4VnD1TgCD23aObslpf6n5BvhxyB2Ve9mnZMmGrs20=;
 b=uSLU6YeNkOKZDUTE2Qt9zQXB6xrFkpuw52ABxHeLu9Yb0vV+7rgPAwLemiuyFyLGJh
 VXs+HlW61yg62ylAqRIAAu8BWNZCpkuSJIapcCE2ncsFCdRWFpXSZ6w8b3uhX1VjDGhN
 pxtYVXbKj6bhqnd7d1yrB2LopAnMz/XQfKbkmkhoE9RRFRtiKAZJCIjJkZDaSvMiCoGw
 +4yO7qtTg51hTSpAkAcS4CtP8qgpXvuWkS1z40L40JPmdJL8wtgJlhuocxhWPOik02dC
 XHGNYHi2UzHRVcxzhj8Xiz4UVbH0IkXMgQEiZi3B9Sn4++MNkHEvnTF9pE5YOcQwl0LF
 MB/w==
X-Gm-Message-State: AOJu0YyIew2mxDwsI0Fab5SFWa4CHzD31VHcSe/bCbv+zmQNgxLfu0s3
 Vj8no4xJ+69xxeBpVGdZF1nIRpm3Wq8IKfHXTIRXHH/dnjPh/FspngJ6eikZk+B0njxu69veHCP
 kjYTsug==
X-Google-Smtp-Source: AGHT+IGIm5lOKs4IC3zxZdsiAZoYLOBCBfSkVLoYhESYo2OpdjEN08IDYMwjly6ksh6zYg7zkN3h1Q==
X-Received: by 2002:a17:90a:f318:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2cdae338291mr2681453a91.5.1721821176860; 
 Wed, 24 Jul 2024 04:39:36 -0700 (PDT)
Received: from localhost.localdomain ([118.114.95.17])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb760e6absm1388868a91.55.2024.07.24.04.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 04:39:36 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com
Subject: [PATCH] migration: Refine the convergence detection
Date: Wed, 24 Jul 2024 19:39:29 +0800
Message-Id: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Currently, the convergence algorithm determines that the migration
cannot converge according to the following principle:
The dirty pages generated in current iteration exceed a specific
percentage (throttle-trigger-threshold, 50 by default) of the number
of transmissions. Let's refer to this criteria as the
"transmission speed," If this criteria is met more than or equal to
twice (dirty_rate_high_cnt >= 2), the throttle percentage needs to
be increased.

In most cases, above implementation is appropriate. However, for a
VM with a huge memory and high memory overload, each iteration is
time-consuming. The VM's computing performance may be throttled at
a high percentage and last for a long time due to the repeated
confirmation behavior. Which may be intolerable for some
computationally sensitive software in the VM. The refinement is for
this scenario.

As the comment mentioned in the migration_trigger_throttle function,
in order to avoid erroneous detection, the original algorithm confirms
the criteria repeatedly. Put differently, once the detection become
more reliable, it does not need to be confirmed twice.

In the refinement, in order to make the detection more accurate, we
introduce another criteria, called the "valid transmission ratio"
to determine the migration convergence. The "valid transmission ratio"
is the ratio of bytes_xfer_period and bytes_dirty_period, which
actually describe the migration efficiency.

When the algorithm repeatedly detects that the current iteration
"valid transmission ratio" is lower than the previous iteration,
the algorithm determines that the migration cannot converge.

For the "transmission speed" and "valid transmission ratio", if one
of the two criteria is met, the penalty percentage would be increased.
This saves the time of the entire iteration and therefore reduces
the time of VM performance degradation.

In conclusion, this refinement significantly reduces the processing
time required for the throttle percentage step to its maximum while
the VM is under a high memory load.

The following are test environment:
----------------------------------------------------------------------
a. Test tool:
guestperf

Refer to the following link to see details:
https://github.com/qemu/qemu/tree/master/tests/migration/guestperf

b. Test VM scale:
CPU: 10; Memory: 28GB

c. Average bandwidth between source and destination for migration:
1.53 Gbits/sec
----------------------------------------------------------------------
All the supplementary test data shown as follows are basing on
above test environment.

We use stress tool contained in the initrd-stress.img to update
ramsize MB on every CPU in guest, refer to the following link to
see the source code:
https://github.com/qemu/qemu/blob/master/tests/migration/stress.c

We run the following command to compare our refined QEMU with the
original QEMU:

$ ./migration/guestperf.py --cpus 10 --mem 28 --max-iters 40 \
--binary $(path_to_qemu-kvm) \
--dst-host $(destination_ip) \
--transport tcp --kernel $(path_to_vmlinuz) \
--initrd $(path_to_initrd-stress.img) \
--auto-converge \
--auto-converge-step 10 \
--max-iters 40

The following data shows the migration test results with an increase in
stress, ignoring the title row, the odd rows show the unrefined QEMU
test data, and the even rows show the refined QEMU test data:

|---------+--------+-----------+--------------+------------+------------|
| ramsize | sucess | totaltime | downtime(ms) | iterations | switchover |
| (MB)    |        | (ms)      | (ms)         |            | throttle   |
|         |        |           |              |            | percent    |
|---------+--------+-----------+--------------+------------+------------|
|     350 |    yes |    170285 |          399 |         23 |         99 |
|     350 |    yes |     85962 |          412 |         24 |         70 |
|     350 |    yes |    176305 |          199 |         20 |         99 |
|     350 |    yes |     66729 |          321 |         11 |         40 |
|     400 |    yes |    183042 |          469 |         21 |         99 |
|     400 |    yes |     77225 |          421 |         10 |         30 |
|     400 |    yes |    183641 |          866 |         27 |         99 |
|     400 |    yes |     59796 |          479 |         15 |         50 |
|     450 |    yes |    165881 |          820 |         21 |         99 |
|     450 |    yes |     87930 |          368 |         20 |         90 |
|     450 |    yes |    195448 |          452 |         23 |         99 |
|     450 |    yes |     70394 |          295 |          6 |         20 |
|     500 |    yes |    112587 |          471 |         19 |         99 |
|     500 |    yes |     57401 |          299 |          5 |         30 |
|     500 |    yes |    110683 |          657 |         21 |         99 |
|     500 |    yes |     69949 |          649 |          8 |         40 |
|     600 |    yes |    111036 |          324 |         23 |         99 |
|     600 |    yes |     63455 |          346 |          4 |         20 |
|     600 |    yes |    126667 |          426 |         20 |         99 |
|     600 |    yes |    101024 |          643 |         20 |         99 |
|    1000 |    yes |    296216 |          660 |         23 |         99 |
|    1000 |    yes |    106915 |          468 |         16 |         99 |
|    1000 |     no |    300000 |              |            |            |
|    1000 |    yes |    125819 |          824 |         17 |         99 |
|    1200 |     no |    300000 |              |            |            |
|    1200 |    yes |    127379 |          664 |         14 |         90 |
|    1200 |     no |    300000 |              |            |            |
|    1200 |    yes |     67086 |          793 |         11 |         50 |
|---------+--------+-----------+--------------+------------+------------|

To summarize the data above, any data that implies negative optimization
does not appear, and morover, the throttle algorithm seems to become more
responsive to dirty rate increases due to the refined detection.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/ram.c        | 48 +++++++++++++++++++++++++++++++++++++++---
 migration/trace-events |  1 +
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index edec1a2d07..18b2d422b5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -414,6 +414,17 @@ struct RAMState {
      * RAM migration.
      */
     unsigned int postcopy_bmap_sync_requested;
+
+    /*
+     * Ratio of bytes_dirty_period and bytes_xfer_period in the last
+     * iteration
+     */
+    uint64_t dirty_ratio_pct;
+    /*
+     * How many times is the most recent iteration dirty ratio is
+     * higher than previous one
+     */
+    int dirty_ratio_high_cnt;
 };
 typedef struct RAMState RAMState;
 
@@ -1013,6 +1024,32 @@ static void migration_dirty_limit_guest(void)
     trace_migration_dirty_limit_guest(quota_dirtyrate);
 }
 
+static bool migration_dirty_ratio_unexpected(RAMState *rs)
+{
+    uint64_t threshold = migrate_throttle_trigger_threshold();
+    uint64_t bytes_xfer_period =
+        migration_transferred_bytes() - rs->bytes_xfer_prev;
+    uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
+    uint64_t prev, curr;
+
+    /* Skip the first iterations since it isn't helpful */
+    if (stat64_get(&mig_stats.dirty_sync_count) == 1 || !bytes_xfer_period) {
+        return false;
+    }
+
+    curr = 100 * (bytes_dirty_period * 1.0 / bytes_xfer_period);
+
+    prev = rs->dirty_ratio_pct;
+    rs->dirty_ratio_pct = curr;
+
+    if (prev == 0 || curr <= threshold) {
+        return false;
+    }
+
+    trace_dirty_ratio_pct(curr, prev);
+    return curr >= prev;
+}
+
 static void migration_trigger_throttle(RAMState *rs)
 {
     uint64_t threshold = migrate_throttle_trigger_threshold();
@@ -1028,9 +1065,14 @@ static void migration_trigger_throttle(RAMState *rs)
      * we were in this routine reaches the threshold. If that happens
      * twice, start or increase throttling.
      */
-    if ((bytes_dirty_period > bytes_dirty_threshold) &&
-        (++rs->dirty_rate_high_cnt >= 2)) {
-        rs->dirty_rate_high_cnt = 0;
+    if ((migration_dirty_ratio_unexpected(rs) &&
+         (++rs->dirty_ratio_high_cnt >= 2)) ||
+        ((bytes_dirty_period > bytes_dirty_threshold) &&
+         (++rs->dirty_rate_high_cnt >= 2))) {
+        rs->dirty_rate_high_cnt =
+            rs->dirty_rate_high_cnt >= 2 ? 0 : rs->dirty_rate_high_cnt;
+        rs->dirty_ratio_high_cnt =
+            rs->dirty_ratio_high_cnt >= 2 ? 0 : rs->dirty_ratio_high_cnt;
         if (migrate_auto_converge()) {
             trace_migration_throttle();
             mig_throttle_guest_down(bytes_dirty_period,
diff --git a/migration/trace-events b/migration/trace-events
index 0b7c3324fb..654c52c5e4 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 qemu_file_fclose(void) ""
 
 # ram.c
+dirty_ratio_pct(uint64_t cur, uint64_t prev) "current ratio: %" PRIu64 " previous ratio: %" PRIu64
 get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
 get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
 migration_bitmap_sync_start(void) ""
-- 
2.39.1


