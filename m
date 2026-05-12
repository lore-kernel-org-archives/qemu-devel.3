Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857AACD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuRh-0000Vm-S5; Tue, 12 May 2026 17:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuRb-0008Mt-Br; Tue, 12 May 2026 17:15:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuRZ-00067K-9P; Tue, 12 May 2026 17:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619305; bh=dm3H42c1x7JUzSv5Jkh42Fx0cbWalHn8RfvTCoAk7zE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=erj9h2HgcEyRiSCIHdYo6gN1Ith3/XZHcRkPGiyAbf4CVuopxWMmZm3S3AjAFtqGR
 q9zPSa6+sw/ZWNvL4ZXWHxelbFcE9Mmsatl54h9yykU8tzbtgglES74u1P24ChSYET
 kuKo0COXVINNZ1VSrGHgwQG76ZglNyJzR5g3zh8W1iqUIqt3e3fBFXXHM11AlVqizm
 yepy7tdzlGOGfzSCHXwHXgA43tKGj0wobUh608GahOWvrXTRQakYc01X1pxOo1o07o
 9ctIH6ELLIbr3sv4B5vPj8GQ9vWoMQVCcgXOtpQm1crEWHWWkPB3vx5kgOzyEG/CJb
 SO02VjJs1K85w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ECF7B1AA39A;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0228E3ABD09;
 Tue, 12 May 2026 23:55:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yicong Yang <yang.yicong@picoheart.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 092/117] hw/riscv/virt-acpi-build.c: Use kvm timer
 frequency when kvm enabled
Date: Tue, 12 May 2026 23:54:34 +0300
Message-ID: <20260512205503.361097-92-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yicong Yang <yang.yicong@picoheart.com>

The timer frequency is decided by the host(kvm) rather than a fixed
RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ on kvm accelerated VM. So build
RCHT with KVM provided timer frequency if KVM is enabled, just like
how we build the timer node on DT based VM.

Fixes: ebfd39289370 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Message-ID: <20260325081314.57089-1-yang.yicong@picoheart.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 4cb2f91773e8ec9511002de851734820f7ba64fe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb683..fd6ca5dbc4 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -35,9 +35,11 @@
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "system/kvm.h"
 #include "system/reset.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -296,7 +298,10 @@ static void build_rhct(GArray *table_data,
 
     /* Time Base Frequency */
     build_append_int_noprefix(table_data,
-                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, 8);
+                              kvm_enabled() ?
+                              kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
+                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                              8);
 
     /* ISA + N hart info */
     num_rhct_nodes = 1 + ms->smp.cpus;
-- 
2.47.3


