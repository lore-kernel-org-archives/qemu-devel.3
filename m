Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CE8CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY49n-000175-Tq; Fri, 12 Jun 2026 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wY49m-00016Q-5d
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:50:54 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wY49k-0008Av-FN
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:50:53 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9CD436008A;
 Fri, 12 Jun 2026 15:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94241F000E9;
 Fri, 12 Jun 2026 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781279451;
 bh=0eEpzlx9/ON/Uwph3+LU5JGk/Iqo/Yt7aIelhbODELY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hshoN7AQXfvjGIj+2PMM5AGC8Y+YqW8ClgD4HuZlx5qartK3ZsY6lIGT5jU4fimyl
 FHGqdEiU0ZcjX8oEbh3E9qsvVAwhP+VUcUoZ768X9TpvHGMdIuWWn5RbAygcWBEfri
 hGqu445Skv5gWeCVb9VDZxf+hyTAOQDxJkrJwOR+0SPnjvFa2ahldduEmwnimgRFE8
 EmHe1Cr3HhiT1yv3LbN2SyyFxGMJwJUtaPjcOrJuMspZje6TsTgin5E/9p29BFpJZx
 bITdChDu+4j2OI3RyqCZuUecxNOWf1L+cdENZY8+ekPe2j0URhlB0OlPnPD78pL5QJ
 C0/wCAJbLueJQ==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/4] linux-user: Implement /proc/cpuinfo for ppc cpus
Date: Fri, 12 Jun 2026 17:50:41 +0200
Message-ID: <20260612155043.3552-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612155043.3552-1-deller@kernel.org>
References: <20260612155043.3552-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

Mimic the entries for /proc/cpuinfo to what can be seen on two debian
porterboxes (ppc64 and ppc64le), which are running via KVM/QEMU.

The "timebase" value in /proc/cpuinfo is used by glibc on power, but only if
the __kernel_get_tbfreq vdso call isn't implemented. So switch
cpu_ppc_load_tbl() for linux-user to get_clock(), as suggested by Richard, and
report timebase = 1GHz in /proc/cpuinfo, which will make the vdso
implementation simple too.

v4: change timebase to 1GHz and use get_clock()
v3: drop another colon, indenting fixes
v2: drop colon, add clock output, refine pvr calculation

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/ppc/cpu_loop.c    |  2 +-
 linux-user/ppc/target_proc.h | 91 +++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 1f9ee20bd0..7c53e25a93 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -26,7 +26,7 @@
 
 static inline uint64_t cpu_ppc_get_tb(CPUPPCState *env)
 {
-    return cpu_get_host_ticks();
+    return get_clock();
 }
 
 uint64_t cpu_ppc_load_tbl(CPUPPCState *env)
diff --git a/linux-user/ppc/target_proc.h b/linux-user/ppc/target_proc.h
index 43fe29ca72..0a48fd65e9 100644
--- a/linux-user/ppc/target_proc.h
+++ b/linux-user/ppc/target_proc.h
@@ -1 +1,90 @@
-/* No target-specific /proc support */
+/*
+ * ppc specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef PPC_TARGET_PROC_H
+#define PPC_TARGET_PROC_H
+
+#include <time.h>
+
+#define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF)      /* Version field */
+#define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF)      /* Revison field */
+#define PVR_MAJ(pvr)    (((pvr) >>  4) & 0xF)   /* Major revision field */
+#define PVR_MIN(pvr)    (((pvr) >>  0) & 0xF)   /* Minor revision field */
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    struct timespec res;
+    double freq_mhz;
+    int i, num_cpus;
+    unsigned int maj, min, pvr;
+
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(env_cpu(cpu_env));
+    DeviceClass *dc = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
+
+    pvr = pcc->pvr;
+
+    /* Taken from Linux kernel: */
+    /* If we are a Freescale core do a simple check so
+     * we don't have to keep adding cases in the future */
+    if (PVR_VER(pvr) & 0x8000) {
+        switch (PVR_VER(pvr)) {
+        case 0x8000: /* 7441/7450/7451, Voyager */
+        case 0x8001: /* 7445/7455, Apollo 6 */
+        case 0x8002: /* 7447/7457, Apollo 7 */
+        case 0x8003: /* 7447A, Apollo 7 PM */
+        case 0x8004: /* 7448, Apollo 8 */
+        case 0x800c: /* 7410, Nitro */
+            maj = ((pvr >> 8) & 0xF);
+            min = PVR_MIN(pvr);
+            break;
+        default:     /* e500/book-e */
+            maj = PVR_MAJ(pvr);
+            min = PVR_MIN(pvr);
+            break;
+        }
+    } else {
+        switch (PVR_VER(pvr)) {
+        case 0x1008: /* 740P/750P ?? */
+            maj = ((pvr >> 8) & 0xFF) - 1;
+            min = pvr & 0xFF;
+            break;
+        case 0x004e: /* POWER9 bits 12-15 give chip type */
+        case 0x0080: /* POWER10 bit 12 gives SMT8/4 */
+            maj = (pvr >> 8) & 0x0F;
+            min = pvr & 0xFF;
+            break;
+        default:
+            maj = (pvr >> 8) & 0xFF;
+            min = pvr & 0xFF;
+            break;
+        }
+    }
+
+    if (clock_getres(CLOCK_REALTIME, &res) == -1) {
+        res.tv_nsec = 1;
+    }
+    freq_mhz = 1000.0 / res.tv_nsec;
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor\t: %d\n", i);
+        dprintf(fd, "cpu\t\t: %s%s\n",
+                    dc->desc,
+                    pcc->insns_flags & PPC_ALTIVEC ? ", altivec supported":"");
+        dprintf(fd, "clock\t\t: %.3fMHz\n", freq_mhz);
+        dprintf(fd, "revision\t: %d.%d (pvr %04x %04x)\n\n",
+                    maj, min, PVR_VER(pvr), PVR_REV(pvr));
+    }
+
+    dprintf(fd, "timebase\t: 1000000000\n");
+    dprintf(fd, "platform\t: pSeries\n");
+    dprintf(fd, "model\t\t: IBM pSeries (QEMU user v" QEMU_VERSION ")\n");
+    dprintf(fd, "machine\t\t: CHRP IBM pSeries\n");
+
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* PPC_TARGET_PROC_H */
-- 
2.54.0


