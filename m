Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9060FCCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJc0-0006rK-He; Tue, 04 Nov 2025 11:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbf-0006hr-3y
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbb-0007L6-4n
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so46285835e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272595; x=1762877395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5jT1nanV2HTon+gYa/5KcgwK7C7VkPnRzMePhdCgTY=;
 b=nwrdCwc5ls6sg6CzMLOwhMtNv7DFaTdy59KcbY3Y9yvX28+/oiMV9/Iz0tuvKtwUOq
 WdqNGBO7ZFN4OLFKR0VRFOemr4HW31wj3qMEgUrrDL/fpea4AfebWwzVStzZF0p77/Wf
 VXNZoynTuuMmSBXYHS8gsQFWrABoe9+OJxeTLo1xbOqg5lR5Fxw2x/HseF245cqfi0I5
 OROHvesJT6QgQbJy2InSUT7pE/lu0i4OHGnoUL5oaebp45m4/3yV6S9/HmmxFzZs7HfD
 eUa+ot0Ws+AhFakdrnpYaxVJ4uN+HpaMgVw1IXN1epyS/UMQBep8VviVCS4YYhdCibiP
 YDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272595; x=1762877395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5jT1nanV2HTon+gYa/5KcgwK7C7VkPnRzMePhdCgTY=;
 b=FFAvzqdBFeH7BhPoBCblSu//uB9iDpk5UN8/bstCzXZuqah792ve3hCmExHEj6qvGY
 YWXgIKp7QJHer79T2XfARrFOaxcdG944Naq1/VMpeJv2TqyX1rKx5IpAWdPieuWmNvFE
 VOcQwDhnvQFdmtSpi7kILHyPVE3vTryKMCeh7ERgWgPb4SheBmfiATFYyxLa9/LRa/81
 +mHJMkaSiXFLUe2jdqu6GQvFWsUv63v8/15eL9VOYhS9AcCQ2wnk+eaUxgjU/ILAgiAG
 fnULJOjgpt2b0Seu2oKtEA3d9yTwu+543CqpbDiU1E5V9+MNf3HLG+shJiHsshdOSMmM
 tZ/g==
X-Gm-Message-State: AOJu0Yz+HBS7OuPGBmsed5H23K/Nz10gcPHQI9UgvC3LkphzUwre8Lql
 DZdtPdgo7Dw94pkP8dPSuXE8QuAoAPOc8TjDuF5fXIpoTW/NKYLXBa9W4VbZwdUn48MVmOg7VVp
 cSy07
X-Gm-Gg: ASbGncvH23L2XtjH01p7pQmAxTWcSlU4NYGvNbQUUkMPFdzf6w/zelNMJiRyf3ZEJCx
 rEvNlxJmn3txOsfAJWAqRRxFaMq9sR1pBeNwUbtXw0zo4TrxucAwjG9zW5r7S42/4+hhylXA33B
 Xxt6zc+GJDtrEAK4/Ep63PDASV3BWKJXd/YERwlKlkHnKD46iZ2IfZjhXdFkpADxwLvS1WqJ97I
 jtdgbUjtIVZwYSKf5+KrwiGdr3ODRLQL3cyvI1iBNo0wjTz7qOvuoW+7CpDcQ1d8uHuawTKuqMB
 E+T8v5EldT9TNR2oOjDrYSGjyTHfnulErVM9Vitct2EZJRoY5QU1xCdUqrjx19/SlX17spnKY1Z
 +Gt9sb3y3oFBmuqMIdyCk6mjWGV2I0wo4Dpwr1NmRfmk1Bp6NLCMePWTuLPRt/QPcsvL3BMWkZT
 elCVE/T7a8r/xEZkuo
X-Google-Smtp-Source: AGHT+IFw0mHTVNQTPpVDHWOwRPNu28SoSm3vy3a0r7q4kvLWFQ2x1D7XC+YLnA6naNfmkaD+uC53Zg==
X-Received: by 2002:a05:600c:190d:b0:46f:aac5:daf with SMTP id
 5b1f17b1804b1-477308dbefdmr162934445e9.35.1762272594606; 
 Tue, 04 Nov 2025 08:09:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 8/9] vfio: Clean up includes
Date: Tue,  4 Nov 2025 16:09:42 +0000
Message-ID: <20251104160943.751997-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git vfio hw/vfio hw/vfio-user

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/vfio-user/container.h | 1 -
 hw/vfio-user/device.h    | 1 -
 hw/vfio/pci-quirks.h     | 1 -
 hw/vfio-user/container.c | 2 +-
 hw/vfio-user/pci.c       | 2 +-
 hw/vfio/ap.c             | 1 -
 hw/vfio/container.c      | 2 +-
 hw/vfio/cpr-legacy.c     | 2 +-
 8 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index a2b42e3169d..c952e090631 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -7,7 +7,6 @@
 #ifndef HW_VFIO_USER_CONTAINER_H
 #define HW_VFIO_USER_CONTAINER_H
 
-#include "qemu/osdep.h"
 
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio-user/proxy.h"
diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index d183a3950e2..49c05848f1a 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -9,7 +9,6 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "qemu/osdep.h"
 #include "linux/vfio.h"
 
 #include "hw/vfio-user/proxy.h"
diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
index d1532e379b1..a6282e063a1 100644
--- a/hw/vfio/pci-quirks.h
+++ b/hw/vfio/pci-quirks.h
@@ -12,7 +12,6 @@
 #ifndef HW_VFIO_VFIO_PCI_QUIRKS_H
 #define HW_VFIO_VFIO_PCI_QUIRKS_H
 
-#include "qemu/osdep.h"
 #include "exec/memop.h"
 
 /*
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index e45192fef65..dab7a23224c 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -6,9 +6,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#include "qemu/osdep.h"
 
 #include "hw/vfio-user/container.h"
 #include "hw/vfio-user/device.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index b53ed3b456f..353d07e7819 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <sys/ioctl.h>
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 7719f245797..3368ac89150 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -10,7 +10,6 @@
  * directory.
  */
 
-#include <stdbool.h>
 #include "qemu/osdep.h"
 #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ddec300e35..013a691bc5a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -10,10 +10,10 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
-#include "qemu/osdep.h"
 #include "system/tcg.h"
 #include "system/ram_addr.h"
 #include "qapi/error.h"
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 7184c939912..273b5978806 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -4,9 +4,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#include "qemu/osdep.h"
 #include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
-- 
2.43.0


