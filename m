Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0351091923
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Kg2-0001cH-RR; Thu, 19 Mar 2026 17:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfp-0001WG-77
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:57 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfl-0003gk-SV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A63E743FDA;
 Thu, 19 Mar 2026 21:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48165C2BC9E;
 Thu, 19 Mar 2026 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773954771;
 bh=zIl2Hp8jjQ0zjD/njDXTIeEwBZZVJ/K4isuPfVOqJfU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZX4ucVnVukIx/aHRMJ4pfb0OH4l5E9SqmHNzIpJ0H6cP0AK0WeZHpv5aT92PN3Ujf
 Il/XWSBELhFshikMUdPcij9lx1ToXzYf+o8ddP1lo2wj6ZNwbHfs+XhDHh6pDyZLLF
 z37VBHoUViWmGdhh/9iZWEpYYcI+kyIz8+eVRrdigNu2kHMoBeqlvgpVMWFiFVlj1A
 cr08yhLHt12lldY4zKbvYTkV1aHz+zhUKAZAu1yswqajc+L7vGoP0yPvnpe7N+m+Ef
 YEnF8C3foZkw/f8+abVUa+SfUVXyld2MVmQF9mwtv2tfMZjtgSjXFtn4fI6akRrxkg
 ejSibfGMZpknA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 5/6] hw/hppa: Fix crash of 64-bit HP-UX 11 while flushing caches
Date: Thu, 19 Mar 2026 22:12:38 +0100
Message-ID: <20260319211239.7902-6-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319211239.7902-1-deller@kernel.org>
References: <20260319211239.7902-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

HP-UX 11 64-bit reads at bootup a word from address CPU_HPA + 0x500
while flushing the the cache of a T600.
Add a memory handler to avoid crashing while reading this word.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/hppa/machine.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e72dda2a68..318ebfeee4 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -306,6 +306,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
 
     for (unsigned int i = 0; i < smp_cpus; i++) {
         g_autofree char *name = g_strdup_printf("cpu%u-io-eir", i);
+        g_autofree char *cflush_name = NULL;
+        MemoryRegion *cflush;
 
         cpu_region = g_new(MemoryRegion, 1);
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_ops,
@@ -313,6 +315,24 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         memory_region_add_subregion(addr_space,
                                     translate(NULL, CPU_HPA + i * 0x1000),
                                     cpu_region);
+
+        if (!hppa_is_pa20(&cpu[0]->env)) {
+            continue;
+        }
+
+        /*
+         * HP-UX 11 64-bit reads a word from address CPU_HPA + 0x500
+         * while flushing the cache of a T600, which was the first
+         * server with a 64-bit PA-RISC 2.0 CPU.
+         * We return 0, since the value isn't used anyway.
+         */
+        cflush_name = g_strdup_printf("cpu%u-T600-cacheflush", i);
+        cflush = g_new(MemoryRegion, 1);
+        memory_region_init_io(cflush, NULL, &hppa_pci_ignore_ops,
+                              NULL, cflush_name, 4);
+        memory_region_add_subregion(addr_space,
+                              translate(NULL, CPU_HPA + i * 0x1000 + 0x500),
+                              cflush);
     }
 
     /* RTC and DebugOutputPort on CPU #0 */
-- 
2.53.0


