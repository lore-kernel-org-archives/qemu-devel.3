Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97846C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rn-0004D2-3r; Wed, 15 May 2024 03:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rg-000485-DV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Re-0001az-2H
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-420180b58c3so20617185e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759580; x=1716364380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMLriNtzm2n+Yau1lbyLPe0VCMn1fshh8b//AyQSKv8=;
 b=gbFQXnCuY4bpbtCifm07lLkJh5fSuaAVUWkfzK0G0AyKbsBA+Z7uMQ4OG5uHSm0xM8
 RMkWC+3/H7lfsxVcMN2U1rispcIgsIcQDlZ75bfsGtPCbjQA3XmNlsC7HtVxmNY+F+fh
 Uxo1fKLRysV48kJ/we75N2tmQN2J4yun8O2MivxJ7LBkzJ5ROCc3lo4B2yJKbSSMprig
 6EiCgN4vWe8z3ZqMsV2hGe2tdQjLcWBp/oSQ7lMwdGzs7yJiRxDs47zqda4LHAdyXyl5
 SlF+o3yAqT+2tf8ntJddBSMvlnA1WiLw+Fg2AJBadssEBOTKvA2fhIAOxYXL920VURft
 pLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759580; x=1716364380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMLriNtzm2n+Yau1lbyLPe0VCMn1fshh8b//AyQSKv8=;
 b=WLNc9Uk6eU1hJbbe/oiqqpoO9PQN3dAp59Jclz1QsOJeyHAp+qWTEvdKwpFkecbFLl
 2q7qYbQss0gVN2Wlp5Y3J10PFCVpeszxj+OWgJRcqxufPoMcItH8x3Bn80rqoiJWxe3K
 XXtZZ3/y5JURVmrLC3sFS1qJvAXH75ZNCqX500PmOF9KKuOchsUIjVOF1x7aUQwZigYH
 JnhJvgAlR5Zgw3E5HBzOzioWhX+7ZrmhdX4FgizhRAiP79NpvDEbqf4GPKc+S/wBwt8o
 vdmW1j2flc2RXSWr33SHlU+iwVGmi1gHPRlTBx40rGWDoel6miOdQ8r9I2vdO4CK5CVK
 vXtw==
X-Gm-Message-State: AOJu0YxHnyx9tMjZO8la8wltjW34ZdircRJgsDZaBCdOUoX3xMq76CE7
 ZqStJM3775QOJ+9HECfjX3jqFUcwaq8IyHpGAAOVxj4Tjp5B802R+rY5PIBYQa5hiS4/EfeZ68T
 F8uU=
X-Google-Smtp-Source: AGHT+IGblsUejkIR3mt3SoycRV0gh8rbXIx8l9RRS6MNhtqCxgqmieC9Lp3KfN/nxbxBc88f+4Mogw==
X-Received: by 2002:a05:600c:4182:b0:41a:a5ff:ea3a with SMTP id
 5b1f17b1804b1-41feaa390ffmr97941215e9.19.1715759580566; 
 Wed, 15 May 2024 00:53:00 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/34] accel/tcg: Return bool from TranslatorOps.disas_log
Date: Wed, 15 May 2024 09:52:30 +0200
Message-Id: <20240515075247.68024-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

We have eliminated most uses of this hook.  Reduce
further by allowing the hook to handle only the
special cases, returning false for normal processing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h    |  2 +-
 accel/tcg/translator.c       |  5 ++---
 target/hppa/translate.c      | 15 ++++++---------
 target/s390x/tcg/translate.c |  8 +++-----
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index fff857a0cc..31c39ab63c 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -135,7 +135,7 @@ typedef struct TranslatorOps {
     void (*insn_start)(DisasContextBase *db, CPUState *cpu);
     void (*translate_insn)(DisasContextBase *db, CPUState *cpu);
     void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
-    void (*disas_log)(const DisasContextBase *db, CPUState *cpu, FILE *f);
+    bool (*disas_log)(const DisasContextBase *db, CPUState *cpu, FILE *f);
 } TranslatorOps;
 
 /**
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 98d2500c53..ccd22dcd95 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -228,9 +228,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         if (logfile) {
             fprintf(logfile, "----------------\n");
 
-            if (ops->disas_log) {
-                ops->disas_log(db, cpu, logfile);
-            } else {
+            if (!ops->disas_log ||
+                !ops->disas_log(db, cpu, logfile)) {
                 fprintf(logfile, "IN: %s\n", lookup_symbol(db->pc_first));
                 target_disas(logfile, cpu, db->pc_first, db->tb->size);
             }
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1a806a9d09..7287e1debf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
@@ -4817,7 +4816,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 }
 
 #ifdef CONFIG_USER_ONLY
-static void hppa_tr_disas_log(const DisasContextBase *dcbase,
+static bool hppa_tr_disas_log(const DisasContextBase *dcbase,
                               CPUState *cs, FILE *logfile)
 {
     target_ulong pc = dcbase->pc_first;
@@ -4825,20 +4824,18 @@ static void hppa_tr_disas_log(const DisasContextBase *dcbase,
     switch (pc) {
     case 0x00:
         fprintf(logfile, "IN:\n0x00000000:  (null)\n");
-        return;
+        return true;
     case 0xb0:
         fprintf(logfile, "IN:\n0x000000b0:  light-weight-syscall\n");
-        return;
+        return true;
     case 0xe0:
         fprintf(logfile, "IN:\n0x000000e0:  set-thread-pointer-syscall\n");
-        return;
+        return true;
     case 0x100:
         fprintf(logfile, "IN:\n0x00000100:  syscall\n");
-        return;
+        return true;
     }
-
-    fprintf(logfile, "IN: %s\n", lookup_symbol(pc));
-    target_disas(logfile, cs, pc, dcbase->tb->size);
+    return false;
 }
 #endif
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 6d7f6e7064..d74939389a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -31,7 +31,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
@@ -6520,7 +6519,7 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void s390x_tr_disas_log(const DisasContextBase *dcbase,
+static bool s390x_tr_disas_log(const DisasContextBase *dcbase,
                                CPUState *cs, FILE *logfile)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -6528,10 +6527,9 @@ static void s390x_tr_disas_log(const DisasContextBase *dcbase,
     if (unlikely(dc->ex_value)) {
         /* ??? Unfortunately target_disas can't use host memory.  */
         fprintf(logfile, "IN: EXECUTE %016" PRIx64, dc->ex_value);
-    } else {
-        fprintf(logfile, "IN: %s\n", lookup_symbol(dc->base.pc_first));
-        target_disas(logfile, cs, dc->base.pc_first, dc->base.tb->size);
+        return true;
     }
+    return false;
 }
 
 static const TranslatorOps s390x_tr_ops = {
-- 
2.34.1


