Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14810CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZayj-00017n-3h; Tue, 16 Jun 2026 17:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wZayh-00017e-Ss
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:05:47 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wZayg-0002Mk-4g
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:05:47 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 338E64397C;
 Tue, 16 Jun 2026 21:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB681F000E9;
 Tue, 16 Jun 2026 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781643944;
 bh=MpSZzBq5bCubM4yTbMOT+AB+YCu6Cfhc9iYUeh+WCJc=;
 h=From:To:Cc:Subject:Date;
 b=a1HkjRRNbCeLTEFBmOKFMIjyh4I+hIlubXrSLNuhms+yeIyXYHvJrwa2SsZ+l3QWZ
 OLejjkHk8rjSuIn/BylNRFJa15LLm+OCVPPKpNM/6VufCeVGKqQxdcRA+KKCv3CoLG
 w+xzk2ObRfcOz2tLFc8CkkGX+qC6WOA1HuFT4wFc99ogwSwhXBBAHp/HYY7JxDMAnY
 GyJq3rgCHJDygXo70w0zKC6CG0GxoF+JpBdnFJlrMjYx5zEcnLBGb7/GXtqfsghkKZ
 fX5zJsU067/wQmJyibo7ejFPD4l5LUVqLkghh0DEYTiuUCLDapIV3YR4gM1pVdIgJR
 hrG2m1JzGCMWg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Implement /proc/cpuinfo for m68k CPU
Date: Tue, 16 Jun 2026 23:05:39 +0200
Message-ID: <20260616210539.69342-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Helge Deller <deller@gmx.de>

Mimic the entries for /proc/cpuinfo to what can be seen on the debian
porterbox mitchy.debian.org.

Cc: Thomas Huth <th.huth+qemu@posteo.eu>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/m68k/target_proc.h | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/linux-user/m68k/target_proc.h b/linux-user/m68k/target_proc.h
index 3df8f28e22..5a6678d59e 100644
--- a/linux-user/m68k/target_proc.h
+++ b/linux-user/m68k/target_proc.h
@@ -1,6 +1,8 @@
 /*
  * M68K specific proc functions for linux-user
  *
+ * Copyright (c) 2026 Helge Deller
+ *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #ifndef M68K_TARGET_PROC_H
@@ -13,4 +15,47 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 }
 #define HAVE_ARCH_PROC_HARDWARE
 
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    const char *cpu, *fpu;
+    struct timespec res;
+    double freq_mhz;
+
+    if (clock_getres(CLOCK_REALTIME, &res) == -1) {
+        res.tv_nsec = 1;
+    }
+    freq_mhz = 1000.0 / res.tv_nsec;
+
+    if (m68k_feature(cpu_env, M68K_FEATURE_M68010)) {
+        cpu = "68010";
+    } else if (m68k_feature(cpu_env, M68K_FEATURE_M68020)) {
+        cpu = "68020";
+    } else if (m68k_feature(cpu_env, M68K_FEATURE_M68030)) {
+        cpu = "68030";
+    } else if (m68k_feature(cpu_env, M68K_FEATURE_M68040)) {
+        cpu = "68040";
+    } else if (m68k_feature(cpu_env, M68K_FEATURE_M68060)) {
+        cpu = "68060";
+    } else {
+        cpu = "680x0";
+    }
+
+    if (m68k_feature(cpu_env, M68K_FEATURE_FPU)) {
+        fpu = cpu;
+    } else {
+	fpu = "none(soft float)";
+    }
+
+    dprintf(fd, "CPU:\t\t%s\n"
+                "MMU:\t\t%s\n"
+                "FPU:\t\t%s\n"
+                "Clocking:\t%.1fMHz\n",
+                cpu, cpu, fpu, freq_mhz);
+    /* dropped BogoMips and Calibration for now */
+
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
 #endif /* M68K_TARGET_PROC_H */
-- 
2.54.0


