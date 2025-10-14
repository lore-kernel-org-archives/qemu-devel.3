Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94450CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8izc-0006hZ-6U; Tue, 14 Oct 2025 13:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8iza-0006gt-7k
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8izX-00023e-BY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so66252605e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760463557; x=1761068357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7vF0j4DV78yMBqROnTyJIaFNu0YV72na+d17JA/sVo=;
 b=NmHEEv6wS0mZrjK93WqoNod4GrX9vW1PygfiFVeRTQlmruflrKJLk6oVNJVqQHhUQd
 O8bEWZzBMTy44kxJGVQZhmHNyXvbsvYmjMEpLkY0Oe4IHAYHSuQH6z+M06cWTN56A8Ej
 pBVianQpnh6iOZu3i8qa8EimEqdT6XP6XW8AnWKIxWv1Lo/F9MGkQ+VefVVmQ3mOwrSB
 2CxOdA0e9neAUOOwF1+CIpk5pUXLScgrBIw8Dff6I0bgi2Hycb9tnFDEzme1zcJJuWYH
 DccIaapQ8lrSReWvNSAbfb/1Ww4Xs5lm23UDbtOWT8YRbEy1EemBKZAqL5RYgfO5yPgP
 Ftaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760463557; x=1761068357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7vF0j4DV78yMBqROnTyJIaFNu0YV72na+d17JA/sVo=;
 b=wA1LRVONqI2LvQxn7ndjOjuFc5SnM6MYNjxC3dF0MWBjZv32S6Tf3jbdB33wr/GYGt
 WhXXqoih2uB4zw9nODdq4jo0bv4VqLv32q8bxKciGHa0Id2gkodS8C7Wo/LYMyFm2kfh
 6JlnGqES3oHEKB9CHdNP2fsdqFtg8lGaPg7EW7hT7sckpWGKmTibIWH6nz+I1meIvSmA
 DLOtELshGrUl0UwVC2CSrUmQUti+dxfEBwsx/NZ45EOIhKWsAUXltkWrYL6tCELA5rg0
 Q/owkrdj95k9noEGcdO9UTTdoGayefYmzJYfOCuzMcBLcaNmphMrltUHm/08IyKiGIqs
 1URA==
X-Gm-Message-State: AOJu0YzeOVANHcB2aoyFIiK4BrQ0/qUKsnPJsdtBzWyjVPDLV3ydphZj
 9qNij6pr8l5S3AYGXd13f1/vQMkqHXcg+LB7kSExf/ASKO7dTjb7qrNMHkRqK34/ULuFlUD2EqI
 MM21CLIFC1Tke
X-Gm-Gg: ASbGncuMeCN/sCLvFjR2MuLeULh945ZgIJW82YPXrh8z77K4H27SaDdAnpJluQch+aK
 SAYnd1QKgLeBeMR0q7eICpDwA7ueoSd6D1QjIjauSgHbGIPoI9GGue7Xoikvvefc3kYlaDWJRGF
 zX9IrxcPd3rRKdJFMKhhCYiZ6PT7NF+79/Jo4IBLTG97lPJdgu/G8knSakYfkFL5iULp5sMZCcB
 oMExPsRMC+8sOllJm7TpM+tdYwfHHlL68wVQq2msbV8sAcMUM8uxz7pHyo6gSTbIRcooJM43Zdb
 mlDje6oHvzcsKEu0/sRvs8Rx+Cs6BpISo5WUd45DFr92M5ZNEOCl7xX5FSw6Sxz7H/dytaRYrL1
 wp+sDomblKaQdFV9CAI+Z53Ul3PfRSu8EEeaiPFSq1iT6bOeXgDNFUT8UQqAFhX1jFZsHpHiRwR
 R43G3/HNRx8tO9iYk0mZs=
X-Google-Smtp-Source: AGHT+IFjUVEp4jSXGxvQNlIsGu/N/ppNcV+o4bN3ZwnNyM2O47Pv4LdijWQR1zOlCR5X/8yUXanfcA==
X-Received: by 2002:a05:600c:4688:b0:46e:4372:5395 with SMTP id
 5b1f17b1804b1-46fa9b01ff5mr179218685e9.25.1760463557202; 
 Tue, 14 Oct 2025 10:39:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb479c171sm249133035e9.0.2025.10.14.10.39.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Oct 2025 10:39:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/3] buildsys: Remove support for 32-bit PPC hosts
Date: Tue, 14 Oct 2025 19:38:59 +0200
Message-ID: <20251014173900.87497-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014173900.87497-1-philmd@linaro.org>
References: <20251014173900.87497-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Stop detecting 32-bit PPC host as supported. See previous commit
for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                 | 12 ++----------
 include/qemu/host-utils.h |  2 +-
 include/qemu/timer.h      | 13 +------------
 disas/disas-host.c        |  4 +---
 util/cacheflush.c         |  4 ++--
 5 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/configure b/configure
index ce76a00aff1..8205c8df599 100755
--- a/configure
+++ b/configure
@@ -391,15 +391,12 @@ elif check_define __sparc__ ; then
   else
     cpu="sparc"
   fi
-elif check_define _ARCH_PPC ; then
-  if check_define _ARCH_PPC64 ; then
+elif check_define _ARCH_PPC64 ; then
     if check_define _LITTLE_ENDIAN ; then
       cpu="ppc64le"
     else
       cpu="ppc64"
     fi
-  else
-    cpu="ppc"
   fi
 elif check_define __mips__ ; then
   if check_define __mips64 ; then
@@ -479,11 +476,6 @@ case "$cpu" in
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
@@ -1477,7 +1469,7 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
-      ppc|ppc64|ppc64le)
+      ppc64|ppc64le)
         container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index dd558589cb5..22d440287f1 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -806,7 +806,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
     *r = n >> 64;
     return n;
-#elif defined(_ARCH_PPC64) && defined(_ARCH_PWR7)
+#elif defined(_ARCH_PWR7)
     /* From Power ISA 2.06, programming note for divdeu.  */
     uint64_t q1, q2, Q, r1, r2, R;
     asm("divdeu %0,%2,%4; divdu %1,%3,%4"
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index abd2204f3be..6c15acebbc0 100644
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
index 8146fafe804..4b06f41fa6c 100644
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
index 17c58918de6..69c9614e2c9 100644
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
-- 
2.51.0


