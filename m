Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABEBC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklB-0002vv-7J; Sun, 27 Sep 2026 05:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkK-0002T1-7i
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:32 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkI-0007Qk-Ix
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:31 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso1359238a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499629; x=1791104429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=08KNnVkYLjXDaLyqb1s0j3G+v4qpCovywDGLvOH8BLI=;
 b=QQthL8aqYeV0Xgt0l9T0XM29zcYL6WoM1xjYxohkJJleeblNIR7W7ecILSxRv5DKwp
 0EUL/+Apmg6xMjpTOqQzrA/yqYGr0zOG6amk4Hd1V610we4neOI2EWodGgRZKfpOiW99
 d1iXflqbXQc88qGtGdNhWngCvhs2tWXetUk2F8OJJqHZoWzIhuPwkHmhtcFjIDQKL6t4
 Ur92bMqGCBcr0+CKSjUOduKJU/BTBeIpUe93jzayhhmUlaBnvac8A2PCgEG4Vvx6agnG
 52P94sUL+MDexQ4LVGeLq7sjTJnC3WlNKKnz/v9NOVp34/hIfIzjQ51lMy1Why9lHCDZ
 zo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499629; x=1791104429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=08KNnVkYLjXDaLyqb1s0j3G+v4qpCovywDGLvOH8BLI=;
 b=tc2mMLfd65ZvZXUH0WcmNMKoInQBgg27/HY6Np3aJ90SQBkU1jewtwyzhTY6QZavz2
 5cJ79+YQsNv+MdzUvq0QYtzQsz9RjECdMXVBOYKh3ZDr6buSh4ZVdV8wWt/hF/CWATZo
 UdP8E3hxkwsy7VHuJjl9U4VsLDnsVgOW5Uq9m4X6R83F9/fN6G7kr6G8dhKp0BIm+Fqr
 Vlk444JddoSX0nRtLtw5ncFDsXYm4UsQkwqgRYEmAf3QgHi+yDmMUa3+rH2qvDtMDOsD
 6BvYkpDrqQGctojgr7HBzGSjt1wa04dQyIt75GSChEfzNq4B+xRS7baR3kTms5kvOCcn
 No0A==
X-Gm-Message-State: AFq9FYLkpMEL+5BK2+39onLAV4DxYDSSB6tG5sOJ7fDI+WfUP+WmpDn3
 88OLSCA9TYvMN5yTOh4jNVJ5/K8B2sEyxB1kILSfYUjA/dTioo6FzJm0I8EEm1O5em3H06sQZ3Z
 UWlKT
X-Gm-Gg: AYBFou2Sbv3yQzo0h5kFoxYbZWo1BrqSPlH4ihmy5vF1Pqmu9H7QzI50NEUvFR9E/X7
 Mf/G3G9gpFyZhADd7ZlEyXEXXSbEUCmOqJQiSGDzeIPiax0+HDHy0Ib1Rz8ieEul/8mhU21+G1f
 fjKMMjuD+nPh/0S9sL22ytVr5DKJy2Go9aGGchsuKxgtdwp3Sa9U0+ymp2syMKrZwlFtmajKatD
 9zVSamNAr/BrRqlohsrKyNX1tDq5BG2CjNAXdfP1k4Lp8XpXROhsNALcdJ4LHDhZKPY6RgOF4Aw
 lcKYfxF8QHdSrhsfsMhU7bEObOrzj0xROXA9yWRYH7+85Orbmv+Me7vt9XN4fVRt+8+/TNTHhyr
 8vUPIx3jSHVFkP0KryZHy3w/PKo+5DIxXcxIkJSfVBSQRLIgQ50huR3j09MmOByiEmpZL6AlVZY
 ojVPJkLjNin3ULrhHcTJi8cnzrzRQuu+9VRrG4dgKDepE7eHLjI5pkQYVTom8AJpubi0/z8uvU0
 KxkQOycjVNajROW2D/V9CC8ZxN3pg==
X-Received: by 2002:a17:90b:57c6:b0:39e:24ab:9f82 with SMTP id
 98e67ed59e1d1-3a098adeba7mr8869042a91.10.1790499629087; 
 Sun, 27 Sep 2026 02:00:29 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 018/101] tcg: Generic expansion of tcg_gen_and_*
Date: Sun, 27 Sep 2026 01:58:48 -0700
Message-ID: <20260927090011.10724-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1ad18b10b5d..0c4513ffb80 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -317,7 +316,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 487ee5936ef..d6b45004a2f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 07bd0767fe4..f76e01310af 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -377,6 +377,11 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -420,11 +425,6 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-- 
2.53.0


