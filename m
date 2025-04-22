Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DA4C369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JTH-0006xc-Hg; Tue, 22 Apr 2025 15:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSO-0004Kq-Hp
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSL-0007Na-9A
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223fd89d036so69496175ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350735; x=1745955535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQbPDTOsf1VGzqz8fPGND6jRUNUvO1vNZUX54zef5RU=;
 b=IoV8JGA0xFDvLDkIcvKcEBujqUkk3Pldn5lLpPcGeUwNyL44H9McsU6cVdnosz9W7o
 Sjsi3yCfQaKZXgnALslNVtbbWopyHPb/8Kv15zKfT0nuCucuE0OlQHmAI1aSpfGtUckN
 6gqhg2WbkWutYHIJkXDy/8ZrzcksYDQAZBdoHRhTvikEr3M2R4xyK/EYJMyXf7YtVtwS
 T8LvXdv1OKUB8YV8kiPMAn8ZGXaKAZ5id4W2nj/Gz5/vSTfhgW/KzF6dg7htDZ0JuiEY
 pouV+68Ou/zJiciqkjeS3IEimdWwtZ4yPwbmEqH3RXFoY4CUkSkZYpif1Lm+nAeJe2rw
 OUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350735; x=1745955535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQbPDTOsf1VGzqz8fPGND6jRUNUvO1vNZUX54zef5RU=;
 b=QqUGEovveGvQzIGiqGA1DZTXUlxcMvmrcy03cfpsu8XjkzI9bAUgpQxc9OWMLkxy4V
 K18kVhxb6ewAdEbcKjdwVl7yJ804YtxLMOTQ+HjV27IaJ2TNRDZQ6+9T1x6ShIvbYoan
 Zg3u+4BkgyjjFmkcMHeYE3leR51R59SQs5u+iGnx3RPlbpobSAxA1hSfCaEkZWUUpNHD
 cXRk/dWXhLwl76CnDkqkCwZSvZDI9XEqE/N0YrkxtfJdZ9ifOHhDa10ih/4R4Z2iiepd
 VXra7qa8xEVk7BkkHjmV/OhvL2jKCBEiDBCc2Y9XbNnzzRJ/mt9WR5wWyVgWNlJYSTJ3
 fL1w==
X-Gm-Message-State: AOJu0YwoxZjdWWfpLoTeFCqJyhDYmzeiF/1JBv224Yj3Mv8FuTA5HI5v
 ZtTs1eTcBbAzkQdjO/ErS9uGr4jPuXK7WLSAbAuD0knqK8Gg3CliGTtcxy4aljPzg+8gVwuOypQ
 1
X-Gm-Gg: ASbGnctfmPt8nN59RWJHGX494n+wu7ZzW2rbfiDt2A3D0aZPSh/IrwDFj/WMR0jNWm2
 EnULWKq5vVP6bGL4E+z/ZndGIgbHWM2FLYJOrU9LFjPeXMFA8ODYRzm43lN+C74rW952nJ9vXzS
 QSXmMcdJgUMgpVBuHYbIGRQEU5e+7Ute3pRWI09Hwcl1Dyn1ikYnS1VXUkPVDMzToUHi6DzUS6i
 y8Dsvcj5ovEM1ShCG62YyU6H/dAg0tkxms62iey6sUfCHCQdC/zNOrytMO1Oosx+Xa7TP5OW940
 mExAOEMKA98ULXTAAVTx+2oPO8ZbAhPrW/rvhfgt4dIYOYZRGIHM1hRQSiMFP6b+wV2HvNFbRRs
 AMrgGbc4NYw==
X-Google-Smtp-Source: AGHT+IFf2Y7o6LVSkeTFe4oZhXkRnK+BtKsY6d5x9iVjhxXhHJxFK9LrFKX9ox8ulCNPY1joYt7bPw==
X-Received: by 2002:a17:903:19ed:b0:224:1c95:451e with SMTP id
 d9443c01a7336-22c53607dffmr241060035ad.33.1745350735396; 
 Tue, 22 Apr 2025 12:38:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 143/147] tcg: Convert TCGState::mttcg_enabled to TriState
Date: Tue, 22 Apr 2025 12:28:12 -0700
Message-ID: <20250422192819.302784-144-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


