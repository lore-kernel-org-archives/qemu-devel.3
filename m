Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6D0CD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMR4j-0008PJ-74; Mon, 11 May 2026 09:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMR4d-0008Ox-U7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:53:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMR4c-0004R3-1U
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:53:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso30625735e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507608; x=1779112408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RblXm9dhEHZv279MNl7uYc29BPUcgmnZmPt//VeUYCc=;
 b=bPfak/fid/JC9UWhB+5LZNjhpdP024SMvHvhk+AMd4+NVwLHE9vwd8zUiiR8L3v+Pp
 qbqz5jkg4lhTrfj8tE0x1t8YAk9hIRl6ElYORi442GiPbZvO9QtSkoTVB2J93RHnEE2C
 2k154FjdzFUJChXiIUqfeh+MolRqP0atSsoOBcpMaYAYQYo7ccR/kr48AWzZO5DS6Ge2
 VzVZxOopcdhp/v5tYW2I7Wj4Uwv0NA3/d1Yo/XMcLZSlKs2fkNZLynrCk4A+5KV17PPN
 l7Y59aq+2VOtHQp12EhSV8IcHYeGp9oiyR5sWQXwoVAo+4u8SdRGYG7Q4HKoapT5CLo2
 6ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507608; x=1779112408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RblXm9dhEHZv279MNl7uYc29BPUcgmnZmPt//VeUYCc=;
 b=BMUUf2EaP9Jh/LMlGuOS8SPhy1a5wVEuvC7sNeVDr1ZaIy5ZZls9uydak8LgmgQzVD
 Heeibup5UkG4VgFUAyCyk4Y4PyU6sU2pW8wj19vNJrbinelgZ1lbzd9ZJWrbpaZ9jMBv
 3GMvMlfnmHpjUpudPyR83hcrxFvlkeI4yR3EP5Wr07pwjgaMdxdH/Vbeb4ShqjUXi0kO
 uCK1burwolFgUCB2Zlamh7JyzkpymGA5HsXn4tpmuMFvvE38KZDwEb6DN2y6/gwUWGtQ
 FEHUlCKmrnCh2xlbJe3Rr2HwuO5Lwmwpwbl7pf9u3iiHKKQynhUx0EosE/Sr2XfD3uzS
 NZKw==
X-Gm-Message-State: AOJu0YwUn/tf+ljHrWIhcbDrruFII/P12l50QdW67Ipylvtk2BjT+PCD
 Up8DLxdfbkZmnbJZ95FWSbWv9jt26ivUspqO6DfI2B5MtakY8vIny+QP0OzJ0pbxMzm7U31csX9
 7Mvk2xgY=
X-Gm-Gg: Acq92OESbjU29uO+JFaHp07KeHAFiwWR59BLnffLMmew1MI3xpRl6rRJt+URq21+tT2
 HFRkezhkvDqZB2QmTXOxupKlmzBul+ZnpZ0kKBPaw397IXM6O2seBqyNkD0+JuAHczJcudkCMZB
 ma7rn35c1SEnRZGyE3wkaQdfQS4FwkIACerOgGoIa4MGq2I1z/telMLt6A81PckYQ63WnToyv5d
 C+qxXUMzJOA7fXPfZ5cimXzRNX1fyvp+ht8JJbW4AjzaMvZNswlleZ+ccQuMJSi+hFLpXYNi723
 l1mnPqN7y1mHvWj6paUpOTt5So44AyRA6y/oxZ6jWwpaiutfQFTdxthlUJKhtqqMsUxULP5etNu
 8SYYxaH68Guth8legzwapOUxXkl59wrgFh38iP0fjG8gPsQg7bMdw5NIBzvDlytkwHvSvWlKgYb
 SYbcN7IRhvful86gpS9V4zjG01hAxy+S+OQPCvUi4mZS96i2Ntebawlunk3KRlgUjzNHTQ77/Q
X-Received: by 2002:a05:600c:8594:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48e676a4e1fmr169162165e9.15.1778507608202; 
 Mon, 11 May 2026 06:53:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e0bf2sm328985905e9.4.2026.05.11.06.53.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 06:53:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/5] buildsys: Remove support for MIPS hosts
Date: Mon, 11 May 2026 15:53:08 +0200
Message-ID: <20260511135312.38705-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511135312.38705-1-philmd@linaro.org>
References: <20260511135312.38705-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 docs/about/deprecated.rst       |  8 --------
 docs/about/removed-features.rst |  6 ++++++
 configure                       | 19 -------------------
 meson.build                     | 10 +---------
 include/qemu/timer.h            | 30 ------------------------------
 util/cacheflush.c               | 16 ----------------
 6 files changed, 7 insertions(+), 82 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5551bd12ad8..9e889601df1 100644
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
index 626162022a8..1a30b941d65 100644
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
index 5fbdc75a0fc..692d0bc0eab 100644
--- a/meson.build
+++ b/meson.build
@@ -55,7 +55,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
-  'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm64']
+  'aarch64', 'loongarch64', 'sparc64', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -5036,14 +5036,6 @@ if host_arch == 'unknown'
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


