Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC9DC27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZ3-0000zS-9X; Fri, 14 Jun 2024 13:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZ1-0000yu-Rx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZ0-00042g-60
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0398C339FB;
 Fri, 14 Jun 2024 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx7Tw7BVV5ItBj54IuIkXhOV34oE+O0rjeGv2yRXDDI=;
 b=Wf1xm8vZOrNSShDsYf6584GlMatTQAq6aia+gI3XBWIy+JQy1WZ1/e4xIO52vjh7jWRwbp
 Bi4Lyuu978gkJnjTSwWeFiYnzYNa9vxV3FIS0gf5peS6VR8/0N7Hd7JvaT9VFAo5JoWbQG
 bHesqZFjQ79QYs16wf2IQn9udvpyjw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx7Tw7BVV5ItBj54IuIkXhOV34oE+O0rjeGv2yRXDDI=;
 b=aFqbeu0rUOkIXTbTEvCsH3vmXeWyKSe9LGSUgLySgftOBijAjczLpIWRb4G88o77JUho1d
 m3e3CScoVASrkOCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wf1xm8vZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aFqbeu0r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx7Tw7BVV5ItBj54IuIkXhOV34oE+O0rjeGv2yRXDDI=;
 b=Wf1xm8vZOrNSShDsYf6584GlMatTQAq6aia+gI3XBWIy+JQy1WZ1/e4xIO52vjh7jWRwbp
 Bi4Lyuu978gkJnjTSwWeFiYnzYNa9vxV3FIS0gf5peS6VR8/0N7Hd7JvaT9VFAo5JoWbQG
 bHesqZFjQ79QYs16wf2IQn9udvpyjw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx7Tw7BVV5ItBj54IuIkXhOV34oE+O0rjeGv2yRXDDI=;
 b=aFqbeu0rUOkIXTbTEvCsH3vmXeWyKSe9LGSUgLySgftOBijAjczLpIWRb4G88o77JUho1d
 m3e3CScoVASrkOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6181713AB1;
 Fri, 14 Jun 2024 17:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kCAOCk57bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/18] tests/qtest: Move common define from libqos-spapr.h to
 new ppc-util.h
Date: Fri, 14 Jun 2024 14:17:45 -0300
Message-Id: <20240614171802.28451-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0398C339FB
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The spapr QEMU machine defaults is useful outside libqos, so create a
new header for ppc specific qtests and move it there.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/boot-serial-test.c    |  2 +-
 tests/qtest/libqos/libqos-spapr.h |  7 -------
 tests/qtest/ppc-util.h            | 19 +++++++++++++++++++
 tests/qtest/prom-env-test.c       |  2 +-
 tests/qtest/pxe-test.c            |  2 +-
 5 files changed, 22 insertions(+), 10 deletions(-)
 create mode 100644 tests/qtest/ppc-util.h

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index df389adeeb..3b92fa5d50 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 static const uint8_t bios_avr[] = {
     0x88, 0xe0,             /* ldi r24, 0x08   */
diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.h
index e4483c14f8..a446276416 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -9,11 +9,4 @@ QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...)
     G_GNUC_PRINTF(1, 2);
 void qtest_spapr_shutdown(QOSState *qs);
 
-/* List of capabilities needed to silence warnings with TCG */
-#define PSERIES_DEFAULT_CAPABILITIES             \
-    "cap-cfpc=broken,"                           \
-    "cap-sbbc=broken,"                           \
-    "cap-ibs=broken,"                            \
-    "cap-ccf-assist=off,"
-
 #endif
diff --git a/tests/qtest/ppc-util.h b/tests/qtest/ppc-util.h
new file mode 100644
index 0000000000..f68ee93520
--- /dev/null
+++ b/tests/qtest/ppc-util.h
@@ -0,0 +1,19 @@
+/*
+ * PowerPC misc useful things
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_UTIL_H
+#define PPC_UTIL_H
+
+/* List of capabilities needed to silence warnings with TCG */
+#define PSERIES_DEFAULT_CAPABILITIES             \
+    "cap-cfpc=broken,"                           \
+    "cap-sbbc=broken,"                           \
+    "cap-ibs=broken,"                            \
+    "cap-ccf-assist=off,"
+
+#endif /* PPC_UTIL_H */
diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
index 39ccb59797..14705105ad 100644
--- a/tests/qtest/prom-env-test.c
+++ b/tests/qtest/prom-env-test.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 #define MAGIC   0xcafec0de
 #define ADDRESS 0x4000
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index e4b48225a5..a3f900fbea 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -16,7 +16,7 @@
 #include <glib/gstdio.h>
 #include "libqtest.h"
 #include "boot-sector.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 #define NETNAME "net0"
 
-- 
2.35.3


