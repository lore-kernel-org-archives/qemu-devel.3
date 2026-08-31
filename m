Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68979C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12RL-0004Lr-4H; Mon, 31 Aug 2026 09:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RH-0004LI-JL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RF-00040Q-Hr
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsKq84WWl0P0xyX3zc9NdARXmnRPfWGby8GQ+hm8M4k=;
 b=OmXRVaR6t1g0bcYkyKPCumQJXwvnlKZCswBmC9ksMtnTcNK9BXgpQVp1/H/mtB0im3E+22
 gABqWmKPNY3wLjDa0eXhf1LhirYKoAmfW9wui9TxUMmluD2ZvthVnccm+ORYurQ1Ldrzk4
 dFXdo+oE0Ng+6p3g9h+Q1qIxRRujEXE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-dtl7g0woNjOfjc9QgRrsWg-1; Mon, 31 Aug 2026 09:52:38 -0400
X-MC-Unique: dtl7g0woNjOfjc9QgRrsWg-1
X-Mimecast-MFC-AGG-ID: dtl7g0woNjOfjc9QgRrsWg_1788184357
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49554715277so33079225e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184357; x=1788789157; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XsKq84WWl0P0xyX3zc9NdARXmnRPfWGby8GQ+hm8M4k=;
 b=RKYlJU07dQyivLl/sgrIO6wRipD9Txy+RvYxdk5srUyA0s95r3KuNaC17i11Ddttma
 jRNwxSgjPZyhdgnk34feUg+8GmzObOjHnu5XqO9DmLczsJUAE6ue0pi20BlINYJJsKHy
 9HAAsp/tiAup8bJX9DQgYahI6N1HEjCjPuVMfRr7HwmGZurHvyL7g7QN4ffaBL2VwdGQ
 BuMi425iMlZDRu0/Y/OYNOIiJ2chkj8jHB7NxB7ysc+4nlEVqaHJMdMbk00HqmlXZ2r5
 3CI1cQZN9y31+aYvVKymm1RZL6S7O3pF/OePYdvWFKnWWByooIlDrLhIR7D5/AfQ0cSn
 m7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184357; x=1788789157;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XsKq84WWl0P0xyX3zc9NdARXmnRPfWGby8GQ+hm8M4k=;
 b=XAk2tjWGw7dLC9rba3h04WDCyjRiw8u2COHS+CX0F1q2qZoFA6IgTlksqcqvsVaFUF
 HOnNESDV65df53zuFzoddUVkGea4LIqZpWPLX8fUnHHV+JT/pXi/livdf6lQtimHNfbs
 m1hZqIj9Uka00FNIKis041iggRbZJVRc0WR8T+CO33p8TjVoSDueTsPx500LHEwJWu+v
 I3Xk6FW+545ymiVyGq9BblAIom2Pd9smR54SWiGiEfWuC09fOtJpBFm21S9E4G0wXOor
 9MOGqFJiKPvVtYerQQadjGqDCVu8jpssT9u+nDrOctPAbRcK7stCfB8nhNM3aC5NcFE8
 U85w==
X-Gm-Message-State: AFuF++k3syWGneb7GcVw0LHCF4mR6K/DoseTTBtEn27nRAOJtZx/I8pE
 l4FVdabGpYegs64ywVIMus/yYLhTToOfQTSDFJFZ1yV5+HFCCp/oP6DP1XITekUr7Q8YlLqA+e1
 nyhSo74g4SDt/gCyBEiEK/pb/GDuVtRvTSxuOlC7V2sU+VTe87XzF/Cme
X-Gm-Gg: AR+sD11YhexN2IwEoN4QLbtp9hq5h88AAX7nlFBpMPwwsMPfiqr9EN4EzaA/2PhTgtk
 XRn93C9HSKgjD5A3myg/cx7ujbhfHp9hv6qm28/1sajVtVI/TLIhza09VmcKyaiBL3ChUp6P6Zi
 HFlX7+KXMO/HafWmvHb+zHso1itsLcJWPLoNcsSiB+eacF/5Gb4xzVP0FNLjyW9EJnOC0E1afbH
 xrcxkliOwz4fT2MJ3mMqjtEDQVNwp6bX/fp7B44+3jvAxav3vXTsseiySlMG/TrKFBI0/vjHOLU
 XYMrzbynBORlCe+NMN8lBVOl1fyLLLnpq9eLekhjJS5HYNzCRHAOjSNt9UlJFmqv7F5yx1ZX8IA
 WN2e4xMBtgGJP8YEb6nljef83EZmTPq/QcvMiCDmbhnySPxztnctejH1B/5E=
X-Received: by 2002:a05:600c:a4a:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49cdc567061mr15382985e9.13.1788184357391; 
 Mon, 31 Aug 2026 06:52:37 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49cdc567061mr15382005e9.13.1788184356984; 
 Mon, 31 Aug 2026 06:52:36 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccea6b814sm177277405e9.0.2026.08.31.06.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:31 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
Date: Mon, 31 Aug 2026 15:52:02 +0200
Message-ID: <20260831135206.126184-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a request finishes with a higher latency than a predefined
threshold, emit the BLOCK_IO_DELAY event.

