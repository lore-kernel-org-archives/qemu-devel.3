Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F9EC2BD09
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 02:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLCZf-0007lN-GU; Sat, 22 Jun 2024 22:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sLCZd-0007l9-Gq
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 22:03:21 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sLCZc-0001YI-33
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 22:03:21 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W6Drn0RQJz8PbQ;
 Sat, 22 Jun 2024 22:03:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=dWz0+NkkccG2mzLfUrSg8aCoXIOWm2XKYd58Nbjz0dk=; b=pkLI
 fpPnMzS3jTpUIvr3mSnZhwjHJ7SmAnYtl0wgPStoWDQgxZTG419TqSVFqoHuakAy
 VBDpS+KR63NNhxEN+uOEhiNj9pvR4pMtKH3Sydp6Rm5LNdpYsdlB9CMX9jZ/Pn84
 jpSwkXul0PuaQzr6fMccqD4wZPBebcWmvGpa/1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=oV2fgfCHjHFV7mevOf2ljUSvjK56v74wlubY83VFN15gt27uEZK/e
 lnUS6y/HEUsHsxXfrR1dWr8ZxcQOYMaPW7CftIFKkMKakRBmP7tMeVGoIkmRyRai
 F19tcsnbKsM49zhYW7IjtIj3PWx3f9p0FMSiVIM8MNArYVQT0dxzBM=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:9ee5:c2f5:b033:d60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W6Drm6jnLz8PbP;
 Sat, 22 Jun 2024 22:03:04 -0400 (EDT)
Date: Sat, 22 Jun 2024 22:03:03 -0400
From: Brad Smith <brad@comstyle.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util: fix building on OpenBSD/powerpc
Message-ID: <ZneCVxqGDjKpa5Jp@humpty.home.comstyle.com>
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

util: fix building on OpenBSD/powerpc

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 util/cpuinfo-ppc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index b2d8893a06..d459c9c87e 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -6,11 +6,13 @@
 #include "qemu/osdep.h"
 #include "host/cpuinfo.h"
 
-#include <asm/cputable.h>
-#ifdef CONFIG_GETAUXVAL
-# include <sys/auxv.h>
-#else
-# include "elf.h"
+#ifdef CONFIG_LINUX
+# ifdef CONFIG_GETAUXVAL
+#  include <sys/auxv.h>
+# else
+#  include <asm/cputable.h>
+#  include "elf.h"
+# endif
 #endif
 
 unsigned cpuinfo;
@@ -19,16 +21,17 @@ unsigned cpuinfo;
 unsigned __attribute__((constructor)) cpuinfo_init(void)
 {
     unsigned info = cpuinfo;
-    unsigned long hwcap, hwcap2;
 
     if (info) {
         return info;
     }
 
-    hwcap = qemu_getauxval(AT_HWCAP);
-    hwcap2 = qemu_getauxval(AT_HWCAP2);
     info = CPUINFO_ALWAYS;
 
+#ifdef CONFIG_LINUX
+    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+    unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
+
     /* Version numbers are monotonic, and so imply all lower versions. */
     if (hwcap2 & PPC_FEATURE2_ARCH_3_1) {
         info |= CPUINFO_V3_1 | CPUINFO_V3_0 | CPUINFO_V2_07 | CPUINFO_V2_06;
@@ -58,6 +61,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             }
         }
     }
+#endif
 
     cpuinfo = info;
     return info;
-- 
2.45.2


