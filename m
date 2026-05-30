Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7870FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzO-0005d0-Gj; Sat, 30 May 2026 17:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzG-0005bm-5q
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzE-0000cO-IB
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c0c2d792c8so686625ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175570; x=1780780370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jqJbTRlZ02/qnQBMgxk5vRF3k8HFQd2Xb3/FkXy688=;
 b=OzFHWmXhaBxUPlZZ8roVS+nZ11Ygz+ViOzTCN0XwkyiFx4+GQqWlHkQmOHKCPO8b8U
 N8Kcm/9h/9UJq+eIrTyuZPdoiSAL+KSa9ktiwkCJbw2FwA4/5CoQ3zrGC/WTkBF+2ecH
 iZQhgX35rM/nn+1EI6yiyQnRTzNsnogUU5Xanhh4A1pquica1UCoYxqd9yq4KfDvnAiF
 HtJAXf1gFXOVQ7wlrP15ntNHzl5XXFQ7UXPB8/CtGbQEbzgrcbLBOUyO+uoXHjIXK/Tc
 21xNm6JdoJgZTbCkttVCq+tmCk7+WDpKE/beeX5RmMf+wUVkBByy2xF7/UVdgGfeQAdw
 WgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175570; x=1780780370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3jqJbTRlZ02/qnQBMgxk5vRF3k8HFQd2Xb3/FkXy688=;
 b=ZR8c6pvxJRV6z40Qi8nAspOJHc2EB4lttL0hr+xSj/7hdA7iW2QuD/1Ix9Xj09JplG
 05F1lVVS8Wl17Vjo0wCfOnMO9HgmioTDeiTUwMAqpUIA1vl6MHBLNa1y5aoDcn4q+XRe
 5rpG1EZ9xHsEqZPrWDRK/SeSGsdFCNwzDBaP9Z2xUjk5UMNLo5ibWJEBS42jmEuA9ufK
 7XGGD1Rd97yT+A9woqLp14CqM6kt/rOCS2N573Th9tal94POAAKDUTgIc/rvvvaFyMjC
 J39kqfAFTgtnzKGsw+WM41c+7eOa3ulGm8Zs4fOQyTpdB6yu0GaI0y8mOGaG5M5NlYUu
 QCQw==
X-Gm-Message-State: AOJu0Yz6TORP5hjfYIABYy57sF99pI269ME/DK3cZfDcZ+H5HuqQAO+7
 TJ5Y6DJpOIVtCNYDri7PEdtEaPY/AA2kPPnOYzXnDo/yoiQo3yv1j1WdDbg6yIxsG77lWjV7frH
 WjkkjoxI=
X-Gm-Gg: Acq92OFavbiriOZxPHJAOQUbMoXA6Y+B6GN7CIjNMFPhSF7l971Bbx8hU37IDn5rP96
 +U3XAibz9hWh3TLCPphCzfWrUFTvGrCznU05YNzb3RcQULROg4jtIYYd4kzuw9R3B3Wjjc5PoUW
 ZO9jhDH8sCXsbvVQrydZ+EN6d5bxgBdcE6JpszNtPDFKgJwx5pDNVq0WaWk3X2IfhYfacP90VZV
 zk/1JmMAfKtcYXXcp3OkfXpI8UIdd3cp6NdCdFT4XTIA5iaPKeVzYGK1bV7i6hioXl8BDE4pw8M
 a1jSYtUq3mWB0eHQAeW898sfbsBkpDS++248rS/C7kDzR87hrNxjaVlYI1eCKND9j9UovVWr3Kx
 cd3zjSL94x4yRj0do3IwW0XEvp3Jjz5G1B99xdX+Mo/4PkSo0H2faoMevxVj5QSXBdar3lpN+gk
 J3bdZojDtvmr4wsCwDhHrh6bknZUYide7896zAr7WTQ5E/UBXD9w==
X-Received: by 2002:a17:902:e88c:b0:2bf:30c8:bfa1 with SMTP id
 d9443c01a7336-2bf368bd8aamr59407015ad.41.1780175570497; 
 Sat, 30 May 2026 14:12:50 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 01/13] linux-user: Introduce PGBRange
Date: Sat, 30 May 2026 14:12:35 -0700
Message-ID: <20260530211248.375318-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-internals.h |  5 +++++
 linux-user/elfload.c        | 36 ++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 21daf422b7..73b0109e9c 100644
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
index 0e757787d2..e1e1ee4674 100644
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


