Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94686FEDA1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aSU-00047k-Ol; Tue, 17 Mar 2026 15:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSR-00047U-L4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:52:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSQ-0006SO-8l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:52:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CB37D61334;
 Tue, 17 Mar 2026 19:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB58C2BCAF;
 Tue, 17 Mar 2026 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773777120;
 bh=u4k0A1PGQkwO1utbIW6Oaek16i16TJKYwPifohF2eXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rdMdkqgVjsu0wU34x+cfwBv4eA97bp/Abv9O4yH0gHEuWCBqezrCS8ZVCN6lIqrQS
 CRnLOCqpom4fjIWZ6/qHhr6JT4qk7rhc4TLeeXiHxR8p8tsF1qaTz4wlydLkQKlNXb
 DT6ZShYb74P9ChqDjA0JI25wnTP9nF5uUpLXbqV9A1LukMBgZdh5GrFlfOrUbJXoJB
 aF3gPPYngNGFBK4VucoK08WQkOgFARQi784cxzX7xCihlhip+kiMqYnVm+vNYZ8xw9
 y4rteKh9fVYl2bLfPi9v/q2Fs/IagQdvx2oEQ+oMhGdv5ucrYfSpOErD7E9L+GC4un
 ScBwnbq4kkrqg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 5/6] hw/hppa: Fix crash of 64-bit HP-UX 11 while flushing
 caches
Date: Tue, 17 Mar 2026 20:51:48 +0100
Message-ID: <20260317195149.8386-6-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317195149.8386-1-deller@kernel.org>
References: <20260317195149.8386-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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
---
 hw/hppa/machine.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e72dda2a68..7e8ebbca3b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -313,6 +313,22 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         memory_region_add_subregion(addr_space,
                                     translate(NULL, CPU_HPA + i * 0x1000),
                                     cpu_region);
+
+        if (!hppa_is_pa20(&cpu[0]->env))
+            continue;
+
+        /* HP-UX 11 64-bit reads a word from address CPU_HPA + 0x500
+         * while flushing the the cache of a T600, which was the first
+         * server with a 64-bit PA-RISC 2.0 CPU.
+         * We return 0, since the value isn't used anyway. */
+        g_autofree char *cflush_name;
+        cflush_name = g_strdup_printf("cpu%u-T600-cacheflush", i);
+        MemoryRegion *cflush = g_new(MemoryRegion, 1);
+        memory_region_init_io(cflush, NULL, &hppa_pci_ignore_ops,
+                              NULL, cflush_name, 4);
+        memory_region_add_subregion(addr_space,
+                              translate(NULL, CPU_HPA + i * 0x1000 + 0x500),
+                              cflush);
     }
 
     /* RTC and DebugOutputPort on CPU #0 */
-- 
2.53.0


