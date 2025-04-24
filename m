Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AB5C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kz9-0000Cv-6w; Wed, 23 Apr 2025 21:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwz-0005X4-CP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kww-0005Y0-JS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so368648b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456421; x=1746061221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQbPDTOsf1VGzqz8fPGND6jRUNUvO1vNZUX54zef5RU=;
 b=duTURFy9CFWrGJPtMOMa5nD9lxtu9Ts9XEY7Y4TnfIjYtMgFJ6bO59zT6VQkKh+DiA
 T2LYF3n5m+mJNeL1k8/z0jf9sZX0THkjkpMGBSE+d0fObmhyb1maMEjec2DS+O44f5Sq
 vMhZGpvC1qTN4cTNAKRzLNdeMxJaLlndpCn0iz3mTFvwdDNdGjKechfQa5DtsmA5ZsOE
 p18f5KV9GKB/WE40vrLfE+FhSBtHnXxwlUxW9m6VPNeXQn5S+qbtt0rO+GHka1MBJvXH
 garjCCz9O4KxrO7CamwrjMpGQ3bBjOl5NL3hVsROf3B71xoX9jp99OvtFf5NLMMtayxc
 iYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456421; x=1746061221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQbPDTOsf1VGzqz8fPGND6jRUNUvO1vNZUX54zef5RU=;
 b=nmpm/wVe8cBzYNHOoC4a8ObwvKbrTqm1MNbOUAHOe77aNvSxgSAazjoLwx8CYn4gZb
 wP34SNN1vteI9VqXn7zZxa1ORipcNK0PdQU+jXph0WPSilZm5b5OQ+24z8qbNvumTxPd
 QOmQogMxRCiMFTc0DWbhHPbPATMM3zrLpIO8iN8NcZTL0y2ne7SjBqTs3eVJbRswiiLn
 TKSTQhShRNdBXQRzzJqjRrKu/tZIDWpu2HTbwNsKpVGqNMxZc0ipeVgJrpci5qmThObn
 ucOx6SvDqXlFCRvYwHS4F3kAZSsPH0CxFriLDPrP9HlaHFooBmis8yaOntl3izDgkG/r
 orzw==
X-Gm-Message-State: AOJu0YyBE7Yeaw5VjoOE7yP0NhbffSC2cbpnAxtVZHAesOn4iuja8qUP
 IHsp9N5XYv1j1/utG23NHnMAP0kWs/hB/bw7kOg1qDqE3SsKTob9zfqQzRL+/PUzRVLiM/0xA72
 Y
X-Gm-Gg: ASbGnctvdT5yLT9/N4mMXo7MuTD5O7NmyamPjD70yPG7rKyGYn97Y0XCdae2ZUFGMc2
 MfY79zACwe4hDMye8EPtbYG7ktCdtvMkAyrcQWDhEs0KGJ+WywXyKQx9llhJvYzYyesO7e4PUFU
 nUSDg2oARAMhMXzXAdex/Zrbymsb4Bkq/nUs/mW7PskgWJlx6EWz+28QTVptS/C9CaXORXTpCMh
 KzoYst2xYBSnmGH5yW6F6DIBgPbGar0yqP3ZrlHkjGsHvDfFptCxTi6j2CoiECLWYiyBh/06crO
 8vb/bJKkB+nieVRtavmI2kKXkDtCDAQi7tCHVQ6WfFsVIzUJ4Q5URRx/Q2X2SyZoHULM88nyzZM
 =
X-Google-Smtp-Source: AGHT+IGbRpSgqVxcqBk5UNegtGTslVMl8C1O5fday4o5yoP9OVs2uiwZewOJm6skzdteWdFkeazgKQ==
X-Received: by 2002:a05:6a00:9287:b0:736:546c:eb69 with SMTP id
 d2e1a72fcca58-73e245e3df6mr949176b3a.9.1745456421102; 
 Wed, 23 Apr 2025 18:00:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 144/148] tcg: Convert TCGState::mttcg_enabled to TriState
Date: Wed, 23 Apr 2025 17:49:29 -0700
Message-ID: <20250424004934.598783-145-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use the OnOffAuto type as 3-state.

Since the TCGState instance is zero-initialized, the
mttcg_enabled is initialzed as AUTO (ON_OFF_AUTO_AUTO).

In tcg_init_machine(), if mttcg_enabled is still AUTO,
set a default value (effectively inlining the
default_mttcg_enabled() method content).

