Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDDACAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UqH-00029I-Nx; Wed, 24 Sep 2025 15:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmC-00070W-Kl
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk8-0007uO-9C
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:35 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32ec291a325so157954a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740485; x=1759345285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZamIB9qOqLDXfHWztLFTsDY1Wf4aDJfUVKiJDrru8TA=;
 b=aH/PiVsipMaHhj+o+ok+FePadXftrIY0Ih9XsrlPfQFsvQRJpStqv0WrdTZVeAhq+/
 Vg9YV4DBqW2CIqRgGRZ/T6UC2MhcXPWcGxCex/qQuYr5meYzuAfEGRA2d7xYACu/xRLw
 ClA0ZjD/DC2ymRoAtoSol2nxwHuSiPk9Q3wlzwfCSnLZAd6ZeNskxM+22dwsUUlm/lGY
 z1ltw9usa5xo17/udqlRydtizqvK12wQ/wdiQyydMjshR4SFfkKYDDoFv62qmKnFmFqp
 dBjetFAbHSPURt4AjGdXIF/5KgJjHKhnqWgA/AQ3P2CRinJ0S4u18rz1/sFC7DEDLUnL
 QFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740485; x=1759345285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZamIB9qOqLDXfHWztLFTsDY1Wf4aDJfUVKiJDrru8TA=;
 b=HBBwd6ibCKk1qAmSqixznTo14h/9NedaUwTPOgaggZHMKMYNt8vpH0dw1HW+sFd7aQ
 jvnThvat7tdfqF2hjH/t2RaawXbRg81hLZ8QIuVrxd2mrP7tbk6E2aA2gdmtv8QL/Gbk
 zkvA3nFZcr8qouzJ76dkNVjNvk8emJNl/uPIPeHt0tCeQTWRAExrLIoMAL0UmHJd6j3w
 YQJD+URuph44hMRewFmS0f6C/lmFCCLjk8m3XsJy/n8H24uP6l3fJ0+9Tf982DUjaj9Q
 erLkilCvWtBN/elfxe4vAG7xsRI5BjJrfp3CLCYBvSGX2KpA6k+hdrD92erxK6+p8IFJ
 Cpww==
X-Gm-Message-State: AOJu0YwJ/R0LnYcQxxHIB12FAHwFsn+wLhiLmBJlzyUzop5Svu7bIjw1
 EmREd0RvNzF/EDLaZzzHualcKE100fEDaYIOcLEUgTzgMayvFiQtBkj6nhXMBUof8GC++FM2MXf
 vE5Z4
X-Gm-Gg: ASbGncscQZD2anjSkGoi8Ptlp1NiJrlHNZivmrI5xLgIGyziiFmFEN96AvYLlLiJmVi
 pih1xA5mZujgdzdJLabmw2h2FtOHvvMtRqag1Hz9RUS/QBq8M6aikHhvZFOjhmKFdaUTvxQYqqj
 dQGOJsLwewbHmEKr0KUlzCViYHS/X1BM5F7AggkGTTFSsNMFHDhCWoc+cSflJ6E1o+eERVvACNP
 cRaPUF0P98QRvk63hkzAbOHesILtMkH7cW6uyRXPvXk/uUd7vH/Chqhl9YKpEVgOqm9IupjAdVW
 KLnFiypiqjlNfJnB5ZAL0E/0/8Oq6av5lhPW1ElHFq32GBzds8fEtpLZuuio7Z0FqcesMv5XhQr
 r4kZgRXhfEC2pmaLIIyNuZtGPLSc0
X-Google-Smtp-Source: AGHT+IFv45f/OnNP+Iysqh/993rV03KXDoq/W52sw5GObjCaPNWjtMIXmX5qcAT4xz0gXbn7D2a18g==
X-Received: by 2002:a17:90b:4d88:b0:32e:38bc:f5a9 with SMTP id
 98e67ed59e1d1-3342a260f75mr720522a91.9.1758740483853; 
 Wed, 24 Sep 2025 12:01:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/32] target/alpha: Simplify call_pal implementation
