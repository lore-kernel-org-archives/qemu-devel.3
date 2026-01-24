Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47427D715D9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 08:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjZOd-000222-42; Sat, 24 Jan 2026 03:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOc-00020j-1b
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:30 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOa-0002TU-JL
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 43A8D41AA3;
 Sat, 24 Jan 2026 08:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C4AC19422;
 Sat, 24 Jan 2026 08:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769244807;
 bh=htgvuWU3qi6a5+MCqA3gyM24viQXphmb4VmeDkuJMNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vNGJkzuDObJxVmBFMskHU65yrLvUn/G8XJAeN0yvfmu1VeDmCjLai4qZbOea9poE7
 4gBzG2Ufi5dyVSsToXNI2lpCcHr1zZuifrse+UlHVWJ1m4CT+C6sPttN1khcNcOA5R
 vOnNoLHXRR53KD/kFoyNR5iTvIwqFfXl3l89STtCC2D4C7wR6qrnkpANycUhxVUMM7
 t5/ohmLjzC7HbtrWOC3eHed91wMTPkmHEDnpEZp5SvIcMxw5J92TaBLBphovdGBK9K
 d3oO7NmOOB0DdfDmZ/O1acaoDVdeR0BDeIUPldZawho//xMR6y1xIOGTrUPw+i7RSe
 XNAadkEu7oYsw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 09/11] linux-user: fixup termios2 related things on PowerPC
Date: Sat, 24 Jan 2026 09:53:04 +0100
Message-ID: <20260124085306.3996-10-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124085306.3996-1-deller@kernel.org>
References: <20260124085306.3996-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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


