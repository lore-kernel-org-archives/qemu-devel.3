Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE3C2BD09
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 02:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLCiU-0001Mb-UN; Sat, 22 Jun 2024 22:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sLCiS-0001M4-0X
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 22:12:28 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sLCiQ-0002zM-6f
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 22:12:27 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W6F3Y2cLmz8PbP;
 Sat, 22 Jun 2024 22:12:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=l0itdJ4sWXRO7UKXF3YZz+szFqAoEHcojxY5FRtV7h8=; b=mSSj
 BAFv1GfPVsMB+JFN93fg5+O2VYFRZr+mbendRU4qrN+KTpDoP1BmR2zCfF+SrEri
 PZoWwxxFUjAejdF1uQazW2KeGS+T1B1eObTtUOobkYlxU+s8CU9iSEjWLTJgdvj4
 +aL11y9xFuoRq5RhthlGhP+dJlAnbOQ7Y28s4cA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=o3KvLYgVTu0oVPLhJCaNOXI5M1mw62u4DV69Yu9suIPUI13cHYfxB
 jEimX6Bs3Z6Hv2eeY1eyA0S90EJ3oRYTXqNpkH9aNNI8S5gjk2RmmJvffI9rZVS0
 SPCTmjHyKVjUuDothzopZi8lqOd6L1K/rSKt7y6dCTs9mD3GVg/ciM=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:9ee5:c2f5:b033:d60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W6F3Y219sz8PbN;
 Sat, 22 Jun 2024 22:12:25 -0400 (EDT)
Date: Sat, 22 Jun 2024 22:12:23 -0400
From: Brad Smith <brad@comstyle.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util/cpuinfo-aarch64: Add OpenBSD support
Message-ID: <ZneEh51XKhxgZKpp@humpty.home.comstyle.com>
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

util/cpuinfo-aarch64: Add OpenBSD support

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 util/cpuinfo-aarch64.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 4c8a005715..8a8c0a30a8 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -20,6 +20,12 @@
 #ifdef CONFIG_DARWIN
 # include <sys/sysctl.h>
 #endif
+#ifdef __OpenBSD__
+# include <machine/armreg.h>
+# include <machine/cpu.h>
+# include <sys/types.h>
+# include <sys/sysctl.h>
+#endif
 
 unsigned cpuinfo;
 
@@ -72,6 +78,32 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
 #endif
+#ifdef __OpenBSD__
+    int mib[2];
+    uint64_t isar0;
+    uint64_t pfr1;
+    size_t len;
+
+    mib[0] = CTL_MACHDEP;
+    mib[1] = CPU_ID_AA64ISAR0;
+    len = sizeof(isar0);
+    if (sysctl(mib, 2, &isar0, &len, NULL, 0) != -1) {
+      if (ID_AA64ISAR0_ATOMIC(isar0) >= ID_AA64ISAR0_ATOMIC_IMPL)
+        info |= CPUINFO_LSE;
+      if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_BASE)
+        info |= CPUINFO_AES;
+      if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_PMULL)
+        info |= CPUINFO_PMULL;
+    }
+
+    mib[0] = CTL_MACHDEP;
+    mib[1] = CPU_ID_AA64PFR1;
+    len = sizeof(pfr1);
+    if (sysctl(mib, 2, &pfr1, &len, NULL, 0) != -1) {
+      if (ID_AA64PFR1_BT(pfr1) >= ID_AA64PFR1_BT_IMPL)
+        info |= CPUINFO_BTI;
+    }
+#endif
 
     cpuinfo = info;
     return info;
-- 
2.45.2


