Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A66CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZYr-000409-42; Tue, 16 Jun 2026 15:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wZZYp-0003zQ-32
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:34:59 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wZZYm-00010f-A2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:34:58 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C942844326;
 Tue, 16 Jun 2026 19:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DC61F000E9;
 Tue, 16 Jun 2026 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781638486;
 bh=Il/D/59EcDGFMbeKx110OhFMLzw22+Wm+90eKW+Hs6k=;
 h=From:To:Cc:Subject:Date;
 b=EFW4rISsPgS42B9DaNyTCP7mc9H/KJ0b8UNidbD00Yp+WujfPnYfEfL85MNvoB9Jp
 6Uwo0mF1oWFl1VqQ+XFkhLhXiTTgc4tO56dF5/t2L78bAfwMUe/uNZwmV51f7WtU+r
 HRJB7IgdgMr8X/1k87ueFgZypWeVBeE/mixs9/hgTq8qutb37mraHRvMFmXSzmB46W
 v99dIZeWD3NgntsdTJ9RSElG1QvBA0Deatt5CUFSjH1mE7j/BgTo08lppAljL3Adhl
 LSi66P3QLc76yc+ncc+dgAUD2vG13QFRIEprnOSjw9ratlpe0kgVExdjmqlPMVWJ+p
 yMMqpRjF35ENA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] linux-user: Implement /proc/cpuinfo for loongarch cpus
Date: Tue, 16 Jun 2026 21:34:32 +0200
Message-ID: <20260616193432.39387-1-deller@kernel.org>
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
porterbox loomis.debian.org.

Cc: Song Gao <gaosong@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/loongarch64/elfload.c     | 20 +++++++
 linux-user/loongarch64/target_proc.h | 79 +++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index e53957e36d..2242f20202 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -28,6 +28,26 @@ enum {
     HWCAP_LOONGARCH_LBT_MIPS = (1 << 12),
 };
 
+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+    [__builtin_ctz(HWCAP_LOONGARCH_CPUCFG  )] = "cpucfg",
+    [__builtin_ctz(HWCAP_LOONGARCH_LAM     )] = "lam",
+    [__builtin_ctz(HWCAP_LOONGARCH_UAL     )] = "lam_bh",
+    [__builtin_ctz(HWCAP_LOONGARCH_FPU     )] = "fpu",
+    [__builtin_ctz(HWCAP_LOONGARCH_LSX     )] = "lsx",
+    [__builtin_ctz(HWCAP_LOONGARCH_LASX    )] = "lasx",
+    [__builtin_ctz(HWCAP_LOONGARCH_CRC32   )] = "crc32",
+    [__builtin_ctz(HWCAP_LOONGARCH_COMPLEX )] = "complex",
+    [__builtin_ctz(HWCAP_LOONGARCH_CRYPTO  )] = "crypto",
+    [__builtin_ctz(HWCAP_LOONGARCH_LVZ     )] = "lvz",
+    [__builtin_ctz(HWCAP_LOONGARCH_LBT_X86 )] = "lbt_x86",
+    [__builtin_ctz(HWCAP_LOONGARCH_LBT_ARM )] = "lbt_arm",
+    [__builtin_ctz(HWCAP_LOONGARCH_LBT_MIPS)] = "lbt_mips",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
 abi_ulong get_elf_hwcap(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
diff --git a/linux-user/loongarch64/target_proc.h b/linux-user/loongarch64/target_proc.h
index 43fe29ca72..f739520fab 100644
--- a/linux-user/loongarch64/target_proc.h
+++ b/linux-user/loongarch64/target_proc.h
@@ -1 +1,78 @@
-/* No target-specific /proc support */
+/*
+ * Loongson specific proc functions for linux-user
+ *
+ * Copyright (c) 2026 Helge Deller
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef LOONGARCH_TARGET_PROC_H
+#define LOONGARCH_TARGET_PROC_H
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    uint32_t elf_hwcap = get_elf_hwcap(env_cpu(cpu_env));
+    uint32_t prid, ser_id, pabits, vabits, i, n, num_cpus;
+    bool is_64bit = is_la64(cpu_env);
+    const char *hwcap_str;
+    struct timespec res;
+    double freq_mhz;
+
+#if TARGET_LONG_BITS == 32
+    pabits = 31;
+    vabits = 31;
+#else
+    pabits = FIELD_EX32(cpu_env->cpucfg[1], CPUCFG1, PALEN);
+    vabits = FIELD_EX32(cpu_env->cpucfg[1], CPUCFG1, VALEN);
+#endif
+
+    if (clock_getres(CLOCK_REALTIME, &res) == -1) {
+        res.tv_nsec = 1;
+    }
+    freq_mhz = 1000.0 / res.tv_nsec;
+
+    ser_id = FIELD_EX32(cpu_env->cpucfg[0], CPUCFG0, SERID);
+    prid   = FIELD_EX32(cpu_env->cpucfg[0], CPUCFG0, PRID);
+
+    dprintf(fd, "system type\t\t: generic-loongson-machine\n");
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    for (n = 0; n < num_cpus; n++) {
+        dprintf(fd, "\nprocessor\t\t: %d\n", n);
+        dprintf(fd, "package\t\t\t: 0\n");
+        dprintf(fd, "core\t\t\t: %d\n", n);
+        dprintf(fd, "global_id\t\t: %d\n", n);
+        dprintf(fd, "CPU Family\t\t: Loongson-%dbit\n", is_64bit ? 64 : 32);
+        dprintf(fd, "Model Name\t\t: QEMU_user-v" QEMU_VERSION "\n");
+        dprintf(fd, "PRID\t\t\t: %s (%08x)\n",
+                    ser_id == PRID_SERIES_LA464 ? "LA464" :
+                    ser_id == PRID_SERIES_LA132 ? "LA132" : "Unknown",
+                    cpu_env->cpucfg[0]);
+        dprintf(fd, "CPU Revision\t\t: 0x%02x\n", prid);
+        dprintf(fd, "FPU Revision\t\t: 0x%02x\n",
+                    FIELD_EX32(cpu_env->cpucfg[2], CPUCFG2, FP_VER));
+        dprintf(fd, "CPU MHz\t\t\t: %.2f\n", freq_mhz);
+        dprintf(fd, "Address Sizes\t\t: %d bits physical, %d bits virtual\n",
+                    pabits + 1, vabits + 1);
+
+        dprintf(fd, "ISA\t\t\t:%s", " loongarch32r loongarch32s");
+        if (is_64bit) {
+            dprintf(fd, " loongarch64");
+        }
+
+        dprintf(fd, "\nFeatures\t\t:");
+        for (i = 0; i < sizeof(elf_hwcap) * 8; i++) {
+            if (!(elf_hwcap & (1 << i))) {
+                continue;
+            }
+            hwcap_str = elf_hwcap_str(i);
+            if (hwcap_str) {
+                dprintf(fd, " %s", hwcap_str);
+            }
+        }
+        dprintf(fd, "\nHardware Watchpoint\t: no\n");
+    }
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* LOONGARCH_TARGET_PROC_H */
-- 
2.54.0


