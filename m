Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0889EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5l-0005kp-IW; Fri, 17 Jan 2025 13:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5f-00050r-0C
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5d-0000FY-2T
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:06 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216728b1836so44552175ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138543; x=1737743343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWp2/JFv2fva2VTRy/d8GxCMMgAUanLYBFx81Z63oKk=;
 b=V8KaUMTkGiukZ731Py50F1jIl2aGlOoq/Oxrm5+m/IY0tYy9nFbsak9W6fAy5jJkH/
 E7PeUcMEV4kRhEGl3tOD+CFuuZNCC8PYXAnQkzMP6lzFmg2147oE5Ff8E7OgQQYu+e7Z
 fRNuXEE/HjbeA5dpQu4DcM4+FkH+gxHjw5DViqqchb/QK6pP2wTYPg4aDUU8BhKCVMt6
 IvIWTfw7DUh+5q0K8ecXXtWhA4OpzgiH8bBmI3rbikaBwaBteQBNKY16VK8iAk8G35MX
 imoRgIVxZLqmfvGL2kRxCKUE8se38prj8c6FnA/krvYBMRdOwOoow4AVQ5Yz3F3Lz1px
 ZskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138543; x=1737743343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWp2/JFv2fva2VTRy/d8GxCMMgAUanLYBFx81Z63oKk=;
 b=QjyxLplLc2MuPPw89iqDIFefZYx9SdKAuN4Ey4DhlEP2alVIaafe2Aoq+J0X/KO69G
 ATWo0mx/wRp972z29Q9a6YHXQJFciI78USkEuFWQeTzYjePwijAYkeQ1dMt18wdOFznv
 pmHE/grxaMIqJAyzEFve+cgxckNRfePsgPjsloKF+G8yLg3FnFUtNKrtsIPBypVNENDx
 3F18KBxm6ytT6lg+ACBZAzNvj05s/xFZfOyH9ldkKE2gXuO/CFkqwMya15cNoceFn8JI
 C10YXBRg1jKeKfOMDTzApqOV4FzeFP1/jEF5UeVWhPMqxFwx6F3dPC3KKb5d8Qs0YUnR
 vUhA==
X-Gm-Message-State: AOJu0YwAUbbgFKWpPtd+SFFYD9qpofWHxwK9dGO56NQxU28HxiROArFo
 G/Q4yEuhghpRVCcDnvloAfEfP6btpVqGvgkJkLZwqMauQXsbKG1bhEbG8/ADN3kjifAdKM6cUkW
 h
X-Gm-Gg: ASbGncukrp0mY/VB2bg49hw6NISl5eQFVY99wcC/67qX7xVyfTOoXtpmHyjds2wYows
 3/6Z0nRFH+2onFSj8GeJjyP5iX92bHBsJglppUE/BD/AT1DTggZYXSQRFFjh6XGvo2QiwpleBY8
 pHSaDYcf3g+dvJCAQhx8x4/XAIrSRkYoQuCaSY0f65WGCtZdXIrOH7ZvOpc17Pw1VEYYz6p9m/K
 0qYD0SxZj5TIlOZndAh+5kcLrD1dRBloBn47GDKe/H4H7iR1gIUY9+5WBQCphilOCnKJ4OuJ9+e
 oIs7pssEFQxFfZ8=
X-Google-Smtp-Source: AGHT+IE0DQs4nFw2lwWbJskcnD31LHQgyDTjZh5a0pKrUIv6SHuOU9mgHqEkSJjDVwf5My6OXt+yUw==
X-Received: by 2002:a17:90b:3503:b0:2ea:61de:38f7 with SMTP id
 98e67ed59e1d1-2f782d59adbmr5059850a91.29.1737138543528; 
 Fri, 17 Jan 2025 10:29:03 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 51/68] tcg/arm: Add full [US]XT[BH] into {s}extract
Date: Fri, 17 Jan 2025 10:24:39 -0800
Message-ID: <20250117182456.2077110-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-has.h | 21 ++++++++++++++--
 tcg/arm/tcg-target.c.inc | 54 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 316185500d..d9f3311102 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -41,8 +41,8 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
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


