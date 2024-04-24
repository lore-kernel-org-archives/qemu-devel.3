Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98F9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5X-0005mO-BY; Wed, 24 Apr 2024 19:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5S-0005kV-FX
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:39 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Q-0003N2-9x
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:38 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ff57410ebbso328630a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001494; x=1714606294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBxX6V9wjd/+Q59RJb43vuZBy1cLIl1w0CB7kBrEvAE=;
 b=CEY7WIz6oDg6BocTADMk3dKHGjN28eT8W1bzXZAgJpxZ5cLXagcxn8tAmXr5CzJMTp
 it3MRRsPvnm5RUKV4PZSVVvPDYsXzhkrQiSGfS9jLmWwyc1ynTAUH+mm3G39m5Hm724f
 7JrC7R6IgkQjw8/FnevUS4uMOIVZnu26lEg5Lw9BHFkg67kMr6oLHpzRhk9eKo3UX98Q
 d0OZfsfB1XoHmB+rb9DopjoV8qraQHm6ku7OSvx6DpY8RI8mkxm0MafgGwVhyOgLnte6
 PHDAoAoKav7bo2hQwlmZlWnmh+PeW/npHT0wHGAj0u4ztL5IT006FHCneChiofBb+cpJ
 M+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001494; x=1714606294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBxX6V9wjd/+Q59RJb43vuZBy1cLIl1w0CB7kBrEvAE=;
 b=A/Uj9p2kSWK5pW3ggSnqCzlevQkPBCYXzWIjQiDg9MnGe3NzuXFqlrb6d9Yl65az5L
 HW8diU5FFnLEHMCp11WlJ9pGe7x/wgApNE7njhs7NHbPJpkf6aabIQWNAR0P2J8Bn42F
 z3KUJtFU1ZCqkbeR+MVC+Hx5HnNFT8rfPO/KSyNF+AEVv2yzq2pxXZ5micWNVJX0j9jf
 o/MyNyQjZ54Wooitu0/fmo8txFMl9lTysJmWuCTOLLPyaaMudywA+6srC5AEm4izQ3HX
 tXZzvKZgk+0AHrokckAXvOeyc724jzEojvepMV3G4YqVodAWmCCV/9hC5NeWOMXvyBrn
 Jtjg==
X-Gm-Message-State: AOJu0Yy/o9igjYwqfTEpgZkbxAj/0zE4wyKg+4VisfBk6bO2sEBmAfE2
 vH9SAXrp2r4uACPqb1pIapZfQrrYXQWcrVBiPRQCerNclqrAKot4p3wEDIDSsRiF7AxjC5X/OuV
 n
X-Google-Smtp-Source: AGHT+IFYQa63t7GpfbaOFQEH2CU8sbGmEipHaDnacD4sPGqWUNoNEfSXUljY/hnaqNLKb5qBvrN2Vw==
X-Received: by 2002:a17:90b:120e:b0:2a4:b831:5017 with SMTP id
 gl14-20020a17090b120e00b002a4b8315017mr2144910pjb.48.1714001494233; 
 Wed, 24 Apr 2024 16:31:34 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/33] accel/tcg: Use vaddr in translator_ld*
Date: Wed, 24 Apr 2024 16:30:59 -0700
Message-Id: <20240424233131.988727-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h     | 18 +++++++++---------
 accel/tcg/translator.c        | 15 ++++++++-------
 target/hexagon/translate.c    |  1 +
 target/microblaze/translate.c |  1 +
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 2c4fb818e7..51489c181c 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/bswap.h"
-#include "exec/cpu_ldst.h"	/* for abi_ptr */
+#include "exec/vaddr.h"
 
 /**
  * gen_intermediate_code
@@ -182,14 +182,14 @@ bool translator_io_start(DisasContextBase *db);
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
@@ -200,7 +200,7 @@ translator_lduw_swap(CPUArchState *env, DisasContextBase *db,
 
 static inline uint32_t
 translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
-                    abi_ptr pc, bool do_swap)
+                    vaddr pc, bool do_swap)
 {
     uint32_t ret = translator_ldl(env, db, pc);
     if (do_swap) {
@@ -211,7 +211,7 @@ translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
 
 static inline uint64_t
 translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
-                    abi_ptr pc, bool do_swap)
+                    vaddr pc, bool do_swap)
 {
     uint64_t ret = translator_ldq(env, db, pc);
     if (do_swap) {
@@ -230,7 +230,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-void translator_fake_ldb(uint8_t insn8, abi_ptr pc);
+void translator_fake_ldb(uint8_t insn8, vaddr pc);
 
 /*
  * Return whether addr is on the same page as where disassembly started.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9de0bc34c8..42fa977e45 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -13,6 +13,7 @@
 #include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
+#include "exec/cpu_ldst.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 
@@ -293,11 +294,11 @@ static void *translator_access(CPUArchState *env, DisasContextBase *db,
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
@@ -314,7 +315,7 @@ static void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
 #endif
 }
 
-uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint8_t ret;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -328,7 +329,7 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint16_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -343,7 +344,7 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint32_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -358,7 +359,7 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint64_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -373,7 +374,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
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
index fc451befae..0941aa67c0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -25,6 +25,7 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
+#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
 
-- 
2.34.1


