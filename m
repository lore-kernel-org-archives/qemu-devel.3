Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE60CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nNT-0004q2-3d; Fri, 17 Oct 2025 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNQ-0004pO-Mc
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:24 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNH-0001CD-Hv
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:24 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b5579235200so1342902a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760718733; x=1761323533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+6QxrQ2Grf7WmLsUxgCW2QmJGtF5cs8k5PSTxarhNg=;
 b=pK5WD73JxeGXke8DeVopapGTOQZI2Hw4EiETb7mSnzcJ8k2NHpBIWu0xFFGHMecM8/
 dcZFM2ZoXCRgaaJvGfbwcVqcG5gF24BZN9ro+javJOZde90FooBnnvlodZr+DQ4ldFWJ
 GWg7JBBFfGYl/t9hMrDBJ4grAR2TK5tTqny6tLDu2bTxlPfK/BXfUvRjDkVotGurE6Ha
 OYsOenPnnYorKHs4TkZrmRdgNkeR1+OyptK81oNztvwIQiynhJ2EFn92JIwdD0k8FkeW
 IP5wcTHXi12Lv52zIZFuAui2Q++Tw2278OjhEWqHCsMyLB2tk+OtInVtHVzPl0e4ilKN
 Zu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760718733; x=1761323533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+6QxrQ2Grf7WmLsUxgCW2QmJGtF5cs8k5PSTxarhNg=;
 b=o99iDDpjhZooX70xqCeiVDDlLdMKWDSBbG+HnFeaW08R42YKd4M1ztbsW9aajA5CDK
 fsGyvtcC3uV8IjbDqLU+BUK59PR9E3rul92RnazCxt9w/YclNKagcLy7bH837K90GhIq
 YYYXGElXf/mAnhr7efFY1QOavDF/Ic/24Z+qJsXQsvHKGkrKZuwJh3l7im8IRnNnrlGW
 oCXd7sXbOmIYGp/hfqwEVtkEooDCtxqw9c4tVHl8DkF90OaEGsRTnJgOErfBJoaqGXXR
 WexPRHp9wGAAZPHBdATywj381U7p53Nsmh8ZculZYkhfhiQRPrImljs3XKkTNdtzckyT
 5IUA==
X-Gm-Message-State: AOJu0YwDFFvSdzOsdeWOi+OOSWuE7M/vxm1pxEfixQtjtnmJ0xwm2csu
 7YYaZxEJmR+BI1GSmy9Vkrv51WOj8xjFVQtCCFbI1/1zSk/hVrVEMQXqrqcYIeRN2kzeMkeUhlh
 9HUBUVlg=
X-Gm-Gg: ASbGncsxiqee8OZkxT+gqwUc05/QM6A22GxayxjNFaW5eg52M1lY7y5/EYQlkK0LLg3
 bufG/NF5g5MLteoFZ7MNAIfb8Psv0oPrX4TRLPPPI3tXwzNuYSiSWaHN0P8r5U9b8+AY6jMvM6P
 fDDvrIwdsoQ28/J56VSfCUKu30eZSuP3mxlVqwoVGEn2nt+rwXJ1smzx+cfgLoZvuajSVOuCJYc
 kM8bIyUVjsq1spcjdEHS5m9uRmhvX5YgziQAQff9xGVqdUKlpeO9BT8zcQyF3LlPIbZZNUvrHW5
 O4rhvbUqUqn31N1f2X6e0KDRRAVI6iUXY3UUtNFfPPOD6CI9SWFdZdPKxJYMy5EMU/BecybAeWg
 2y/yQaqGC/q0rdwZy+CaFSOj4CNoUHLY4/QzvXNh8UQwsoqdjq3gGgZ8ATAUzDm6d0dyssU3ItL
 PWYjZtVuanua2vy7Dr
X-Google-Smtp-Source: AGHT+IHjO1SHOqiJmGu6zQXNfaaKRF9sLcyHK7HrWaHrKVr2QNLhBDd193tOMKz3vZIgQX/VT7XgAA==
X-Received: by 2002:a17:903:3c24:b0:24c:6125:390a with SMTP id
 d9443c01a7336-290c9c8c7cdmr40367215ad.10.1760718733160; 
 Fri, 17 Oct 2025 09:32:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm68667715ad.65.2025.10.17.09.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 7/9] buildsys: Remove support for 32-bit PPC hosts
