Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CDEEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMYc-00011s-3a; Wed, 11 Sep 2024 08:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYO-0008L4-P1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYL-000171-FW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5TPiqoqswcpW5f0ntCYsHT0hpanWg27anpDw5EcIfg=;
 b=dxqISCihqN2zRmt8sobTVlsPTKCMdM/bAd0M0Wcm0GrNxr2DeSoBLZzfC7opBrwoNAGrTl
 5R85QYIqMTClP4QZ3FebwYhlpc/LGhmqcpTAUAWMFVOPHWYbjGj+1i+i038X/YDcVf9l64
 4awe69TgY5zUOFAqyKm5VzQg0C9xbBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-eesWlWAAMDmMhsL6PyfTsg-1; Wed, 11 Sep 2024 08:34:30 -0400
X-MC-Unique: eesWlWAAMDmMhsL6PyfTsg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb2c5d634so29110735e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058068; x=1726662868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5TPiqoqswcpW5f0ntCYsHT0hpanWg27anpDw5EcIfg=;
 b=kEsem6J0xOAmQSL9R9iSTl3Hpm2qy7jUdgirJLM33NuaJUNqScOESiSBhFyZm81/Vo
 QY6VT7chQiE9b2IXuvAqA3VeYegr+oQEs7REBiXgZOxesRE5zonVzI3NRDk8FN1y3an/
 zByqczz2JIKRUnExKtzxjXkKzWMIDS3x8reXuDWtBhZA+QucySukAvT73aOwhMu4LK26
 jsztsYuX84FNoZICnwkKDJssavYd02D28F+vtl+Kj182RIgYi9QzjDUZtsF6uNn3KFqv
 EF5HszqAJ1PyJNKNqAOTtC3fVan0P8wq9MGMTMpPXQ/7yZr4oyJ/BLaDeTN0xkQqpBKs
 vpKg==
X-Gm-Message-State: AOJu0Yzcq5eSHT0HgUFPjqSx1pjwBh/i/I/7BQZrbvUZULZSU847hdnx
 XF4ctcHU0rGm97VV8XNI+o55CG9Zuui2fqdB7nYp6tYVhscBaoJvMyK62S8dZ+jlDEcGx3jsK2L
 hRWLCw3zcSkx+Z14yhrojzSaEzIgr9gjlaWCCbpWjbKVph0NRkyqdPhU0+vBCMEUUc3z4y8yzqq
 apFLFS1YpzRfgPmRxXwaFlGD5IUJwfL9uEhgWekEs=
X-Received: by 2002:a05:600c:34ca:b0:42c:b9a0:c17c with SMTP id
 5b1f17b1804b1-42cb9a0c52bmr59733385e9.35.1726058067617; 
 Wed, 11 Sep 2024 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJshuvzk45/tpQ01oZAWmTbwtM2l2Lh2NU6qXc8oe7XPAalBZkRVJ1jTF2n8Xh8UCN24fzHA==
X-Received: by 2002:a05:600c:34ca:b0:42c:b9a0:c17c with SMTP id
 5b1f17b1804b1-42cb9a0c52bmr59733085e9.35.1726058067059; 
 Wed, 11 Sep 2024 05:34:27 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de3aesm11427060f8f.110.2024.09.11.05.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 14/17] hw/char/serial.h: Extract serial-isa.h
Date: Wed, 11 Sep 2024 14:33:39 +0200
Message-ID: <20240911123342.339482-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The includes where updated based on compile errors. Now, the inclusion of the
header roughly matches Kconfig dependencies:

  # grep -r -e "select SERIAL_ISA"
  hw/ppc/Kconfig:    select SERIAL_ISA
  hw/isa/Kconfig:    select SERIAL_ISA
  hw/sparc64/Kconfig:    select SERIAL_ISA
  hw/i386/Kconfig:    select SERIAL_ISA
  hw/i386/Kconfig:    select SERIAL_ISA # for serial_hds_isa_init()

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20240905073832.16222-3-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/char/serial-isa.h | 38 ++++++++++++++++++++++++++++++++++++
 include/hw/char/serial.h     |  9 ---------
 hw/char/serial-isa.c         |  1 +
 hw/i386/microvm-dt.c         |  2 +-
 hw/i386/microvm.c            |  2 +-
 hw/i386/pc.c                 |  2 +-
 hw/isa/isa-superio.c         |  2 +-
 hw/isa/vt82c686.c            |  2 +-
 hw/ppc/pnv.c                 |  2 +-
 hw/sparc64/sun4u.c           |  1 +
 10 files changed, 46 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/char/serial-isa.h

diff --git a/include/hw/char/serial-isa.h b/include/hw/char/serial-isa.h
new file mode 100644
index 00000000000..8517afa128a
--- /dev/null
+++ b/include/hw/char/serial-isa.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU ISA 16550A UART emulation
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2008 Citrix Systems, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_SERIAL_ISA_H
+#define HW_SERIAL_ISA_H
+
+#include "hw/isa/isa.h"
+
+#define MAX_ISA_SERIAL_PORTS 4
+
+#define TYPE_ISA_SERIAL "isa-serial"
+void serial_hds_isa_init(ISABus *bus, int from, int to);
+void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
+void isa_serial_set_enabled(ISADevice *serial, bool enabled);
+
+#endif
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 6e14099ee7f..fca32a532b9 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -106,13 +106,4 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end);
 
-/* serial-isa.c */
-
-#define MAX_ISA_SERIAL_PORTS 4
-
-#define TYPE_ISA_SERIAL "isa-serial"
-void serial_hds_isa_init(ISABus *bus, int from, int to);
-void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
-void isa_serial_set_enabled(ISADevice *serial, bool enabled);
-
 #endif
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 329b352b9a8..b562ec9d37c 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -29,6 +29,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index b3049e4f9f2..fc5db6ed7ff 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -34,7 +34,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "sysemu/device_tree.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 40edcee7af2..05c882669c2 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -39,7 +39,7 @@
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/display/ramfb.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/e820_memory_layout.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f4df8637ef0..7fc4d034550 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/i386/pc.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/char/parallel.h"
 #include "hw/hyperv/hv-balloon.h"
 #include "hw/i386/fw_cfg.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index a8c8c58ef7f..cff756e791b 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -22,7 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "trace.h"
 
 static void isa_superio_realize(DeviceState *dev, Error **errp)
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 505b44c4e6b..1aa5c9613fe 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -17,7 +17,7 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/block/fdc.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/ide/pci.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685b..ffc3f2bca06 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -53,7 +53,7 @@
 #include "hw/ppc/pnv_pnor.h"
 
 #include "hw/isa/isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/rtc/mc146818rtc.h"
 
 #include <libfdt.h>
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 4ece1ac1ffc..a839abbf5d0 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
-- 
2.46.0


