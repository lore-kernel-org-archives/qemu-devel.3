Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973EBCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIq6-0003th-Sf; Thu, 18 Jun 2026 15:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq1-0003s7-7B
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIpq-0007qy-O1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c6be9cd89bso6596415ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812527; x=1782417327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaOFaqKACdMizsx9Pbv6kiT8caf5eiJWnLh/9195E8s=;
 b=FE/B9taN3SBO/Kjjss37EgW5VGoWkUA3ipflTbComJXJpjGtobfRVSpzf4GM9yQ17g
 Xap3j0o41DbLUJ6nTiSidDCoYBpDgJ7n/fsgxC/WWMwzC700ZB8t/8uEpPut1kFzPral
 GzthvNr+d/UJyW6xqLazubROXh9ABAHn2buWAEFLfte+/Rz33CvnbZwyzhh6GYzIBPwz
 qX03hZ/txbjqoQS/CSZ/UzcpY6ijoixCEcjG+Ofi3keuwOQrIPcXyy+SgB9oF2wlnxrH
 +kBqxm0WcARFEM+HM2eUua0hCUYr85iygIZe0OGMtlXD8Vk9wteOHcnZQC8JuLcOTQd3
 djXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812527; x=1782417327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IaOFaqKACdMizsx9Pbv6kiT8caf5eiJWnLh/9195E8s=;
 b=TxEKTiqBvBBEtpZcmSniOSi8ChWJ48f+FHL4914Jfdz+cirnQMRkf8P+NseXWllb+f
 fhAEAAjHZSfpl92xQMkY2RDu8aypWTu+ioJF6MUsfzF/Lj/P68DEfS/2/jWW+aFHf62V
 5BySvtsa2j8aGWdIHPwyjqbehbS317gBeeuuWTpLepk03eCmoTGJkYA/wuXsvjCO9pub
 qYCgQYGIXxuKcITW8oZTMw/3SDiRmEWC3+soRY1hUHO0tOaF+yaQAdbaKqAj3ptmG0bK
 od3q/+SNHGi3hClkH91BEoUm3O8HxKc7gM2qWtytWD9WklCrfTjet2/Zb6gd4Ua5yuX7
 p3Lg==
X-Gm-Message-State: AOJu0Yz9WzzpahZ1s/B/QdKKGrb5L6dowQfW37qK+UQz4prPHu8jRWSv
 miLFbvbpVe+LwB3n5fEwGHFCnwSXGLAFxecbf/COqIsGEDN9QE82JqkJfZotXqjxsZngpUjoyVa
 ST7SW
X-Gm-Gg: AfdE7cm3J3YPXNSBzL6F03LZD7slwG7f5TISQl1qCj5JoIT/h1eyR3U1wdyjrhOtCef
 lz91PdXLCZUqMtf+sHk+PThToSdq5PsiyrjkWWTQYyTQ7K02vbQiFW/EqyGDpt+ox6D7GotSNin
 EUPgx0miCkEztoFAf3KhjAEBmkyRHx7uGo0JCeMd4wCyOQJGyviz+7bs4D7Q464s5aktV/cMeV3
 WMVyDD9i3V+1bVFyJFXEhRMjn9jbYqz8Jd12+nD7A80dNf8sucf1FJ3AykG9mhn0S/lJYOmJDP6
 hs8GLQGG6hGgU7XZfsnPNMdEtFjasnRrj7qprIiYUK12TGpSzKXRH505c72l/CYtdUx50RmnqHc
 dDi7vY6P/KkxKNmQzJJ5siHm6mNkK3TNc/IWAjjd8oW/dUAY62S2hjzjU7GMa5y5hQPN/CysZbi
 VF+BzS/Od94gJI4ruzZeqkcqXIAPDwFrBYJzvxjQiTppxeg3VGCw==
X-Received: by 2002:a17:903:41c3:b0:2c6:bb55:4078 with SMTP id
 d9443c01a7336-2c718c88c55mr7606285ad.8.1781812526994; 
 Thu, 18 Jun 2026 12:55:26 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/13] linux-user: Introduce PGBRange
Date: Thu, 18 Jun 2026 12:55:07 -0700
Message-ID: <20260618195520.589907-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index b05b8b0c6b..aa4986a3d8 100644
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


