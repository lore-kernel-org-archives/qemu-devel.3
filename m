Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B437EC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLP2-0004tf-0D; Sat, 02 Aug 2025 19:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOU-0003nn-Bl
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:06 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOS-0001oo-2y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:01 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2665742fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176318; x=1754781118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9Fyxy0iYqxs0t+2QnM3wgexXwkcWrG91zIlwNYAYRg=;
 b=Ui2HMNDj4wZXSbSVtKYougYUF08klW+Df1YRePCIPxgAiX3qvJSRX6KILZKHJw81ws
 UurPIcgebVLrYC3CTKtSDwVvLjeD1WGqtMV+YCP2gBfThleL50hYjgP4zSnqfyMkB325
 d+di2iPXNzXqWuJAKYXMPEzIPkBWDK2VVAJRgpvxFfWR4xRFQNL7c1xrD8jgrCXoryg+
 vhNIU75Lbpcg1xxJHqLTNcx7RaSq+z6KCrZYA0ZdN5VuAIF9J2jCjk+2YZZCsRrmTccM
 1HYdnHm7JAop9BavMJ/v3NqB/wwSYL8UGFrH1j9mrlS6UBe/AL8SSb7cklAWZ89rgMqG
 WZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176318; x=1754781118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9Fyxy0iYqxs0t+2QnM3wgexXwkcWrG91zIlwNYAYRg=;
 b=MUmvbtu3IkikYmhbSamM2H96rDOLHi7G6C2qjDmeXV9RGDbXu1A8zlxoT23TBDV/c0
 88n1v+lwBmwjrxQZFMovK60mlNDQ8WIdZYyJ0soRJQyRl0Vsk0N4HLIhS9bCtDj60Os/
 hpC0ZmlOci+rsnG5lCsMZCJNBPoDWZGTEwKb18r+NroSMQUB2TaQDQhi12lwUDzaPust
 jKFKVjRGVYKbe7Ox8yyjZorjBbcCBSCOK1QHUiQ3sZC7vVawZZJWjv+NnFsH8pOmVrgS
 40zl2vgKx/h//5r00NquvCB7CES4YFVPeQEv0BTTi58ESn32Vh5QV7pmHBi/LJazZFDb
 6iuQ==
X-Gm-Message-State: AOJu0YzS0UJY0EGT9lNkzP3IC5JrCMJgE2Q3X2s++wSYUWtPx/pSD5bh
 UOd0/pb6/5fiaBgnyUbMmREr9UsZe/5XtYeLd0qB0RbDBvIi1g9/aLnsVV29EPZOppKuxxZZ7jT
 CTn94l+E=
X-Gm-Gg: ASbGncs4rBHJl1nvtEztlq36IqikwgHcAId7k6AEEhUq1/cjksxPD6fsTVbcDvZVZ/W
 7xnU2ahrrRvgpGZ8S2ELOXvg+ofY+BlznDhRJq2vv5XfhigZnbUyAndYqrlP0BWx0iHngJKqQhL
 9MdQgQyTQHtzonTEy4pkkj3HzqoQ7vVwpBJwZaLeXgGO9HqfSMPzb48x1Mxwa0JYfKVyGqJgN+2
 Xh8rzZm5Wvlz3rcKTp2Twm8An4VFrxXuGbxdMi/hT0EZF5ICNA23bVy1yt6ZJPjGoK77KR0VmUA
 AkZybFJThjt29b/KkqfrLH5rW1gBvGLyjfP4AG2Fjoi5DEVw+4tIh8AQGBrO+gGXZmRencVBpT4
 eTbzvK0nG0QNP9sRfGb05i2kgbKpA2zu69XAbqfS/Asirvk4e77Yy
X-Google-Smtp-Source: AGHT+IGPA61HYU47hLvilGjNtnKliUrZkP9SAfx6j5g6VeGUvL+p4ZVYzXL5gFwkLWGtvzOQ5zE2gg==
X-Received: by 2002:a4a:edc5:0:b0:611:a921:bfef with SMTP id
 006d021491bc7-6198f314133mr2438394eaf.8.1754176317981; 
 Sat, 02 Aug 2025 16:11:57 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 64/95] linux-user: Move init_guest_commpage to
 hppa/elfload.c
Date: Sun,  3 Aug 2025 09:04:28 +1000
Message-ID: <20250802230459.412251-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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
index a12a07039a..4ef46fba5c 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,9 +105,7 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
-#if defined(TARGET_X86_64) || defined(TARGET_ARM)
 bool init_guest_commpage(void);
-#endif
 void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6cc2c498c8..ec5b1b586f 100644
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


