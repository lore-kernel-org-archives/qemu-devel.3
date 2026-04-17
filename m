Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0248F43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfeQ-0005De-9o; Fri, 17 Apr 2026 05:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDfeM-0005CV-Hk
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:38:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDfeK-00052h-QZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:38:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488c2690057so4559235e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776418686; x=1777023486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A141vI3/UoGYhzPPu08TWpps2ytxzNsFg5NMoVqZZ9k=;
 b=KG0BQ8j1cwyGCHJ64ButfNJGuXYseEk5gWAaX7KVyJ4cKZaUNEt87DQJQIotzvpAEs
 cSWzC/HEw9TP6KMt7Ph0hdGFTcF0B+hB0rVNEV8WH4yH5IrZurMz2iwIjqE7GmwdIT6V
 UH+ks4gHBMvCu80w4Jg2bKkM40s/maVbWBRUqWoe/f757NtW1YowlezsCxRRz9XWoela
 tZdUVAAThU2n4AQGxCZ7klHjN9e09/cq+GUs2oudfEoma3+83rdMeM0cLVbfOlfp04fE
 32Tbrb7DGxt1/yT9z6BYy9BSXjUBhmLsLZBLn3sC+/Jfpo6tZWrRoI8IC+eYUIW+qgPR
 htbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776418686; x=1777023486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A141vI3/UoGYhzPPu08TWpps2ytxzNsFg5NMoVqZZ9k=;
 b=IOrvq+vDGhmos9S2ARLUPWPws8vpaLupG+C+HsnIG3PyBvcddmh6AQ2XQNDSpqujQU
 68XYPg8j6ALRUYmP7Zru954TXv5L90O33t14LvwOq6IrVPZFQdZft1HxAj192S3JZwjf
 HvuY+14CvA84mfBsrLojuND2sqAnUvZsJeeLci+1fd3zWTeY28oPIZJV7Zy2gk35FQAB
 QhUBRnNVnhe0vYD7ga1FRAS149VZgraxRZXcauuZ/GWvpJtNr8kbLqo52VjigOyPwPg/
 WqHBCcDAbvTajzFAPi03tkrqvDo3PinZHXYbEaUVgb6JUQ7wqOPazx5u61D5gm1tmamB
 RQdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ85VRZYmhW8ilYTtlTcMPiVPzLa0HMWSLtc8iFX//FegaSNTjNRsKaMcpPfc/taY7LfGzpnwxL+xJkV@nongnu.org
X-Gm-Message-State: AOJu0Yz/DOV6bVTDfmjjCf2hJkKTaEfpyZGjraYxryfhaPgDb1OkyjR4
 oXU4p/JUv7gvTrn83gejF7qEmQI38lRe46qbJSc2C1z+4O1cmXwGjmmZW6V2LxI04gU=
X-Gm-Gg: AeBDiev3oXj+c/c19RGBsLrbGvjM1l/etdwNKrHx2NvjeHzQsOoSkVEVbBo1c43aAqd
 Zize4oJ56IoZb14fLiKKNTBqcc6cjXpTSRPKo9SV/qgreSrk2hq+XBOv19UhI1gWGleFab7eHbQ
 jRzca2d0ckFFt0aifnmxhSnabjq+ZMVhMmt5u2BRqQbV0AMR1N0PBGKxmSmqQWpyg05u6GpG7y2
 UXmxKVeF4WwgUIaBqNbCPDxghxs+bHme8nXXDV9BB+wKB2dl2rkfZUN/riWwEj+YZZgKMmIjrSK
 1xPg6t3crMpuHXfso6L0rso69vuPuGKQ5oEo3De+Zaoc+w1+j+BT2TTAUyEl29TEXKA3n/eVsOt
 Ne03SsvZLIlmgmeJlNpEvX/cIe2xL/gQJ9vNqr1pso4C4nhYbHQ6hGFbxl6B5ZFQIUaBWOc6DeD
 WrFUWs0pRjQjaCluPmUBYV9NROZFOCY4X/+Tp9Q1nepBzZTY6ElGNzGvwDFQCV5mIEDCMb2B2E3
 XDv6jcRZQ5Ufr7+yKF9eTHKEBQj7K4Hrnlr+nXVCQ==
X-Received: by 2002:a05:600c:48a3:b0:488:caed:5ccf with SMTP id
 5b1f17b1804b1-488fb8d1865mr14133525e9.16.1776418686529; 
 Fri, 17 Apr 2026 02:38:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc18bccfsm28611615e9.8.2026.04.17.02.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:38:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH] hw/arm,
 hw/ppc: Remove unnecessary audio.h includes from board code
Date: Fri, 17 Apr 2026 10:38:05 +0100
Message-ID: <20260417093805.1076954-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Some boards (mostly arm, but also ppc/prep) include audio.h, but they
don't need anything from it.  Drop the unnecessary include lines.

These seem to have been introduced with commits 2b16397264a8e,
b8ab0303de, which added the machine-default audiodev handling, but as
far as I can tell they were unecessary right from the start, as the
machine_add_audiodev_property() function has always been in boards.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 1 -
 hw/arm/musicpal.c     | 1 -
 hw/arm/realview.c     | 1 -
 hw/arm/versatilepb.c  | 1 -
 hw/arm/vexpress.c     | 1 -
 hw/arm/xlnx-zcu102.c  | 1 -
 hw/ppc/prep.c         | 1 -
 7 files changed, 7 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 0bf519b6bb..03633f3d4f 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -27,7 +27,6 @@
 #include "hw/core/irq.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
-#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 250fdb49b6..441a11100a 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -37,7 +37,6 @@
 #include "qemu/cutils.h"
 #include "qom/object.h"
 #include "hw/net/mv88w8618_eth.h"
-#include "qemu/audio.h"
 #include "qemu/error-report.h"
 #include "target/arm/cpu-qom.h"
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index c9558be4d4..e9c19e7e6e 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -30,7 +30,6 @@
 #include "hw/core/irq.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
-#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 254b1610b3..c6991a52e6 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -26,7 +26,6 @@
 #include "hw/char/pl011.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
-#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 #include "qemu/log.h"
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index cc6ae7d4c4..b178798085 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -45,7 +45,6 @@
 #include "hw/sd/sd.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
-#include "qemu/audio.h"
 #include "target/arm/cpu-qom.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 3ba2736bab..4e48970274 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -26,7 +26,6 @@
 #include "system/device_tree.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
-#include "qemu/audio.h"
 
 struct XlnxZCU102 {
     MachineState parent_obj;
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index e973b34099..2672eb9e7a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -46,7 +46,6 @@
 #include "trace.h"
 #include "elf.h"
 #include "qemu/units.h"
-#include "qemu/audio.h"
 
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
-- 
2.43.0


