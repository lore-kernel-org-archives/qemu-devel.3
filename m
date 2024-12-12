Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A4FE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkQs-0007q4-3R; Thu, 12 Dec 2024 09:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkQq-0007pP-H5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:44:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkQm-0004EF-C6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:44:47 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so480912f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734014682; x=1734619482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubAPSraytKECXi5pOUff7PvfuDwY94ODpHJ+R/dGBjc=;
 b=cGN65S9CpxNA6phrl/78yxXXpWv+Ay7prx3Dfoa2AjrX9m2dOV2wkk2xdte6wF+3Dl
 tiFJmRhdHHS7kn1zHvE/dlty7Gs/rwEjXl8fG16cc5Etbuudzd8WcXnr9KAr61nVr3VM
 q2QBsyo9IPpfCnmh3JptZSepyvc0gs2IC/f3L5Z7FW7+xpRzQWny9i5uJ2vK2DLUae6m
 sKrSWH92AZKDFOFpBUJzs3hQ3RA/FGQNDiy7/ZYiNtK0D4NZcKHiaecjXuuId0fX0VuC
 P45vzVCTqGGt0go1tLCdw1Qyv2DZiztzURLTZ2F3aag/mJXx/sAZUpWD57yU1n/cK5Gr
 Kr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014682; x=1734619482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubAPSraytKECXi5pOUff7PvfuDwY94ODpHJ+R/dGBjc=;
 b=gFsVWGDAohtWtoUG/3TeSq8jHIGWRzlTtkF0+Oz5ed85W6vxIVMYKE7OsjlO4FAWKz
 8GvgQ+UWqm/mP44J6Lvt7XKJTNe2L6GZeHxdOjILFCMWo4CJwG4pp7aRn7j3e7MidLe3
 C0ndg1tJV2276xR9b3YFNX6aGzBVuTR0g2gXJGtxbxI/KTnYXZPF3PrjqJyhLkDxXje4
 UFAn0B5aBTfGIz9QkDoKiJP39SOSV1rS8ey2j/yLU+IJ55fx3BMLqsZf/hRimNxYLhgn
 weBC9knLhMwDmew2jsDGzUA6C5aBRx+Q0ooaw3SN50tvDB0Sz8o4bJowJQXncqs/Sr4g
 gpXA==
X-Gm-Message-State: AOJu0YydNcNYAFMEDy7fy0NJTGJKInYg2M/A2h9GhSpJ+d3LERfRz8xG
 +g/WItOhPL6OJkPj2XqOQrvnDNaD+BU+fQq7Cb0nqnQGzM7azSEfi8uxW05Tc6dDJqZEBWTYxph
 m
X-Gm-Gg: ASbGncv6VZUtdegjF/jny+vaCuD7eB7ebPGoP7nJ5v8WttXbFTZZpsMju9JCUuc0fwk
 wYpAMLL8QTOfbD3x8gZrs8zSColwJviyvXWnVJgBuJ2P/upFxFYekM+lDEqwI45X1alfjp+JZQl
 Yi/C177j9bI3H/Z6Q5yL3QwmS3DtLTT2iRKBestEU9Yw1GC5XLboYQ9jZwLuhP8G10qZs2C8KHu
 GgAZ30wsK4S36Uvtq9R36SUF0If6RuIsrLXPKlVHDjpMF5BiOXEcSEb+2+kn/GgCMpKFp4eRaax
 eTCvT396u7NyQM7tu9K91es8zy66Kjw=
X-Google-Smtp-Source: AGHT+IGApRXn6HThZjNp+4qmGWF8IVKLRIkEtNIi9QCG/MG/0ewAJxzmzK8bpPMjifZ7llg115+fOA==
X-Received: by 2002:a5d:6d81:0:b0:386:3672:73e7 with SMTP id
 ffacd0b85a97d-387887df018mr2952815f8f.9.1734014682257; 
 Thu, 12 Dec 2024 06:44:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a5005sm4212024f8f.41.2024.12.12.06.44.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 06:44:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/2] accel/tcg: Include missing 'exec/translation-block.h'
 header
Date: Thu, 12 Dec 2024 15:44:30 +0100
Message-ID: <20241212144430.66224-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212144430.66224-1-philmd@linaro.org>
References: <20241212144430.66224-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

TB compile flags, tb_page_addr_t type, tb_cflags() and few
other methods are defined in "exec/translation-block.h".

