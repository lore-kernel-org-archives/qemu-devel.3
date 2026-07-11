Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03233C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpS-00062s-BI; Sat, 11 Jul 2026 18:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpO-0005tT-DW; Sat, 11 Jul 2026 18:05:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpM-0000c3-C0; Sat, 11 Jul 2026 18:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=wTg+U40SNU3eeOy9WQM2Ylx2TLCzMkjokSZmIvnz2pg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iqx/w7YYxLcX8CmJx7TNrPE1nE4FkeOFe6tjspOSySD8ydkQRKcsmRKLvv2hccj9o
 mz+iFQz1TM0eDGSHvxH7lesqY8WmOoet4GZznqPeWjol6aj+4/g0XAUIk66/wlpHGT
 6QJiLPOn7Cl/ztLw2IZOTdK3J5WFCX6DimZqEKv2HBZq5dZNCb6XalN2A2G4meFpNg
 WEG5TE01LY0gtjkywljwNmkCFJwkGOvKmvtVbYDYjsGrm3vP+iq4b5zCgvEJAxU09V
 DW72pQcoRcN78ld/Rgmk23pq0OJ7N2sp20ApIs2F+bJMu97gnM90qEpnYnenAUELRV
 2kKgRyOw9G4Wg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 854E01C0AC9;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C1013EAF54;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CCC3F1335F; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alex Crichton <alex@alexcrichton.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 62/81] accel/tcg: Make PageFlagsNodes' start and last
 immutable
Date: Sun, 12 Jul 2026 00:58:40 +0300
Message-ID: <20260711215904.3757-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

page_check_range() may race with pageflags_set_clear() as follows:

    T1                                     T2
    -------------------------------------  --------------------------------
                                           p = pageflags_find(start, last);
    interval_tree_remove(&p->itree, ...);
    p->itree.start = last + 1;
                                           if (start < p->itree.start) {
                                               ret = false;
    interval_tree_insert(&p->itree, ...);

leading to errors like

    fail indirect write 0x72f0a659aff0 (Bad address)

in vma-pthread test. I am able to reliably reproduce this on a machine
with 32 SMT threads as follows in about 25 seconds:

    jobs=32; \
    seq "$jobs" | \
        time -p parallel \
            --jobs="$jobs" \
            --halt=now,done=1 \
            --ungroup \
            '
                _={};
                while ./qemu-s390x tests/tcg/s390x-linux-user/vma-pthread; do
                    printf .;
                done
            '

Also wasmtime project reported a similar failure pattern in their CI [1]
with a similar reproducer [2].

There are other races like this. In general, region bounds mutating
underneath the reader are very hard to reason about. So fix this by
preventing mutations and creating copies instead. Use RCU guards in
readers to avoid uses-after-frees.

Now, when the reader finds a node, it may fearlessly access its fields
and be certain that at some point in time the respective region had the
respective bounds and permissions. The downside is slightly more
expensive mprotect(), but complexity reduction is worth it.

Lockless field accesses should probably be wrapped in qatomic_read(),
but this is a pre-existing issue, so do not change it here.

[1] https://github.com/bytecodealliance/wasmtime/issues/10000
[2] https://gist.github.com/alexcrichton/f14f23a892ffb9df2522754572d51b1c

Cc: qemu-stable@nongnu.org
Reported-by: Alex Crichton <alex@alexcrichton.com>
Reported-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Fixes: 67ff2186b0a4 ("accel/tcg: Use interval tree for user-only page tracking")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260706165445.57418-2-iii@linux.ibm.com>
(cherry picked from commit e03b7dac65d96d7d9b34bb88803029cf5ec7e4a9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index dd0bcde4d49..7cd26a238d5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -238,13 +238,16 @@ void page_dump(FILE *f)
 
 int page_get_flags(vaddr address)
 {
-    PageFlagsNode *p = pageflags_find(address, address);
+    PageFlagsNode *p;
+
+    RCU_READ_LOCK_GUARD();
 
     /*
      * See util/interval-tree.c re lockless lookups: no false positives but
      * there are false negatives.  If we find nothing, retry with the mmap
      * lock acquired.
      */
+    p = pageflags_find(address, address);
     if (p) {
         return p->flags;
     }
@@ -300,15 +303,15 @@ static void pageflags_create_merge(vaddr start, vaddr last, int flags)
 
     if (prev) {
         if (next) {
-            prev->itree.last = next->itree.last;
+            pageflags_create(prev->itree.start, next->itree.last, flags);
             g_free_rcu(next, rcu);
         } else {
-            prev->itree.last = last;
+            pageflags_create(prev->itree.start, last, flags);
         }
-        interval_tree_insert(&prev->itree, &pageflags_root);
+        g_free_rcu(prev, rcu);
     } else if (next) {
-        next->itree.start = start;
-        interval_tree_insert(&next->itree, &pageflags_root);
+        pageflags_create(start, next->itree.last, flags);
+        g_free_rcu(next, rcu);
     } else {
         pageflags_create(start, last, flags);
     }
@@ -370,8 +373,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     if (set_flags != merge_flags) {
         if (p_start < start) {
             interval_tree_remove(&p->itree, &pageflags_root);
-            p->itree.last = start - 1;
-            interval_tree_insert(&p->itree, &pageflags_root);
+            pageflags_create(p_start, start - 1, p_flags);
+            g_free_rcu(p, rcu);
 
             if (last < p_last) {
                 if (merge_flags & PAGE_VALID) {
@@ -393,11 +396,11 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
             }
             if (last < p_last) {
                 interval_tree_remove(&p->itree, &pageflags_root);
-                p->itree.start = last + 1;
-                interval_tree_insert(&p->itree, &pageflags_root);
+                pageflags_create(last + 1, p_last, p_flags);
                 if (merge_flags & PAGE_VALID) {
                     pageflags_create(start, last, merge_flags);
                 }
+                g_free_rcu(p, rcu);
             } else {
                 if (merge_flags & PAGE_VALID) {
                     p->flags = merge_flags;
@@ -418,8 +421,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     if (set_flags == p_flags) {
         if (start < p_start) {
             interval_tree_remove(&p->itree, &pageflags_root);
-            p->itree.start = start;
-            interval_tree_insert(&p->itree, &pageflags_root);
+            pageflags_create(start, p_last, p_flags);
+            g_free_rcu(p, rcu);
         }
         if (p_last < last) {
             start = p_last + 1;
@@ -431,8 +434,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     /* Maybe split out head and/or tail ranges with the original flags. */
     interval_tree_remove(&p->itree, &pageflags_root);
     if (p_start < start) {
-        p->itree.last = start - 1;
-        interval_tree_insert(&p->itree, &pageflags_root);
+        pageflags_create(p_start, start - 1, p_flags);
+        g_free_rcu(p, rcu);
 
         if (p_last < last) {
             goto restart;
@@ -441,8 +444,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
             pageflags_create(last + 1, p_last, p_flags);
         }
     } else if (last < p_last) {
-        p->itree.start = last + 1;
-        interval_tree_insert(&p->itree, &pageflags_root);
+        pageflags_create(last + 1, p_last, p_flags);
+        g_free_rcu(p, rcu);
     } else {
         g_free_rcu(p, rcu);
         goto restart;
@@ -504,6 +507,8 @@ bool page_check_range(vaddr start, vaddr len, int flags)
         return false; /* wrap around */
     }
 
+    RCU_READ_LOCK_GUARD();
+
     locked = have_mmap_lock();
     while (true) {
         PageFlagsNode *p = pageflags_find(start, last);
-- 
2.47.3


