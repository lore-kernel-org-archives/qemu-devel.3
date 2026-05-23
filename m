Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91650CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQldS-0005J8-E8; Sat, 23 May 2026 08:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wQldQ-0005Ik-9F
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:39:20 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wQldM-0004o7-Jq
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:39:20 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64NCcZTh019725
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 23 May 2026 21:38:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BNRW/j5h0rMkK1BTmEvIbZjkQ08T8F05tW1RreTz0tA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779539938; v=1;
 b=ZgiEFbL1rnbgvfdwdJF1uPKU7kZ4UCxPzToyta0TI7hTSFJW6xCqcAaYn7oHyZg4
 UyCnnUhkZyUaerQbpmWIHl327TCcOMRDMKDGmAS7DfGdTQAUbKwLxtz5DJgFI+KD
 7DejTFjzNfgKg9cAHlfrsgSY3P2S5uDXQJBh5q04I3JtwlZlweFbd7X53f1vGWub
 EPEk1jJkttRByOD8Ef2fZQNS/C2eGET9UkVnFIp6LsNAktyKPAhbEe/vzyOhE3p5
 7RLSyIwlRCNNMXEcaHFPA02JP+S9MCQTsDDIgXY0F+/obRr3i7aIDn20fHTASJW+
 fbC3pvEc1gLSmQgqvho2WA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 23 May 2026 21:38:28 +0900
Subject: [PATCH] system/physmem: Synchronize ram_list accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMD3ZLixDzdZLM0w8RESwNLIFYCKi0oSk3LrAAbEx0L4ReXJmWlJpe
 A9CrV1gIA7RleJWgAAAA=
X-Change-ID: 20260520-tsan-c6f1aa909a90
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=6748;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=qM226VHWLt/mqFKbQrdKwTtUT2AoPl19zgThVczH9hc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5bg/Id3XzBtu/jpb71jn2vv5bpc9y+W35wKv6vcNlp3O
 SprydKVHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABNZUsPwP7OpJu37cvPQ6M8/
 PrNsE6nYa/m53CjMmDfhOJvyRWY1GYb/ATvzp4p1L5qw6cblBQtTI2P4J6R8XjR7Y+Wc9sRNurf
 6eQA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

Alex Bennée reported a ThreadSanitizer warning about a plain concurrent
access to ram_list [1]. Ensure the concurrent accesses to ram_list are
properly synchronized with atomic accesses, mutexes, or RCU.

First, the plain assignments of ram_list.mru_block are replaced with
qatomic_set(). A comment in qemu_get_ram_block() explains why the
ordering requirement is relaxed, but it still needs to be atomically
accessed. include/qemu/atomic.h says:

> The C11 memory model says that variables that are accessed from
> different threads should at least be done with __ATOMIC_RELAXED
> primitives or the result is undefined. Generally this has little to
> no effect on the generated code but not using the atomic primitives
> will get flagged by sanitizers as a violation.

Second, ram_list.version accesses are replaced with atomic operations
or protected with a mutex. Unlike ram_list.mru_block, ram_list.version
has tighter ordering requirements for one of its goals: ensuring that
the reader-held rs->last_seen_block value is invalidated whenever a RAM
block is reclaimed between two RCU reader critical sections. Below are
steps a reader and an updater follow:

Reader:

R-1. Enter the first RCU read-side critical section:
R-1-1. rs->last_version = qatomic_load_acquire(&ram_list.version)
R-1-2. rs->last_seen_block = an element of ram_list.blocks
R-2. Enter the second RCU read-side critical section:
R-2-1. if (qatomic_read(&ram_list.version) != rs->last_version)
R-2-2.     rs->last_seen_block = NULL

Updater:

W-1. Enter a ram_list.mutex critical section
W-1-1. Update ram_list.blocks
W-1-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
W-2. Enter another ram_list.mutex critical section
W-2-1. QLIST_REMOVE_RCU(block, next)
W-2-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
W-2-3. call_rcu(block, reclaim_ramblock, rcu)

W-1-2 represents the write observed by R-1-1.