In the tcg_get_thread() getter, consider AUTO / OFF states
as "single", otherwise ON is "multi".

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 74 ++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index b754f92905..fa77a4c5a2 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -32,6 +32,7 @@
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
 #include "qemu/atomic.h"
+#include "qapi/qapi-types-common.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
 #if defined(CONFIG_USER_ONLY)
@@ -47,7 +48,7 @@
 struct TCGState {
     AccelState parent_obj;
 
-    bool mttcg_enabled;
+    OnOffAuto mttcg_enabled;
     bool one_insn_per_tb;
     int splitwx_enabled;
     unsigned long tb_size;
@@ -63,41 +64,14 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
 bool qemu_tcg_mttcg_enabled(void)
 {
     TCGState *s = TCG_STATE(current_accel());
-    return s->mttcg_enabled;
+    return s->mttcg_enabled == ON_OFF_AUTO_ON;
 }
 #endif /* !CONFIG_USER_ONLY */
 
-/*
- * We default to false if we know other options have been enabled
- * which are currently incompatible with MTTCG. Otherwise when each
- * guest (target) has been updated to support:
- *   - atomic instructions
- *   - memory ordering primitives (barriers)
- * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
- *
- * Once a guest architecture has been converted to the new primitives
- * there is one remaining limitation to check:
- *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
- */
-
-static bool default_mttcg_enabled(void)
-{
-    if (icount_enabled()) {
-        return false;
-    }
-#ifdef TARGET_SUPPORTS_MTTCG
-    return true;
-#else
-    return false;
-#endif
-}
-
 static void tcg_accel_instance_init(Object *obj)
 {
     TCGState *s = TCG_STATE(obj);
 
-    s->mttcg_enabled = default_mttcg_enabled();
-
     /* If debugging enabled, default "auto on", otherwise off. */
 #if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
     s->splitwx_enabled = -1;
@@ -113,16 +87,40 @@ static int tcg_init_machine(MachineState *ms)
     TCGState *s = TCG_STATE(current_accel());
     unsigned max_threads = 1;
 
+#ifndef CONFIG_USER_ONLY
+# ifdef TARGET_SUPPORTS_MTTCG
+    bool mttcg_supported = true;
+# else
+    bool mttcg_supported = false;
+# endif
+    if (s->mttcg_enabled == ON_OFF_AUTO_AUTO) {
+        /*
+         * We default to false if we know other options have been enabled
+         * which are currently incompatible with MTTCG. Otherwise when each
+         * guest (target) has been updated to support:
+         *   - atomic instructions
+         *   - memory ordering primitives (barriers)
+         * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
+         *
+         * Once a guest architecture has been converted to the new primitives
+         * there is one remaining limitation to check:
+         *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
+         */
+        if (mttcg_supported && !icount_enabled()) {
+            s->mttcg_enabled = ON_OFF_AUTO_ON;
+        } else {
+            s->mttcg_enabled = ON_OFF_AUTO_OFF;
+        }
+    }
+    if (s->mttcg_enabled == ON_OFF_AUTO_ON) {
+        max_threads = ms->smp.max_cpus;
+    }
+#endif
+
     tcg_allowed = true;
 
     page_init();
     tb_htable_init();
-
-#ifndef CONFIG_USER_ONLY
-    if (s->mttcg_enabled) {
-        max_threads = ms->smp.max_cpus;
-    }
-#endif
     tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_threads);
 
 #if defined(CONFIG_SOFTMMU)
@@ -144,7 +142,7 @@ static char *tcg_get_thread(Object *obj, Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
 
-    return g_strdup(s->mttcg_enabled ? "multi" : "single");
+    return g_strdup(s->mttcg_enabled == ON_OFF_AUTO_ON ? "multi" : "single");
 }
 
 static void tcg_set_thread(Object *obj, const char *value, Error **errp)
@@ -159,10 +157,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
             warn_report("Guest not yet converted to MTTCG - "
                         "you may get unexpected results");
 #endif
-            s->mttcg_enabled = true;
+            s->mttcg_enabled = ON_OFF_AUTO_ON;
         }
     } else if (strcmp(value, "single") == 0) {
-        s->mttcg_enabled = false;
+        s->mttcg_enabled = ON_OFF_AUTO_OFF;
     } else {
         error_setg(errp, "Invalid 'thread' setting %s", value);
     }
-- 
2.43.0


