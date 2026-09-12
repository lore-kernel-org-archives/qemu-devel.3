Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FE5C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1o-0005K0-18; Sat, 12 Sep 2026 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1b-00051S-MG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1Z-0007LF-PK
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d91ded8174so16461255ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209116; x=1789813916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IItVcsGUmaxAvVFY8b+tl0xaRl7TZLN6+n2PHwWIEUc=;
 b=IQJOf7sjEuWpzAuP9zYgREfBvucKR+W1tnMxBab6bCWXoTJ6sG5ancAQQhygrYmeu6
 NnIfEvU3Ftyxys7emlGZrXRCFXkx0dKOXA4P79VfTMXAw9vzft9UXXjzM+taol3U0jjy
 OUf3+ScWz+C0d4/0O0MC8quEPQLmIx+NUwESe5Mk6TGv0xa0NML8VbPDq9PsIV7NP1Lm
 MY1e2c0YweffeEgG6PDJ3wci9i0Oq9mYH51OciWweu0NqFGBEfwg4OBiWoEiQEkz4gSU
 lzHa7l/TWWKot9oU5NYTmGAx1eJ/k+xKZ3YeuviCMSZe4MQ282T2YdHTy+fz4SqInnml
 afnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209116; x=1789813916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IItVcsGUmaxAvVFY8b+tl0xaRl7TZLN6+n2PHwWIEUc=;
 b=JgOowRJFydqyymFW6HC/RhiUQ/M3dJbrs641fU+ezMHLLQCrkk+jMrCX2BiilRYQwR
 GwXfJPa+oPTFKmjC53N4j/g99WLtzOvnCdVT/gi3ENoI1tJTdHW2hnMy+ACqLbixvrz9
 PO6Xv1RJL2dhBs07YRJXwa0MbCPk8oABVD2sCjx2Bcq1O3ZMq5p2vSSS4P6kC0tKQgfY
 CwkH5zkjL9pgdA4g/cVpn2FysPHz2Hw9yrBaOBHTr5A6t1nfnOoJ+3DvwyTZOrDZZiQc
 sHyiMuKFDe5obBssdpO7tFvVYPHWCSL2EHm/RQC7qoovFH/5KTPzlVN6A9Ni08vVnzm7
 C5wQ==
X-Gm-Message-State: AFuF++kZNsW9BnsPH2kVBRzEV1xk3bwy4UraBvS9yMZpNBDyFT2eDaAt
 auoqJc4BPR7sEvZFvaG5fq+XRlr4e+nFtOTWC6dkOKWh1eDLrVgyLOwzIMKGAU0w26RUNmnrv9W
 Twhwjn2Q=
X-Gm-Gg: AYBFou24nHfktVF0GKP7SKx4ji8FJ09O6fPdjVyDh/H1xzkyJR+2pIrAjq+d+ShdGHg
 ZbX5/loRw/LoAyyy50L7YrWp/Im3DBDKz+iGWdqkbTF0jZKa2QKUobVnogdAKuWFqheRIn0veJJ
 fgeLwI8/lM3OvOkWM0xTkj5ZjKwmWjzN8twEZ6lP+ymcotSvIebraIghjYdsdNjQADjcwYBwHlS
 oRayesJV3m43kNzRjLmEqiYXuiZGvXi3ToKz3EvGQjFUbYIqTYUDUq0+hCJ0eksXMn9VdMz/N4m
 PPUYDQ1ywA0v4FJVXfdaj0ozHVbArfAKrjeRzoDNnfoH26twCZLmtkC+bFQMKaPtOl59QGLo6IC
 lcSCTvqu1QqPkbag4Gbh1r2lrCFeeLUSwb4sCiqMq7ec2Q8vNGLFngKauqeYkGLkDoPo0zROPPG
 amV3WzrehsDESyfhboZo7O9vHDFh4FkQt6f+hGXPpQ6nToNiilrAe6flynSNQUWKxiNL8LyWz0g
 x2M53Q=
X-Received: by 2002:a17:90b:4d0c:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-39d9b97d29emr13365187a91.0.1789209116147; 
 Sat, 12 Sep 2026 03:31:56 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/82] tcg: Generic expansion of tcg_gen_rem_*
Date: Sat, 12 Sep 2026 00:30:33 -1000
Message-ID: <20260912103126.598030-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 tcg/tcg-op.c                  | 62 +++++++++++++----------------------
 3 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c5f1edd6218..20ccdbd0c95 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -202,7 +201,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 9ee7db8b60e..56d7d2c6bfc 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -20,6 +20,7 @@ DEF_RRR(and)
 DEF_RRR(div)
 DEF_RRR(mul)
 DEF_RRR(or)
+DEF_RRR(rem)
 DEF_RRR(sar)
 DEF_RRR(shl)
 DEF_RRR(shr)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 84f06b8593b..bdbd9244864 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -490,6 +490,28 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rems, type, 0)) {
+        gen_op_ttt(INDEX_op_rems, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+            gen_op_ttt(INDEX_op_divs, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+            int width = tcg_type_size(type) * 8;
+            gen_sari(type, tmp, src1, width - 1);
+            gen_op_ttttt(INDEX_op_divs2, type, tmp, dst, src1, tmp, src2);
+        } else {
+            g_assert_not_reached();
+        }
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -666,26 +688,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
@@ -1580,26 +1582,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


