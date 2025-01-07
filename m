Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6FBE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4an-0000gk-0s; Tue, 07 Jan 2025 03:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aL-0000Kf-G5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:17 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aD-0003La-54
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:07 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166022c5caso195637975ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237099; x=1736841899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS0c+Wz8RnCkIggCVrQNj3MLwcSW/qYIRrNAgRv9hNM=;
 b=UgJoXVwXDhOtRTY8OH2kLmuT+9DhNj+/+TDC6qSnUnFHWwsPfvAPO/fu0crpudJ2b+
 ZOc5psMjQ0t0CpyW5kvaPymAWkjspm7iUV1SSdcAqhsdsRmCCG9xZy1K5GBWqP9GqWHU
 dIdpmYOkX839tTEKS0ROWher7Jppn7dUZN7I8q0MPYbN/+CUjct5c+0KB/dlV/VeL2zB
 RUI+TBhfHbJzGgX7t+Y0xSATCd/qxUiaCZWD0dVnvLZSyu0CAwtQ6FLcr9hziX+iRmBv
 yND7ZrwNYrAOBckS0TNZkSDT/5gw5zWoz9Xetxr2+f8U3ItuwVanLzsuXFsjYIqjndNM
 hMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237099; x=1736841899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pS0c+Wz8RnCkIggCVrQNj3MLwcSW/qYIRrNAgRv9hNM=;
 b=Z6kInAQhMhqCc7tCG8x1waFmQ6jW20vXuP75HGgiuqC/KgLO/O7lGNdNvxfyxJMQIN
 CJRD3In1E55DN8NJex8RZCx1JWpvcH7jOqu92oz/DFGpesQRPt1Aw+U8JVEVktaI6YTp
 mScnKt5JCCm2IyqImfQhR8I646ZVQOllGX+8OVrDF/bB3aP7Q+9mKQZWjzko3cqubim2
 yf7hebl1JKcK104DrvglfNmA+8nrteraFuCXPVNFtfXDNzqXfrVxLOhlEq0UXE/amMUz
 I5cYJmQ1XcpW3zR/WxzpIXKY7AFv9G9uMNAEmpzdoRv558PGY9rNHqTGtFr6iyGdYL+F
 xVFA==
X-Gm-Message-State: AOJu0Yy08jvkbDCcbd00dVUOyZkZh39Ufg0VjrhKil/hA+2QC/IlibM1
 IfUmpPLGxXa552A1F1SSTh9zxd5FBmpQrbAg24B7SNqz0GzvbTmqU0JOxM4i/Fisp/3GmmDx71o
 r
X-Gm-Gg: ASbGncuscbC7QinwjUgW7KaQOlxbQLUB/dNY2eLiyN+npdxLGPjwERasx653NjNqmLS
 V2+1VOky+D0RS12b7fNzSihzXWMeYg6L1aOgUk3OWPZTDiSRoKhZLpb48Wkm0+L+iZdv8Fl0+jy
 Phw3W2K9ekBYTbFQttx9gTDawzQ06WXYIA0CyG359y7DE9WordL0A/pk1xXPRQlVGXxxZm6UBCb
 BAxwaKqGH8UEcQLyeu5dlViTDNQEMtDyWW6+0axErh7LLGrOvcLyo4hxLT3F0YhRMsiMQmA62O1
 zG9vTvUMoF1srCaKWQ==
X-Google-Smtp-Source: AGHT+IHHQ5K145rRHCmXG8a2lgOB+w8mV22wAfBOUQkn7bkLrqd7iPA7udkFh88/ZFhLHVHkFcS7Zw==
X-Received: by 2002:a05:6a21:789a:b0:1e0:c50c:9838 with SMTP id
 adf61e73a8af0-1e5e04464dbmr92415078637.6.1736237099182; 
 Tue, 07 Jan 2025 00:04:59 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:04:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 41/81] tcg/riscv64: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Tue,  7 Jan 2025 00:00:32 -0800
Message-ID: <20250107080112.1175095-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 tcg/riscv/tcg-target-has.h | 39 ++++++++++++++++++++++++++++++++++----
 tcg/riscv/tcg-target.c.inc | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index ddc759a533..5bf62c7c7f 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -16,8 +16,8 @@
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -50,8 +50,8 @@
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -109,4 +109,35 @@
 
 #define TCG_TARGET_HAS_tst_vec          0
 
+static inline bool
+tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 16:
+            return cpuinfo & CPUINFO_ZBB;
+        case 32:
+            return (cpuinfo & CPUINFO_ZBA) && type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_extract_valid  tcg_target_extract_valid
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+        case 16:
+            return cpuinfo & CPUINFO_ZBB;
+        case 32:
+            return type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index e381ba4e77..fc93900c6d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2343,6 +2343,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
+    case INDEX_op_extract_i64:
+        if (a2 == 0 && args[3] == 32) {
+            tcg_out_ext32u(s, a0, a1);
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_extract_i32:
+        if (a2 == 0 && args[3] == 16) {
+            tcg_out_ext16u(s, a0, a1);
+        } else {
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_sextract_i64:
+        if (a2 == 0 && args[3] == 32) {
+            tcg_out_ext32s(s, a0, a1);
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
+        break;
+
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -2620,6 +2650,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
+    case INDEX_op_extract_i32:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap16_i64:
-- 
2.43.0


