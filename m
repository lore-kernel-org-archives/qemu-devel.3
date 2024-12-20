Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793A8E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfii-0003VN-S8; Fri, 20 Dec 2024 11:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiF-0001eI-5F
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:55 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiD-0008CZ-14
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1628410f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711527; x=1735316327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJ6sY5XUhLHbRNTmaDxbD9cJFw1tn4dnsQbphdheGMc=;
 b=PLu6AUMOYPZ73H2se66gxhVmGLKVpmpkqRpltnySQgXDUvDo7hxVOGLK53bFs+WXCU
 qnIlnABbFp5iiOvbpXFHZ+9KhYdYY6Few090YU4wvKF5/ntk9PvO0RHePtqXU2Wm1bHO
 sSglJgO3PM1/2gzad84xIZQ3B+EX5lspMV43uQIIiLfDePK96N33PwLiSpberASV7+MN
 tJu9gQPLM/rlHhzgz6IWANxoQSD/pj7Mat8t9sHN8izyJEO26iqtsxtY42945TDYqtP+
 BT6mOE5UgxCCxW5o716nwypFes+QAXeCIZAgnESyfN7UeMhK2HAgrvqJUdeySfkj1a4/
 yqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711527; x=1735316327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJ6sY5XUhLHbRNTmaDxbD9cJFw1tn4dnsQbphdheGMc=;
 b=WYUqQE0jONlu0UxEiAbKNLqVFC/1QJ6iQDbfdhMHe8rftJJRZRIuRUGc1PeesT27jp
 ItvXrKSpfRRgfvW/9ALYay0Qxr04n46bsbWzKMvdpU4sMrPXTt+jQ5wGksZI65+It/nI
 dFF5EQS02ym1uh6W6AJ0cWA9VZjZCA2G94FG5hZh93y+8ecwH+9JRNrxPLCksu4W+xob
 mfAgGFYUYptfCr3e5S8ywQHyzOVr6bwX4D4RnVUUI/TaGx5L74S5rpDA85nA9aVKAheo
 zo9Gy2c3D36/5aFpwXzXVIoONbWqPbgWmdI2NZ4qhMkUUv3DRpeOViwWctI/d5s/tTos
 ukiQ==
X-Gm-Message-State: AOJu0YwmllJFIZtaWv60RxTkiO1PL+wZ55x6xZZlAOrUbPAMPqZ21jJf
 +AcE1dVXHRwewP8MVetF+NKSoqLFa7XbbhQBr5eQxfBAe93PldC5jkkJai5bdwmsWPHwas0PTo5
 Z
X-Gm-Gg: ASbGnctixRxy6GqECX7RX6XpvUGfhYMQBd+jGG43FTQ4BosEUOf+p013lKcmxwB5HZ5
 OOkleJenyI7FoLWkwnXUg4PQxmXLt4T1Ujriue/vCYl/bZ0TMg6U4DqFANO/GjFwdpr399JWZ+u
 vc9mhGCVf9TtXlvzsy61sBrCfioh0rz+h38f6TPVBsvcW+zTp6czGI8wH6/95goWlu3k5uOBQnM
 fuQmSUJQtYfEL/OxNP8UpaAL8OK00tahAA/o+gvNnXN2W/EyLQG5U7x9n64zSG9fEKbRlvcrUU=
X-Google-Smtp-Source: AGHT+IGP9U8koon1A6z6XBMOs8bjTpH0xW0vcgy3QM38YR28WD067XPkEggVojvMvp2pW1aZP9+72A==
X-Received: by 2002:a05:6000:400c:b0:385:f23a:2fe1 with SMTP id
 ffacd0b85a97d-38a221f92c9mr3835774f8f.26.1734711527089; 
 Fri, 20 Dec 2024 08:18:47 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a636asm4500534f8f.88.2024.12.20.08.18.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 38/59] user: Move 'linux-user/cpu_loop-common.h' ->
 'user/cpu_loop.h'
Date: Fri, 20 Dec 2024 17:15:29 +0100
Message-ID: <20241220161551.89317-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

"linux-user/cpu_loop-common.h" is generic enough to be used by
bsd-user, so rename it as "user/cpu_loop.h".

