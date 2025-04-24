Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2A4C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kuf-00005S-Oi; Wed, 23 Apr 2025 20:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktW-0005uF-Jp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktT-000569-Cu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:50 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-aee773df955so1393948a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456205; x=1746061005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2dng6uyh/TVtKzBLSnew6/1cI3Pxi8Kdl7ghuagDjo=;
 b=eMxCHhPpTlM7vH1+DS0xauR28qAHhBexSeVBxNVsxoqgOFwkwfVb+4+iGUkuUz+Fqo
 MXX7Gvy4LIV4vBoRmAMwXeK+ezOIRmzgl9AUmecSpzn8mZyRHIeXMBQcE3PMvaDlqGo6
 sIByk5ey0n9Gd16z+AUXHqd94/zw9UMd8nVo+wmh28sklhq+5bu+WWW2i0onhuij+eiQ
 MjooeLK1Nw1TahE5VnY7392V0GWhLd1BwdlAP7N8lL+J8So57Vz86G7I7g9YTEz425d2
 A3g85BMvsXc8D8D2KS4K57EEI2nGjWQQ4bmMFX/vuP28EA8Tt6BND4Kx6xcIs211jv0P
 jQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456205; x=1746061005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2dng6uyh/TVtKzBLSnew6/1cI3Pxi8Kdl7ghuagDjo=;
 b=gyFOOc2TlaTuXSwLzN52quCbOFWBbWQrvYET72PGmSa7azvLuHGNc9CAw70K1zT5A7
 PG6AW5Dq6/ZC/4qwpD/ZPrU4dxkq2fyFrt4zViDefjWtyyJQ8hgl5WuXyX05jn9r8P0n
 GkjBYd1O9VhjqrWiurGpUnTZfKw2N51YX646Ejs0DcXda2k/nQT3q35Zk1jgNP7uUm50
 1WARMfM+dm4iPOUsW0B0QOBvUiSE3NTYz9lpGwvHiwJOdUQleMbsd1BhP6PR0DUJwTPv
 /j7YIIwCHNoifGXg6rqUApoeK7lavgU8SwkkmbS+KLb5URAGvYBsvKdjMhZpCpxrj7yp
 xLjw==
X-Gm-Message-State: AOJu0YwJoSepiVKheQDN+YeYYVb+mp+yXsBGBInXx7kJyuT8BpMw2NfL
 RIb5d2MvdrEp/KFeVmS/1bElDESXHmUGqzB9DMYX84yZR8N0bS1cXo16v1jnzkVlP/o9WCMKa0U
 G
X-Gm-Gg: ASbGncvGshVCPeumoExocV1Q3+JvnmX6fpqDOidzMQBBVnVEMe1gblpAIbLhFk8IC0T
 Zg5+9mKtke5mHBe2udJvGFoI4QOTHfy19uAQQZyb6SzBdsdYE8sA+qWbc7sBwXw722gDGwLb9Vv
 ZI+fP4N4MW2cx4axZs3eEAC2UUvGhc82kxo13drdbozOLW9b04PHk8uoL7bJvKiXe5J1OI2lUif
 GgXzILRPy/7ujBBAXoHVDnBqmfxbONm9jLIY6BQx17fbeoY5bNPhPwzmY2F0xrts0XYmVcffKnI
 +Bw26oXYSFHLpnziZbWmMk1Cd4r5DY5VNNqp3oGH0N566JM1zH11S1Mqh79iY8s2o98wQ5JDKRY
 =
X-Google-Smtp-Source: AGHT+IGqZN2njQ1EqSavj0riLVx/vqTuxQHdk9kvx58a7O27dVZ4dXwWovvMnV68FHNXw8McQ95TTQ==
X-Received: by 2002:a17:903:2acc:b0:223:3eed:f680 with SMTP id
 d9443c01a7336-22db4982ecemr5846855ad.18.1745456205398; 
 Wed, 23 Apr 2025 17:56:45 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 096/148] accel/tcg: Build translator.c twice
Date: Wed, 23 Apr 2025 17:48:41 -0700
Message-ID: <20250424004934.598783-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Drop some unnecessary includes.  Change the offsetof expressions
to be based on CPUState instead of ArchCPU.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 14 ++++++--------
 accel/tcg/meson.build  |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 5f0aa9d56a..c53bbdef99 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,14 +11,13 @@
 #include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "exec/exec-all.h"
 #include "exec/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "exec/target_page.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-common.h"
-#include "internal-target.h"
 #include "disas/disas.h"
 #include "tb-internal.h"
 
@@ -26,8 +25,7 @@ static void set_can_do_io(DisasContextBase *db, bool val)
 {
     QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
     tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
-                    offsetof(ArchCPU, parent_obj.neg.can_do_io) -
-                    offsetof(ArchCPU, env));
+                    offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
 }
 
 bool translator_io_start(DisasContextBase *db)
@@ -50,8 +48,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
     if ((cflags & CF_USE_ICOUNT) || !(cflags & CF_NOIRQ)) {
         count = tcg_temp_new_i32();
         tcg_gen_ld_i32(count, tcg_env,
-                       offsetof(ArchCPU, parent_obj.neg.icount_decr.u32)
-                       - offsetof(ArchCPU, env));
+                       offsetof(CPUState, neg.icount_decr.u32) -
+                       sizeof(CPUState));
     }
 
     if (cflags & CF_USE_ICOUNT) {
@@ -80,8 +78,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 
     if (cflags & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, tcg_env,
-                         offsetof(ArchCPU, parent_obj.neg.icount_decr.u16.low)
-                         - offsetof(ArchCPU, env));
+                         offsetof(CPUState, neg.icount_decr.u16.low) -
+                         sizeof(CPUState));
     }
 
     return icount_start_insn;
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 72d4acfe5e..047afa49a2 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -8,6 +8,7 @@ tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
+  'translator.c',
 ))
 if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
@@ -22,7 +23,6 @@ tcg_specific_ss.add(files(
   'cpu-exec.c',
   'tb-maint.c',
   'translate-all.c',
-  'translator.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
-- 
2.43.0


