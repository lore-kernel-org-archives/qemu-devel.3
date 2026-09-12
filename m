Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C76C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1z-0005v9-3q; Sat, 12 Sep 2026 06:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1D-0004m8-C0
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:36 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1B-0007Ed-Hm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:35 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so1893005a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209092; x=1789813892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z7+YBIpmNPsrQ6OostqfxCiUFWEiZyjWzNQs+kE3sk0=;
 b=jRX2Qj3kCESfNwQ7PL24hj307gQHdOJ5p1tVFk6Mte6Ruwrw3Ga4/V90aNLfYdkDAA
 P9dZHAdEPPP/wNRGzU2nn/uWGK5ugxV69BiL75PGFfKtCoTJz1NuqtjQyiuZIDS4lmQt
 feoeE0hhuNM50mbVWsHFg6sKeRDSPANSI+re1VY6eBTCWbU9XcOnoGtC01h+XCJ9Mfl1
 ehVjcVj/6IktrPBjRWoYqNF4lorJe+Gr6meNoosfdcFZPk+o7z4+GLkvb+Zk6doG4uKA
 ijQ6kkQpfFa0A6DbSnZg74y22mxTmLNAcxvnBu2tVQpzUKBVKe+ZN09WQrZTekDvEK6r
 kVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209092; x=1789813892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z7+YBIpmNPsrQ6OostqfxCiUFWEiZyjWzNQs+kE3sk0=;
 b=fNn7LV0Wa6SOz2eKXZShbg3vxLHgcwJVBWy2PSX7l+KpBAa8GWhGmlCIiQWkZcfnvA
 kR7WoJ8QXP8KwTSpZiYJCd70/gGtXZLjGPpsXK+KTFEzaij/bX7dBbULcwuprZYEKU7p
 gj9m+WGVKcwEKyWnOg9mWK48h1lLFdA/tXiNwrc5yqtJsXDRL8uyNEExT00qvuabjsgY
 6kwC8UlOfwCanaDFWbNYpTw385/S5/V7v7znkVZ35PaboJfV9UXdKOatLYFjMUz2CPSS
 ypQlkobcjqdQgPjmHR+oqI1lBgq/xt1CuXvCtW0gC21VXTKHQXPCzFOzjACu4x3m2dJz
 hPGQ==
X-Gm-Message-State: AFuF++kxguYOvAzKZ84FctpdqAz6CSuIXwJp8u0Iw2xp+hbvsOzfwAHq
 eDhdY5+SB5WXj1PlFu/HuOIj232H6eWwHrkjKfIXcw80g321JEagQKzCcL1g+pVljnrKyHm2mWT
 PH4IHuLc=
X-Gm-Gg: AYBFou3VjnagBhQLoDnRTFUVgnkJpqBY7rVY2XBTd7SYcgjee/8w5NC9nH4blGVheAG
 Db+v27KoCAIP+H21qxEnA9c2fVdV///ykl7U5/1L0VQ7MFuKW0nVHYmiDNgV2rqk/9nz5HHUgso
 3mLpjo4ba4b08sTLYBZXGsif1/ffMyZ46bISzUaTexdPejcyYvKngb1s8zrFc+UasTJtKizu6JT
 IXdtaSIm+MyfGq/4KN2uCOh9jMQvQhIs1gZdoAKbpOcQhhGFViD030ChE9nEz14wHV9gpSpPj0V
 7D14Si64YYSUAypa6TWkRvLkeLm0200ztbRL2vEMSLV8HbHnEyEXeji9AF+V+PmO0pafV0oThlA
 YkBJ56XJqywsLIgHJWliKyK9ZoBNzkrvAE7ERuZrvgn5WVtEDmTV4iP0JdedEh1K9WLhC0gWJ1+
 z/oRemOHjpqqOrRr3utiGHZ//2ClnR4E5r46Cx4cmB35BC1N695ZcEb8SMcZVd5lf6LzzniDLPW
 If81lg=
X-Received: by 2002:a17:90b:1d0c:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39d9c35972cmr14746944a91.24.1789209091952; 
 Sat, 12 Sep 2026 03:31:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/82] tcg: Generic expansion of tcg_gen_mov_*
Date: Sat, 12 Sep 2026 00:30:07 -1000
Message-ID: <20260912103126.598030-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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

Begin sharing code in the expansion of operations
for various TCG types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   | 13 +++++++--
 include/tcg/tcg-op-def.h.inc  | 29 ++++++++++++++++++
 include/tcg/tcg-op-def2.h.inc |  3 ++
 tcg/tcg-op.c                  | 55 ++++++++++++++++++++++++++---------
 4 files changed, 84 insertions(+), 16 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc
 create mode 100644 include/tcg/tcg-op-def2.h.inc

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e826b62574..2f5276c8a2c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -88,6 +88,17 @@ void tcg_gen_lookup_and_goto_ptr(void);
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
+/*
+ * Construct operations from templates.
+ */
+
+#define DEF_RR(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b);
+
+#include "tcg-op-def.h.inc"
+
+#undef DEF_RR
+
 /* 32 bit ops */
 
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
@@ -172,7 +183,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_discard_i32(TCGv_i32 arg);
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -294,7 +304,6 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_discard_i64(TCGv_i64 arg);
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
new file mode 100644
index 00000000000..a24fb3d7372
--- /dev/null
+++ b/include/tcg/tcg-op-def.h.inc
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: MIT */
+
+#define TEXT    _i32
+#define TYPE    TCG_TYPE_I32
+#define TCGV    TCGv_i32
+#define TINT    int32_t
+#define TTMP    tcgv_i32_temp
+
+#include "tcg-op-def2.h.inc"
+
+#undef TEXT
+#undef TYPE
+#undef TCGV
+#undef TINT
+#undef TTMP
+
+#define TEXT    _i64
+#define TYPE    TCG_TYPE_I64
+#define TCGV    TCGv_i64
+#define TINT    int64_t
+#define TTMP    tcgv_i64_temp
+
+#include "tcg-op-def2.h.inc"
+
+#undef TEXT
+#undef TYPE
+#undef TCGV
+#undef TINT
+#undef TTMP
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
new file mode 100644
index 00000000000..86777f54bad
--- /dev/null
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: MIT */
+
+DEF_RR(mov)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b738863ea69..eda87960380 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -104,6 +104,11 @@ TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
     return op;
 }
 
+static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
+{
+    tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -315,6 +320,42 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
+/*
+ * Forward declarations of generic expansions.
+ */
+
+#define DEF_RR(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *);
+
+#include "tcg/tcg-op-def2.h.inc"
+
+#undef DEF_RR
+
+/*
+ * Generic expansions for templated operations.
+ * We have used compiler type checks to ensure all operands
+ * are of the proper type.
+ */
+
+static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (src != dst) {
+        gen_op_tt(INDEX_op_mov, type, dst, src);
+    }
+}
+
+/*
+ * Templated operations.
+ */
+
+#define DEF_RR(NAME)                                                    \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b)             \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b)); }
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef DEF_RR
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -322,13 +363,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 {
     tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
@@ -1396,13 +1430,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 {
     tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-- 
2.53.0


