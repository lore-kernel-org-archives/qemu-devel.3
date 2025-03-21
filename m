Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DC9C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhD7-0007m9-JN; Fri, 21 Mar 2025 14:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhD5-0007iQ-Kg
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:35:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhD3-0006U2-Q4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:35:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so15846105e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742582108; x=1743186908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFcvKnJ/OFG2ddpHAkQ7xN+mVhKOeS5fntJYMy/mG4s=;
 b=xpWIMQvXs5RD6ulV9hmLgxn9TOZc6OpCLBNnoeu0WG3e2/CrG1CyVfXm+Z9mNWaQtX
 wRi/dynuCljDfKBoBKHgW92xkUIRP2MvJcruZpSx0aFCeuJAtE5oS5Da38UgqxIhU7yT
 8/DhEENVmIRYo0gPU9S0rCfw9+Z81FFytsMb9Iu4vZE6azo6sAxXGsgVonj0q864iyzl
 kjIL7JY5LkY2k50I0uqjUN5gCFissj/Z8JuaDbOzJ5vXdHi2b8AzR2QXUMWxHCzIoTqK
 48J8m0E2PeeRA4i26bIIGtuDNYrYGb1RbucRbvWdSut3P/mZq62nw1fBYtpHZNZAwjuF
 Ymbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582108; x=1743186908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFcvKnJ/OFG2ddpHAkQ7xN+mVhKOeS5fntJYMy/mG4s=;
 b=Nuvb0um0A64TI9RH3g/yQCwQwj2C+JfQM8CcClp+OeGF0VY/FD+I4aYKBanGhg2jLs
 ylLYkGuu8iQYg01vEuUixjIBQCEbzDdUx1O0G3a9lYz19cMKW8tU6vG1zix7x5bGZKsD
 T10falOyI4Z1xumbe1JX8LKFwSIYkNyILDfc3v9cjs7wAmZq18+6MiyNEMY6Kh1lnOGL
 W1DcuOBdP3S40ySfiWyjJB01Od7gTrrf28WrfGHfn9QSYpqt1iu9nYF4yKH6QGUVMYiT
 ifYbV5vWPbEV4V0vE/+hCKukQb1XeWdtxrRj3juJmdBovbc+9MJe/o1bMvoaPXiTf7fs
 kyKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9FVMy9VjxcLjDn7E78akAsC3JRDTnvyzlHcxTeNol2Jc56W+Nj/N1DaK5zmLXPgQ+mYiB17AN+GgW@nongnu.org
X-Gm-Message-State: AOJu0YxM+UgKBdc6OwXKgScOhIJEiONCdGvbpSfolW2BhGyyrS01sxMV
 Q5oofmErhjoeZCjB+1koiTt/lbFtVMFO+kFodSBHg8csZpFWhquTVDSj0VCBhwM=
X-Gm-Gg: ASbGncvoSB0EBw4xTIzOSbdXQ9xx3E2JgIn+a/foVnqmvWg0BpoNueBBkN9h+1qUcoG
 oBQnJ3WA2iAtr6OglsafqwffaIv5sWqa7S5u1J8x3SoBrO7v752ycDsWXnDqblJYZl0/vJW2NHO
 xoP6SEDYC1bIl47FEq8Pd1N1/UHiBHdWjFXhjE6y2YhmHBBr6FjSXVT4HRXU5ZvKpaxn+pHmgk0
 GijcrHjgNU6/BT94QbAq5vu6v9f35odNyBxMhPfxeIre6zjtSKh1t7MjqTokkkxKS4638PVQ1/8
 MOveRF9mWl9SjFpCnFkib/bsVaalK8kRxL8498ADL4GXCaYexuE0cAkdJB8NIukxVV+iSIkNUhc
 qQZM5+7oIe0PLoR7gIRU=
X-Google-Smtp-Source: AGHT+IGkJXYCNsy3XUoMtNTMRt9NvqXuPnF+QZaRF9vloL+Bm852shcR36Rn6ubeyG9TIe5VBEOTRg==
X-Received: by 2002:a05:600c:3b95:b0:43b:b756:f0a9 with SMTP id
 5b1f17b1804b1-43d509ea96fmr42703105e9.11.1742582107598; 
 Fri, 21 Mar 2025 11:35:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f99561dsm3097827f8f.12.2025.03.21.11.35.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:35:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 3/4] tcg: Convert TCGState::mttcg_enabled to
 TriState
Date: Fri, 21 Mar 2025 19:34:48 +0100
Message-ID: <20250321183450.3970-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321183450.3970-1-philmd@linaro.org>
References: <20250321183450.3970-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Use the OnOffAuto type as 3-state.

Since the TCGState instance is zero-initialized, the
mttcg_enabled is initialzed as AUTO (ON_OFF_AUTO_AUTO).

In tcg_init_machine(), if mttcg_enabled is still AUTO,
set a default value (effectively inlining the
default_mttcg_enabled() method content).

Instead of emiting a warning when the 'thread' property
is set in tcg_set_thread(), emit it in tcg_init_machine()
where it is consumed. This is in preparation of the
next commit where we replace the TARGET_SUPPORTS_MTTCG
definition by getting the value at runtime via
CPUState -> CPUClass -> TCGCPUOps -> mttcg_supported,
so we need an initialized CPUState -- which is not
possible at instance_init time).

In the tcg_get_thread() getter, consider AUTO / OFF states
as "single", otherwise ON is "multi".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tcg-all.c | 69 ++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d75ecf531b6..f83f9b9d79e 100644
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
@@ -68,37 +69,10 @@ bool qemu_tcg_mttcg_enabled(void)
 }
 #endif
 
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
@@ -117,8 +91,37 @@ static int tcg_init_machine(MachineState *ms)
 #else
     unsigned max_cpus = ms->smp.max_cpus;
 #endif
+#ifdef TARGET_SUPPORTS_MTTCG
+    bool mttcg_supported = true;
+#else
+    bool mttcg_supported = false;
+#endif
 
     tcg_allowed = true;
+
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
+        if (icount_enabled()) {
+            s->mttcg_enabled = ON_OFF_AUTO_OFF;
+        } else {
+            s->mttcg_enabled = mttcg_supported;
+        }
+    }
+    if (s->mttcg_enabled == ON_OFF_AUTO_ON && !mttcg_supported) {
+        warn_report("Guest not yet converted to MTTCG - "
+                    "you may get unexpected results");
+    }
     mttcg_enabled = s->mttcg_enabled;
 
     page_init();
@@ -144,7 +147,7 @@ static char *tcg_get_thread(Object *obj, Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
 
-    return g_strdup(s->mttcg_enabled ? "multi" : "single");
+    return g_strdup(s->mttcg_enabled == ON_OFF_AUTO_ON ? "multi" : "single");
 }
 
 static void tcg_set_thread(Object *obj, const char *value, Error **errp)
@@ -155,14 +158,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
         if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-            warn_report("Guest not yet converted to MTTCG - "
-                        "you may get unexpected results");
-#endif
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
2.47.1


