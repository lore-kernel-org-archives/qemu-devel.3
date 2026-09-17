Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF1BC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rW-0004ii-UD; Thu, 17 Sep 2026 00:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qv-0003kz-Sy
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:05 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qt-0007ww-M9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:05 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so308093a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619762; x=1790224562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G3BqLd91rjoKhJ2YDcmupDkC98VcuJQ2DeRHEk8J0io=;
 b=Odne1nx6sYSOh3N2WjU2lQa40HdpdA3CTUzMnczXyKwZylnZiePrJP97O9zkysrAZx
 Vyhdksyz1BVYwnl+L5+phAErd8xXGBfXoHNR33teYwunJOGJl/jDykn1vsuhW4BMFKLB
 p9BIXddD81k+EAUQ5f9DKopmUoOka9c1wpg34YVA7HPvi5sMIIhkGm5OEf9/Y3d++vI5
 pvX4THvGNu+IZ09sTQFPYhmdbn5LBqZGbnH8iNOBfZ3xYSEyQMi3V4GFm+8eqn/sxV9O
 9hj+irxhsrw+2/OnosLx93ogrfDZMYhs/tu2e39mAdz8nN7zEgQv9drVwL5QniFND6Ks
 9znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619762; x=1790224562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G3BqLd91rjoKhJ2YDcmupDkC98VcuJQ2DeRHEk8J0io=;
 b=DV9j8TcFtG/zpGGd9jAIfxSEw/vELDsOTnIGIFn3J9t64xBMj2NHOX6KxavSuAgSMW
 JmyYeDEgev8z5B3tdZDOGdU/j7KvNbr5PUkNsqfUysGj2knlLgIzKdP5tVc+pqDAw4JT
 ki8ZKHllAX/8SxweYD59hC3BLnY9zgvDI/tVG0lFW4qu6pn9wvLXSdbgB9fraVn3+ezl
 GgzaZ9e7jPjnZs0vO+MkPFfyM21ahNGfCjUB8dyQf04MtIDhDktnwXVzxN6rHBxD7Jb8
 bGyMuf7o2b6p2P7whq5G+EWZ65b+oB5ubQNCSRQbUghPcRXDeSnbsaiSXD4/geMyqjrG
 L7xw==
X-Gm-Message-State: AFuF++kwkB1GpZnEzO8LfR5RBnHdaFXLISGKPuu/DJiiAhcoyu4yOJ56
 XAC3loXAYP9ZseXOE8mg/M2TK5X6kNeb+hxgWuVde8a6wlVL26mc1B8ogKs2+Go5Jj6V/eFmWvb
 i2YtkxcE=
X-Gm-Gg: AYBFou2T9m2kzyvrvvr0RY8BzjMW5BOwmzrsNn6h+oMUvPJnsrc4R+YeVTczBoeFv+/
 wpTl8AUvVIn9yWcfKcBo1oRjWbTaj11T8+g99pEPyOyh6C9MHM3a3tbxV9cXBq6Z6iYMZ5OKs+i
 ErfjW9tT+hiD/v9A8DTInqg2WHmVHytIW3SYfJTsDGOSiLGVoIynMn7+ZUa3im1IsCM+ZNsjOQM
 ldAwnnbSTfEef8VT3CoVt000J1z+o6p2XB0+EyB/KJz5tMivznRXlA+nNKpQTCKa6lXvb6ZSZnS
 ijcRlLiRoiCPVdDY8tOb80HEKg/LzkQC7xAt6tdbUDIh5jcP4E3mW8VD4zo3DZKCrBNYpYfrbEG
 bVPxowsqO6o6eGu1KIIow/7diA1U7rW3sVMMOvOM/8E84YjK0LksAqUuGnnw8qtvb2ODqNX+4pj
 9ZOPmBAIqM+JxmMoR+nlJNLEc++93h/Moiq9O6lcXDN9rv3fUJxExUwsWzeQMmlPP14xhwiVl2D
 6rOobE=
X-Received: by 2002:a17:90b:58c4:b0:39d:e445:1d44 with SMTP id
 98e67ed59e1d1-39e361afbe1mr3337818a91.31.1789619761741; 
 Wed, 16 Sep 2026 21:36:01 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 091/101] tcg: Generic expansion of tcg_gen_ld_*
Date: Wed, 16 Sep 2026 18:28:13 -1000
Message-ID: <20260917042823.542588-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 tcg/tcg-op.c                 | 26 ++++++++++++++------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c3d080222d9..22077246109 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -176,7 +175,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 13aa8e15e42..dcd5be7f20c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -30,6 +30,7 @@ DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
+DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 33e82973d8d..b77e61c2b1d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -284,13 +284,15 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
-#define TCGV  TCGTemp *
-#define TINT  int64_t
+#define TCGv_ptr  TCGTemp *
+#define TCGV      TCGTemp *
+#define TINT      int64_t
 
 #include "tcg/tcg-op-def.h.inc"
 
 #undef TINT
 #undef TCGV
+#undef TCGv_ptr
 
 #undef DEF1
 #undef DEF2
@@ -332,11 +334,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
+#define C_TCGv_ptr      tcgv_ptr_temp
 #define C_int32_t
 #define C_int64_t
 #define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_tcg_target_long
 #define C_unsigned
 
 #define TCGV  glue(TCGv,TEXT)
@@ -363,11 +367,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef C_TCGv_i32
 #undef C_TCGv_i64
+#undef C_TCGv_ptr
 #undef C_int32_t
 #undef C_int64_t
 #undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_tcg_target_long
 #undef C_unsigned
 
 #undef DEF1
@@ -885,6 +891,12 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
 }
 
+static void gen_ld(TCGType type, TCGTemp *dst,
+                   TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1509,11 +1521,6 @@ void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1562,11 +1569,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
-- 
2.53.0


