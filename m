Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485BAC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCu-0007it-BY; Tue, 18 Aug 2026 13:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCs-0007hl-G4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:34 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCq-0004rm-Tk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:34 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so153537b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072552; x=1787677352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vGVbCkOEIOeLT7VoAwDE/N9IP+ngx75+x/kjdK+zKf0=;
 b=br6gsDs2CuhOhLKz8Vd6xjeDfRJM3GCrN8GefdizZXABXniH2K6tA9GDatMSXIsUDo
 uzfYu61s/pmS7eq5BOPYl+Pk85zcyRqJ92kLAIiDTq9TrOz7Or66ZDTYfG7TZeH5tVeM
 3EpsEsKIh8sIYUGxcSf+MF9NijpgUQ6qKItMgUaannxeBSeVBD2/R7GjtRW1KoAqFCuh
 TBCjoczL5jKwgqkoKYXf+doCu++Ag3TBJjJgaYEcKUcDXLgJEPmJfdmWD6vmrJSewQ1G
 6VhHVv81SbEJO7To7rtXLABoAJuZEx7pVXVa8w7JXeI7xBrCn/5HJcRalRbqqx15ouF4
 WM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072552; x=1787677352;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vGVbCkOEIOeLT7VoAwDE/N9IP+ngx75+x/kjdK+zKf0=;
 b=kM6ADbT7pQrs/7T9CmerhxwhabhICBtKksNGqSVdEL91KyeG64lOrT1OkWG6+2TjN1
 uWTtCz4404kA1VphT9MAljpqMT+V47KazGThzevgix89xIelIsK0PWQ8U/Vx3OH6u4rJ
 t/w7FxAnXvw6vM7OYccUfqUMwoa1ZmADQhjmZ8mHgGJ50nPPzS/AbNiHDGNfRVLEyZJJ
 rfyYXjNck9UbopEnsa5kvi37DEQGxS4HAIIPqyjMyJM7NzhNzy1You7IfDkwK3NaFWPL
 Wk34te6lD6NhV3IRrk6mRldr21D6pg85YisPncs9eDBzNziJDkomnYZ8Lge3XP/dM+iI
 5TVg==
X-Gm-Message-State: AOJu0YzHinFi5V/txZfq8mzwdb3zq+oct1H2pMnAeD+CY4NFwOzP2DfX
 ucTpT3lrXOHDXJsCIzxUpn72Rpyh7kQ3qL2tknsVBIboZuOJ5hbaZ8sN0GdBRTGTwlqcx86Z6jX
 K5tccef8=
X-Gm-Gg: AR+sD12W1cRK7rE8NQjsBi6YYNeXEjyckSCkk2P+hd3LJm7oMDZuVng4r5e5MhQgNbQ
 fw/zxStFngimBNE/8XClWzmgaEvmxCauUJQTkLIjZA1f1JSqgfd1Q+Dr1m3lpa8/YRdPTGY1ro0
 eqODDYn8/uMuoB2Q5yZBibbgbDRlYrb2HIyBBgMX/OaukhgNhvHqSO+U8tWir8Ly4d9Q4haW6Ej
 EmYcSsnXCVS14vcNe9XBLGEu9q6UWlWplpM6UfwJ7lReiF9a/yzyF19Oc/ZH/T66lGNbvi9FmOY
 0o0aYO8xMnu+cEa7FsFgPe5gPahsOqR1X8AEJD43Io7KGK4vHEteCJgS0phb5L3FQptjLKEu3Wj
 EDtoaxNMI2iFRCh0M17Q7cagzS9ECnP8+31IIOEs3jnQvzHNMYRXeEYbgaoEvTkOkqsk4cOQT1J
 tKhNdg/D2DRRWIlt28peL6HYxMnghCpb03HrvkKnhdOzGWdhChpgqKqxPBjNgJ1cwlH/226eX0/
 KEcKe5OL6GuGpvqUzG4nj5NKwJxzHtb4rM=
X-Received: by 2002:a05:6a00:3cca:b0:848:2c5e:305e with SMTP id
 d2e1a72fcca58-84fddfbf1a9mr36322248b3a.6.1787072551480; 
 Tue, 18 Aug 2026 10:02:31 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 29/38] tcg/aarch64: Use CTZ from FEAT_CSSC
