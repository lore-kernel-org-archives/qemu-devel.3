Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A464CD98FE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 21:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waKgx-0003gq-8e; Thu, 18 Jun 2026 17:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1waKgw-0003gT-64
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 17:54:30 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1waKgu-0002Kd-MQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 17:54:29 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4699E601E1;
 Thu, 18 Jun 2026 21:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C401F000E9;
 Thu, 18 Jun 2026 21:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781819661;
 bh=PEnXMMVv9dWFj8YPlqBxVILE7oewYr7Nm0uK+8bv6uo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bNtoS5pNY+z5l3l5leKVZQcE7g5fsytNv9ZU51MgfBKEzUpj4LYi3dckOy6IJYeTl
 e/j8BojoGxUbFXEcuyKeRbwRrLqIg9qHeDoE8nZwjVqptfGECg8yiasN4MRgy/kNbB
 fPOTmw3AbzDUZsmY/sOn0IvA0sFhbbuTsO+nj3zm5qQStt7D8IiI/t9P/H56bkEnaE
 TI459BBbiQ/E3XqRMhcOtd+qtnTyjahuQNcLfRCrm2iQV1mOvT39N/cQBzY9pvz3AI
 UQxKXDoaHZag0HXwcrfdOxGC/AuB54vpzKSwNQNKj7YzyMbt6xYExn5anWCloW3xyB
 xjALnlZ6/hX9A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Thomas Huth <th.huth+qemu@posteo.eu>
Subject: [PULL 3/4] linux-user: Implement /proc/cpuinfo for m68k CPU
Date: Thu, 18 Jun 2026 23:54:10 +0200
Message-ID: <20260618215411.22057-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618215411.22057-1-deller@kernel.org>
References: <20260618215411.22057-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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
 linux-user/m68k/target_proc.h | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/linux-user/m68k/target_proc.h b/linux-user/m68k/target_proc.h
index 3df8f28e22..dca77d8483 100644
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
@@ -13,4 +15,48 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
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
+                "Clocking:\t%.1fMHz\n"
+                "Model:\t\tQEMU user v" QEMU_VERSION "\n",
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


