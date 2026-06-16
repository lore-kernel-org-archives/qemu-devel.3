Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2495CCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDT-0005UA-BU; Tue, 16 Jun 2026 17:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDQ-0005SZ-PA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:01 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDO-0007Mr-Ln
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:00 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-37cae11ba85so3851a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644857; x=1782249657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaOFaqKACdMizsx9Pbv6kiT8caf5eiJWnLh/9195E8s=;
 b=a/I6rH2fGBnj9i6ksWYEA9nbuGU2LWdaRYnuThpLzj0/hpk3v5MvO7+jGgOYQnv8+C
 VfIJwwSYhv4Ni6TlUW6Tkq8opDxv17OwYyTpfa43Bqf027L5EE2Ra/H9SYV/AixRlsCg
 Hip0K0Oebt+9ZcSDZoFZ/tZmOyFOEKHyvhWJMcrmLUI3C0zgj8ZvLDU1VxIYqQwXcKQ5
 dtAf06ERDWTY39y0diL++iurnMjamootwL1yEUaLI17IOxtAq91UoBM2Kg0HzcWDVINu
 eOWVQh+gBnkuajmMfKl+G49VUzpVRkkJ//bI2SjKuwt387pyVs7I9OZL3YobRux9QbzU
 EiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644857; x=1782249657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IaOFaqKACdMizsx9Pbv6kiT8caf5eiJWnLh/9195E8s=;
 b=SUHQCYC9woA084222oQzl+28n5ySKW/a0XE5pFncNKYLSE1jEWTUnsjNcFN8aTK8Y/
 ynvXOC20cYR7zkLhz88Ginq2rF8OFg1vqoaDSd0vSaUm3nPZ0W/piLou15HU1T6cuV6Z
 MmXPm3aU86uxedJuBHPJHVmnXGS2aiGizD+AKS9+E6zaYZlBdvHlxF0cWpx6AlTyjSFs
 eS2Wyzrbl/kW7bWdAcbhgROikTeP7D6oBEjlcAlcCm7Lt8whkx0LsWq/TjyNXFDR4hXR
 bOosJRfytK9jukqByu+j26u9cbyMBRvIICRkG3XVhm7C5oxeDCZDTVGwUOMavvXB7RgR
 XjXA==
X-Gm-Message-State: AOJu0YyeHT6f6KPsajVMmL6jQyWx1975pcdM6N+bNn1AqVTVj6SxZu7a
 rrYMokRBpTcEJdjYr4ctgGhzLCMdTAHIesIucyvDD5pQU/Ep5IZZAw1Z2sValQ+6OokF6ICIDLF
 6UH40
X-Gm-Gg: Acq92OFXGQ/LoAAFkZH26CMEuBCooHjmcMfY9Eu9kaGhpf9M/nuyRvvIwnLfxNi3c8J
 L1UVxiFdFI0K0Ay1W4U4qS7Oz6yczlU8wH6pUjSohi2n0rE3bpFbWOVGGespAnSRM/TsPGPBnRo
 PW4gWyeI0s/sLKbgJgy9NgZMuIAMtcyg5X1SR5oc/WN90MqrTdROWdeCBp8tF8PdDEigf4rZ5zp
 znAPwyu7eiG28v2S3flZ7qfe/MpxASIAtKtoCiR4Qj2wk559ZQFjiyYd704szalnHcOMNC9kakj
 GwqpPHsGk6Aj6CARnpGXXITWDA2RNYFhqmxOc30Dz5SoG/RzcT7bMkMBdNmkFmOiqrz70A0X9mR
 jQ2xtqAoSdAp2ZcM/qL6VZECwIgwJVuXDeOoxEazl2jdyE167wtXlz8+KV3vPjzJLcj4eAkKojQ
 nUpC8dwd6gPEEEv6fCPHJqRlnCjMN16KToM5qz94jA28eiUi0G6K2kCwIoT/X5
X-Received: by 2002:a17:90a:d88d:b0:366:132:fda7 with SMTP id
 98e67ed59e1d1-37c93723e15mr1107975a91.10.1781644857097; 
 Tue, 16 Jun 2026 14:20:57 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:20:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/13] linux-user: Introduce PGBRange
Date: Tue, 16 Jun 2026 14:20:42 -0700
Message-ID: <20260616212055.334466-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
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


