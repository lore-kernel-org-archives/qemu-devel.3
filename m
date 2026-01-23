Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B334D778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 20:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjO9G-0000ab-Px; Fri, 23 Jan 2026 15:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO9F-0000ZU-9f
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:53 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO9D-0006zJ-NS
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 221BA600C4;
 Fri, 23 Jan 2026 20:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F2CC4CEF1;
 Fri, 23 Jan 2026 20:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769201570;
 bh=htgvuWU3qi6a5+MCqA3gyM24viQXphmb4VmeDkuJMNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LWwRa7SHSkLr2K8dEAhp3Vc5e+GWaqGIJBtmLchfIJeoazHCLGKpyJ6L4OIrX8wkw
 HdRcJOZvDercLmFXK3aqjF2ROKF+bkjqjbNzG1kga1pc6mOzTNhiRsR3GmEf0mulHG
 166ddXTgawBZYRqMBh98DRpp3oDFnu4zCg+tNGvh2ZdWLH2zVdxp/RAVH/avAitvS6
 AfAEvpgFCizJXTttwlZ/0CVuGOeJamw7puyIidjFfMK985yN3XpVU1tv439lWoJxIK
 h4sML9DZWRsE+8zxkPs9bfiFFgbShGJHmHtbeeF1iHlPz6vXvw9dISQC8GkYgo/oAU
 GnvPnXgI3buIA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/11] linux-user: fixup termios2 related things on PowerPC
Date: Fri, 23 Jan 2026 21:52:28 +0100
Message-ID: <20260123205230.33541-10-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123205230.33541-1-deller@kernel.org>
References: <20260123205230.33541-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 linux-user/syscall.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9443eb3a17..64a2f1cbb2 100644
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


