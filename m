Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF338C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKDn-0004Ge-EM; Fri, 10 Jul 2026 19:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDh-0004G2-Hf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:21 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDf-00030x-Pp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:21 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1316416a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724478; x=1784329278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oeawevpVSRwg+lSOsHGxJdLDP+nh+zwgXFZReFroaMM=;
 b=fwLaGvMQumKH3+40PF94sBC9zX0RJcT8uvpLo6kCfWC0Wh7WNMJ9tLwUGaOU3AMvPd
 Mj3y0FpVgH45FWuiDotX8LuDzASj4ph7fkse3zFFJvAgyJOC6ZZhqnKSz2zeQOCKc996
 UIlk+8eGfvKIO3zgEJJLTZRENs1HzjhEPdVn8L6UZLUWQ6JXCAdW/wdQhBCldByPE1+g
 AnOkuPqG3tXv+7qB+L+3d4WdRmHMNJ/DSKlHsg0wUEdFHoxlKsI//dVyN6gMWmTtwGBa
 Uu08qaBC2tIMV1sP1lmKJg20WgAaQvpIZQ3Wontx7L/97FA40mtikUvunkgTfu+KYlZS
 SJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724478; x=1784329278;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oeawevpVSRwg+lSOsHGxJdLDP+nh+zwgXFZReFroaMM=;
 b=cAyJd4LPlyF9nH/YFvYPJQZuQg0NxkW7krOd0EuGgPnvGIW+5sZ+Mi5nEPqRjCZgcY
 z1/LBTRzBZGMREsaqVAXaZJOQSOIlhoOw8IZF+ocobWuOa8rSWb4oU7nF/5m2WJ2My1k
 +Ef4zTAhrwrrCvtKgpeloLM4XX36F7LsB98ouM19Z2px5Ztcqz0s8+fEU5icTxicNhFi
 szxXzNbMNhx2LybyN+xTk1CMyNh/Z9md7q+YM4iZj+XG8u8/pozuI+xqXRs+lVkyP5Nr
 gXa/9r8KgRvnIz78/IgeLo+1fBfoZhkjg2xF7vvSXznYm9hUO8pvOd5bZjWYJR/cP4Rz
 ZabQ==
X-Gm-Message-State: AOJu0YzWEDiJKKTsl5Ar0oXx0uGQ7o9nmKQljMWFPtm+mDBlTwwblit8
 Mz2X96xudnmwM/sE1/4sJCeoT1qC0wXIhAjISWfK20L0ayTasxnqw1qZhMR4+ku1tDmenQ/o5CW
 tEvt7
X-Gm-Gg: AfdE7cmxo1e7lh6xEQJ2lcSI1sHFPtz+blChU0zzC0cEI35kAPcYC1yy1L87OmgPUuw
 LfAKZ5uM7Wp5P9GEvMkN1Rey0Q2+KgxCSc6Fkyehqnj6xTEO6mRDJX6dKsZjw8PmLESN+JPr0Nr
 eiVZrkqFIAGoiBKnj0/W0TYl1WIZsxFFitCl9yBvPmPjlCpdSVLZnzlat7kQgYzcBQdCxD05sER
 OCtMy+7evMn9a8xpToEF6B6FLixQ+9jeByJAE0QGe9AvcmkK4K8G9ui+Q9n+Ou0cRNq2Dp4A+9Z
 BV2nFslxUI//H1RIOnVDsMmOHV0Tm7vZvD0GZVDdvmmS7cVjYjUZElebTRYgXGnjbaSPhMxix3w
 oPVh3MslKxwWfBfk9uM9FlthieN1AMEJTm9KYxU3EYuiD5oZFoRhijraytkKZvVI5Zt8isii3dX
 7+rMlwdd0MDbLi7vvUqw==
X-Received: by 2002:a17:90b:2d4d:b0:37f:9cdf:f037 with SMTP id
 98e67ed59e1d1-38dc7b3f828mr745606a91.26.1783724478065; 
 Fri, 10 Jul 2026 16:01:18 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/13] linux-user: Introduce PGBRange
