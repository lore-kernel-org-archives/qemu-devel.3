Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0E9C4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmbsz-0004TR-J0; Wed, 22 Jul 2026 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsk-0004Mu-EC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:30 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsh-0006NU-QQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:26 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso6111194a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784745682; x=1785350482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1iV4cfKmJ85SbIeZG946KmTHF9GXveJIAMOLWNKJw6s=;
 b=FVLXx7sXgaZbz0eX7s/pex54wb5FZa3b6ulp8uVhVJE6Tup3qbesKlz66iLd8SuULF
 ghLuI+wwWQLDuQT6JwxoQGNrNe9X9UC93Guf8NUucikDOXlxrMrVpqnnsZnOOJ2DrVXx
 1hqL79uYvTcwhrBH832C70zrffBoPU0c441xhZzctSI73oUgbyh+lXA7If8zSzMxFYdQ
 OohWhfqSAgts1cH2LMHyc1owxrlYnq/kQkEtduMleV/PAToUeqKB1a8czQMpe7A4gYaW
 e+XutmRHj3QeUvtiPNODK2qLjcfAsmWomnhCJ5SbNbyfBEizp69pwWL4p7yNSNPp18fB
 Q1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745682; x=1785350482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1iV4cfKmJ85SbIeZG946KmTHF9GXveJIAMOLWNKJw6s=;
 b=TBEeExm/lQgMl7AchvwquyXg1X6Sr3yMQvZxPwOSKwR2CbN7jO6qbgvjzi7mPKABOG
 tWgBILBNKHI5OK4rs3gGpmFHuGgfZk8Qmkn11vdl5+f3fZNg8+QcpcBKIjsITVZ17smb
 3BY4jbHmb6ME8iHPc1dZ0fuShYk7d6kcbyod1L5fTkuXeC+r9pTNSANCDk/klWSxHUYy
 6nF2W6q2vhkVtg/fT1oqcwF3Y8HczFD5BAKpmcntbD3PuVSCQwBl3hUmPT860s30gezd
 AFTIo74xicaKXS388D4m4cMkSoGg0rTJwmclFiJlT3N/UAA4/yE0MaAC4PN00+ZnUWKH
 BEag==
X-Gm-Message-State: AOJu0YyVmz3bIkGMr6o1X1Jln/4nnQUe1vePFqmiq2GlajGxyDSKEsfu
 oRHlBLURvvvtqFuFjxcPJjHW5YJCrM1ET5Gkj9W1zOnIGwItjQMZJhIh4CgdGAS6vt9GH3jPFR+
 N1UdU
X-Gm-Gg: AR+sD11jfIfwvGL+9JD1lvhJVEn3exLRjw+nSYVOuJeEY0sEGFNW/n80EccNowG3L6B
 CtBVYgbpXj4tXFKPx8hA7cdho2kgy1XQCca44hDICukb2LsFPhO5kqa6VBxiiQP6qnuzG320/3u
 acqhaWSEFCympgnbtzuJjJ2KC+Y9HJw0KEOwemzFfco5dok5yKZR/DPZSMh42rCOzl++iLx1Bqj
 0BrAENZwqX+Rt4OKHwYve8t90c1SQwNxNq3Xm00lA3HvXhNhLUdqkrbNFzhhjRj5SuNO8Ule/wo
 E/0En0XK0QZfg/dd0uaAzrmL+iLNJOVXc+bQ4v9JUQ1rHayQ7SDMUxFDjT9GEkrbK4WjajRUqNQ
 10QKLYFkrMkr7V3G1mw6pTJ6gq/h/Iv/MKXboY+lgF/5cpZOE6e0+d59HzOQVInVEigwhcRBoU3
 EOc491aGiMiHhqI7Emh3OYxQK3zU7eicz5Eweyo85tCnt+tM33d2jL4k1/z4A11rP3/GbHOB1U
X-Received: by 2002:a17:90a:d886:b0:37f:9cdf:f03c with SMTP id
 98e67ed59e1d1-38e4b54082emr22950740a91.31.1784745682195; 
 Wed, 22 Jul 2026 11:41:22 -0700 (PDT)
Received: from stoup.. (162-198-231-97.lightspeed.wlfrct.sbcglobal.net.
 [162.198.231.97]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13015052sm8559298c88.5.2026.07.22.11.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:41:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 3/3] host/aarch64: Implement atomic64_{read,
 set} with FEAT_LS64
