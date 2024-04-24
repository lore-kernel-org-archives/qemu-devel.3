Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9558C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldL-0003hD-Mg; Wed, 24 Apr 2024 19:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldI-0003fh-2h
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:33 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldG-0002cK-1e
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:31 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f00f24f761so362536b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999749; x=1714604549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpTCH1YULD/T8eR03//FfcdW59oyfLg0vMaMY0B4ivI=;
 b=U9z10mBUdfWLRsreHh6jP0kzlS17rVqCo/9h+qPvUVY/QPm5pT64iKhfJp13l2OLOB
 v2VEJ3NEQ8R6CASPyhgytFBKbu8GWmovhnDn9MTTMYI3RCrabFaigZsMgkTYZ6gLhsC7
 XqRPPNj4He/zUCk0ju4h923uGsiAk77FU4IOmrL024qnGucaIPaqAlWPaP5xwo0PryJC
 Yv68UgsrKHzp98FOKD93U39kvMPFaym4f1N5GabWIUfAMX8tCC8pMns95538dYIKPocu
 pWAw3AyOrltS4W3THSQjLkiA5O0SSwAOsHyvNQ6J4/0L2OcJ5styIdx9OPVSXcH2XBIq
 MPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999749; x=1714604549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpTCH1YULD/T8eR03//FfcdW59oyfLg0vMaMY0B4ivI=;
 b=m2hSic3dDrqtuMaOvMv+iDsk5JBaWvbq+rbrZk0A3sgfXlnz2VUTA3Ds8NCi1kN73y
 Z6IP9g4vejwkL5NquVzMSKi1zYgZBGRXRh6JN1OhWSbNnvsp8jexKNqHmIObP2uPUQrP
 hftIM7ijoRE/NuQDkhVhT0A6BunwjT39MMFn6WwVJwg1lFzczmM/Zo8DKSlq17MDBcWP
 Lu0s9tx+8bAJ/OTqYL3ZKuaD1pysL9de8xUCO6DZXWqMxRuD1qrVGX3RePEKiWQWiwpp
 VzmhKGOifH1dPpDn3GNEDTc4GM+ydw1jOuBebs5S1vUrpOo+NUS7YUOHOTrjsWrwbgS+
 7WYA==
X-Gm-Message-State: AOJu0YxYP2bSd7SizjCrsjJImkvg6ibe/9advhKFqCUy6YwFqG8Bj5J7
 uj6zUdpUEXb3fsIX/bWwtdylPv8gukmS/T/xbfcNDib4sdOBhlW+UsFxDlmo/Ql39IvBNr2f6YH
 l
X-Google-Smtp-Source: AGHT+IFY747fs1c+wiMjzx6dh1L+o2TM2dtBdT4mwM+23tUTp54vLNnekfZwNETbOwQxf7mMwLHCWw==
X-Received: by 2002:a05:6a00:1911:b0:6ec:fdfe:9bde with SMTP id
 y17-20020a056a00191100b006ecfdfe9bdemr4771761pfi.25.1713999748582; 
 Wed, 24 Apr 2024 16:02:28 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 02/20] tcg: Pass function pointer to tcg_gen_call*
