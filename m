Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4256BC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kF-0003Gl-F9; Thu, 17 Sep 2026 00:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jk-0003AS-Ka
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:43 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jh-0006mb-QB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:39 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-8686f46e4adso335390b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619316; x=1790224116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nS0F4afUEpaeo9DXWV3nrwx6iqbi97gY4q1OhP6mo8Y=;
 b=VzHqCi3fGHhyIszlQjrw4coxn1OevPQr6rK83L0jlqkOUZrrIvwkg6rTDpMtX3v3fR
 oIcAg3SF092SZwf2TuxLzURWnLxeVQtNQefpvtZFsL1QNKX1tTdcDcJZMH1Sy34b5AcI
 3RV5wE0ZMdm/0uEz88ULw6G8kqXcBVZ85MhCpbXVTXc+n86fLr7H4sjO70AY9i1N0TnH
 24iOTvxhxNBeU1y3PMBzKqLwBCItAVI+5DkYEjh7hbg66Yg8FV+SXUD0UpstlyqUQXT6
 6C1c377FtDnC2r0jsRnyc4faM+HYrro3IvHj44T45sXEmnvD7aqWzYPM4Basj9/lBzQw
 mQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619316; x=1790224116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nS0F4afUEpaeo9DXWV3nrwx6iqbi97gY4q1OhP6mo8Y=;
 b=D6miMtFKCFASHKCaaFCihhMPobgRAfesBHTEUzXAvt3KBdn2/HtqOeQPZhYWM9lVXf
 J7Rd0CuZWCidBGOTEtuUCU5fJxw4JfBk8hIdZ7snx7w+tAziF9Q6EKhFy3ISfPBW7vJt
 3WvMEg4j2s3m923TOnWkddmfZiBiDBDU23TaK3hXHRAka/ZZQLP7pXBB1mYAzKZ2CjzD
 frEhlCUvblGaF11Gr57zuKlzbdk4qgLGN4wbpkmJz9ZvUDdaWc7/2wDQXdue7RmYdhL9
 FIqmE/WGECcmDHyx1PD/J3GB6XG3uM9K5kFNbQXdgXjuTZjVOSFWMAF0Ldc3xXbkgpFs
 SPFg==
X-Gm-Message-State: AFuF++ny4nc1eGGkkvWbDN/z2yJXSrdhWgI93E2wlP6UnhCS7jEy0zDt
 uFqf3BVJeAgYZfS3ZbtwsHQVFTF+nsHcIgUc2WQ8kCFhxroZ//Meuj2i2eDkwp2AfzgvR38hd2c
 eW0ls9TU=
X-Gm-Gg: AYBFou0DOKb+api9hNtX4MsevD37FGZ7ZJy8kiJYe33Knf+4ncZSnBUZGNRV846DgsP
 OzqmU9fDuxVRYPTmB0s4cjy5tzcGnIL3RJ7Bi8LqCNyu7+PeTS302zT5WnTQ8/i1kFb2ghA4l89
 Ypo7rLrZsE762SUBvVGO+SlSt9EIAA5eo86DGVhKY2FJbj4/KWNJo9k+Sx0BWyOfKC3M1BwqFQ9
 wqUhOdJ/ktEKOzHRiQ22S83N0qFmnmtJcIWX/XSMdsvLnT7085mM8jTuQj67UCeglFpamqAPVBW
 7P1AyARM/Ks3IYV8Ut/6renymDxSmQYaohplJ8R7kRxqQ+B2WK0ALdtDjsZYLCuZDPYkKzC9WQm
 VuIsAaWgUZMsznYeHsmu8g7XSYROblNvN16ygsKS9gaEExF6rcXmMkiRZ336IK9oitmDbZdSeyJ
 Rjfatjin4QgX8oYwP8LlWFlQ6Wq66Yt4Trzc+WsTopH58n20hBzwePs4JD/ypmJ78W2Udy9fGoF
 UttzGg=
X-Received: by 2002:a05:6a21:32a9:b0:3dd:53e0:aabf with SMTP id
 adf61e73a8af0-3dd5f7a9b95mr12021272637.26.1789619316125; 
 Wed, 16 Sep 2026 21:28:36 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 009/101] tcg: Generic expansion of tcg_gen_mov_*
Date: Wed, 16 Sep 2026 18:26:51 -1000
Message-ID: <20260917042823.542588-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
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

Begin sharing code in the expansion of operations
for various TCG types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  | 29 +++++++++++-
 include/tcg/tcg-op-def.h.inc |  3 ++
 tcg/tcg-op.c                 | 91 ++++++++++++++++++++++++++++++------
 3 files changed, 107 insertions(+), 16 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 888f00d5f24..69331928bd5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -88,6 +88,33 @@ void tcg_gen_lookup_and_goto_ptr(void);
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
+/*
+ * Construct operations from templates.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
+
+#define TCGV  glue(TCGv,TEXT)
+#define TEXT  _i32
+#define TINT  int32_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+
+#define TEXT  _i64
+#define TINT  int64_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
 /* 32 bit ops */
 
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
@@ -172,7 +199,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_discard_i32(TCGv_i32 arg);
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -294,7 +320,6 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_discard_i64(TCGv_i64 arg);
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
new file mode 100644
index 00000000000..ebfaf0b8188
--- /dev/null
+++ b/include/tcg/tcg-op-def.h.inc
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: MIT */
+
+DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b738863ea69..6fc75b9286e 100644
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
@@ -315,6 +320,78 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
+/*
+ * Forward declarations of generic expansions.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2);
+
+#define TCGV  TCGTemp *
+#define TINT  int64_t
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
+/*
+ * Templated operations.
+ */
+
+#define DEF2(NAME, T1, T2)                                              \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b)                     \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
+
+#define C_TCGv_i32      tcgv_i32_temp
+#define C_TCGv_i64      tcgv_i64_temp
+#define C_int32_t
+#define C_int64_t
+
+#define TCGV  glue(TCGv,TEXT)
+#define TEXT  _i32
+#define TINT  int32_t
+#define TYPE  TCG_TYPE_I32
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+#undef TYPE
+
+#define TEXT  _i64
+#define TINT  int64_t
+#define TYPE  TCG_TYPE_I64
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TEXT
+#undef TINT
+#undef TCGV
+#undef TYPE
+
+#undef C_TCGv_i32
+#undef C_TCGv_i64
+#undef C_int32_t
+#undef C_int64_t
+
+#undef DEF2
+
+/*
+ * Generic expansions for templated operations.
+ * We have used compiler type checks to ensure all TCGTemp
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
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -322,13 +399,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
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
@@ -1396,13 +1466,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
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


