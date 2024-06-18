Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D544EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJV-0002Z6-2m; Tue, 18 Jun 2024 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJU-0002WN-6Q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:04 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJS-0007Dx-Ck
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:03 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so6075232a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726640; x=1719331440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/fRH20LiiHNd6n6UxrfG9EvHyIfE/d9iyXREJbBrfA=;
 b=gjRNJPIC4JkJK2X+4gRfoHS9hknM3VAqW05NzP0e1N0Ge+N7kJgVJTuaF17B2xPrFw
 C43C77WZrTzUTxiRfTEw2Y8UwoWhsycE4iPlBo1UfrhRaz5wunrwKqZJxmz8nsPbWoji
 168SW7XeJDDAczeT32YtTu9PXwjMujrOlLcxgc5nwISmheSNVD9R6Ot6DTZKXfFSX33z
 SNTHBP5SttqGtFguFoHUK/p26EGCKmtOIvv+tzS3ndcdlZd45yCi6pU9c9uEmeKMjR3Y
 LFkkSXHmN5+uujvQ59Qq1jp5YJAXPTX6Fxrd3iMm8Ni+ZtC4mJMtKCrdd4Q2TU2jRj2s
 4wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726640; x=1719331440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/fRH20LiiHNd6n6UxrfG9EvHyIfE/d9iyXREJbBrfA=;
 b=eMYHjJwfNQ/XtwXKwdMUfyPW559D+NfiYxkoydxfj0XHUsrL3DmBakpPUsm7QLyOGu
 93gONMmyb9l4i7BIZQndU1y15ZP5Uo/xnoAyXP2Ad+X1aDvH/VZXuJddUYme8G53cY/k
 RXgoVT4tMuj/UQmVbSyoM7jwjo+7mIwzUUWWgGfinLT5oJzhFi3PvtOj3GNCee/LlSib
 lyz0PM1hLQ9T8UvqnjK4/f4NJYt3dxxC8Hij56GVlJTupuVnApAOLvEvq0dMV19VopHw
 PB6HEymnkqIfEzgYd5hM9xmQHkxC4vyyFlzQeKf66/w01b/riFMUOkQZal7jFRs+HaI7
 Fh/Q==
X-Gm-Message-State: AOJu0Yxsyp6gxynib1xTqTZwJiOf0QgpY8BTDUxOe76xdG+dFUv/mauy
 vtJceatkArpuM1/kJ0PGxpOBjWTHgI/YExcsZmToIdytXnX7rd9OD3c8o1sov5RgyH4zyGIrmWk
 f
X-Google-Smtp-Source: AGHT+IFmIWHSWOpj2CzRtduAV6CJQFU7m87V2fSwiFcm/MSYdVIJBqOYkhRz3ZF3n6hYardd3z4QYA==
X-Received: by 2002:a17:906:489:b0:a6f:2253:d1f7 with SMTP id
 a640c23a62f3a-a6f60dc5069mr999916866b.61.1718726640451; 
 Tue, 18 Jun 2024 09:04:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd1fsm625207666b.102.2024.06.18.09.03.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 34/76] hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:56 +0200
Message-ID: <20240618160039.36108-35-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20240610062105.49848-11-philmd@linaro.org>
---
 include/hw/pci-host/pnv_phb4.h | 2 +-
 hw/pci-host/pnv_phb4.c         | 9 +--------
 hw/ppc/pnv.c                   | 6 +++++-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 3212e68160..8abee78e4d 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -155,7 +155,7 @@ struct PnvPHB4 {
     QLIST_HEAD(, PnvPhb4DMASpace) dma_spaces;
 };
 
-void pnv_phb4_pic_print_info(PnvPHB4 *phb, Monitor *mon);
+void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
 int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
 PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
 void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 4b453997e7..99991008c1 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -10,8 +10,6 @@
 #include "qemu/log.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
-#include "monitor/monitor.h"
 #include "target/ppc/cpu.h"
 #include "hw/pci-host/pnv_phb4_regs.h"
 #include "hw/pci-host/pnv_phb4.h"
@@ -1802,14 +1800,12 @@ static void pnv_phb4_register_types(void)
 
 type_init(pnv_phb4_register_types);
 
-void pnv_phb4_pic_print_info(PnvPHB4 *phb, Monitor *mon)
+void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf)
 {
     uint64_t notif_port =
         phb->regs[PHB_INT_NOTIFY_ADDR >> 3] & ~PHB_INT_NOTIFY_ADDR_64K;
     uint32_t offset = phb->regs[PHB_INT_NOTIFY_INDEX >> 3];
     bool abt = !!(phb->regs[PHB_CTRLR >> 3] & PHB_CTRLR_IRQ_ABT_MODE);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     g_string_append_printf(buf,
                            "PHB4[%x:%x] Source %08x .. %08x "
@@ -1819,7 +1815,4 @@ void pnv_phb4_pic_print_info(PnvPHB4 *phb, Monitor *mon)
                            abt ? "ABT" : "",
                            notif_port);
     xive_source_pic_print_info(&phb->xsrc, 0, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index aed6767c8d..df187c5180 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -791,12 +791,16 @@ static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
 {
     Monitor *mon = opaque;
     PnvPHB *phb =  (PnvPHB *) object_dynamic_cast(child, TYPE_PNV_PHB);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     if (!phb) {
         return 0;
     }
 
-    pnv_phb4_pic_print_info(PNV_PHB4(phb->backend), mon);
+    pnv_phb4_pic_print_info(PNV_PHB4(phb->backend), buf);
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     return 0;
 }
-- 
2.41.0


