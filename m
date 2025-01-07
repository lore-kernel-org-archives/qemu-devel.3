Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B366E7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Yv-00049k-Qe; Tue, 07 Jan 2025 03:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XI-0000Pq-Vz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:02:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XF-000311-Ka
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:02:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso214559185ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236916; x=1736841716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSgr2JqwOeSH9gaeCpGRTiTD4hodIbHr+dCR4OITq94=;
 b=hiiU7LD+Jf0P5exF8zym8SZTU+1+3kob6+MUbLsWqbLoHAWCOs5fIljP6JrHTveTLh
 j43gg71pkph/hutnemJ6pI4PT2goLQXB2F08pJJW3EpVPm7oe8Kgf+SF8LWAvx4lpy6t
 6VCLZz18XYOhIPIN+kaJcAzI9tK0L83SrXpVO75A5clF81YCxizmG4xj64J7v1/U+J2M
 Ai4frMfAMKMEKipqwKtuXm8merGG/QVfH/5I6nzdl+ueqrCvSRla0an9UqH3bVTMXnX1
 1MmngZBHz7NXvhm9iLeL/jPmr8eaKQ1itT6I87pfCuz+b2mlhK3rKPb1WeN1Mucldza2
 dTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236916; x=1736841716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSgr2JqwOeSH9gaeCpGRTiTD4hodIbHr+dCR4OITq94=;
 b=X0E+SeGZRAc6el2CqYbEJHmXAtiv7tjdxaOmxtHMR+wGKRxq1iFMGpmlTlVkOAksvN
 DfLmh0AWauPkx4eoUKxhUOnn6c1zaLukKYL2IXAh2Say5HzODgdv9JubdeBO7n8DhTb2
 JrpEfeBBouzGsm9pSh8MnLYAD1/qvxP7P2iHHp72AzJh3eTfwkxaw5N+KgQ3Km5vTGbo
 BxH9f/25ympwIqf6v/0vqiRdYyLh/UDGm8hEhc3nyWBZ17uBdCWcFeHURNkFXlH9cY4/
 h8dod8Hxvv6yTk+pEi3CNStgqhWI9CTz5UQo86mMC3zwz9GHEZF82m2l70zYJ5KTcg5y
 rV4w==
X-Gm-Message-State: AOJu0YwauKuZKHW1aVfBawchPy0i7HFb/bN4fSFT9aFnTfzvsHgripuf
 rO45hTOYn92tGuLawrNuGxSg7TtsUvwRx7yQq1dVh7DQ6WkRIE5sHxpc822vedt79N54ai92DFR
 Y
X-Gm-Gg: ASbGncufsJLiZ7eUEreWQOdv4VisT1EpZjv76rcw3AkF83dn1Qk1ljw/mUrZDpBxPkL
 0SFCmUnM2hejcqdSwzQijFZ5BFxBWz41bwT9BaVbm67L191ELmXUufF1bAwyGvPsP+XTPXsLiB/
 FsbSyimRVltnryxOIoampPxpZEjC+hysY/WJY/Kv75XcE2bjJKi7cEAiglyBlAJM+2b8IlZooB4
 GOXKuoCSGApV4+faOMJQW3r4e7uhhNE2gV+LnUFyvbdfggiUqCEkSrL01VmIzK4gDhDknv+qZIB
 AlwEcmmrgkXb09krZg==
X-Google-Smtp-Source: AGHT+IEX3GSWzgISq4twaS1DNAn4GS2gfVYOQcOUjAYp5ZfUoyzrb1ZTA9gnqB5ivpIdMjMls768Iw==
X-Received: by 2002:a17:902:f688:b0:215:a172:5fb9 with SMTP id
 d9443c01a7336-219e70dbe56mr810121865ad.48.1736236916327; 
 Tue, 07 Jan 2025 00:01:56 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 39/81] tcg/mips: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Tue,  7 Jan 2025 00:00:30 -0800
Message-ID: <20250107080112.1175095-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Accept AND, ext32u, ext32s extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h | 26 ++++++++++++++++++++++----
 tcg/mips/tcg-target.c.inc | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index d3d874ffd1..e7914cc970 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -80,8 +80,8 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
@@ -96,8 +96,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
@@ -119,4 +119,22 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
+#define TCG_TARGET_extract_valid(type, ofs, len)  use_mips32r2_instructions
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+        case 16:
+            return use_mips32r2_instructions;
+        case 32:
+            return type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index b31b8f0007..99f6ef6c76 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2041,12 +2041,37 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
                          args[3] + args[4] - 1, args[3]);
         break;
+
     case INDEX_op_extract_i32:
-        tcg_out_opc_bf(s, OPC_EXT, a0, a1, args[3] - 1, a2);
+        if (a2 == 0 && args[3] <= 16) {
+            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bf(s, OPC_EXT, a0, a1, args[3] - 1, a2);
+        }
         break;
     case INDEX_op_extract_i64:
-        tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1,
-                         args[3] - 1, a2);
+        if (a2 == 0 && args[3] <= 16) {
+            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU,
+                             a0, a1, args[3] - 1, a2);
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
         break;
 
     case INDEX_op_brcond_i32:
@@ -2170,6 +2195,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext8s_i32:
     case INDEX_op_ext16s_i32:
     case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2191,6 +2217,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.43.0


