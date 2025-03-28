Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126C8C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFx0-0002sT-JI; Fri, 28 Mar 2025 16:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwz-0002qe-4p
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:09 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFww-0007nf-VB
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:08 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3feaedb6670so1502678b6e.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192306; x=1743797106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oD3b+nDGpxnwQn/lSzkFZnkDRTkEZOWvlufBLJ/eR8Q=;
 b=I1cuWsT3Ayj5UstYCiufn0w9yEJAo5z9VvQRPhRbTJ0icNXMdhKzVZ15aTX7BXYkMW
 B1v4sBlJ5kCjUjCRvP4D7KUK6jsAC7/rVpMPu/iAugozKIf874NsMMDarkrvWW4Tf56L
 f9jGgfRqnvzqIsajF0MGDUojP1x3kjFmWBfplshWJ6Ou//FxqZkptZ+hUJlF+bXBxg+7
 dvpM+BtMyrP26YZKuAyoTkX4RsWagLvBfV/5FNPQ7cVDUbCwWBhy3g5R0r4v7oARu2Sp
 jO54y0K1m4H1nIDf8EWq3/W8iDSLIqMvPMU7ll5kuBfUIVwMvjUNj1KcRC+iQyOxpILk
 eolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192306; x=1743797106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oD3b+nDGpxnwQn/lSzkFZnkDRTkEZOWvlufBLJ/eR8Q=;
 b=o73yyyaUenXaBFfN5c67tAmel23H7rDB8to+1FTdPFa91OXRsBoqtsgtMOTBlkjfon
 ZfwPSp/xqB7H+hrqtI5cA0dzNWT5whQQ72AFdfvXGHaOFpX9q6LRkl5VqnqkjkzlvtA6
 bfjmKjZZIT6zVEi3BY8z4s9lu5xAeskOaFA/JjIFuR26LgmYUraebIBq0EhUJM4bAXpS
 idDT9txJRyp3sMVdvPygKb8sd/aA8fi3Tmx0ILhD5GBBO7FDj5OPMFngr2DMvbOdoyap
 w/5z8TNQhiKezaciUBSBetYwZ2NoLq4+MqLLbp8LaTosKj80pe9W0fF5vsbD/ZhrNLGF
 L6TA==
X-Gm-Message-State: AOJu0YwRQJxZ1HRxVFn++s59h+5lUnMAIaUWWoRhE8FdppG0GgiMfa2l
 PeF5D/P1DfeWbWkm2GeWqj4AxUXPynYXslEsbnHxRUpSxq1HczP3NDmxww+K45u3067od4G8aVR
 q
X-Gm-Gg: ASbGncsrs4+jhP0xHcReVgOJn3dqq2/fGyEySybzoWzD0nyWkMVzjPs1iMYN+bN+G72
 2BFPWgjfIBpMmBHtMKBTuWCBnObR9MstGReFu5wGfezqX2MjbBrEKB1A4YrqxJMWgFdrgkM14kh
 f/cD3Br0iO7DnG6tqeGBTV03urKaVWXg4PWXXxd6GuEZfBup+dO8bTKLSnxD6AxpNhlUKsitoPO
 LBfJJt2RQb7eR2eUnUhVDA5DON1LI6z51VHUnCBvklamgua8InaWbyjLyndIAufkCnte0jMDStY
 DCAR6ZgPdP7xt7i9UT1X5lhG1mLXME8WChymWZQgqlLXGrVgBbPv5ZImmk/8I3O816almyFRCSX
 uvVKWDW76AYs=
X-Google-Smtp-Source: AGHT+IHKACtBCONYBQmC+zpdAOXw61Vjh217/e8HpdQ9+Nv8GWQCieIk/uNF0BM6X3+e5L+BQHRnkg==
X-Received: by 2002:a05:6808:221b:b0:3f8:acb4:8d8e with SMTP id
 5614622812f47-3ff0f5ddd9bmr463456b6e.39.1743192305672; 
 Fri, 28 Mar 2025 13:05:05 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 5/9] accel/tcg: Build translator.c twice
Date: Fri, 28 Mar 2025 15:04:55 -0500
Message-ID: <20250328200459.483089-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 14 ++++++--------
 accel/tcg/meson.build  |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 307a513487..36a6a9e040 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,14 +11,13 @@
 #include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "exec/exec-all.h"
 #include "exec/cpu-ldst-common.h"
 #include "exec/cpu-mmu-index.h"
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


