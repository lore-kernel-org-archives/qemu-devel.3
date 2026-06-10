Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBE8CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 01:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXU0D-000740-R6; Wed, 10 Jun 2026 21:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXU0C-00071w-FD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:14:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXU0A-0005Ng-PD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:14:36 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36d98c9b596so4681152a91.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1781140473; x=1781745273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0E+INEFYhKvusoqL8t6A2F3paWL5r7PM2RouYJXRrU=;
 b=Sb7jCMWIcCupq9nOdnmS9ykSJyeh9T6Pm1iYXZNlBoV/qlKPNV0RJPqGM8rbUnBBoa
 moT5J4j/gj/msgm7wslx2yub/wRT1fToRFXJXJKYxhnQP4K192S8y+/oUYtm3wAk3ajQ
 rzScAisqGrAZnlEekLdbwxJtAidWMWo+AYfsbPz2Wox9Lmd8+FLwILlDfYoWUYkaAzfF
 SqRdTIVu+d2th+Eimqc3p0XlmiTsZoQVQQJl62UcMvO0oyRXoYau5hu3G8a2UFSfyHFN
 weHpsqQ8zhVmuazwe5gj5ONgsVRf+//octJtv/KNt2MX38IAF6XFueynOffJPLHgT75x
 Tcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781140473; x=1781745273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z0E+INEFYhKvusoqL8t6A2F3paWL5r7PM2RouYJXRrU=;
 b=V3YVpO/5rdJ4PDNFDluYharzLSbOvypYzU7fmrmh1VpyD54aTVUAz84jnCnETM+wOm
 23UcvOOd+ujF5k4+o0lp/qcd8fQK4vZdV5ojYLXdGT+E7pd7PLPA9vKFbYsED7BMY0z5
 giURrXgh1ui9Ymj7ade4xgZ0E9vjxAkwTqsszEuuKNvvthUajVi+R6V3/43ze+smOVkD
 608WkK1yrRmaPE7036CpqyhM7/xIUsqGEWoYGNzlT/ya4aJp68oDpwPtoRO28ws3JYrG
 M2CZrLreFQ/VOBfXGEJutZ9Dt/FS9DX048OpV49Ealq4rooDmUCJ178F1ypY8ILt46zZ
 aUkA==
X-Gm-Message-State: AOJu0Yxz1lIUV/0W1+VOC8jVgdjX9AqUIkLc9aaPBly7OnpsSBTjJ2uJ
 V8CVd7nIvUKRTcbSchVl8pH0XLAIkQM9+aJcA8cW0PcWQfw88nlhwPVpkss9dZckMTMo7sw8XTH
 13AqATDVecQ==
X-Gm-Gg: Acq92OGLHV2BGa2M4NcEssc3jbMRcZTqrsxFmng7NSdNg5EDi4aTerZ7XnsAfjtY0S+
 KcX2PSIhnOpiElzpI30JXC+rv61N3LPVB68iPL4FJelwRWKoVFbCY7yBUi4tyzWYbu2dUcubdzO
 /MxuetLEE1TcGYXCFcS0rc9wcZ5IxwwMdEDYpLphSoe96rii1Y8MMjztEK7FMoBhicasMwc43VE
 4NqlMSf4Y2zk+8y83lb3Zb5/u4tuscKZMFf4JfTHttiVEzDp4R9Es0aA7noDhmpMJJt026vrwdP
 YHZTX4spR3TGhgxYEWzAKX+yWPyvCkkmOGBQYHxnSpwcJK7kEPmELooMLHGULpBs9qD0PqGRlBd
 xBgYzR1i/lP3mb6pb7X0/Q1bU99epJKOzlIxhgOioX4qp1acSdzTM+8OEqs2b6erNkTbLTr/44J
 zHOrqgU5LazFLOzxXa476RDV7a4TgpFNMv7gcwpzTHElJHQmKaHi7ufJFB9ynVHvdKjPjRBxMT
X-Received: by 2002:a17:90b:4ac9:b0:368:6998:b49d with SMTP id
 98e67ed59e1d1-3779e7f0788mr678367a91.10.1781140473126; 
 Wed, 10 Jun 2026 18:14:33 -0700 (PDT)
