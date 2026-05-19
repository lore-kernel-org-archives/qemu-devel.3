Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE42CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLuU-0003bR-Ub; Tue, 19 May 2026 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLuT-0003aq-B0
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:59:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLuR-00021t-Ic
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:59:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so24281745e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779202741; x=1779807541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SZelGvEgEEvg0CCXVNGBslj4QJmWf6JnvfcIYGqOwQo=;
 b=aWT4rgyoGj6M0vIbRsf+oNSiiG/ef8C9MTbZPUI9xK+3C0Nzl5BJDWGRpNUcVaydMg
 TQc8Ydokt9+KVsO336b+yud77fr7oZtd7e1qBQsJAKAun8j/TqAjrP3cAiUZimxn8xzv
 jeh5ubwZUEgJoITdDIPIq6BvKX5zXJY0HKR5/6scfEU/86sSI4Uh3eu05n8i+FeSkeTH
 NEFJD7HjhQAYM1vvsnQEI2wKghzraXGmUbiOE2xIKsiMGqHs3gv2teCvJnsX3uuhx/2d
 /hW4H6GGtbF0NBAjll75Pxc9d0TMEixS9GENzTVEo6jocUL0eKRpREkwlXVCrTQAsKDV
 TPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202741; x=1779807541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZelGvEgEEvg0CCXVNGBslj4QJmWf6JnvfcIYGqOwQo=;
 b=rb2HEyg/pYZJDoMEqzeYWx0ePo9hiJ9WsZRkXy/881ws2gIo7j83zlzO1w2XSAKc5b
 hUyZkliCyMtL91LAVmV01GesqWTz7MOViqpbwhTywXNKe/Bk2wIrW0u4FPp388ojHK2f
 altKNWTI2GEIQY9btLqdxVY/9w6dBFZLPEdGvXs+AnTYi59K95OUrywkLcj+DjLjvF6k
 5Jv2N1wMKU4ncZgU6s6xYpitGax4+82RTzOgDLpIXdg9OhLlDfbjo68Fg2dLGn6Zpv47
 oUQNVoFBlDo5b0cq2G4ekqEMt0ZGsG2JRxVvxEA1TicPxwrs/OxCxrTKUl0P03z/y5HN
 SvyA==
X-Gm-Message-State: AOJu0Yyv6+RsauqyxUud95Kr2Cg96xSPyszIzxx1GHOiK6XTDNE0UrzF
 W2ILHyaTdfRf8d7234EXy+ZXEeHRN1yxRg9J9yKxwPz9HN7VqvtUdfvM3owUT09kIQp6p4R9DYk
 JJfME2ak=
X-Gm-Gg: Acq92OEj0TMRcB+SLBmVB0M5Fo56q4A19hgYYn1jY7y/hfi9gW0zYUwPRo1z+CI0PVJ
 gYNy2NzZTYrmxCZ+TQF9B995Qw/SefUjm/501C4J+ww4AyjJ9APj0c2QYHCPn8k+UleByVb/Kwy
 X17cnEEtwQhn+SlHiHSCRR4o3QEnORRMAntD243XZAUrcMyrtkumE6jONbLgLnpdMOjdQEPWEPy
 IFgwWB0MfhG3iRzQsrXO8Ymw4dlHUDuuPmATprFpJK3gODOK0oXxZY/rcAQ3IFqjV5Yp1zyYjhG
 hAT4B6sKtoeCbMWxbndUUMddQ5aoD8CqEj56vIol/PAB7FlFMjvBqvc5hwzqZRZieveniJ3cltr
 yvm254YMsYityCsvR7og3d7llw3uUL6WlYdlkV3V0Wa0ZxGR4yJ+0Rq1+1aH06Ws5n75ZMaMGgt
 IyQwW4QoEqoOetmL01GmVA9eLbUPouOidO9wxICHebBT17m1RTrlbKqM8FFcMypTxPHHhfKNZUj
 7GRF8zyAN0=
X-Received: by 2002:a05:600c:5296:b0:490:31e:d6f4 with SMTP id
 5b1f17b1804b1-490031ed905mr193136935e9.18.1779202741515; 
 Tue, 19 May 2026 07:59:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab3977sm362148885e9.9.2026.05.19.07.59.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:59:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] buildsys: Stop checking for ESA/390 host
