Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6A7C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Yr-0007hw-9B; Wed, 02 Apr 2025 17:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yj-0007bW-2x
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yf-00047E-Vx
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso1742015e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743629016; x=1744233816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WxLf1qzYlIt55rERNGlTsLbACYfcGvHkqll/jBxBAw0=;
 b=fIBI7JHX9aw4l46E742fvelieY7vOIHfsz4EM0Nwzmo77TgDkURAqs06fFX3qivW2X
 Sm8eqGihKjVxxji+ZD5MkArxfijJisRtcV8lpk9HmHbthSlGTLKTbhBQiA69j2yVqOSl
 WhkpxNYrFhddFH1dstYvacWbUACZ6HOIYZYBMvzsdHTtujl7rDu3OizGVNynLyWqxqH1
 Y8bNpZ2GWqP9jTpM1rwoSTU8Z6nPPzDPP7i/NRhR2a0/z9dnodTO7vo7L4gnIt67SB7o
 Vswc497GOq9dQuKqgpitq6U6XnvpT9kPtp/MW9hMfMwdBUli3poKSL24HNO+rUQm6Go2
 Vxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743629016; x=1744233816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxLf1qzYlIt55rERNGlTsLbACYfcGvHkqll/jBxBAw0=;
 b=k0ZBuW583K98BU0wbZGi+hsQbqj+mSrBD4wAc3id4+F7h0EGYQcwtScYxs/NOitOkV
 jEG9t6sqs8gluRe9MIF190wxnOrr7XIIAd4v6RemtYAIJXCbvZsIU9Kb4+O3q0qGREdF
 srJ8JmXKfmuJj+fmgRHXCB9Rndr7Qfnwd/SDGdcz3/FtNyQZhnu7dj0PhmFwBi77yZmy
 5aPsdoFM9knFEtAXnm8G4JHhaFBKXPG253T/P3JqjrXN3iuVYpXXcpi2pDD+92sY0sdn
 6M4T3tyUmYE+jBz0ZPy+2mX/IsNi07IGbyZiZDFn9GjkCDZpFr5f3YRUmS7GecWtp7RX
 Abbw==
X-Gm-Message-State: AOJu0Yx17MYpGKpI/7Tysd4TL1YzGBPZgQF9WM/a56uWshHgKs4G6vq9
 00kPNZUaBpOmcjSsp9hOxoYzLeQ8b1dt+P53ElD0+FInX1RR3fRflx30SaILPshvIVRMimSSN0y
 /
X-Gm-Gg: ASbGncv2wZPp4D7ObXTQSXINDuUaNTZymodbNYC6IZaXbA/2UR4k8OGyuKqT5gN6U/m
 ne10y5SyO7Wic5lKKu0gl1xD9n0nylO3c65XE1D9b91dFTtLrDqeXa1s4LbeT38Nv2ZaM4ycUAj
 QRgTcz0V228Z04GR+i+oRPF36jtpsK4aSKBg6zuls5vVbZQtwSNip8Ii9s3wTM2JCWspekWQ7a2
 D1elpqEit5/3fCjAihy2qt3HXOHC37w7AghSyZj98lGsmUhfUPHbMYDAnO1MUBrpAAwDwf6m2yU
 BpdnsRjsoJ6e/MO1r3nM6YU4FQtYeb3FBz/hrOfRI0AD5rKs3tMg4sP2iuBzozOFF4d242jUzGc
 Gdz6GquHj1xFK2RPWYok=
X-Google-Smtp-Source: AGHT+IHLL6RFBQPBNnUVMVfb57wpF2vtxSlSMHTgC+dapLCL7800ZwY++A0USQLDIaQT0qjdQPcUkA==
X-Received: by 2002:a05:600c:1f17:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43e99ab533cmr160367475e9.0.1743629015915; 
 Wed, 02 Apr 2025 14:23:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16313edsm2515875e9.6.2025.04.02.14.23.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:23:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v2 40/43] tcg: Convert TCGState::mttcg_enabled to
 TriState
Date: Wed,  2 Apr 2025 23:23:16 +0200
Message-ID: <20250402212319.58349-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402212319.58349-1-philmd@linaro.org>
References: <20250402212319.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


