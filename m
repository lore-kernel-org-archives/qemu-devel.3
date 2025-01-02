Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49599E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbl-0007OH-UF; Thu, 02 Jan 2025 13:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbS-00072j-Vr
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:29 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbQ-0005CE-Ju
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso160655405ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841242; x=1736446042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XUTpaBvkK/AmU9Br3cCuRs2TbKk17VU1RK81NC2aO4E=;
 b=nLMpQWoKwEpFfklF9u8jMUY0i24NPlUi++uW1Gph6OoHjOt3qxUYg33cpcxOBr6Aov
 B6lJezU4a4jaJtEvgJa/12bT7F92S395iFjyKjuLhrftIL8JIY/GBbv9dUjzsrS3IQ3B
 Wm6inJt/5jzZl6nCFyY4Iu1oa/oGzZ3uhzgnMICa6hsHMW/TMyxeH2Z8pCL1z+HhC489
 PKsJ/4YGv1tbvpr9gtDPpam8Oxktn82z8oERx7ZIvEIPmBjLyCC/oSKWpTu5wkAsEHqe
 RHy8ARLmJ365m+aymbusPLPOvuHImeNloqWSIPvwBWLC0u87G4RolUhzEgPHeF9S0wR0
 HkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841242; x=1736446042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUTpaBvkK/AmU9Br3cCuRs2TbKk17VU1RK81NC2aO4E=;
 b=xF8B6BAIIG3cCVn0yjvhpj8VYlqMXS1Kvkh27vf1qFLBpLNPr+0+WLimTOa2G9Pv9B
 tx466IW26ShMys0l4oSmUHHuvbyMzZiqCE7EHuzVmj1ONmuS3QMpRoA747BycIJx5VHu
 rGbOc2LZXSjw/tZGVn0b3BZ7UuuDmgZbAwy/uYw0ALJUputPJc60Pdy7lqvM/xsuw/Sy
 WQAvLbEO8quP/c5ztlT19gTqwpiWizpFk+pk8asRrTSuVm0bGtJlLt+Tu8jbC2ghxN8+
 JlskNDBI017lXYHB1ZI0nfDkrqOZLHAq9miPvs2JWb4fnGtsvbyCAM0F8E2yu1qpy3os
 N83g==
X-Gm-Message-State: AOJu0YwSOducf9VVfhoF1i6+R7XtZtIZSw/DW160sC1m+jf1/V+PQjt/
 lq0TeChQouK+7y4iA3rGp5xq5f+A76a+Yvbq+zfjjLH+2fevXgiEDpqSNJx0CXdau3NNM5EP4bK
 S
X-Gm-Gg: ASbGncvvKtVHbY80Qrr9SIyC0A/4ftw7qyBRYljKKFdurS41kHG0Du2XaUFPk64MGpb
 qFHbiLlfi8f6gAAGvf1EOSosYnpt6p+WS4NJAK6wi94/WCenhAJzqRhQwrtMf33UsSnTmZQDhUF
 t4FfLuWaqmxvPvOzgCcS2L+KKtzSE8kDwI3y2+kmeDbDsdubxd9NQf08MlmpKkLDNWePWOQP8PI
 ic2I2V3pzj5hQU59w58uhnMs+PILWSInl9hm24EkBdwo3sPsOT2EQsR6/H+XA==
X-Google-Smtp-Source: AGHT+IFFzLG/MqKuW47IlcgabWWcRDcmA+AcWE/Y8fOhCJLCnMibLmEsYCjPlU9V7SokoJWqcKi20w==
X-Received: by 2002:a05:6a00:430d:b0:728:e906:e466 with SMTP id
 d2e1a72fcca58-72abdeb4793mr65138694b3a.21.1735841242510; 
 Thu, 02 Jan 2025 10:07:22 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/73] tcg/loongarch64: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Thu,  2 Jan 2025 10:06:15 -0800
Message-ID: <20250102180654.1420056-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-has.h | 15 ++++++++++++--
 tcg/loongarch64/tcg-target.c.inc | 34 ++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 2716f9d0bc..48dc703ad5 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -35,7 +35,7 @@
 
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -48,7 +48,7 @@
 /* 64-bit operations */
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -81,5 +81,16 @@
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
index a273e7fce5..13debee683 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1375,10 +1375,38 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -2242,6 +2270,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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