All these files don't include "exec/translation-block.h" but
include "exec/exec-all.h" which include it. Explicitly include
"exec/translation-block.h" to be able to remove it from
"exec/exec-all.h" later when it won't be necessary. Otherwise
we'd get errors such:

  accel/tcg/internal-target.h:59:20: error: a parameter list without types is only allowed in a function definition
     59 | void tb_lock_page0(tb_page_addr_t);
        |                    ^
  accel/tcg/tb-hash.h:64:23: error: unknown type name 'tb_page_addr_t'
     64 | uint32_t tb_hash_func(tb_page_addr_t phys_pc, vaddr pc,
        |                       ^
  accel/tcg/tcg-accel-ops.c:62:36: error: use of undeclared identifier 'CF_CLUSTER_SHIFT'
     62 |     cflags = cpu->cluster_index << CF_CLUSTER_SHIFT;
        |                                    ^
  accel/tcg/watchpoint.c:102:47: error: use of undeclared identifier 'CF_NOIRQ'
    102 |                     cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
        |                                               ^
  target/i386/helper.c:536:28: error: use of undeclared identifier 'CF_PCREL'
    536 |     if (tcg_cflags_has(cs, CF_PCREL)) {
        |                            ^
  target/rx/cpu.c:51:21: error: incomplete definition of type 'struct TranslationBlock'
     51 |     cpu->env.pc = tb->pc;
        |                   ~~^
  system/physmem.c:2977:9: error: call to undeclared function 'tb_invalidate_phys_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   2977 |         tb_invalidate_phys_range(addr, addr + length - 1);
        |         ^
  plugins/api.c:96:12: error: call to undeclared function 'tb_cflags'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     96 |     return tb_cflags(tcg_ctx->gen_tb) & CF_MEMI_ONLY;
        |            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241114011310.3615-5-philmd@linaro.org>
---
 accel/tcg/internal-target.h   | 1 +
 accel/tcg/tb-hash.h           | 1 +
 target/arm/tcg/translate.h    | 1 +
 cpu-target.c                  | 1 +
 linux-user/elfload.c          | 1 +
 plugins/api.c                 | 1 +
 system/physmem.c              | 1 +
 target/alpha/cpu.c            | 1 +
 target/alpha/translate.c      | 1 +
 target/arm/helper.c           | 1 +
 target/avr/translate.c        | 1 +
 target/hppa/translate.c       | 1 +
 target/i386/tcg/tcg-cpu.c     | 1 +
 target/i386/tcg/translate.c   | 1 +
 target/m68k/translate.c       | 1 +
 target/microblaze/translate.c | 1 +
 target/openrisc/translate.c   | 1 +
 target/ppc/translate.c        | 1 +
 target/riscv/translate.c      | 1 +
 target/rx/translate.c         | 1 +
 target/s390x/tcg/translate.c  | 1 +
 target/sh4/translate.c        | 1 +
 target/sparc/translate.c      | 1 +
 target/tricore/translate.c    | 1 +
 target/xtensa/translate.c     | 1 +
 25 files changed, 25 insertions(+)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index fe109724c68..efac18e3c9a 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -11,6 +11,7 @@
 
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
+#include "exec/translation-block.h"
 
 /*
  * Access to the various translations structures need to be serialised
diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index a0c61f25cda..a5382f460dc 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -22,6 +22,7 @@
 
 #include "exec/cpu-defs.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/xxhash.h"
 #include "tb-jmp-cache.h"
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 20cd0e851c4..a533aad7c47 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -6,6 +6,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/helper-gen.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/cpu-target.c b/cpu-target.c
index 5a7c3290814..d04c8486b0e 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -42,6 +42,7 @@
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "exec/translate-all.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 #include "hw/core/accel-cpu.h"
 #include "trace/trace-root.h"
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 471a384b222..e6f80dcd11e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -9,6 +9,7 @@
 #include "qemu.h"
 #include "user/tswap-target.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include "user/guest-base.h"
 #include "user-internals.h"
 #include "signal-common.h"
diff --git a/plugins/api.c b/plugins/api.c
index 24ea64e2de5..4110cfaa237 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -43,6 +43,7 @@
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
+#include "exec/translation-block.h"
 #include "exec/translator.h"
 #include "disas/disas.h"
 #include "plugin.h"
diff --git a/system/physmem.c b/system/physmem.c
index 93c0ff60eb4..ac95b06ebfd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -34,6 +34,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
+#include "exec/translation-block.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 5d75c941f7a..396739e3468 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -24,6 +24,7 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 660788d5c3c..629ff3cde92 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -26,6 +26,7 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 63fe4ba318b..0e976a02d3e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -19,6 +19,7 @@
 #include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include <zlib.h> /* for crc32 */
 #include "hw/irq.h"
 #include "system/cpu-timers.h"
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 2d518921159..f13b997f8d9 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 51c1762435a..d13f80fe3e4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e8..231ecac37d1 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -22,6 +22,7 @@
 #include "helper-tcg.h"
 #include "qemu/accel.h"
 #include "hw/core/accel-cpu.h"
+#include "exec/translation-block.h"
 
 #include "tcg-cpu.h"
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5d729e68c98..b5439a558e4 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -21,6 +21,7 @@
 #include "qemu/host-utils.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ad3ce345014..077151c62d9 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4beaf69e76a..d53995c26d1 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -26,6 +26,7 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "qemu/qemu-print.h"
 
 #include "exec/log.h"
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ca566847cb4..028ba66631f 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -26,6 +26,7 @@
 #include "qemu/bitops.h"
 #include "qemu/qemu-print.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 47ca50a064b..8ab87f42d67 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -30,6 +30,7 @@
 #include "exec/helper-gen.h"
 
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 #include "qemu/atomic128.h"
 #include "spr_common.h"
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index bccaf8e89a6..5fedde363f7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -25,6 +25,7 @@
 #include "exec/helper-gen.h"
 
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 #include "semihosting/semihost.h"
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9aade2b6e5c..4f43654bad0 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bcfff40b255..e78815c4f7f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -40,6 +40,7 @@
 #include "exec/helper-gen.h"
 
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 #include "qemu/atomic128.h"
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 53b092175dc..f076da9bac8 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
+#include "exec/translation-block.h"
 #include "exec/translator.h"
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cdd0a95c03d..aeb0f826346 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -27,6 +27,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 #include "fpu/softfloat.h"
 #include "asi.h"
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4a12d2ca191..2b67395c09e 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -30,6 +30,7 @@
 
 #include "tricore-opcodes.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 #include "exec/log.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f4da4a40f94..3c62c99b4fe 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -37,6 +37,7 @@
 #include "qemu/qemu-print.h"
 #include "semihosting/semihost.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-- 
2.45.2