Date: Fri, 17 Oct 2025 09:32:04 -0700
Message-ID: <20251017163206.344542-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017163206.344542-1-richard.henderson@linaro.org>
References: <20251017163206.344542-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Stop detecting 32-bit PPC host as supported.
See previous commit for rationale.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[rth: Retain _ARCH_PPC64 check in udiv_qrnnd]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251014173900.87497-4-philmd@linaro.org>
---
 include/qemu/timer.h | 13 +------------
 disas/disas-host.c   |  4 +---
 util/cacheflush.c    |  4 ++--
 configure            | 19 +++++--------------
 4 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index aec730ac25..406d741120 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -850,12 +850,11 @@ static inline int64_t get_clock(void)
 /*******************************************/
 /* host CPU ticks (if available) */
 
-#if defined(_ARCH_PPC)
+#if defined(_ARCH_PPC64)
 
 static inline int64_t cpu_get_host_ticks(void)
 {
     int64_t retval;
-#ifdef _ARCH_PPC64
     /* This reads timebase in one 64bit go and includes Cell workaround from:
        http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027052.html
     */
@@ -863,16 +862,6 @@ static inline int64_t cpu_get_host_ticks(void)
                           "cmpwi   %0,0\n\t"
                           "beq-    $-8"
                           : "=r" (retval));
-#else
-    /* http://ozlabs.org/pipermail/linuxppc-dev/1999-October/003889.html */
-    unsigned long junk;
-    __asm__ __volatile__ ("mfspr   %1,269\n\t"  /* mftbu */
-                          "mfspr   %L0,268\n\t" /* mftb */
-                          "mfspr   %0,269\n\t"  /* mftbu */
-                          "cmpw    %0,%1\n\t"
-                          "bne     $-16"
-                          : "=r" (retval), "=r" (junk));
-#endif
     return retval;
 }
 
diff --git a/disas/disas-host.c b/disas/disas-host.c
index 8146fafe80..4b06f41fa6 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -56,11 +56,9 @@ static void initialize_debug_host(CPUDebug *s)
     s->info.cap_mode = CS_MODE_64;
     s->info.cap_insn_unit = 1;
     s->info.cap_insn_split = 8;
-#elif defined(_ARCH_PPC)
+#elif defined(_ARCH_PPC64)
     s->info.cap_arch = CS_ARCH_PPC;
-# ifdef _ARCH_PPC64
     s->info.cap_mode = CS_MODE_64;
-# endif
 #elif defined(__riscv)
 #if defined(_ILP32) || (__riscv_xlen == 32)
     s->info.print_insn = print_insn_riscv32;
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 17c58918de..69c9614e2c 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -153,7 +153,7 @@ static void arch_cache_info(int *isize, int *dsize)
     }
 }
 
-#elif defined(_ARCH_PPC) && defined(__linux__)
+#elif defined(_ARCH_PPC64) && defined(__linux__)
 # include "elf.h"
 
 static void arch_cache_info(int *isize, int *dsize)
@@ -187,7 +187,7 @@ static void fallback_cache_info(int *isize, int *dsize)
     } else if (*dsize) {
         *isize = *dsize;
     } else {
-#if defined(_ARCH_PPC)
+#if defined(_ARCH_PPC64)
         /*
          * For PPC, we're going to use the cache sizes computed for
          * flush_idcache_range.  Which means that we must use the
diff --git a/configure b/configure
index 8263f81370..a2f66f7ff9 100755
--- a/configure
+++ b/configure
@@ -391,15 +391,11 @@ elif check_define __sparc__ ; then
   else
     cpu="sparc"
   fi
-elif check_define _ARCH_PPC ; then
-  if check_define _ARCH_PPC64 ; then
-    if check_define _LITTLE_ENDIAN ; then
-      cpu="ppc64le"
-    else
-      cpu="ppc64"
-    fi
+elif check_define _ARCH_PPC64 ; then
+  if check_define _LITTLE_ENDIAN ; then
+    cpu="ppc64le"
   else
-    cpu="ppc"
+    cpu="ppc64"
   fi
 elif check_define __mips__ ; then
   if check_define __mips64 ; then
@@ -472,11 +468,6 @@ case "$cpu" in
     linux_arch=mips
     ;;
 
-  ppc)
-    host_arch=ppc
-    linux_arch=powerpc
-    CPU_CFLAGS="-m32"
-    ;;
   ppc64)
     host_arch=ppc64
     linux_arch=powerpc
@@ -1471,7 +1462,7 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
-      ppc|ppc64|ppc64le)
+      ppc64|ppc64le)
         container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
-- 
2.43.0


