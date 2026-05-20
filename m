Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEDECD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmWi-0007LT-Sx; Wed, 20 May 2026 15:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWb-0007H4-Aa
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWZ-0001oU-AL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso3355679f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305049; x=1779909849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m4CFVBuY5FpXniBNOFBvMmlKaStuGCYzJte6nly+p94=;
 b=WSj/ixCmatIib9sUkwwFhDM31X9SSDRGDaKFJDHhW9495xZAyifrIVsT+9vRhTf46I
 FhhxzBCRRuqBSt7pWhffOmPXO7g5DXuBSRfcd1bDYu0NenickSwitJ7GY4Tg0mk4VHli
 +fO4bc8HoQYHRiuuX1VqW4VwbQKOn/A4RFWp1E6MMwkxO5+QIrm0lqMo4eIe0Fy5CC69
 XJZOgfjvLSzlui4UsQIDbyOZ1CAcOw/DzAWjShnsM2y9PgeecKoPAwodFTeZFok5vpSw
 l1H32OCoX+hRFt3KYBCu5xVya04g8KWB3THz1prvdVn2JKjDsGxPSeLRwJG6cubOTeRt
 qv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305049; x=1779909849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m4CFVBuY5FpXniBNOFBvMmlKaStuGCYzJte6nly+p94=;
 b=F+rMQaQ0yYJuEbcGKxubK+XE5iorFjB5gF5lFTBgdVr95oOlDNQGTlDCjanF9lVGdt
 KKSw2W4jpO5dRGlzIVwy5qWnIbqAxJPro2vrue0+qTSe4r1Dnoy8X7oC0fuXUP7jhndm
 xqbBaEOTKpMIick92XTVWic/Bz3UhJF2/zs50f/W8Ij9muZde6+CcEdA6z5BWRBW4qkJ
 8xsmXpNgiSDvDB9WzpcdHQguy26CfdZNabpUXXTDSnte14hx7qDw7PUl5mFGGzQTvfLX
 vaUSGDf0JHvdw77cAkqr4PzlJ8R5csOTlkZZ4P64L+pQWl6xz1Fhu4xBGIetFAGX+STn
 Gwcw==
X-Gm-Message-State: AOJu0YwbQbvTR9wkd/4cIdVeRBxRLV+RTHZlB1a4GqD5vwKttrOVPe18
 txQgFOrPG/8fWkQ6410dqej8RgmQtu0H/s0uLQyfp6J3hwnkHKhrFWCNC2Q9e91VlntEs/hUGun
 4sPwaCQc=
X-Gm-Gg: Acq92OFpDojDGD3jISHOiaDzMCCO6SHSVwjNxwr+G3xlvnFOqKSaAhg/KSSnIeAbCEp
 J0p5eWzDxy8xpzVsDolTn88XNoQKK4KM0gYBKw62mDTPUNrC2GQKvlFA91EErmbaWm6uDqvOJfv
 fxRxHifEfAaYyraCduT4XZlSg8IiRRxR+m051KmhBVVJ2b10+mlZ4+grEzgwVDPIVRG2aaz0I7N
 o3AnX8wq6BbEbCyNJ9trp2HyRpbD5QobissNhYTu+3l6UjDD7oMIGm0Ecx347XiEOFDcMBLDkA5
 1H2IueZ7yWR+6bJwON7Dg1AfHhfeQQhMfXZR9BGuSQlIUhRBVWe5p8ZLuL2BAJsu113yrbL/7rk
 YMH99jU+WMLCSg8rc6k5jZz+whHDEGew4oUEeL7vDDtzJVDt+nL0Qs8nacP+nm/Bg5u5WZ8+vdY
 x9XpeiL0+G5Svz4COH+/PuDMlNo40oZ4d7pe7vEkRFb6P242YNqpQ2plJg4sYzyVUEuJx3gEXs/
 5rGpR9+5kA=
X-Received: by 2002:a5d:6311:0:b0:45e:73a5:e7f4 with SMTP id
 ffacd0b85a97d-45e73a61c59mr20779238f8f.37.1779305049040; 
 Wed, 20 May 2026 12:24:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm57095865f8f.32.2026.05.20.12.24.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:24:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/33] buildsys: Remove support for MIPS hosts
Date: Wed, 20 May 2026 21:23:09 +0200
Message-ID: <20260520192338.40036-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

MIPS host support is deprecated since commit 269ffaabc84
("buildsys: Remove support for 32-bit MIPS hosts"). Time
to remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260511135312.38705-3-philmd@linaro.org>
---
 docs/about/deprecated.rst       |  8 --------
 docs/about/removed-features.rst |  6 ++++++
 configure                       | 19 -------------------
 meson.build                     | 10 +---------
 include/qemu/timer.h            | 30 ------------------------------
 util/cacheflush.c               | 16 ----------------
 6 files changed, 7 insertions(+), 82 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e64328c5b2b..95bf7613295 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -177,14 +177,6 @@ The ``info capture`` command is deprecated and will be removed in a future relea
 Host Architectures
 ------------------
 