Date: Wed, 24 Sep 2025 12:00:55 -0700
Message-ID: <20250924190106.7089-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Since 288a5fe980f, we don't link translation blocks
directly to palcode entry points.  If we load palbr
from env instead of encoding the constant, we avoid
all need for tb_flush().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.h       |  1 -
 linux-user/alpha/cpu_loop.c |  5 -----
 target/alpha/sys_helper.c   |  6 ------
 target/alpha/translate.c    | 21 ++++++---------------
 4 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index d60f208703..788d2fbf28 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -90,7 +90,6 @@ DEF_HELPER_FLAGS_2(ieee_input_s, TCG_CALL_NO_WG, void, env, i64)
 #if !defined (CONFIG_USER_ONLY)
 DEF_HELPER_FLAGS_1(tbia, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, i64)
-DEF_HELPER_FLAGS_1(tb_flush, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_1(halt, void, i64)
 
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index bb8346b509..f93597c400 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -94,11 +94,6 @@ void cpu_loop(CPUAlphaState *env)
                 break;
             case 0x86:
                 /* IMB */
-                /* ??? We can probably elide the code using page_unprotect
-                   that is checking for self-modifying code.  Instead we
-                   could simply call tb_flush here.  Until we work out the
-                   changes required to turn off the extra write protection,
-                   this can be a no-op.  */
                 break;
             case 0x9E:
                 /* RDUNIQUE */
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 51e3254428..87e37605c1 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
-#include "exec/tb-flush.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -38,11 +37,6 @@ void helper_tbis(CPUAlphaState *env, uint64_t p)
     tlb_flush_page(env_cpu(env), p);
 }
 
-void helper_tb_flush(CPUAlphaState *env)
-{
-    tb_flush(env_cpu(env));
-}
-
 void helper_halt(uint64_t restart)
 {
     if (restart) {
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index cebab0318c..f11b382438 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -48,8 +48,6 @@ struct DisasContext {
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
-#else
-    uint64_t palbr;
 #endif
     uint32_t tbflags;
     int mem_idx;
@@ -1155,7 +1153,6 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 #else
     {
         TCGv tmp = tcg_temp_new();
-        uint64_t entry;
 
         gen_pc_disp(ctx, tmp, 0);
         if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
@@ -1165,12 +1162,11 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
         }
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUAlphaState, exc_addr));
 
-        entry = ctx->palbr;
-        entry += (palcode & 0x80
-                  ? 0x2000 + (palcode - 0x80) * 64
-                  : 0x1000 + palcode * 64);
-
-        tcg_gen_movi_i64(cpu_pc, entry);
+        tcg_gen_ld_i64(cpu_pc, tcg_env, offsetof(CPUAlphaState, palbr));
+        tcg_gen_addi_i64(cpu_pc, cpu_pc,
+                         palcode & 0x80
+                         ? 0x2000 + (palcode - 0x80) * 64
+                         : 0x1000 + palcode * 64);
         return DISAS_PC_UPDATED;
     }
 #endif
@@ -1292,11 +1288,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
     case 7:
         /* PALBR */
         tcg_gen_st_i64(vb, tcg_env, offsetof(CPUAlphaState, palbr));
-        /* Changing the PAL base register implies un-chaining all of the TBs
-           that ended with a CALL_PAL.  Since the base register usually only
-           changes during boot, flushing everything works well.  */
-        gen_helper_tb_flush(tcg_env);
-        return DISAS_PC_STALE;
+        break;
 
     case 32 ... 39:
         /* Accessing the "non-shadow" general registers.  */
@@ -2874,7 +2866,6 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     ctx->ir = cpu_std_ir;
     ctx->unalign = (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
-    ctx->palbr = env->palbr;
     ctx->ir = (ctx->tbflags & ENV_FLAG_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
 #endif
 
-- 
2.43.0


