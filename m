Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE362CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqK-0003xk-6N; Thu, 18 Jun 2026 15:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq5-0003tM-4d
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIpz-0007rg-71
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c6c57c5bcfso12909875ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812535; x=1782417335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgqfzWhCcL1IcrFMPtYBl3wfH4Sd8FWDUgVUy/mTAUA=;
 b=x1zh5Ks05bghW1ZfrfdA3xTiZ2Vv9jN4JtB7b/u0U737mz1aMVOisZqsLfJ26XOX+g
 xHizo4SIMxQbbg7CDPPbnSX6bf4hwsp6IaBkue5fxL+NzOFoXYbJuzsr7378Psk0WEiD
 VuQqprXqIXjwPI0CEgw7YWDOCmf/0+F0CZXkFywJO+Od/Jebx9N4BXYy6ogZQzGymwoK
 u4CDyk+w4n8huVW3A8tAvPcNMA/v4N1iZOlmaMVGxasYEhCPYXJVhEcazvB2Hb9QexAG
 +mrXxXmP/C1pIxlGw2lLXF3w7x/x1d4GNoqhqUiedI3njC9vFBUchT48NAl0hiG4I4ws
 aSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812535; x=1782417335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VgqfzWhCcL1IcrFMPtYBl3wfH4Sd8FWDUgVUy/mTAUA=;
 b=hOi8IEPzhfOnLomlfT2su63vpWts9I4q0mkP5b9Lgo4v+AHsDEDw7tq6pxqmzUh8SH
 Qi5jOyqzVX5Mo7qn5s8CTnCu7xcDuYRpDvzpVDz7uHmpG/LqOUzJxeMETCq8TpFf6MVI
 QumS6cozOJOl7RBCC91xtPhNOJ+/1POSAgbToVbH/zf5FxwoFRdDU+fuBJGBGbKU5oU6
 A25T2nj2SG+5DgB3D2ZGc1Qj9W8c9Eva+4NNn+ZfkMPUyPdkr+/gYfVEf8gNdf2N/trl
 kQtaokCYZoSOs2dvdiYrv9LLALGlU5QG88FR82SagFyhfvRNO48Y4g9iecoiufOhVU4w
 a/7g==
X-Gm-Message-State: AOJu0YzBOz/vOjg70GZf9I6WDnxrk+xEdbxRtytmSG233t/Qpd9XoDOS
 oQHx6jflXk3uzE97eTK+IXr41Fj4tptNcC7y9xMBmLBGauh/LlucDjVHGk2rEEKC/K3LWvpp/FG
 SPGOR
X-Gm-Gg: AfdE7clUjVwa59D5jERZiCNd/eImkJ3zPlwsIjKRBE2Dc+mui52h0lkGs7hKD9cWZWy
 HM4/6PtLXyNaSxhYoYdAM6ZAsx1iB31hKgTxLHxRS2QUEr4ZvjKKDzx7yg2Mjjv69Np3CeszmjO
 /zNq6F1uMmTK76a+nzpJu4qswOmVMQuvLQUDwjjAur2d6H2eBKpV1ooTEBeCWA8TgUuMUyEXvC8
 YQ93g0xPz4rzzWMhBqJC53jGxjBtKv/LS37bbupFwQ/KMg/xfMjEEZ25xASC47A+M9IPBpfbMUk
 lsEeSUkXrGwo4jObbw7lf8PR/FxEFuMLiZ6CFlWJIYbMtAoc+d3BcEYf6u2QBORsblhBJWd5b9l
 zLeWzJQj2tjlV+EApHWka5sdF8NHL8GB7nV7aNinYXDB2wTiXCbMA5uEGCANuqW/TBW6mVHNDCz
 A5CM1g7T7kxiGfSd4TAeoWuvqUMXWVsOlOJalfduR8C+Qp2jY+4w==
X-Received: by 2002:a17:903:22d1:b0:2c0:ab82:6b99 with SMTP id
 d9443c01a7336-2c718fc11b2mr6589175ad.33.1781812534846; 
 Thu, 18 Jun 2026 12:55:34 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/13] linux-user: Pass image_range to probe_guest_base
