Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ACEC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztGn-0002mt-LM; Fri, 28 Aug 2026 05:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wztGl-0002mQ-VF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:53:07 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wztGj-00044R-6j
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:53:07 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id D2D9E240101
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1787910781;
 bh=gMGyejMKTGX0CW1SJrpuUtat5Ad1+A/Mt2eajOklJEc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=l3xRi2UntC0yX6zlX7XNztm7tRTs5+W5TfVDbGre2MTXyffwSqy9T6vPBwZkbUrQn
 Yfwjm1VQvG1rGQzOWnkuKjniAHgpumArrxSXWrRfAyvFH4BbRs9KHG/GEC78V1LJBK
 T46ksKsy9cRBtpCLlWVYWB49Fb57r5CS2yMgGfAini5yME/fmWP2oL9xxtH78cZivX
 ku17csyMkYPw2Q5xTZBBrBnfURPZrW3uLIlLBGnug42ARyhHAXTrze99ycWBaVjXKp
 HQkGW2AQaIr+yNdQuWquFg6EVemASNvLJzTsahkuGmm7W7akrHM29+Dqe+llHv9H5d
 Y5yDEzZBq7ACA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hWYbd1mD9z6twf;
 Fri, 28 Aug 2026 11:53:01 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 1/3] hw/m68k/next-cube: Replace assert()s and abort()s with
 logging functions
Date: Fri, 28 Aug 2026 09:53:01 +0000
Message-ID: <20260828095241.118458-2-th.huth@posteo.eu>
In-Reply-To: <20260828095241.118458-1-th.huth@posteo.eu>
References: <20260828095241.118458-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The next-cube code contains some assert() and abort() statements that
can be triggered from the guest side. Of course LLMs love to complain
about those and people are filing bugs about this. Thus replace those
spots with logging functions to not get bothered about this again in
the future.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4303
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4304
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4305
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 hw/m68k/next-cube.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9a0a57c0cc..c541e6d00c 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -30,6 +30,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "ui/console.h"
 #include "target/m68k/cpu.h"
 #include "migration/vmstate.h"
@@ -620,8 +621,7 @@ static void nextdma_write(void *opaque, uint8_t *buf, int size, int type)
 
 static void nextscsi_read(void *opaque, uint8_t *buf, int len)
 {
-    DPRINTF("SCSI READ: %x\n", len);
-    abort();
+    qemu_log_mask(LOG_UNIMP, "nextscsi_read with len = %d\n", len);
 }
 
 static void nextscsi_write(void *opaque, uint8_t *buf, int size)
@@ -825,7 +825,8 @@ static void next_floppy_write(void *opaque, hwaddr addr, uint64_t val,
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_UNIMP, "next_floppy_write at addr 0x%"HWADDR_PRIx"\n",
+                      addr);
     }
 }
 
@@ -840,7 +841,8 @@ static uint64_t next_floppy_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_UNIMP, "next_floppy_read at addr 0x%"HWADDR_PRIx"\n",
+                      addr);
     }
 
     return val;
-- 
2.55.0


