Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E01CC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84jN-0002NZ-SW; Thu, 24 Apr 2025 18:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u84j1-0002Mp-S0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u84ix-0007hE-OY
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745532431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KJylaBEhS4zY32bG5Fn91bK8lynEEWO1umQ6/lwOOYc=;
 b=eZHSfcS9J73zPIePm3EWDliWd4bVwHRDwCfPALYw84BmOWqCbw4natptlf43Lp4pMmDHCF
 vcgAQP+/W8sEzP65kjwfqc2L2gYLwDQAvsUgP+7JHN1wInXE3UChLlaUzUV+Ahrpy5Hf1e
 cPpa5UzUIMCyWW0PepahdqOjzoCFD/8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-TWSXbYM-NB2FN7TBr0c-_w-1; Thu, 24 Apr 2025 18:07:09 -0400
X-MC-Unique: TWSXbYM-NB2FN7TBr0c-_w-1
X-Mimecast-MFC-AGG-ID: TWSXbYM-NB2FN7TBr0c-_w_1745532429
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c09f73873fso210359485a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745532429; x=1746137229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJylaBEhS4zY32bG5Fn91bK8lynEEWO1umQ6/lwOOYc=;
 b=u5yS6GQXMV8y5bfSBUmWwL3xTeFnPb4lGbZr7U8TibiGn13JYv59lZP3lt6dFn09Z4
 i0n+ZslorCoQrJQZLnIBSxqxl/wQ958TOyR7nItf0b6sRQIW0z8rS1TI5ZubVZns9/D8
 zS5yy9kcPdxNdCZ46vqWaY8yhZ7SP7oPgN4bsQ+OHVJVpVTzwVMhMU80+7shk7QV4g9j
 vYq8f6fy+XJg4viNRQ5PmHB/XExrSkrUKpblRDGix6Qd2to/FkJ1WPRLV9HGWujZndkA
 k+RAoumGAQpfpCAh+yib8dDccyzMDOPWHQEDE1pI4UYY92hvCLO7RADwUCCjrOYtaP03
 q1RQ==
X-Gm-Message-State: AOJu0YxiwuPCUS95V2O6PFFnmBLBvp8ZR1sgeBjXlMOQqcvhHL0WP0eR
 34kWbrM7y9PAE0Kauf3C3tJnAG1LlXR/WRZcAP/mjc/wtUGsT5/K9m7GoYjPnzJxSDZtTYKcI5c
 Ta3rJoWW8g5dC5VXAEp44QuN5LaCv0OMMX0WQ3bW69yh1wGUvOIWoPUPy6ZmlwCb37vB54W2i4y
 643rQgkfk9WdMGAaX2/DBw6oIsHcocbqeBGQ==
X-Gm-Gg: ASbGncsZOPsHVw3T83HriHJ58QorfA00evrBM1eVPPn1kgW6m/7ko7lQFSwnU7ibfSC
 8gi8u5ZfOB6uym9k+HQipOBMmTWRxaXRyJnnxTXL5U3pL3v+wy/lk8dPqNFMGCAxGCrlYlF7vqJ
 n9khohtG5/pCAqGf9PRZpxBDa2ns0xRH14FgaNvlRsaKUeyYW9LFJu0G4GPfKJrEN5htYQd1I+b
 t03Ylc3iP2HiNZjeeFcTUsVVusdH7H/fDO8yqfKU6Cgos2TS7pTwwi+Vbkn+PlefMdMFN49c9nQ
X-Received: by 2002:a05:620a:261d:b0:7c7:a45d:3a5 with SMTP id
 af79cd13be357-7c9606dd656mr30796785a.14.1745532428711; 
 Thu, 24 Apr 2025 15:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI/Upj9td57F/SO6D/EyEEFEmTLCb57juQ4YCpJkqAOqfGOTRIVYeNuAszXR8ys+akmO9KTQ==
X-Received: by 2002:a05:620a:261d:b0:7c7:a45d:3a5 with SMTP id
 af79cd13be357-7c9606dd656mr30793385a.14.1745532428185; 
 Thu, 24 Apr 2025 15:07:08 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958e9fdfbsm139571085a.94.2025.04.24.15.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 15:07:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Xiaohui Li <xiaohli@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration/postcopy: Spatial locality page hint for preempt
 mode
Date: Thu, 24 Apr 2025 18:07:05 -0400
Message-ID: <20250424220705.195544-1-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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

The preempt mode postcopy has been introduced for a while.  From latency
POV, it should always win the vanilla postcopy.

However there's one thing missing when preempt mode is enabled right now,
which is the spatial locality hint when there're page requests from the
destination side.

In vanilla postcopy, as long as a page request was unqueued, it will update
the PSS of the precopy background stream, so that after a page request the
background thread will move the pages after whatever was requested.  It's
pretty much a natural behavior when there's only one channel anyway, and
one scanner to send the pages.

Preempt mode didn't follow that, because preempt mode has its own channel
and its own PSS (which doesn't linearly scan the guest memory, but
dedicated to resolve page requested from destination).  So the page request
process and the background migration process are completely separate.

This patch adds the hint explicitly for preempt mode.  With that, whenever
the preempt mode receives a page request on the source, it will service the
remote page fault in the return path, then it'll provide a hint to the
background thread so that we'll start sending the pages right after the
requested ones in the background, assuming the follow up pages have a
higher chance to be accessed later.

