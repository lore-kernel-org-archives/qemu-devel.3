Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D30BC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12RA-0004F1-Vu; Mon, 31 Aug 2026 09:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RA-0004EX-7E
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R8-0003z2-FM
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NguZRg2njAzfq0LjCSooGLybivAspJ8iVsvKAnTuuw=;
 b=F8oYaNOyKbtnapaD+gX2qkFYeDAtS8NfQsmP1nXYTze4ghIr72Os3mTJoXsMROJwj/bEn1
 36wnZnS3c35BO/Fohdb6SYq2DIn0VYIxlWwVZRbfC3uWBDI/htNDzIQ+HGVbsOqL0hlv4Z
 94KBqy4TAuaXGjiwoqxaHpc6gFM/dj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-mgB30ikkOESbGGJAw1Zgbw-1; Mon, 31 Aug 2026 09:52:32 -0400
X-MC-Unique: mgB30ikkOESbGGJAw1Zgbw-1
X-Mimecast-MFC-AGG-ID: mgB30ikkOESbGGJAw1Zgbw_1788184351
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b0e6638e3so27238705e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184351; x=1788789151; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3NguZRg2njAzfq0LjCSooGLybivAspJ8iVsvKAnTuuw=;
 b=QW400cwTZS/YU0m64ODTF+0Ley79NzOVAizlKX3Lvej2WBE4hfOE8sKt5gPl1QQHqz
 TkbiDw7DfpsPa4SAnyVqjVziwq5GJu46Vk+VoeYZye5+2qfe2Hx3Ixi40dVymRcHvVYJ
 ZecEZanzpLdndjR5O0LxDVBHmKFec1jDwDUwUZlViRXV6F7s/28zf8TaRD583JJ5UDiL
 mfk739p6sZ1XUegtMdS8VAUyJw8fe4Mq/uEKxtCZHnDcbCUXO2fadI0x4rzj3WPQxUJJ
 uYzu8smpXk0hxfZ3MyiIKndKfkHyCs6R7oWGTSVnHx/LN+4SpkbkzRSOZSPSZ6QCNG72
 ZZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184351; x=1788789151;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3NguZRg2njAzfq0LjCSooGLybivAspJ8iVsvKAnTuuw=;
 b=J6LyK3WQXYb8g7SVSdRfrb3FgIQJbTrJ1dNbzjYvKNCCQuMDkGC/CnQSKa7nGIikCk
 7PO8UoKzoTyFKSL+MuyUc7CeopQG8Oj7Epd7/jc5K+kdCzmslYXSRgP1MLRo2o5nTFAm
 rSgB3zAbtoLCHoQevyPQfCiTXYKdf/vASiFhCFiEx4HqNS6FuAxAzmyb8Si1aYf4d2hK
 6aKk+kE1qGAU82lj1bVF0xL6yV2Ba86Bz+t5/iYVRI3pKHLig+kS5Yrgd6THPW3jkWbl
 llABnMlafAqc2B15dQZVQaySKDVnwPHwz8st94Qq8/vTYA5G5elt1AB8YbmnLGhHVyXZ
 u3yQ==
X-Gm-Message-State: AFuF++kfexdnh8NyfImyO+XMqBqWtXOsakGBIst8Fi8zu3lLhtP+17P7
 xYhgAUZ/sWqKrYRqGklx2vr6Vc4q5y/LSfD62bYK6lb3IemPDug/ne8bTBlObzrw0P7zGWV/GT6
 C7mnSRuuPIHFAt3Fkvk1TxH/fcfxLkd4fqF3lapd/6ThgjoKKVRvpTTmB
