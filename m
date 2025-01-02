Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6F4E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbi-0007DX-Nr; Thu, 02 Jan 2025 13:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbQ-00071A-RT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbP-0005C6-0b
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:24 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2165448243fso190567375ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841242; x=1736446042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6BbOJGVKedcAH7Dn7J3WMmnBwhgk9Ccfhw3EFyhkC/4=;
 b=Yzq8pAYLc7P56RD5pahEBO1vQqZamNtYvhh4dQTBbCmzz13MXRwBXoLKXitbS5waOZ
 8XAyO6hVaGirR4VHvgmtO5bHMxT3WPdEdyzAizQ8wy7WcK9ewnnXWOhf5f8n+slZjYGe
 yxpevdPvmnwz3gtyCTDrYFLGdDk52/n3A5CfkT7rE6h1sWcVU+HJrpCTA+lDqQFGZvUX
 WUEAYnMH55LVVYy0Gb0EQ77GEx7GKCcfr1BngxygIg/Fig18KuR5ZT5CwImdmWKPnh8i
 WYcRLjQuyp18TSOkaBKRAIszCo2As5hAnV/bay8towQWc6l5lJjFGXg+3jgMe6tulv1P
 RMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841242; x=1736446042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6BbOJGVKedcAH7Dn7J3WMmnBwhgk9Ccfhw3EFyhkC/4=;
 b=XXKisH+edDUccpNcQ7c3ssIud3LLCkGekd0dD0nAx4IwgxPITLJDELlVhDQtyzcRPh
 8O32YZyiyPGxcjenn+sF0YhkpLtQFqvZw6it4IyGREIDTQr/QVUnxcGw0kMD13legML4
 ThGN3hBIiRCjnbbi6MpbCVuoOr3Xexsh3+fAJWF+uZLC87YYwVue/iiZGV+Xp2YSreT7
 i2G1XkML0uEjB9Fnh9E/Zm5as3tbfYwjPMURaYOwV50rrW8EUR6Ck75wbSO75+7FvHR6
 t/C+zSUhOalzU8lpbUo/IqHIC53ou81FzexPScRiFuYoANO1UDjDktSKJcwSO+u5J/NI
 QKlg==
X-Gm-Message-State: AOJu0YwwWbqjohZLaEK3hRqOUkxgbF6CNdONpU+UXjNElRzSVN9ulShh
 w+IKCX/QLMaSY3u9LP55/tYOsgRBTVvymv0M0sYAKl8ZiBriphe9f8zo1uInY98PU24yDsYrwRB
 j
X-Gm-Gg: ASbGncsfy5VBHCI2dfcVJoybDNb3KDir06kt+x5b/e+j/4a+Oyi+rjW5Gv0ZipPo+Uh
 Pl78T27qt8XnQpjOAeC5CuGApdsSCKQIBAFMJ2fcCFuRiPbsKC958JDThAxal0iKw3eWuiyaICv
 ej0sYCJmxNLeYczlc17W32r6UaSXcOF4d+f4lWeImaYeWpXZS+6iNc6+2v5txcVaDSDcv9fAcjk
 TXQzJZaylQ57FpEl9idDdfAIW5ldfU+5jytTLb/B66aW8eocYssJx323yQRMQ==
X-Google-Smtp-Source: AGHT+IGK2Xp8ZR2OOPBC3inJW6UvXLtCCNUu79x9laxezTYzcSsvkK5jhGoPY1lhAiXfv3prqIvEAQ==
X-Received: by 2002:a05:6a21:9102:b0:1d9:c753:6bad with SMTP id
 adf61e73a8af0-1e5e04647c8mr64854146637.10.1735841241702; 
 Thu, 02 Jan 2025 10:07:21 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/73] tcg/arm: Add full [US]XT[BH] into {s}extract
Date: Thu,  2 Jan 2025 10:06:14 -0800
Message-ID: <20250102180654.1420056-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index cd9b68a024..6990968b06 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -80,4 +80,21 @@ extern bool use_neon_instructions;
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
index 90ac80077f..44b7c6d185 100644
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


