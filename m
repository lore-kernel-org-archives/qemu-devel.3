Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A563CC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWL-0005kV-Mh; Fri, 02 Feb 2024 00:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWJ-0005k3-Uf
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:23 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWA-0002wd-8T
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:23 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso13646785ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853313; x=1707458113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHTgshUz3efE+7SkB9HdUmE2rql9T+3s9m+XHqmCTak=;
 b=ibc1NlueGCC87Zd5vKYqZCgE1aZ0TqF/SkEhxGxnV/NfWUZB24qPQKVD3HfOfOkS33
 qsKafGgBLNVEK/WR+Uhqw67TYz7t/mE6owBRuxZEo5k1Z32CPXh/3ma6JSg0Dkx7xxhC
 Ddl8aOMuYg5V/Y/sj5D+WyqbxL/paWeW3wGpzh9ORW5u/Mmgix6XYWGLhzRZ3aRqUYEn
 Vm7ClfSyQgaGfHHKHTKZtMYtCMvqMPsGTUO7VXeiQays0Pq/brh6BN4gpG7al9irQAdu
 F4wjh/3WX7DHRHnYQkLvsAAztgLBvixw9y//GagDpbnLtyloN1IXOtuonaJnvnmjXZBW
 l2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853313; x=1707458113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHTgshUz3efE+7SkB9HdUmE2rql9T+3s9m+XHqmCTak=;
 b=f32wg2aafEMAYoifMhdOvTsFF/5PEPtSKbOAbHUiEZG3vPD5TGYVCgBAikCjnVtDMZ
 jnl6H57lzJGFjx1hcqyGYD5/jPABERe6KOH6JuEVW1+YjYQQ82t4Fe3VRx/NI5c8lwVo
 SbkYEzhqQyzhN8r90L/leaZgZudHKX8g3WrTPWiThsnzUKXsnBkIejmTWKGixSV9Over
 UrCXrKRCjULNIow2mbR/iqH+x1LUqEmZV4WgPTbq8O+Znl+bVwTmGFcKN1rp1vGr4FpY
 KeE64OGSMF8h6uVBubyjN1/+/pHTLumuBrhHtJu7nZ+KcRdI9oMgzoI1yqsoB9b2q/yg
 WM8A==
X-Gm-Message-State: AOJu0YyEy1LaVEBroGsIsVESIK8l/P1hpYuLT0qSI16haxm+cSfgGEwc
 TaX8CjxZHpvo+21H8zlurX2a/J6thSXNCvYynkvAzx+FuPl4nCX54+Z/Eyw6WTXvSgS4An90VrX
 Hb3I=
X-Google-Smtp-Source: AGHT+IEhxEZIT9k2gEGA+AsHplv/JxWnONpo/4P1FsZUdZBcDiYVh9xG4SkaigHnc1Zw8PMvevMQEw==
X-Received: by 2002:a17:902:650c:b0:1d7:5943:21b8 with SMTP id
 b12-20020a170902650c00b001d7594321b8mr1246075plk.16.1706853312952; 
 Thu, 01 Feb 2024 21:55:12 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 41/57] target/sparc: Use i128 for FSQRTq
Date: Fri,  2 Feb 2024 15:50:20 +1000
Message-Id: <20240202055036.684176-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-7-richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/fop_helper.c | 26 ++++++++++++++++++++++++--
 target/sparc/translate.c  | 12 +++++++-----
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 74a1575d21..eea2fa570c 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -43,7 +43,7 @@ DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_1(fsqrtq, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_2(fsqrtq, TCG_CALL_NO_RWG, i128, env, i128)
 DEF_HELPER_FLAGS_1(fcmpq, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpeq, TCG_CALL_NO_WG, tl, env)
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index d6fb769769..d639e50965 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -26,6 +26,28 @@
 #define QT0 (env->qt0)
 #define QT1 (env->qt1)
 
+static inline float128 f128_in(Int128 i)
+{
+    union {
+        Int128 i;
+        float128 f;
+    } u;
+
+    u.i = i;
+    return u.f;
+}
+
+static inline Int128 f128_ret(float128 f)
+{
+    union {
+        Int128 i;
+        float128 f;
+    } u;
+
+    u.f = f;
+    return u.i;
+}
+
 static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
 {
     target_ulong status = get_float_exception_flags(&env->fp_status);
@@ -222,9 +244,9 @@ float64 helper_fsqrtd(CPUSPARCState *env, float64 src)
     return float64_sqrt(src, &env->fp_status);
 }
 
-void helper_fsqrtq(CPUSPARCState *env)
+Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
 {
-    QT0 = float128_sqrt(QT1, &env->fp_status);
+    return f128_ret(float128_sqrt(f128_in(src), &env->fp_status));
 }
 
 #define GEN_FCMP(name, size, reg1, reg2, FS, E)                         \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 41952281dc..ca98565c16 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4669,8 +4669,10 @@ TRANS(FNEGq, 64, do_qq, a, gen_op_fnegq)
 TRANS(FABSq, 64, do_qq, a, gen_op_fabsq)
 
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
-                       void (*func)(TCGv_env))
+                      void (*func)(TCGv_i128, TCGv_env, TCGv_i128))
 {
+    TCGv_i128 t;
+
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4679,11 +4681,11 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
-    func(tcg_env);
+
+    t = gen_load_fpr_Q(dc, a->rs);
+    func(t, tcg_env, t);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    gen_store_fpr_Q(dc, a->rd, t);
     return advance_pc(dc);
 }
 
-- 
2.34.1


