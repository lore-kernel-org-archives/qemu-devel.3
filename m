Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C7BC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Mnf-0006fW-6O; Tue, 15 Sep 2026 02:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6Mnc-0006fC-GG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:37:48 -0400
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6MnZ-0001Dv-1E
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789454243; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Qr52ItPjNoQFNh4q9cMQK9LkWdC9JRTZIHpsy1bQGyo=;
 b=M05nJSN7ic36x2cnodUAKQmfwQhxk3E8QSUZfkCtUS0cd1xqED68Mir4nAD2Y4IjBHowEXirdgUZLXN61uJBHtAG4fVRdyilF3UZCyPFu0Z2VpwcXO9x6NjIKc1aPc/JVFQst1Blzdta97w+T/A2kCHEYjc9ecT9Q0c0JT4ISVw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0XB0TToh_1789454241; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0XB0TToh_1789454241 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 15 Sep 2026 14:37:22 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 2/2] migration/postcopy: account faults taken by memory
 sharing processes
Date: Tue, 15 Sep 2026 14:37:19 +0800
Message-ID: <20260915063719.89031-3-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260915063719.89031-1-guobin@linux.alibaba.com>
References: <20260915063719.89031-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Page faults taken by a process that shares guest memory with us (e.g. a
vhost-user backend) are resolved over the migration stream just like our
own, but they are not accounted for, so they are missing from the latency
reports.  There is no thread id to report them with: the client's
userfaultfd is not required to enable UFFD_FEATURE_THREAD_ID, and
libvhost-user does not, so the ptid in the fault message stays zero.  Even
when the feature is enabled, the reported ids belong to another process
and can never match one of our vCPUs.  Passing zero would not work either,
as mark_postcopy_blocktime_begin() reads it as "no thread id" and returns
early.

Report those faults with POSTCOPY_TID_FOREIGN instead, which takes the
same path as the faults of our own non-vCPU threads: no vCPU is involved,
so the vCPU blocktime reports are left alone and only the latency of the
fault is accounted.  This also resolves the "TODO: support blocktime
tracking" left in postcopy_request_shared_page().

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/postcopy-ram.c | 26 ++++++++++++++++----------
 migration/postcopy-ram.h | 10 ++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5509cbdcb8..00e2a6fc62 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1122,8 +1122,6 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                         qemu_ram_get_idstr(rb), rb_offset);
         return postcopy_wake_shared(pcfd, client_addr, rb);
     }
-    /* TODO: support blocktime tracking */
-
     /*
      * The page will be placed by qemu_ufd_copy_ioctl(), which removes the
      * matching entry from mis->page_requested (and drops
@@ -1133,10 +1131,16 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
      * backend's address space and can never equal that host address, so the
      * removal would miss forever, leaking page_requested_count and hanging
      * postcopy teardown.
+     *
+     * We have no thread id to report for the client: its userfaultfd is not
+     * required to enable UFFD_FEATURE_THREAD_ID, and even when it does the
+     * thread ids it reports belong to another process, so they could never
+     * match one of our vCPUs.  Report the fault as a foreign one, so that it
+     * still shows up in the latency reports.
      */
     postcopy_request_page(mis, rb, aligned_rbo,
                           (uint64_t)(uintptr_t)qemu_ram_get_host_addr(rb) +
-                          aligned_rbo, 0);
+                          aligned_rbo, POSTCOPY_TID_FOREIGN);
     return 0;
 }
 
@@ -1234,7 +1238,8 @@ bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
  * blocking time.  It's protected by @page_request_mutex.
  *
  * @addr: faulted host virtual address
- * @ptid: faulted process thread id
+ * @ptid: faulted process thread id, or POSTCOPY_TID_FOREIGN when the fault
+ *        was taken by a thread of another process
  * @rb: ramblock appropriate to addr
  */
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
@@ -1256,7 +1261,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
 
     current = get_current_ns();
-    cpu = blocktime_get_vcpu(dc, ptid);
+    cpu = ptid == POSTCOPY_TID_FOREIGN ? -1 : blocktime_get_vcpu(dc, ptid);
 
     if (cpu >= 0) {
         /* How many faults on this vCPU in total? */
@@ -1281,11 +1286,12 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         }
     } else {
         /*
-         * For non-vCPU thread faults, we don't care about tid or cpu index
-         * or time the thread is blocked (e.g., a kworker trying to help
-         * KVM when async_pf=on is OK to be blocked and not affect guest
-         * responsiveness), but we care about latency.  Track it with
-         * cpu=-1.
+         * For faults that did not come from a vCPU thread, we don't care
+         * about tid or cpu index or time the thread is blocked (e.g., a
+         * kworker trying to help KVM when async_pf=on is OK to be blocked
+         * and not affect guest responsiveness; likewise for a thread of a
+         * process that shares guest memory with us), but we care about
+         * latency.  Track it with cpu=-1.
          *
          * Note that this will NOT affect blocktime reports on vCPU being
          * blocked, but only about system-wide latency reports.
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index edba7b0240..028f774651 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -200,6 +200,16 @@ bool postcopy_is_paused(MigrationStatus status);
 bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
                                        RAMBlock *rb, ram_addr_t start,
                                        uint64_t haddr, uint32_t tid);
+
+/*
+ * Thread id to report for a fault that did not come from one of our own
+ * threads, e.g. one taken by a process that shares guest memory with us.  It
+ * can never collide with a real thread id, as Linux pid values are far below
+ * this.  See mark_postcopy_blocktime_begin() for how such faults are
+ * accounted.
+ */
+#define POSTCOPY_TID_FOREIGN  ((uint32_t)-1)
+
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb);
 
-- 
2.50.1 (Apple Git-155)


