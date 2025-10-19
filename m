Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B09CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY9A-0005BZ-I5; Sun, 19 Oct 2025 14:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY97-0005A3-Dj
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:45 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY94-0000a5-V0
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:45 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so2186584a12.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898521; x=1761503321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+6QxrQ2Grf7WmLsUxgCW2QmJGtF5cs8k5PSTxarhNg=;
 b=KoSmEnLWQ9VlySBJAJryIB/1S4/D7/jMa3wgxXE7R3OuqO0qRdFJ3GsMkZR//QiBvc
 BgIo6cF33twAuggpXBkscatUmd1Muec33ENnlZ6MNYJzVnTL0gHQF9s6XKJVAg8lNZuh
 XpKjr6oDrF97SKvvVr+EeLRSSJAokCG6U3JuKP6fh4ov2vDxX10NuhwMp116Asv4034l
 M8zBSCuPi1J2RDUOObw2330Wi5ljg69KHRXgerY2PZ3FOE/33pQ0fwDyYhKAxyYDYuNN
 nOIB+2RnM2S+aINL/F5a4EcHYjncUYEekcUd2uBCrxhKbIC73nWXQia402IuDB8JMBwj
 o60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898521; x=1761503321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+6QxrQ2Grf7WmLsUxgCW2QmJGtF5cs8k5PSTxarhNg=;
 b=vT1Ki0jheLSZvJmVHwshSU8C/yYQGiClNAHAzYKvhru52hpyBVsvHo37j4PBk88Yhs
 GQNO1gaf8dc4tDetRszt1ho1ZQ3akzx0w3qlNrPUcL8tZgmWVHGd8lMyvAJXswmLnZ5C
 ubVMNG9WOn/3FNBZ4KXG726LDuebLw2ZA8lpyR+fq472DnGDlH+YoomRm/zaNOfX2wIx
 QNlbnh8zfpdd18XJKI83aP600yAFk2A1w9sQ40mrTbuSv+5Hs4IOjyIvk1rCCobC7T1P
 s4cwBwnO32NyM90Up1Sax5LoOVpffCLK4SuYNL9RIlT/G97YjPKkhCj6IGjfsHRciIt/
 T4ng==
X-Gm-Message-State: AOJu0Yz5cTece3sCcu9XFprbKwyCOJTI+cz5CGFzQ6HPzL3UMnSfkBzA
 1L/Ys48LoVND4ari+E0PCmnDHBvpG00NxyNO8IxO/xPK2HQLdxLjrLMoGTxFlZR4jES44swAnkV
 rBMoHqZ0=
X-Gm-Gg: ASbGncs70fT3a07AtWQPr607NvELdfyNcv9no7urIQDCCwohORZ7ELmESjJ+IBa9Y0U
 DLcMNtAYOehGPFpOueVRs+2o6lPev5GGH/JHf4liC+loGgS46oePSYv9Fw0r2nwtFTxwa3rFjCX
 BtMpx0mJyxHSCUPxoZvbgker7LR01e60Wm0P4LFSewtUX5MMbJoMZzg5g+5dF2a3AYppw8IcsfO
 pY0ZgkwMOOstg8FwYfeckZnHKAzZa0KTtw+wgjYZA+jL3llB5ni23TxJP9eieAkSqqfut3ZlOZ/
 GQqSXEnRY/kmtfHBxFDoNY2/QQX0WaIug9U4kCiBHi3qbWpWKvVx4Kxsvelarvl7DuzIs1JXJ1k
 QbfyXFSc5DD3i5ov1JkBXm+sJq0004OYM203o9hNce3IYq2bUdskqcCCAvRSrISS9L6Q6kKbSEw
 7ikG1eUtkSQUpVv9wt
X-Google-Smtp-Source: AGHT+IHeltuXUntrSR8pI7fDhXAnJinTVYbyajvNUaB6HGYn8fcg7XnlrL347RJIwtLnOX/FkbHJfw==
X-Received: by 2002:a17:902:db11:b0:28e:a70f:e879 with SMTP id
 d9443c01a7336-290c9c8cc5bmr145108855ad.1.1760898520999; 
 Sun, 19 Oct 2025 11:28:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 7/9] buildsys: Remove support for 32-bit PPC hosts
Date: Sun, 19 Oct 2025 11:28:32 -0700
Message-ID: <20251019182834.481541-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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


