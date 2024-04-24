Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EACC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5j-0005wX-Fj; Wed, 24 Apr 2024 19:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5f-0005qv-0U
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:51 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5d-0003Tq-9g
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:50 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so323808a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001508; x=1714606308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udtyyROxDVvgFlN2ODG5uKnex/HkXV/I+K4Ewok5QlI=;
 b=GoE+Q51WpgP+TesOQfrnXUYuEV2e7QIn0K2udoQNFJhEoyMEpbSjHEBL3NE7ZABwg5
 jPEkAHc9aOlND5PE+CTyWzK/K0CXFOmymDHEsAND8UjrnWiXepMfnLbva8osZZQEXrRv
 Q1huEvn8gXP6g8YqE9ij+TdPVndVzqKDO/Vi9uDKPvMYV0AV/Qxz840GFkizm9jg8N4T
 6uLAUw1Ezdt7cvEjlKDQECdIhDIOxIrD/HstzkQxNra4Pup4Sn7x0i7S2k9bMPF4fe2K
 M7vvZIzfvySFgePA2aEUd4csVWaUKs2VH/yOveTmodjrkl4EVEN5eA6TnhThzecqc4LA
 NPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001508; x=1714606308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udtyyROxDVvgFlN2ODG5uKnex/HkXV/I+K4Ewok5QlI=;
 b=eFJ036VD7Ll2/ghtpDOD7talZvCPNdalcRfgUaRmA81I/iEuiulELFOhFy71r68Hjg
 u8FkPFH5McGu8ITEXgfwKscte3u0CN5BJkxRiZzX+UeheDNkPxQeJXI4PXAIsgtGKZoQ
 HwF0zDW0oJy5V/vw8b3Ia9f1FShwnCxEL3iJyKoyvk5Skn1UXa0Bre2ofFvJYBuRekcS
 CjkJc5hpumVaJvAEtU0NsOpcPKqyyrucv8WBYHuH/iK9zklHIgl1XyweUzKqptSu+fzb
 Tin877plGLJcjfFxo9jDhcWU1+QNSJAnfdPXYhGtE3KpDRyE9YDtqg+nFPuWA7vkyoP2
 Gq1Q==
X-Gm-Message-State: AOJu0YwJLDCZtXvE/pSWgoAAjojtqScm88/UINuOW17vH6jScgp5cQBC
 Ad9F7GFu/OxBFgdT6UP2GgmlUItNb3rcM9zIkHnaQZQk7JpHlahae8waiPESjyIlFK23mae1V84
 z
X-Google-Smtp-Source: AGHT+IGJqdgnKhPxr7wfoGTvAnpFdtbxSCNCtlTybc3rMXa3lyhJbNNMH8Mhtk9YHiwSCXEn8AnLbw==
X-Received: by 2002:a05:6a20:6a1d:b0:1a9:85a0:afeb with SMTP id
 p29-20020a056a206a1d00b001a985a0afebmr4562937pzk.20.1714001507978; 
 Wed, 24 Apr 2024 16:31:47 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/33] accel/tcg: Return bool from TranslatorOps.disas_log
Date: Wed, 24 Apr 2024 16:31:15 -0700
Message-Id: <20240424233131.988727-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
index 3c354a4310..bd76d6446b 100644
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
index db586b894a..8e8c4e1bf8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -227,9 +227,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
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
index cafba84631..e8a542c039 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
@@ -4816,7 +4815,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 }
 
 #ifdef CONFIG_USER_ONLY
-static void hppa_tr_disas_log(const DisasContextBase *dcbase,
+static bool hppa_tr_disas_log(const DisasContextBase *dcbase,
                               CPUState *cs, FILE *logfile)
 {
     target_ulong pc = dcbase->pc_first;
@@ -4824,20 +4823,18 @@ static void hppa_tr_disas_log(const DisasContextBase *dcbase,
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


