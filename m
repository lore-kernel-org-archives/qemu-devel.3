Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023E5C3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16AG-0001Pw-TJ; Sat, 05 Apr 2025 12:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16AD-0001Cc-LG
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16AB-0005Is-Se
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so20278825e9.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869670; x=1744474470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxLf1qzYlIt55rERNGlTsLbACYfcGvHkqll/jBxBAw0=;
 b=Ez0pbWsaUQeVmAt9Uk40HXZpmgmhQvKn/9W+E3QOOzU7E85awwFswKecp8WdOe3ykF
 fimhQrxZJAjynvs9ebJfUx4VHZQt0QHj7SktMywuMPSRA31iAnX7AkjISByavi16QMbQ
 rDnyIvqyHZFtxQXzFGY77mPv59eO2VNPTfYBTrNbhn+KkxQsuF4Yo8gJ1gyo2nSXWgW9
 hngaviN7jami2TwDSWx15wUErGX73TChkgmrDGj5cm5hDN1cJLN4ZcoB31XayWtUYhzr
 iWipUEeuqc+te+idQGFfMiqjgECGHkRB1jmBRmeBjyall/SLv96lSy8uVIoHqxGkxLct
 oGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869670; x=1744474470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxLf1qzYlIt55rERNGlTsLbACYfcGvHkqll/jBxBAw0=;
 b=VY+Y/pMS/P+dpywdIYy/Z5SrEVBZoq9U0Mdb+hfBUvxH6CO1agv3EXRSrMZSoE8jT7
 4NiGUaGfJGyQZgz78KzAYSPy8PUvZjonBdnqeX7mUzJECglTOkoBQ0y4vRkk5Ng7W9Tt
 EaEUfqJrQfA6WeKB9k9F70xEx2wOa0X/E2zCrzW/g3B3G11PzRSISe6m/IhEteGuowLP
 TVsvLL9kDS2iyYuElGNX9KYRW2goWR8MS8mpZ0y4Zgx0mY56m4wBTo/J2KbltmpV8kMz
 wcCzoOR2sY3H7G4hydfFwVOI+L/FeEcXqi6gYBvA+4YLOwPjNOo1dudWZvrmTv7qMwRq
 f9Iw==
X-Gm-Message-State: AOJu0Yxdpoatl3gtJhp1oYLRtJdaVKFtMRCIkpoXIbMYW8/4uvLLy9Yo
 Bl49xqyGGga0nnxBkCzJTCrYScjbkpaPE6LcfCifr0gJT81Zm/X5hYQKUKk54PYI4Eauyf8sxDz
 W
X-Gm-Gg: ASbGncuzyx++Tns9SFqvXNSSLS7A8OQZOl2SU7MrIktw0B+rW0yVNCT77KqIk++mA/t
 wgzHgGLXXPj1BfgQykRJ6/3TAOqAoNggwjFhjfGSCtkw8A2FHn8pMKu21MVIiQqDlsx4bPdIqzn
 kC0AE9FgWjH1VzKpmbvy2YTkjnDl8HpEJLwsB4eMjutfwxa7iLx8eDPCezKtQVRW2dwhJJgtBlx
 YNHNSJlUHTVNDGirCuKZ7GB3i9oiDYxXQR9vNmCfeTkJ48KN9iV1SBS97Cx8LUIT5TtyGvK4e4H
 NCd/BVkkHsKbvBygbf9ZYIDrSzwnSjIE0qSA57703JcbuSaIvmYO+XGDHBhLAAll98JwJtSjHsS
 4twYYH8QYnIa8SG+K22B4TumJ
X-Google-Smtp-Source: AGHT+IHwMl71qxKC7xyYfvRdL+hL2VXjUKCRU0Gacm10ZstFUEus151D3Ek3ipHqZmceQFGwUibwUg==
X-Received: by 2002:a05:600c:b89:b0:43d:7413:cb3e with SMTP id
 5b1f17b1804b1-43ecf81bb90mr61366455e9.1.1743869669840; 
 Sat, 05 Apr 2025 09:14:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630de9sm79905905e9.1.2025.04.05.09.14.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:14:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 v4 14/16] tcg: Convert TCGState::mttcg_enabled to
 TriState
Date: Sat,  5 Apr 2025 18:13:18 +0200
Message-ID: <20250405161320.76854-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
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


