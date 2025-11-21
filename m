Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1B4CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdas-0005a4-8S; Fri, 21 Nov 2025 21:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdZY-0004Qg-Dx; Fri, 21 Nov 2025 21:42:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdYQ-0002oz-TH; Fri, 21 Nov 2025 21:41:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC03E16C6DB;
 Fri, 21 Nov 2025 16:51:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B136321952;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 03/76] hw/ppc/e500: Check for compatible CPU type
 instead of aborting ungracefully
Date: Fri, 21 Nov 2025 16:50:41 +0300
Message-ID: <20251121135201.1114964-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

When using the ppce500 machine with an embedded CPU type that has
the right MMU model, but is not part of the e500 CPU family, QEMU
currently aborts ungracefully:

 $ ./qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
 qemu-system-ppc: ../qemu/hw/core/gpio.c:108: qdev_get_gpio_in_named:
  Assertion `n >= 0 && n < gpio_list->num_in' failed.
 Aborted (core dumped)

The ppce500 machine expects a CPU with certain GPIO interrupt pins,
so let's replace the coarse check for the MMU_BOOKE206 model with
a more precise check that only allows CPUs from the e500 family.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20251015111243.1585018-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 270b28681e369082dc17f58eae2871b75d3e8e6c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 723c97fad2..3d69428f31 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -20,6 +20,7 @@
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
+#include "cpu-models.h"
 #include "e500.h"
 #include "e500-ccsr.h"
 #include "net/net.h"
@@ -942,9 +943,8 @@ void ppce500_init(MachineState *machine)
         env = &cpu->env;
         cs = CPU(cpu);
 
-        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
-            error_report("MMU model %i not supported by this machine",
-                         env->mmu_model);
+        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
+            error_report("This machine needs a CPU from the e500 family");
             exit(1);
         }
 
-- 
2.47.3


