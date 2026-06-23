Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00148CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YQ-0004VR-A2; Tue, 23 Jun 2026 08:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YM-0004Up-6v
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YH-0006z7-GG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUAaem2nilSMECZVVibrZOmODUF58+NtOhllRUin4yQ=;
 b=JcaAUgHnicXshJnctYpWP5FOY3rFrOfDG8jIcNKEEtZItn34Jfvxwz1/e2S7BLFSNtRv9B
 aR/S5IvxtpHmtFjWWnZDCDevX6OXm4KN6XXz0e3chPHuh6rGAx5CLzugUvzkEhTogEBCo4
 3MxheVxuy8nbNWhhrRGMA1r8XX+L0IE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ra1xBVbAOaSV8_ay7PpGmg-1; Tue, 23 Jun 2026 08:48:24 -0400
X-MC-Unique: ra1xBVbAOaSV8_ay7PpGmg-1
X-Mimecast-MFC-AGG-ID: ra1xBVbAOaSV8_ay7PpGmg_1782218903
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-519ed1acb05so58743371cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218903; x=1782823703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUAaem2nilSMECZVVibrZOmODUF58+NtOhllRUin4yQ=;
 b=Hd60JMhcZD0+vsYfRw4DLvm8Z1Da1D0/UhQjDjhwinO0nBPpkkuY20v0hx2zZbzoFb
 93dQ3xG8+B61lywFLw9bM7yHJe69ZZfm3WFS1voEv7AGDrg4wHbARBlzqYb7I7x+eDtM
 TBbePy6kfxB0yKte+wfzTSPPAgD4qu1cTv4K0KaY/PArycWHg4O3KvNVdnxuDBU0CBM4
 uv3iUVBp01ASTF0yVR7u/NB6xPYVxOl/PK/U1HAdAaWHWsach9GC8RL7QPfJ9Id7z8A6
 Uvycd+C0N7TzVSpwLldRiWy2EvU8S/HtkuY7VyF7bemQbxUfVTfMJ/om781R2CcIa5PZ
 uStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218903; x=1782823703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yUAaem2nilSMECZVVibrZOmODUF58+NtOhllRUin4yQ=;
 b=sHN+xlaVnfZ4JkYuA0uwNZyoZALGEgIGKBqq5Vwg4/JjROvH2uQAt3vNsnrvBpil+j
 lZ7yQqUWqyUZCf5MBgXOOC9EsVfKcsOCtepPP+KQgAxMUrYSv8/M1bcApktw5PDqdM5z
 SVTaA5r9l+VLUa1xDRVE82NT2gTshX+w18gI0V947F48LvJKGJQkUZ3TzJpLLJ4jr98z
 uHUdWmKzIKWYsfAdjYEcet803RYQ1uHjCwNSeQ8qCiq/mXtjB0rVAc36ZzGwDWhcBXem
 hA0IdDa6Kr20ujWPmGvUSa+t+AKd86RUog3Ihep4BUs1/8bMZqTEix+9hsaeKVRrPx1E
 iRVQ==
X-Gm-Message-State: AOJu0Yzyvr3x9UP2K8ZR/iBhlrO/bSEv8G3zJ4abfhQTNfAMiAIxb/JJ
 8OY8WtuuyL68zh4LqdCYkwVw3LVeSJsr15YRV00kxLjTrGYlloTukqBdxXTMOf3l9yd3A0ZERif
 kFzF7MFJjdrZrxT2s6dLkAKyuH4UZTOoC+0rpS1r95VD5U1ygfvHSjnbxCREs41NM6IL3bPbTOA
 eQFmY9K2f1x0FADktt8zXrMccosOqBUqFUPkLD9Q==
X-Gm-Gg: AfdE7cnB969MFkWh2tolnuKo5yfMksZ79iuOQuEzjdA2qYjy4kHi24ln3rZFOjYbPEe
 sR5MIPZbQFUfgbVMc3ePLEfYuoJA29KbG3qlXzOG5ft6SF6ZDavWjAD1GdGE3gYhwq6vSBzzL+k
 o5zVCZulwl9bwcCeXWBLdqWYYHBlHcHYBsVimzeqGlhWc35p+nDTjVXue1VDK9s5WpiDVwG+Zdy
 8/iwzTm+bXrOdqOV54QM5Aaq7Ttv0TVfE4CUnnV6/mSv8efrVgp9z9tx8pk21CU1W0nfx55eP7w
 28TUkXQZoutV8/91nUshTMVh7pjf7N6h+xQn4nwijtxM0oPBCdRWlLYMwHbzHEUSVyQb1O5yonr
 aIg==
X-Received: by 2002:a05:622a:1456:b0:517:8e3c:efc6 with SMTP id
 d75a77b69052e-51a55a150b1mr33683581cf.24.1782218903122; 
 Tue, 23 Jun 2026 05:48:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1456:b0:517:8e3c:efc6 with SMTP id
 d75a77b69052e-51a55a150b1mr33682661cf.24.1782218902273; 
 Tue, 23 Jun 2026 05:48:22 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/18] system/physmem: Synchronize ram_list accesses
Date: Tue, 23 Jun 2026 08:47:44 -0400
Message-ID: <20260623124759.125399-4-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c  | 10 +++++-----
 system/physmem.c | 16 +++++++---------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fc38ffbf8a..6da24d7258 100644
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
index 9e5b50c5b1..db8ad84ab6 100644
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
-- 
2.54.0


