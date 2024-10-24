Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADFDD0E3F7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43v8-0001zn-P3; Thu, 24 Oct 2024 15:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t43v6-0001zZ-SH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:54:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t43v4-0001KX-Cl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:54:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cbb1cf324so10540385ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729799692; x=1730404492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fGQe9LgCzinjcSkVA4DthbYV5GUCfqC+fO5Ksg2Wis0=;
 b=Aro3V1FCPTn6lYiiC+/PsQsyzXU9kD8bfsAPizZjfbHJWYlGZeY0HeK/ml/7CxlWW4
 VFze7OHON2iuq6usJQuzOBGuJa8ut0PipHujfEyei6NatyfLBwjLdScRia4+6MO2r8wp
 CXImSRMgy93TkwZlG3Wd+wAMfjJaMhlAniDe8A4ulyVEDtH9ZTsSaWBl7BbSZJl+gxhi
 8We5cJ6S/YyeA/EZ0QikiY53/tAHYcIw7GsmC+t772Ffq96uYPIxKiQGkv8iAPTJTlhC
 U6DC20N3pr5k9UfhbTpA6ERzp8ICgvOU9EiS4us7ErbPzTpulWa9/m2pibNFYPBOuFlS
 4Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729799692; x=1730404492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGQe9LgCzinjcSkVA4DthbYV5GUCfqC+fO5Ksg2Wis0=;
 b=aqVm9QcWGZFbeoJ37rpONfNOZtkMft0Vxqk1H1JK4KuXLmVygCApIkplUEIo/VYrY5
 ivdr5oaWQOKnFZuDmEVsLwIsPN1w3uF9hAy7BSGUvW/nPBQUu440xtP1oGCnBOLKt926
 MVVhujsBwk4KcwxmLI03VB1zLVXz022N2eVXvNQoNdPo2EwHmH67Z99JbNEVv8LzA7Gr
 lfrx8driNlAgPgU4VjCD0orjXrj06Xh928MKXjXRLQW9oMtlvwmj0Ln2iB5OW5b2leMd
 T951MdVCuAg6g+eAt9DEj5cnGkZhOTEqXuNIvbPjz5RUmg2jADZK+9hD8/xoqElJD7qT
 76Lg==
X-Gm-Message-State: AOJu0YztTCtXYSOMVKCYngKSd8d68oKnctpPcshcST/hbPqZ5Y7aAC7V
 39sJtRV897eX5QE3hVtokg20cd3ISu1zCN3l6io1rFPuSD+D4yzo00Uvwp3CVIBIHBL2ah+YpDn
 W
X-Google-Smtp-Source: AGHT+IHM79ZOnFG5okB3pzVYocxlb25bNJzBF6AW3Ux2d4LkOtd3qy6Lg6HXtdiVsgEuh7i9XjxExg==
X-Received: by 2002:a17:903:32cb:b0:20c:8abc:733a with SMTP id
 d9443c01a7336-20fb9a3b790mr39606845ad.53.1729799691693; 
 Thu, 24 Oct 2024 12:54:51 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0de4f5sm75989015ad.192.2024.10.24.12.54.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 12:54:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/mips: Introduce disas_mt_available()
Date: Thu, 24 Oct 2024 16:54:47 -0300
Message-ID: <20241024195447.44600-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Similarly to commit 17c2c320f3c ("Introduce ase_mt_available helper"),
introduce the disas_mt_available() one which takes a DisasContext
argument to determine whether Multi-Threading is available by
checking the MT bit of the CP0_Config3 register.

Remove the then unused ASE_MT definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/mips-defs.h     |   1 -
 target/mips/tcg/translate.h |   5 ++
 target/mips/tcg/translate.c | 136 ++++++++++++++++++------------------
 target/mips/cpu-defs.c.inc  |   4 +-
 4 files changed, 75 insertions(+), 71 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 6b5cd0d8f53..9d4d292586c 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -30,7 +30,6 @@
 #define ASE_DSP           0x0000000008000000ULL
 #define ASE_DSP_R2        0x0000000010000000ULL
 #define ASE_DSP_R3        0x0000000020000000ULL
