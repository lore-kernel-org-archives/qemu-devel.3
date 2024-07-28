Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77429C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 04:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXv46-0006gS-Ng; Sat, 27 Jul 2024 23:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sXv41-0006fE-1I
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 23:59:20 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sXv3z-0000yx-C6
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 23:59:16 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4WWnmM50r9z8PbP;
 Sat, 27 Jul 2024 23:58:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=eVauMf+K7gGcdYdycr2mjJhuLi0vC3VMCUEb9IJHDww=; b=j079
 b5zqrO2IS644mUT+Z0t/vrJI3B56zqm7Trahp+EUaJkCTcLl+kdSZVPvoOAxOwo6
 7YPsPKD/ihggo0aWDrmFnID2zULonVSalSrrf41Xnk9T7NneaoGDvvs4lPPZbXP5
 5PLDh7ux0uhivbyfrWZhUXd85/s4k6NIHqDcLjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=g8HA4LVK+/7OG9dwqlQtOYV6aLlvLuMgpDWGTwlJ3Nz4ZrDwcXA5H
 sZk+abZyTf9KI7GjHeoUZC18d11sNGfivK1abx/Tx4CGZvJKxcEdXI0u1ye6qRkE
 ptdEmb1eWn4I0kY96ytjMR/WEzndGtwQODcWViu64Wu+/2tC15a5Rc=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:53bc:6e1:d993:94e7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4WWnmL6kGYz8PbN;
 Sat, 27 Jul 2024 23:58:58 -0400 (EDT)
Date: Sat, 27 Jul 2024 23:58:55 -0400
From: Brad Smith <brad@comstyle.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
Message-ID: <ZqXB_zz0fR1CpA7k@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 meson.build            | 8 ++++++++
 util/cpuinfo-aarch64.c | 9 ++++++---
 util/cpuinfo-ppc.c     | 5 +++--
 util/getauxval.c       | 2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

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
index 1304f9aa80..ccfcaa0754 100644
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
+#if defined(CONFIG_LINUX) || deinfed(CONFIG_ELF_AUX_INFO)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
diff --git a/util/getauxval.c b/util/getauxval.c
index b124107d61..5bdbb04f8f 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -98,7 +98,7 @@ unsigned long qemu_getauxval(unsigned long type)
     return 0;
 }
 
-#elif defined(__FreeBSD__)
+#elif deinfed(CONFIG_ELF_AUX_INFO)
 #include <sys/auxv.h>
 
 unsigned long qemu_getauxval(unsigned long type)
-- 
2.45.2


