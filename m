Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C081ECD8C90
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNLP-0004iD-Ka; Wed, 10 Jun 2026 14:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wXNLL-0004hk-Tn; Wed, 10 Jun 2026 14:08:00 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wXNLJ-0000Ax-5w; Wed, 10 Jun 2026 14:07:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2536144185;
 Wed, 10 Jun 2026 18:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0849A1F00893;
 Wed, 10 Jun 2026 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781114875;
 bh=9vIBde6QYLEv1SLnPkm9yp2a0+lbIbmGwTq4PvMBFa4=;
 h=From:To:Cc:Subject:Date;
 b=NsEJwrEKTlDVS3+rECWK+D6N4XY2ogUBCNv5xNKeXD+23xBu/S97gsu/MXjp1Jj07
 9wheJwPD0zDZrgPicP1QjvJx/f1K3bZ2Sn0muggPiiSmyndf7QvSgZ8S+5gt+fqOiM
 qRtuLcjR+nJ4em7R41LrwM5Ne9CK/+asXm698UKo6dyYF/LayAvpkxGB6//UqwoGWz
 eyWgWJhc1/x+kU59MXsOB9K/wHyJDyfp1xclK2OJWvRz1464D9NVgi+ijxmHJYUtSf
 ogxEWdtr7ETETJI9T4QAUOmuycx4SvkN+50eyHNByeaF7/IQm1vDMRqcn26MRV7WXR
 zOU/CUehbkNIQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] linux-user: Implement /proc/cpuinfo for ppc cpus
Date: Wed, 10 Jun 2026 20:06:56 +0200
Message-ID: <20260610180749.10883-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

I've tried to mimic what I've seen on two debian porterboxes (ppc64 and
ppc64le), which are running via KVM/QEMU. I assume the model type of
pSeries and such doesn't make much sense for some older ppc chips, so
any better suggestions here are welcome.

v2: drop colon, add clock output, refine pvr calculation
(@Richard: I suggest to completely drop the clock for v3 ?!?!)

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-ppc@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_proc.h | 91 +++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/linux-user/ppc/target_proc.h b/linux-user/ppc/target_proc.h
index 43fe29ca72..6d78c0f543 100644
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
+            switch (PVR_VER(pvr)) {
+            case 0x8000:	/* 7441/7450/7451, Voyager */
+            case 0x8001:	/* 7445/7455, Apollo 6 */
+            case 0x8002:	/* 7447/7457, Apollo 7 */
+            case 0x8003:	/* 7447A, Apollo 7 PM */
+            case 0x8004:	/* 7448, Apollo 8 */
+            case 0x800c:	/* 7410, Nitro */
+                    maj = ((pvr >> 8) & 0xF);
+                    min = PVR_MIN(pvr);
+                    break;
+            default:	/* e500/book-e */
+                    maj = PVR_MAJ(pvr);
+                    min = PVR_MIN(pvr);
+                    break;
+            }
+    } else {
+            switch (PVR_VER(pvr)) {
+                    case 0x1008:	/* 740P/750P ?? */
+                            maj = ((pvr >> 8) & 0xFF) - 1;
+                            min = pvr & 0xFF;
+                            break;
+                    case 0x004e: /* POWER9 bits 12-15 give chip type */
+                    case 0x0080: /* POWER10 bit 12 gives SMT8/4 */
+                            maj = (pvr >> 8) & 0x0F;
+                            min = pvr & 0xFF;
+                            break;
+                    default:
+                            maj = (pvr >> 8) & 0xFF;
+                            min = pvr & 0xFF;
+                            break;
+            }
+    }
+
+    if (clock_getres(CLOCK_REALTIME, &res) == -1) {
+        res.tv_nsec = 1;
+    }
+    freq_mhz = 1000.0 / res.tv_nsec;
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor:\t: %d\n", i);
+        dprintf(fd, "cpu\t\t: %s%s\n",
+                    dc->desc,
+                    pcc->insns_flags & PPC_ALTIVEC ? ", altivec supported":"");
+        dprintf(fd, "clock\t\t: %.3fMHz\n", freq_mhz);
+        dprintf(fd, "revision\t: %d.%d (pvr %04x %04x)\n\n",
+                    maj, min, PVR_VER(pvr), PVR_REV(pvr));
+    }
+
+    dprintf(fd, "timebase\t: 512000000\n");
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