ram_list.version is read non-atomically on the update side because the
update side is serialized with ram_list.mutex. The other ram_list
accesses in these steps are reasoned about in two cases.

When the grace period of W-2-3 contains R-2:
    qatomic_load_acquire() at R-1-1 and qatomic_store_release() at W-1-2
    enforce the following ordering:
        W-1-1 -> W-1-2 -> R-1-1 -> R-1-2
    The value of ram_list.blocks stored by W-1-1 or a newer value that
    was loaded by R-1-2 is still valid because of the grace period.

When the grace period of W-2-3 ends before R-2:
    call_rcu() at W-2-3 and the read-side critical section at R-2 ensure
    the following ordering:
        W-2-2 -> W-2-3 -> the grace period -> R-2 -> R-2-1
    The value of ram_list.version stored by W-2-2 or a newer value that
    was loaded by R-2-1 differs from rs->last_version and the reader
    invalidates rs->last_seen_block.

Together, these steps ensure that rs->last_seen_block is invalidated
whenever necessary. With added atomic operations, pre-existing memory
barriers are no longer necessary and are removed.

Any other ram_list accesses are already properly synchronized.

[1] https://lore.kernel.org/qemu-devel/878q9fbmap.fsf@draig.linaro.org/

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 migration/ram.c  | 10 +++++-----
 system/physmem.c | 16 +++++++---------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fc38ffbf8af1..6da24d725861 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2495,7 +2495,10 @@ static void ram_state_reset(RAMState *rs)
 
     rs->last_seen_block = NULL;
     rs->last_page = 0;
-    rs->last_version = ram_list.version;
+
+    /* Read version before ram_list.blocks */
+    rs->last_version = qatomic_load_acquire(&ram_list.version);
+
     rs->xbzrle_started = false;
 
     ram_page_hint_reset(&rs->page_hint);
@@ -3270,13 +3273,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      */
     WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
         WITH_RCU_READ_LOCK_GUARD() {
-            if (ram_list.version != rs->last_version) {
+            if (qatomic_read(&ram_list.version) != rs->last_version) {
                 ram_state_reset(rs);
             }
 
-            /* Read version before ram_list.blocks */
-            smp_rmb();
-
             ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
             if (ret < 0) {
                 qemu_file_set_error(f, ret);
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf8757361..9e1ac13e8259 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -839,12 +839,12 @@ found:
     /* It is safe to write mru_block outside the BQL.  This
      * is what happens:
      *
-     *     mru_block = xxx
+     *     qatomic_set(&mru_block, xxx)
      *     rcu_read_unlock()
      *                                        xxx removed from list
      *                  rcu_read_lock()
      *                  read mru_block
-     *                                        mru_block = NULL;
+     *                                        qatomic_set(&mru_block, NULL);
      *                                        call_rcu(reclaim_ramblock, xxx);
      *                  rcu_read_unlock()
      *
@@ -852,7 +852,7 @@ found:
      * when it was placed into the list.  Here we're just making an extra
      * copy of the pointer.
      */
-    ram_list.mru_block = block;
+    qatomic_set(&ram_list.mru_block, block);
     return block;
 }
 
@@ -2260,11 +2260,10 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     } else { /* list is empty */
         QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
     }
-    ram_list.mru_block = NULL;
+    qatomic_set(&ram_list.mru_block, NULL);
 
     /* Write list before version */
-    smp_wmb();
-    ram_list.version++;
+    qatomic_store_release(&ram_list.version, ram_list.version + 1);
     qemu_mutex_unlock_ramlist();
 
     physical_memory_set_dirty_range(new_block->offset,
@@ -2608,10 +2607,9 @@ void qemu_ram_free(RAMBlock *block)
     name = cpr_name(block->mr);
     cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
-    ram_list.mru_block = NULL;
+    qatomic_set(&ram_list.mru_block, NULL);
     /* Write list before version */
-    smp_wmb();
-    ram_list.version++;
+    qatomic_store_release(&ram_list.version, ram_list.version + 1);
     call_rcu(block, reclaim_ramblock, rcu);
     qemu_mutex_unlock_ramlist();
 }

---
base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
change-id: 20260520-tsan-c6f1aa909a90

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


