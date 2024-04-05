Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188FDCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl6-0005z6-Nr; Fri, 05 Apr 2024 06:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl4-0005xk-NJ
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgkr-0004NN-PQ
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6eced1dab1fso1462824b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312703; x=1712917503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5/CiOSfkjWjMtqqZEcZpCs+EVmjBtCRTaDzPf8PAx+4=;
 b=lKCaUAuctf+nHu7378RzPh/1SAlRwvQMXUV0od/H2oSoeNuFgFeTIVW/NIHIO6ZYAw
 5oiKhjyldyI1NYePL6HvHIy8CFGcie15TGDZ9XjNeOorMTHtYUr2pKBiV+rTAcT1CLdX
 YGz27eesv9ZOtk/FreWTkajtUPHgsTCa1lzTUofXOvpmRhsQY+2oql6oaAZlH5eSRMhw
 LZOVAP2P/JAtsl1MctJ9IH1qaszKVCoLC0L+LoFNLEc/dzHWgaoypwmp6Stf8GAHiUaB
 CIZAQKSt48yqUkZgHmjBUey5NgXt1xqipGYTvdcOw7eTvhuIog4VUnBEtUIba1WoORSj
 3SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312703; x=1712917503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/CiOSfkjWjMtqqZEcZpCs+EVmjBtCRTaDzPf8PAx+4=;
 b=c2lvMC8jpY5U4DxPpwNIdTzoRM2vJnf8Abq7M67OieDI3Sv87gaF0B/vc9hg7rIRLy
 R4BjYHMn66So/RuDELJU+W3yJOpZFnMigJMiXrcdEScdiMIVin1SrwFMzouUrcT6SDve
 0B5eKtbK53k7qJyS7XHR0VXcQxS1Y3tr+srCee6UMDbB67k/ngFuIjyE1mScDM187aZG
 PqeIy1H30u795ZQnV1tGkDx6dSIcwSyKtCozocT31HN6Q4g3Q5z7bS6qqgIeTeP/GV7d
 TP4H/7UT/taDXGMbImQfzCc/95RFK5RDqStsicXz2bwkW5Y4f9TImPjVIszBvGUzWP/k
 dK9Q==
X-Gm-Message-State: AOJu0YzvhJlE5XnEj4I3GsR2Tjlxd4LsXVW9uoXkMc0rdcDqZwvOl/iN
 zD8FOgVlremw7LS+9i5B2ivs7c6WDCjV7qAClsdnGWzQhStrTlc52qWbB/q/9wk69QrP08Bde4R
 Q
X-Google-Smtp-Source: AGHT+IEbzEmEer5A/ib8fQqfuBxM+UUv/e4tlRgDXaUrGlLduSYgYrTKXzw/+1jr7BSD0FcdWHZIKw==
X-Received: by 2002:aa7:88d3:0:b0:6e6:970f:a809 with SMTP id
 k19-20020aa788d3000000b006e6970fa809mr1149843pff.20.1712312703150; 
 Fri, 05 Apr 2024 03:25:03 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/32] accel/tcg: Use vaddr in translator_ld*
Date: Fri,  5 Apr 2024 00:24:28 -1000
Message-Id: <20240405102459.462551-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 include/exec/translator.h     | 18 +++++++++---------
 accel/tcg/translator.c        | 15 ++++++++-------
 target/hexagon/translate.c    |  1 +
 target/microblaze/translate.c |  1 +
 target/nios2/translate.c      |  1 +
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 51624feb10..29804de92e 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/bswap.h"
-#include "exec/cpu_ldst.h"	/* for abi_ptr */
+#include "exec/vaddr.h"
 
 /**
  * gen_intermediate_code
@@ -180,14 +180,14 @@ bool translator_io_start(DisasContextBase *db);
  * the relevant information at translation time.
  */
 
-uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc);
-uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, abi_ptr pc);
-uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, abi_ptr pc);
-uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc);
+uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc);
+uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc);
+uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc);
+uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc);
 
 static inline uint16_t
 translator_lduw_swap(CPUArchState *env, DisasContextBase *db,
-                     abi_ptr pc, bool do_swap)
+                     vaddr pc, bool do_swap)
 {
     uint16_t ret = translator_lduw(env, db, pc);
     if (do_swap) {
@@ -198,7 +198,7 @@ translator_lduw_swap(CPUArchState *env, DisasContextBase *db,
 
 static inline uint32_t
 translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
-                    abi_ptr pc, bool do_swap)
+                    vaddr pc, bool do_swap)
 {
     uint32_t ret = translator_ldl(env, db, pc);
     if (do_swap) {
@@ -209,7 +209,7 @@ translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
 
 static inline uint64_t
 translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
-                    abi_ptr pc, bool do_swap)
+                    vaddr pc, bool do_swap)
 {
     uint64_t ret = translator_ldq(env, db, pc);
     if (do_swap) {
@@ -228,7 +228,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-void translator_fake_ldb(uint8_t insn8, abi_ptr pc);
+void translator_fake_ldb(uint8_t insn8, vaddr pc);
 
 /*
  * Return whether addr is on the same page as where disassembly started.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 38c34009a5..9ac0f52b47 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -13,6 +13,7 @@
 #include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
+#include "exec/cpu_ldst.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 
@@ -290,11 +291,11 @@ static void *translator_access(CPUArchState *env, DisasContextBase *db,
     return host + (pc - base);
 }
 
-static void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
+static void plugin_insn_append(vaddr pc, const void *from, size_t size)
 {
 #ifdef CONFIG_PLUGIN
     struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
-    abi_ptr off;
+    size_t off;
 
     if (insn == NULL) {
         return;
@@ -311,7 +312,7 @@ static void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
 #endif
 }
 
-uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint8_t ret;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -325,7 +326,7 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint16_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -340,7 +341,7 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint32_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -355,7 +356,7 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint64_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -370,7 +371,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-void translator_fake_ldb(uint8_t insn8, abi_ptr pc)
+void translator_fake_ldb(uint8_t insn8, vaddr pc)
 {
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index f163eefe97..c9bf0e7508 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
+#include "exec/cpu_ldst.h"
 #include "internal.h"
 #include "attribs.h"
 #include "insn.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4e52ef32db..916afd4dec 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -25,6 +25,7 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
+#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
 
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 7ddc6ac1a2..9c3958a0ba 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -32,6 +32,7 @@
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
 #include "semihosting/semihost.h"
+#include "exec/cpu_ldst.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
-- 
2.34.1


