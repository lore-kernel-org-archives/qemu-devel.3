Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643F2ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDMC-0004Ni-58; Thu, 05 Feb 2026 23:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDMA-0004Lz-MB
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:10 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM7-0003Tk-Kz
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:10 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82318702afbso228567b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351726; x=1770956526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUFdts3CrD2LjojjXcJUcXjopBDfFEshkWcx0O/wm9M=;
 b=mT+jSa5T1QzXSX4TFvhhD7+CirJIKog1Fe3Hn2BeCT4HzXdq5hlFoQD+8kSH19LX63
 7Aqg2fNjfozt6h44gsXju6/sSGXmnETtqXbrCnC4vAcXZSOqrVFm4p+jJORfvyvU1VPP
 mJIURe/5t0dGpYt808QMtxEouf2q3lT3YemOq0a/K5VlKokWL1mSm4e0XRty0JoTSLN3
 dm9kee+NOkItYWfm7Fh5H/Qsus1ESj6FeAJ9s8rZ6Zo8LSf+AcakBSmU5+ZQmrkw/QhA
 3q+ztRKC5WorER/C3Qa4DDEuwHPR1FepfFQH8byKVr85+zaUuTBLVGNbT7MU9rpCKA2Q
 4YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351726; x=1770956526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xUFdts3CrD2LjojjXcJUcXjopBDfFEshkWcx0O/wm9M=;
 b=lRXxQS9+7ABLxPYzvV3VZMP9p7PluGo2uuzumE+PDBrOqpaUFyfznxldViPwZu6kwR
 UBziooxVVgT1I+vOFwGThpYHSsi/fVqoQYTIiucDaxLpi0xi8RPWCIcu0cvVA+rhTFHV
 eoejIviLjPWx9ukFhEkNlLQE3vB1ORSeI3B/7ZznBk72Is+Qf0Pb5GvIH7tHGj5U4So7
 01+Osf6yxrZeBafU+gOwErB1usk0oC4WcEPMUmjtM9ud2r3Ca9TkXWgGsJNxDe37JF2k
 XZJLytZPx4iOFz71twBpkN6uxkHwjxYNzmWVzcOUskZ1lvvsQUvAaTtC8431YddvHQGZ
 97NA==
X-Gm-Message-State: AOJu0YwhvXQWnH6ClEnF7LguqqYt+TZpLmB/j0JJaTzlubn2HvhrFv+a
 az8aiAT0o4BgDnn6HHpvytjtedLBP1PmCygVI0W1l05tbuj8OJKD+w81WqLUPUfLlSi7miJ6HB+
 PfPoW
X-Gm-Gg: AZuq6aLf0P+gIieLOXQIfSURgqZeGpzax5ym6AAFDZHbHcs64LXg3zdLJK/zSZJhWWc
 HI880qS6Tncefs4T6U+jkSUmVEFaBndBUuAPmSKq2V6uOKHqymX2o56QKTfHhgEua+1FYwKrV+Z
 rXcKQYhLa75czAmYOjrJQGTeKhmhXsNaiuCrZlylUb2gPbPGXW5RS5h+kot2ZBxcHRdGh4vZz9L
 KNWMGC7f66Vg5axCChTMfqEmnf2VTzNWwMMPe7+YwZAsKaoETn9/Ta/TmCOQPyJLeSNOwNIn0L5
 g9yG1/+BcZ92ChJwXigg3TnKLdvDx1vj6sLpI8XhvNp6hvzqgMdgdGHZa49ykwJiCIjAQrW5iCk
 BbV0ylwEy+bQKx+l8d7ontO+1paIbksees3G/KNj2qvcbp27i/UObcHrLZEhVmD0mBhaWOVTjyR
 XEOUuy2Vt8Z6pJStuo4qzRZiYjbkIspPG7ZdQi5Pmde5rvNuJh/cgXd7aIWPP34QBRYb8eF1D+f
 VY=
X-Received: by 2002:a05:6a00:4185:b0:81f:3957:2772 with SMTP id
 d2e1a72fcca58-8244160c6e6mr1317363b3a.3.1770351726160; 
 Thu, 05 Feb 2026 20:22:06 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:05 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/12] target/arm: move exec/helper-* plumbery to helper.h
