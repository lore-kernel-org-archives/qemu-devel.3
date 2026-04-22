Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FE3FA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjZ-0005a7-Fq; Wed, 22 Apr 2026 15:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjT-0005PK-1w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjO-0000vO-3n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso1562483f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887966; x=1777492766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3FA6kV14LHUuP0QpK4mqiTkInujSRm5Anz7/zzy3MKQ=;
 b=Qx6B+FRb1PcCvJUokwhubwFPYOJA/RXaos56rbgavQ8xSX9l1/mZLAZTUyEXMVv5IE
 PTMG0b8i00LylLB/YdFUaGQUf1ZFotE3bBEp58rhKqsO+BJZgOgeK3uQm2tHlpsNsk2z
 +63zBxtnUCi0AUkATXITiSUQQCShruJZHrjbkT0pXut6j+dh6cVgOE4+3S7VwHJ/eBBp
 vLSqBXSJNIl1riZYhrQ22Wi4eH+XnH/bkJ2EVxSl5Ri5g02pOJ17tSql2yjZDBA7HVeg
 rJqfkxGFZFBaPxfVuZTI4u/rTnCFcQmU/8ItOpuckaA+TQSPrElobUFU5f/NP062YV9g
 9SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887966; x=1777492766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3FA6kV14LHUuP0QpK4mqiTkInujSRm5Anz7/zzy3MKQ=;
 b=VdFOIQqfVz9U9HCPLhnDXNsjkvvRECkWTCcZ1MrOh2Ksoc7/hPwsM6RSKdP5LWmBMz
 eEdfv3y3+IFOLVxfXSPVj1JIwABr2EofRXQ6tDnQtOIMpUdw9Lck6zsY4J3b2Kg7DhVS
 lKm3QcEhXCr1jdQLx27+sZssUUevMeIVLt+yqk/KNcAWXKAMynVq3alIGGXCrj4YuNsX
 YdzYX9tPzzwa2gBHQiJH5LIUxyIp/m/Seo9Nqv/d6JvZXl9k/lowfuM7LEfR76XBLDnM
 rmrQsyicMC2ZQ/Fe4UWO7keWVxVlBNj1fHydtPS7BMKd0XtTBnInZ9C+/A+WhOzAQPUb
 mx0w==
X-Gm-Message-State: AOJu0YxVcffYW59+paFAvvPM0mC3rfElX+m4AktLu5AiL63Svh9UESjx
 CnlW9AHSInicbq+hYfDxZLPrQJ5VPRvNwHxys2+DHVk9KvDHSXwDJvXiDjdu+xcK4sDRZXP24up
 ZmSg0QKY=
X-Gm-Gg: AeBDiessQVGPxe1rRgJTMPuWqi0xlRaAz48n1eYpb7qtm2YoAZ8oqSFd3Nrxebp7C/B
 46+aynV0SMuqfByDM89EJ8SuKlHgqkyFzjuX2JpoEPA2lcF3cdyywKnKCvVJY5Nu6RkhiWjAxvX
 uyyYMEvrzRs6HFp5gxNwEyrSmWL2sN5P9T8TCaL1I89ivyF5UQ9RZeEIT9ZBBhDKjYdHJzr2Hoy
 QrfXgvjPLGUo/j8GVkdstcKPkqcti6u6YhthQw6y3OQH82zmoIM+vWzngM1wPQ8ffqq89OsfsOf
 hnjhFQMWp2PIJ6rpxx20VR4pg/xI4AeRClAGo7195F5hXEs4hGvhtxWINl1qgov91HwM/vLh9Uk
 qXtRmyDnVCESHdXNVKIFqO/YyH8zXMwNdpIFftLM/OJyWMokQ8kMB0Mb2oJLq1HEa3cSCYsAHi7
 gSTjUndKjigMeScAvs36DVq9obsrPGa7enquZDsKw3br3XmbEMNc3FWUjIpX7g0SOw5KJSwrqY4
 0ZESwc5QzA=
X-Received: by 2002:a05:6000:208a:b0:43e:531f:720c with SMTP id
 ffacd0b85a97d-43fe407383cmr36091773f8f.11.1776887966482; 
 Wed, 22 Apr 2026 12:59:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb13a0sm47869520f8f.8.2026.04.22.12.59.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/48] hw/s390x: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:12 +0200
Message-ID: <20260422195746.88865-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-32-philmd@linaro.org>
---
 hw/s390x/ipl.h            | 2 +-
 hw/s390x/s390-hypercall.h | 2 +-
 hw/s390x/ap-bridge.c      | 2 +-
 hw/s390x/s390-hypercall.c | 2 +-
 hw/s390x/s390-stattrib.c  | 2 +-
 hw/s390x/tod-tcg.c        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 403cd08450d..fac30763df2 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -13,7 +13,7 @@
 #ifndef HW_S390_IPL_H
 #define HW_S390_IPL_H
 
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 #include "exec/target_page.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
index 4f07209128c..c5a2b17e858 100644
--- a/hw/s390x/s390-hypercall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -12,7 +12,7 @@
 #ifndef HW_S390_HYPERCALL_H
 #define HW_S390_HYPERCALL_H
 
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 
 #define DIAG500_VIRTIO_NOTIFY           0 /* legacy, implemented as a NOP */
 #define DIAG500_VIRTIO_RESET            1 /* legacy */
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 5cdbf098074..c7e49d966ba 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -14,7 +14,7 @@
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "hw/s390x/ap-bridge.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 
 static char *ap_bus_get_dev_path(DeviceState *dev)
 {
diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index 508dd97ca0d..71dc717d08a 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index d808ece3b92..2e83aa211cd 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 
 /* 512KiB cover 2GB of guest memory */
 #define CMMA_BLOCK_SIZE  (512 * KiB)
diff --git a/hw/s390x/tod-tcg.c b/hw/s390x/tod-tcg.c
index 0cc96624e1b..448b531b2ea 100644
--- a/hw/s390x/tod-tcg.c
+++ b/hw/s390x/tod-tcg.c
@@ -14,7 +14,7 @@
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
-#include "cpu.h"
+#include "target/s390x/cpu.h"
 #include "tcg/tcg_s390x.h"
 #include "system/rtc.h"
 
-- 
2.53.0


