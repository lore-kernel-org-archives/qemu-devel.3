Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFACE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfig-0003EC-Pt; Fri, 20 Dec 2024 11:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfi5-0001Cr-II
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:42 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfi3-0008Bd-Ps
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so1074123f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711518; x=1735316318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWjm7Akn/ztT8yFAoR8wPvndBvcn+hzG6Ss9mzGUhhA=;
 b=LWJKuQExXPS4WJfaYxJpihn1HQ9kwc0Oo9Mh0cN8PaQ2+9NW6UQUNThq/GLs4woSGV
 HwpGEagJlRG/5L8F9LaWXJKki41cRUPnGVQopKB3bMtdvyR46yq79blQ2z1zaCySAMIG
 hY3/cjHnM1Sz3yEGxc3doklVvzwFwDsmCfMJ7F6V7uC1iDRwbHNxv8EustaH9gdZ0Huc
 pgBX3OnUkyF2Fm2fqsO83Fnyqm5BZ4Em1jFPkkWNfTsrdyEGWUAfscsW0H3USB/tvebQ
 +aLpvo3azP8KATkyM+dWpWcO/YowIeKy6A/kUpu4iBb8tPfxcFWe7XdOna7bn9L+LyYF
 XcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711518; x=1735316318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWjm7Akn/ztT8yFAoR8wPvndBvcn+hzG6Ss9mzGUhhA=;
 b=NKJ5+iyF14KDkO48NVnMPclVAPnAAvr5irwFDbEKNLo7O7DOYZ5gWwwX40HS9NH1zV
 aG6B6BEwJ/tQ0cOuB45FkbjF8Wh4L55sOrhVQPAa3d5cUDxHYf/1f+C4yp3jQl7cvwTU
 6hEPgNaP3gfb6gik4uxUcfSZM6wJo3T9exqgzgnDj02igrmYb2RyCYnhdgy/2ElXBUsV
 ryq3OgKi8aUT4nNUSo5RSpNdJTgF97zLNHnZdklSFVDGeXvyh1QY7IE4+/YyDTwZuHkr
 Gz1mx8bpFfnJyilb1glpF0RMt3JmkWfYXpZK1AkXY8Z8T5PKupO2QV8yj2ANVHFAZ2fr
 gmkw==
X-Gm-Message-State: AOJu0YwiRmIFwCOdkU+TFJXFEMdjn6k/ZfwQ9IzW8xcOWTsM09rCd9E4
 xMDlmYHW7IgkFJpQBtCabu2Dv0DGdthVT7KklgSi3quh6xGkPqy8ak+yGPNbckzSnN0cE18zZR+
 K
X-Gm-Gg: ASbGncu3nfZiP7pHwcVlCcNgHhmiLal/CLoVAaNgBkqzD5d+8RkPZk0+u8iGnglT2/o
 bWqUzLrjjJGYGJMSHB/DcpPSbMpflhxjEbL7sUJNwY3inTGw34jw/IK+WHZpzTb2Q4qvtQo44yq
 FP/bXZ4uQErTjpy09pb/GNjI89iO+R3xdFd95E5PdUjVfDi/FNs9pS/IQnnOKvVplclQqIhHvSH
 zRwQiV1gnje44k1sOapPjUdP0hyp4daWOM7ESrz5FPd2Aknk8Mf39YR91EUsu/A2XaTOAzRXnw=
X-Google-Smtp-Source: AGHT+IH3Hyt3DcN8d4r7MVHj/qM7QmUQUIL1Jcwo2QWeDcwzwt9oqu2B4n+v6ASxxiDyG4kSQEc0oQ==
X-Received: by 2002:a05:6000:481e:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-38a2220120dmr3649587f8f.35.1734711518059; 
 Fri, 20 Dec 2024 08:18:38 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e375sm4445881f8f.73.2024.12.20.08.18.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 36/59] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (4/4)
Date: Fri, 20 Dec 2024 17:15:27 +0100
Message-ID: <20241220161551.89317-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Message-Id: <20241212185341.2857-15-philmd@linaro.org>
---
 include/exec/cpu-all.h         | 6 ------
 include/user/page-protection.h | 2 ++
 accel/tcg/tb-maint.c           | 3 +++
 bsd-user/signal.c              | 1 +
 cpu-target.c                   | 1 +
 linux-user/arm/cpu_loop.c      | 1 +
 linux-user/signal.c            | 1 +
 target/arm/tcg/helper-a64.c    | 3 +++
 target/s390x/tcg/mem_helper.c  | 4 +++-
 9 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 73b11f58abb..f7eea33b101 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -126,12 +126,6 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-#if defined(CONFIG_USER_ONLY)
-
-int page_get_flags(target_ulong address);
-
-#endif
-
 CPUArchState *cpu_copy(CPUArchState *env);
 
 /* Flags for use in ENV->INTERRUPT_PENDING.
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index bdd98a37de1..51daa186480 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -19,6 +19,8 @@
 void page_protect(tb_page_addr_t page_addr);
 int page_unprotect(tb_page_addr_t address, uintptr_t pc);
 
+int page_get_flags(target_ulong address);
+
 /**
  * page_set_flags:
  * @start: first byte of range
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 8e272cf790f..3f1bebf6ab5 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -33,6 +33,9 @@
 #include "tb-internal.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 
 
 /* List iterators for lists of tagged pointers in TranslationBlock. */
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index da49b9bffc1..edbcd461bfa 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "qemu.h"
 #include "exec/page-protection.h"
+#include "user/page-protection.h"
 #include "user/tswap-target.h"
 #include "gdbstub/user.h"
 #include "signal-common.h"
diff --git a/cpu-target.c b/cpu-target.c
index e9fc4a5be0e..7a2efa890c4 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -29,6 +29,7 @@
 #include "migration/vmstate.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
+#include "user/page-protection.h"
 #else
 #include "hw/core/sysemu-cpu-ops.h"
 #include "exec/address-spaces.h"
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index ec665862d93..709f718a99d 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -25,6 +25,7 @@
 #include "signal-common.h"
 #include "semihosting/common-semi.h"
 #include "exec/page-protection.h"
+#include "user/page-protection.h"
 #include "target/arm/syndrome.h"
 
 #define get_user_code_u32(x, gaddr, env)                \
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 9b6d772882d..a191e9b26f2 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "signal-common.h"
 #include "host-signal.h"
+#include "user/page-protection.h"
 #include "user/safe-syscall.h"
 #include "tcg/tcg.h"
 
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 35dce4bef3c..b6af2a59d63 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -34,6 +34,9 @@
 #include "qemu/atomic128.h"
 #include "fpu/softfloat.h"
 #include <zlib.h> /* for crc32 */
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 0e12dae2aa8..307388e5bd1 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -31,7 +31,9 @@
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_USER_ONLY)
+#include "user/page-protection.h"
+#else
 #include "hw/s390x/storage-keys.h"
 #include "hw/boards.h"
 #endif
-- 
2.47.1


