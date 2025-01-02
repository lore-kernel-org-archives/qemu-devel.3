Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D0FE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbl-0007OP-UX; Thu, 02 Jan 2025 13:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbT-00072n-R0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbS-0005Co-07
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:27 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2161eb95317so163044535ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841245; x=1736446045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BCPUOA5Uk9H2cDEALtbrXdMj2dY8iECCbyoIuKpCyr0=;
 b=PT9lyAPXuiwh8q4Z+EsyaI7EyuiIwRgQAc4HcJ/aNB+7qai47g0TU8cpmVpX43HvDz
 ID1dj8vViFW1/nHYrCoU2TwMXg6QFEL04H4kdg101ew0Qyv1tefreHfvYNQ5Zjnm8Ria
 52VAoXxeoDv0Fze3vMlMT3iTk/Zj9i0pzZtoYGhus9YKkQMhQdLsVMfJKClhqatejO0B
 JD8QE0KFxvz4/BleG2ODyO4mfr+0uk1z1sPMYRzWQgUH0pisvFZxvw8fE6p3usTg2R53
 WIgHdHxRfH935BIKKUVrhMlJsDB5j0a9J2hb8HVTq0lp2i4uCGseq64U2NZhKDw0qhnL
 VeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841245; x=1736446045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCPUOA5Uk9H2cDEALtbrXdMj2dY8iECCbyoIuKpCyr0=;
 b=TjlCNNTTRUIJHTnHf/w0OZzcOAiZQcDMNufjENvCDl9pZanXXnwsRJ1PBV4Tcus1FM
 EiFy27srfP7D5mVv4taJa0ZYWWyqYqqVezcdmWmcHhjAIZFX4u41dG7IBmBYEfJmWnc8
 qdyBHnVefPkK4EFkbAPet6Zo6vnf8MJb4S+BaN6RuLLidRIqCYcIukVk/2gZJ/35NpRf
 nt7rm16Od4bZmobmf9kaFHIf8Go+x3hpfcUDKHTE7sq56YKz+m+2n9RjUX7GeO28g1Df
 wN6mXe8+xeVfH+r829khzeO+aaDIiNlGg9lJvmsGjCYFrPhNiWXvcvnfvLcHyeK0pEs9
 2aig==
X-Gm-Message-State: AOJu0YyXTU2cycYysNkjeriBgpa1FLYuwMPMyenRHfdiJQhNvdLJBn6W
 38Aq7nHLZaQoe+GSwJ4BGpsv253KsnJcVt+YihX/2S3q6euLhUMs7+jeX4ymUt6yGHAYWAU6szL
 x
X-Gm-Gg: ASbGnctQXxAI/iYPLLxPa9VljbjsgsmmDNsx8efKX4c7bB+9PSKxkb5kVmNd7+ZTMA/
 V24VVufsI0Va0MRIEZwJMjrP9SfTHhelXsefbdHNGA4U95b65q8BlXn3Xf7WfF9/AYNXZojC7p5
 pDDMK0xEqg3+5XQs2gEd2HMOEPbaK6TlXVo3aShk2TpvtOxzualPGVg1veWd/NhYX4diUchnOu9
 roSmE9By2kLyrqoPTbxwxv6N/+Pec4aq4KIk669OzAHbiehJnHg2HCfgLzw7g==
X-Google-Smtp-Source: AGHT+IHAW3yFQNJMmryqFdrCVhLDlGTZEWJ/es/oHTXypSVspcDKWv7uiP2q40dSR8SOqpFXm2sZVA==
X-Received: by 2002:a05:6a20:1589:b0:1db:e509:c0a8 with SMTP id
 adf61e73a8af0-1e5e0497ca3mr69069087637.21.1735841244677; 
 Thu, 02 Jan 2025 10:07:24 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/73] tcg/riscv64: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Thu,  2 Jan 2025 10:06:18 -0800
Message-ID: <20250102180654.1420056-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index 08096d0625..efebc46109 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -34,8 +34,8 @@
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -46,8 +46,8 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -81,4 +81,35 @@
 
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
index 7d1bba100a..8122187665 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2343,6 +2343,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -2619,6 +2649,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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


