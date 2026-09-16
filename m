Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73765C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQh-0006Ut-NO; Wed, 16 Sep 2026 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQe-0006Hh-QL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:01 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQd-0001zI-1Z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:00 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398c066106cso685972a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564317; x=1790169117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pd0sWaJOCVXpfAiLYxJiYpW0khwr3sBzEOoEYqJ/8oM=;
 b=KjszqoFwdJ0v24HG3WNqhzk9ldJB/Cn4LmTbfMyLu4z/NH5OzzhEG8sWbyWk91VnTt
 KzdXAVhHc/qRF4suOcab+g+VAyTiqMIppSC+RFWiVoMImtG31bb+ThAoVf6otxhQzihk
 lMBuiAXIuT/Oe0m5Vr+8jblOoJkI3loIDR7JDezoKrPwwu3yIpIzKldIB3jvVRMj5WRA
 2IwdbaWXlQG/P6ag3Jf9WyoWpd1zbQ4LR+XfmSmppsxre0KclNR+G0KSmEq4dRFFB/o2
 CbCTLlc5uEqvFAC5eR4bWHG7x7T67WJqcwbPGuadCzDmdbxY1IuUHLUhpecCJ7U97rHg
 HuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564317; x=1790169117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pd0sWaJOCVXpfAiLYxJiYpW0khwr3sBzEOoEYqJ/8oM=;
 b=09id44/cZlwdtDV3BToB+nXHqPn9d4m/OxpV3q6wCB0O1XOib3NHNhoZkngNEZAILF
 R0x4FFYFYRKIbGmZt5c+F4SZtQqv2pDmMo8BXEVbKDdAX/diGZpsCSEg5T0Fdi89aElR
 zKWLTMK7fpzTk3/zZVAThS2FXLsokyJy3q+jyUwkIxehf5r1rgOY5ewPp08wDat2iii8
 zM964sM7NbB5ffCqyQWqpmiUe33kS5xxN+p5K1hRTlEKSPXEhafCRzsuRGKTgXD7ulx8
 agBwiMRBL4h7kW8tzqUwAeeaSenvaqwYLY4HiQEr9MtklwmE5NVHZaxTfTDdVwzXFrzY
 HlrQ==
X-Gm-Message-State: AFuF++mEvoyDhFqT5Bc9KKSHCWStVAuk6cjcV+MAIb7IjI4CHE9t7w/a
 1bzQtNx8zypoELM+3LGBIb2YrazHT+PClo/iKYONX+vreMcfDdY58TbLeCoavs8F2re3Q/Vd/IN
 phaEbVvA=
X-Gm-Gg: AYBFou3JRvRP7eVzgDYYFIBgvRHssQGYQ5mwrCjfa0yERg8d37smP+xO+td57iGAP4v
 awaDRfi+BpPMAE4ygMJK+l3RYGUYcf+yIRhqTf3GIQ5jApvSBDrXo05THz+PdglYtPVfFusKxEY
 BUXTVx0rfuDdhskA80OrQShkbQby76W9FB73p5LD2LwvI1cnTkeHs10gYbCPFzAFzD3Tu8qc93+
 OHDI6M+DAtSpn/HkF84xLZDXBdFMVpmZmU58KCpEIupqB54bgtr7u5oKhbLFic1Axwejxd1eP2T
 KJZq3+/E66pW8sEfe0EJJ3Xw/focxfKj7jupjCxFTCxjS0+gaw4FQgdgBpubvSu9prGY1rAMg+p
 AYphR+NmVF23KhmYypJntbkF8lVmHw9x0W7tp2tZnUtDh6/vQ/Q2Vp+fzgQj1baNFNBmiIJQR78
 XYrWNGYjoMosKvxqIKMkNvUtNYiEu/aVT+nAorVdGNYwd09qubLSbCenzDC0cp9JTdaH3SogHM/
 uPXT98=
X-Received: by 2002:a17:90b:4a51:b0:39d:ee20:1e28 with SMTP id
 98e67ed59e1d1-39e1e510f73mr6082750a91.21.1789564317330; 
 Wed, 16 Sep 2026 06:11:57 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.11.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:11:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 81/92] tcg: Generic expansion of tcg_gen_add2_*
Date: Wed, 16 Sep 2026 03:03:56 -1000
Message-ID: <20260916130409.3382710-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 67 ++++++++++++------------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 60a0dfddf25..d6e185580c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -160,8 +158,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 141c18061e8..f42aeb7d8f5 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF6(add2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c8b5cd2b502..6d8f14038a0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -431,6 +431,28 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_add2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        gen_op_ttt(INDEX_op_addco, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_addci, type, rh, ah, bh);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_add(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, t0, al);
+        gen_add(type, rh, ah, bh);
+        gen_add(type, rh, rh, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    gen_mov(type, rl, t0);
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
                        TCGTemp *a, TCGTemp *b, TCGTemp *ci)
 {
@@ -1267,28 +1289,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_add_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i32(rh, ah, bh);
-        tcg_gen_add_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1776,29 +1776,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_add_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i64(rh, ah, bh);
-        tcg_gen_add_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


