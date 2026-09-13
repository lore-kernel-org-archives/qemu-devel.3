Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BB3C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBC-0003N5-Lq; Sat, 12 Sep 2026 22:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB4-0002e8-H7
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:46 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB2-0001va-Om
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:46 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747f0135fso7281855ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267363; x=1789872163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A8xMZ+JTBPiyf1IH+K3UcpHGmlFbKNUSAWOxVi4iE3Q=;
 b=RBg79HOpizBWwTT3L2VI5nknmKJBx6W33Omc2Gp7Ls4Cwmi4hPpiNfCclXeR7aJKaA
 UNiw5IFUc0c4nYmLUdmlE/VAhgSRn7AYxsgujMyXoKUE5zj4rZkEOmf2MsWZbDObG0w+
 HJIgK9BPtNxFm9dSG443GD+8GaA9l1LsMTQfaFAdytC3IYNwZSdtV+kcYwUyBpx8yQeL
 2cf0t37p1/Wlm/584FXU9q2+1lOQ85/H7lDgXLKN3MZjGTXw8QhQY6QHr9WXzmtU2P/l
 QUNlHNeS0VEFhRwu9pO1+ws5jYt+me54YHpuEsvmIhS1W63mn55z7KSaukSjqWTWaouZ
 GdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267363; x=1789872163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A8xMZ+JTBPiyf1IH+K3UcpHGmlFbKNUSAWOxVi4iE3Q=;
 b=dwbZs3FX5m/rrFTTsgRAVXzU9oMikXGBmoKIlvoPoDFk6GsNTV98eGS4Y02gYCHnkM
 NXrm+mLJ1JWTHP7FHIPJsqNKCWfqQJWzW9BNmUlRqybsSZA3tkPmrKzB+fGWr3QjdvRP
 15Tu9ihgaYHtkklAQFIp7Z34ZpBKeV9YTJ5AI57NRXKPo52qiGi2IirxjRu9sgc24W8y
 PxghVoxIL6ZC2zXz8yxBsx07pXsg/fmDOZecLF07ES/6z/2IKbgiuk5LymiACMGEcoWA
 ypgd7JE2PvqDkguzQBDPJkicln4nEbN7luIHg9oCMkPxBf9QaTh6L32xI9GXd1eOG0Qj
 TfDg==
X-Gm-Message-State: AFuF++meb3L79HjzyAFNKLfSu6ghNnfah8y1QZ1dZsMXqHUQna/YLnDk
 47wQxs4ZrgdY3N6VAlKVXN7hxo1sGdaTgOaOMPIRXWh3KQ29eBg7Xcn+mXf5TBHF+iAG++6qAsB
 EZr5WKtc=
X-Gm-Gg: AYBFou3ogZ3Om+tWJEHFrViNkIRBG8fmgJXHbWNf/q1CiGWtZ1Jp4tGNwXx4Hchghan
 1Tf3BxS7hb1Pq7ebTFcdYjltN0//4Ra2QMbB5ZlvBDrP8XZEPLHlVyuxUQuOzLH7toObT6V5cEo
 +JqrCssuM/kPR2dnTNPGZMmwIoDng/xdI+Q1kz3ovtei7m64RmxWQbpiDM65y51WIwSwipyCiCu
 qlZ+Nd/pjoUb9HKBbxDlqU2NpdnJLbA8nQes7pZpvF+9BzdKP5rytDwOGfBoLYuqQvcu74Nflmb
 ANCYDgj6ELXThYCBzoO80kUDCDr4M3s5rk7LG1blmnwX3D5v+Q4qzAuiUq+3/6jS5Tzks4WA15J
 DK7D78hNxNrAhM74Ho/goIAh9ePlvL1xQCfw3OHe2tC2M+NU5xQrBNfYVWIVvUcg+JQKx3wFHwu
 JfISqaBw/h3yne/f6nnVSPTXFFY4aEuTy2vTOm1iVBLs9twNlMbVY+DBENFIqyrXxeDTyY6Qagt
 EI6fhk=
X-Received: by 2002:a17:902:e544:b0:2d9:484:861d with SMTP id
 d9443c01a7336-2dd4bd4772fmr94360995ad.10.1789267363325; 
 Sat, 12 Sep 2026 19:42:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 57/86] tcg: Generic expansion of tcg_gen_rotri_*
Date: Sat, 12 Sep 2026 16:38:08 -1000
Message-ID: <20260913023837.741866-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 tcg/tcg-op.c                 | 49 ++++++++++++++----------------------
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6c6a7f930c8..825ba2d3afc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -183,7 +182,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 35542e003ef..383a13aa1e9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotr, TCGV, TCGV, TCGV)
+DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 837c43e6587..5034f1a6f0b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -893,6 +893,25 @@ static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, width - src2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        gen_op_ttti(INDEX_op_extract2, type, dst, src1, src1, src2);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -1006,21 +1025,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1795,21 +1799,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