Received: from localhost.localdomain ([103.114.192.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337b916cesm98217b3a.8.2026.06.10.18.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 18:14:32 -0700 (PDT)
From: infra.ai.cloud@bitdeer.com
To: qemu-devel@nongnu.org
Cc: Bin Guo <guobin@linux.alibaba.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>
Subject: [PULL 1/1] accel/kvm: event-driven wakeup for dirty ring reaper thread
Date: Wed, 10 Jun 2026 21:01:52 +0800
Message-ID: <42994dfcb25f6de9bb72d012265a6f996cfb69a6.1781095539.git.yong.huang@bitdeer.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781095539.git.yong.huang@bitdeer.com>
References: <cover.1781095539.git.yong.huang@bitdeer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bin Guo <guobin@linux.alibaba.com>

The reaper polls with sleep(1) (TODO in the code) and only notices
dirty-limit teardown at the next 1s tick.

Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
from dirtylimit_state_finalize() after dirtylimit_state has been
cleared.  The kick must follow the NULL assignment: kicking earlier
wakes the reaper while dirtylimit_in_service() still returns true,
so it just loops back to wait.  A 1s fallback timeout remains as a
liveness backstop.

20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
cancel-ack| measured with strace on the reaper TID:

    before: median 255 ms, max 502 ms
    after:  median 0.6 ms, max  27 ms

kvm_dirty_ring_reaper_init() returns int again (was made void in
commit 43a5e377f4) to propagate event_notifier_init() failure.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
Message-Id: <20260604070029.34982-1-guobin@linux.alibaba.com>
---
 accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
 accel/stubs/kvm-stub.c   |  4 ++++
 include/system/kvm.h     |  7 +++++++
 include/system/kvm_int.h |  3 +++
 system/dirtylimit.c      |  2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb24..be005832bc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     } while (size);
 }
 
+#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
+
 static void *kvm_dirty_ring_reaper_thread(void *data)
 {
     KVMState *s = data;
@@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     trace_kvm_dirty_ring_reaper("init");
 
     while (true) {
+        GPollFD pfd = {
+            .fd = event_notifier_get_fd(&r->reaper_notifier),
+            .events = G_IO_IN,
+        };
+
         r->reaper_state = KVM_DIRTY_RING_REAPER_WAIT;
         trace_kvm_dirty_ring_reaper("wait");
-        /*
-         * TODO: provide a smarter timeout rather than a constant?
-         */
-        sleep(1);
+
+        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
+
+        /* Drain unconditionally so a stale event can't spin the next loop. */
+        event_notifier_test_and_clear(&r->reaper_notifier);
 
         /* keep sleeping so that dirtylimit not be interfered by reaper */
         if (dirtylimit_in_service()) {
@@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     g_assert_not_reached();
 }
 
-static void kvm_dirty_ring_reaper_init(KVMState *s)
+static int kvm_dirty_ring_reaper_init(KVMState *s)
 {
     struct KVMDirtyRingReaper *r = &s->reaper;
+    int ret;
+
+    ret = event_notifier_init(&r->reaper_notifier, 0);
+    if (ret < 0) {
+        error_report("Failed to initialize dirty ring reaper notifier: %s",
+                     strerror(-ret));
+        return ret;
+    }
 
     qemu_thread_create(&r->reaper_thr, "kvm-reaper",
                        kvm_dirty_ring_reaper_thread,
                        s, QEMU_THREAD_JOINABLE);
+    return 0;
+}
+
+void kvm_dirty_ring_reaper_kick(void)
+{
+    KVMState *s = kvm_state;
+
+    if (!s || !s->kvm_dirty_ring_size) {
+        return;
+    }
+    event_notifier_set(&s->reaper.reaper_notifier);
 }
 
 static int kvm_dirty_ring_init(KVMState *s)
@@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
     }
 
     if (s->kvm_dirty_ring_size) {
-        kvm_dirty_ring_reaper_init(s);
+        ret = kvm_dirty_ring_reaper_init(s);
+        if (ret < 0) {
+            goto err;
+        }
     }
 
     if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c4617caac6..b878598552 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
     return 0;
 }
 
+void kvm_dirty_ring_reaper_kick(void)
+{
+}
+
 bool kvm_hwpoisoned_mem(void)
 {
     return false;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda..e127a5eb37 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
 
+/**
+ * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
+ *
+ * Safe from any thread; no-op when the dirty ring is not in use.
+ */
+void kvm_dirty_ring_reaper_kick(void);
+
 void kvm_mark_guest_state_protected(void);
 
 /**
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938..c14ebc927f 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -12,6 +12,7 @@
 #include "system/memory.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/accel.h"
+#include "qemu/event_notifier.h"
 #include "qemu/queue.h"
 #include "system/kvm.h"
 #include "accel/accel-ops.h"
@@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
     QemuThread reaper_thr;
     volatile uint64_t reaper_iteration; /* iteration number of reaper thr */
     volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr state */
+    /* Wakeup channel: kicked when dirty-limit is torn down. */
+    EventNotifier reaper_notifier;
 };
 struct KVMState
 {
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 50fa67f3d6..5a44b4c138 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -222,6 +222,8 @@ void dirtylimit_state_finalize(void)
     g_free(dirtylimit_state);
     dirtylimit_state = NULL;
 
+    kvm_dirty_ring_reaper_kick();
+
     trace_dirtylimit_state_finalize();
 }
 
-- 
2.43.0


