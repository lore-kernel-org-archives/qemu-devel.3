Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF25CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCO-0003DP-4G; Thu, 28 Aug 2025 13:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWS-00088D-Ud
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:37 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWO-0008La-IQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:31 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b49cf21320aso1032894a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383264; x=1756988064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iohwGQx+PJHpsLcgRWLe+gDcmZ33+kolO8wPf1tJJvc=;
 b=P5zBD3WI4BlIYxxLghBd59zbyl4n53QxVfqIbmw54DROYnhLXtyu0iLKAbtWtpeBXT
 FmfhC0YfJXlKa18ZIUbLgTgQkin/+JNOEzUlZzWbIQH7juz/Bd61q1iLbN4EeE9gNdXk
 wUnd/wF8v87RuKc+Ci/XcOJ35y7sPOiYU783XgQhR2C0n6DP4XpgLaq54BGaITBPSs15
 265ezNCVB46Gsh1jcgn8ulGImHKIC8tToKbDffWk4wfE8o4pzvt9Y8DfSXJ4hZwRBnWW
 90GfyvSKZslggEo2U/kofD/0D0QdkffkOhi36XUhaq1mByDIJhty3rVfxGMwyVw6uPR+
 iIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383264; x=1756988064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iohwGQx+PJHpsLcgRWLe+gDcmZ33+kolO8wPf1tJJvc=;
 b=dGK8LMWZRKYq4ZrUggmwdETtvb3eD+9iIIyO/UO212hBgKZUHrksWMNvYrVkVDUG3H
 oNN4EqGyPRl8y/37IgQODGYHMv7ul+DQpVZ/cJyo77PYY40GgOyZ+w3DmC4b0jvjhQeX
 RPrCQWtDNy8XxNXR4yTIQOS7mM0bDpJVkL997SFbu45nbdHPGh2YFZ55+SR8Zk6Gd/f2
 mukDkk6Q2jEZ/UZ13CUKHt8SM7B5byAXPkEa2hFuLLbBcK8qar587rAqAoWubIEH2x6f
 yTmud7R2xIKKHTWx6UtaDMvvvPO9C6DvwvRNQ6g39zPxv+6ZIf6/CafQ/HGnFMebEOO1
 +srg==
X-Gm-Message-State: AOJu0YziUGW42qzEt6LF+7SMOJwsazYlhoB7p+tt728mBzuI0c+3fNs4
 tewCGMFVSNDI7qEMm4a0Y22+qSEPi8jMdzkvZprKTciMm1lp0wq+45ouNgCR1DmfIqIgCiqrBew
 tMKEtHPw=
X-Gm-Gg: ASbGncuw3++B3823OIONOxIZqcLxUddZXjzOOzLdggc0y3/v1xkrckwaX5DIhpNee9k
 QQpl2TqoVxdMCmCM1Am6K9GOhbYQLMCY/1g2irdK+7henMnkVBlLHG+1JjbIyicINbqtLl1jIPf
 sDQRUd1WaZNfgFa++zmujlAIXHeUN2lzgZ49MfJK7mWS/C94N+He3QxabMCzkBgz8528EKFmkTr
 l2GngLsVEXy1S38qdmwsWZ0WkI4cNRuvZD1xoesLKV1scFooD5zVLAMBV1UkryPN15MmlHR306/
 k9OKAH940P184GOtbvRKBMR1oG9QHbx4Q2J3RbMgGOrnZ4ld1SV+oO0Zfw5+5ntZBwKUB82EZXR
 Wfc8z/ev4TQ7NavtlN6fIvEk2VhWYicZvVtcEbXnbAAwJOHw=
X-Google-Smtp-Source: AGHT+IE0GVi0OBeMfdw8EANZyzg1IEhChw4uDGfK3cwP/feacIDbaJRsJvsWhwewMPeFs4Zt3TVEzw==
X-Received: by 2002:a17:902:e552:b0:247:b86:548f with SMTP id
 d9443c01a7336-2470b86560amr148579125ad.11.1756383263795; 
 Thu, 28 Aug 2025 05:14:23 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 59/87] linux-user: Move init_guest_commpage to
 hppa/elfload.c
Date: Thu, 28 Aug 2025 22:08:08 +1000
Message-ID: <20250828120836.195358-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_elf.h |  2 ++
 linux-user/loader.h          |  2 --
 linux-user/elfload.c         | 32 --------------------------------
 linux-user/hppa/elfload.c    | 31 +++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 85be00584d..b654758afa 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -10,4 +10,6 @@
 
 #define HAVE_ELF_PLATFORM       1
 
+#define LO_COMMPAGE             0
+
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 0c2cc556c3..c3b8f92e23 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,9 +105,7 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
-#if defined(TARGET_X86_64) || defined(TARGET_ARM)
 bool init_guest_commpage(void);
-#endif
 
 struct target_elf_gregset_t;
 void elf_core_copy_regs(struct target_elf_gregset_t *, const CPUArchState *);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2281853c57..25f29e60de 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -415,38 +415,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define LO_COMMPAGE  0
-
-static bool init_guest_commpage(void)
-{
-    /* If reserved_va, then we have already mapped 0 page on the host. */
-    if (!reserved_va) {
-        void *want, *addr;
-
-        want = g2h_untagged(LO_COMMPAGE);
-        addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
-                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
-        if (addr == MAP_FAILED) {
-            perror("Allocating guest commpage");
-            exit(EXIT_FAILURE);
-        }
-        if (addr != want) {
-            return false;
-        }
-    }
-
-    /*
-     * On Linux, page zero is normally marked execute only + gateway.
-     * Normal read or write is supposed to fail (thus PROT_NONE above),
-     * but specific offsets have kernel code mapped to raise permissions
-     * and implement syscalls.  Here, simply mark the page executable.
-     * Special case the entry points during translation (see do_page_zero).
-     */
-    page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,
-                   PAGE_EXEC | PAGE_VALID);
-    return true;
-}
-
 #endif /* TARGET_HPPA */
 
 #ifdef TARGET_XTENSA
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 9dd3fe092a..018034f244 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -14,3 +15,33 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "PARISC";
 }
+
+bool init_guest_commpage(void)
+{
+    /* If reserved_va, then we have already mapped 0 page on the host. */
+    if (!reserved_va) {
+        void *want, *addr;
+
+        want = g2h_untagged(LO_COMMPAGE);
+        addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
+                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Allocating guest commpage");
+            exit(EXIT_FAILURE);
+        }
+        if (addr != want) {
+            return false;
+        }
+    }
+
+    /*
+     * On Linux, page zero is normally marked execute only + gateway.
+     * Normal read or write is supposed to fail (thus PROT_NONE above),
+     * but specific offsets have kernel code mapped to raise permissions
+     * and implement syscalls.  Here, simply mark the page executable.
+     * Special case the entry points during translation (see do_page_zero).
+     */
+    page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,
+                   PAGE_EXEC | PAGE_VALID);
+    return true;
+}
-- 
2.43.0


