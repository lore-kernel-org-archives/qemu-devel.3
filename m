Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63ECE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoM5-0008P3-OX; Thu, 12 Dec 2024 13:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLv-00079e-46
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:59 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLt-0006rB-Fj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:58 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725ef0397aeso855298b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029755; x=1734634555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdnrZGUpPexZaRp1gyb0f+RzXNxhb5NfrEmgTu8F7Mg=;
 b=v5C1JNiDlgdabxT/Q8X/VnkKqTRST9HJlyKDUO4l+gv3cwsDdWH38AR46P3aJFhcbj
 4rODYm6SACHnNywqpAbwfwu9R6Ds3is3NJ9tLyd1tDXw1/r2oh/4RPY6R5gadE3TFD1q
 FqXB4Nd+wKVyvC7+GCPN2bJwyJi8862mJocTnuE7evc01GAgR8wTHvsiPP5HQsqZoOGe
 64hnsewWzkwkbfLKXYziy4mrd/z7yNOFV6xHnxQ8TfPk2tRmURh2vssOfN90zzlwVAS4
 6mmXXvZ7ttrXZ8V1c7rY4kIa0f+hfINdSEGFQrn/iuZxjywoZ34hojgZMKe/ITbotLqz
 5yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029755; x=1734634555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdnrZGUpPexZaRp1gyb0f+RzXNxhb5NfrEmgTu8F7Mg=;
 b=GAR0b9rnWnJ0c+dqCfH6+Qm0h2WHvtvXl21Wc4KhROHDf7iIes4zYO5AEf0s7Uf5t0
 n7EYShNe5OlMd8UTSR6KhNfiM4V1eGfT1xMdxpIET7BhdAsL9SfLKhSh4zX5JCQDe2RJ
 J2HgaIg3/6sVBtoEKgk4DFRzJdyhqFkr2J1o8pE6wvVwsIqdbS8u4f/9DBtEBF0amYCl
 jgQAZnxKyfLVcP8YqfYPY+6Cqe/xJ3xabSPc7tJSFekzrrtg4iFlcZEZDGEV0BogaMjK
 gm61E+tNQI+tYIKBpijoJlkmtZk1AHsIZS5/POdqj/tLJkXbrkz4Zy4Vo+DDDA1HAZer
 5Y9A==
X-Gm-Message-State: AOJu0YyPktDfhA3r6yFIk5RBNVFT5CVOANm+1isn2W4+vKpL4mRmUR4x
 /OopkDx9lvk6YMHccu/4RUNM5etYFIyLs0K69QxM9TE7gLrYx+5vT5gRFSzmKJk3Zj4//Dy1WmV
 M
X-Gm-Gg: ASbGncsQ251N8iCWcQoqyL0fjloZg82cyFQhvozVpjHAuB0jyWkUtwE+aAHHDuyex5X
 CEsRkEhmF8vUgsjklcQTQ6fLu6I3D9oayOaqCIdLswN4I7/XpGwbOWSJU+jXbrfcwxEaZ39Q7N6
 sXSBqI5Aw9Jh+NQO0QEtNLsruNZOmUTMoqGwu81Jb5tL0QjERuLq5Kte7u4ARsJvWiFbe9e5+4B
 azAhe4QqO+WJZtckhcrZSRCUcBPOxcJ6l39ZcJW3i5vf7mHYoOmOg8Qb6p+dM3lu4a0wYvqI+tG
 Vo8SlR8Z5kgVq401blDJQ1nwalM1bXA=
X-Google-Smtp-Source: AGHT+IE5bIF9VtLylFp1j+0DZ2Ndsno1rZUC7F8vX1IC/vjDv3nvLZ2NAyLsHTzaYZ/0TM+/P6mzHw==
X-Received: by 2002:a05:6a20:728f:b0:1e1:ab63:c5e8 with SMTP id
 adf61e73a8af0-1e1dab643edmr1888496637.26.1734029754866; 
 Thu, 12 Dec 2024 10:55:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725da7e0181sm9392168b3a.134.2024.12.12.10.55.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:55:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/18] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (1/4)
Date: Thu, 12 Dec 2024 19:53:34 +0100
Message-ID: <20241212185341.2857-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x433.google.com
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

Move declarations related to page protection under user
emulation from "exec/cpu-all.h" to "user/page-protection.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h         | 5 -----
 include/user/page-protection.h | 8 ++++++++
 bsd-user/main.c                | 1 +
 bsd-user/mmap.c                | 1 +
 linux-user/main.c              | 1 +
 linux-user/mmap.c              | 1 +
 linux-user/syscall.c           | 1 +
 7 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1c8e0446d06..3d97323893b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -127,11 +127,6 @@ extern const TargetPageBits target_page;
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 #if defined(CONFIG_USER_ONLY)
-void page_dump(FILE *f);
-
-typedef int (*walk_memory_regions_fn)(void *, target_ulong,
-                                      target_ulong, unsigned long);
-int walk_memory_regions(void *, walk_memory_regions_fn);
 
 int page_get_flags(target_ulong address);
 
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 448c7a03449..ea11cf9e328 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -12,9 +12,17 @@
 #error Cannot include this header from system emulation
 #endif
 
+#include "cpu-param.h"
+#include "exec/target_long.h"
 #include "exec/translation-block.h"
 
 void page_protect(tb_page_addr_t page_addr);
 int page_unprotect(tb_page_addr_t address, uintptr_t pc);
+typedef int (*walk_memory_regions_fn)(void *, target_ulong,
+                                      target_ulong, unsigned long);
+
+int walk_memory_regions(void *, walk_memory_regions_fn);
+
+void page_dump(FILE *f);
 
 #endif
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 61ca73c4781..0a5bc578365 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -38,6 +38,7 @@
 #include "qemu/plugin.h"
 #include "exec/exec-all.h"
 #include "user/guest-base.h"
+#include "user/page-protection.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 775e905960b..346f2cefd32 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "exec/page-protection.h"
+#include "user/page-protection.h"
 
 #include "qemu.h"
 
diff --git a/linux-user/main.c b/linux-user/main.c
index b09af8d4365..06037304cb1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -39,6 +39,7 @@
 #include "qemu/module.h"
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
+#include "user/page-protection.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e4bf5d5f39c..4e0444b4cbc 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -22,6 +22,7 @@
 #include "exec/log.h"
 #include "exec/page-protection.h"
 #include "qemu.h"
+#include "user/page-protection.h"
 #include "user-internals.h"
 #include "user-mmap.h"
 #include "target_mman.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1ce4c79784f..c54b199b6d3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -135,6 +135,7 @@
 #include "signal-common.h"
 #include "loader.h"
 #include "user-mmap.h"
+#include "user/page-protection.h"
 #include "user/safe-syscall.h"
 #include "qemu/guest-random.h"
 #include "qemu/selfmap.h"
-- 
2.45.2