Date: Thu,  5 Feb 2026 20:21:45 -0800
Message-ID: <20260206042150.912578-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since we cleaned helper.h, we can continue further and remove
all exec/helper-* inclusion. This way, all helpers use the same pattern,
and helper include details are limited to those headers.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h                        | 13 ++++++++++++-
 target/arm/tcg/{helper.h => helper-defs.h} |  0
 target/arm/tcg/translate.h                 |  2 +-
 target/arm/debug_helper.c                  |  4 +---
 target/arm/helper.c                        |  5 +++--
 target/arm/tcg/arith_helper.c              |  4 +---
 target/arm/tcg/crypto_helper.c             |  4 +---
 target/arm/tcg/helper-a64.c                |  2 +-
 target/arm/tcg/hflags.c                    |  4 +---
 target/arm/tcg/m_helper.c                  |  2 +-
 target/arm/tcg/mte_helper.c                |  2 +-
 target/arm/tcg/mve_helper.c                |  2 +-
 target/arm/tcg/neon_helper.c               |  4 +---
 target/arm/tcg/op_helper.c                 |  2 +-
 target/arm/tcg/pauth_helper.c              |  2 +-
 target/arm/tcg/psci.c                      |  2 +-
 target/arm/tcg/sme_helper.c                |  2 +-
 target/arm/tcg/sve_helper.c                |  2 +-
 target/arm/tcg/tlb_helper.c                |  4 +---
 target/arm/tcg/translate.c                 |  6 +-----
 target/arm/tcg/vec_helper.c                |  2 +-
 target/arm/tcg/vfp_helper.c                |  4 +---
 22 files changed, 34 insertions(+), 40 deletions(-)
 rename target/arm/tcg/{helper.h => helper-defs.h} (100%)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b1e83196b3b..b1c26c180ea 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,3 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-#include "tcg/helper.h"
+#ifndef HELPER__H
+#define HELPER__H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER__H */
diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper-defs.h
similarity index 100%
rename from target/arm/tcg/helper.h
rename to target/arm/tcg/helper-defs.h
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1e30d7c77c3..027769271c9 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -6,7 +6,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
-#include "exec/helper-gen.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 579516e1541..ec6a2b0c179 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -8,15 +8,13 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e86ceb130ce..70227263612 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10,6 +10,7 @@
 #include "qemu/log.h"
 #include "trace.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/page-protection.h"
@@ -36,8 +37,8 @@
 #include "target/arm/gtimer.h"
 #include "qemu/plugin.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
+#define HELPER_H "tcg/helper-defs.h"
+#include "exec/helper-info.c.inc"
 
 static void switch_mode(CPUARMState *env, int mode);
 
diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 97c6362992c..cc081c8f966 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -8,11 +8,9 @@
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "qemu/crc32c.h"
+#include "helper.h"
 #include <zlib.h> /* for crc32 */
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 /*
  * Note that signed overflow is undefined in C.  The following routines are
  * careful to use unsigned types where modulo arithmetic is required.
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 3428bd1bf0b..11977cb7723 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -15,11 +15,9 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
+#include "helper.h"
 #include "vec_internal.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 07ddfb895dd..2dec587d386 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -21,7 +21,7 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "gdbstub/helpers.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "helper-a64.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5c9b9bec3b2..7e6f8d36475 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -7,15 +7,13 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 static inline bool fgt_svc(CPUARMState *env, int el)
 {
     /*
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 3fb24c77900..5a75e8b3e11 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -8,10 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "gdbstub/helpers.h"
-#include "exec/helper-proto.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 01b7f099f4a..a9fb979f639 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "exec/target_page.h"
 #include "exec/page-protection.h"
@@ -32,7 +33,6 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "helper-a64.h"
-#include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "qapi/error.h"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index f33642df1f9..a67d90d6c75 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -19,10 +19,10 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "helper-mve.h"
 #include "internals.h"
 #include "vec_internal.h"
-#include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 8d288f3a700..69147969b23 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,13 +9,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4fbd219555d..5a510730ece 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "exec/target_page.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 5a20117ae89..67c0d59d9e9 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -19,11 +19,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "helper-a64.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
 
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 2d409301578..bca6058e41a 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
 #include "system/runstate.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 7729732369f..ab5999c5925 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "helper-sme.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/helper-retaddr.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 16e528e41a6..062d8881bd0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -21,9 +21,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/page-protection.h"
-#include "exec/helper-proto.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#include "helper.h"
 #include "helper-a64.h"
 #include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 5c689d3b69f..565954269f9 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -7,12 +7,10 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
  * tables. Used when raising alignment exceptions, whose FSR changes depending
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index febb7f1532a..982c83ef42a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -26,14 +26,10 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
-#include "exec/helper-proto.h"
 #include "exec/target_page.h"
+#include "helper.h"
 #include "helper-mve.h"
 
-#define HELPER_H "helper.h"
-#include "exec/helper-info.c.inc"
-#undef  HELPER_H
-
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index a070ac90579..1223b843bf1 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index e156e3774ad..45f2eb0930f 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -19,14 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 /*
  * Set the float_status behaviour to match the Arm defaults:
  *  * tininess-before-rounding
-- 
2.47.3


