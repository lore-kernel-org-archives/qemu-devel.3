Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43B6CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9aL-0008WD-OB; Sat, 17 Oct 2026 14:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9aF-0008Sl-Hm; Sat, 17 Oct 2026 14:56:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9aD-0003dE-IV; Sat, 17 Oct 2026 14:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263370; bh=Iwbhg3ibPz1Bhm9E/egqBaWZUe8H2YcpdcesX1LNXIs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HJrVWpBWAPY/sXvx+g2AaxCHl7JwsVTgESf9tPp6QMWiMk06J4rFAdDe1BWaGyLj5
 W0h+gslKcsu9zemSSxt+8sOLLhmtvcVPcYzsAm7aNHbwEV13tQCdhd00c7OTmKLyDG
 i+2Db+fOfCzF6ULB2m0mRdq+iZHMXDI2NeJ3rH0Eqv1YFZpHX9ccE3IfXJEr3GUO3e
 oASG5Y2qznqC8vigKdN34M2RWoLRPqtOSgik3v3cG4q9cRN6nWcQ4jBdEkNynIDRl+
 G8VqTvQ5YyPZ10vKRPVOIx/x3Gp8EfQpEbPOQ/eILwHJjSbVZpsdj1MsE9pr7+TH1a
 8PtDUEZ+91i/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CD82F1DE6AD;
 Sat, 17 Oct 2026 21:56:10 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 78D23443378;
 Sat, 17 Oct 2026 21:56:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 13/63] s390x/pci: Use qemu_log_mask() for
 guest-triggered errors in reg_ioat()
Date: Sat, 17 Oct 2026 21:54:29 +0300
Message-ID: <20261017185528.722197-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

The error paths in reg_ioat() that are triggered by a guest providing
invalid MPCIFC arguments use error_report(), which writes unconditionally
to stderr.  A misbehaving guest can exploit this to flood the host log
by repeatedly issuing the instruction with bad arguments.

Replace these with qemu_log_mask(LOG_GUEST_ERROR, ...) so that the
messages are suppressible.

Fixes: 863f6f52b713 ("s390: implement pci instructions")
Fixes: dfcee1ea4c52 ("s390x/pci: add support for guests that request direct mapping")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929153012.774530-3-mjrosato@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 10a81449a279be0d5b46c3422b445ca3f42d3393)
(Mjt: fix #include statements in hw/s390x/s390-pci-inst.c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f01cdeae61..1be3bc0f46 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "exec/memop.h"
 #include "exec/memory.h"
-#include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "system/hw_accel.h"
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
@@ -1042,11 +1042,12 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
     /* currently we only support designation type 1 with translation */
     if (t && dt != ZPCI_IOTA_RTTO) {
-        error_report("unsupported ioat dt %d t %d", dt, t);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unsupported ioat dt %d t %d\n", dt, t);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     } else if (!t && !pbdev->rtr_avail) {
-        error_report("relaxed translation not allowed");
+        qemu_log_mask(LOG_GUEST_ERROR, "relaxed translation not allowed\n");
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     }
-- 
2.47.3