Date: Tue, 19 May 2026 16:58:59 +0200
Message-ID: <20260519145859.91999-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We still build QEMU tools on 32-bit hosts (see commit
cf634dfcd8f), however no OS supported by QEMU still runs
on ESA/390 (Linux dropped support in release 4.1 in 2015).

Remove the configure check, directly checking for the 64-bit
z/Architecture.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                      | 12 ++----------
 include/qemu/cacheflush.h      |  2 +-
 include/qemu/timer.h           |  2 +-
 tests/tcg/multiarch/nop_func.h |  2 +-
 block/file-posix.c             |  2 +-
 disas/disas-host.c             |  2 +-
 util/cacheflush.c              |  2 +-
 7 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/configure b/configure
index eea90306728..513ef7a153d 100755
--- a/configure
+++ b/configure
@@ -401,12 +401,8 @@ elif check_define _ARCH_PPC64 ; then
   fi
 elif check_define __mips64 ; then
   cpu="mips64"
-elif check_define __s390__ ; then
-  if check_define __s390x__ ; then
-    cpu="s390x"
-  else
-    cpu="s390"
-  fi
+elif check_define __s390x__ ; then
+  cpu="s390x"
 elif check_define __riscv && check_define _LP64 ; then
   cpu="riscv64"
 elif check_define __aarch64__ ; then
@@ -469,10 +465,6 @@ case "$cpu" in
     linux_arch=riscv
     ;;
 
-  s390)
-    linux_arch=s390
-    CPU_CFLAGS="-m31"
-    ;;
   s390x)
     host_arch=s390x
     linux_arch=s390
diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index 8c64b878145..0618966ddde 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -19,7 +19,7 @@
  * mappings of the same physical page(s).
  */
 
-#if defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390x__)
 
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index b931181f53d..fc021f8f966 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -889,7 +889,7 @@ static inline int64_t cpu_get_host_ticks(void)
     return val;
 }
 
-#elif defined(__s390__)
+#elif defined(__s390x__)
 
 static inline int64_t cpu_get_host_ticks(void)
 {
diff --git a/tests/tcg/multiarch/nop_func.h b/tests/tcg/multiarch/nop_func.h
index f714d210000..26d3a76eb62 100644
--- a/tests/tcg/multiarch/nop_func.h
+++ b/tests/tcg/multiarch/nop_func.h
@@ -15,7 +15,7 @@ static const char nop_func[] = {
     0x1e, 0xff, 0x2f, 0xe1,     /* bx lr */
 #elif defined(__riscv)
     0x67, 0x80, 0x00, 0x00,     /* ret */
-#elif defined(__s390__)
+#elif defined(__s390x__)
     0x07, 0xfe,                 /* br %r14 */
 #elif defined(__i386__) || defined(__x86_64__)
     0xc3,                       /* ret */
diff --git a/block/file-posix.c b/block/file-posix.c
index e49b13d6abb..5019ddade9b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -79,7 +79,7 @@
 #include <linux/hdreg.h>
 #include <linux/magic.h>
 #include <scsi/sg.h>
-#ifdef __s390__
+#ifdef __s390x__
 #include <asm/dasd.h>
 #endif
 #ifndef FS_NOCOW_FL
diff --git a/disas/disas-host.c b/disas/disas-host.c
index 7cf432938e0..d41235250a0 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -74,7 +74,7 @@ static void initialize_debug_host(CPUDebug *s)
     s->info.print_insn = print_insn_little_mips;
 #elif defined(__m68k__)
     s->info.print_insn = print_insn_m68k;
-#elif defined(__s390__)
+#elif defined(__s390x__)
     s->info.cap_arch = CS_ARCH_SYSZ;
     s->info.cap_insn_unit = 2;
     s->info.cap_insn_split = 6;
diff --git a/util/cacheflush.c b/util/cacheflush.c
index c043c5f881a..77440ddb478 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -223,7 +223,7 @@ static void __attribute__((constructor)) init_cache_info(void)
  * Architecture (+ OS) specific cache flushing mechanisms.
  */
 
-#if defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390x__)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
-- 
2.53.0


