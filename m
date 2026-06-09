Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76799CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4dn-0007eT-Fe; Tue, 09 Jun 2026 18:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wX4dl-0007dl-ML; Tue, 09 Jun 2026 18:09:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wX4dk-0003Rw-3m; Tue, 09 Jun 2026 18:09:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A60EE40340;
 Tue,  9 Jun 2026 22:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8E61F00893;
 Tue,  9 Jun 2026 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781042980;
 bh=s04LTT7BKhVo1CZxpcLnNoczPVx/VafO6+iqawSW++U=;
 h=From:To:Cc:Subject:Date;
 b=LIsA1QvAwk/vLOg116d3ySXUQuixJW0j0kyF3jp2hN04utCZMK8+RS/s49RtomsQ4
 nRIPwYy/0dUcjUR7qYZlJeumYbjLgFM2T7/onhllT1BvqZOeahIkSq4zMkYde7UpmX
 f0L7uRQ6lkE6zcyq69avztk/1mmK6VquVYTAY2HgrE747NNBPTR6rIzMjtIovpsErg
 irbWQWM9CxWYXNlyihSfbZwDGGpJOEsUUUB9J+ktdBsjFD4yjgT/INLyoKFF6dP6WG
 +QHUAp3e0INYsr1BV6tX+b46eHhFwrxmzJ9x4E2+u6cdfFQ56sAfxCfc0yXXYOHuuX
 9mdQWD4u1V5cg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	qemu-ppc@nongnu.org
Subject: [PATCH] linux-user: Implement /proc/cpuinfo for ppc cpus
Date: Wed, 10 Jun 2026 00:09:29 +0200
Message-ID: <20260609220929.83951-1-deller@kernel.org>
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

I've tried to mimic what I've seen on two debian porterboxes (ppc64 and
ppc64le), which are running via KVM/QEMU. I assume the model type of
pSeries and such doesn't make much sense for some older ppc chips, so
any better suggestions here are welcome.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-ppc@nongnu.org
---
 linux-user/ppc/target_proc.h | 38 +++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/linux-user/ppc/target_proc.h b/linux-user/ppc/target_proc.h
index 43fe29ca72..fa965c0e69 100644
--- a/linux-user/ppc/target_proc.h
+++ b/linux-user/ppc/target_proc.h
@@ -1 +1,37 @@
-/* No target-specific /proc support */
+/*
+ * ppc specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef PPC_TARGET_PROC_H
+#define PPC_TARGET_PROC_H
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    int i, num_cpus;
+
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(env_cpu(cpu_env));
+    DeviceClass *dc = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "processor:\t: %d\n", i);
+        dprintf(fd, "cpu:\t\t: %s%s\n",
+                    dc->desc,
+                    pcc->insns_flags & PPC_ALTIVEC ? ", altivec supported":"");
+        dprintf(fd, "clock\t\t: 3425.000000MHz\n");
+        dprintf(fd, "revision\t: %d.%d (pvr %04x %04x)\n\n",
+                    (pcc->pvr >> 8) & 0x0f, pcc->pvr & 0x0f,
+                    pcc->pvr >> 16, pcc->pvr & 0xffff);
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