NOTE: since the background migration thread and return path thread run
completely concurrently, it doesn't always mean the hint will be applied
every single time.  For example, it's possible that the return path thread
receives multiple page requests in a row without the background thread
getting the chance to consume one.  In such case, the preempt thread only
provide the hint if the previous hint has been consumed.  After all,
there's no point queuing hints when we only have one linear scanner.

This could measureably improve the simple sequential memory access pattern
during postcopy (when preempt is on).  For random accesses, I can measure a
slight increase of remote page fault latency from ~500us -> ~600us, that
could be a trade-off to have such hint mechanism, and after all that's
still greatly improved comparing to vanilla postcopy on random (~10ms).

The patch is verified by our QE team in a video streaming test case, to
reduce the pause of the video from ~1min to a few seconds when switching
over to postcopy with preempt mode.

Tested-by: Xiaohui Li <xiaohli@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f1..21d2f87ff1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -91,6 +91,36 @@
 
 XBZRLECacheStats xbzrle_counters;
 
+/*
+ * This structure locates a specific location of a guest page.  In QEMU,
+ * it's described in a tuple of (ramblock, offset).
+ */
+struct PageLocation {
+    RAMBlock *block;
+    unsigned long offset;
+};
+typedef struct PageLocation PageLocation;
+
+/**
+ * PageLocationHint: describes a hint to a page location
+ *
+ * @valid     set if the hint is vaild and to be consumed
+ * @location: the hint content
+ *
+ * In postcopy preempt mode, the urgent channel may provide hints to the
+ * background channel, so that QEMU source can try to migrate whatever is
+ * right after the requested urgent pages.
+ *
+ * This is based on the assumption that the VM (already running on the
+ * destination side) tends to access the memory with spatial locality.
+ * This is also the default behavior of vanilla postcopy (preempt off).
+ */
+struct PageLocationHint {
+    bool valid;
+    PageLocation location;
+};
+typedef struct PageLocationHint PageLocationHint;
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* The migration channel used for a specific host page */
@@ -395,6 +425,13 @@ struct RAMState {
      * RAM migration.
      */
     unsigned int postcopy_bmap_sync_requested;
+    /*
+     * Page hint during postcopy when preempt mode is on.  Return path
+     * thread sets it, while background migration thread consumes it.
+     *
+     * Protected by @bitmap_mutex.
+     */
+    PageLocationHint page_hint;
 };
 typedef struct RAMState RAMState;
 
@@ -2039,6 +2076,21 @@ static void pss_host_page_finish(PageSearchStatus *pss)
     pss->host_page_start = pss->host_page_end = 0;
 }
 
+static void ram_page_hint_update(RAMState *rs, PageSearchStatus *pss)
+{
+    PageLocationHint *hint = &rs->page_hint;
+
+    /* If there's a pending hint not consumed, don't bother */
+    if (hint->valid) {
+        return;
+    }
+
+    /* Provide a hint to the background stream otherwise */
+    hint->location.block = pss->block;
+    hint->location.offset = pss->page;
+    hint->valid = true;
+}
+
 /*
  * Send an urgent host page specified by `pss'.  Need to be called with
  * bitmap_mutex held.
@@ -2084,6 +2136,7 @@ out:
     /* For urgent requests, flush immediately if sent */
     if (sent) {
         qemu_fflush(pss->pss_channel);
+        ram_page_hint_update(rs, pss);
     }
     return ret;
 }
@@ -2171,6 +2224,30 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
     return (res < 0 ? res : pages);
 }
 
+static bool ram_page_hint_valid(RAMState *rs)
+{
+    /* There's only page hint during postcopy preempt mode */
+    if (!postcopy_preempt_active()) {
+        return false;
+    }
+
+    return rs->page_hint.valid;
+}
+
+static void ram_page_hint_collect(RAMState *rs, RAMBlock **block,
+                                  unsigned long *page)
+{
+    PageLocationHint *hint = &rs->page_hint;
+
+    assert(hint->valid);
+
+    *block = hint->location.block;
+    *page = hint->location.offset;
+
+    /* Mark the hint consumed */
+    hint->valid = false;
+}
+
 /**
  * ram_find_and_save_block: finds a dirty page and sends it to f
  *
@@ -2187,6 +2264,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
 static int ram_find_and_save_block(RAMState *rs)
 {
     PageSearchStatus *pss = &rs->pss[RAM_CHANNEL_PRECOPY];
+    unsigned long next_page;
+    RAMBlock *next_block;
     int pages = 0;
 
     /* No dirty page as there is zero RAM */
@@ -2206,7 +2285,14 @@ static int ram_find_and_save_block(RAMState *rs)
         rs->last_page = 0;
     }
 
-    pss_init(pss, rs->last_seen_block, rs->last_page);
+    if (ram_page_hint_valid(rs)) {
+        ram_page_hint_collect(rs, &next_block, &next_page);
+    } else {
+        next_block = rs->last_seen_block;
+        next_page = rs->last_page;
+    }
+
+    pss_init(pss, next_block, next_page);
 
     while (true){
         if (!get_queued_page(rs, pss)) {
@@ -2339,6 +2425,13 @@ static void ram_save_cleanup(void *opaque)
     ram_state_cleanup(rsp);
 }
 
+static void ram_page_hint_reset(PageLocationHint *hint)
+{
+    hint->location.block = NULL;
+    hint->location.offset = 0;
+    hint->valid = false;
+}
+
 static void ram_state_reset(RAMState *rs)
 {
     int i;
@@ -2351,6 +2444,8 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->xbzrle_started = false;
+
+    ram_page_hint_reset(&rs->page_hint);
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
-- 
2.48.1