Date: Wed, 22 Jul 2026 11:41:17 -0700
Message-ID: <20260722184117.11937-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722184117.11937-1-richard.henderson@linaro.org>
References: <20260722184117.11937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Detect the host feature in cpuid, then use it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h           |  1 +
 include/qemu/value64.h                        |  7 ++++
 util/cpuinfo-aarch64.c                        | 14 ++++++--
 .../include/aarch64/host/atomic512-ldst.h.inc | 36 +++++++++++++++++++
 meson.build                                   |  8 +++++
 5 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 host/include/aarch64/host/atomic512-ldst.h.inc

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index fe671534e4..ac3a224fc3 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -12,6 +12,7 @@
 #define CPUINFO_AES             (1u << 3)
 #define CPUINFO_PMULL           (1u << 4)
 #define CPUINFO_BTI             (1u << 5)
+#define CPUINFO_LS64            (1u << 6)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/include/qemu/value64.h b/include/qemu/value64.h
index 7de287a13d..b74316bf82 100644
--- a/include/qemu/value64.h
+++ b/include/qemu/value64.h
@@ -3,12 +3,19 @@
 #ifndef QEMU_VALUE64_H
 #define QEMU_VALUE64_H
 
+#ifdef __aarch64__
+#include <arm_acle.h>
+#endif
+
 /*
  * An stream of 64 bytes; no endianness implied.
  * The members are perforce host byte ordering.
  */
 typedef union {
     uint64_t l[8];
+#ifdef __aarch64__
+    data512_t arm;
+#endif
 } Value64;
 
 #endif /* QEMU_VALUE64_H */
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 288074c08f..0a01050626 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -13,9 +13,6 @@
 #  include <asm/hwcap.h>
 #  include "elf.h"
 # endif
-# ifndef HWCAP2_BTI
-#  define HWCAP2_BTI 0  /* added in glibc 2.32 */
-# endif
 #endif
 #ifdef CONFIG_ELF_AUX_INFO
 #include <sys/auxv.h>
@@ -29,6 +26,13 @@
 # include <sys/sysctl.h>
 #endif
 
+#ifndef HWCAP2_BTI
+# define HWCAP2_BTI 0  /* added in glibc 2.32 */
+#endif
+#ifndef HWCAP3_LS64
+# define HWCAP3_LS64 0 /* added in glibc 2.44 */
+#endif
+
 unsigned cpuinfo;
 
 #ifdef CONFIG_DARWIN
@@ -72,6 +76,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
     info |= (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
+
+    unsigned long hwcap3 = qemu_getauxval(AT_HWCAP3);
+    info |= (hwcap3 & HWCAP3_LS64 ? CPUINFO_LS64 : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
@@ -79,6 +86,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_LS64") * CPUINFO_LS64;
 #endif
 #if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
     int mib[2];
diff --git a/host/include/aarch64/host/atomic512-ldst.h.inc b/host/include/aarch64/host/atomic512-ldst.h.inc
new file mode 100644
index 0000000000..a254560be7
--- /dev/null
+++ b/host/include/aarch64/host/atomic512-ldst.h.inc
@@ -0,0 +1,36 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 512-bit atomic operations, AArch64 version.
+ */
+
+#ifndef HOST_ATOMIC512_LDST_H
+#define HOST_ATOMIC512_LDST_H
+
+#ifdef CONFIG_ARM_LS64_BUILTIN
+#include "host/cpuinfo.h"
+#include <arm_acle.h>
+
+#ifdef __ARM_FEATURE_LS64
+# define HAVE_ATOMIC512_LD  true
+# define ATTR_LS64_ACCEL
+#else
+# define HAVE_ATOMIC512_LD  likely(cpuinfo & CPUINFO_LS64)
+# define ATTR_LS64_ACCEL  __attribute__((target("+ls64")))
+#endif
+#define HAVE_ATOMIC512_ST   HAVE_ATOMIC512_LD
+
+static inline Value64 ATTR_LS64_ACCEL atomic64_read(const void *s)
+{
+    return (Value64){ .arm = __arm_ld64b(s) };
+}
+
+static inline void ATTR_LS64_ACCEL atomic64_set(void *d, const Value64 *v)
+{
+    __arm_st64b(d, v->arm);
+}
+
+#else
+#include "host/include/generic/host/atomic512-ldst.h.inc"
+#endif
+
+#endif /* HOST_ATOMIC512_LDST_H */
diff --git a/meson.build b/meson.build
index 164328ded8..5afeda83fd 100644
--- a/meson.build
+++ b/meson.build
@@ -3106,6 +3106,14 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
   '''))
 
+config_host_data.set('CONFIG_ARM_LS64_BUILTIN', cc.compiles('''
+    #include <arm_acle.h>
+    #ifndef __ARM_FEATURE_LS64
+    __attribute__((target("+ls64")))
+    #endif
+    void foo(void *p, void *q) { __arm_st64b(q, __arm_ld64b(p)); }
+  '''))
+
 if get_option('membarrier').disabled()
   have_membarrier = false
 elif host_os == 'windows'
-- 
2.43.0


