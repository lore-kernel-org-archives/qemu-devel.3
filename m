Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8617C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTo-0001ET-6q; Thu, 06 Mar 2025 10:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSj-0008GZ-U9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:42 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSd-0006Hj-9J
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3bcso965213f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276108; x=1741880908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G34caD8GZIkzvT1uGzaFBY/MHPpNPk1210VTkPWJrCE=;
 b=k+T9VqJUjnZ6vzKajkPWdS6PCnQaAsCBXQz+KMyVh6Ob4lR2ylF4wisbGIhBBMjyf3
 7gAmzwcTkGuoRoyVh3OIU+2M0QEY7mxIxUdrQGqg/29hk1ip/pYC71At+Ywr2rpI4/ZF
 w84PffmSOJGyMUK1Pwkq0MAXIrq8xZWFRfQRE85ru+kuaUYqeHZ01Sc2PwdMEr46tMKu
 yLmbnNK4Va8XuuMtrT+Hx/2TISLv/hPoJkV6Yu9+2kyObizVag/4QYfP45jnidwgH/fO
 JZOV18kc5mc21PXnYX73z/Nh2hfSDvqFXoLux7vRHVur6e6NyBrZuiHdkulRCo/CC71y
 5K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276108; x=1741880908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G34caD8GZIkzvT1uGzaFBY/MHPpNPk1210VTkPWJrCE=;
 b=TwLdXZiDk+VeDeakIsyZEQBMrBPGDc4oKVfdYrlbD19C+JbumUKUH0+d7M/4crrpHu
 Xt8eKwsNXsi00YhEDve3BNwP0sfUA+mzOnQjPHrjFQdMFx9VMaxE8SBaybgy4L53+13x
 Xsn0dmtuzwvNc0Ge8pSmUP3zrStWiWKx1d2pBJ5/vfTds+AsATCepsnej+1XKEFHsEHc
 vf46UH5248n3t9ZJDI6kbII4I1sUNea37DvOklo72EY5B/wuxcOGjQIm25VJeeiBw4dh
 bbc6n8NcFVpnOnF5CnzP+hLEK85Jdx+SjhdesI2Z4e+hoCPp+2pzH+QSBp3QkWPG3SvQ
 bMGg==
X-Gm-Message-State: AOJu0YzzDM9uwUBl/qzaSfMoZMS+fpo+TqLeziwFa8kpOQg3P+8eOlbj
 r1/CpphcVmor4GE0xiDNn7gpcDbYJoye+cYXS1ApdktGhc47jyVPxf4X/2wG/1pe0i+Wj0Jw20t
 ofjI=
X-Gm-Gg: ASbGnctw/8ve6Q95wTmpg1Pf5ND0hUg9LgQBNFy1KxCJC2cxwD7UW+r9Zk56fz2lQkj
 gktC8hlwzVi8XMx/8RnfNAkXYk2SULIVj+VHe+l+qT+BiXwvSNOOgPtyMC7oepbykYtG9HPUEBO
 YpQ6/sh4ec/8yM3ukJmU8xc5e4pDPe74Rtx7JaL9kp6fDT1wYtWp4uL+8HQ4Z0L2fbHjzi+12+b
 SO701B4m8xwrfc3zbNQn036WtPken70SxbuZGH7e72bmicLdfnvmyb5sjJu503JEYU20M5io/Lo
 HN4K6uAdRtt8mQYan1kzLa5iGu0OIpUG883xz3KCftYS0qNWXwjsQd+VlYp0IpS2H+/qHYHX+Cj
 XHgS3JeIeR1aChziM3wU=
X-Google-Smtp-Source: AGHT+IEXuyF76wZrv1323Pl0cP1XZ3YHsvUi3xRGKoY8hmbH6l4ntXgLI/7X5N5YFBp1XEP1DVL+Bg==
X-Received: by 2002:a5d:5f8f:0:b0:391:3124:f287 with SMTP id
 ffacd0b85a97d-3913124fb16mr814752f8f.16.1741276108154; 
 Thu, 06 Mar 2025 07:48:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015a29sm2358327f8f.42.2025.03.06.07.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/54] accel/tcg: Rename 'hw/core/tcg-cpu-ops.h' ->
 'accel/tcg/cpu-ops.h'
Date: Thu,  6 Mar 2025 16:46:53 +0100
Message-ID: <20250306154737.70886-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

