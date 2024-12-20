Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACB6E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiP-0001fK-J6; Fri, 20 Dec 2024 11:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhr-0000d5-SX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhq-0008A8-4P
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862a921123so1493935f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711504; x=1735316304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tifxFPID9bghi7hq01IeGacsDjpsOnZMZbgcEaKOJwE=;
 b=osKZFulOeuNpwsLcCrB7SLydz7WacRnuV/zpSlAhzHnC5PyWiC38sbKMN5RPI2K7uf
 DbAoP7QawN69grfcWM7DhcSvpKqCL1XbF1JvRrr1ojLbqB5WCyGlhn/GY3sARTLSGsOL
 IFRcLdzm3uQTCwawpbxLw951Hm7PDafK6+7aoGuqNUxto0Z6EH60eWAVF1fZPzDuqPey
 Lzxhig/Dm7ZCBflEYxq/M4GJDUUI34UBO5zHGAorPygNLvdFUDT1iwJAnOh1AMuUycXP
 syKfhgW41jzN6RhS3uZg2obl1yOUluQ0EKAlGScnguU0UH66So43CdmLfQt37hANBP2b
 UWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711504; x=1735316304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tifxFPID9bghi7hq01IeGacsDjpsOnZMZbgcEaKOJwE=;
 b=djwxndJOk45j64WgI1a2Yu2Uni+aTEQqxuLeXgPbomxeWgpuOKL+Uo1qTw1RNI0dYO
 wC1/2Cw5IVzNyWs4VzIGIKydKM7In1vYnUyynH/Eus8tXV+4VqvX2swNg1TxM1O2yTcM
 8NeAJN3wLbMr5TnHpGTYyCQL8MiS1FRRqJfn58E+ALQpOaVDRrYaKUsQiYXO+HI08DZV
 odviombrGa53FfbIDCVbhgZ8UBSSnQSmuN1a6QjxIcW5b4pPvFZ6SoOezC98UDwG02zO
 Sf/Djca7f3imcSLR1utZb//sMZOC7wI+cmlGTtiUOC9+JUkwNltLi4zlNKQ2aB2+bd3Y
 M73A==
X-Gm-Message-State: AOJu0YzZysahc4+TZyEqwvlKm8z2eacXY0Agq6TwlRUJ3ERznriP5/5s
 gUeU9zUbNncYta9lntNjDzYa8Fpd/qFjip3fa4eXnSe45DUL2F4hzsed4fh81AFe3MTKYlZKqaG
 l
X-Gm-Gg: ASbGncvSjTb60ql8qylTO5LrSi0vcC8SOA1rEjE3hwoXd8bgMCq5vPB8KUKVQEFFOlr
 CbrjzKKd3gB6oLWCfCL4Jw5DuJ6O+PLwV28vSZPGubuoTNisAk6BQFgXFEGkc25+bG90RiM8B/R
 CehlM+63RnXwBQn98Q3r8YAz540BGs0pdSnCXkWD2tMzE10xzvY/X6Jam2Op6w7AcWjZoTgEk+n
 5zu+jIbezyU7lHXXWj88tOd4uL6Sbd5dEQQMt0XJTsVaBG4mJTmMi8y1Y0D+zsSlUH3OILDyN0=
X-Google-Smtp-Source: AGHT+IEhNsiUTNOMqkuYqQsbDql0+svXU9BGupJUsxZRmHyUuPSV2y0GVvhV01a5sl6WBwZsQ9Yo7g==
X-Received: by 2002:a5d:59af:0:b0:385:deca:f7cf with SMTP id
 ffacd0b85a97d-38a221e1ff0mr3295515f8f.8.1734711504479; 
 Fri, 20 Dec 2024 08:18:24 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847513sm4416421f8f.49.2024.12.20.08.18.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 33/59] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (1/4)
Date: Fri, 20 Dec 2024 17:15:24 +0100
Message-ID: <20241220161551.89317-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-12-philmd@linaro.org>
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
2.47.1