Date: Tue, 18 Aug 2026 10:01:46 -0700
Message-ID: <20260818170155.1907006-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

We already have an expansion of CTZ using RBIT+CLZ,
but use the new insn with FEAT_CSSC is present.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 43 +++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 1f784e8d46..ce5c039557 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -535,6 +535,7 @@ typedef enum {
 
     /* Data-processing (1 source) instructions.  */
     Irr_sf_CLZ         = 0x5ac01000,
+    Irr_sf_CTZ         = 0x5ac01800,
     Irr_sf_CNT         = 0x5ac01c00,
     Irr_sf_RBIT        = 0x5ac00000,
     Irr_sf_REV         = 0x5ac00000, /* + size << 10 */
@@ -2213,24 +2214,30 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
-static void tgen_clz(TCGContext *s, TCGType type,
-                     TCGReg a0, TCGReg a1, TCGReg a2)
+static void tgen_clzctz(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                        TCGReg a2, AArch64Insn insn)
 {
     tcg_out_cmp(s, type, TCG_COND_NE, a1, 0, true);
-    tcg_out_insn(s, rr_sf, CLZ, type, TCG_REG_TMP0, a1);
+    tcg_out_insn_rr_sf(s, insn, type, TCG_REG_TMP0, a1);
     tcg_out_insn(s, csel, CSEL, type, a0, TCG_REG_TMP0, a2, TCG_COND_NE);
 }
 
-static void tgen_clzi(TCGContext *s, TCGType type,
-                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_clzctz(s, type, a0, a1, a2, Irr_sf_CLZ);
+}
+
+static void tgen_clzctzi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         tcg_target_long a2, AArch64Insn insn)
 {
     if (a2 == (type == TCG_TYPE_I32 ? 32 : 64)) {
-        tcg_out_insn(s, rr_sf, CLZ, type, a0, a1);
+        tcg_out_insn_rr_sf(s, insn, type, a0, a1);
         return;
     }
 
     tcg_out_cmp(s, type, TCG_COND_NE, a1, 0, true);
-    tcg_out_insn(s, rr_sf, CLZ, type, a0, a1);
+    tcg_out_insn_rr_sf(s, insn, type, a0, a1);
 
     switch (a2) {
     case -1:
@@ -2246,6 +2253,12 @@ static void tgen_clzi(TCGContext *s, TCGType type,
     }
 }
 
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_clzctzi(s, type, a0, a1, a2, Irr_sf_CLZ);
+}
+
 static const TCGOutOpBinary outop_clz = {
     .base.static_constraint = C_O1_I2(r, r, rAL),
     .out_rrr = tgen_clz,
@@ -2271,15 +2284,23 @@ static const TCGOutOpUnary outop_ctpop = {
 static void tgen_ctz(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_insn(s, rr_sf, RBIT, type, TCG_REG_TMP0, a1);
-    tgen_clz(s, type, a0, TCG_REG_TMP0, a2);
+    if (cpuinfo & CPUINFO_CSSC) {
+        tgen_clzctz(s, type, a0, a1, a2, Irr_sf_CTZ);
+    } else {
+        tcg_out_insn(s, rr_sf, RBIT, type, TCG_REG_TMP0, a1);
+        tgen_clzctz(s, type, a0, TCG_REG_TMP0, a2, Irr_sf_CLZ);
+    }
 }
 
 static void tgen_ctzi(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
-    tcg_out_insn(s, rr_sf, RBIT, type, TCG_REG_TMP0, a1);
-    tgen_clzi(s, type, a0, TCG_REG_TMP0, a2);
+    if (cpuinfo & CPUINFO_CSSC) {
+        tgen_clzctzi(s, type, a0, a1, a2, Irr_sf_CTZ);
+    } else {
+        tcg_out_insn(s, rr_sf, RBIT, type, TCG_REG_TMP0, a1);
+        tgen_clzctzi(s, type, a0, a1, a2, Irr_sf_CLZ);
+    }
 }
 
 static const TCGOutOpBinary outop_ctz = {
-- 
2.43.0


