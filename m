Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B937BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkJ-0001Xc-2f; Sat, 30 Aug 2025 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bm-0004oZ-1c
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bk-0003uG-0t
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so2302077b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506606; x=1757111406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iohwGQx+PJHpsLcgRWLe+gDcmZ33+kolO8wPf1tJJvc=;
 b=wGvxw+sdOkyVcdcdURyvaeQHnAIxJ4L2hWjbW/l+tH06ndfXjsZZ6hVQ0Af7ZJvfCu
 RJQMynOvE6Bk4ljkRFqygpfqnMgYiVS9z+CT50bpfHaIKqkpBI4pZUSs8WKbPwfI37ol
 yllsuUwwlpXwllw9ZjTju+/MVzzSVLAMyflMPX+6DByBsCR9ENOqRe8lIEG1IrZvywMs
 qzdOY5Ex5pc3GJMqPXEu1C2ITOl/K8Fjv8inv17u2qgg9u3tuXIGpB4C5fqMqh4YjnmG
 Pea5oUU8CeFWhAaaT5eo4PT8iRoI1WoHSEy8BwnFN1ChHBCwVNBgPK4SiAvEQSY9p9nA
 ER6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506606; x=1757111406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iohwGQx+PJHpsLcgRWLe+gDcmZ33+kolO8wPf1tJJvc=;
 b=n4bd92CO9QpuhCtl5Y+ig1E4Ku3783c4puJEi7r2cyOLzY0GGcDED0SSkNLv9d6PXs
 D+akBx2FdPQuNgNigwn2eh1hCcQQYal931z7fZAkxq8C9dXpdBCL2evs59H0MqJpHXpX
 eDj1V2zyqA/x35mHuol2Z5ZU8m3X6dkQA+q2t9Afb0RIs39nIeM5u+z/d257zRzyuVbE
 mCKFvODkxhJrfZAjYSUnR1C4yPhFigjXupqVGyUcyg3gK6zqqGxqeTZD+22ftorGnhtO
 cdH8hgW1dOxoiOPhVu/+AQ3QoCjCB1CS2XxWpqskM1VmeewPYWju5XVorJPjv6k422we
 ZuLw==
X-Gm-Message-State: AOJu0YwnNNKJNTxwo9Z1AMxH//v8xT1I/f2Ui8/fKN/fbxQYZtiMxoF7
 Ap0m3zyvRM7Hm0moiKan2Evo1QGWfI9I4jilLPgBTBvO8lpp7bOuhlhB/mH1YAC5OPA8Df2AF4l
 Fqv0pp10=
X-Gm-Gg: ASbGncubv+DjfM45SrGtBhdDR2GgXCLgJI2v//9n6V7/RiT2GCXCAnFWi9lUyB7cwz/
 zhsQ4841KYetair669mJ4EN73y1lrjJWR3AMz0cza9a04mInlBNkt7k1/4yY020Ym0TDSwpSeUi
 iMu0oXCpBhBKNO7MQqKuod4Xe6robRUwRsGWExKO++DWRYroKWEZgzBo4shyayfGjTi3qADZIP7
 p/eJX9NGIhGjLhABU6MF4ZJfSxaxNVpxpZ/0UrNxzCBeCAbUnn7bA4JbBjYMwpJwHZZe6ZE8Xnm
 E46adk8VyWp5eVWh1gUuvn6V7zrN/o1Xt7HYToYtqYHWQBPDcSt1RoGliLYyQcmpxrJsTOIFHrH
 mGaJmkJZiI7OCxml+QDzZiO9WBu8vhMWKpMCPYkpzWjP6Cbd5B6LBnCrGTdO2RqfxMT3nhE7JiA
 ==
X-Google-Smtp-Source: AGHT+IG+NXNTK7jtChrQagzOK2TVUWHSH9Pqb1sC4hO2IUqtFpUsV2raqHuWyF4RIWdkzZV0aqzUww==
X-Received: by 2002:a05:6a00:3e0c:b0:76b:fab4:6456 with SMTP id
 d2e1a72fcca58-7723e308c8emr282439b3a.21.1756506605879; 
 Fri, 29 Aug 2025 15:30:05 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 63/91] linux-user: Move init_guest_commpage to hppa/elfload.c
Date: Sat, 30 Aug 2025 08:23:59 +1000
Message-ID: <20250829222427.289668-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


