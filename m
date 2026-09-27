Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C9CC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkl8-0002kg-7y; Sun, 27 Sep 2026 05:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkJ-0002Sp-AR
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:31 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkH-0007QZ-MJ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:31 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d2c37b0bso558566a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499628; x=1791104428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J6Cr9PpEetbQL4BIvIhsyGl7iL3usw8kNCRnJG3H6oQ=;
 b=toJ/pgPx608nZcMR4PAz/mcJPtQKWcJNRVmiEqENT6261+5PsGdzVGRkxzuknLTWht
 uP/KXtFwKKeivh0x4Hml/t63ooo1knDB5Go/TjDW4yFdfgxQc0y2GNu/ZZOG5bAyJoKZ
 +pF9iJnZvXGpEyOUib/V+067d8Ml9nPc3a0pWlCrVL/fOZRMvA/v03lW/k4XbnmHYf9Y
 HVBTb2lftcH0/umH7R3BSCz+30aX+b6wRKZv3IgAIHoicPiF9ByJmTa1ANTzRL234jkf
 WMthIa8ygxwwOO2hRscJhQOZJbd1OamTv8zgs7tJOocdlPq2N0bWM/jaS7G9TRveuSzq
 px1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499628; x=1791104428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J6Cr9PpEetbQL4BIvIhsyGl7iL3usw8kNCRnJG3H6oQ=;
 b=GfIduoFCd1P4FO76P1LJjgsh1hsU0Gljx9K/PY9d7f7QxuGZJV50BmiCBeDoBLXYPw
 bH0VcJ5Uwb86eIzSvIzvJKFhPDj5pTzzWKwigmpHOjlCsYj4eTuqgt7YYXiWzWisYdcb
 vd4Q0hifzVuxlY6O9huCFANrAISf/CtxEvRcnhAhHCfTAIMRcIvFSRX/40uGjQIs9k35
 3QjnJ5YMb77rJlKnjwVsfxpSs0+z3iRq0QdDxuAVqO22qGjXsg7YrkH7xWLX0D6RZpBI
 6OOxUToUv/qgIM0a8sGiBdk6XXLdm2VDin6Mes3iAvYoJazkzW8iUPuF9nVCp4YtrqWV
 xWbw==
X-Gm-Message-State: AFq9FYLIQyyLfVRMlGydvPTF5h7hF1zNEsedir4OfaEV/LvSz5F99TV0
 13ZMWJQDMq+3Z0FA9/oM4ScQIjFX92s4BJ00d1bh6bjiqpTgDlig9wf9NtKmDbWHzKDDuncP6zi
 PtEM4
X-Gm-Gg: AYBFou233KK4R3sdHycVdVhAeeqQjHQ0xzTAYgckyIRSjoudEAfxmJ8GNSoxYPHzfQK
 zQVpKmAlZyqptIm/RcYD1eiRY+LXgMVTRHRuYMesKTv5aFDXSkg3PwHTtdd/3YvamVXWB2helG5
 T3MT3kZ1gqrrfNDbn1Jk8jgbOGkggiVCXqJQJMt7KC9kixwrXyW9F/S0UVr5oQVBEXr6fuuOeco
 DbJzsYiyoE2YzCn0OUk0uOz9vea4XXkCFgPddRVFFRoRVKmerjSsSbCYYqhF2t2tYlVJGEwZC5c
 Xnv353PoWw8GYuEnJkr3QeF9mb8OoDV/tGHxdk933PaerxJVJWcdG5JNv0ZJFzDq02ql26IbNTe
 cSme2Lox+8FtNvomt+/TXu6tNfLKSmnnXw2QCRQoD6Cwn2/3ETneF+p7zqA0gSLgVd7B4k2RI/w
 AtLUlC2OGONaU1ppchGz7yXDbUVu67YRYuJ0QawvmMSWVtv44IODBynemZVEJ0J9t+cv942YXrE
 5JE4VYVT8KNhOrPeDos3hDM7knLYoDYdXeGwJUi
X-Received: by 2002:a17:90b:55cc:b0:3a2:b4bb:91ca with SMTP id
 98e67ed59e1d1-3a2b4bb933emr358930a91.1.1790499628149; 
 Sun, 27 Sep 2026 02:00:28 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 017/101] tcg: Generic expansion of tcg_gen_subfi_*
Date: Sun, 27 Sep 2026 01:58:47 -0700
Message-ID: <20260927090011.10724-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 21 ++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index bce6be377ca..1ad18b10b5d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -222,7 +221,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b5ede945115..487ee5936ef 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,3 +9,4 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 37135fcf4b3..07bd0767fe4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,17 +409,17 @@ void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_addi(type, dst, src1, -src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
+void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
-    if (arg1 == 0) {
-        tcg_gen_neg_i32(ret, arg2);
+    if (src1 == 0) {
+        tcg_gen_neg(type, dst, src2);
     } else {
-        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
+        tcg_gen_sub(type, dst, tcg_constant_internal(type, src1), src2);
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1528,15 +1528,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i64(ret, arg2);
-    } else {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
-    }
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


