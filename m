Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC1E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4YB-0002AI-N0; Tue, 07 Jan 2025 03:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XH-0000Pk-Kv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:02:00 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XD-00030Y-7Q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:57 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166651f752so25297125ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236914; x=1736841714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uOL1Ec34bEcm3pIR/RP3l7LZaQfA5cBwwchghp/teo=;
 b=AdlvAhgGv6v8+CMeBdapjB5E2l99Nziu2nMEXz3yT7S2YtexyOThMsDKgThn7Hf+8J
 3eAblwwUn518/QpHGEvkcoc0ZJD9RH+HnBAS7AmZB+9/EU0lMcSd4QLItIOjqUTfFdRE
 LUspz5QhHElTZcT3r1oK1DZiFav+GOLDjhnyEag3D8jm/hSxR0mc3N3D2DqLgepCdrgz
 GYA3m+MgyIsXWZXddGrO5YSFA1BoGZLMciOO2+n7ImMURelwLSnAqJceHZy9qa8mC9ma
 Y89rryQHNbUAH1z2hoxBfk8B4ag1leBblSubZm/9fVI0wPgxmW+HHlrihna0hErFOwoF
 dRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236914; x=1736841714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uOL1Ec34bEcm3pIR/RP3l7LZaQfA5cBwwchghp/teo=;
 b=fjD4FXcVjGMQ6n89Ce504AsDnKgSqsilF0cXc5cdug0toM+VCuZqkxdnjwn8Wi/x7e
 xOtbR+FacseutvDoWBfBbFf9hsseiIXj5NDdgynnW/47mHURUW1NE2V/3vVt03FL7/VW
 WCPBJ+JKrXwMmd+bLAasF491M/7o0wWsgNKCFTJ0Q2R9kARIIdaLsxfSfcH//ScPiGMn
 LfwEAibKK69v6Su5WtveJCO1jojKAQN5NBCum5ZWA8ZTJsrIQUgY1JuZMFnysztrOz1k
 ipw9kg/NfpFwq67gveOl4+hbXj5NlMHEvPwLTQ36Y8VfFo8LXDrhwvpybqCohLjbhHrN
 MUDQ==
X-Gm-Message-State: AOJu0YzUplv4nOLJ+xyZngKl6dz+hkJsQQJIYItmAVnDBQyE0OeD86W0
 Vznjf2fmLjRL/gEe+V2WbR+OrRw5M48oBLqVCEeLzHcPZN+gDcnQlembTHcfrCH8+E+mi5Y9bSN
 t
X-Gm-Gg: ASbGncvdeaHqoxDSx8pxLdRlgs4ZtTHIyZzBCVETwCI6pL5j4Xfg04egW3qO6rQ0v3H
 bIHrncV7q77ZlDDgwB9PbbCzEHA43vC8HbAT1weRiqXNGDEurnxwy+G+MUFAASDr0jBLX9PdTsk
 dLaTmRG58d5O2r7o8RX1PyyM34r1kvC6I5RmFY8bBI0rcrcVVWD8f7LrOCWlPISvtzbM0Br1/Zx
 ny+Kg2mYnYHbwmAHzwQSUEx/W7WzSERrjD6N5G63MdsuqQN7M0wxTyiHwmwOGx09dSx7ZqbDJGH
 zXGgTGk7v5QmC95Nww==
X-Google-Smtp-Source: AGHT+IE7xrWToRcnH3+SnqzeaBRXyoAV843py2nuIvuFj1SajuLbs5FRdI7gnTPk+77y8bFvdzatSA==
X-Received: by 2002:a17:902:f602:b0:216:3c2b:a5e5 with SMTP id
 d9443c01a7336-219e6ebb682mr841720155ad.27.1736236913955; 
 Tue, 07 Jan 2025 00:01:53 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 37/81] tcg/arm: Add full [US]XT[BH] into {s}extract
Date: Tue,  7 Jan 2025 00:00:28 -0800
Message-ID: <20250107080112.1175095-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The armv6 uxt and sxt opcodes have a 2-bit rotate field
which supports extractions from ofs = {0,8,16,24}.
Special case ofs = 0, len <= 8 as AND.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-has.h | 17 +++++++++++++
 tcg/arm/tcg-target.c.inc | 54 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 316185500d..d6ca35ed1a 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -82,4 +82,21 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_cmpsel_vec       0
 #define TCG_TARGET_HAS_tst_vec          1
 
+static inline bool
+tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (use_armv7_instructions) {
+        return true;  /* SBFX or UBFX */
+    }
+    switch (len) {
+    case 8:   /* SXTB or UXTB */
+    case 16:  /* SXTH or UXTH */
+        return (ofs % 8) == 0;
+    }
+    return false;
+}
+
+#define TCG_TARGET_extract_valid   tcg_target_extract_valid
+#define TCG_TARGET_sextract_valid  tcg_target_extract_valid
+
 #endif
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 9cfb733a14..12dad7307f 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1036,19 +1036,61 @@ static void tcg_out_deposit(TCGContext *s, ARMCond cond, TCGReg rd,
 static void tcg_out_extract(TCGContext *s, ARMCond cond, TCGReg rd,
                             TCGReg rn, int ofs, int len)
 {
-    /* ubfx */
-    tcg_out32(s, 0x07e00050 | (cond << 28) | (rd << 12) | rn
-              | (ofs << 7) | ((len - 1) << 16));
+    /* According to gcc, AND can be faster. */
+    if (ofs == 0 && len <= 8) {
+        tcg_out_dat_imm(s, cond, ARITH_AND, rd, rn,
+                        encode_imm_nofail((1 << len) - 1));
+        return;
+    }
+
+    if (use_armv7_instructions) {
+        /* ubfx */
+        tcg_out32(s, 0x07e00050 | (cond << 28) | (rd << 12) | rn
+                  | (ofs << 7) | ((len - 1) << 16));
+        return;
+    }
+
+    assert(ofs % 8 == 0);
+    switch (len) {
+    case 8:
+        /* uxtb */
+        tcg_out32(s, 0x06ef0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        break;
+    case 16:
+        /* uxth */
+        tcg_out32(s, 0x06ff0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void tcg_out_sextract(TCGContext *s, ARMCond cond, TCGReg rd,
                              TCGReg rn, int ofs, int len)
 {
-    /* sbfx */
-    tcg_out32(s, 0x07a00050 | (cond << 28) | (rd << 12) | rn
-              | (ofs << 7) | ((len - 1) << 16));
+    if (use_armv7_instructions) {
+        /* sbfx */
+        tcg_out32(s, 0x07a00050 | (cond << 28) | (rd << 12) | rn
+                  | (ofs << 7) | ((len - 1) << 16));
+        return;
+    }
+
+    assert(ofs % 8 == 0);
+    switch (len) {
+    case 8:
+        /* sxtb */
+        tcg_out32(s, 0x06af0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        break;
+    case 16:
+        /* sxth */
+        tcg_out32(s, 0x06bf0070 | (cond << 28) | (rd << 12) | (ofs << 7) | rn);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
+
 static void tcg_out_ld32u(TCGContext *s, ARMCond cond,
                           TCGReg rd, TCGReg rn, int32_t offset)
 {
-- 
2.43.0