Date: Fri, 10 Jul 2026 16:01:04 -0700
Message-ID: <20260710230116.900171-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Create a structure to hold a beginning/end range for guest virtual
addresses, for use by probe_guest_base.  Use vaddr for clarity.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-internals.h |  5 +++++
 linux-user/elfload.c        | 36 ++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 0380d44fe9..b04ca43f02 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -75,6 +75,11 @@ void clone_fork_end(bool child);
 void fork_start(void);
 void fork_end(pid_t pid);
 
+typedef struct PGBRange {
+    vaddr lo;
+    vaddr hi;
+} PGBRange;
+
 /**
  * probe_guest_base:
  * @image_name: the executable being loaded
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8049c8ae62..2566c2f54c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -828,15 +828,15 @@ static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,
  */
 
 typedef struct PGBAddrs {
-    uintptr_t bounds[3][2]; /* start/last pairs */
+    PGBRange bounds[3];
     int nbounds;
 } PGBAddrs;
 
 static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
 {
     for (int i = ga->nbounds - 1; i >= 0; --i) {
-        if (pgb_try_mmap_skip_brk(ga->bounds[i][0] + base,
-                                  ga->bounds[i][1] + base,
+        if (pgb_try_mmap_skip_brk(ga->bounds[i].lo + base,
+                                  ga->bounds[i].hi + base,
                                   brk, i == 0 && reserved_va) <= 0) {
             return false;
         }
@@ -875,26 +875,26 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
     n = 0;
 
     if (reserved_va) {
-        ga->bounds[n][0] = try_identity ? mmap_min_addr : 0;
-        ga->bounds[n][1] = reserved_va;
+        ga->bounds[n].lo = try_identity ? mmap_min_addr : 0;
+        ga->bounds[n].hi = reserved_va;
         n++;
         /* LO_COMMPAGE and NULL handled by reserving from 0. */
     } else {
         /* Add any LO_COMMPAGE or NULL page. */
         if (LO_COMMPAGE != -1) {
-            ga->bounds[n][0] = 0;
-            ga->bounds[n][1] = LO_COMMPAGE + TARGET_PAGE_SIZE - 1;
+            ga->bounds[n].lo = 0;
+            ga->bounds[n].hi = LO_COMMPAGE + TARGET_PAGE_SIZE - 1;
             n++;
         } else if (!try_identity) {
-            ga->bounds[n][0] = 0;
-            ga->bounds[n][1] = TARGET_PAGE_SIZE - 1;
+            ga->bounds[n].lo = 0;
+            ga->bounds[n].hi = TARGET_PAGE_SIZE - 1;
             n++;
         }
 
         /* Add the guest image for ET_EXEC. */
         if (guest_loaddr) {
-            ga->bounds[n][0] = guest_loaddr;
-            ga->bounds[n][1] = guest_hiaddr;
+            ga->bounds[n].lo = guest_loaddr;
+            ga->bounds[n].hi = guest_hiaddr;
             n++;
         }
     }
@@ -909,8 +909,8 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
 
     /* Add any HI_COMMPAGE not covered by reserved_va. */
     if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n][0] = HI_COMMPAGE & qemu_real_host_page_mask();
-        ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
+        ga->bounds[n].lo = HI_COMMPAGE & qemu_real_host_page_mask();
+        ga->bounds[n].hi = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
         n++;
     }
 
@@ -976,8 +976,8 @@ static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
                                IntervalTreeRoot *root)
 {
     for (int i = ga->nbounds - 1; i >= 0; --i) {
-        uintptr_t s = base + ga->bounds[i][0];
-        uintptr_t l = base + ga->bounds[i][1];
+        uintptr_t s = base + ga->bounds[i].lo;
+        uintptr_t l = base + ga->bounds[i].hi;
         IntervalTreeNode *n;
 
         if (l < s) {
@@ -1076,9 +1076,9 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
                      "guest address mapping requirements", image_name);
 
         for (int i = 0; i < ga.nbounds; ++i) {
-            error_printf("  %0*" PRIx64 "-%0*" PRIx64 "\n",
-                         w, (uint64_t)ga.bounds[i][0],
-                         w, (uint64_t)ga.bounds[i][1]);
+            error_printf("  %0*" VADDR_PRIx "-%0*" VADDR_PRIx "\n",
+                         w, ga.bounds[i].lo,
+                         w, ga.bounds[i].hi);
         }
         exit(EXIT_FAILURE);
     }
-- 
2.43.0


