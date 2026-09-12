Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC3C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1a-0004yb-D0; Sat, 12 Sep 2026 06:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1I-0004mx-8o
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:42 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1F-0007Fk-7n
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:38 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso1788202a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209096; x=1789813896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LOmq0qnyvOhF/zyPHnRHIe5uIW+lRCHfexmuikfSauk=;
 b=hKdnIStbvt8aLWBachLEQ/QfFGe+CJLUdPlavguMr3MeUHiz/kHCJ32VDqfAoq3VOJ
 irH+wxbN45iUE5lE+q3FZu6GVwWXeGHcbcI6eVr2VLOS+dE1fqjnq/niSPVuMzQiRp+D
 o2Zps1exUyxthdrG4wrR3RbkK2D9v3PQgWPvEzcOQPZzKvYqgP72LDnsAi2Prfgo9QBz
 xKICipuSpCm8cJSCx6sU10OtkBnmhkDgcb6RXKJrtUD2e/gTXGNNoWw6G9ChlAQl+IXW
 eroI9MTZjQzOw2rXTQpCgWaQfg947iGr5EhulvWFqxP8BwJgyLeXYDupSgtcu6LSaAif
 zWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209096; x=1789813896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LOmq0qnyvOhF/zyPHnRHIe5uIW+lRCHfexmuikfSauk=;
 b=j5J1Hbe7ATUGtfEdEZ6G3K2FqTenz+JZVEkGQ65zaOZCTvrYz3JeSIelKhA26RpmoN
 nKGRVvCU+/NfAJxl+2tAaMsU24QFyYqfjBQGS7pjz1bkV2sM8OXziT5LiDITYkTlOWbR
 wX5Xc/RzYOY7EzTHEMjEdFxs3QqwI/Xr2oVtZfYO6Kez3Ka6u3oEGET9aXhD9XH+92+6
 DRlkB83XwKG5sf/J3yh+iAdJkvjMhFsS7EI1zsOzKIudrQeC8wAYc/2h4/AIgb2+RdgO
 GeMukkj3bmArkMjcrC+iPtevGEzp+QucneJH+6bqjT1eMuLULG+jNHosZkpILr1ZYZz5
 WvMQ==
X-Gm-Message-State: AFuF++mN4ylDaNOyVeusPcmO7IwUF5V+s4acTEQG0eqJPTakkmPd3QvS
 ZgcMhAq8Lb8mJucYEw0v7j7lx/eawYoNFSUIsGpIhYKoZ8XG5Hbx47e7ND5f4TIRYSH5Wd7yvJt
 XoeqeNgA=
X-Gm-Gg: AYBFou0Ugun3FamieCpaERVraIalkTG3DwlZZeJPlkN2mxEjm2NpUOfZ24vdsCGVJg7
 1c1At9Hx9NKb1fQr/Fex/PbbqVqTcqQVQIhJimw+kNNC73l6PJZ0BgU7MJ7O73koYYROMBrxxUh
 FjFxNJPnFZryKPRo9htqA59krFBJRSD5PlbsCVh2M91eWqBo8iMHta1orlYxRk6Y7K6Halcy6FY
 aMu1EPf7ewR9YPo7woOFOu+NXx2ZQbnASIX7o2WH2eS6/Bbd7zm0IWQ88aQWJTmtKzLTcxbmcLN
 MWIOXGNI+0zRxOVz7FZe3jv9ZtC04m6j9ZVbi2F6MAQCT7VtuADx/zWigbL4ogHtxsXGyJe7wmp
 mQ/OZvcAGCHAKSsMoesbH4mzFDuiocx1aZgS1L+KhRIVQFxGBdkOqQ9y5CQJ5AUJ7Rvced4kc5S
 +czrNVj8mMqh9Xw73Ynt7zx4PY9tM+iX8eGf2B+0YR2uMFR2tknr8jPheHBsm85/Gs6hEUC5mee
 DoQ8po=
X-Received: by 2002:a17:90b:4c85:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-39d77b1c383mr17731519a91.15.1789209095553; 
 Sat, 12 Sep 2026 03:31:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/82] tcg: Generic expansion of tcg_gen_addi_*
Date: Sat, 12 Sep 2026 00:30:11 -1000
Message-ID: <20260912103126.598030-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
 include/tcg/tcg-op-common.h   |  6 ++++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 38 +++++++++++++++++------------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ab0c3f9554c..96d8ed8990a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -104,16 +104,19 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RI(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b);
 
+#define DEF_RRI(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TINT c);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
 #undef DEF_RI
+#undef DEF_RRI
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -216,7 +219,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index e36fd296a30..642cc7cfa48 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -3,4 +3,5 @@
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RR(mov)
+DEF_RRI(addi)
 DEF_RRR(add)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 30c84d348c9..b48dc62bdfc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -332,12 +332,16 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_RI(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, int64_t);
 
+#define DEF_RRI(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *, int64_t);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
 #undef DEF_RI
+#undef DEF_RRI
 
 /*
  * Generic expansions for templated operations.
@@ -350,6 +354,15 @@ static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
 }
 
+static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (unlikely(src2 == 0)) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_add(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -387,25 +400,20 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b)             \
     { gen_##NAME(TYPE, TTMP(a), b); }
 
+#define DEF_RRI(NAME)                                                   \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b, TINT c)         \
+    { gen_##NAME(TYPE, TTMP(a), TTMP(b), c); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
 #undef DEF_RR
 #undef DEF_RRR
 #undef DEF_RI
+#undef DEF_RRI
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
@@ -1543,16 +1551,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
     if (arg1 == 0) {
-- 
2.53.0


