Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfhq-0000YA-MM; Fri, 20 Dec 2024 11:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhH-0007zF-QT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhG-00085R-0n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:51 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43635796b48so13682735e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711468; x=1735316268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gotFg7Z6rIPf9OWJfzM5lmtklY+ARPyI8m/w+TBOPmk=;
 b=WJdSZ7KVPVLpuvrbX9Z3RBEhDYZrT8wC4yrWeBqEaGTe8BwEBMThJup+IYMD51+4hD
 79bp3H7J5XazEso7HaFEyxHMVn5SbCJfOzsDjEhXdkAPZhy39A3SEnIef4PFMuU6gCcG
 vkyey/l4n1KzoGqxO5vdFdnsoVUmxKdZzy3VO3OYIJqFCtpzHvAKu3VvE58LFerMwHkT
 yt4S+TaLIjve8trl5yrZsTz6PcIXoChIQuu03F7xV48dUBNzMi4jGwUHCcI4WVqhyuJ7
 gr2Yukzy44Ztgim6OUG1FvJrzPUWGZaH05dBirMNW1lnOht/nkk/BP0zrClZcVDzSswX
 4zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711468; x=1735316268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gotFg7Z6rIPf9OWJfzM5lmtklY+ARPyI8m/w+TBOPmk=;
 b=n1dzCHFS341FMFyooplXJvhNxLJfSDL3b3EdhOInwmfryGQYz+i3nbxZb/ZVofRekc
 bjYqz2nVdB/0v6vezWCmpszADOdRPB829XiwiBwS22dI5OpF1zuS5fiw/QuN+6fU39kU
 gZYfWsbQBkqDVhIePEkl7IbX+cteMBIcq/2Xa1/p2nJcA622jDnYTOoQLEJzJWJ1Wcb/
 w13TDOHvlfi3dvxv2cpAWNDU4XVRfQew/h4x/VhlzpM5QdaBpqIgWz0QLT/asmod0UFI
 PG9xVSKQ7TNeWbL4NFjkUCjjHvbIwzskJ5bJMPMFshHuN8e+OgRqx1jH2z14PJZiVqG9
 Kinw==
X-Gm-Message-State: AOJu0YweR4qe/hT7TZxwQEoPTvobkTKftUh+q44ntVPYkIhn0osaKtsY
 SHnPSa6EpAypfQAqD9qFwRN1aITY6NDBWG8JBkgIgB9p/f+Cb1u10VkvCrXKn6nlldDlpu2KWOq
 y
X-Gm-Gg: ASbGnctGgq/e4Ya7AK4zEbTg4SrXT1Kj40xudtkkJOFEp+zHpwb6F6acD/FL3U5u1vZ
 eaWNxrqD1QdmFxWLJzfLnE8eGz/f3lvVe3eTCebTOc/PkLdvqiN8lTHtA4r+SSZMdgEG0YM/1ml
 HofNkjhGBJhEQtbpKzY6GvsNgknz3tlW3XxnCmhs5BEhcqzaLVD37tA+h52YG14j+R7W66cHuDK
 uY9lw6h20SeXuiIiLG1ktgz3nJFD7UErXlkfldAvcXJo7/jxWEMc+Iopur6eKBIXQM6ic77VwQ=
X-Google-Smtp-Source: AGHT+IHzMNN7aV5xcrXbAN7CC8WUe/GABE20Yoos2TvcKCwWvDR5fJAkGlSt1EvGBPpDtcULvsczKg==
X-Received: by 2002:a7b:c3d9:0:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-4365c79aa7dmr74714645e9.13.1734711467891; 
 Fri, 20 Dec 2024 08:17:47 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e1bsm4396653f8f.31.2024.12.20.08.17.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/59] accel/tcg: Declare mmap_[un]lock() in
 'exec/page-protection.h'
Date: Fri, 20 Dec 2024 17:15:16 +0100
Message-ID: <20241220161551.89317-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Move mmap_lock(), mmap_unlock() declarations and the
WITH_MMAP_LOCK_GUARD() definition to 'exec/page-protection.h'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-5-philmd@linaro.org>
---
 include/exec/exec-all.h        | 17 -----------------
 include/exec/page-protection.h | 24 ++++++++++++++++++++++++
 accel/tcg/cpu-exec.c           |  1 +
 accel/tcg/translate-all.c      |  1 +
 accel/tcg/watchpoint.c         |  1 +
 linux-user/flatload.c          |  1 +
 target/arm/helper.c            |  1 +
 7 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2e4c4cc4b46..b5ea607cf45 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -27,7 +27,6 @@
 #endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
-#include "qemu/clang-tsa.h"
 
 /**
  * cpu_loop_exit_requested:
@@ -520,18 +519,6 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
 }
 
 #if defined(CONFIG_USER_ONLY)
-void TSA_NO_TSA mmap_lock(void);
-void TSA_NO_TSA mmap_unlock(void);
-bool have_mmap_lock(void);
-
-static inline void mmap_unlock_guard(void *unused)
-{
-    mmap_unlock();
-}
-
-#define WITH_MMAP_LOCK_GUARD()                                            \
-    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard)))  \
-         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
 
 /**
  * adjust_signal_pc:
@@ -585,10 +572,6 @@ G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                                      uintptr_t ra);
 
 #else
-static inline void mmap_lock(void) {}
-static inline void mmap_unlock(void) {}
-#define WITH_MMAP_LOCK_GUARD()
-
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index c43231af8b5..bae3355f62c 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -38,4 +38,28 @@
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+#ifdef CONFIG_USER_ONLY
+
+#include "qemu/clang-tsa.h"
+
+void TSA_NO_TSA mmap_lock(void);
+void TSA_NO_TSA mmap_unlock(void);
+bool have_mmap_lock(void);
+
+static inline void mmap_unlock_guard(void *unused)
+{
+    mmap_unlock();
+}
+
+#define WITH_MMAP_LOCK_GUARD() \
+    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
+         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
+#else
+
+static inline void mmap_lock(void) {}
+static inline void mmap_unlock(void) {}
+#define WITH_MMAP_LOCK_GUARD()
+
+#endif /* !CONFIG_USER_ONLY */
+
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c13f4a7cbbf..f82870a1e2a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "exec/page-protection.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a8b24be0b96..d586ac9bb1d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -44,6 +44,7 @@
 #endif
 
 #include "exec/cputlb.h"
+#include "exec/page-protection.h"
 #include "exec/translate-all.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index ca641eb95cf..8923301b8b8 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
+#include "exec/page-protection.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 0e4be5bf44a..d5cb1830ddf 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -34,6 +34,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu.h"
+#include "exec/page-protection.h"
 #include "user-internals.h"
 #include "loader.h"
 #include "user-mmap.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 146ddf06c5b..449e69a6e39 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13,6 +13,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/helper-proto.h"
+#include "exec/page-protection.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
-- 
2.47.1


