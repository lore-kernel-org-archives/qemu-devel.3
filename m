Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3DDC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1k-0005EJ-1Y; Sat, 12 Sep 2026 06:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1W-0004to-N2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1U-0007Js-KL
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:54 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so660055a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209111; x=1789813911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lS5nTKUVb9TWb8AYruRlZVgS2OOFSe5Gc4qEMqAS+7w=;
 b=I940TqAZsfSs5cvcscABoxgBRZ9vkWYFTaqqHbR8zKgWz6YXxhaqTeRhAz17dxrbva
 g8eh7yqSqrD/FE0W57CSGog6GP4Ozt837F6Os0O53yf7F23w15w3QwFfXHDBRxba1rQl
 gsMu9GDg9IKvDhcO9P2rmJKgn5eb8nVvfIQzwISIrqzHpAM5tbbr4PGG4kHBEJk6SVSw
 ZQRXWqswtI7EbTe8Y45UnYfAwhD7djw63AL8LsdoLlx8hHFAYuAOp2hzSjAuA0IC4XYW
 EKHml950MuVVY/rIyUGGLGr+6bT6qJUiMWJJBiVHSzFGwfWhMZ/Z9S+VErAklhSqRdVH
 knEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209111; x=1789813911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lS5nTKUVb9TWb8AYruRlZVgS2OOFSe5Gc4qEMqAS+7w=;
 b=ME5Tf2GEJB+ovDdj3Ygykv0w019l64tEHzz+exwcS+g/RKWvXuxrWqtV3SiUWAQ4m4
 tl0WpJ/j9caPv1kEW/YIrhU8nmdJ82rhAzOdNIG7JJwOt+COfddJFj9Vt6jgvl9HNvz+
 1XNiECJVlyZuNHG/z/Xy2iPz7IsomW8lr8L4M+MeDJ7AR/RFRgGnVPE819v2PcpcI0+s
 zMsod+klK0u/t1s3C1Q026MbHXWx9j0ouHMQuMCOOTU7r6k/pQ4OqzX92t4whNmeQuku
 gT7wE8vAgj1wReFhNpbEIPgpjkeJPj2YY2KgglY8OJ0FzHKOecH69rt4e/4YQSHZTnmQ
 B++g==
X-Gm-Message-State: AFuF++kS3vwz0/8nrFuNxH/8+q5Mx/6l/+sKv18Fo7uAbtYhMNWA+dLn
 arbxMGqGpSDWiRLXjU3k20T2lzSWfoLeH0/Tz0uWHjJZUwz+OZojK4o0s4AfI9MaRcGp8i8B1/h
 sfKFtRGs=
X-Gm-Gg: AYBFou0DLN5M2kUSYaCsxCmIMqd4mjabUZOFS3GfM700j9OYtTM4UbYKUFVpvyna+bN
 eNMbNd7YM7LbRavGpHEOXkGKDjr2kQ2Lt8WXiKI7i/0ywhWyHj6rzQPxcvfJTfJe2d7zbrgD2yj
 fNeQZUNDAwi9wRjMSve6ZnGpHpf8QWzxWGp8cn4KOLuLyg6Pl32cPOs3p7/kO8zKZD3q3st8j9c
 92NyXf20XnhyLCFWCRf0nXKMFGfM49U91EliXwSK8iCpEssShceXXSn6BM9gUy044no1aM98W02
 4MGGSdtDyjsUWFLE4JD8kTQFqSaYBsaX5XN2DfrF9Ffx6hvVHyDXOavijPej6Y9WngVAXGPzEXZ
 DA0BhHbYYE2I9ufIEFXGAE3bNURB+gWYihQ5KCv78LPj9PJS0tsDrMzTeiu1muVy7Ml0OFnh6up
 WRxznW6KqXzTcOP3cew7SQjS34WIk0Fmsr9Ei/FIy3aUXoEKE/34JgRmaQpYrpIQsiLxsaD5z+M
 0747OM=
X-Received: by 2002:a17:90b:5111:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39d9c3f0dbamr14334308a91.22.1789209111240; 
 Sat, 12 Sep 2026 03:31:51 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/82] tcg: Generic expansion of tcg_gen_xori_*
Date: Sat, 12 Sep 2026 00:30:28 -1000
Message-ID: <20260912103126.598030-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                  | 40 +++++++++++------------------------
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b47d33d723f..742af3665db 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -207,7 +206,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 07e1a9bedd9..250ab78ec0e 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -12,6 +12,7 @@ DEF_RRI(sari)
 DEF_RRI(shli)
 DEF_RRI(shri)
 DEF_RRI(subi)
+DEF_RRI(xori)
 DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(mul)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ce358bbff26..442c8e25927 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -514,6 +514,18 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
 }
 
+static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (src2 == -1 && tcg_op_supported(INDEX_op_not, type, 0)) {
+        /* Do not recurse with gen_not.  */
+        gen_op_tt(INDEX_op_not, type, dst, src1);
+    } else {
+        gen_xor(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 /*
  * Templated operations.
  */
@@ -553,20 +565,6 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
-    } else {
-        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
@@ -1519,20 +1517,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


