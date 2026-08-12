Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19505C5CFC1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwsx-00045O-MB; Tue, 11 Aug 2026 20:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsv-00044a-Be
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwst-0000Ti-Od
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8485bd28dd0so509748b3a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494714; x=1787099514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iI509NUBVNDZPEMf0tnn/XHTHMqXogdOb+FwwTjBNmo=;
 b=uWhJw82RkDHS/CAJUYksXPlVWuUQ9He58w7nZi+/3WCMPzfDCiOhcuc4fCUvpLc2uK
 7tGemTwQNRhPzx5lqXDbe4JoPvFSbq0Rk5cY1OmjNHLE2yxI7jjLd7+VEVtlYLW5CQo/
 UYHVuKdn6AUwZjwdroLeT2GEkSusSyAyV9BY0Dy2iIZftWP3xdl7Ic0BQ87ICbxurhbH
 90nXD0o/GbjDiQAE3mnCSHeTUPMBh6JZ5vlqf/RwGnD+Lij2kgjQAytByQimK1pBKxal
 jLjzrkAx1VPUsK2kbV41dDGctYWUeyljOu68wXSU5jtVq5XUs1ajvrl7qU/t/+iDqL3i
 XNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494714; x=1787099514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iI509NUBVNDZPEMf0tnn/XHTHMqXogdOb+FwwTjBNmo=;
 b=csSOO6zn9iwzeZOZMV7HzsEu/EDnXPyoMmJgg7+QC9Aw1C2qABwP1W9JKlxVZ6sB3C
 /1McluFVC8vEfA4Gcz4HmP2V/EA93mYeaYoiM3q+0KE6NSR4c5zJWhpmfORbuh+8tNBP
 mQ37FZoP+1Ag74vaYzgxr5lkZi6kFk/yzIbGBUtAU/nklmPgI00aw+c8rzhJHQ/KEAuA
 O9Tu6R/ggvYV2IXVTTKvmXG+T0bIfEFfEZq/aFLQGL2wnXFG3FPcGZHJ747NdjxlYMCg
 JQFnUs7FJzK6mqQ/rgdPvMsLu3CblkxZL2BQkbVDC2YjYJCXBvX0R+/xQIZaGD4E5L4J
 RgIQ==
X-Gm-Message-State: AOJu0Yz1jPjU9X3Hxs9XxctsLBlI09fSo8/8XZnkFREzHPypPts9Op/4
 WLm0/N5+55reOxPiyBUG/TMBfbsMPANWDVAPonq/EQ5gzOKBz/wi1Veid4MddKREosvOXMrCPk7
 JTBiV
X-Gm-Gg: AR+sD126ZO95npeIKCgVBB45YHSdzgymrNOyDOIwP+097U+t824wDja3nv6dVB8IZ1T
 Bo58BGzVK5qvt196523CFDT2f/asKnwJoSBRTPYrybymch4VAEXZuLR8QLZCsgp2HJO1zTYWQU0
 3PofEyDxLE2Xyq1CAetFkj/I+Ch+Bp6SK0nFxUf7E2+d5e+pHo80hPcyEVBAxgHyHh3+lCEfJ0m
 GIQdMG6AJsyhb1PxGbXqLSZWeQIcAJVzvKzdnkLCZDR7nwzXwVutDwJh1Vc4rupd8+QcJaQhhyG
 OAdC7ToFgqKOR40HFTdZj83IJo6XJzR/wzPL5aKzTITEe7RhegClt9n7iCMb+NSZMQ6NPyfW3wx
 gxDR5qoVp1KQkjjKi/umv+oP8R3c3jivE43NKDShlaI9ZRu1uV9hHM5sE8JKiZybhGmAW+gty1C
 2GJh/oVcjfEXcc7QQSFiOcbJ40+BFAPcMvt+s2cQoD0B8OYsBXPjJZqGH90WVuKj3yecxyvhY09
 GvfVgOtmY4ZqB/WvZWP
X-Received: by 2002:a05:6a00:8088:b0:848:76c4:fba9 with SMTP id
 d2e1a72fcca58-84fb53c14femr1353473b3a.7.1786494713987; 
 Tue, 11 Aug 2026 17:31:53 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] tcg/aarch64: Use CTZ from FEAT_CSSC
Date: Tue, 11 Aug 2026 17:31:43 -0700
Message-ID: <20260812003143.225228-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812003143.225228-1-richard.henderson@linaro.org>
References: <20260812003143.225228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


