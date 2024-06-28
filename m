Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B24C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 02:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN0uH-0006c3-5O; Thu, 27 Jun 2024 22:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sN0uE-0006aW-M8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 22:00:06 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sN0uC-0002D6-RB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 22:00:06 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W9JXz0yqsz8PbP;
 Thu, 27 Jun 2024 22:00:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=57jHEWmlqqEUsR4+CPDJ7U+k3iF/7oQZQKKS6mmDZuY=; b=JcXn
 Ri4fLPDOzSQL74oZCOH75CgjUH6IRKmkao3ixOSNPdR7L5S1Mo+0JfVGpyzIlXZf
 OO3UY06P4AmVjgXOmGPyWV0GQntRNGWCFi1YqLBpxEHVqpqQne1QBHPPdKBS3+yn
 Z9wKKy8NDHZROuPHx4ZHbeUB0Fjlqg0qJ/h8VA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=fE/yAyHWzni2C/3WjNglWPYm9erVFRZ1PTkCYsUDWlBdEpzRhAJt6
 LEd86GA6wO68U4usN2XLmG0rtT0lx8oUuuFw2YH8eyrHusFgrEB27KcCTDxQrdyi
 Of09edatdDrRFaEecKbMSUMJWl6DIiYFcdW+4IlBIzn8P06EleB7ck=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:6892:e4ed:172c:18e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W9JXz09qPz8PbN;
 Thu, 27 Jun 2024 22:00:03 -0400 (EDT)
Date: Thu, 27 Jun 2024 22:00:01 -0400
From: Brad Smith <brad@comstyle.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util/cpuinfo-ppc: Add FreeBSD support
Message-ID: <Zn4ZIYX0uxwHf3I-@humpty.home.comstyle.com>
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

util/cpuinfo-ppc: Add FreeBSD support

Signed-off-by: Brad Smith <brad@comstyle.com>
---
With corrected sign-off.

Also this was based on the tcg-next branch.

 util/cpuinfo-ppc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 47af55aa0c..0ad634b46f 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -14,6 +14,11 @@
 #  include "elf.h"
 # endif
 #endif
+#ifdef __FreeBSD__
+# include <machine/cpu.h>
+# define PPC_FEATURE2_ARCH_3_1		0
+# define PPC_FEATURE2_VEC_CRYPTO	PPC_FEATURE2_HAS_VEC_CRYPTO
+#endif
 
 unsigned cpuinfo;
 
@@ -28,7 +33,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     info = CPUINFO_ALWAYS;
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
-- 
2.45.2


