Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76DFD1268B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbP-0004Ye-42; Tue, 05 Nov 2024 06:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbK-0004Vh-A3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:58 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbA-000763-Ei
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso47185795e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805584; x=1731410384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rw5y8B7P/l3rqEDHkilLI0k4OLMoKZwY9v6CZQNZn3k=;
 b=xcagPw9ZwkwcCLWHYTk9ps1UZASuNwBR/XsbyFjSHS6CmxuF/PqqLmFBqGZchlNZyE
 ebnyHPZCRL++F7TcXow6delDrL0lagVFKnOzzATn1KqxSEMwhkovWwObH80M6cOejgUa
 KGcF+C0YLbaOLuyXbgNu42U0taXcauS3ORhqDbu5h2X6K+5+3OZpYV3Y7T2xGNz+Jsfp
 0jLL8QSi5aT237jBIkbOFe6cMQooo1kwJFGr/oaeeukdeX2JJOjVZMrVFIKEBG4E+oc4
 unBp0iH10R7ZdLeSv7bMp/Y1206tjVzdePTtdh2+iUkUeus3DcK2Kgtmyr1YQSzgX062
 r2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805584; x=1731410384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rw5y8B7P/l3rqEDHkilLI0k4OLMoKZwY9v6CZQNZn3k=;
 b=wbLyj7irjhXOGVXPKiuQZGc3YpI3xwA8kl6yklK2+Qi0J2R1yfBxbjCKB5Y1xEFtF7
 JXM+6lIHn1a7rlsg+NXHkSX2Ril9N0XmivZhAkKedNzII8hRrkry/Dk3aTMPJlWYp87m
 8kH91lnw5i6dnHfMNDCuGsU2sHdznRSnKqA7xqzacqHqww4Qfp7im89OaAVOaH8IctE/
 y/D1h4leMwjkn80wxTUFy1YoH7b+021qAgEQeAmZnlXEVnNmYs+Tyo8Wggy+Bt/jAhGY
 8BBGNzPZWmDObK8UKhBzPx1WDaJ7HUqjauSUz8p+tFtKM0TKyzQCfNa5jo4nb6keGDiX
 7dlg==
X-Gm-Message-State: AOJu0Ywdn6fFLvD011uKbg1AYMl4K5zAyzp/Co4QrFZ61MRMe+EEAvw7
 FxVsz0Tr3yzD5yP22nFWiZzgBKskPHPo+BiTTzeFxbKjwmmF9tA9+s0f3dYTL/FaOUR+k65z/H+
 o
X-Google-Smtp-Source: AGHT+IHVRTEx68Yv7dOqT2OjZM0ciVmoCVF0Ailvkbvd7WM4MZ7B+AiAvvDnIC6MLRXzTXXbLcGHYQ==
X-Received: by 2002:a05:600c:4e8a:b0:42b:af5a:109 with SMTP id
 5b1f17b1804b1-43283284867mr114312475e9.24.1730805584293; 
 Tue, 05 Nov 2024 03:19:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/31] target/sparc: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:16 +0000
Message-Id: <20241105111935.2747034-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Set the NaN propagation rule explicitly in the float_status
words we use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-13-peter.maydell@linaro.org
---
 target/sparc/cpu.c             |  8 ++++++++
 target/sparc/fop_helper.c      | 10 ++++++++--
 fpu/softfloat-specialize.c.inc |  6 ++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e7f4068a162..dd7af86de73 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "tcg/tcg.h"
+#include "fpu/softfloat.h"
 
 //#define DEBUG_FEATURES
 
@@ -807,6 +808,13 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     env->version |= env->def.nwindows - 1;
 #endif
 
+    /*
+     * Prefer SNaN over QNaN, order B then A. It's OK to do this in realize
+     * rather than reset, because fp_status is after 'end_reset_fields' in
+     * the CPU state struct so it won't get zeroed on reset.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index b6692382b3b..6f9ccc008a0 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -497,7 +497,10 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
      * Perform the comparison with a dummy fp environment.
      */
     float_status discard = { };
-    FloatRelation r = float32_compare_quiet(src1, src2, &discard);
+    FloatRelation r;
+
+    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
+    r = float32_compare_quiet(src1, src2, &discard);
 
     switch (r) {
     case float_relation_equal:
@@ -518,7 +521,10 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
 uint32_t helper_flcmpd(float64 src1, float64 src2)
 {
     float_status discard = { };
-    FloatRelation r = float64_compare_quiet(src1, src2, &discard);
+    FloatRelation r;
+
+    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
+    r = float64_compare_quiet(src1, src2, &discard);
 
     switch (r) {
     case float_relation_equal:
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 226632a4d10..8bc95187178 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -404,11 +404,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
-    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K)
+    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
+    || defined(TARGET_SPARC)
         g_assert_not_reached();
-#elif defined(TARGET_SPARC)
-        /* Prefer SNaN over QNaN, order B then A. */
-        rule = float_2nan_prop_s_ba;
 #elif defined(TARGET_XTENSA)
         /*
          * Xtensa has two NaN propagation modes.
-- 
2.34.1