-MIPS (since 10.2)
-'''''''''''''''''
-
-MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
-maintain our cross-compilation CI tests of the architecture. As we no longer
-have CI coverage support may bitrot away before the deprecation process
-completes.
-
 TCG Plugin support not enabled by default with TCI (since 9.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 1ee4ab07944..2021e85f56a 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -938,6 +938,12 @@ From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
 maintain our cross-compilation CI tests of the architecture.
 
+64-bit MIPS (removed in 11.1)
+'''''''''''''''''''''''''''''
+
+Debian 13 "Trixie" removed support for MIPS, making it hard to maintain our
+cross-compilation CI tests of the architecture.
+
 32-bit PPC (removed in 10.2)
 ''''''''''''''''''''''''''''
 
diff --git a/configure b/configure
index b6dd797de5b..e138d83bc9f 100755
--- a/configure
+++ b/configure
@@ -399,8 +399,6 @@ elif check_define _ARCH_PPC64 ; then
   else
     cpu="ppc64"
   fi
-elif check_define __mips64 ; then
-  cpu="mips64"
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
@@ -446,12 +444,6 @@ case "$cpu" in
     linux_arch=loongarch
     ;;
 
-  mips64*|mipsisa64*)
-    cpu=mips64
-    host_arch=mips64
-    linux_arch=mips
-    ;;
-
   ppc64)
     host_arch=ppc64
     linux_arch=powerpc
@@ -1244,11 +1236,6 @@ EOF
         rust_osvariant=${rust_osvariant}eabi
       fi
       ;;
-
-    mips64)
-      # e.g. mips64-unknown-linux-gnuabi64
-      rust_osvariant=${rust_osvariant}abi64
-      ;;
     esac
     ;;
 
@@ -1281,12 +1268,6 @@ EOF
     test "$rust_arch" = arm && test "$rust_os" != linux && rust_arch=armv7
     ;;
 
-  mips)
-    # preserve ISA version (mipsisa64r6 etc.) and include endianness
-    rust_arch=${raw_cpu%el}
-    test "$bigendian" = no && rust_arch=${rust_arch}el
-    ;;
-
   riscv64)
     # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
     test "$android" = no && rust_arch=${rust_arch}gc
diff --git a/meson.build b/meson.build
index 70613bf4afc..fe5211b2122 100644
--- a/meson.build
+++ b/meson.build
@@ -55,7 +55,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
-  'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm64']
+  'aarch64', 'loongarch64', 'sparc64', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -5013,14 +5013,6 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_arch == 'mips'
-  message()
-  warning('DEPRECATED HOST CPU')
-  message()
-  message('Support for CPU host architecture ' + cpu + ' is going to be')
-  message('dropped as soon as the QEMU project stops supporting Debian 12')
-  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
-  message('that QEMU will compile or work on this host CPU.')
 endif
 
 if not supported_oses.contains(host_os)
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index b931181f53d..ec03635dd34 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -922,36 +922,6 @@ static inline int64_t cpu_get_host_ticks (void)
 #endif
 }
 
-#elif defined(__mips__) && \
-    ((defined(__mips_isa_rev) && __mips_isa_rev >= 2) || defined(__linux__))
-/*
- * binutils wants to use rdhwr only on mips32r2
- * but as linux kernel emulate it, it's fine
- * to use it.
- *
- */
-#define MIPS_RDHWR(rd, value) {                         \
-        __asm__ __volatile__ (".set   push\n\t"         \
-                              ".set mips32r2\n\t"       \
-                              "rdhwr  %0, "rd"\n\t"     \
-                              ".set   pop"              \
-                              : "=r" (value));          \
-    }
-
-static inline int64_t cpu_get_host_ticks(void)
-{
-    /* On kernels >= 2.6.25 rdhwr <reg>, $2 and $3 are emulated */
-    uint32_t count;
-    static uint32_t cyc_per_count = 0;
-
-    if (!cyc_per_count) {
-        MIPS_RDHWR("$3", cyc_per_count);
-    }
-
-    MIPS_RDHWR("$2", count);
-    return (int64_t)(count * cyc_per_count);
-}
-
 #elif defined(__alpha__)
 
 static inline int64_t cpu_get_host_ticks(void)
diff --git a/util/cacheflush.c b/util/cacheflush.c
index c043c5f881a..247c4ce2980 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -301,22 +301,6 @@ void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 }
 #endif /* CONFIG_DARWIN */
 
-#elif defined(__mips__)
-
-#ifdef __OpenBSD__
-#include <machine/sysarch.h>
-#else
-#include <sys/cachectl.h>
-#endif
-
-void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
-{
-    if (rx != rw) {
-        cacheflush((void *)rw, len, DCACHE);
-    }
-    cacheflush((void *)rx, len, ICACHE);
-}
-
 #elif defined(__powerpc__)
 
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
-- 
2.53.0


