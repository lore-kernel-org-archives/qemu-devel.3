Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21367C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jr-00015H-PP; Fri, 28 Aug 2026 18:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jp-00013U-BU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:05 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jn-0004PY-JT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:05 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso1711685a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957102; x=1788561902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hIy0gb0lzwTqaMIKaxxUm5Ba8igXz5ompfZG8YNaMiI=;
 b=FC0o6SjDtEnbiDOG3I72SW7QGpQ61mdAwUt2zSspKYXPUTrB2FfbK8SFEM08lqn4Wo
 JhP32ZBhk7rRwaVNIy3dri8F1WcGOC/lDWv6g4hxn9blnIOoWeX72iYC6rHX1gA1cqMs
 nrjnRycqFbv4l0Uh0b7dOrD08qownbqxL6fA7qKdTt+h/zTgKgl+61A04VxGJiFvcwRp
 g2sIcCwMXZFDcI1m7TUrDQvfTLgDVf4uxMfsrf9Tc9LwqEcPqpGj9mvOP/QrYEGscvVZ
 pxqqXdMf9SnVAHqEQg1AfED+LOpZJ5XdJxoj902l4eDimjbOZVgGwjxmyM4iNbUfAHSt
 BbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957102; x=1788561902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hIy0gb0lzwTqaMIKaxxUm5Ba8igXz5ompfZG8YNaMiI=;
 b=ncQJorHZP9kIpXQsZIx/Ie9yQhmD9IEnRiGRZcrWOcyj5Nc8aEb8ts4R786JBVwBo4
 K0Ud4siBSQCjgMWHfaVM4vvsJJ0BH075/uBljFScMTt2Rc17qyysOHqJs9eSojuvOfA/
 smfVQsd1CSkb5lEBKO5Y2SubtNfxjOXgzaMj4pMS+l5dTHLLz1WJISYsOUs4M+MF70S7
 tYrSE51Gw4Vma12D1m18ZQBkG5oZ7m/1+0iQlxTGhHc4pRFnsWmoiI/W1+G77mPjhzVs
 lIIRIiCtNQ7OhFHQ187chNHBnv1zQkUe0krZwt+Jz6sptkSziRtwiSLCx9sVoIKaAaBs
 LMkw==
X-Gm-Message-State: AFuF++n1MNRKTHsy866pv53tLdiNBAAh41cFW3G4TMfgIKzco1ea61KY
 fP2lXolToHivMyW46RynL/J2ck1lH01ZXxr/2dp7ZEHxcDoVrROkeo+4bCgrn0ItffaohgF1TOh
 P0tMM
X-Gm-Gg: AYBFou2OeRFTrIuKHIQ7jHZuJ4LyHzwHCeb3+eFYDuPtDPts0l0V8JsZd7MedYbwWaE
 O/PsptoBADK7UFz/54BRf7sdNx812yWkAtXl3D4bN6R/t8eyoYc0AuubGwsnwSoNM02HrSFy5Eg
 QZGfuth7Yk+dMqvqX7FWUAxO7a1gcWPNbHzySDrerJ+8gIe8eQ4n5gBty2ZZit9dBPRdgWLCOmS
 ydAOxzbEsh70fIIJFjCg+mzzVGUEDiCQe5wcVMWX8c/8glkJeAib2eiCxJetPYtmbwdzpxTzuWg
 ZJbLclrb7O5e3HdTqSCkJEr3Y+mh+B9mm1F5OMmk+FB63fbF5hiOkyCQqi79capM5SA+FidizXG
 3ZxYQ8ZgX9/bPlC4eRN3Pez8KGVM7DWisCNfpiMxwLjSd6gCIUrNOEJA+6xWiSiQ9plPP7gYNwH
 UYYY2V6/QXqO+d7WTIL2QdnS+e3DZ72BfyGYvRLWPbklxZF+ADwJXggmgFn0eazdbxHn/M9TZWO
 HNK9K8NpKJOws2mds9K
