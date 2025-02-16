Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6B2C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyO-0007ie-VJ; Sun, 16 Feb 2025 18:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwf-0004OQ-Sm
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:08 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwc-0006TD-Q7
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:05 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cc39so7118320a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748061; x=1740352861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bmk6ZfjcUictTTcvWQnXhrk1XKxfh8uaZLHmYOMw2HQ=;
 b=hl6qG70p77OVdgEpOCvu01++eUlqItAkwRhptozHRcAFeLBMn/fZuEv8zGF1s2Isnl
 +SYikUrTjlxVnZm9W4KPnz/gUKzNhuWGNZkLanB76AyxdiMcNLEULFdieG35L+lfLDmR
 Y91BmLm2vonCH2Ler29uJvi7FJoLX20aShMtv7uWOFH2R3Mvjm3nx3Jjr1rxzNiwI6rN
 l9bz3U4XWaZzZW68GLZfkGRZnZMbuWZjFYHZrBeeFlL3mPVc6Blthx5G5ORiQ4GXQpVj
 w30NwPkjGOZiXOKfAx9/FL+GHaTYLabIBbk1T+woOgX8zHHBYKonV8oobHs1xxhgGF0v
 m1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748061; x=1740352861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmk6ZfjcUictTTcvWQnXhrk1XKxfh8uaZLHmYOMw2HQ=;
 b=KIoo/r+HgV8yY5tewspoNDO2s1VSErp4Bl6gmwET7jf4mhjMjF3XajBupNJLOF8TCK
 p+pMc7h64BHxx+cU/WMg08q02oNEACQP2QrqvXdgt6dvljKkdfqQxqLpM5Ser1ft/kqs
 PDzAs5Xwh44C1pmQ3d/588yBEwLuw+pTMSUjJMmKG8ibqH+juhbbhPUZ+vTM1oj8W2aR
 qR/BKFLO+gGgbkxOvtzAjd4nPnJU5xWSljlkB794KeDCmA7TVs8Hmphin9BBVBxDU+Rd
 0L9zAlnp77dh2IxaFHNaGwhd7RS10m1a9n++/qJ+aCtyjQDTgopYquHN8q2gVOt5sv8c
 ojDg==
X-Gm-Message-State: AOJu0Yw3535pKljAT9lXzjuUwqPOa8ZpxGH9IYYKfxM/sBd334sXX0ff
 joUxAcLsj4S7LfmKs7vZehKIpKiabnJb4TPS+LHEEhLvqf/sIF1J053+G68TELKvI1n3/3MgTsq
 g
X-Gm-Gg: ASbGncsYNowwWJCRF4m3MTBGUlZI7mWmQSpZvUG/ydFz8c44o0vHABKtQV1sPoSbDHr
 ZrAmGn06HYcRxTLXGzLejH75HOfU3rW5k8N5+HBNQf9vekAES7Ukwn9lKqKqSWwjaRVW/t+Rb9r
 ClfjRAa3fiU8y4t9/DB9MGrhCWKA7YMtY6hu0G5H2hc4WuYuWc7A7qx+jnDzUF5GSvNEAIIU0q/
 Gw+hdNLt3H62zsvg8RBxioEiVDbSuh3nSJiCgmji5mpRlP0I2XnJtgQze9bfruW7QmtENUXZSC0
 PrrbVoKSJwgRBV1ADQfamN0EYgyCS6r2VIJxrd8KUxQ8d3M=
X-Google-Smtp-Source: AGHT+IEL5CrU5Yx0aCaZGrzMvs94DXTwJBxe+PEBOQ85HnMXtQHYU41aW7WdcZjGouVvOkZOZ/aQCA==
X-Received: by 2002:a17:90b:1e02:b0:2ee:c4f2:a76d with SMTP id
 98e67ed59e1d1-2fc40f21e2cmr10615316a91.21.1739748061282; 
 Sun, 16 Feb 2025 15:21:01 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 140/162] tcg/s390x: Implement add/sub carry opcodes
Date: Sun, 16 Feb 2025 15:09:49 -0800
Message-ID: <20250216231012.2808572-141-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |   2 +
 tcg/s390x/tcg-target.c.inc     | 103 ++++++++++++++++++++++++++++-----
 2 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index f5d3878070..0a991f6d5d 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -22,6 +22,7 @@ C_O1_I1(r, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I1(v, vr)
+C_O1_I2(r, 0, r)
 C_O1_I2(r, 0, ri)
 C_O1_I2(r, 0, rI)
 C_O1_I2(r, 0, rJ)
@@ -32,6 +33,7 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
 C_O1_I2(r, r, rNKR)
+C_O1_I2(r, r, rUV)
 C_O1_I2(r, rZ, r)
 C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 9b28083945..2b31ea1c3e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -173,6 +173,8 @@ typedef enum S390Opcode {
     RRE_SLBGR   = 0xb989,
     RRE_XGR     = 0xb982,
 
+    RRFa_ALRK   = 0xb9fa,
+    RRFa_ALGRK  = 0xb9ea,
     RRFa_MGRK   = 0xb9ec,
     RRFa_MSRKC  = 0xb9fd,
     RRFa_MSGRKC = 0xb9ed,
@@ -2259,21 +2261,60 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, ALGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, ALR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, ALRK, a0, a1, a2);
+    }
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RIL, ALFI, a0, a2);
+    } else if (a2 >= 0) {
+        tcg_out_insn(s, RIL, ALGFI, a0, a2);
+    } else {
+        tcg_out_insn(s, RIL, SLGFI, a0, -a2);
+    }
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rUV),
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
+};
+
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, ALCR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, ALCGR, a0, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_addcio,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_addcio,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, RR, SLR, TCG_REG_R0, TCG_REG_R0); /* cc = 2 */
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -2794,21 +2835,57 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, SLGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, SLR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, SLRK, a0, a1, a2);
+    }
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RIL, SLFI, a0, a2);
+    } else if (a2 >= 0) {
+        tcg_out_insn(s, RIL, SLGFI, a0, a2);
+    } else {
+        tcg_out_insn(s, RIL, ALGFI, a0, -a2);
+    }
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rUV),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, SLBR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, SLBGR, a0, a2);
+    }
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_subbio,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, RR, CLR, TCG_REG_R0, TCG_REG_R0); /* cc = 0 */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


