Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B06C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ShS-0002b8-1s; Thu, 03 Apr 2025 18:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sh7-0001w3-SK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sh5-000426-Tr
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so9298745e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717949; x=1744322749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxLf1qzYlIt55rERNGlTsLbACYfcGvHkqll/jBxBAw0=;
 b=Korbj5vGBxWX9BDYVIQewZSH1rVYwet+rIbrpzQHjqSm/+bqSzMivODE96hm7OS8BR
 VQnaj+8iG7yfyXE8stsAvQw8Ec4N3bTLO0/QjXyJ8W9UuI+eCH2XL9OSm5T5MXBSMIA5
 YIY9MJi58w0pzs6J2VZKAQ3Mg4Svt2lJEbKyUHwbLaivWEcO0qDB9lKPU/2xcd8oqihR
 0gMRv1YjsUpmoI38xU7t/ta2hRr7YUd4tiI4htJIL1wu0zlXqvZR7zus8wVDLSfR/1gz
 QfBOfS3etmmVRdNdGCZZt/OXzajWkaUB9h5Fp29Xl5AXLPF8M2f9RxpV6PPrTcG5OGbu
 3jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717949; x=1744322749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxLf1qzYlIt55rERNGlTsLbACYfcGvHkqll/jBxBAw0=;
 b=PGqyzNDk+RSpZHulXvFsB2KgX0IUktPG9q3TZ6Kb8tt58qhT5aovZrRl2FZBE8SdjC
 MKUIpHu/+mbROHYK98tHeUKYGY+XKK09DzKE571B0iWv1TsUS/U1U619mnYe+PFt6rN6
 4rvq9GJGeeKd2nFxQrC/JJiXzT+m0Pa8SNsPpS5TlovDAJgyYKMsaqguM6zRx0Szfncj
 6lRK2RSd6v0e94PhhxEEZ8YxldOhAplNkOX7lxLj8O+Nz0mKa877aYj5CbL9+B6IbL/d
 ho7eM5SYLKH1AWhsDhJZID92aBtALHphRdMOZ6lTX20h5KivMbokiwGrw1nHZUVLtrDV
 /yQA==
X-Gm-Message-State: AOJu0YzvTZmx7d1LyB7fudSnSacWotjoKJrQgfGWG1y3GXzW857PPabD
 69VeKk2J4CkQLAh+oWVwdFi7m2oEraRgp2jKIHd/WK388tlNI1UhGlvh1t1L+4ijV/Luj/5HYMy
 V
X-Gm-Gg: ASbGncvZD0w0GdSA0YbeLCMSZHvSxLdRyvryxBral/UCUFukNotepefb7wI2/vLLhEl
 Ue+ZQA2ffrZTTkEGWwsyLjtKdmCH3eA6D5e8bJaN/cqCurInTDcgHgYS1YkGxDC6lsCqHr2EutL
 VBstbrEaj5JOwimlFa1fMRvUuB/oezUpKsUnToK2qrXn1JI/bXuKIFRnCY8gLXAKaVXGHCfRgFg
 IE9vzSzgV170dW9I5NRkDjUI97ScjEnxLkHw8Bu96ZUUfXWGBJdhgFoFqTL5KGGjOFg8fXT/p5K
 5DCIpIrtGw7GjMF8RjFz8Hr2neiSdLz5mn8XDmZMMQIoM2Xoxg2UOHNxCftdBg13yvcdceEJqwh
 tbadOrYZkpv0MyhWH04dWQfCN
X-Google-Smtp-Source: AGHT+IEIKM/8xkF+LYo5ZYm1WjaaDxmRkXTk9PYtSPPcMLEExJcSefuw7IN92/fEkI1es6ZrCKF4Wg==
X-Received: by 2002:a05:600c:3c8d:b0:43c:f5e4:895e with SMTP id
 5b1f17b1804b1-43ecf841d5dmr5406035e9.1.1743717949557; 
 Thu, 03 Apr 2025 15:05:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a3dfsm29444105e9.4.2025.04.03.15.05.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 17/19] tcg: Convert TCGState::mttcg_enabled to
 TriState
Date: Fri,  4 Apr 2025 00:04:17 +0200
Message-ID: <20250403220420.78937-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

In the tcg_get_thread() getter, consider AUTO / OFF states
as "single", otherwise ON is "multi".

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-all.c | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index b8874430d30..15d4e9232ae 100644
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
@@ -70,37 +71,10 @@ bool qemu_tcg_mttcg_enabled(void)
 
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
@@ -118,7 +92,31 @@ static int tcg_init_machine(MachineState *ms)
     unsigned max_cpus = 1;
 #else
     unsigned max_cpus = ms->smp.max_cpus;
+#ifdef TARGET_SUPPORTS_MTTCG
+    bool mttcg_supported = true;
+#else
+    bool mttcg_supported = false;
+#endif
 
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
     mttcg_enabled = s->mttcg_enabled;
 #endif
 
@@ -147,7 +145,7 @@ static char *tcg_get_thread(Object *obj, Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
 
-    return g_strdup(s->mttcg_enabled ? "multi" : "single");
+    return g_strdup(s->mttcg_enabled == ON_OFF_AUTO_ON ? "multi" : "single");
 }
 
 static void tcg_set_thread(Object *obj, const char *value, Error **errp)
@@ -162,10 +160,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
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
2.47.1