X-Received: by 2002:a17:90b:57c8:b0:398:9bd5:4910 with SMTP id
 98e67ed59e1d1-3989bd54c5cmr4167868a91.23.1787957102169; 
 Fri, 28 Aug 2026 15:45:02 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:45:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 12/16] tcg/loongarch64: Import SLADD insns
Date: Fri, 28 Aug 2026 15:44:47 -0700
Message-ID: <20260828224451.1564072-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-insn-defs.c.inc | 30 ++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
index e907fc755f5..ececc6a3dd5 100644
--- a/tcg/loongarch64/tcg-insn-defs.c.inc
+++ b/tcg/loongarch64/tcg-insn-defs.c.inc
@@ -4,7 +4,7 @@
  *
  * This file is auto-generated by genqemutcgdefs from
  * https://github.com/loongson-community/loongarch-opcodes,
- * from commit 1b95bb8c443ad71e266120fd97bd227df2d8ecfc.
+ * from commit 2d84c975e8894afc8b3ee9b8559f10308a658440.
  * DO NOT EDIT.
  */
 
@@ -24,6 +24,7 @@ typedef enum {
     OPC_REVBIT_D = 0x00005400,
     OPC_SEXT_H = 0x00005800,
     OPC_SEXT_B = 0x00005c00,
+    OPC_SLADD_W = 0x00040000,
     OPC_ADD_W = 0x00100000,
     OPC_ADD_D = 0x00108000,
     OPC_SUB_W = 0x00110000,
@@ -62,6 +63,7 @@ typedef enum {
     OPC_MOD_D = 0x00228000,
     OPC_DIV_DU = 0x00230000,
     OPC_MOD_DU = 0x00238000,
+    OPC_SLADD_D = 0x002c0000,
     OPC_SLLI_W = 0x00408000,
     OPC_SLLI_D = 0x00410000,
     OPC_SRLI_W = 0x00448000,
@@ -619,6 +621,18 @@ encode_djk_insn(LoongArchInsn opc, TCGReg d, TCGReg j, TCGReg k)
     return encode_djk_slots(opc, d, j, k);
 }
 
+static int32_t __attribute__((unused)) encode_djkua2_insn(LoongArchInsn opc,
+                                                          TCGReg d, TCGReg j,
+                                                          TCGReg k,
+                                                          uint32_t ua2)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(k >= 0 && k <= 0x1f);
+    tcg_debug_assert(ua2 <= 0x3);
+    return encode_djka_slots(opc, d, j, k, ua2);
+}
+
 static int32_t __attribute__((unused))
 encode_djsk12_insn(LoongArchInsn opc, TCGReg d, TCGReg j, int32_t sk12)
 {
@@ -1426,6 +1440,13 @@ static void __attribute__((unused)) tcg_out_opc_sext_b(TCGContext *s, TCGReg d,
     tcg_out32(s, encode_dj_insn(OPC_SEXT_B, d, j));
 }
 
+/* Emits the `sladd.w d, j, k, ua2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_sladd_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k, uint32_t ua2)
+{
+    tcg_out32(s, encode_djkua2_insn(OPC_SLADD_W, d, j, k, ua2));
+}
+
 /* Emits the `add.w d, j, k` instruction.  */
 static void __attribute__((unused)) tcg_out_opc_add_w(TCGContext *s, TCGReg d,
                                                       TCGReg j, TCGReg k)
@@ -1692,6 +1713,13 @@ static void __attribute__((unused)) tcg_out_opc_mod_du(TCGContext *s, TCGReg d,
     tcg_out32(s, encode_djk_insn(OPC_MOD_DU, d, j, k));
 }
 
+/* Emits the `sladd.d d, j, k, ua2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_sladd_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k, uint32_t ua2)
+{
+    tcg_out32(s, encode_djkua2_insn(OPC_SLADD_D, d, j, k, ua2));
+}
+
 /* Emits the `slli.w d, j, uk5` instruction.  */
 static void __attribute__((unused)) tcg_out_opc_slli_w(TCGContext *s, TCGReg d,
                                                        TCGReg j, uint32_t uk5)
-- 
2.53.0