TCGCPUOps structure makes more sense in the accelerator context
rather than hardware emulation. Move it under the accel/tcg/ scope.

Mechanical change doing:

 $  sed -i -e 's,hw/core/tcg-cpu-ops.h,accel/tcg/cpu-ops.h,g' \
   $(git grep -l hw/core/tcg-cpu-ops.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-11-philmd@linaro.org>
---
 MAINTAINERS                                            | 2 +-
 include/{hw/core/tcg-cpu-ops.h => accel/tcg/cpu-ops.h} | 0
 accel/tcg/cpu-exec.c                                   | 2 +-
 accel/tcg/cputlb.c                                     | 2 +-
 accel/tcg/translate-all.c                              | 2 +-
 accel/tcg/user-exec.c                                  | 2 +-
 accel/tcg/watchpoint.c                                 | 2 +-
 bsd-user/signal.c                                      | 2 +-
 hw/mips/jazz.c                                         | 2 +-
 linux-user/signal.c                                    | 2 +-
 system/physmem.c                                       | 2 +-
 target/alpha/cpu.c                                     | 2 +-
 target/arm/cpu.c                                       | 2 +-
 target/arm/tcg/cpu-v7m.c                               | 2 +-
 target/arm/tcg/cpu32.c                                 | 2 +-
 target/arm/tcg/mte_helper.c                            | 2 +-
 target/arm/tcg/sve_helper.c                            | 2 +-
 target/avr/cpu.c                                       | 2 +-
 target/avr/helper.c                                    | 2 +-
 target/hexagon/cpu.c                                   | 2 +-
 target/hppa/cpu.c                                      | 2 +-
 target/i386/tcg/tcg-cpu.c                              | 2 +-
 target/loongarch/cpu.c                                 | 2 +-
 target/m68k/cpu.c                                      | 2 +-
 target/microblaze/cpu.c                                | 2 +-
 target/mips/cpu.c                                      | 2 +-
 target/openrisc/cpu.c                                  | 2 +-
 target/ppc/cpu_init.c                                  | 2 +-
 target/riscv/cpu_helper.c                              | 2 +-
 target/riscv/tcg/tcg-cpu.c                             | 2 +-
 target/rx/cpu.c                                        | 2 +-
 target/s390x/cpu.c                                     | 2 +-
 target/s390x/tcg/mem_helper.c                          | 2 +-
 target/sh4/cpu.c                                       | 2 +-
 target/sparc/cpu.c                                     | 2 +-
 target/tricore/cpu.c                                   | 2 +-
 target/xtensa/cpu.c                                    | 2 +-
 37 files changed, 36 insertions(+), 36 deletions(-)
 rename include/{hw/core/tcg-cpu-ops.h => accel/tcg/cpu-ops.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 692628cd780..2d9ba810851 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -175,7 +175,7 @@ F: include/exec/helper-info.c.inc
 F: include/exec/page-protection.h
 F: include/system/cpus.h
 F: include/system/tcg.h
-F: include/hw/core/tcg-cpu-ops.h
+F: include/accel/tcg/cpu-ops.h
 F: host/include/*/host/cpuinfo.h
 F: util/cpuinfo-*.c
 F: include/tcg/
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/accel/tcg/cpu-ops.h
similarity index 100%
rename from include/hw/core/tcg-cpu-ops.h
rename to include/accel/tcg/cpu-ops.h
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index be2ba199d3d..3a3c45f52ed 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/cpu-common.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ad158050a13..c8761683a0a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/memory.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d4189c73860..786e2f6f1a7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -58,7 +58,7 @@
 #include "system/cpu-timers.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 0561c4f6dc7..c4454100ad7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -17,7 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index af57d182d5b..40112b2b2e7 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -26,7 +26,7 @@
 #include "tb-internal.h"
 #include "system/tcg.h"
 #include "system/replay.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "hw/core/cpu.h"
 #include "internal-common.h"
 
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index ff2ccbbf605..ab1d9ddd50f 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -29,7 +29,7 @@
 #include "gdbstub/user.h"
 #include "signal-common.h"
 #include "trace.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "host-signal.h"
 
 /* target_siginfo_t must fit in gdbstub's siginfo save area. */
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index c89610639a9..1700c3765de 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -50,7 +50,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #ifdef CONFIG_TCG
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #endif /* CONFIG_TCG */
 #include "cpu.h"
 
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 81a98c6d02f..4799b79dede 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -21,7 +21,7 @@
 #include "qemu/cutils.h"
 #include "gdbstub/user.h"
 #include "exec/page-protection.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 #include <sys/ucontext.h>
 #include <sys/resource.h>
diff --git a/system/physmem.c b/system/physmem.c
index eff8b55c2dd..8c1736f84ee 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -28,7 +28,7 @@
 #include "qemu/lockable.h"
 
 #ifdef CONFIG_TCG
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #endif /* CONFIG_TCG */
 
 #include "exec/exec-all.h"
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index f5dd7449876..57e41fcd784 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -227,7 +227,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
     .initialize = alpha_translate_init,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 656070afb59..ac1ceec2110 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -29,7 +29,7 @@
 #include "cpu.h"
 #ifdef CONFIG_TCG
 #include "exec/translation-block.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #endif /* CONFIG_TCG */
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 03acdf83e00..29a41fde694 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "internals.h"
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 0f1c5bc87e8..2c45b7eddda 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "internals.h"
 #include "target/arm/idau.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index f72ce2ae0d4..5d6d8a17ae8 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -31,7 +31,7 @@
 #endif
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #include "mte_helper.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c206ca65ceb..d786b4b1118 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -28,7 +28,7 @@
 #include "tcg/tcg.h"
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8a126ff3222..5a0e21465e5 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -203,7 +203,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
     .get_phys_page_debug = avr_cpu_get_phys_page_debug,
 };
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
     .initialize = avr_cpu_tcg_init,
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 345708a1b39..9ea6870e44d 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0b7fc98f6ce..238e63bcea4 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -321,7 +321,7 @@ static void hexagon_cpu_init(Object *obj)
 {
 }
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
     .initialize = hexagon_translate_init,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5655677431c..4bb5cff624e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -245,7 +245,7 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
     .initialize = hppa_translate_init,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 14ee038079a..f09ee813ac9 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -105,7 +105,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 }
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
     .initialize = tcg_x86_init,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ac514a15fba..b4b82425b18 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -857,7 +857,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifdef CONFIG_TCG
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
     .initialize = loongarch_translate_init,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 2617d8f6ede..eedda07c2ab 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -582,7 +582,7 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 };
 #endif /* !CONFIG_USER_ONLY */
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f114789abd8..13d194cef88 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -419,7 +419,7 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
     .initialize = mb_tcg_init,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47cd7cfdcef..0b267d2e507 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -544,7 +544,7 @@ static const Property mips_cpu_properties[] = {
 };
 
 #ifdef CONFIG_TCG
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 static const TCGCPUOps mips_tcg_ops = {
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b7bab0d7abf..0669ba2fd10 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -232,7 +232,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
     .initialize = openrisc_translate_init,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 062a6e85fba..425049ab093 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7430,7 +7430,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #endif
 
 #ifdef CONFIG_TCG
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
   .initialize = ppc_translate_init,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3f5fd861a80..34092f372df 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -27,7 +27,7 @@
 #include "exec/page-protection.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
 #include "system/cpu-timers.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f1d971eec1f..70f4c7984aa 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -31,7 +31,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "hw/core/accel-cpu.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 37a6fdd569b..7d5fcbf76ac 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -200,7 +200,7 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
     .initialize = rx_translate_init,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 97d41c23de7..3bea014f9ee 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -322,7 +322,7 @@ static const Property s390x_cpu_properties[] = {
 #endif
 
 #ifdef CONFIG_TCG
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index c6ab2901e5a..ea9fa64d6b4 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -28,7 +28,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ccfe222bdf3..22cdf9b4e12 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -256,7 +256,7 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
     .initialize = sh4_translate_init,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fbd38ec334a..e3b46137178 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -992,7 +992,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #endif
 
 #ifdef CONFIG_TCG
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
     .initialize = sparc_tcg_init,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 95202fadbfd..eb794674c8d 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -168,7 +168,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
     .get_phys_page_debug = tricore_cpu_get_phys_page_debug,
 };
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
     .initialize = tricore_tcg_init,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4eb699d1f45..efbfe73fcfb 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -228,7 +228,7 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 };
 #endif
 
-#include "hw/core/tcg-cpu-ops.h"
+#include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
     .initialize = xtensa_translate_init,
-- 
2.47.1


