Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981EEC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCs1-0004Nl-BL; Tue, 07 Jul 2026 16:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCry-0004LU-9x
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrw-0003TF-8T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so221855ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783457895; x=1784062695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CecBT2dF5louTPlKf1XneGUwb8vKhmmqWyIT5qnKcOs=;
 b=Yyhc4RmJHBUH6OrHT2iZqKAK+G+7W2YDlP2629IN2fgD4ZIOOZmUQzNur2zm0sUB3h
 UvVOeU1sbZ6oTHwlXgfX1vquKjXotFQ9qQlO38tRKliD1fsszWZraDBgH31A/LQMUGup
 y6uwPDDscdz30yPieAeBSvhisjDIUA1Ca79bSHsGpe4gItyUOc3Sh6HVuOSjEC7PqrnF
 uBKsC5bGTCMe3R83G5fzYjbJroqJVT+BtK+YNStkaxM4FRtkvEMVWGixDn77FuBTm4iJ
 UhJQ11QNyrNQAXyx9vErf0F7C8jho21xPiqTA51p6CTqQcsmut/S3+YbSueDYdx2hjRV
 lTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457895; x=1784062695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CecBT2dF5louTPlKf1XneGUwb8vKhmmqWyIT5qnKcOs=;
 b=aeYhnO6AU/gDWkvnK6Q6dIeo6y+DJMGD6Ys0id6jgS6MzsJRzVzPemsyjMf2CsgP6s
 BnnxthhasqECUyJFitpPPlF8RUTE6d/KZLyo7fDwFvFhXhR2YwUpr6A0xcU56WbvbEGs
 OGt++cjBdKjkZXqFpOLnZ2RZh8ZSkZx1Ry/6qLMACWmXo0XeNhtdhuTLtVyDzVFWXFFQ
 sm1MzrjKAwpEzjz786Tdue7RFvMjNf4MiO7bfP5I1gvmGbcqJVflTyCWoJ/kKahSOgHK
 iU2PvyqD3DQDNMhsGE58rcEfSDE8I+o5ljNpRCwYATioeME6VHNedp+pryJaMO4u0539
 Jyow==
X-Gm-Message-State: AOJu0YzUwdEhsjrWQD23+NGSEWa8Zb6fBh9QfZGynEghIk9lMspQnNCq
 B0z336HSKJzH5jdbF6pUpQpkjo9NbVQh7OeJxpU5SEs74fQXF4WgNh3omdaddXUWmx6PJfGUYYf
 KvNPK
X-Gm-Gg: AfdE7clw97pkIt3AqW6UEXj9mqSJJ7i9Nz73YPKZhxNtaS/1lyMo6hfNO5pDx6cTbWn
 yGqF0T8KSN2tmjx5/f/U36jDL6iUGVqNRD1nn9v3bOr65U3iZLpiBpf0YBVffvKvLefZNe7CDjn
 yYif2x+Pi20ixH4E2h0qzqTQqaWZFv7oNupdLORsA5ZsduzWruto5IDAxSkulUoXgkNz8LqJkOy
 2I7kzW2qUMp0GMVWshD+xm2v3N/j7TiXZLp/X5BIPQQ0xFSiUaPIz7ttLYOZ63G8Hh25Ku1iK4Z
 lZg/J0npfUuXoa+Fvf6lbzw9nODuYz3AO7UE2k7fDQuz4ss6aWREOZDYo3cOgf0buHCV+s6nomJ
 k4CrWYBJk087H4GlElGlSs8+mDJVS+Ysw/QN5IlZvAo6hdhPN32EPzw+DD1AuHXhh5qrD0LHkQr
 tXhUmttSvSzyX/Ux++tny/d3WNdZDDmPJV+Zl43E6F0RY3YDqmbgY/R6ejrg==
X-Received: by 2002:a17:902:ef44:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2ccbe6109ccmr57941265ad.15.1783457894383; 
 Tue, 07 Jul 2026 13:58:14 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc2asm17980575ad.69.2026.07.07.13.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 13:58:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Alex Crichton <alex@alexcrichton.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/6] accel/tcg: Make PageFlagsNodes' start and last immutable
Date: Tue,  7 Jul 2026 13:58:06 -0700
Message-ID: <20260707205810.303376-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707205810.303376-1-richard.henderson@linaro.org>
References: <20260707205810.303376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 accel/tcg/user-exec.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index e4629b837d..a35aca7889 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -239,13 +239,16 @@ void page_dump(FILE *f)
 
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
@@ -301,15 +304,15 @@ static void pageflags_create_merge(vaddr start, vaddr last, int flags)
 
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
@@ -371,8 +374,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     if (set_flags != merge_flags) {
         if (p_start < start) {
             interval_tree_remove(&p->itree, &pageflags_root);
-            p->itree.last = start - 1;
-            interval_tree_insert(&p->itree, &pageflags_root);
+            pageflags_create(p_start, start - 1, p_flags);
+            g_free_rcu(p, rcu);
 
             if (last < p_last) {
                 if (merge_flags & PAGE_VALID) {
@@ -394,11 +397,11 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
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
@@ -419,8 +422,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
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
@@ -432,8 +435,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     /* Maybe split out head and/or tail ranges with the original flags. */
     interval_tree_remove(&p->itree, &pageflags_root);
     if (p_start < start) {
-        p->itree.last = start - 1;
-        interval_tree_insert(&p->itree, &pageflags_root);
+        pageflags_create(p_start, start - 1, p_flags);
+        g_free_rcu(p, rcu);
 
         if (p_last < last) {
             goto restart;
@@ -442,8 +445,8 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
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
@@ -505,6 +508,8 @@ bool page_check_range(vaddr start, vaddr len, int flags)
         return false; /* wrap around */
     }
 
+    RCU_READ_LOCK_GUARD();
+
     locked = have_mmap_lock();
     while (true) {
         PageFlagsNode *p = pageflags_find(start, last);
-- 
2.43.0


