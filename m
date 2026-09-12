Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECDFC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L20-0005zf-7w; Sat, 12 Sep 2026 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1R-0004oM-6h
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1P-0007IZ-8f
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:48 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso797016a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209106; x=1789813906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xFzRZlbE6PthqtHpKnFiRaIoLUKZKGxLEv12G8A5wpA=;
 b=RAKZOhkng9ufDqbmDLnfdE3pTodeuHvQBaKulWv7fGjuyH/xUmZSb9SMWjgccSap81
 9glZ5zgy7IXIGzbXCY5dUEtmL+PYXi5NdrW1ova4IRmTjvKKp/0nGC33alPJfqN6h2Yf
 k0Q0GJI8tvbC8qoCEeW8jMVLgjIunyK1zicOIeMMpOs5my2eUlJQRCWG5vDMZ9x610AB
 W2JX7iQCGXPebvOOQ1Yc1ngxQERDmlIzw6/rR9VTCpvjd2ojyTUGwK4GNhTEqQKVTrDV
 cdm5RxF4kZCE1Bw5O8RNunlErnoBF64JasgXoICpsm7GQ+PRBdZb6huOkIAsi1SkBlrB
 DCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209106; x=1789813906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xFzRZlbE6PthqtHpKnFiRaIoLUKZKGxLEv12G8A5wpA=;
 b=W3AiJO9MpbOuo+9bZbhrgHQex4pL5LcglWtNR9y2lrFf8v+yWxoyeb8tzMHtz66EZ6
 S4Y5G6pVCCKAPcHjJ/Z2GV/UhlULhHkYkXECcxY2+9UFcunrhRp+q5wq8niyJ1sjVDIe
 zuQNtWX5xo4xGLHu7NXP7NobXkbp5Z3j5Yp+LFlKg6rZ5uwReldy/BeqVY7qcc+KHsTr
 5LqVWrANOI+SdhYVZkBB/oucW7E7fHAab+i7Vk1FCAk+8BItVS9IXtnYcaR7FSG3cv4M
 M4c2jSmmT3a0P+lGuddW+K7cKfCJvQI1Sx1TcsgSmbGZzJLdDRzv6Fh5huxYrInINLth
 WRvw==
X-Gm-Message-State: AFuF++mr9CEhfIMg+E100mKN9o5EH4NHUpHOWb+B7MWZ4gvjS3a3crH/
 x4qTn5Hd/+dPHFILaWSWydZydqrIn50bai3zPRiOLGWStYcbAQwRc1CAIX/Nem7oTzHOKNaGUGq
 N4k/y+X8=
X-Gm-Gg: AYBFou1gd+jrrUKdaBuMLHgFe2QR3786cfELk82K8Z41J2x8SQwEVui79TEG+5CGl6R
 KdxJjT1gMnUAFpbBQ7l4scc0Sj4Kth+ceh2eTO6SDXD8vKIv+acQ53GyIZP6AIFkDiq/y84pTGu
 cPZeHBR8InQUo8iBTEvWX4/hyVsSks91LjX0mDmW45hDfUfbKR9kCYmSMRv/H77n7m6FAeyUq1i
 fSwGUS02Ap5mUcSLhONcpY1uvhemG09hrbARp0Y8HiyMQSaVNCngJZiRF2frlO2UfTWKW1AzYRe
 XPDceyPEVUo6x15++Knl0HlPQRsN1qGtHBj5MB8I2YrxctH2lfA3+5aVTWEjLmSs9RA9ca1p09q
 9GZVaY8cyreaJHPyduO832kPRWv0E+Gw98E+T8qAI5WKNgUX4xOvc7fNVshSWy6mFIvD9DUUe4x
 LN5fteI/A+6j5RmfU8TwNSI6z9vHUQiYo1a+7wZxsbWpSOHwNxVOQ80u8CFtR94Cx0wBBtFcypW
 PfQwbY=
X-Received: by 2002:a05:6a20:cf85:b0:3d3:aec2:4dce with SMTP id
 adf61e73a8af0-3daed3ff609mr15211986637.26.1789209105784; 
 Sat, 12 Sep 2026 03:31:45 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/82] tcg: Generic expansion of tcg_gen_mul_*
Date: Sat, 12 Sep 2026 00:30:22 -1000
Message-ID: <20260912103126.598030-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 79ef28c0196..af15e4a9dea 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -208,7 +208,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -309,7 +308,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 356c2fd3147..67aee68c1a4 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -9,6 +9,7 @@ DEF_RRI(addi)
 DEF_RRI(subi)
 DEF_RRR(add)
 DEF_RRR(and)
+DEF_RRR(mul)
 DEF_RRR(or)
 DEF_RRR(sar)
 DEF_RRR(shl)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7e3672e4b9f..ff06a80dc02 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -389,6 +389,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -628,11 +633,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1520,11 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


