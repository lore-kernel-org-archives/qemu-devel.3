Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBE8D59F6C
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 05:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUIOD-00061R-Ds; Sat, 13 Dec 2025 00:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO8-00060M-GE
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:53 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO5-0002lv-8h
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:52 -0500
Received: from [10.200.7.128] (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BD5fMh5021206
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 13 Dec 2025 14:41:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BGY2ydZ9DW/wM8vz+C2bRvZNL/uWtNVIK4HlTDmTvOw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1765604496; v=1;
 b=NeqxvlgnGUdFoOdgurjfIDWexbhXikUvqNzpPt7IEK6aPPPdXDutziadl/WB8/br
 i9rzOfYV29lreQCZCNOfRyXujko2MLgdw5ITdTIo+V4Lp/GCJkwg2IwrrvV7YaPa
 sZ94ZCH7DvNnrrBkp1+QV4gj92q8dlxXI7+/dkXORyQ+kQ1Hv9s4ChhhqElLIm5z
 Ng0HRl3BqL5ScWM898gjEfkIVMi6wAYs+dvODg54wE690i4S1BwMKE/j3zzwPAN0
 FcZnz9bZP0pzJagmhp4O6vwzUzjh2m5857hhfQixcdlaDmvqVw0upKY+okn225bq
 Njz9JU+05kcfBm9TPzsT0Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 13 Dec 2025 14:41:20 +0900
Subject: [PATCH v2 1/6] timer: Rename init_clocks() to qemu_clock_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-force_rcu-v2-1-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
References: <20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

tests/qtest/stm32l4x5_usart-test.c will include qemu/timer.h in a
suceeding change, but it causes a conflict of init_clocks() definitions.

Since other functions that operate on clocks are prefixed with
qemu_clock_, follow the convention by renaming init_clocks() to
qemu_clock_init() and avoid the name conflict in the suceeding change.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/timer.h              | 4 ++--
 tests/unit/test-aio-multithread.c | 2 +-
 util/main-loop.c                  | 2 +-
 util/qemu-timer.c                 | 7 ++++---
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 406d74112030..9dfde0660d0e 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -786,11 +786,11 @@ static inline int64_t qemu_soonest_timeout(int64_t timeout1, int64_t timeout2)
 }
 
 /**
- * initclocks:
+ * qemu_clock_init:
  *
  * Initialise the clock & timer infrastructure
  */
-void init_clocks(QEMUTimerListNotifyCB *notify_cb);
+void qemu_clock_init(QEMUTimerListNotifyCB *notify_cb);
 
 static inline int64_t get_max_clock_jump(void)
 {
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 0ead6bf34ad1..33720b3ffff0 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -443,7 +443,7 @@ static void test_multi_mutex_10(void)
 
 int main(int argc, char **argv)
 {
-    init_clocks(NULL);
+    qemu_clock_init(NULL);
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/aio/multi/lifecycle", test_lifecycle);
diff --git a/util/main-loop.c b/util/main-loop.c
index b8ddda8f5eec..718b87e05c74 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -162,7 +162,7 @@ int qemu_init_main_loop(Error **errp)
     int ret;
     GSource *src;
 
-    init_clocks(qemu_timer_notify_cb);
+    qemu_clock_init(qemu_timer_notify_cb);
 
     ret = qemu_signal_init(errp);
     if (ret) {
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 56f11b6a641f..c96856d70123 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -121,7 +121,8 @@ void timerlist_free(QEMUTimerList *timer_list)
     g_free(timer_list);
 }
 
-static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB *notify_cb)
+static void qemu_clock_init_one(QEMUClockType type,
+                                QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClock *clock = qemu_clock_ptr(type);
 
@@ -637,11 +638,11 @@ static void qemu_virtual_clock_set_ns(int64_t time)
     return cpus_set_virtual_clock(time);
 }
 
-void init_clocks(QEMUTimerListNotifyCB *notify_cb)
+void qemu_clock_init(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
     for (type = 0; type < QEMU_CLOCK_MAX; type++) {
-        qemu_clock_init(type, notify_cb);
+        qemu_clock_init_one(type, notify_cb);
     }
 
 #ifdef CONFIG_PRCTL_PR_SET_TIMERSLACK

-- 
2.52.0