-#define ASE_MT            0x0000000040000000ULL
 #define ASE_SMARTMIPS     0x0000000080000000ULL
 #define ASE_MICROMIPS     0x0000000100000000ULL
 /*
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 5d196e69ac4..b613726ea42 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -228,6 +228,11 @@ bool decode_ext_octeon(DisasContext *ctx, uint32_t insn);
 #endif
 bool decode_ext_vr54xx(DisasContext *ctx, uint32_t insn);
 
+static inline bool disas_mt_available(DisasContext *ctx)
+{
+    return ctx->CP0_Config3 & (1 << CP0C3_MT);
+}
+
 /*
  * Helpers for implementing sets of trans_* functions.
  * Defer the implementation of NAME to FUNC, with optional extra arguments.
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9e0c319bb23..dd8918d1a31 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -5315,17 +5315,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpcontrol(arg, tcg_env);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf0(arg, tcg_env);
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf1(arg, tcg_env);
             register_name = "MVPConf1";
             break;
@@ -5346,37 +5346,37 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEControl));
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf0));
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf1));
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_YQMask));
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEOpt));
             register_name = "VPEOpt";
             break;
@@ -5403,37 +5403,37 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcstatus(arg, tcg_env);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcbind(arg, tcg_env);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcrestart(arg, tcg_env);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tchalt(arg, tcg_env);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tccontext(arg, tcg_env);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcschedule(arg, tcg_env);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcschefback(arg, tcg_env);
             register_name = "TCScheFBack";
             break;
@@ -6072,17 +6072,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_mvpcontrol(tcg_env, arg);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf1";
             break;
@@ -6102,39 +6102,39 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpecontrol(tcg_env, arg);
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf0(tcg_env, arg);
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf1(tcg_env, arg);
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_yqmask(tcg_env, arg);
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeopt(tcg_env, arg);
             register_name = "VPEOpt";
             break;
@@ -6149,37 +6149,37 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcstatus(tcg_env, arg);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcbind(tcg_env, arg);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcrestart(tcg_env, arg);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tchalt(tcg_env, arg);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tccontext(tcg_env, arg);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschedule(tcg_env, arg);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschefback(tcg_env, arg);
             register_name = "TCScheFBack";
             break;
@@ -6822,17 +6822,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpcontrol(arg, tcg_env);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf0(arg, tcg_env);
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_mvpconf1(arg, tcg_env);
             register_name = "MVPConf1";
             break;
@@ -6853,40 +6853,40 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEControl));
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf0));
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf1));
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_ld_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_YQMask));
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_ld_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_ld_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEOpt));
             register_name = "VPEOpt";
             break;
@@ -6902,37 +6902,37 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcstatus(arg, tcg_env);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mfc0_tcbind(arg, tcg_env);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tcrestart(arg, tcg_env);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tchalt(arg, tcg_env);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tccontext(arg, tcg_env);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tcschedule(arg, tcg_env);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_dmfc0_tcschefback(arg, tcg_env);
             register_name = "TCScheFBack";
             break;
@@ -7539,17 +7539,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Index";
             break;
         case CP0_REG00__MVPCONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_mvpcontrol(tcg_env, arg);
             register_name = "MVPControl";
             break;
         case CP0_REG00__MVPCONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf0";
             break;
         case CP0_REG00__MVPCONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             /* ignored */
             register_name = "MVPConf1";
             break;
@@ -7569,39 +7569,39 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "Random";
             break;
         case CP0_REG01__VPECONTROL:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpecontrol(tcg_env, arg);
             register_name = "VPEControl";
             break;
         case CP0_REG01__VPECONF0:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf0(tcg_env, arg);
             register_name = "VPEConf0";
             break;
         case CP0_REG01__VPECONF1:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeconf1(tcg_env, arg);
             register_name = "VPEConf1";
             break;
         case CP0_REG01__YQMASK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_yqmask(tcg_env, arg);
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             tcg_gen_st_tl(arg, tcg_env,
                           offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_vpeopt(tcg_env, arg);
             register_name = "VPEOpt";
             break;
@@ -7616,37 +7616,37 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcstatus(tcg_env, arg);
             register_name = "TCStatus";
             break;
         case CP0_REG02__TCBIND:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcbind(tcg_env, arg);
             register_name = "TCBind";
             break;
         case CP0_REG02__TCRESTART:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcrestart(tcg_env, arg);
             register_name = "TCRestart";
             break;
         case CP0_REG02__TCHALT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tchalt(tcg_env, arg);
             register_name = "TCHalt";
             break;
         case CP0_REG02__TCCONTEXT:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tccontext(tcg_env, arg);
             register_name = "TCContext";
             break;
         case CP0_REG02__TCSCHEDULE:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschedule(tcg_env, arg);
             register_name = "TCSchedule";
             break;
         case CP0_REG02__TCSCHEFBACK:
-            CP0_CHECK(ctx->insn_flags & ASE_MT);
+            CP0_CHECK(disas_mt_available(ctx));
             gen_helper_mtc0_tcschefback(tcg_env, arg);
             register_name = "TCScheFBack";
             break;
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 09bd62d430a..922fc39138d 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -314,7 +314,7 @@ const mips_def_t mips_defs[] =
                     (0x3fe << CP0SRSC4_SRS14) | (0x3fe << CP0SRSC4_SRS13),
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_MT,
+        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
@@ -543,7 +543,7 @@ const mips_def_t mips_defs[] =
         .SEGBITS = 32,
         .PABITS = 32,
         .insn_flags = CPU_MIPS32R6 | ISA_NANOMIPS32 |
-                      ASE_DSP | ASE_DSP_R2 | ASE_DSP_R3 | ASE_MT,
+                      ASE_DSP | ASE_DSP_R2 | ASE_DSP_R3,
         .mmu_type = MMU_TYPE_R4000,
     },
 #if defined(TARGET_MIPS64)
-- 
2.45.2


