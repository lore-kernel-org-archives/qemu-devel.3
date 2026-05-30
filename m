Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6F4CD6E59
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzS-0005dQ-CO; Sat, 30 May 2026 17:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzJ-0005cN-So
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzH-0000cp-TZ
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso1919105ad.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175574; x=1780780374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXIpY+BcyO+KWcNu+Dj75+LCljfhirlOj1U9J8zLtBs=;
 b=CscD1lMc2eDqr22+npw51Y+oaM1CYQffK6sr4ImT/mydUGs+/Za4weLdpCcdPPFMOQ
 2qFo8YqC55O+sXAJnKBlqzHAw3Q4H5XyiEmaiI8MjiTVKpoH94wiHoGolcNVqnoW7kAh
 YKgQj9/ESea1pBugat6F6zuK63EbAzO1JkqnBAGPHjs90O4rIUry549O0JItduGFX6q+
 YOc5tkAQ0K0JTX6JxbGTABDhUCiDvBdnXOl00noWLp6pETNDmJsldBZ0TGifc0bPfPX+
 nj1ci2uMJ3DCbPdVYHAUjjMPqbJhrhN3Orc5ky18qyZXCccFlit9C6yhdT8DFa4DW7bU
 imzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175574; x=1780780374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UXIpY+BcyO+KWcNu+Dj75+LCljfhirlOj1U9J8zLtBs=;
 b=igOsgfrfx0L5qiC1v8rWpM7bRVZZIF5AHILxUv4EzSMZxqtV5Ce7OB3umgVnVLpvVQ
 ui+H8WW0MQzjbK/mDBDt+P3ZNyicURq/bLACxpQ/pKdYu97zPf4LOK81mQcwEkbrqpe7
 Qb4HSsy0X6tVQo4bYUnskst7ad8br1BvXjV6OBXFQklFet3SuLbPRs48o6jF9max5fyc
 isj5N182hdyLInz37ozDqQDL+FQ5Z+xt3qs2PWLU6n5VBhPGWBKlpdZcGmtIY4YGWlRh
 ELMHR90kitmUh+5yX30CP2FVN+wUZqnM1NJ4pokAYbnxQRDbEsioYlx4MZO0aWKdhDRo
 xnSQ==
X-Gm-Message-State: AOJu0YzzwdmsElazjJYSY/M5639pi/eDxz7vzQIqlBSer/TlLDQiWCWY
 NvoA3qBU8Yuw3sFxgTpwc5OZ4Klt6pX2+eB1G6MtmXilmQcoiW4iLaoGSkB76cjLxuDhLlcQCMy
 hNHf4zIQ=
X-Gm-Gg: Acq92OGafD8XgeEIvXIvg7MwjCB1Vs/SDspeSR6nACGJe/nip5A7x6ECl7o38nvvDqH
 QhmWonAvAFiGndOVh+Xb3Gic0mby8BNG1vpqMb3ZwoDLcmElegnQcv+6EVuTOLqtP8r1HB3BZAh
 Cd4Ed3pvIJrOPcLFpUA6P9Y0BMa9Nfz6p4pDsIjppH5/N/E7KAdwREWJXCE0xBRcJOp+XBDoo41
 iWrssfyl7EaHPBeDj0V/1K9gnzauRZfOTwTiydJuywC8JzLhlV9g0FyB4SkaQk5zOs5ndSPFBvc
 5wOPdrTYMoiAUFQYIu1VO8Prs0RuONm56ilSXla5pk6Wy0quSW9jWR676ZnWoz7aSuZFcH/0j7Y
 kjkMPe8TvfTvlFuSz+FN+tMobOo94Kkx1zNy2HA/uggs3hfWLQ0oyK9f/s6pP7wdOY8LFswuji3
 LlBPz1wx5sCbXrhLYbFij8U9epR/ButzP4xIYyh4o=
X-Received: by 2002:a17:903:1207:b0:2bd:3bfd:7512 with SMTP id
 d9443c01a7336-2bf368468ddmr58029325ad.29.1780175574200; 
 Sat, 30 May 2026 14:12:54 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 04/13] linux-user: Pass image_range to probe_guest_base
Date: Sat, 30 May 2026 14:12:38 -0700
Message-ID: <20260530211248.375318-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-internals.h | 13 ++++-------
 linux-user/elfload.c        | 46 +++++++++++++++++--------------------
 linux-user/flatload.c       |  2 +-
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 73b0109e9c..3f41d3f33c 100644
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
index 33565ad7be..10a826e658 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -847,14 +847,13 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
 /**
  * pgb_addr_set:
  * @ga: output set of guest addrs
- * @guest_loaddr: guest image low address
- * @guest_loaddr: guest image high address
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