Date: Thu, 18 Jun 2026 12:55:10 -0700
Message-ID: <20260618195520.589907-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Pass a PGBRange structure instead of separate guest_loaddr
and guest_hiaddr parameters.  This allows NULL to indicate
that the image is relocatable, so that image_range->lo == 0
is a valid fixed setting.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-internals.h | 13 ++++-------
 linux-user/elfload.c        | 46 +++++++++++++++++--------------------
 linux-user/flatload.c       |  2 +-
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index b04ca43f02..d7f346b0d0 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -83,24 +83,21 @@ typedef struct PGBRange {
 /**
  * probe_guest_base:
  * @image_name: the executable being loaded
- * @loaddr: the lowest fixed address within the executable
- * @hiaddr: the highest fixed address within the executable
+ * @image_range: the fixed addresses within the executable
  *
  * Creates the initial guest address space in the host memory space.
  *
- * If @loaddr == 0, then no address in the executable is fixed, i.e.
- * it is fully relocatable.  In that case @hiaddr is the size of the
- * executable minus one.
+ * If @image_range is NULL, then no address in the executable is fixed,
+ * i.e. it is fully relocatable.
  *
  * This function will not return if a valid value for guest_base
  * cannot be chosen.  On return, the executable loader can expect
  *
- *    target_mmap(loaddr, hiaddr - loaddr + 1, ...)
+ *    target_mmap(i->lo, i->hi - i->lo + 1, ...)
  *
  * to succeed.
  */
-void probe_guest_base(const char *image_name,
-                      abi_ulong loaddr, abi_ulong hiaddr);
+void probe_guest_base(const char *image_name, const PGBRange *image_range);
 
 /* syscall.c */
 int host_to_target_waitstatus(int status);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 960847fda7..8545ac9695 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -847,14 +847,13 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
 /**
  * pgb_addr_set:
  * @ga: output set of guest addrs
- * @guest_loaddr: guest image low address
- * @guest_hiaddr: guest image high address
+ * @image_range: fixed guest image addresses
  * @identity: create for identity mapping
  *
  * Fill in @ga with the image, COMMPAGE and NULL page.
  */
-static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
-                         abi_ulong guest_hiaddr, bool try_identity)
+static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
+                         bool try_identity)
 {
     int n;
 
@@ -866,7 +865,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
         if (LO_COMMPAGE != -1 && LO_COMMPAGE < mmap_min_addr) {
             return false;
         }
-        if (guest_loaddr != 0 && guest_loaddr < mmap_min_addr) {
+        if (image_range && image_range->lo < mmap_min_addr) {
             return false;
         }
     }
@@ -892,10 +891,8 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
         }
 
         /* Add the guest image for ET_EXEC. */
-        if (guest_loaddr) {
-            ga->bounds[n].lo = guest_loaddr;
-            ga->bounds[n].hi = guest_hiaddr;
-            n++;
+        if (image_range) {
+            ga->bounds[n++] = *image_range;
         }
     }
 
@@ -928,8 +925,8 @@ static void pgb_fail_in_use(const char *image_name)
     exit(EXIT_FAILURE);
 }
 
-static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
-                      uintptr_t guest_hiaddr, uintptr_t align)
+static void pgb_fixed(const char *image_name, const PGBRange *image_range,
+                      uintptr_t align)
 {
     PGBAddrs ga;
     uintptr_t brk = (uintptr_t)sbrk(0);
@@ -941,7 +938,7 @@ static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
         exit(EXIT_FAILURE);
     }
 
-    if (!pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, !guest_base)
+    if (!pgb_addr_set(&ga, image_range, !guest_base)
         || !pgb_try_mmap_set(&ga, guest_base, brk)) {
         pgb_fail_in_use(image_name);
     }
@@ -1026,15 +1023,15 @@ static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
     return pgb_try_mmap_set(ga, base, brk) ? base : -1;
 }
 
-static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
-                        uintptr_t guest_hiaddr, uintptr_t align)
+static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
+                        uintptr_t align)
 {
     IntervalTreeRoot *root;
     uintptr_t brk, ret;
     PGBAddrs ga;
 
     /* Try the identity map first. */
-    if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
+    if (pgb_addr_set(&ga, image_range, true)) {
         brk = (uintptr_t)sbrk(0);
         if (pgb_try_mmap_set(&ga, 0, brk)) {
             guest_base = 0;
@@ -1046,7 +1043,7 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
      * Rebuild the address set for non-identity map.
      * This differs in the mapping of the guest NULL page.
      */
-    pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, false);
+    pgb_addr_set(&ga, image_range, false);
 
     root = read_self_maps();
 
@@ -1085,24 +1082,23 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     guest_base = ret;
 }
 
-void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
-                      abi_ulong guest_hiaddr)
+void probe_guest_base(const char *image_name, const PGBRange *image_range)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
     uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
-    if (reserved_va && guest_hiaddr > reserved_va) {
+    if (reserved_va && image_range && image_range->hi > reserved_va) {
         error_report("%s: requires more than reserved virtual "
-                     "address space (0x%" PRIx64 " > 0x%lx)",
-                     image_name, (uint64_t)guest_hiaddr, reserved_va);
+                     "address space (0x%" VADDR_PRIx " > 0x%lx)",
+                     image_name, image_range->hi, reserved_va);
         exit(EXIT_FAILURE);
     }
 
     if (have_guest_base) {
-        pgb_fixed(image_name, guest_loaddr, guest_hiaddr, align);
+        pgb_fixed(image_name, image_range, align);
     } else {
-        pgb_dynamic(image_name, guest_loaddr, guest_hiaddr, align);
+        pgb_dynamic(image_name, image_range, align);
     }
 
     /* Reserve and initialize the commpage. */
@@ -1362,10 +1358,10 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Make sure that the low address does not conflict with
              * MMAP_MIN_ADDR or the QEMU application itself.
              */
-            probe_guest_base(image_name, range.lo, range.hi);
+            probe_guest_base(image_name, &range);
         } else {
             /* The binary is dynamic; we still need to select guest_base. */
-            probe_guest_base(image_name, 0, 0);
+            probe_guest_base(image_name, NULL);
 
             /*
              * Avoid collision with the loader by providing a different
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 8abdd2aef2..45d69040c6 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -261,7 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     /*
      * Allocate the address space.
      */
-    probe_guest_base(bprm->filename, 0, 0);
+    probe_guest_base(bprm->filename, NULL);
 
     /*
      * there are a couple of cases here,  the separate code/data
-- 
2.43.0


