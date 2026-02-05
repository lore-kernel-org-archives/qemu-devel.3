Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA8FEC1EA0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxLs-0004mS-24; Thu, 05 Feb 2026 06:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLl-0004hb-H1
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:43 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLh-0003nU-VP
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:40 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c6788f3db37so262631a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290196; x=1770894996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7P4L6KRGUfnJuZGklnenZefdnYuPN4EZ2NjRTD5rCHQ=;
 b=i3Lk4qns2IbeWdFNuZ8f9TTR1lDatU/xAHGiPk1fXWEd52AzdXbZKDxiNAEXGsmUAw
 t6nv/G4/4g6FwYwEyLqhNockHyyAw1NwrM+XwS6yv/LHZi//cTgAyQS6VEN2eZ3oPPlF
 Aibmg13gU0GvcSyj46MfEL8wlBkCQ7tSWP+tETuNseVK88mplkwPYOSoQO+nxYO6kSJN
 ZJuqcbH+BKMVDtRdz2TJN5Yo50MaCmhju7ZtsJsgLD8yFDDwzm9oawJjt2nXxrMobcr3
 KqIaOqoAjBE0H2l28GoRaVB5eY70C7iIKZPWxHXqav5phuILJKJK58lIkdVJtIwpnlvW
 OsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290196; x=1770894996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7P4L6KRGUfnJuZGklnenZefdnYuPN4EZ2NjRTD5rCHQ=;
 b=sZH5kJ1y43JMcFhrlYZx7v3HPxtGNS/KmPQovP8XpSclNNzwWE6BqxBsgjrW3/8Ym0
 zt1xp4u++UoY//PyhpDdgQ3LIjM3xLRc/jPz1eKLuRgmqkAJDyGVsRNDCdN+zkFcvw9U
 NaaVlC+cskpm9yB+iN9AdmDgKckKP6T9erssbBlYRQ2jNN0IzQAvYjg3CaajCIGFf0zV
 DRiLrlAVmFHhJP9acLqqNBsvRNAptI3GtH3qKUqyD60+rKaOSG0f6GEq74YwFqo13MgT
 3BQZ8juYF+xGY/v8J/qQOkstJRGaMP481muUlSyWggPtfKkyDncTD3o91sAWfUc92kci
 Lmkw==
X-Gm-Message-State: AOJu0YxAqn4SoxmKP8i1kcdUBdP5fgBzVKpzayGcqgJmaoj404cSfdh4
 MQW3YKlOnUx9tnvFf3vmTaQcrpBxD52MJhITHi2DfESKEw/GKr25WktGVwzlB/RATr7XuUeaibC
 qiu5fk9TGtQ==
X-Gm-Gg: AZuq6aJZ1MMDfxlEFE7a7Rr8QRIMUcF5LChWw6rhUJBsSsQiZHlQwP0z/9HFE6DuIgI
 CfDmXNndCBVlFuOOq/GBQBb40fGyU2bggJKT0OxVb2QfTxdL28pxGJWuY1fx9DeZ0oJJ6NOuFnZ
 v9v1jTtn24/d+bj2HfI4Br+zVb7yLubtcDhMVYsBMW4XD7hFpZ+j5RrkurL09mXDRwistU7inc5
 PlODYHfT1CJIde9Rpp6TVyCK6VYiCQQJWJ2vReCCJ8sL+v8DUcvMsA/CDD/MI+ra8Hzf4RZ7ll/
 hfO9SwoolCJqazFJHBf7EY+MBc/9ioj7Laoam6oYZPgNrZSxVidy6my2/bg7+7AGR+PSDQbl7o1
 3BVD+WQuyTG2nw8zgmltkEfvOp10wWIjHOnh10YWv7Ek+yL/gIN7PI7ufaWYFO4smJ70sbGEtaj
 JgiJvlu26q8HgN/H295V1bykmSTtyf3q0=
X-Received: by 2002:a17:903:3d05:b0:2a9:484c:ff21 with SMTP id
 d9443c01a7336-2a9484d049amr7647235ad.25.1770290195535; 
 Thu, 05 Feb 2026 03:16:35 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v4 3/9] target/i386: Fix pseudo-NaN handling in
 FPATAN/FYL2XP1/FYL2X helpers
Date: Thu,  5 Feb 2026 21:16:16 +1000
Message-ID: <20260205111622.461497-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

From: Max Chou <max.chou@sifive.com>

According to Intel's x87 FPU specification (Table 8-10, Vol. 1), arithmetic
operations on operands in unsupported formats (including pseudo-NaNs) must
return the QNaN floating-point indefinite value.

The helper functions for FPATAN, FYL2XP1, and FYL2X incorrectly check for
signaling NaN before checking for invalid encodings. This causes pseudo-NaNs
to be treated as valid signaling NaNs and silenced, rather than being
rejected as unsupported formats.

Reorder the checks to test floatx80_invalid_encoding before
floatx80_is_signaling_nan, matching the correct behavior already
implemented in helper_fscale.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260204051756.667397-5-max.chou@sifive.com>
---
 target/i386/tcg/fpu_helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b3b23823fd..37c83ded38 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1377,16 +1377,16 @@ void helper_fpatan(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2061,16 +2061,16 @@ void helper_fyl2xp1(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2159,16 +2159,16 @@ void helper_fyl2x(CPUX86State *env)
     int32_t arg1_exp = extractFloatx80Exp(ST1);
     bool arg1_sign = extractFloatx80Sign(ST1);
 
-    if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST1 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST0, &env->fp_status);
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
-               floatx80_invalid_encoding(ST1, &env->fp_status)) {
-        float_raise(float_flag_invalid, &env->fp_status);
-        ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
         ST1 = ST0;
     } else if (floatx80_is_any_nan(ST1)) {
-- 
2.43.0


