Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7D8C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDs-0003L5-IP; Thu, 10 Sep 2026 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDq-0003Jh-0r
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:42 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDn-0000Q4-Nq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:41 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 0458C240103
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040737;
 bh=2wYuMywGAbXwTs0965S+FyTgOD7d0hT2lRxy3G8lTsw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=WyXFFhuJva/2C7rMO1MZ7HR76NMe76dscbGbSlUsVI1xvrDQwLpWPEOgkDH5jaNB3
 9EizER08/blzG1hvhq9ICKA5WFf4GF9lk3zkgnDHIVb2wuylrMm1Yfms/yNY6BEGGj
 b9cEGXivYaQifE1FSqevKq9kPE80rqgiDDuhPpif8UYeMCI8IyfgFIdndA1xhuHpqF
 9n8tCI6BKJwReAjDHqsVay83RmFepuFcmVfwYQPPMVapgx2x2a6On2W3IJv/fwgWUD
 XPNWxIFODUSWQyXcGAS0CBxINES8OKDenHOxc9LMti9YsnMSlXgb861U0uiXjwviD4
 N4wPr12T3mkYA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTW2Nhgz6v17;
 Thu, 10 Sep 2026 13:45:35 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/7] hw/m68k/next-cube: Replace assert()s and abort()s with
 logging functions
Date: Thu, 10 Sep 2026 11:45:36 +0000
Message-ID: <20260910114522.396396-2-th.huth@posteo.eu>
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
References: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260828095241.118458-2-th.huth@posteo.eu>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 hw/m68k/next-cube.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9a0a57c0cc..d8cb4a8c23 100644
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
@@ -825,13 +825,14 @@ static void next_floppy_write(void *opaque, hwaddr addr, uint64_t val,
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_UNIMP, "next_floppy_write at addr 0x%"HWADDR_PRIx"\n",
+                      addr);
     }
 }
 
 static uint64_t next_floppy_read(void *opaque, hwaddr addr, unsigned size)
 {
-    uint64_t val;
+    uint64_t val = 0;
 
     switch (addr) {
     case 0:
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


