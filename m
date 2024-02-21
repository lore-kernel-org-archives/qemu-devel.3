Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B64FC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu0T-0005wO-6p; Wed, 21 Feb 2024 16:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzv-0004ZX-NK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:26 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzh-0001Kl-2s
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:23 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d26da3e15so127025f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550346; x=1709155146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpDez5BJ9vbQ7QvGPKHbANOGqK0wCG2QqegQsAENy/M=;
 b=JhhImJ34pZsm+yXJkMhkg39DZC5rn7ZSVufvqv6DoCpYcp9it9GKYW2BTJFrYdNsOH
 NUwwWGq32qv2M6b9duDLUkgyAtaTeZwl+yvqpwDVoVt/yNaeWGbYUI0Sqzz13ZdUOJyb
 led7Y+1HusAtJypdCDRENxmTSGm17DnxOuT7lTGUfmRvdJUi//2nHQ3gcX1K1O1MgBqw
 Vtp/k2uzM+I0w/AxEn9yurNwmURSbqXfivWB8QzePn6n0Z+nQ0mXMl11Ozj8/BW46wr/
 OWuaLvaeXx6Or+aGF9OIIQcCq7viHcz6PWoyTNmh2/eJ6AOIoPDwW8gRAA+GYdhuz7jl
 3D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550346; x=1709155146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpDez5BJ9vbQ7QvGPKHbANOGqK0wCG2QqegQsAENy/M=;
 b=jT/2aYTJdDVCCK2fJ2knc007ka53yrgSLrj+QWBlc+MW5UG0Zbl30IreGvapbKsKH4
 kNvKRwOWi84QD2Mc4rWMtxvxgrllQqKlWiEShP11/bGFIt+pzeypvlaHCs1UmRB9tKUQ
 hP/5WzvMhSZyYOSJjVhtg/wFGt5gkd1r77LeJkcOWW6CVu5fc8vapUYihNbTtkyjoyqA
 3N05B6apw0/qkhdWYuDUJQXcegmuWvE6fCVw8Sm/eqOtPRGuEfGTD+vrpGX4NL2XrRxr
 KlQQzCJp3qMYrPZ1Cn7e7NA7ZDjPql0ijOGneEW0KinLE3JH2eyr0KIgllTQVr1j+zq5
 KIkA==
X-Gm-Message-State: AOJu0Yw8XS5tSY+eag9TeBu+1e3JC5r8j0eL9CMqoN65dQT7UKuUM78N
 ktFNw/+xuekmi30HnmflUnFeNS0rDQTwwI0Ywzgc9QzEDYN1Wc8RNBq/QvhnQRUS0Ve66JPIsQe
 e7rs=
X-Google-Smtp-Source: AGHT+IEiZ0yx9stEBXUpom8+/tY1+MsXEq20M8a4XHguZUGteJL27fk7hNVVLQyX4kl9h7jI/8coZA==
X-Received: by 2002:adf:f78c:0:b0:33d:3490:6e05 with SMTP id
 q12-20020adff78c000000b0033d34906e05mr639495wrp.27.1708550346251; 
 Wed, 21 Feb 2024 13:19:06 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm17842766wrm.64.2024.02.21.13.19.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:19:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 22/25] hw/ide: Move IDE bus related definitions to a new header
 ide-bus.h
Date: Wed, 21 Feb 2024 22:16:22 +0100
Message-ID: <20240221211626.48190-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Thomas Huth <thuth@redhat.com>

Let's consolidate the public IDE bus related functions in a separate
header.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240220085505.30255-6-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ide-bus.h  | 42 +++++++++++++++++++++++++++++++++++++++
 include/hw/ide/internal.h | 40 +------------------------------------
 2 files changed, 43 insertions(+), 39 deletions(-)
 create mode 100644 include/hw/ide/ide-bus.h

diff --git a/include/hw/ide/ide-bus.h b/include/hw/ide/ide-bus.h
new file mode 100644
index 0000000000..4841a7dcd6
--- /dev/null
+++ b/include/hw/ide/ide-bus.h
@@ -0,0 +1,42 @@
+#ifndef HW_IDE_BUS_H
+#define HW_IDE_BUS_H
+
+#include "exec/ioport.h"
+#include "hw/ide/ide-dev.h"
+#include "hw/ide/ide-dma.h"
+
+struct IDEBus {
+    BusState qbus;
+    IDEDevice *master;
+    IDEDevice *slave;
+    IDEState ifs[2];
+    QEMUBH *bh;
+
+    int bus_id;
+    int max_units;
+    IDEDMA *dma;
+    uint8_t unit;
+    uint8_t cmd;
+    qemu_irq irq; /* bus output */
+
+    int error_status;
+    uint8_t retry_unit;
+    int64_t retry_sector_num;
+    uint32_t retry_nsector;
+    PortioList portio_list;
+    PortioList portio2_list;
+    VMChangeStateEntry *vmstate;
+};
+
+#define TYPE_IDE_BUS "IDE"
+OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
+
+void ide_bus_init(IDEBus *idebus, size_t idebus_size, DeviceState *dev,
+                  int bus_id, int max_units);
+IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive);
+
+int ide_get_geometry(BusState *bus, int unit,
+                     int16_t *cyls, int8_t *heads, int8_t *secs);
+int ide_get_bios_chs_trans(BusState *bus, int unit);
+
+#endif
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 1aab89b27b..d3ec16a945 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -8,16 +8,10 @@
  */
 
 #include "hw/ide.h"
-#include "exec/ioport.h"
-#include "hw/ide/ide-dma.h"
-#include "hw/ide/ide-dev.h"
+#include "hw/ide/ide-bus.h"
 
 /* debug IDE devices */
 #define USE_DMA_CDROM
-#include "qom/object.h"
-
-#define TYPE_IDE_BUS "IDE"
-OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 
 /* Device/Head ("select") Register */
 #define ATA_DEV_SELECT          0x10
@@ -338,29 +332,6 @@ typedef struct IDEBufferedRequest {
     bool orphaned;
 } IDEBufferedRequest;
 
-struct IDEBus {
-    BusState qbus;
-    IDEDevice *master;
-    IDEDevice *slave;
-    IDEState ifs[2];
-    QEMUBH *bh;
-
-    int bus_id;
-    int max_units;
-    IDEDMA *dma;
-    uint8_t unit;
-    uint8_t cmd;
-    qemu_irq irq; /* bus output */
-
-    int error_status;
-    uint8_t retry_unit;
-    int64_t retry_sector_num;
-    uint32_t retry_nsector;
-    PortioList portio_list;
-    PortioList portio2_list;
-    VMChangeStateEntry *vmstate;
-};
-
 /* These are used for the error_status field of IDEBus */
 #define IDE_RETRY_MASK 0xf8
 #define IDE_RETRY_DMA  0x08
@@ -477,15 +448,6 @@ void ide_cancel_dma_sync(IDEState *s);
 void ide_atapi_cmd(IDEState *s);
 void ide_atapi_cmd_reply_end(IDEState *s);
 
-/* hw/ide/qdev.c */
-void ide_bus_init(IDEBus *idebus, size_t idebus_size, DeviceState *dev,
-                  int bus_id, int max_units);
-IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive);
-
-int ide_get_geometry(BusState *bus, int unit,
-                     int16_t *cyls, int8_t *heads, int8_t *secs);
-int ide_get_bios_chs_trans(BusState *bus, int unit);
-
 int ide_handle_rw_error(IDEState *s, int error, int op);
 
 #endif /* HW_IDE_INTERNAL_H */
-- 
2.41.0


