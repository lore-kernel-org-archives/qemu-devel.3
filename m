Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF21C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQZ-0000NS-PW; Tue, 22 Apr 2025 15:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOy-0005AP-MD
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOu-00073a-VU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225477548e1so57017145ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350523; x=1745955323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2dng6uyh/TVtKzBLSnew6/1cI3Pxi8Kdl7ghuagDjo=;
 b=AUbGAmacNLauXAn7sy+sGXnofPcI2DGfXvYWeGU+tldxYog9WaUTFKBQcaVHHWT/az
 9vm6ZSx6ym+J/aDyYWYwf2f6EGkHDoVBG1+C8ovy6jXjK+j/ccvTtq3qPS2PibSYls5W
 HW83tr6R08i/PYMN8xBeTP6jj79ZHXvlaglqGIx4tkNRQNh350NL5h497meD60AdG/Lw
 G5LJKYNlJQh/qyq3zfEg2/1/8e+rdhsiXVqwcdq9YFa5GUpOVmIkLRHZ5edhTZtmUmpR
 F4aagJYGhGGR4xkquFijZpVoRQpu86NyB2oUAl5UpzehIG4/JvAMJzyX2Uu6lBAkNk7Q
 Uh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350523; x=1745955323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2dng6uyh/TVtKzBLSnew6/1cI3Pxi8Kdl7ghuagDjo=;
 b=K9wxich1bJU+tCX8EcMv+j2c2WIDQLYmggWd4tkpaoy61AbMLXhSFU8ByoBh9CGpc5
 BeIyaMn/EFWCY90PV820WDnrohJS9pRYmlRNGyCQXVH2ES7TObfKWLTcayofucNWROAu
 GvIwlpgnZjCTFSQFKOntheOywdkj+eceEmjCFVavI9tOUQG801NsF8PPDFIXf7Ez5lko
 M9SjpN/J2F6WaH02hjFIY4q0AsS3hW3dDUAsv1QXhKuEu1JOat7z8W1MXYMHrgPeqDrr
 pEuY7fUtDRAkHZ8Lg6Mk/tQN6qY9Iz8fUMQ6kaTtpScqwErgpZGTufKVc+pV/BYymatq
 rWXw==
X-Gm-Message-State: AOJu0YzXMdBj60Rf/P2Dj4Nxl3oEXpyh5gTPV3mLYyFI71gHfGjLT3hu
 y7FDq5citZ7WH/4r5qG8sNBc+3VedH0xhv0dQ82+7hea18i0nXjmYKn0mNSQGIxkjnVokW1GEFt
 i
X-Gm-Gg: ASbGncu+xCi1I14+OqDBt9wkYXVXO7GG7qbMTajxqeQu3Rwko045yDzzKnWDVqsM+xJ
 D7swEt4GR/KWAfv4B0Pgt/y1R6W98iIx9sYr7v50XhWJKvzGP2aQLVCwsXoCNePuyWNyMhzWtV1
 rIST/ycoryYh1Qy1qV58m3Zh8UiiR5CihN1r+HhlR6lwgMQeHcPUXsqHb1DWXh0QYnmlDjl5xQK
 f/6Xr++jsrgv6dE1e/7H9rBiUCZxIJgK56Eo5S02HmZenltuPjYuj5nbPJD4pJXodNzflvEPzIh
 HRBtr6EavgDjwNwTyeuWEjUDmTyZrFTUVnMjbvxsU8SkV4OaeaxEyNtkAppb/KagMa+AXT+KZ3u
 DmAsL4K/Eqw==
X-Google-Smtp-Source: AGHT+IF3sdvzjsJfy29xB/uspueerctkoEaCAGZM3yxLzzLRofKiWDKEadLKu8Ad0U+4LN9QwDcYtg==
X-Received: by 2002:a17:902:ef0a:b0:22c:35c5:e30a with SMTP id
 d9443c01a7336-22c53580d0dmr229853135ad.16.1745350523568; 
 Tue, 22 Apr 2025 12:35:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 096/147] accel/tcg: Build translator.c twice
Date: Tue, 22 Apr 2025 12:27:25 -0700
Message-ID: <20250422192819.302784-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


