Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E6CFC6175
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 15:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc3dN-0004qN-GK; Sat, 03 Jan 2026 10:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1vc3dD-0004pI-1U
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:33:31 -0500
Received: from woodpecker.gentoo.org ([140.211.166.183] helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1vc3dB-00034V-GP
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:33:30 -0500
Received: from noumea.fritz.box
 (p200300e5cf308a00a98854cc6072a531.dip0.t-ipconnect.de
 [IPv6:2003:e5:cf30:8a00:a988:54cc:6072:a531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dilfridge@gentoo.org)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 5D9CC341081;
 Sat, 03 Jan 2026 15:33:27 +0000 (UTC)
From: =?UTF-8?q?Andreas=20K=2E=20H=C3=BCttel?= <dilfridge@gentoo.org>
To: qemu-devel@nongnu.org
Cc: Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 8/8] linux-user: fixup termios2 related things on PowerPC
Date: Sat,  3 Jan 2026 16:25:39 +0100
Message-ID: <20260103153239.15787-9-dilfridge@gentoo.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260103153239.15787-1-dilfridge@gentoo.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.211.166.183;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Icenowy Zheng <uwu@icenowy.me>

The termios things on PowerPC equal to termios2 things otherwhere.

Use some simple #define's to allow both termios and termios2 to map to
termios on PowerPC.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Link: https://github.com/AOSC-Dev/aosc-os-abbs/blob/8d77eeaa76e9b159c3f35adaf73c875751aa7d17/app-virtualization/qemu/01-shared/patches/0005-AOSCOS-linux-user-fixup-termios2-related-things-on-P.patch
Link: https://lore.kernel.org/qemu-devel/4403eb94ddbb2934f1f75d94ce921f0f1078ad9f.camel@icenowy.me
---
 linux-user/syscall.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 01b67a6794..dd04c0ec63 100644
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
2.52.0


