Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E25C25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Re-00046k-06; Wed, 15 May 2024 03:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RW-000415-Hx
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:54 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RT-0001XQ-8J
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:53 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e0a34b2899so97510901fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759569; x=1716364369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QME3RTbGMfJpkg4v/+6E8q/97o230nz7+xr7hPnvphQ=;
 b=XyJmGYikq8NllYveg6JSEmxlHiAdvHe6bRZmada2p1ABnQtNXo0SjNOuOk5WzIzaa/
 sq5UDyWagokT8fkPPDV9lyeKsmfmFpUr2C746znPuJ9uE8kKrGyaYoTc1LCRMhjJY8xG
 apdRvn1z7oJP7+KQlwCV5nkiQkFKJglZMLyc4+sTbR/RugEzS9+IaIZw4jUqtxVUbdsc
 jXI6iOe23qgqWSTrRtbzqnoMz4G2H2guQIFxKYQnqWqxVFFbqDCYb5uCAd6pxYmQ/jpF
 2pBju+mPMgW5LkfDITZBONI/oXxrakmqC5UWZH2dsn3frbko4AGGSReCmuQ7loIahe+a
 WPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759569; x=1716364369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QME3RTbGMfJpkg4v/+6E8q/97o230nz7+xr7hPnvphQ=;
 b=Eh0q9m5fVePi3E6AIYrca6gClDndE+mXk6Nc7gn8K+mtksnkGWs+G0z3x/BhkWPeyx
 dHMiRphxlTAqckEbRZcbXSXzAyC5jTYRxXkfUlFmipBGSyOO5FxuROegLHL7ELxlGDzq
 qBULSsBkzHJPN7uE6qGV9Wsk9jou7fz7g3wzOdX5LJyu+N3+UPJRPei+/nsYENBQPHs7
 UbrBYSaMn8014PGC7OaWQRANzN6+GISVWZo7JgE8jhU6Nfx6ieeE9sxvooHS4Y1duABw
 UI7nXb1FUUiN2PwXgbxrMiaXQ2bKmirReEuoaHBq9ToTBLoOZf+KrD9Wjz+EUShPVC1+
 4SLg==
X-Gm-Message-State: AOJu0Yx+YaocWEXDPmqDmLZT2OMPwaxBiGpP/YKwhU7wl5a/mvs3HOEj
 iawuM/Y6LVR/GmBK5jpN9Mt7WYAg7iYYXeYPUFJ7tXM0czbQMYM6jAmR9J/mcQZJHBm6SJtqWIX
 n7oc=
X-Google-Smtp-Source: AGHT+IF5bwlXz4KQbyyGmKF89FVki54N0Nv8Ca94cWHDc7eGZi0xwUYAwzLoeg+0TMQIq1N9CLfmtw==
X-Received: by 2002:a2e:905a:0:b0:2e0:4216:6fa8 with SMTP id
 38308e7fff4ca-2e5203b421emr140198451fa.39.1715759569222; 
 Wed, 15 May 2024 00:52:49 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/34] accel/tcg: Use vaddr in translator_ld*
Date: Wed, 15 May 2024 09:52:14 +0200
Message-Id: <20240515075247.68024-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x236.google.com
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
 include/exec/translator.h     | 21 +++++++++------------
 accel/tcg/translator.c        | 15 ++++++++-------
 target/hexagon/translate.c    |  1 +
 target/microblaze/translate.c |  1 +
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 6cd937ac5c..51489c181c 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,10 +19,7 @@
  */
 
 #include "qemu/bswap.h"
-#include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
-#include "exec/abi_ptr.h"
-#include "cpu.h"
+#include "exec/vaddr.h"
 
 /**
  * gen_intermediate_code
@@ -185,14 +182,14 @@ bool translator_io_start(DisasContextBase *db);
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
@@ -203,7 +200,7 @@ translator_lduw_swap(CPUArchState *env, DisasContextBase *db,
 
 static inline uint32_t
 translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
-                    abi_ptr pc, bool do_swap)
+                    vaddr pc, bool do_swap)
 {
     uint32_t ret = translator_ldl(env, db, pc);
     if (do_swap) {
@@ -214,7 +211,7 @@ translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
 
 static inline uint64_t
 translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
-                    abi_ptr pc, bool do_swap)
+                    vaddr pc, bool do_swap)
 {
     uint64_t ret = translator_ldq(env, db, pc);
     if (do_swap) {
@@ -233,7 +230,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-void translator_fake_ldb(uint8_t insn8, abi_ptr pc);
+void translator_fake_ldb(uint8_t insn8, vaddr pc);
 
 /*
  * Return whether addr is on the same page as where disassembly started.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 6832e55135..53225290b1 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -14,6 +14,7 @@
 #include "exec/translator.h"
 #include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
+#include "exec/cpu_ldst.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 
@@ -294,11 +295,11 @@ static void *translator_access(CPUArchState *env, DisasContextBase *db,
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
@@ -315,7 +316,7 @@ static void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
 #endif
 }
 
-uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint8_t ret;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -329,7 +330,7 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint16_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -344,7 +345,7 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint32_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -359,7 +360,7 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
+uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint64_t ret, plug;
     void *p = translator_access(env, db, pc, sizeof(ret));
@@ -374,7 +375,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     return ret;
 }
 
-void translator_fake_ldb(uint8_t insn8, abi_ptr pc)
+void translator_fake_ldb(uint8_t insn8, vaddr pc)
 {
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 0904dc2d38..fcba82f7dc 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -25,6 +25,7 @@
 #include "exec/translation-block.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
+#include "exec/cpu_ldst.h"
 #include "internal.h"
 #include "attribs.h"
 #include "insn.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6d89c1a175..84cca04962 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -26,6 +26,7 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
+#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
 
-- 
2.34.1


