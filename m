Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EAEC54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMU5-0001sU-Rs; Tue, 20 May 2025 08:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTg-0001Kl-Gj; Tue, 20 May 2025 08:53:55 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTe-0000u3-EY; Tue, 20 May 2025 08:53:52 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30e542e4187so4082032a91.3; 
 Tue, 20 May 2025 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745626; x=1748350426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVm/z5b/WNdO6MaO5hkoo2oUhPq3LCHlkm5p2hpglKI=;
 b=RnHl702K+maMYPeuo1KN+erRMZbfZmWSBo32GmmLdC8QL+Zi/OqpBj201RFu6Zm1fu
 gjWbxE+Hh0/7XjzJ1BeLDTVAEvGnS3qtaQtBjcm/UIyjgP/vB9Vhk3lfPKxbxwHtlBnY
 W1oo+ldKt0NhMHrhnCqmM9CI5wZENNvu5IcfGlV0eCKRcTdRySYWMady8X9mwtws9q4O
 pKi9bNDB3J++ibL5M2PZjv2L4XX6+en59ow3j/0AexB+r+lA9b63uA/lgTg8liTEsG1O
 vSBiEjYW/z8rgJoq9hHQ7j2ofkBScXvW9eWMr/M7ZE2E8IXkM2hbfWFgZqmI/QY9gyau
 9VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745626; x=1748350426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVm/z5b/WNdO6MaO5hkoo2oUhPq3LCHlkm5p2hpglKI=;
 b=xTL+1MbvtPF4JqGl0iz4EOxPdQYueaP//nzVRG7YyFaqKo6Q/8izswYE6ccqjj2piq
 nve83h1SkSl6a4p5Tt7FQoK0Bf6D+GcI8znW8BeDpspqId+22i5CfAOOKRGWnLStMieY
 3O/EVlTe1DgNuFJUoojUGIPTOt1e0eLCfQ5yCaPyboflV+T63YpPMUIpb1hz1YcayrS8
 AeNaZZ4W80D059c8dTcdCCX80AH9L2rFNBcuxLaFu0B4vyMCsEWbJ1So3U8pMGDaLaOP
 md96S0+FJbt+EmrzxXDHv2d4QjB60Kw0XduVPvpt71+6DhWJuavSyMIfYj1/C/PCSEI/
 84tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+I91WQY3VuTtgjxfTjnXDLAv1go2GfzkXre6kiDMpJIUwv4ehmIsTxwFFFD1rCoaHB3teHDq52GzMpw==@nongnu.org,
 AJvYcCUwHkeJnAKYI8OeFYZuTAo8rOYvnpe619AFpnEnIVbmSzUEU5mC3mPWzneAvDyra61yFPNcDBPw8A==@nongnu.org
X-Gm-Message-State: AOJu0YzTMUeP6SlripAVskC8zpTi4n1mS5PbDyWh2bMKu5hdziMf0efm
 sP93ZRhF1f/zPGEqrfESxc7uZ8Y2iyiBDCMGXS6rt1k75JxkMHW2l11cYgHxhZYR
X-Gm-Gg: ASbGncvBqPhLWHgg9jyq8t16BwXCT5D8xh4Ns5ulbTEue4a7tC19BJIkfMBoaxnJgJL
 QSIdKnIX6kiNc2VPuFaBiyCMHIOJBoDKOgbZbKdHvyTk4HQVtg3dMtN7tLUoFdBQoNZRS4EmnPu
 4nnalQnTiaVtlAtuXOqxgHtRsher4k2sSeK8wmBKDT1GfKU3+ztGxvraS+OlKyIhTJCvyXv9CZS
 3hw9zq3w49KqWbIdrKEYQuBdHraDtlQcIUKw0bujFCW2PwfLrQkvoNKd983z4XUJxqGvieps/vd
 WPyITSzlB0li2VVVBhESY2yv8v5Qky3chQyfutCmoUu7MQxinAg=
X-Google-Smtp-Source: AGHT+IEMrdC1V+LESFaMuMDw5tT3hhKjWCJ/qaG6s6FWhGMJ038w54wCgcmH9JUMZKT3Ksn+vd9Iow==
X-Received: by 2002:a17:90b:28c5:b0:2fc:a3b7:108e with SMTP id
 98e67ed59e1d1-30e7d4fea80mr26291198a91.4.1747745626401; 
 Tue, 20 May 2025 05:53:46 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:45 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 16/33] tcg/wasm32: Add neg/not/ctpop instructions
Date: Tue, 20 May 2025 21:51:18 +0900
Message-ID: <d8ade887307f6bea4bf392a36c02657204db939f.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit implements neg, not and ctpop operations using Wasm
instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 39 +++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 50d772f3d6..e5de2f69bd 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -200,6 +200,10 @@ static void tcg_wasm_out_op_i64_xor(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x85);
 }
+static void tcg_wasm_out_op_i64_popcnt(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x7b);
+}
 static void tcg_wasm_out_op_i64_add(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x7c);
@@ -570,6 +574,29 @@ static void tcg_wasm_out_nor(
     tcg_wasm_out_op_global_set_r(s, ret);
 }
 
+static void tcg_wasm_out_neg(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_global_get_r(s, arg);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_i64_add(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_not(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_global_get_r(s, arg);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_ctpop(TCGContext *s, TCGReg dest, TCGReg src)
+{
+    tcg_wasm_out_op_global_get_r(s, src);
+    tcg_wasm_out_op_i64_popcnt(s);
+    tcg_wasm_out_op_global_set_r(s, dest);
+}
+
 static void tcg_wasm_out_shl(TCGContext *s, TCGReg ret,
                              TCGReg arg1, TCGReg arg2)
 {
@@ -2056,6 +2083,7 @@ static const TCGOutOpBinary outop_xor = {
 static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
+    tcg_wasm_out_ctpop(s, a0, a1);
 }
 
 static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
@@ -2112,9 +2140,15 @@ static const TCGOutOpUnary outop_bswap64 = {
 };
 #endif
 
-static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+static void tgen_neg_tci(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
+ }
+
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_neg_tci(s, type, a0, a1);
+    tcg_wasm_out_neg(s, a0, a1);
 }
 
 static const TCGOutOpUnary outop_neg = {
@@ -2125,6 +2159,7 @@ static const TCGOutOpUnary outop_neg = {
 static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_not, a0, a1);
+    tcg_wasm_out_not(s, a0, a1);
 }
 
 static const TCGOutOpUnary outop_not = {
@@ -2157,7 +2192,7 @@ static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGReg dest, TCGReg arg1, TCGReg arg2)
 {
     tgen_setcond_tci(s, type, cond, dest, arg1, arg2);
-    tgen_neg(s, type, dest, dest);
+    tgen_neg_tci(s, type, dest, dest);
     tcg_wasm_out_negsetcond(s, type, dest, arg1, arg2, cond);
 }
 
-- 
2.43.0


