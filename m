Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B897C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5k-0004PT-F7; Sat, 12 Sep 2026 06:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5J-0002EW-BT
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5G-0008W9-UQ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2db710396ffso24959855ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209345; x=1789814145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6i3xXZbPEroHYzTlSOxIG/qtruVFdBi6eR0RDPNX6Z0=;
 b=kgPjsyhoHamjPIXyUYtmko5CMiRGmnZiJ/KIOGPGE4fIzVbyhATKbKHzpm8tQ3ChZo
 CEvPxp+wvRk1PzA4oNSVrFVWSXOXNstq+6XzkY0nj5D5oChnRjez7m1yPCL5IpPEhdK/
 bxPaIKXYYcDGHEulIu+BLXBsNVzJB9dfMvsuVhJARFB+wLNiFcmsLUmaF/r8FLl2DRpG
 MY3IhlwDTqRtXyVR8dJ5fJCmruYKQ/5/Z27ThsZaD7U8WLW2m7snEkWrIrqNP/tlee8p
 OVllo1nRYmEeMOUPgShhwgecd2WupFjNtr93dDEoS1xNG9+ssObc7Rpt5wkIJmoKXCNF
 xh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209345; x=1789814145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6i3xXZbPEroHYzTlSOxIG/qtruVFdBi6eR0RDPNX6Z0=;
 b=gxMZPxLJ+tJytRI7ZtZiccyxXosTOM60xNlKXLZlifSefrmJ5Sa7bAwu840xTlJbXg
 dkZmgDuA8AfuEr/yJfT3TUDoZD7Cycm/BpF7B4KWqNSSXv8RS+l3D8S1vMI7bmCnDbmd
 4wvotOj2Zq9EJU98/ER+JorIN1H5RrJVACEgXkApEgLAvD5sQpLshFsstCSae+iaEx6y
 UF2rPBOrtB9KnCdZ/2HjZayRhczH7dE1j/hKeyCPe8b+qGgzPK9aAXVEnqASNEMatJjF
 041Qp1iW5dE3eNv92ryCWnJu9BbxHrzAiz4NcLiIP7jrE748j6Zsnu8fHav5RHfhmlCY
 nwRw==
X-Gm-Message-State: AFuF++kW7/RKwaYLimxk8fCZa5DGy3TxkVZUIz4zZEogh2DjjgQfNPZ1
 GC4UWZkG9+V66WJs/pDm6xanKm3CLQCxf4bvruu9exlf/MaoObsV0DmPi3m3WKCf3pLfQpSRFiY
 uIOm9VXk=
X-Gm-Gg: AYBFou3tbVKDqt6D/u+fV2gdmAbAXFWWKsN2Mb0LH+eMMI5JxzHJ+Nd8t29rlPqEn4R
 LZsB6u0Q18SsLv82jBd2gZyeJ2fqusTqEHYNZDvQQZIQ4LEWIt22sqGZu0LzMCi8W3ihAvYn06s
 P685mY5E4ljIElTxOBNZ1N/MGvEA5ayU+NsiAf82FLd9eDfmGZYwFGbUPuj6dYuYfyizlRLq1KH
 rMtYGP3qR37BI9eJE6Nr2wXgmLOhNraupntk9n5GzYXXBt43kdKJtG0HrMCRnatzszQzkjvbiiy
 9H5iBDueBYyZ6zKI9AePu7fyO9gmf6LsNKPAFD7EEZKsPqSDcbGXvz9r1IrltsPQjq8Hr3/RWCk
 ysEzvOEms4P1SiOm/K5AwXomF/jj0QN+y/jw6tMNIRxDgu3pjc9YXUE2Li9OKHkj+0um5R5dOtG
 o+B64ic/jfKLUzJVoxVRwSLpNL3oTaMnqJYWehgn+tkgu8SL/zJLiw4LvN5mSmRBOfB+w1Mxx8E
 fuv+uo=
X-Received: by 2002:a17:902:f64f:b0:2d7:1f17:41f8 with SMTP id
 d9443c01a7336-2dd0ec755c5mr146046825ad.15.1789209345236; 
 Sat, 12 Sep 2026 03:35:45 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 79/82] tcg: Generic expansion of tcg_gen_sub2_*
Date: Sat, 12 Sep 2026 00:31:23 -1000
Message-ID: <20260912103126.598030-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 include/tcg/tcg-op-common.h   |  4 ---
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 67 ++++++++++++-----------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 67d32fc9f2e..96fb4d5a47c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -164,8 +164,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -191,8 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index dc567a27ffe..337733b71a6 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -62,6 +62,7 @@ DEF_RRR(ussub)
 DEF_RRR(xor)
 DEF_RRRRR(addcio)
 DEF_RRRRRR(add2)
+DEF_RRRRRR(sub2)
 DEF_RRRU(extract2)
 DEF_RRRUU(deposit)
 DEF_RRUU(deposit_z)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 164b8bb26b6..ca4440746cb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1183,6 +1183,28 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
+static void gen_sub2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_subbi, type, 0)) {
+        gen_op_ttt(INDEX_op_subbo, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_subbi, type, rh, ah, bh);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_sub(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, al, bl);
+        gen_sub(type, rh, ah, bh);
+        gen_sub(type, rh, rh, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    gen_mov(type, rl, t0);
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
     if (src1 == 0) {
@@ -1360,28 +1382,6 @@ void tcg_gen_ext_i64(TCGv_i64 dst, TCGv_i64 src, MemOp mop)
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_sub_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i32(rh, ah, bh);
-        tcg_gen_sub_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
@@ -1889,29 +1889,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_sub_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i64(rh, ah, bh);
-        tcg_gen_sub_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


