Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080EACA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulJx-00009t-Nr; Sat, 06 Sep 2025 01:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJv-00009A-H6
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJo-0006oU-SY
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b9a856dc2so17822675e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135905; x=1757740705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7FMx8ch25mi1HM2iSzOFbjlu0abcZfgeYT8ylr/T9c=;
 b=fhxX6H6F8vPPjijnk4SNV64D+EN4btdIPYviZ7pIdzTc1neOm7RDVZb7hooJ4JQ3EX
 eXUf8rNnTlutABlXb4l0LFrmGMkooeRihZkInq/kQ/YJDVwjkobAplThQqBZlOPJUJDc
 rsWmgpn6rKq/4s/siNrmxYcYOcZX8BCBB+OwnBZiILYOlmUUADktvl1NqWfPKYfcGA21
 +MblaAPJfVUVX4XNU2RUoSADJedrM9xj1Hr0Vi0SjtFOvxxVJbYKhpQ6v52iI0cbMJP+
 CdEJI8JHZPRJuqUuu2I6srVQX5gCN/Tje4UiSXI9x23+cLoTTBVDAIfYimhNEylRwj79
 5mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135905; x=1757740705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7FMx8ch25mi1HM2iSzOFbjlu0abcZfgeYT8ylr/T9c=;
 b=RFMx9ubMMck1mzltMHeoU6vmP3qiBIlxRAYv6tdGPiN6j5stMQwZcA909f7Kf15F18
 2fSDVvIzAaQMXIv/jgpJMi74RsHcWdjswy3JdBipY58pbvSC70Q2DuUslbBXtqVYDeXV
 3fW7FRB8xlV4TKCwNMg5r5QxiyU9FPpzHJMmZdaSAqNt5PeB4Ft9ducGOvSFFoETI+uk
 4wuh2unjlZZBtq7vD14/wdSbRw4LzXV+ZKq6aYjV78rhUNUpnBDy2swprr11g/J5xdQl
 8mQ/CqK2skFGgvgYMOr0Gsv3oHobWOfWyXTERlDVf8VA70MjaQB1YII2Hj8PYw52bynk
 QhbA==
X-Gm-Message-State: AOJu0YwumBAWcHxkfHcsRDLn96Hrs0Gtpuqa0MgCUVCwaftm/Y/CSnTb
 izDEwrgrXJEJZYu+A7odyt0gIqLD9yu/3mIu29T2KrEE1O0gRd2s7JZylataJRlvJMGuYZ5wvdi
 pTaP5v54=
X-Gm-Gg: ASbGncu7qc7sOENr33ApWtB/QWnrgXQJcHHULpLxddta8Xv29KRJBbZKOS5QuJR7C4O
 6lf/TNDl8SvCNipFj0VLGGHdXELASzrh6ThJ9I0Mp48hYv6frsMKYHpJv9D9Ex+iNBgRL1Xy6wh
 SwmDwtkvfd1sVmCqHuQIV8qaWKvARAKkFE8jeH9H3n2WPR305AWbP0vGLo8WmL40UUBdjgboL8+
 MHpC597iXd03zRF6VSpkpgsWa1cF4lZxPZIKikhxHMd7zkMXmnKZzBzxgjdwSICzzxj2+R5cFPY
 Je2LdXrTp1ptDpaWa0Qvzd1dqEr/SAckaSLbuNiSh/Le/WcfFII7NBB2yNOZ1Bvjh8kTU/5L9hJ
 7Ahf5QdTuNIVu05Dj5wWc+eAwrToecKV1NFPR/AbH31MppgYMiLeVpDaczc8DxqurvpIN8+joGl
 zMR9aWHhg=
X-Google-Smtp-Source: AGHT+IF/ebYvzRSZdPi3EyzGmVx2QRqe0dxeAEHK2wiOa9MFKYtomYd5SobN7Vo9GE7My8943D/Zuw==
X-Received: by 2002:a05:600c:1c8f:b0:45d:cfc6:5166 with SMTP id
 5b1f17b1804b1-45dddeee8bamr7375255e9.23.1757135904991; 
 Fri, 05 Sep 2025 22:18:24 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 03/11] target/alpha: Simplify call_pal implementation
Date: Sat,  6 Sep 2025 07:18:12 +0200
Message-ID: <20250906051820.160432-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Since 288a5fe980f, we don't link translation blocks
directly to palcode entry points.  If we load palbr
from env instead of encoding the constant, we avoid
all need for tb_flush().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.h     |  1 -
 target/alpha/sys_helper.c |  6 ------
 target/alpha/translate.c  | 21 ++++++---------------
 3 files changed, 6 insertions(+), 22 deletions(-)

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


