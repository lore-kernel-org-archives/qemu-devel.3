Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A3FC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6gh-0003Qf-SB; Mon, 19 Feb 2024 11:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6ge-0003AX-H9
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:12 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gc-0003Hk-KF
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:40:12 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40fd72f7125so37727045e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360809; x=1708965609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3uRtm+UhgX23rdC9bJKVvQF8N8ZLI8dwwAO65r+PJ0=;
 b=EbljZkA/eq6Md6EybymS3SA/+562WW6Nrc1XEuDk0qxJ5ah+5/0WqcuXKUjflQ7lZb
 XHoQ32qg/0TVN975oh7pXAH5RZ1DJzp0tT6GGI9QXh/YpRVL5zwRnPPo+JwHP95JLQOq
 uS40kT1U66RTGKi/WaGfm7Vhk8OfzkAnPBwEY167R8BsBTuYmpoYY6IDe7ahSBueUtFm
 AKom226KEziCQC6muTTQ4RzX3DVu35TDtDuP3WjTs1UE9rNUtRCcPatJ+iVTX9Gyqhok
 zd+UzvjuoTjaDm7t/AqWPRbSspLS7h8CknNSQ9bzQw+2tLesFa/Hic1PYvSG+5rlA0V0
 YjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360809; x=1708965609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3uRtm+UhgX23rdC9bJKVvQF8N8ZLI8dwwAO65r+PJ0=;
 b=HvDUFuHsBAuDT19ofG+S45nu7su35N/qwXuPfBGgF5ogIFzXiSq578POzobVDn6kVB
 agrLA80sv3c5m1zKcaWn3JFKndU1xDORQRxdzIS4g0CyIW50gc2ORsxzSd9eu/NG9gem
 MANoVDpJ33opFqvwG4k1deELgU0zdhdIXs51JOHhmIEBtysp6P9ENBljqbNvK+vJBch9
 occ/vTlj/ZaEAS6tQ5QQJpzDVvMZJU5ta9jDv1XAdibT+rnRawWoADi0Vpng00JqIxp8
 ObayoXONg8zC2szEImbVOw6wHkWUbm62ZzFl2L5oqdwMMIYG44902sxnYGDZW+df16Iy
 u0hw==
X-Gm-Message-State: AOJu0YyM0BqRADoEozt8XW8ulECEEvb2eDdFWHxlDLeiXAENr6vgDSRE
 KkFZyleTFD9YjKv7Q3HlruqSpdp5cCQHAEwusxMIxUNKJZLLtNg7XeEoUFU3YGmSy83WS7gKUSI
 u
X-Google-Smtp-Source: AGHT+IFgrOLKLNhDnObcbHz3HuhLySJlS12CZ4KOq2ceG+xaCxZ+ZJKWQYOoNsGHPrWnHuFr5jnmjw==
X-Received: by 2002:a5d:5f47:0:b0:33d:5d4f:a45a with SMTP id
 cm7-20020a5d5f47000000b0033d5d4fa45amr1881140wrb.22.1708360808807; 
 Mon, 19 Feb 2024 08:40:08 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600011c500b0033cf095b9a2sm10827520wrx.78.2024.02.19.08.40.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:40:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/14] hw/i2c/smbus: Extract QOM ICH9 definitions to
 'smbus_ich9.h'
Date: Mon, 19 Feb 2024 17:38:50 +0100
Message-ID: <20240219163855.87326-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Expose TYPE_ICH9_SMB_DEVICE to the new "hw/i2c/smbus_ich9.h"
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                 |  1 +
 include/hw/i2c/smbus_ich9.h | 25 +++++++++++++++++++++++++
 hw/i2c/smbus_ich9.c         | 15 ++-------------
 3 files changed, 28 insertions(+), 13 deletions(-)
 create mode 100644 include/hw/i2c/smbus_ich9.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 937ebb5c96..b896d953af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2611,6 +2611,7 @@ F: hw/ide/ich.c
 F: hw/isa/lpc_ich9.c
 F: hw/southbridge/ich9.c
 F: include/hw/acpi/ich9*.h
+F: include/hw/i2c/smbus_ich9.h
 F: include/hw/ide/ahci-pci.h
 F: include/hw/pci-bridge/ich_dmi_pci.h
 F: include/hw/southbridge/ich9.h
diff --git a/include/hw/i2c/smbus_ich9.h b/include/hw/i2c/smbus_ich9.h
new file mode 100644
index 0000000000..d716cbca33
--- /dev/null
+++ b/include/hw/i2c/smbus_ich9.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU ICH9 SMBus emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_I2C_SMBUS_ICH9_H
+#define HW_I2C_SMBUS_ICH9_H
+
+#include "qom/object.h"
+#include "hw/pci/pci_device.h"
+#include "hw/i2c/pm_smbus.h"
+
+#define TYPE_ICH9_SMB_DEVICE "ICH9-SMB"
+
+OBJECT_DECLARE_SIMPLE_TYPE(ICH9SMBState, ICH9_SMB_DEVICE)
+
+struct ICH9SMBState {
+    PCIDevice dev;
+
+    bool irq_enabled;
+
+    PMSMBus smb;
+};
+
+#endif
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 208f263ac5..3980bca4c5 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -1,5 +1,5 @@
 /*
- * ACPI implementation
+ * QEMU ICH9 SMBus emulation
  *
  * Copyright (c) 2006 Fabrice Bellard
  * Copyright (c) 2009 Isaku Yamahata <yamahata at valinux co jp>
@@ -22,8 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/range.h"
-#include "hw/i2c/pm_smbus.h"
-#include "hw/pci/pci.h"
+#include "hw/i2c/smbus_ich9.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
@@ -31,16 +30,6 @@
 #include "qom/object.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(ICH9SMBState, ICH9_SMB_DEVICE)
-
-struct ICH9SMBState {
-    PCIDevice dev;
-
-    bool irq_enabled;
-
-    PMSMBus smb;
-};
-
 static bool ich9_vmstate_need_smbus(void *opaque, int version_id)
 {
     return pm_smbus_vmstate_needed();
-- 
2.41.0


