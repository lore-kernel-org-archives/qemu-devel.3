Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B11CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4y2-0003Tq-PI; Wed, 29 Oct 2025 08:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xR-0003DY-Mr
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xE-00050l-Oh
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2nLVnIMpd1SN7HGH5Ve6xUlTg+yyzNFQi5ephwI5Ls=;
 b=LdfOvCYb/1M2bpDRMQu5NOjBdyAEB8pZczC+qhRDTd+TkPxTqIMuoZq/OtDqzR+c/j8Gl+
 Xjz4F+vk1fAavpNeb34UsDQ1yU6ZEWvCZtA5v4SxEkH6r09rESbtQ/R0/dttp7hXCTJGAr
 YRzzPX0YF/HDF2J8/vIgMtjAJO4+/zE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-XwDIVz7xMgeaZY5vYF60qw-1; Wed,
 29 Oct 2025 08:06:54 -0400
X-MC-Unique: XwDIVz7xMgeaZY5vYF60qw-1
X-Mimecast-MFC-AGG-ID: XwDIVz7xMgeaZY5vYF60qw_1761739613
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B433F180A200; Wed, 29 Oct 2025 12:06:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39103180057C; Wed, 29 Oct 2025 12:06:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/18] block: enable stats-intervals for storage devices
Date: Wed, 29 Oct 2025 13:06:24 +0100
Message-ID: <20251029120634.288467-9-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Chandan Somani <csomani@redhat.com>

This patch allows stats-intervals to be used for storage
devices with the -device option. It accepts a list of interval
lengths in JSON format.

It configures and collects the stats in the BlockBackend layer
through the storage device that consumes the BlockBackend.

Signed-off-by: Chandan Somani <csomani@redhat.com>
Message-ID: <20251003220039.1336663-1-csomani@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/accounting.h |  5 +++--
 include/hw/block/block.h   |  7 ++++++-
 block/accounting.c         | 17 +++++++++++++++--
 blockdev.c                 |  3 ++-
 hw/block/block.c           |  7 +++++--
 tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index a59e39f49d..b1cf417b57 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -101,8 +101,9 @@ typedef struct BlockAcctCookie {
 } BlockAcctCookie;
 
 void block_acct_init(BlockAcctStats *stats);
-void block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
-                      enum OnOffAuto account_failed);
+bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
+                      enum OnOffAuto account_failed, uint32_t *stats_intervals,
+                      uint32_t num_stats_intervals, Error **errp);
 void block_acct_cleanup(BlockAcctStats *stats);
 void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
 BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index de3946a5f1..b4d914624e 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -34,6 +34,8 @@ typedef struct BlockConf {
     OnOffAuto account_invalid, account_failed;
     BlockdevOnError rerror;
     BlockdevOnError werror;
+    uint32_t num_stats_intervals;
+    uint32_t *stats_intervals;
 } BlockConf;
 
 static inline unsigned int get_physical_block_exp(BlockConf *conf)
@@ -66,7 +68,10 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
     DEFINE_PROP_ON_OFF_AUTO("account-invalid", _state,                  \
                             _conf.account_invalid, ON_OFF_AUTO_AUTO),   \
     DEFINE_PROP_ON_OFF_AUTO("account-failed", _state,                   \
-                            _conf.account_failed, ON_OFF_AUTO_AUTO)
+                            _conf.account_failed, ON_OFF_AUTO_AUTO),    \
+    DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
+                     _conf.num_stats_intervals, _conf.stats_intervals,  \
+                     qdev_prop_uint32, uint32_t)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
diff --git a/block/accounting.c b/block/accounting.c
index 3e46159569..0933c61f3a 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -28,6 +28,7 @@
 #include "block/block_int.h"
 #include "qemu/timer.h"
 #include "system/qtest.h"
+#include "qapi/error.h"
 
 static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
 static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
@@ -56,13 +57,25 @@ static bool bool_from_onoffauto(OnOffAuto val, bool def)
     }
 }
 
-void block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
-                      enum OnOffAuto account_failed)
+bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
+                      enum OnOffAuto account_failed, uint32_t *stats_intervals,
+                      uint32_t num_stats_intervals, Error **errp)
 {
     stats->account_invalid = bool_from_onoffauto(account_invalid,
                                                  stats->account_invalid);
     stats->account_failed = bool_from_onoffauto(account_failed,
                                                 stats->account_failed);
+    if (stats_intervals) {
+        for (int i = 0; i < num_stats_intervals; i++) {
+            if (stats_intervals[i] <= 0) {
+                error_setg(errp, "Invalid interval length: %u", stats_intervals[i]);
+                return false;
+            }
+            block_acct_add_interval(stats, stats_intervals[i]);
+        }
+        g_free(stats_intervals);
+    }
+    return true;
 }
 
 void block_acct_cleanup(BlockAcctStats *stats)
diff --git a/blockdev.c b/blockdev.c
index b451fee6e1..dbd1d4d3e8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -617,7 +617,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
         bs->detect_zeroes = detect_zeroes;
 
-        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed);
+        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
+                         NULL, 0, NULL);
 
         if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
             blk_unref(blk);
diff --git a/hw/block/block.c b/hw/block/block.c
index 2e10611d95..f187fa025d 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -249,8 +249,11 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
     blk_set_enable_write_cache(blk, wce);
     blk_set_on_error(blk, rerror, werror);
 
-    block_acct_setup(blk_get_stats(blk), conf->account_invalid,
-                     conf->account_failed);
+    if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
+                          conf->account_failed, conf->stats_intervals,
+                          conf->num_stats_intervals, errp)) {
+        return false;
+    }
     return true;
 }
 
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 146fc72388..a023cd407d 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -30,6 +30,7 @@ Testing:
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
 
 
@@ -59,6 +60,7 @@ Testing: -fda TEST_DIR/t.qcow2
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -95,6 +97,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -109,6 +112,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -149,6 +153,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -163,6 +168,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -204,6 +210,7 @@ Testing: -fdb
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -218,6 +225,7 @@ Testing: -fdb
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
 
 
@@ -247,6 +255,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -283,6 +292,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -297,6 +307,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -337,6 +348,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -351,6 +363,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -395,6 +408,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -431,6 +445,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -467,6 +482,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -481,6 +497,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -531,6 +548,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -545,6 +563,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -586,6 +605,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -600,6 +620,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -641,6 +662,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -655,6 +677,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -696,6 +719,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -710,6 +734,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -760,6 +785,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -774,6 +800,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -815,6 +842,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -829,6 +857,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -876,6 +905,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -942,6 +972,7 @@ Testing: -device floppy
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
 
 Testing: -device floppy,drive-type=120
@@ -968,6 +999,7 @@ Testing: -device floppy,drive-type=120
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "120"
 
 Testing: -device floppy,drive-type=144
@@ -994,6 +1026,7 @@ Testing: -device floppy,drive-type=144
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 
 Testing: -device floppy,drive-type=288
@@ -1020,6 +1053,7 @@ Testing: -device floppy,drive-type=288
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
 
 
@@ -1049,6 +1083,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "120"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1085,6 +1120,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "288"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1124,6 +1160,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1160,6 +1197,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 share-rw = false
                 account-invalid = "auto"
                 account-failed = "auto"
+                stats-intervals = <null>
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
-- 
2.51.0


