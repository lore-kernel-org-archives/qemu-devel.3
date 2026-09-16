Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840BFC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJx-0001TD-BY; Wed, 16 Sep 2026 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJr-0001Dz-JF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJp-0000Rp-PR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:59 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so1722756a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563896; x=1790168696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sq8Yv+sp7tQR+JDzfb4K48KyhrUPcZRMabJqL0FAtTI=;
 b=K29+CkO0G53KfNgSAjSXlKReVHhunHVaYoTOb7Au/LjquHzHyx3695r8h/X2YUXW16
 V0PYK706O+piSzu2WPFHx0x3iOUZdzO6UcSJfnKx4HHJBq8FdjOkDY0eCDE2/q8/aSFX
 mAjD5hPBHYKO3a9tBIF0s3NWSvVHauIeCFAAHUek9MD6dh0ypcKKza8zfTLOiEaTXbf6
 XUyHSZ/KoZFiqVU39W+ycGMDnyz7nZ8fhrCxhc9/uGHfASGyydtz0BW7R1Yfar6+u11M
 SRV8Gf9nQeoThXG5lUdK4twnnARO1l+gafkScRGDEywMismBxvpPdFI/hBVJvFguLqzi
 ghpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563896; x=1790168696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sq8Yv+sp7tQR+JDzfb4K48KyhrUPcZRMabJqL0FAtTI=;
 b=d69c6Szpn+HJBcBloyZ71vADS/sbLrCnQ0473n09IJwRYrccSWlKRqyaM3z9I4o2C5
 4RAOlHc1elkeiTOS8m8vCNxBol3VWKq/lghTbsP9y/aG8cKuTSj73DDFRJAZkE0XqGD/
 +sYDhoe9Ig28Xovc+3/q2p8wAqMiOB36S8b8t9VTZD0XwQn0gG9I7fHQua25H6BEE5Th
 VEK0cXpMJr7d5watwPtctCmrFZxWTN2ZkqZMPrY+Ppv9Uxi3muUBqjog4w4GdNvJcB0w
 D86/KihWEW82GvpzA85UHTT3944lvpUxkP2lch38tRH86Y1/rqzLMioebLCgWj7cV4EQ
 CfOQ==
X-Gm-Message-State: AFuF++lso7ZrJzr4wBjRNXXs6PT6DX/jWlwHKiqV21gZn5V/0tT36+eQ
 0gDNKtTUsJ5ux8LFpYB9rZEdKdMB2cQRWZym8igK9+s17IAbs/9Z7QGiXzVO7DpuQrcONpZ2u8b
 M6pTcHXo=
X-Gm-Gg: AYBFou1MyBOxAKdlYPiQPWJDpDnrEun8pdXMnfAX4d7GD4W65buw6CRV3N4MMFXiEP0
 bgkldYJ3hhLII6PcJtA4zUDF4h/ni4N8leLV0l7TK6I8Ukrg+qPMiTrXscg4fVPhw+RzcQz67zn
 jmgo7U3d06rf7xJYTu97R6/H6byOxeh1mzaNGJ8j0bmXv2P1XCGNj3GlQvrBfew2lCuo4MEDsLm
 ywfy7mDASUVObHgo+2/8DxIfBFMh/n37afuDAj9VhGYC24eSFQIPjBmX75ATdsnbdc8SJ9u2DSY
 U7PPLK+X4ZtqrmOeQoIEACPgmJusIz0N4MZVq2ZhLTgH8ZYoVlJZc+9LxQ40SjC3NGYCGzpqFV5
 LWDkKLddgQar4ii4gUaJ1Tqhzdoc1Xtlyc7e8zaMe7wXSbQeY5I/bd4MXVmODWioM2kfuaijFxA
 uV3SA6hQ71UCL3Nqpu05y/mr438uCSukma0yFlV2SwIiZcmL6gqf0a+ZVU4ijYSQ7Er9w/0pTHZ
 rx2mzo=
X-Received: by 2002:a17:90b:17cb:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-39dfdfdb38dmr12222294a91.4.1789563896033; 
 Wed, 16 Sep 2026 06:04:56 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 26/92] tcg: Generic expansion of tcg_gen_ori_*
Date: Wed, 16 Sep 2026 03:03:01 -1000
Message-ID: <20260916130409.3382710-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 35 +++++++++++------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 57caf5f6631..a30e9972b86 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -210,7 +209,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 67056e9f730..2c3604cc7ed 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 198e1021ed1..2c7627e7cfc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -478,6 +478,17 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == -1) {
+        gen_movi(type, dst, -1);
+    } else if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_or(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -549,18 +560,6 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,18 +1526,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


