Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E3606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyNtfQEl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3DP-0008Qr-9J; Tue, 24 Nov 2026 21:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW3DK-0008QD-56
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:58:30 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW3DI-0003dj-N2
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:58:29 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 125E560E91;
 Wed, 25 Nov 2026 02:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D71F000C4;
 Wed, 25 Nov 2026 02:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575507;
 bh=HfYwX+vjayMvrw17yCvyS9NzmI+jw1A0lHezqO5mt3w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SyNtfQElAehRe6hPf8E+eMtePaWRfv5MpiAD7rN7jJX1BecptWu7BVCE+G8ltYc61
 cRPwAPkvOYcVkXutl+hdiOWnCBPEemGkf+ZfljrOR9y8V8zPaHmw0M99nBo7icdwCk
 u8BJmWX+N6Fl0akhPkw/lBrzZLnXZhGLbdn5n9r3+RjmAoSauJUQPz9Hubvlu/iT6T
 G5MEsBzBNsPtxg+8JDLCEYSDYUokAa0iJugGt5xwD7CWUjwAf1Hi2YOBLJDiWZAxSX
 Lkzcuj+2jQhqPTtzkHKAHio8694ruDJYEe9W+5/Z2eDS+QgWWXDvX+3O/nCvcd74IO
 16I2W/FRHRE9g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PULL for 11.2 1/3] hw/hppa: fix OpenBSD boot on B160L emulation
Date: Wed, 25 Nov 2026 03:58:20 +0100
Message-ID: <20261125025822.10813-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125025822.10813-1-deller@kernel.org>
References: <20261125025822.10813-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

OpenBSD 8.0 hangs on boot since commit 98c37479afc7 ("target/hppa: Map
CPUs at same addresses as on physical machines"):

"Advanced audio (ext.)" at gsc0 (type a sv 7b mod 3 hv d4) offset 4000 not configured
"Core Centronics" at gsc0 (type a sv 74 mod 3 hv d0) offset 2000 not configured
dino0 at phantomas0 offset ff80000: can't map space
panic: trap: uvm_fault(0xaf8560, 0, 0, 2): 14
syncing disks... done
dump to dev 301 not possible
rebooting...SeaBIOS wants SYSTEM RESET.

On a physical machine, the boot CPU HPA is 0xfffbe000, so let's use
0xfffa0000 instead of the current (invalid) HPA of 0xfff10000 to allow
space for multiple CPUs.

Reported-by: Kirill A. Korinsky <kirill@korins.ky>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 3b83968f33..8dd9023058 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -716,7 +716,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     PCIBus *pci_bus;
 
     /* Create CPUs and RAM.  */
-    translate = machine_HP_common_init_cpus(machine, 0xfff10000);
+    translate = machine_HP_common_init_cpus(machine, 0xfffa0000);
 
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP B160L workstation requires a 32-bit "
-- 
2.54.0


