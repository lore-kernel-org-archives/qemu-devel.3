Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE45BCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglJ-00065K-UI; Fri, 05 Apr 2024 06:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglC-00060C-Cn
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:26 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglA-0004m2-N6
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:26 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e69a9c0eaeso1285945a34.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312723; x=1712917523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rExV436qASDL7Fg2YdiVxvwbh1gcXXC/kcp8pAfAu2E=;
 b=kOFE5F0PSHQdUmtDU4G6G7OmSGJgcR1a5YoFavYVBu0u2/JOyYahOyAZQJATAqyEHM
 NYfMcKyC4OCW7ZYoy3DSHWIUMqK0nJNKSQQSmt6baqXk39wcG8sYbeiy+A3cCcHc3Mbu
 zcjX573L56CWVRvh2FfgOc8g2RJ4SrcquSxllIUWn8pljeADvDmM3YNHaRxT9FxJoXjb
 ForoKA1+v/phTHhMQ6/9bJd7XrAc+hMXQUAx3iw9gHj1lf8LWjzPJC+w/lpZS7MDyHB9
 QYU+qEEDDOn4+TxHEysAVq8V8qev2aKGYn9vI18tater+oBjDzyx6r5d1wBTeSLlJK87
 bb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312723; x=1712917523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rExV436qASDL7Fg2YdiVxvwbh1gcXXC/kcp8pAfAu2E=;
 b=P5AqyztKByzMVSgYQOC0zv/9kij/L0CsV4DLbgN/IliOK9BNxUdSTZRR3yZ0W1Xh7C
 4rgXFb3Hj4U1giGSHDz8fjVTb+pzBXDx2nDPf8Gt5em8YxyBeNFsFsgEpujc95/up1nq
 E1/uLfPzI3EvxIsdSGeO/65r/jq67tLtenJp+Ew3MGbjRIgypzNo/URpoeAUWooRuVJl
 IYtS4QonfT0WLx6RUy2w2/UpqCr4p+Ttux+w2Zv+RRhAzMg7eroFtWthsnN70betpf5a
 tO6LPXV+CdABRfphsL/dTBGQ8pP7iKmAzTZwshGj9xCCBH116DRHtxfToYmKUKLjaMoF
 vvNA==
X-Gm-Message-State: AOJu0YzZF3uB64cG3D5+qXln9+M+kAghzvyyORFcTLxxFSCpdMG2p1XS
 nxZsDfn0S02rOAzrbEpZyR+qiC4AtgKZ3yw9XR9BOihdM43jfk2QTjeCcCWFiX2ogBWqNQuor9a
 r
X-Google-Smtp-Source: AGHT+IF09xnWjOAsTFNVaZj5O4ae03Tv2d62LaZNqGNeu85iycEbek1FHkhc+a9ppOGI859GWhGeoA==
X-Received: by 2002:a05:6870:f286:b0:22a:a40c:4bf2 with SMTP id
 u6-20020a056870f28600b0022aa40c4bf2mr1137462oap.14.1712312723440; 
 Fri, 05 Apr 2024 03:25:23 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/32] accel/tcg: Return bool from TranslatorOps.disas_log
Date: Fri,  5 Apr 2024 00:24:44 -1000
Message-Id: <20240405102459.462551-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h    |  2 +-
 accel/tcg/translator.c       |  5 ++---
 target/hppa/translate.c      | 15 ++++++---------
 target/s390x/tcg/translate.c |  8 +++-----
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 97cdb7439e..6ebe69d25c 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -134,7 +134,7 @@ typedef struct TranslatorOps {
     void (*insn_start)(DisasContextBase *db, CPUState *cpu);
     void (*translate_insn)(DisasContextBase *db, CPUState *cpu);
     void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
-    void (*disas_log)(const DisasContextBase *db, CPUState *cpu, FILE *f);
+    bool (*disas_log)(const DisasContextBase *db, CPUState *cpu, FILE *f);
 } TranslatorOps;
 
 /**
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 2a69916b9a..712e0d5c7e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -224,9 +224,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
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
index 7470795578..b1d3d6d415 100644
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
index 8282936559..d8c1ad042d 100644
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
@@ -6522,7 +6521,7 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void s390x_tr_disas_log(const DisasContextBase *dcbase,
+static bool s390x_tr_disas_log(const DisasContextBase *dcbase,
                                CPUState *cs, FILE *logfile)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -6530,10 +6529,9 @@ static void s390x_tr_disas_log(const DisasContextBase *dcbase,
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


