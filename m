Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0ABE7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2AQ-0008My-D2; Mon, 02 Feb 2026 17:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn29t-0007ju-0e; Mon, 02 Feb 2026 17:12:40 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn29r-0003Qt-Fw; Mon, 02 Feb 2026 17:12:36 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6EE241852DC;
 Tue, 03 Feb 2026 01:07:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4DD0435B3EF;
 Tue, 03 Feb 2026 01:08:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Icenowy Zheng <uwu@icenowy.me>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 47/56] linux-user: fixup termios2 related things on
 PowerPC
Date: Tue,  3 Feb 2026 01:07:52 +0300
Message-ID: <20260202220805.945271-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Icenowy Zheng <uwu@icenowy.me>

The termios things on PowerPC equal to termios2 things otherwhere.

Use some simple #define's to allow both termios and termios2 to map to
termios on PowerPC.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Link: https://github.com/AOSC-Dev/aosc-os-abbs/blob/8d77eeaa76e9b159c3f35adaf73c875751aa7d17/app-virtualization/qemu/01-shared/patches/0005-AOSCOS-linux-user-fixup-termios2-related-things-on-P.patch
Link: https://lore.kernel.org/qemu-devel/4403eb94ddbb2934f1f75d94ce921f0f1078ad9f.camel@icenowy.me
Reviewed-by: Helge Deller <deller@gmx.de>
(cherry picked from commit d68f0e2e906939bef076d0cd52f902d433c8c3da)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 28394961b6..fbacbaea3a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -148,6 +148,21 @@
 #include "fd-trans.h"
 #include "user/cpu_loop.h"
 
+#if defined(__powerpc__)
+/*
+ * On PowerPC termios2 is lacking and termios along with ioctls w/o 2
+ * behaves like termios2 and things with 2 on other architectures.
+ *
+ * Just define termios2-related things to be the same with termios-related
+ * ones to support PowerPC.
+ */
+#define host_termios2 host_termios
+#define TCGETS2 TCGETS
+#define TCSETS2 TCSETS
+#define TCSETSW2 TCSETSW
+#define TCSETSF2 TCSETSF
+#endif
+
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
 #endif
-- 
2.47.3


