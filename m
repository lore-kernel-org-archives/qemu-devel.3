Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF46C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWcH-00081o-V3; Fri, 23 Feb 2024 09:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdWVj-000692-L2; Fri, 23 Feb 2024 09:26:49 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdWVe-0008FK-0A; Fri, 23 Feb 2024 09:26:47 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7B8454E602C;
 Fri, 23 Feb 2024 15:26:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id zrz1TTP_eaB1; Fri, 23 Feb 2024 15:26:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 933694E6004; Fri, 23 Feb 2024 15:26:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/ide: Remove last two uses of ide/internal.h outside of
 hw/ide
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Message-Id: <20240223142633.933694E6004@zero.eik.bme.hu>
Date: Fri, 23 Feb 2024 15:26:33 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove last two includes of hw/ide/intarnal.h outside of hw/ide and
replace them with newly added public header to allow moving internal.h
into hw/ide to really stop exposing it.

Fixes: a11f439a0e (hw/ide: Stop exposing internal.h to non-IDE files)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/arm/sbsa-ref.c                 | 2 +-
 {include/hw => hw}/ide/internal.h | 0
 include/hw/misc/macio/macio.h     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {include/hw => hw}/ide/internal.h (100%)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 5d3a574664..f027622a75 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -36,7 +36,7 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/ide/ahci_internal.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
diff --git a/include/hw/ide/internal.h b/hw/ide/internal.h
similarity index 100%
rename from include/hw/ide/internal.h
rename to hw/ide/internal.h
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 86df2c2b60..2b54da6b31 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -28,7 +28,7 @@
 
 #include "hw/char/escc.h"
 #include "hw/pci/pci_device.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/misc/macio/gpio.h"
-- 
2.30.9


