Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F21BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcYW-0007S1-4U; Mon, 29 Jul 2024 22:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcYT-0007OP-3h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:25:38 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcYR-0007U6-BY
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:25:36 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5e1c86b83so1443039eaf.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306334; x=1722911134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2wtDHUY+HHrfRWzkSo3Bk34wWAfi1Yqji+v1/RaSkc=;
 b=JyG5lpzK8Fx3c8ZzS38saCfzuw4XepZ5xv32R8KrA8wcykE90EkTtv3Tt0XiAgEJHq
 s2vo+1IB8U1v6j1X1DpjkQgmy6EJwfI321ekTpPqP5/n5PaM5aNlJvvAcwnhQoJsWWD5
 TRGLIqYY6WmJ8VQHp0sQ5PHmTYABAophEq1RvzNLnGxSIDSTpWCiUxmMpSneAi+22WkV
 vYvzGLD6+ac42wddIAbsLaPs4cg/lmQV0bj53ycBdU8EJa7SZd2f9hNaZNFPOUZd5Ra6
 E4U6U8I1bV0YtePox/2KCNhvbWNLG+WTBXRNU3Vnq9xBP8LWWWdrkKjtfsJxL45TPpLU
 VUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306334; x=1722911134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2wtDHUY+HHrfRWzkSo3Bk34wWAfi1Yqji+v1/RaSkc=;
 b=nQyeemPqQdb+aGO7aVFaz6u+2iJ6krvNwV7VcHcG4zx/jtpIia7tiPKVo1ka30pXgD
 m1f2Q9AQKAstINYgT5rZuowBCeAyUJ110UE2eB76xp9Isww7Ylllo+3cxq2tn58tVFTR
 5WYxJ26oeOB9LMvFmhv7sSq6IoaKrpSfrDffeF2FMozsVE4+lvTmWxbYpxbtCI6JoC8k
 o2Li6uTwn29XTArnn59GnPjFJes/yrrmt9EOhKRTnjHqQkl/zO3+nMYcsSsolh96pxm7
 Is6H4ToNa0BlII/PsNER3gnk56CmQ6KPDvVgLU5iDtzAyAjQ0UPM4cHAOx4LXC+QxpSN
 5b5g==
X-Gm-Message-State: AOJu0Yw5X5DZcGvrV/0Hr/t2T+8jAPOKonFQJTTZDMAI9q7LXnE7IEa3
 jfDWNYc97w0rWEY+ceqa71pu3fErKU1fswfjIz7AoETcteKPnhXFK0bJfvjJ5iIMeXd3hX6JhcB
 drdg=
X-Google-Smtp-Source: AGHT+IHomwBW++cs9aOrDRrwgEbGxLkTpk6KKS+Upl+WfQ4f2xgaz2sRFWS8NxCihdSys9OEjz8d2A==
X-Received: by 2002:a05:6870:b28e:b0:261:f4c:e08c with SMTP id
 586e51a60fabf-267d4dd3eb0mr11718340fac.29.1722301939544; 
 Mon, 29 Jul 2024 18:12:19 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6ff4bsm6750206a12.4.2024.07.29.18.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 18:12:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>
Subject: [PULL 4/5] util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
Date: Tue, 30 Jul 2024 11:12:01 +1000
Message-ID: <20240730011202.480829-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730011202.480829-1-richard.henderson@linaro.org>
References: <20240730011202.480829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

From: Brad Smith <brad@comstyle.com>

Signed-off-by: Brad Smith <brad@comstyle.com>
Message-ID: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/cpuinfo-aarch64.c | 9 ++++++---
 util/cpuinfo-ppc.c     | 5 +++--
 util/getauxval.c       | 2 +-
 meson.build            | 8 ++++++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 8ca775a14b..57468890c3 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -17,10 +17,13 @@
 #  define HWCAP2_BTI 0  /* added in glibc 2.32 */
 # endif
 #endif
+#ifdef CONFIG_ELF_AUX_INFO
+#include <sys/auxv.h>
+#endif
 #ifdef CONFIG_DARWIN
 # include <sys/sysctl.h>
 #endif
-#ifdef __OpenBSD__
+#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
 # include <machine/armreg.h>
 # include <machine/cpu.h>
 # include <sys/types.h>
@@ -61,7 +64,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     info = CPUINFO_ALWAYS;
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(CONFIG_ELF_AUX_INFO)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
@@ -78,7 +81,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
 #endif
-#ifdef __OpenBSD__
+#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
     int mib[2];
     uint64_t isar0;
     uint64_t pfr1;
diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 1304f9aa80..4d3d3aae0b 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -14,7 +14,8 @@
 #  include "elf.h"
 # endif
 #endif
-#ifdef __FreeBSD__
+#if defined(CONFIG_ELF_AUX_INFO)
+# include <sys/auxv.h>
 # include <machine/cpu.h>
 # ifndef PPC_FEATURE2_ARCH_3_1
 #  define PPC_FEATURE2_ARCH_3_1   0
@@ -35,7 +36,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     info = CPUINFO_ALWAYS;
 
-#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
+#if defined(CONFIG_LINUX) || defined(CONFIG_ELF_AUX_INFO)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
diff --git a/util/getauxval.c b/util/getauxval.c
index ad4f6686a8..0735cd8271 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -99,7 +99,7 @@ unsigned long qemu_getauxval(unsigned long type)
     return 0;
 }
 
-#elif defined(__FreeBSD__)
+#elif defined(CONFIG_ELF_AUX_INFO)
 #include <sys/auxv.h>
 
 unsigned long qemu_getauxval(unsigned long type)
diff --git a/meson.build b/meson.build
index 5613b62a4f..97f63aa86c 100644
--- a/meson.build
+++ b/meson.build
@@ -2835,6 +2835,14 @@ config_host_data.set('CONFIG_GETAUXVAL', cc.links(gnu_source_prefix + '''
     return getauxval(AT_HWCAP) == 0;
   }'''))
 
+config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(gnu_source_prefix + '''
+  #include <sys/auxv.h>
+  int main(void) {
+    unsigned long hwcap = 0;
+    elf_aux_info(AT_HWCAP, &hwcap, sizeof(hwcap));
+    return hwcap;
+  }'''))
+
 config_host_data.set('CONFIG_USBFS', have_linux_user and cc.compiles('''
   #include <linux/usbdevice_fs.h>
 
-- 
2.43.0


