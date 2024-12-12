Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C12EE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoMZ-0002W8-N2; Thu, 12 Dec 2024 13:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMU-0002Eu-31
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:34 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMS-0006tc-BC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:33 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725ce7b82cbso1113815b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029789; x=1734634589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYC6oRELj+5ympYW3tq1E6/ibkizwxjQsKp5dy3fobw=;
 b=TZ9lkeo+fvSzeBvkj0/7+BWR6LmVO6ibjtluFKm9u7lvZ1t/a6kEFJfPWehOtBQ1Nm
 TAXj7R2RhpVVYDHyWY/xYoRikLJx1/7gmrJrT7BR71BtsDb1mwxSa6dhmA52bMfIAvlE
 FJIamEuWK3/ZRGsoE/UmkoYuKQoPpHGTMZwRAP7qyxurjpnpYSsQhxR54GgMpNg0pVlg
 LlppeWvOIQQC9JXXqfWAwNGnxMHEkJQspw/8YVCXAYcm8lz8ISIpQKEjI4FlV2QM5/6x
 iTxuOgI8VVG2WYV89ZdvV5FGNjRM58BYev9JDkpaDgQqpI+iwm/CyUV6TRi813BqEkVB
 thUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029789; x=1734634589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYC6oRELj+5ympYW3tq1E6/ibkizwxjQsKp5dy3fobw=;
 b=iLgf0sHNaiwvv4pol1W+Jet9ImOpZMrvoCb9sYEYtnTQV39KeQwPKUB4FSaCeUiEeS
 mh+P4tzkTqcXjc/l1ueeQ2otZu/p5Efq2eNM29n/4PYI1AC98dqS2pOtrBx/x7/2v0tr
 /U2IhFyc3TskQCxXaUsZVjejiagP7Uss/I9vfGsaZkwjuTxc/MW72S1PDDVXx9L0N2lS
 +JQbPrdpob8nTyoUa+HECzKuzJz/aqDo+PcsGwSQ/KjYq/x3DgQjkwzvb4QGk6hclBKp
 FXISgeXIwJdbGCoERjeQLucTuaPrjMcJBwSWb6iW2Mb+NnYJZGlkc1pB57mFOc3a/sk/
 Xm9g==
X-Gm-Message-State: AOJu0YyFgXB5eKZy+wnnwayadthzB+uyJ+/WZ3EaHXNyC6KPaKcUPjEz
 InYiXXtpv70fcgrs0FjBGTk4uqD2BvYTrwFtV4vsD4DTlPxwTOCcrJm8M4utKEvvUpphURE7V+R
 7
X-Gm-Gg: ASbGncvq3F/7jU8psoEXqjvuRzX/fEaMkwTa+BQSMvC0ZCXuzCkrUlHhsSReyIfslH0
 1+HNwOf1IZ9WxVsiJK8dcZ/tyQ+3FAXNtBsQyyCwLxmkTMnlWDHRhYDrXq3CMSAp8Pi6A/5EEzn
 14JWAQ689I+9HSMq5E3H3TtweqsVHzcBnijcSF6TpJ3zlMEjpFgZ+ditj1xmcbnaG6F7QlBQqzx
 Q+j+25yI3F03dMS/q8kv90y0rG/NSg4rAZ3D+9diZMy9svrxphXPl11nw64moSC2NZM4kEX8cac
 2LNaCyjhFIN63IApN13OI1HwqUnOnDY=
X-Google-Smtp-Source: AGHT+IFkU2xkXlA8Y2CzEYBoSsiW8RBj7199k7WmkhLHeDk0U2aEGg9++ya8Sf3VjW0R/4DAYuNf1w==
X-Received: by 2002:a05:6a00:999:b0:725:cfd0:dffa with SMTP id
 d2e1a72fcca58-72906a01c5emr2101090b3a.5.1734029788724; 
 Thu, 12 Dec 2024 10:56:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ceb7c00asm9859657b3a.95.2024.12.12.10.56.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:56:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/18] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (4/4)
Date: Thu, 12 Dec 2024 19:53:37 +0100
Message-ID: <20241212185341.2857-15-philmd@linaro.org>
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
index 4a88f1c6db8..69a49202110 100644
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
index 8f42a28d07b..bc144688dd5 100644
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
2.45.2