Note there would be an alternative, more precise solution: We could keep
all active cookies per BlockBackend in a list and repeatedly iterate
over it in a background coroutine (woken on a timer so it would wake
always exactly when the next request would time out, so it generally
stays asleep until there is actually a timeout). This way, we could emit
the event exactly when a request crosses the delay threshold, while it
is still running; and we could hypothetically even take actions like
pausing the VM until the request is done so the guest operating system
is shielded from extreme latency spikes.

In practice, this is very complicated because latency cookies are
created and finalized all over the place, so it is very hard to
guarantee that every `block_acct_start()` is matched by the right
finalization to ensure that cookies are properly removed from the list
when they are done. Even if we fix all non-matching places now, there is
hardly a guarantee this will be kept in order in the future.

So, for now, just implement the simpler solution of only notifying the
management layer when the request does complete, so VMs with high
latency spikes can at least be identified when they happen without
having to regularly check the latency histogram.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/accounting.h | 10 ++++++++-
 block/accounting.c         | 42 +++++++++++++++++++++++++++++++++++++-
 blockdev.c                 |  2 +-
 hw/block/block.c           |  2 +-
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index 025536239e6..ba3a6859cf4 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -92,6 +92,7 @@ struct BlockAcctStats {
     QSLIST_HEAD(, BlockAcctTimedStats) intervals;
     bool account_invalid;
     bool account_failed;
+    int64_t delay_threshold_ns;
     BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
 };
 
@@ -103,9 +104,16 @@ typedef struct BlockAcctCookie {
 } BlockAcctCookie;
 
 void block_acct_init(BlockBackend *blk, BlockAcctStats *stats);
+/**
+ * Set up accounting for a block device in @stats.
+ * @alert_ns specifies a latency so that if any request takes longer than that
+ * threshold, a BLOCK_IO_DELAY event will be generated (when that request
+ * completes). Pass 0 to disable.
+ */
 bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
                       enum OnOffAuto account_failed, uint32_t *stats_intervals,
-                      uint32_t num_stats_intervals, Error **errp);
+                      uint32_t num_stats_intervals, int64_t alert_ns,
+                      Error **errp);
 void block_acct_cleanup(BlockAcctStats *stats);
 void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
 BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
diff --git a/block/accounting.c b/block/accounting.c
index a74551d41f2..debf1924455 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -27,8 +27,10 @@
 #include "block/accounting.h"
 #include "block/block_int.h"
 #include "qemu/timer.h"
+#include "system/block-backend.h"
 #include "system/qtest.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-block.h"
 
 static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
 static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
@@ -62,9 +64,35 @@ static bool bool_from_onoffauto(OnOffAuto val, bool def)
     }
 }
 
+/**
+ * Convert a BlockAcctType into its QAPI equivalent IoAccountingOperation.
+ *
+ * Must only be called for valid BlockAcctType values, i.e. specifically not for
+ * `BLOCK_ACCT_NONE`.
+ */
+static IoAccountingOperation block_acct_qapi_type(enum BlockAcctType type)
+{
+    switch (type) {
+    case BLOCK_ACCT_READ:
+        return IO_ACCOUNTING_OPERATION_READ;
+    case BLOCK_ACCT_WRITE:
+        return IO_ACCOUNTING_OPERATION_WRITE;
+    case BLOCK_ACCT_FLUSH:
+        return IO_ACCOUNTING_OPERATION_FLUSH;
+    case BLOCK_ACCT_ZONE_APPEND:
+        return IO_ACCOUNTING_OPERATION_ZONE_APPEND;
+    case BLOCK_ACCT_UNMAP:
+        return IO_ACCOUNTING_OPERATION_UNMAP;
+    case BLOCK_ACCT_NONE:
+    default:
+        g_assert_not_reached();
+    }
+}
+
 bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
                       enum OnOffAuto account_failed, uint32_t *stats_intervals,
-                      uint32_t num_stats_intervals, Error **errp)
+                      uint32_t num_stats_intervals, int64_t alert_ns,
+                      Error **errp)
 {
     stats->account_invalid = bool_from_onoffauto(account_invalid,
                                                  stats->account_invalid);
@@ -79,6 +107,7 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
             block_acct_add_interval(stats, stats_intervals[i]);
         }
     }
+    stats->delay_threshold_ns = alert_ns;
     return true;
 }
 
@@ -252,6 +281,17 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
         return;
     }
 
+    if (stats->delay_threshold_ns && latency_ns > stats->delay_threshold_ns) {
+        g_autofree char *dev_path = blk_get_attached_dev_path(stats->blk);
+        double latency = latency_ns / (double)NANOSECONDS_PER_SECOND;
+
+        qapi_event_send_block_io_delay(dev_path,
+                                       block_acct_qapi_type(cookie->type),
+                                       latency,
+                                       cookie->offset >= 0, cookie->offset,
+                                       cookie->bytes);
+    }
+
     WITH_QEMU_LOCK_GUARD(&stats->lock) {
         if (failed) {
             stats->failed_ops[cookie->type]++;
diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f9..195bac8af01 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -618,7 +618,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         bs->detect_zeroes = detect_zeroes;
 
         block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
-                         NULL, 0, NULL);
+                         NULL, 0, 0, NULL);
 
         if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
             blk_unref(blk);
diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d0..19301c6f995 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -251,7 +251,7 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
 
     if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
                           conf->account_failed, conf->stats_intervals,
-                          conf->num_stats_intervals, errp)) {
+                          conf->num_stats_intervals, 0, errp)) {
         return false;
     }
     return true;
-- 
2.55.0