Date: Wed, 24 Apr 2024 16:02:06 -0700
Message-Id: <20240424230224.941028-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For normal helpers, read the function pointer from the
structure earlier.  For plugins, this will allow the
function pointer to come from elsewhere.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h             | 21 +++++++++-------
 include/exec/helper-gen.h.inc | 24 ++++++++++++-------
 tcg/tcg.c                     | 45 +++++++++++++++++++----------------
 3 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e4c598428d..8d9f6585ff 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -852,19 +852,22 @@ typedef struct TCGTargetOpDef {
 
 bool tcg_op_supported(TCGOpcode op);
 
-void tcg_gen_call0(TCGHelperInfo *, TCGTemp *ret);
-void tcg_gen_call1(TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
-void tcg_gen_call2(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *);
-void tcg_gen_call3(TCGHelperInfo *, TCGTemp *ret, TCGTemp *,
+void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
+void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
+void tcg_gen_call2(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *);
-void tcg_gen_call4(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
-                   TCGTemp *, TCGTemp *);
-void tcg_gen_call5(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+void tcg_gen_call3(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *);
-void tcg_gen_call6(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+void tcg_gen_call4(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *);
-void tcg_gen_call7(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+void tcg_gen_call5(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *);
+void tcg_gen_call6(void *func, TCGHelperInfo *, TCGTemp *ret,
+                   TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *);
+void tcg_gen_call7(void *func, TCGHelperInfo *, TCGTemp *ret,
+                   TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *, TCGTemp *);
 
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
index c009641517..f7eb59b6c1 100644
--- a/include/exec/helper-gen.h.inc
+++ b/include/exec/helper-gen.h.inc
@@ -14,7 +14,8 @@
 extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
+    tcg_gen_call0(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret));            \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
@@ -22,7 +23,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-    tcg_gen_call1(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call1(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1));                                       \
 }
 
@@ -31,7 +33,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-    tcg_gen_call2(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call2(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
@@ -40,7 +43,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-    tcg_gen_call3(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call3(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
@@ -50,7 +54,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-    tcg_gen_call4(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call4(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2),                         \
                   dh_arg(t3, 3), dh_arg(t4, 4));                        \
 }
@@ -61,7 +66,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-    tcg_gen_call5(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call5(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5));                        \
 }
@@ -72,7 +78,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
-    tcg_gen_call6(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call6(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
 }
@@ -84,7 +91,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
-    tcg_gen_call7(&glue(helper_info_, name), dh_retvar(ret),            \
+    tcg_gen_call7(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
                   dh_arg(t7, 7));                                       \
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0c0bb9d169..0bf218314b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2251,7 +2251,8 @@ bool tcg_op_supported(TCGOpcode op)
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
 
-static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
+static void tcg_gen_callN(void *func, TCGHelperInfo *info,
+                          TCGTemp *ret, TCGTemp **args)
 {
     TCGv_i64 extend_free[MAX_CALL_IARGS];
     int n_extend = 0;
@@ -2329,7 +2330,7 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
             g_assert_not_reached();
         }
     }
-    op->args[pi++] = (uintptr_t)info->func;
+    op->args[pi++] = (uintptr_t)func;
     op->args[pi++] = (uintptr_t)info;
     tcg_debug_assert(pi == total_args);
 
@@ -2345,56 +2346,58 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
     }
 }
 
-void tcg_gen_call0(TCGHelperInfo *info, TCGTemp *ret)
+void tcg_gen_call0(void *func, TCGHelperInfo *info, TCGTemp *ret)
 {
-    tcg_gen_callN(info, ret, NULL);
+    tcg_gen_callN(func, info, ret, NULL);
 }
 
-void tcg_gen_call1(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1)
+void tcg_gen_call1(void *func, TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1)
 {
-    tcg_gen_callN(info, ret, &t1);
+    tcg_gen_callN(func, info, ret, &t1);
 }
 
-void tcg_gen_call2(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1, TCGTemp *t2)
+void tcg_gen_call2(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2)
 {
     TCGTemp *args[2] = { t1, t2 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call3(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
-                   TCGTemp *t2, TCGTemp *t3)
+void tcg_gen_call3(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
 {
     TCGTemp *args[3] = { t1, t2, t3 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call4(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
-                   TCGTemp *t2, TCGTemp *t3, TCGTemp *t4)
+void tcg_gen_call4(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3, TCGTemp *t4)
 {
     TCGTemp *args[4] = { t1, t2, t3, t4 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call5(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+void tcg_gen_call5(void *func, TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
                    TCGTemp *t2, TCGTemp *t3, TCGTemp *t4, TCGTemp *t5)
 {
     TCGTemp *args[5] = { t1, t2, t3, t4, t5 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call6(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1, TCGTemp *t2,
-                   TCGTemp *t3, TCGTemp *t4, TCGTemp *t5, TCGTemp *t6)
+void tcg_gen_call6(void *func, TCGHelperInfo *info, TCGTemp *ret,
+                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3,
+                   TCGTemp *t4, TCGTemp *t5, TCGTemp *t6)
 {
     TCGTemp *args[6] = { t1, t2, t3, t4, t5, t6 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
-void tcg_gen_call7(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+void tcg_gen_call7(void *func, TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
                    TCGTemp *t2, TCGTemp *t3, TCGTemp *t4,
                    TCGTemp *t5, TCGTemp *t6, TCGTemp *t7)
 {
     TCGTemp *args[7] = { t1, t2, t3, t4, t5, t6, t7 };
-    tcg_gen_callN(info, ret, args);
+    tcg_gen_callN(func, info, ret, args);
 }
 
 static void tcg_reg_alloc_start(TCGContext *s)
-- 
2.34.1


