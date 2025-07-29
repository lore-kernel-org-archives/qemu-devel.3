Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB80C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucp-0000Hd-Lz; Tue, 29 Jul 2025 20:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ3-0004gm-Iv
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:31 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ1-0004dk-HY
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:29 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b42099901baso1991842a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833866; x=1754438666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ut68EBxP3nF3sszksqZbsbARC+pNHvmjmSrg0qwpPOA=;
 b=xu7WMZTrHQn2T+5A+BvpjgMSUAljAQAqIVX6IUfV2Eyx5d1mInaIkkAaLoRAzXvfgQ
 6K9WXA6GviejGOY7mMczaWg0PhywE6Ec/sNqa87+utEmcpzhXj9Q1Kh8dftpPprStGr1
 bY4ipre+1pc6On/k2I9n0hde04+8Z6ZRjj0TPZbWgsRtiV+j9QpvnQXXzweNuiqSnWRy
 vvQaBkNyL4JNb4xMaH2YhP/+x+DbFVFVYYnTYocLa32dVLkgqt6uWB4sNLxmHY00OkDb
 3LoG+fmNkIiej28EpKRd1kJdf4ZCvbdo62ZWvvxYOBrzHUZXfFqHrcbRjO2/IAPYMCrN
 ZzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833866; x=1754438666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ut68EBxP3nF3sszksqZbsbARC+pNHvmjmSrg0qwpPOA=;
 b=OZz9DVfehaJYr8ua9VTg/wDieiNf2ejWSOjdMxwkEBt5fQD4spytRy6bXDBz+ZnE37
 TEy7Cz0QHmdHprM5LiBJYZHcj2z9IoKWG0xYEifz0DNapWfMrhajjpSX4ZJZb+oMe4Mg
 lEP1Z2WwLrBBfZlSoWh40Ef2N2LcOt7PbPbzt62qLVzLWnCktodX71DFdPpjNb1gFIBR
 1V3T11yiR57Zw6F/hHYjyn927fPX7NMO2u8kyAfv9nqa93KwCQzYX1yK2b1yhbk/aH/s
 NVsIq7qWWAJKmYi0CZq4ROLSlFWVH8mpIKYmO2e1lk+CMem7PNUMm1g/0LDR4b6SWech
 qv8w==
X-Gm-Message-State: AOJu0YzeiqH0qws553z8TyK0LEXRXtaKZF9usbvBWrvpZ9/uXoWjXkOm
 HSxPbDpjLSjDu4t6q4sFHBHlmtUraBykdzw8RHwuBvUyFDSis4CvravHoMlI6Y0gj2SPNAtjSNn
 7VnGA
X-Gm-Gg: ASbGnctWxBATmjUraPA11SguY6HOi9RhND9CIv7GvHsuyhX3NbENBLNAtgYWaTwn5uf
 29POOdm8dyLzBD/GCdLrleG3GqYb5o7sdZ5BD+qjdV+6PZqqn9Q/UQnaORmh1Zt9eEv2ruEdXFg
 Og7WIuuOAu8vwtdmhK1w4VYDVRUPao7iFf5o1q5Hs8PGHGw/qiC5TdQ1b9+kcu/Bv1SqKQ+eeCM
 30KUb6KGDZXI8TE+b+4PSgkxIgRwSuYR+5HDEKzp7r6A0Q7jqQeYcKjjQ/ugz9bHoauGyi8AzQ+
 0u3j12wqe73DBhLy39Gm/wJWPdhOAo/IMTQCrYOD0YhHT64knjKKfab8sXkukpc/6yh/j1UzhAX
 8pN5c9RuoM8mr++ZgzcPlTC3MHztxaYbHIBoXAwFajsrE1ci/ioHOjHkP+BpR0GioMjqKDev2vL
 gD+Qa83yRD+g==
X-Google-Smtp-Source: AGHT+IGHNHfmFIbtOMFk0yBCCD/FKmfPdXQMKb7RcNECeN43g7Kyiw6rXBTl/2219L5JuWfL6gWYSw==
X-Received: by 2002:a05:6a20:5491:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-23dc0ec3828mr1845923637.38.1753833865767; 
 Tue, 29 Jul 2025 17:04:25 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 55/89] linux-user: Move init_guest_commpage to x86_64/elfload.c
Date: Tue, 29 Jul 2025 13:59:28 -1000
Message-ID: <20250730000003.599084-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h         |  3 +++
 linux-user/elfload.c        | 20 --------------------
 linux-user/x86_64/elfload.c | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 700bbdb02e..e5e317ab76 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -102,5 +102,8 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
+#if defined(TARGET_X86_64)
+bool init_guest_commpage(void);
+#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6feab68a52..297151e4fa 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -159,27 +159,7 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#if ULONG_MAX > UINT32_MAX
 #define INIT_GUEST_COMMPAGE
-static bool init_guest_commpage(void)
-{
-    /*
-     * The vsyscall page is at a high negative address aka kernel space,
-     * which means that we cannot actually allocate it with target_mmap.
-     * We still should be able to use page_set_flags, unless the user
-     * has specified -R reserved_va, which would trigger an assert().
-     */
-    if (reserved_va != 0 &&
-        TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE - 1 > reserved_va) {
-        error_report("Cannot allocate vsyscall page");
-        exit(EXIT_FAILURE);
-    }
-    page_set_flags(TARGET_VSYSCALL_PAGE,
-                   TARGET_VSYSCALL_PAGE | ~TARGET_PAGE_MASK,
-                   PAGE_EXEC | PAGE_VALID);
-    return true;
-}
-#endif
 #else
 
 /*
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index bc40ed8c5b..98acca94ef 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu.h"
 #include "loader.h"
 
@@ -14,3 +15,22 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "x86_64";
 }
+
+bool init_guest_commpage(void)
+{
+    /*
+     * The vsyscall page is at a high negative address aka kernel space,
+     * which means that we cannot actually allocate it with target_mmap.
+     * We still should be able to use page_set_flags, unless the user
+     * has specified -R reserved_va, which would trigger an assert().
+     */
+    if (reserved_va != 0 &&
+        TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE - 1 > reserved_va) {
+        error_report("Cannot allocate vsyscall page");
+        exit(EXIT_FAILURE);
+    }
+    page_set_flags(TARGET_VSYSCALL_PAGE,
+                   TARGET_VSYSCALL_PAGE | ~TARGET_PAGE_MASK,
+                   PAGE_EXEC | PAGE_VALID);
+    return true;
+}
-- 
2.43.0


