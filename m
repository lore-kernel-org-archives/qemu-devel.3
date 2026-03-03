Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1747EB3649
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFq-0000Fe-Tl; Mon, 02 Mar 2026 20:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFp-0000FA-8m
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:53 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFm-000725-CO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:52 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8273e0fb87aso2749181b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500129; x=1773104929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tP5/W1kiTCmuQM9EHfOiY2ySSiL3wae69p6z7AYvXAU=;
 b=hb2ogS+pO9z+0l8/wyfshMu/jt0F9lk51jz7QhRJAMhVKM0aiFVUxFEzoeVVqqEXio
 Q1g1CdwgSGcitTD30NBVm59aAOTw/tBNbMpAQM5oePTgxs7q/ct33X9jg5JQ7+JomMmo
 5o6uvFkkVJxkc7KetwYGghOQj27bfG4Dd6gQEqNQcVMVqdnzL9WGrIrE99gJSDwZH5bJ
 m6MX35yMAOCdirqobahKQO9DgwpBGAPv7k9GG4Tr32s3yAD8zkWjun6afOgKIo8Ca7Bg
 9viE/JRtd6mQ778xTfAfzTJeG3xvQA17Zso0Uksmhf7KFpYUe77sAvqzxFZz9lV8cThu
 iymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500129; x=1773104929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tP5/W1kiTCmuQM9EHfOiY2ySSiL3wae69p6z7AYvXAU=;
 b=AUHmPxyQsbGqFfbDktAejspQCkCM31rCrsG8/qHcnaPAAAy0bA8QLTlK1b/YBL9f+L
 2Sl1oXw2/7V85btKm2aqDLK87h4PTLLV5H63JeR4Hx3mBdihtGFMRwdvpAD5XrLtiK2n
 Py3b6O+mWTqkUvMP/FRPRZVIKrz+U6p9izOqMl76noLydtOFRVeyRVNnDnSnKOA+6BZP
 aY7uFAgzTFFfN2H5Y7LrU9JIe7qvsjlL0pCCX+pkk/50M0gYf6qwHTa5QmcA7lltNlXc
 aCGXMOHntV/F5J0j+7K8+sL5MVJUDK+rOagaU2B60nlHmgv+xB1LdfrHNpmMg0RxX/uR
 c5aQ==
X-Gm-Message-State: AOJu0Yy1qiu/svZSOujEnebDFfd8pw7BbpsLgrQbDcAsaeantm2Qnmzn
 rrJW0ocwnl9mKpWI1rHRetTH/DdTrXN5b7U5FT34F//p2f4A9HVNuEaJlQTZyh4zPRwXLUhFouM
 R3PODHXA=
X-Gm-Gg: ATEYQzw0AvCjkV7t9/cl160qWHbhbenBJEqkGJuNgjYE0NrvKKizn9X/9idB6eHWsKo
 69Kk2cKK2b6lLeW+i8h5cxIereqPly/QjCYIy8e+Zb0wZfHMR7Eb7vHdyYrcM++Kqa51hqlJhz0
 f7CerwbDkQD/aLE+iEns4DKTTjRYzNu8jtJjoUEIaj8sWqWhXfQ2R2OOXIwmaq32YuG/lM6Fx8+
 aKMUgzBf5MjgPDiE7phSrWVmuRtYtzGfbvyj52Xj5ZX6B22+TRfiT++CNEc0E/d34L0y6RJ1tdF
 DzuJu5IMxYJO9kWqw9q5/GzFpuE15TOcNMwOQUVSupBE6mITm75egB/XuSM85RGiVfUxfYKm/Mm
 nI9L5GJ2OSIcPSyqoAYobb9uJgD9qH1W1KtGKOW0klJsc4JfKjgwVO2OVv21MHh9VtJwu2EIRd4
 PDVTMw9S0cy1ecCW/lcUg9wbheQTGG2g==
X-Received: by 2002:a05:6a00:f8d:b0:824:3cf6:3fb4 with SMTP id
 d2e1a72fcca58-8274da11634mr10406730b3a.32.1772500128905; 
 Mon, 02 Mar 2026 17:08:48 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH v3 4/7] tcg: Expand missing rotri with extract2
Date: Tue,  3 Mar 2026 12:08:29 +1100
Message-ID: <20260303010833.1115741-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Use extract2 to implement rotri.  To make this easier,
redefine rotli in terms of rotri, rather than the reverse.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fc2254f54a..13a56d89fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -826,23 +826,12 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shli_i32(t0, arg1, arg2);
-        tcg_gen_shri_i32(t1, arg1, 32 - arg2);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
     }
 }
 
@@ -870,7 +859,16 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
+    if (arg2 == 0) {
+        tcg_gen_mov_i32(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
@@ -2042,23 +2040,12 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shli_i64(t0, arg1, arg2);
-        tcg_gen_shri_i64(t1, arg1, 64 - arg2);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
     }
 }
 
@@ -2086,7 +2073,16 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
+    if (arg2 == 0) {
+        tcg_gen_mov_i64(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-- 
2.43.0


