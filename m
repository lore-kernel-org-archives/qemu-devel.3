Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE79C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73re-0005W4-ET; Thu, 17 Sep 2026 00:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r0-00041T-Nz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:12 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qy-0007xy-Ew
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:09 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae7166ebso229199eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619767; x=1790224567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lM95YebAVIwfGCLo3GNoIrAehoSrueZBN/xi84kv11w=;
 b=gtUQqM8nnBMbJZRRKRDUhE1AsOXXi7O6CzpUiJLp2cAML8wjX2zUocAM7LdobZ1Hkv
 LyzNkJOn/m97oqXoxBjCp2UhqaGZLbEPJlZBdGEBKx7MjR8GPinnI5g3jFZ7dPpA1cwQ
 +Lc8ZPcDSuIKWCClGrx2xq2uNpThP8YgtmnNS8m/2Wk/Oa8JbufuSP30xn/fujTeSsAn
 R9zBaxF5b15lRySYNKnXM5feS8+7t8oIPwOPeSA3Wci7KmW588dIxIifoXmdlatDS+Ef
 Zx7gzHmO8H1ioBFdVer+wB3T4upNtgDsihreYZE+r3hdLb+rA8JcnpCyn5CKj1yqALRf
 EQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619767; x=1790224567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lM95YebAVIwfGCLo3GNoIrAehoSrueZBN/xi84kv11w=;
 b=ZjZ4gI06E23dImKp9F9iVaFM3sYig+hT/YOE7wrfozBcTnAi6zHekFsN0ZNLiTP0GQ
 grMOQlkC0jY0Ijs0XHeAD7J0BETR/0RiaXgRgWlLyAje5VRNHWTxoCfvYYWCZbak24K3
 PPdevoEUoc02cucSXereFonNPanLo1A+UiCjCIXEHpfuCSbNKKqsDIYL8I1AACZRVz67
 rJXpAlUNLxc9sHuvTkNracZBoXSP5MDNwSOZw+ycwPa+QTfEGxwtqDLbxb5Z9pyJ7hky
 Cd5JKbHwp0xFhlwu8UICk73iNdEiJBDi1Kk+t83yt9eePIY9Tq7LJwistNjIiFlVwRHw
 75HA==
X-Gm-Message-State: AFuF++kahyIwJZWq1Mu3eEcEYp70wNcgEW0gbloZWxn9gNYUN16mTaTO
 ADLvDFOMG7GR92X2o3nwejP1lEqbVS3OyoqvVJfqu7y3Ycmhd8J2rlCshI1WjnfEi5CpmEFWgn0
 jRpiSLlM=
X-Gm-Gg: AYBFou3d8nvSCi3XCqyjARNbs/bq9vzBFm1omyrqk+LHeUywHDEt14BhNr5mQ284D6e
 e35HiXLsFG+SdmhuL1zPZXeVKgPEUAZaVdG12NSrUAJ1C/dAZv1WZDAijzcYMsqIl4l2KcwOMCd
 aWwqmPdgl/3436QhDZpV5rfX21nrW5eowFBY1LjsIoTb5y1sU/DRfLTiZXYr1oNZasfEm/JK7XF
 4G/UQ/KgZI6XbLYvL1jOQiz3cZ2sHiLzdpNYHBxchB5DIO8IPTFeVm8vUGxbjzQuFpN+rRKNaoU
 xKSyFYt0wcZhhFeGlbe89b8XXoOUHDhy8ft0TuTfXCybuzaOPEs/da4f/DoUdzdUVV+Zok3IfeL
 ZR2zsHQaj4GkdKYZFVObh9pPV7ijAhRLGraKLAu9Enqc4Onm2d0rYq69sm/5EmOpj85pon/xaDk
 /ek814Zz7r1zWCUT82KabKt/JZtxK/j0+l9u4q3dWvnE2bqJrgSjX6mqwNvlGESUDKwe5YwU5W/
 xP/4Kc=
X-Received: by 2002:a05:6820:199a:b0:6c7:1e67:852 with SMTP id
 006d021491bc7-6c7d49f9831mr5308477eaf.67.1789619767224; 
 Wed, 16 Sep 2026 21:36:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 095/101] tcg: Generic expansion of tcg_gen_ld16u_*
Date: Wed, 16 Sep 2026 18:28:17 -1000
Message-ID: <20260917042823.542588-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0f.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 75e124b8091..a6b479ab2d8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,8 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -166,7 +164,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c4078ca5a1a..4f630f7e32a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld16u, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5c644c06609..539911ff94e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -915,6 +915,12 @@ static void gen_ld16s(TCGType type, TCGTemp *dst,
     gen_op_tti(INDEX_op_ld16s, type, dst, base, ofs);
 }
 
+static void gen_ld16u(TCGType type, TCGTemp *dst,
+                      TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_ld16u, type, dst, base, ofs);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1519,11 +1525,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1542,11 +1543,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-}
-
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-- 
2.53.0


