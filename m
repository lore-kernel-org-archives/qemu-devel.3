Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003D9FDEE4E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1Na-0008Nn-Jb; Thu, 23 Apr 2026 17:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1NY-0008NN-Gw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:14:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1NW-0002ug-UA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:14:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso43947085e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776978868; x=1777583668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sLdK3eQTBsh50F4R80MJsGBz+VRBF+0s/+ksaSNHJ1M=;
 b=Xa57ugN7MsNr8F8v/CBNC7QQ/X1PR3XaJeIM+O7v4uIHhPOCjFo1uiFmZjdTAypKd7
 K2oXy7n+nw4ALoE5ARxRnzBl8uFZlkGRcxkM7hLreChN21nuLp0sacisP1i1Rw9DYH/P
 yp5LqWR3sP2AGuKzfN+2xXOe6wMp14DotwnWewSRuk3zDn+kiFvoVjo5vW7/TQChiN4O
 Vq2a+vO58uVOmuf5ZIdmFH4X1hCxyk3NWGwW3NqvoBsFKjAgluXEQ7L5cJKJ9UB7oLk9
 mAFjw2YVidc3PvIOY+ssRLYeIhZShWgOjGZKMmwOuswLjLhGVyIcEjfeu1QqQjg1gxqc
 ImNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776978868; x=1777583668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sLdK3eQTBsh50F4R80MJsGBz+VRBF+0s/+ksaSNHJ1M=;
 b=rqQ7DVHRmncAKDK/kiY2uIUDiO1UEZ3If+WqS/7xkWwbVafRcQMosx1LlquWxz75/i
 8GLuM6wgAe+S5wTFKMqMVtJUffDayVAS0j6+9X23WBcQ9Gu3XKBacy8kVxGcBb8gy0j8
 OoMX+JgjYnyceSh9e5xkRv/5At3X7fXFMqwX17vRt9/AHBuejhlRF9A/zS5lv8B8EFfP
 OS8xVHgOZmDC9BIh/KwJYA7mt+Boh5k7j44Ay/3v5Zy/U94vpUYM9Nz0F9h3N1Sq1VUt
 toBcm2wTCdNYdz0TQVfB+TPQp4lJiUx69ytic0MNWmxV0XdVO0eCv79m5kgBXJcNCH0t
 e1Kg==
X-Gm-Message-State: AOJu0YyRjxnytplG37FG6M1Try4V/y28o1J3KhMLG4227gqjUkYiemKD
 Dj9ipRMhcmtSN85SGJJLsT9zW1fqpqfogK5W/kVGeWsU6Unlj6oF7IcBPtGYtJElExPhgmzDDsb
 EUZgRE3Q=
X-Gm-Gg: AeBDiescKvMQ1tCpDW23IboCHqmd9k3gVE/1D+Z3TSTfYEtDdGLYIxhwP7m1IO75mZK
 ElGYIB2o2PnYo4fRhHUvOMhTP5sV6AU2z7cDDdUHRaN2JqUFO4TmrViOA12zCyHzy96sIQ/iZFo
 gYkmNdQGVU90fSYhJ843vh0Wn0n8p8cN/6nN4lRhDsZmkQhNUXe9fPc6oQdTY6bFXlH+tMF/wER
 2R28Gf8cDjZochfwBjm8CTta8D0+3PtsjLmIsP9Xqpj6/S5h4Ha+NWoeSI20wI0e5DxPEm2G0kZ
 /g3soD0Kpowtv0ohT9qaGLkQUcpXaVIJtpue8mxWF7sq0FupFw8tZ/5kJEdKRy+oRoXfyh1QQe1
 ItgwEiakWhCkDR1IGoKicEytTXIVCEakY3TMeNyEpu5gyfhENlCsS1+onGC9NWJTTe6eHKCVjqr
 47LWwlgAbq+xmyN3WiHqs2OvHdyXlGzeeD7xUN96qluZIzb8ohprY4NdwsBX2Ks/dk/FzGR/RdP
 itrTpIfKNQ=
X-Received: by 2002:a05:600c:8588:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-4892005b4e9mr167975155e9.19.1776978867725; 
 Thu, 23 Apr 2026 14:14:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a6124d7e7sm80123865e9.5.2026.04.23.14.14.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 14:14:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 40/49] hw/arm,
 hw/ppc: Remove unnecessary audio.h includes from board code
Date: Thu, 23 Apr 2026 23:14:18 +0200
Message-ID: <20260423211418.67186-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423211418.67186-1-philmd@linaro.org>
References: <20260423211418.67186-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Some boards (mostly arm, but also ppc/prep) include audio.h, but they
don't need anything from it.  Drop the unnecessary include lines.

These seem to have been introduced with commits 2b16397264a8e,
b8ab0303de, which added the machine-default audiodev handling, but as
far as I can tell they were unecessary right from the start, as the
machine_add_audiodev_property() function has always been in boards.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260417093805.1076954-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 0bf519b6bb8..03633f3d4fe 100644
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
index 250fdb49b6f..441a11100a3 100644
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
index 7e8acd34acd..7c49995c803 100644
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
index 254b1610b39..c6991a52e65 100644
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
index cc6ae7d4c48..b1787980850 100644
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
index 3ba2736bab3..4e489702743 100644
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
index e973b340992..2672eb9e7a7 100644
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
2.53.0


