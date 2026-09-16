Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9612EC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKi-00034p-D0; Wed, 16 Sep 2026 09:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK9-0001zc-3X
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:22 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK6-0000au-MG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:16 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so2254141a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563912; x=1790168712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qvJBGaOSccZGmol6Ivf9fbHRDjhDeRvcxgwlCOD7JEA=;
 b=zaURcFvraMfhbOwTcLBdEhlbqHmUqo/1L4gD56V64R+eKVZXotnMh0oEEm1TwtdlYR
 CVfbpInsbIofjU60IvJeLvVy96TpqhODRuDn1UkHD20Um0Dl3d7+IhFcyNY+mC9l4a7U
 7buBmfJ+MUWgIWT7fc8qzwl3S95DTqmzbQFiVy5OCSvS9GwuzQ/gJtUrYsSKLvax9mIz
 iJUfFxS8FHGIwpCV/u5hvWJF6vwqXhL9vVXwj/y0ot+MpoX43lF4jBeN6Qukd4iwDPsa
 GhiZsi/tEy+yEp+s85tB/tHVA2umhDNfHGOFOIp6H7xcRSZfnSCPUweTzdTYRQwYLvzg
 4wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563912; x=1790168712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qvJBGaOSccZGmol6Ivf9fbHRDjhDeRvcxgwlCOD7JEA=;
 b=yXiOtoFay4ilSjwu38s7UQxjTRfy4585vFegF3h2FQ4MT5cM2p8VrShauUyYPYTdim
 PAHa4AoMkx8Y9Eruu2UmCSbZ/5fdyece/KqXbf3wJOW7jE9f8RABYKHD/Yr20lar9+lc
 A05xB984rixX4J7WumDsneWn6xfQzkE5gdRISQD0zQvoaJDUk60LRQfrcTfFmcS+p0VN
 C6ZcBBuf47oHh1h2jMoPEk0wKGxrfovtFM1h73nxKX17kaOi+XHSbSUJRl7hcdvH2/hb
 dpOK99d2YWYWBhwkxQ68jTYObC+HQCjm28hXm8EDP+ZYYlJKOe+NBbJFG7LGZDvCQQaE
 PIGQ==
X-Gm-Message-State: AFuF++muXCvQ6Cs9MUUk0eN29LvUBpU8U2IMdDpoRKEbbRwlLAdolQI1
 1vdAJ2AbOBKmLBSrYvcvR6k91KaVdf5Z3lNCMPGG3O1pDzG2DDtykRhuLg8A+KFt+7uZ1lzMS1y
 chbVXrGI=
X-Gm-Gg: AYBFou3x0kBaIbgUR16fjVC3mXHi4OuSnKVg0jL2gRqDNmLE+0LU2+/12q5vdQYN+K8
 xlHOVvaLUiMM6HlA/dKmqyLrWq0WB9oD2QODIL3AxD/FlHYPhoHGk5CvhA/EFen4mlIppTn1zYK
 A2ZvTmy+ZG7w091qRcOFp5TuBuUwGP7va1Xnp3nICBZtYXSVubYeDtVyRwSS/Thc9cAtUYICX8j
 SX1sduJjEOp6198kpI1hQ5mFgleWEWPDQPke/yIHTuGxCjBy++vPTe82lIHLtym/pUfZqPVwHj9
 gG8lgFDi1reAKSU9+UuTP+HWwW9i29v09Lhh8C55C/GiyzRM6s28tQpfgEYYfx5hefzlIEkUdMx
 sbqXI5vNDJHk9O8G9g0yWZ8moJPx4Fy0cFwwTvUBvcZ8NskEuq/exe6+ihxetkpav61VW/BH4b1
 dfkE5yZ52Ljp0RmYFbg3qVn1F1nNPTjH0y8+kKG0qOaXYqEa3pBiW6qgoiEDSeLW/kcgJV8s1Hi
 +C7RqU=
X-Received: by 2002:a17:90b:5650:b0:398:9beb:a2b4 with SMTP id
 98e67ed59e1d1-39dfe1c41c5mr8879375a91.22.1789563911503; 
 Wed, 16 Sep 2026 06:05:11 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 39/92] tcg: Generic expansion of tcg_gen_orc_*
Date: Wed, 16 Sep 2026 03:03:14 -1000
Message-ID: <20260916130409.3382710-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 tcg/tcg-op.c                 | 37 +++++++++++++-----------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fb10ffd804..a5b9e0da647 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 62dc85ff6a6..e17caafd890 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index edc3db83df3..0ffe0a9930d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -578,6 +578,19 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_orc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_orc, type, 0)) {
+        gen_op_ttt(INDEX_op_orc, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_not(type, tmp, src2);
+        gen_or(type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rems, type, 0)) {
@@ -760,18 +773,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1777,18 +1778,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