X-Gm-Gg: AR+sD10PH4dYVBE1arwpzZYl2QFaHAwnzWDFu5KgFtGqc9/Yx84M291zs3wfwh6UftJ
 tgzhgyox3hSXdcPtvWPydY/Y9JmVmhBZKOXmBLBlRPuCIhIxEu2U1Vq3wCFfymHX/tqLQqa5/Uz
 0KzNoDJZSybZLWPcbFl0Agbdrtx5S5exKHK1L9w/47sm5uOWZavg6eX9pPGR2U7IvhlpYJ+UljJ
 OX3OKHUN0Rn/FzFvTJRNY0Hq4Ra80g+J5GOYxhL2MUXhahPBXUL+gh+Ge+6W0mFn5oxkmM5YMkh
 x2Zz9W8d75gCc3XQZeD+B+RH72qyV+9wNs+YL1+q140SCj9J4NJCtyQ8qQSLWyNCtT4uYqeT69R
 FEiTzi6lDdVynKWpwY1TFu8jW/NI1onGkChm37+2zdYv0Y/VId4HU00Q6Unk=
X-Received: by 2002:a05:600c:1d08:b0:49c:d293:70c8 with SMTP id
 5b1f17b1804b1-49cdc40551bmr16384435e9.3.1788184350927; 
 Mon, 31 Aug 2026 06:52:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1d08:b0:49c:d293:70c8 with SMTP id
 5b1f17b1804b1-49cdc40551bmr16383065e9.3.1788184350390; 
 Mon, 31 Aug 2026 06:52:30 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd53a4678sm119908535e9.13.2026.08.31.06.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:29 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 5/9] block/accounting: Add BB field to latency checker
Date: Mon, 31 Aug 2026 15:52:01 +0200
Message-ID: <20260831135206.126184-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The BlockBackend reference is required to be able to generate the QOM
path as part of emitted events.

A weak reference is enough because BlockAcctStats is tied directly to
one BlockBackend, and will be deleted via block_acct_cleanup() before
the BlockBackend is truly deleted.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/accounting.h | 3 ++-
 block/accounting.c         | 7 ++++++-
 block/block-backend.c      | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index 9386440ec89..025536239e6 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -81,6 +81,7 @@ typedef struct BlockLatencyHistogram {
 
 struct BlockAcctStats {
     QemuMutex lock;
+    BlockBackend *blk;
     uint64_t nr_bytes[BLOCK_MAX_IOTYPE];
     uint64_t nr_ops[BLOCK_MAX_IOTYPE];
     uint64_t invalid_ops[BLOCK_MAX_IOTYPE];
@@ -101,7 +102,7 @@ typedef struct BlockAcctCookie {
     enum BlockAcctType type;
 } BlockAcctCookie;
 
-void block_acct_init(BlockAcctStats *stats);
+void block_acct_init(BlockBackend *blk, BlockAcctStats *stats);
 bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
                       enum OnOffAuto account_failed, uint32_t *stats_intervals,
                       uint32_t num_stats_intervals, Error **errp);
diff --git a/block/accounting.c b/block/accounting.c
index 66e5001403f..a74551d41f2 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -33,7 +33,7 @@
 static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
 static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
 
-void block_acct_init(BlockAcctStats *stats)
+void block_acct_init(BlockBackend *blk, BlockAcctStats *stats)
 {
     qemu_mutex_init(&stats->lock);
     if (qtest_enabled()) {
@@ -41,6 +41,11 @@ void block_acct_init(BlockAcctStats *stats)
     }
     stats->account_invalid = true;
     stats->account_failed = true;
+    /*
+     * No need to blk_ref() because block_acct_cleanup() is called exactly when
+     * the BB is deleted.
+     */
+    stats->blk = blk;
 }
 
 static bool bool_from_onoffauto(OnOffAuto val, bool def)
diff --git a/block/block-backend.c b/block/block-backend.c
index 164bda846f4..ca091a8bf5d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -369,7 +369,7 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm)
     blk->on_read_error = BLOCKDEV_ON_ERROR_REPORT;
     blk->on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
 
-    block_acct_init(&blk->stats);
+    block_acct_init(blk, &blk->stats);
 
     qemu_mutex_init(&blk->queued_requests_lock);
     qemu_co_queue_init(&blk->queued_requests);
-- 
2.55.0


