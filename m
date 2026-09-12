Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A86C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1x-0005rB-KP; Sat, 12 Sep 2026 06:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1Z-0004uG-Ix
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1W-0007KT-Pq
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2db710396ffso24952255ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209113; x=1789813913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fyxk1q64cJSDBV0Wp761OrEHC9nf26N8EGJTV5SbsQs=;
 b=i3wlBY6HIHVfVh7s7yrc3yPdmmO0htrCkRN+/dU/HSgTd/KCMrmSiIgGI8iu+g8Kna
 UAeHepAXtP2iE8+ucj2YUlAq+iAj3by9nJu+HcvgkRa5nvHTyy1DIPe+95sDyliXSpJ4
 28dr8nSqskF8wtE+w8oogRtkiCXNRJMBq/rfAHoYzi1g05OkNDOLUACP5V7mqzuIpzAD
 8nfBSWZMTf2K/89uU2bM3ofkTvqGPCbImcH3WhzYWAEB8SPieuXo629W35HxsY17ZS5c
 Kik+o8pYGUFbFKnVgtgoimF3C10Q9EU6hbiISSrM8UCM+y9DERb3RikbKhJSdO0LG7UK
 Bs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209113; x=1789813913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fyxk1q64cJSDBV0Wp761OrEHC9nf26N8EGJTV5SbsQs=;
 b=JIYdCSqddUNx7MzkzIINmYMM6Lqm3bxiKwbU0v/+3ytH7hchpVbAxP5CIi92ri1lsh
 987oDRdW7g3B1tuM9Bd2Yjujf0hsJptRGa8U4ZPdv+0MxJromUZSY6CxwOUe+tjYm1Fm
 v5VgeBsZ9MgmhmTNn+R1sI6Y+JMMnKOShyWKWIAsU945CLesuqGgB4brxrF2W1dWNowx
 RWPzzRSYLTgx9BuwZiaDlT+vEIp1Ax6QAxs2fPjPQxo4TBAzlm2mANglW1v4Un190SV6
 MblxANnUz4c53nIDoDtKcfQQpkPg77fqTxob4uy637WCxr6ddSEFkx/Nn7BhOn1LEqk/
 VASg==
X-Gm-Message-State: AFuF++n0eT/rBiR8DYVCfqE2g5O2FukYvoGZtjuJjqO8slM1HEDYrS+R
 69gVlazFBBjar0N+n2LxiqqllFI7UPYPe8eaZ3mzWLoIN1TWzYWEVSFP4Xcf2C24uO68XRs+elq
 aOzOX
X-Gm-Gg: AYBFou1tKTYp38oIYJHQOPylI8XhGCHefyPOIZiPk2l/ZdUvdOBoF1gCw+xE/7uCPfX
 qYkq9N8OK2GyoOx+o3KewcR6hZtgrpJwSawMoZq7Ivrx9pPb3umsycnPuaceJOcaxovI5mbged1
 MvRwzFrDS4QqXsDvgaxv6ZXON/BdgyFmgbtmixdAScuZF9QYo0sMtY25KUirofI9ysYZn/vuKwN
 J2QI3cnDcnr0uvFJA+SRfsyGCeJIXEcucuhx7cpmq3EGWmPOwamX8eAt7xL70YQmNmCryMWfY6O
 pGW1diZAHBXE7BLx3xkHX24PO0J8Io2tt8Bz3NjDYMJAZ9M/EtN10MtNDsfProENEnUMNtpLgCX
 ScENhSCeRpCh1Mvk+jzQCNVt2HtfYtPHVrrs43KGWw2/p0wlMLqQsQrMC3xYIUhAQVIsEzPKojb
 PACXxdbwddtxIByqzrGF+3i11juBAuwRSw3WjbgY/x2cs7/naHgQrI3eoS9N1iCImsu5yrhIc6O
 Obk9/lUbAp2qizcUw==
X-Received: by 2002:a17:90a:d445:b0:398:c6e1:dceb with SMTP id
 98e67ed59e1d1-39d77962e7emr16053540a91.9.1789209113116; 
 Sat, 12 Sep 2026 03:31:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/82] tcg: Generic expansion of tcg_gen_not_*
Date: Sat, 12 Sep 2026 00:30:30 -1000
Message-ID: <20260912103126.598030-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
 include/tcg/tcg-op-common.h   |  3 ---
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 28 ++++++++++------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4cba6cc7448..4476f9dbfb3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -201,8 +201,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
-
 /* 64 bit ops */
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -256,7 +254,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 247db4b15f7..e3935b850cb 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -5,6 +5,7 @@ DEF_RI(movi)
 DEF_RIR(subfi)
 DEF_RR(mov)
 DEF_RR(neg)
+DEF_RR(not)
 DEF_RRI(addi)
 DEF_RRI(andi)
 DEF_RRI(muli)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3811b6721a2..bf48db8b684 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -440,6 +440,16 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_not, type, 0)) {
+        gen_op_tt(INDEX_op_not, type, dst, src);
+    } else {
+        /* Do not recurse with gen_xori. */
+        gen_xor(type, dst, src, tcg_constant_internal(type, -1));
+    }
+}
+
 static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
@@ -576,15 +586,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i32(ret, arg, -1);
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1836,15 +1837,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i64(ret, arg, -1);
-    }
-}
-
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


