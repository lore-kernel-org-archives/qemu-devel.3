Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B1DCD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKn-0001hp-9X; Sat, 16 May 2026 20:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKV-0001dy-1w
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKT-0002Wh-Ha
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-835386ff122so1125286b3a.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977559; x=1779582359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aizZ6KsxuScbuarSuGl62Wou0yp8xd59JdQCbRvge3Q=;
 b=sAdgmxIZ2SNp1KU+/f/R2fA6D61RNdVOfXes6gFyVhVrIXxWO1HqPSggN1rBvOSSLu
 sbXGlszWb43NnI9qjV8j+7u4gwD2I0RzoXA9uWCliN/wWnhQ6Myy4Q2/t/eQc7o+Hnyq
 SFJMUu8js+Z3bAtw+U5ClKXHQ0fCK1iqG554HdbXckyHXOggRcIqI9gcpYUBy4fr4W+Y
 c41jJbrGdEGub9PAjsIZaGA0j4WYib6G7cExRwxl2Q5gUnSQSAVM7IfnluG2aW4BczMc
 uAIiHpz35FQUvSj73FRTE7le5ImN4kzTGx0zLvO/RsJBzyLVg6ddHAotpmX9LZXZEza7
 4Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977559; x=1779582359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aizZ6KsxuScbuarSuGl62Wou0yp8xd59JdQCbRvge3Q=;
 b=ah/Ar3NrE10PQfYp12FKtknAgwnMi8pv3D06x9L1q/F+lkkALvpd6sqotJIkqsmz9X
 Agliz0LCWVjC/z/enjKpnmkvxvdGGUrgtu9PX21imFS47wLQI+OWoN0lTufgKzRkbwUh
 ZyLOqgvoKuqk7W5gH6FL4HHiGif2Ad8Xvgw8lL2vUvfLNhpHWJkP7MYla/dfIq7boU4C
 GiRxcYduexWWcd40Z/cgUgbRBBdTPbaFkH9pyqSWIfEHGWxqA/7Z/MXWZHrEbo+oX6dR
 8ZVyOt76BF/uPzeE/fOEComFn7nCGOunhkgg691XfZhwb/MEleCPZgIRxEkcf12WUNbY
 B88g==
X-Gm-Message-State: AOJu0YzbKPQn3es9+sZSj/4lSBepJVB7235QL/SeKQaj0hjbaYDdeFzW
 Hf7cFD7g2Bdvz32Lh8u7Jud/6lcDKoKLa2xfE2J20dH3/00wQV/cID1isfgdcpgj/zN5x5j/AKX
 1inNA
X-Gm-Gg: Acq92OH/nJURVsntUDldxyerHM/zT/EaJFPTyFWBzlijNh6iVCTZCV8MAFJ1nA3aQUZ
 9x9T9w4Hj43tlLhlifjqtEKDN2qw9hZn9vHnb0WnqR0/HL5WPzEm+Bbc3Do3FpujVjaEwv/aC+Q
 UmIvOYiwwU26dj4URtxM5EP6bSLZQsit4Drsq/r6zVriu8uS095neBPaDKRZrGmam71tDmz3giE
 AJUGBoq2BIMYxUAGM7khKob6SZX6zbZygU3ood+33Y9IMqur0OTh7BX9RG/x2ocWFj3rJNhxDHQ
 LIgeD9QEKZNYFLzYLD4ojglnduQ7QoVJha89knKlrD7w2qkuxgzWeoIcRnig0naueYw6upDpiZ2
 GQKQ5reT8A80bYMSlJJI1iChNRiK+DAwoY1pZvseeEO4Xa1OZc40cZlR3V19IHVdngSyVo4IY7J
 jswe/M5oqu9G0gTbloQVu7OwAoA9zA
X-Received: by 2002:a05:6a00:4fc8:b0:838:1636:e2d3 with SMTP id
 d2e1a72fcca58-83f33c97154mr10721453b3a.35.1778977559196; 
 Sat, 16 May 2026 17:25:59 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.25.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:25:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/12] fpu: Simplify 0 +/- N case in parts_addsub
Date: Sat, 16 May 2026 17:25:42 -0700
Message-ID: <20260517002550.321291-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Consolidate the tests for zero and anynorm.
Add comments for a few cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3246702289..45606f8402 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -556,6 +556,7 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 - 0 */
             a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
@@ -581,23 +582,20 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 + 0 */
             return a;
         }
 
         if (ab_mask & float_cmask_inf) {
+            /* N + Inf or Inf + N */
             a.cls = float_class_inf;
             return a;
         }
     }
 
-    if (b.cls == float_class_zero) {
-        g_assert(is_anynorm(a.cls));
-        return a;
-    }
-
-    g_assert(a.cls == float_class_zero);
-    g_assert(is_anynorm(b.cls));
-    return b;
+    /* 0 +/- N or N +/- 0 */
+    assert((ab_mask & float_cmask_zero) && (ab_mask & float_cmask_anynorm));
+    return b.cls == float_class_zero ? a : b;
 }
 
 /*
-- 
2.43.0


