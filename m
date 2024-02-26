Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FA6C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwv-0001KZ-DD; Mon, 26 Feb 2024 06:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwt-0001JW-DR
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwr-0008Ub-NU
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412a7db191cso2598315e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946102; x=1709550902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fb+zhvtDUVjaJy9yx0kEmbmNVaKip+nPoa65mQ3CZ74=;
 b=uoqg85DiZImRGOAPktifg2IFh0qV3VTt4mpJI3RHD+f6eCuRp8BsdERFusBSMdbHpP
 IExa/kFdqtVXJqztaGqKqpOSsS+Rpoprsrxbm0c701w2ZzLxJf7XwfC0f4T18FVfmgmJ
 Dy7uwv6YCz470xVWo3fNroEfeUWPjb4gndCGP1SKK/nARNcYXxL3+iCVJ8Vjuc4ZiU6L
 hsOJ9OOUuqXQQVm5iOp0j1QBYno6hgJv4i+F7w8tHbyFZqWnjZTHABlU/DfFUJ28Mv4v
 K8Gu7U8CZQ9FByZc/92pAa99gmBd+q4uMEMiOy5vZ7W0iM1dRqf22NnqDIPOfU0LOZ57
 61DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946102; x=1709550902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fb+zhvtDUVjaJy9yx0kEmbmNVaKip+nPoa65mQ3CZ74=;
 b=SSanEflFUZZn0Z4xcIuUhjCY2LrBmB43h0tjyEi+5OaMsKe9uDHlUA1yY9H9NYKoKn
 uNHOfoMq7DV28oxYryu9GzGZhJQD5dIVrE671SXAR4zIkjscCLqHdC2fCpX1+0LiAUip
 e2qLShSu60fk/rWNTvEqg7maB5IrV7hezH0GGn8lOthVWOiurerip++07oIElw7rv0ut
 IpOR31NqCN9av1B/fEEP6zbC9PYIgwGmOagQTFubJ753MQwibvweq999j0Xo76ZBQkfs
 I0Ks9bYXCJeZeldJiqcIfmTtYhahnuVLXWGLmkFkVenBGq71ErOLS9nG1BQUT1V1KmCD
 PwxQ==
X-Gm-Message-State: AOJu0YwRJ3s7MJZSRzlpoUGAPwMrCz28l+kU7tvREtC0S+N5hro7mc4J
 VylvHw3nwHuncQZA8+v7quN0/h844u/7G1I+yqsqWXY35LdUw1bn6zxQj3CpVNjPcTYbiUmAMKI
 N
X-Google-Smtp-Source: AGHT+IF7LFATZZfT8Ux9BwLg+G2Xx0VOnfvsyPF9ZuppNqOBu19kJ5ZBrRwpKtPEEShmP9TAywEu3w==
X-Received: by 2002:a05:600c:4f0d:b0:412:9d49:64a3 with SMTP id
 l13-20020a05600c4f0d00b004129d4964a3mr3410725wmq.24.1708946102740; 
 Mon, 26 Feb 2024 03:15:02 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 jt2-20020a05600c568200b0041290cd9483sm11662999wmb.28.2024.02.26.03.15.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/15] hw/i2c/smbus: Extract QOM ICH9 definitions to
 'ich9_smbus.h'
Date: Mon, 26 Feb 2024 12:14:06 +0100
Message-ID: <20240226111416.39217-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Expose TYPE_ICH9_SMB_DEVICE to the new "hw/i2c/ich9_smbus.h"
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                           |  1 +
 include/hw/i2c/ich9_smbus.h           | 25 +++++++++++++++++++++++++
 hw/i2c/{smbus_ich9.c => ich9_smbus.c} | 15 ++-------------
 hw/i2c/meson.build                    |  2 +-
 4 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 include/hw/i2c/ich9_smbus.h
 rename hw/i2c/{smbus_ich9.c => ich9_smbus.c} (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3f14c28a8..0849283287 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2617,6 +2617,7 @@ F: hw/acpi/ich9*.c
 F: hw/i2c/smbus_ich9.c
 F: hw/isa/lpc_ich9.c
 F: include/hw/acpi/ich9*.h
+F: include/hw/i2c/ich9_smbus.h
 F: include/hw/southbridge/ich9.h
 
 PIIX4 South Bridge (i82371AB)
diff --git a/include/hw/i2c/ich9_smbus.h b/include/hw/i2c/ich9_smbus.h
new file mode 100644
index 0000000000..d6f46ba89c
--- /dev/null
+++ b/include/hw/i2c/ich9_smbus.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU ICH9 SMBus emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_I2C_ICH9_SMBUS_H
+#define HW_I2C_ICH9_SMBUS_H
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
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/ich9_smbus.c
similarity index 95%
rename from hw/i2c/smbus_ich9.c
rename to hw/i2c/ich9_smbus.c
index 208f263ac5..35f526d71c 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/ich9_smbus.c
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
+#include "hw/i2c/ich9_smbus.h"
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
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index b58bc167db..f1a122c5ec 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -2,7 +2,7 @@ i2c_ss = ss.source_set()
 i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
-i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
+i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9_smbus.c'))
 i2c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i2c.c'))
 i2c_ss.add(when: 'CONFIG_BITBANG_I2C', if_true: files('bitbang_i2c.c'))
 i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
-- 
2.41.0