Mechanical change running:

  $ sed -i -e 's,cpu_loop-common.h,user/cpu_loop.h,' \
                $(git grep -l cpu_loop-common.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-17-philmd@linaro.org>
---
 linux-user/cpu_loop-common.h => include/user/cpu_loop.h | 4 ++--
 linux-user/aarch64/cpu_loop.c                           | 2 +-
 linux-user/alpha/cpu_loop.c                             | 2 +-
 linux-user/arm/cpu_loop.c                               | 2 +-
 linux-user/hexagon/cpu_loop.c                           | 2 +-
 linux-user/hppa/cpu_loop.c                              | 2 +-
 linux-user/i386/cpu_loop.c                              | 2 +-
 linux-user/loongarch64/cpu_loop.c                       | 2 +-
 linux-user/m68k/cpu_loop.c                              | 2 +-
 linux-user/main.c                                       | 2 +-
 linux-user/microblaze/cpu_loop.c                        | 2 +-
 linux-user/mips/cpu_loop.c                              | 2 +-
 linux-user/openrisc/cpu_loop.c                          | 2 +-
 linux-user/ppc/cpu_loop.c                               | 2 +-
 linux-user/riscv/cpu_loop.c                             | 2 +-
 linux-user/s390x/cpu_loop.c                             | 2 +-
 linux-user/sh4/cpu_loop.c                               | 2 +-
 linux-user/sparc/cpu_loop.c                             | 2 +-
 linux-user/syscall.c                                    | 2 +-
 linux-user/xtensa/cpu_loop.c                            | 2 +-
 20 files changed, 21 insertions(+), 21 deletions(-)
 rename linux-user/cpu_loop-common.h => include/user/cpu_loop.h (95%)

diff --git a/linux-user/cpu_loop-common.h b/include/user/cpu_loop.h
similarity index 95%
rename from linux-user/cpu_loop-common.h
rename to include/user/cpu_loop.h
index aca51f53238..8e2df232758 100644
--- a/linux-user/cpu_loop-common.h
+++ b/include/user/cpu_loop.h
@@ -17,8 +17,8 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef CPU_LOOP_COMMON_H
-#define CPU_LOOP_COMMON_H
+#ifndef USER_CPU_LOOP_H
+#define USER_CPU_LOOP_H
 
 #include "exec/log.h"
 #include "special-errno.h"
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 77f857a8216..c5d8a483a3f 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "qemu/guest-random.h"
 #include "semihosting/common-semi.h"
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index b5403ed0e46..80ad536c5f2 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUAlphaState *env)
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index be1f11022a7..10d8561f9b9 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 #include "user-internals.h"
 #include "elf.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "semihosting/common-semi.h"
 #include "exec/page-protection.h"
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 750150a78db..e18a0183b50 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "internal.h"
 
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 503a204460e..890e758cd1c 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 static abi_ulong hppa_lws(CPUHPPAState *env)
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index e06aa23de4c..d96d5553faf 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 #include "qemu/timer.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "user-mmap.h"
 
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 935d5bcf2c8..0614d3de224 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPULoongArchState *env)
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 69cdce95518..5da91b997ae 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUM68KState *env)
diff --git a/linux-user/main.c b/linux-user/main.c
index 06037304cb1..b97634a32dd 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -50,7 +50,7 @@
 #include "elf.h"
 #include "trace/control.h"
 #include "target_elf.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "crypto/init.h"
 #include "fd-trans.h"
 #include "signal-common.h"
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index ee4ba768691..87236c166f2 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUMBState *env)
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 1331a9a2b8d..6405806eb02 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "elf.h"
 #include "internal.h"
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 1bf9542d16a..306b4f8eb43 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUOpenRISCState *env)
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index e168f1ce947..2a0efaffcd6 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 #include "qemu/timer.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 static inline uint64_t cpu_ppc_get_tb(CPUPPCState *env)
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index a72bc76da3d..3ac8bbfec1f 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 #include "elf.h"
 #include "semihosting/common-semi.h"
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 42e4d24102e..c9124444ed2 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 937d9fa265d..ee9eff3428a 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 void cpu_loop(CPUSH4State *env)
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 58a2464da9f..68f1e8ecd43 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 #define SPARC64_STACK_BIAS 2047
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c54b199b6d3..1b335688f12 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -143,7 +143,7 @@
 #include "special-errno.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index 7564e25a966..c0fcf743e70 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
-#include "cpu_loop-common.h"
+#include "user/cpu_loop.h"
 #include "signal-common.h"
 
 static void xtensa_rfw(CPUXtensaState *env)
-- 
2.47.1


