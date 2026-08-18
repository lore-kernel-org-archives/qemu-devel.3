Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E534AC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCi-0007UN-Fw; Tue, 18 Aug 2026 13:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCg-0007U1-PU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCf-0004mu-9x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso106106b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072540; x=1787677340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VhlDEow7kayv7qRQDlE/Y1wsQ2IfOPvBYG5/m8i8FvA=;
 b=ujXYhY2PDFnecL1N52uiAmFTzp0pDxVUficm92uZuG3agdvVyLcIXcLkgvxKXyVX7N
 EyB08haTm+i5Ldqy8wri9p9swb6rldDDufWLAPGGoh0c5CyCx+AqUp9jKjigjQFcHSAR
 vDWJQJ5eyOGndnfgu3gt50tdorFUN2HmY5JAxPye1MsoUrUHds+YFrn0ppNvsb3Z5Wbw
 xeRlPjig4wU/hQUkNRQgjAqf7lY+orXolOWllDRbk62JFRhVfaixOwhxejYtwMyEuE2Q
 MABsWJMzV7w2pCbVqnVB47m7/sw5wKNKAUEvHyhqx0E8jaDOci5qmWXmr/q1zWZPQrcb
 ++KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072540; x=1787677340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VhlDEow7kayv7qRQDlE/Y1wsQ2IfOPvBYG5/m8i8FvA=;
 b=IsJCP4bf4ZTgAR+ulYKw1nTptZpy23qlArbag/qbKiyvGdnCw7qHQ1Wkksq86KVaI+
 Q3L85qKtQTgSIMzIJY1FAZ6RyrUGi3VYemnO7z2JKIY25oxmhtheHFQL5ok5CVHJrVcb
 5PTbmJ5K8N2ZdcJcfNlo7XK1HIg3lEuPvUnW6eVacM3pzJknLbAIDCQ1zF81zsflt71x
 vAFgGd1mG0tJ+4Amr1aZf9PuaE3T4M0dJthpuPL3P7qkraMDM4BIITwn0F3xAP3UCibT
 S3ftSAK4c1rD4YsbdAeDm3cQ278EjmRChCV+8GF0ODoWfGx33zC2G1jeM1jE5A55Ygur
 s7EA==
X-Gm-Message-State: AOJu0YyczeUAYTJIjS46dL61QURQoUyRy18uuBNu1SqY4Pd5WZvanTS4
 irDsUMPrwuv/LvD6nOt9AhByuNy1nRjjS/slWVsYuh/HvnlZiERClP9uwlzeDXjsLeLEsNBG2/x
 I7sM+ZxY=
X-Gm-Gg: AR+sD12Y3z9qeQDrrHq9m2NC722E2dpUAmLA9vZ0aCojBVcmkl5Ljp34KG7daAUphwd
 FHiNGvNLO4svm659iGs2+PTHz/DM66qEPm9UohRJEFqxFptRVDKG1hzuOZJIlCDi0MBZy4n1TbU
 ISRQRFAeKYTM0KFS8/us661Oj2fzhheBEdjPHf2vpBOHrRk75MnuJ8saqBp5LXzAz8sWb7+rTTS
 y4Oq25YsIxb4ofklGO8Fi0AMAlCUvEnINkLPtuHfMm8asxv8ATOlF374MBZ6gyWrBOjEfZ+1mKi
 0W3Fdxgvm310y4TT+uBUiL56cNbmFTmirwJjwbeEJdKPHTg+Xq+qDKER1gka5qXuhWpXb2H9gb8
 pEi8DSPo/rczC+M7PDfiCodLcnlodKBf9X3uDFDwuyKr0OIfep62lvsnUhVLJs81SmNzIv186ID
 pLkXC2pJL31/R19b6P2mWNRhyIUOgtsKzbv6FJAiad6Sv03hz6bcfq92vbJ4RO9h7lsPsMVZ71h
 5zxiyswl1p3LeHGKiT9EDOAtPBoL0e1P9te
X-Received: by 2002:a05:6a00:2d98:b0:84a:646f:193 with SMTP id
 d2e1a72fcca58-84fdde42b9bmr35973790b3a.0.1787072539610; 
 Tue, 18 Aug 2026 10:02:19 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 18/38] tcg/loongarch64: Implement revbit{8,32,64}
Date: Tue, 18 Aug 2026 10:01:35 -0700
Message-ID: <20260818170155.1907006-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 97ed51d99c..7d89e80886 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1866,16 +1866,44 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static void tgen_revbit8(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_revbit_4b(s, a0, a1);
+    } else {
+        tcg_out_opc_revbit_8b(s, a0, a1);
+    }
+}
+
 static const TCGOutOpUnary outop_revbit8 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit8;
 };
 
+static void tgen_revbit32(TCGContext *s, TCGType type,
+                          TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_opc_revbit_w(s, a0, a1);
+
+    /* All 32-bit values are computed sign-extended in the register.  */
+    if (type == TCG_TYPE_I64 && (flags & TCG_BSWAP_OZ)) {
+        tcg_out_ext32u(s, a0, a0);
+    }
+}
+
 static const TCGOutOpBswap outop_revbit32 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit32,
 };
 
+static void tgen_revbit64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_revbit_d(s, a0, a1);
+}
+
 static const TCGOutOpUnary outop_revbit64 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit64,
 };
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
-- 
2.43.0


