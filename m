Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F3CCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu8x-0004T0-7a; Tue, 12 May 2026 16:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8Y-000465-Q7; Tue, 12 May 2026 16:55:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8V-00036a-RC; Tue, 12 May 2026 16:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=YMZrUYsIlbBqCWStEj4HLXZ9OHaM8mNn1Z68T//7P1I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V4ha8WbBFJutd79MEV7og4XqYsEN4Oux0MQJRmqUkfcXipyHAuFLZI1Jcv4io5oyk
 82oOs+7IkpzWx1NOk/dEyQs84XOqAIU40iT0TX9D4y82sPPo0YCZ7yXHlI+L0ThP8W
 sf1tY7/z9KmS14ffDjkH1YxmEBedtOE5PaQ5n4MRxjcbtSZ6dFakwLV5zvmMwZIw6E
 XScpfVK5u4eAaIJ+O28omoT/dbxWoJ4ob5EdYc7oii/xt1XrQ8w1byz7e6v5M/WDi9
 NhaJcc+tzNWEXop1LtzI/yXBtN3YkHeLJeVY/Q+BF0M0MlyeJxxK5o39CxruEZ1D1g
 Dux342/gVvjpQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 01AE01AA2D6;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B4F13ABC47;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 010/107] ppc/pnv: fix dumpdtb option
Date: Tue, 12 May 2026 23:52:57 +0300
Message-ID: <20260512205437.360850-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

The '-machine dumpdtb' command line option stopped working on
PowerPC/pnv systems after recent design change [1].

Fixing this by generating fdt blob in `pnv_init`.

[1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-stable@nongnu.org
Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260311143549.118720-1-shivangu@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit a16d4c2f162a86db1f84ef0836d42eabaf57fe69)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 07a44ccd4c..9f9f3ce4ac 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -741,26 +741,8 @@ static void pnv_reset(MachineState *machine, ResetType type)
         }
     }
 
-    if (machine->fdt) {
-        fdt = machine->fdt;
-    } else {
-        fdt = pnv_dt_create(machine);
-        /* Pack resulting tree */
-        _FDT((fdt_pack(fdt)));
-    }
-
+    fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
-
-    /* Update machine->fdt with latest fdt */
-    if (machine->fdt != fdt) {
-        /*
-         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
-         * the existing machine->fdt to avoid leaking it during
-         * a reset.
-         */
-        g_free(machine->fdt);
-        machine->fdt = fdt;
-    }
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
@@ -1208,6 +1190,11 @@ static void pnv_init(MachineState *machine)
     if (pmc->i2c_init) {
         pmc->i2c_init(pnv);
     }
+
+    if (!machine->fdt) {
+        machine->fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(machine->fdt)));
+    }
 }
 
 /*
-- 
2.47.3


