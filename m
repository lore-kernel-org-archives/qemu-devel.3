Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF42C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5n-00060w-Ox; Fri, 17 Jan 2025 13:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5g-00056j-93
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:08 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5d-0000G0-Kd
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:07 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso3431985a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138544; x=1737743344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDdcDXXMoyLv7/1KfJ1cMXQbpZKLIjBYNpE33H5vAuk=;
 b=jew4jib4anYgh6ENrzSCU0qHEuml5TRs9rGx013k/soI+ZzSc54dX4/02tXVcOi02Y
 VEYpTEbmcfzL9qcnO6E2PPCACszMFi6sCV1ovbMlsZR+X2sQ3aRxfNGS14gQTyC7GYep
 y6IyF1XKNwmRBe0jF4Bxt8O+Wl189yPriAZ/tVBe8AteDIAF5pAL6+tKjqhzYun2S2RJ
 v8nm5V7GHKIQsDbBRfUz9wmqDYSj5iU4jNOIYz6mVERrW2vNUu1n7yQIZx4eLz4W36fg
 cMgiM/zk6qzfqgBrgKXN6lWl0UFAmGVSDWM/uYY4/r2nTpI2kqRuzavNkNiUWeBNV57V
 qgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138544; x=1737743344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDdcDXXMoyLv7/1KfJ1cMXQbpZKLIjBYNpE33H5vAuk=;
 b=Gun5/CBZNnTiYVLu0lL3NfvOm6ALEg6iQQYUDKgnJ9TjNGvUC4wZUtUyI1VHn1qMjd
 cyNQhhzhkHJpCAPoVK+6cRBo36+wEKgc/sZFqm1TVrLXT+//KN01xmBrYVPxQlciO1Cv
 8KNCFF0LEkWSHtOdyGq4aV13gYZy3KjZDaXnsc+2vPbryyBVSkwKIyum3DoA3w1nycM1
 0p0fb4eOQH8aP2yUj9koTR1bkpMWIHaobUGOin/LIa32dUcYFVIrxV0j971Hucyw+Ptr
 bhU7u8zWSzctJH6qcfqALmaLMrXsibH4Ic3wF1cUHzz6h8ecHavXIoS/6BTi8Yp/KFNJ
 t+lg==
X-Gm-Message-State: AOJu0YzFnPBBqBEZOAU2OiLT0R2+TOofe4GGXqiUMYIgUROx+7I1SgpP
 aTHeZdK5iaFMjAB5P7+56WfKOx5NRrkzkyoTRRhb1Fi7Pk0EP4wdAmOtNLDJmat4ok7J8PsvPbO
 m
X-Gm-Gg: ASbGncsvNIaHq1+r7/PBEWg1ERH4aRI8xA1NV1qwAw+BRPNQhQwcj9BfX54q6drm96K
 6/Q/iM5xMWpog621sTJcJWUATILY2B5eOCZlDEU3a6L+4epOheKw1Pid5UVHS5eQSb7OJ7Wb0w7
 KAMjO6m6w5X1JAOgBMeaqbhOon088vqHjABF67ZLJn7QvHIzDUkGuQWCOmzX0FUFG8PuZRw8UnL
 mL8gNMg9mjcYa9tneABqYmOKTiaDwQxa7/b00PDFILcj8nq8oIhiLo3i0JkcAdj7N6x2R6+1/8L
 /A+oPsfsLjbWkPg=
X-Google-Smtp-Source: AGHT+IG1L+NrxdDAhh/yi8SKVSTCvrjh7Fm7jFwfnD/sVUvvbJ2g/PP3TzMR/AsoxgNHnyNbtyJp9g==
X-Received: by 2002:a17:90b:1f91:b0:2f4:465d:5c94 with SMTP id
 98e67ed59e1d1-2f782c77124mr5469282a91.11.1737138544295; 
 Fri, 17 Jan 2025 10:29:04 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 52/68] tcg/loongarch64: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Fri, 17 Jan 2025 10:24:40 -0800
Message-ID: <20250117182456.2077110-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Accept byte and word extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-has.h | 15 ++++++++++++--
 tcg/loongarch64/tcg-target.c.inc | 34 ++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index e4333c36c6..ac7d2fcdf9 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -17,7 +17,7 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -52,7 +52,7 @@
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -109,5 +109,16 @@
 #define TCG_TARGET_HAS_cmpsel_vec       0
 #define TCG_TARGET_HAS_tst_vec          0
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        return true;
+    }
+    return ofs == 0 && (len == 8 || len == 16);
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
 #endif
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 3dff29facb..cebe8dd354 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1375,10 +1375,38 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_extract_i32:
-        tcg_out_opc_bstrpick_w(s, a0, a1, a2, a2 + args[3] - 1);
+        if (a2 == 0 && args[3] <= 12) {
+            tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bstrpick_w(s, a0, a1, a2, a2 + args[3] - 1);
+        }
         break;
     case INDEX_op_extract_i64:
-        tcg_out_opc_bstrpick_d(s, a0, a1, a2, a2 + args[3] - 1);
+        if (a2 == 0 && args[3] <= 12) {
+            tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bstrpick_d(s, a0, a1, a2, a2 + args[3] - 1);
+        }
+        break;
+
+    case INDEX_op_sextract_i64:
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32s(s, a0, a1);
+            } else {
+                tcg_out_opc_srai_w(s, a0, a1, a2);
+            }
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_sextract_i32:
+        if (a2 == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
+        } else if (a2 == 0 && args[3] == 16) {
+            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
+        } else {
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_deposit_i32:
@@ -2243,6 +2271,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
-- 
2.43.0


