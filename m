Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC686C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05IT-0003tU-Fq; Wed, 02 Apr 2025 17:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IQ-0003f6-5a
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IO-0007Pv-2v
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:49 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso760765e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743628007; x=1744232807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cIoxttK7iSfSroRf7LfqLkVmrDQ/epUW1IeQyX1yBKA=;
 b=NtMxnkTgirvAOxVLUrtdjmh/lxdTc6WGBedWL1ur0Bu2/4BD3nKT0Au783IBlFW1Ry
 kuMBMxlA0K1DoSt2hKg6pgVOhegHAOONrIXm1uOB/UtWRFnBaiYsXLotKWgMnv2eIKo9
 SI7MGiueIX0ayH8/cUuLz06eRYp3N3V2A50luHZ1crp+SfTYIPJtJjWMehWBikVkGaaM
 mnap5xrbRuDULVQWKrGbxh2IqQX+a3Qgz090x7qRoOwAubt4nwGKiys0tSS366vwb8Lc
 Z6Qy5EpCoNXTtwSaubfgSHROH4h01ArjHDeAW+Te278DkALouMMT++D8LR3BCOG5d4K9
 2xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628007; x=1744232807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIoxttK7iSfSroRf7LfqLkVmrDQ/epUW1IeQyX1yBKA=;
 b=i05iKHVtjH/DzGZs55ag/Qx4Tr85JE50uhefWeJqFrykyyVmHzdarwLkh8m4s4tphE
 HiLqF3YKsC/SgxP6g5SHTOOS/eLuISYvfDZNyaWadSeupujQSrEl5MV1Vwb3VpuWILlH
 qk5GxoizBatPBZyRroMaPY1aRjQOoq9Sgh1X/79YfkGlTOd1ZryVunA2ejgk5sOqoyn/
 k+5CIgbitn8Hs8ljNiuv6xEhQpz/B/alpzlwUzQSQh9l3iDq4+XL9fBIXYhY4b8fqQ4I
 fFS2hWHnPWyVWeIFmTuoNYMjLieUuMMA4jKYOseRtHO0yD3yur0ADd7F3ezj/V2ek4kD
 81uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvoKUOvgkPKtI+03u3lm7ATaTu79D2suxDSOn/668ae/f2ZsOhaYuFuqV3uuI1WI1YNj4aHVWqzNbP@nongnu.org
X-Gm-Message-State: AOJu0YxSaCJcer9nGbLpR5NqIw4EYOaWIalcSrR1u0j3kercSWnjXw1v
 gHCaMJKC1VTefegLXQJ/8zU4G8PoWpPfMDh9vqu5JDIkfIzUqioezqb2gjweryZS+8HO+ZW6OJu
 x
X-Gm-Gg: ASbGncsbLRqrKyP1qOn51gWRNDm+NUn431gQ/7rVT05RO1KqRfKO/DvVE+jGGxOwH+k
 XldW2kh93U4PuLczZVrSnTJv2R2Zp6woiMC5QcX/SisLKm5hue4EKSHmxvSCkomBOqGLkoej/Hc
 Y2P6Q9zz6+zLPKvaVUGGlbBmorV+8cnGCJLLDzv290SKi/hk+vRsvA/yZ0lmd2uHpsCTu28ri/y
 fYtVo9wPDPy0muezC5AuQAHkB0Jqk206IQgWd2zedcn0v12FcNbwcPbEN/ri1qXNsoPdL9nowQ/
 dX7osE9VEBglnGPKi68PmnQc3uR8vQ52OvEyRDMzfoKO+CavkKf+jYFEXLRfp3bT+S8rZJRmrq1
 y/iZcNdx+9zct3UlBUuk=
X-Google-Smtp-Source: AGHT+IHrGbt2E6V19yDg9xw2WoMvqvvoMXjptQfQGDkgwh+o4UVMTYNhcKIuqmfoOFf9890veW/jBA==
X-Received: by 2002:a05:600c:34d3:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-43ebdf77b60mr12445085e9.32.1743628006622; 
 Wed, 02 Apr 2025 14:06:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b1352sm1889115e9.37.2025.04.02.14.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 40/43] tcg: Convert TCGState::mttcg_enabled to
 TriState
Date: Wed,  2 Apr 2025 23:03:25 +0200
Message-ID: <20250402210328.52897-41-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 accel/tcg/tcg-all.c | 68 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index b8874430d30..ae3a137e87f 100644
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
@@ -118,7 +92,35 @@ static int tcg_init_machine(MachineState *ms)
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
+    if (s->mttcg_enabled == ON_OFF_AUTO_ON && !mttcg_supported) {
+        warn_report("Guest not yet converted to MTTCG - "
+                    "you may get unexpected results");
+    }
     mttcg_enabled = s->mttcg_enabled;
 #endif
 
@@ -147,7 +149,7 @@ static char *tcg_get_thread(Object *obj, Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
 
-    return g_strdup(s->mttcg_enabled ? "multi" : "single");
+    return g_strdup(s->mttcg_enabled == ON_OFF_AUTO_ON ? "multi" : "single");
 }
 
 static void tcg_set_thread(Object *obj, const char *value, Error **errp)
@@ -158,14 +160,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
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


