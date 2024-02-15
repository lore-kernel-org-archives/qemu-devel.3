Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED243C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1m-0007B5-Ud; Thu, 15 Feb 2024 13:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1k-00071y-Bs
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1h-0001un-J3
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-411d3c75026so9349195e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019999; x=1708624799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0JMLTzOASp2LTXmqUnI4wsUaudt2sBVolvQqLJvM14=;
 b=jSGPEJYFXQXuoE8+uoZaEdxJEMWYzAwLV17uIA0JOCVXIZ4vxQykpXCbZmZwvm7pKC
 7I3YOm43dG9cHfzU/pbJbDTB8GmwLsIawO6OODp6c94g9m5VEEwh+adTOnv3gDybchuf
 uUaaVo/8FTfa6AkNxQO/pcjlkBXBjReCDU6FqCTzJ8H0eqYHJYXWojzupo2whBXSUKUn
 2DArFN7dlJ3Xxxeajzfz3GpkeklPEtHs0WTwbchCP71bgeRQ1ir9d2EeW8gmnAvC+8Nc
 hTbaidSaahl6ReT1IgLSbwBJ6mVdQP0FZtKoYBS7cAUz5NToOwgRg/4gO4HwWCrtC5kW
 tI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019999; x=1708624799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0JMLTzOASp2LTXmqUnI4wsUaudt2sBVolvQqLJvM14=;
 b=oiK4RmWS5oNpHuqE4/mA95N7MBpVuyaMM8k16kzt1WLlgz0Ix8jcupK7vdKyF/d254
 1U6TfcytapphFlFkjzFaitL946V/PdHPufmpdxLkqgVmC+P1/wJg8+Q+ZexcnHycPSPF
 LdV/MyHAupTlZWvbxnAeT7oFRURwRxxXOw+T4BtqYRpj+a4+J6JLYxvOg97/7I+iUN47
 SJhp7apFcfoKmtFindpinsLt/tnPozeN+oup5pttthU3kwbYu97T+kvSiD1NpXpabxET
 AFiIWolU3xOtv1P4vYvXULB9LHjaymMWiiYlIGS55cUlGXKjJuNBcyQSWpZAr+htY9m/
 jnuw==
X-Gm-Message-State: AOJu0Yz/NT1DbiW0vA03+a1sdVfwN05MVutYYkx53zoxYhjap/L6P9r8
 PSu1YeodDcowwOUnLII+c5SlMZBoPT0/p9nSr5E9Uv7oE5P/xueZIVvnpy4xIinb99GeY53Lf+v
 T9Xk=
X-Google-Smtp-Source: AGHT+IEaWcGRb9ukFzPkT3oA6f1sKO1XMNb3NfWMLKvBO8tFFPKsCzeT/t52oMWK+PiJvro4r9u65A==
X-Received: by 2002:a05:600c:218:b0:411:e27d:522e with SMTP id
 24-20020a05600c021800b00411e27d522emr1957903wmi.33.1708019999176; 
 Thu, 15 Feb 2024 09:59:59 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 k2-20020adff282000000b0033b8808355fsm2427810wro.28.2024.02.15.09.59.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 19/56] hw/isa: extract FDC37M81X to a separate file
Date: Thu, 15 Feb 2024 18:57:13 +0100
Message-ID: <20240215175752.82828-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

isa-superio.c currently defines a SuperIO chip that is not used
by any other user of the file.  Extract the chip to a separate file.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240213155005.109954-7-pbonzini@redhat.com>
[PMD: Update MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                |  1 +
 hw/isa/fdc37m81x-superio.c | 32 ++++++++++++++++++++++++++++++++
 hw/isa/isa-superio.c       | 18 ------------------
 hw/isa/Kconfig             |  4 ++++
 hw/isa/meson.build         |  1 +
 hw/mips/Kconfig            |  2 +-
 6 files changed, 39 insertions(+), 19 deletions(-)
 create mode 100644 hw/isa/fdc37m81x-superio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6..8920ba403d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1357,6 +1357,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: hw/isa/piix.c
+F: hw/isa/fdc37m81x-superio.c
 F: hw/acpi/piix4.c
 F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
diff --git a/hw/isa/fdc37m81x-superio.c b/hw/isa/fdc37m81x-superio.c
new file mode 100644
index 0000000000..55e91fbca1
--- /dev/null
+++ b/hw/isa/fdc37m81x-superio.c
@@ -0,0 +1,32 @@
+/*
+ * SMS FDC37M817 Super I/O
+ *
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/isa/superio.h"
+
+static void fdc37m81x_class_init(ObjectClass *klass, void *data)
+{
+    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
+
+    sc->serial.count = 2; /* NS16C550A */
+    sc->parallel.count = 1;
+    sc->floppy.count = 1; /* SMSC 82077AA Compatible */
+    sc->ide.count = 0;
+}
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_FDC37M81X_SUPERIO,
+        .parent        = TYPE_ISA_SUPERIO,
+        .class_init    = fdc37m81x_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index d85f22db1a..ad9cd129af 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -188,27 +188,9 @@ static const TypeInfo isa_superio_type_info = {
     .instance_size = sizeof(ISASuperIODevice),
 };
 
-/* SMS FDC37M817 Super I/O */
-static void fdc37m81x_class_init(ObjectClass *klass, void *data)
-{
-    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
-
-    sc->serial.count = 2; /* NS16C550A */
-    sc->parallel.count = 1;
-    sc->floppy.count = 1; /* SMSC 82077AA Compatible */
-    sc->ide.count = 0;
-}
-
-static const TypeInfo fdc37m81x_type_info = {
-    .name          = TYPE_FDC37M81X_SUPERIO,
-    .parent        = TYPE_ISA_SUPERIO,
-    .class_init    = fdc37m81x_class_init,
-};
-
 static void isa_superio_register_types(void)
 {
     type_register_static(&isa_superio_type_info);
-    type_register_static(&fdc37m81x_type_info);
 }
 
 type_init(isa_superio_register_types)
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 5df3c09cd5..73c6470805 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -23,6 +23,10 @@ config ISA_SUPERIO
     # Some users of ISA_SUPERIO do not use it
     #select IDE_ISA
 
+config FDC37M81X
+    bool
+    select ISA_SUPERIO
+
 config PC87312
     bool
     select ISA_SUPERIO
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index 2ab99ce0c6..f650b39507 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
 system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
 system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
 system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
+system_ss.add(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-superio.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index afcfb2b8ec..e57db4f641 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,7 +1,7 @@
 config MALTA
     bool
+    select FDC37M81X
     select GT64120
-    select ISA_SUPERIO
     select PIIX
 
 config MIPSSIM
-- 
2.41.0


