Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC346E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSS-0007oR-87; Fri, 06 Dec 2024 07:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRX-00062n-MJ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:25 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRW-00047J-54
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:23 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-7f43259d220so1366380a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488100; x=1734092900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMVtNuBqtIXXm2C24hwxrJtPRQT47P73SaeeHd2lWK4=;
 b=NQctH7kvEmWVFI7CeCVq1+j/WvAumC9T7WQerc2CEU2SCFZuEFSOfSp/67kc84nHsu
 k9Y9CzY7t56QSTbbmeowAnutOZv225IA2HmF5Ly+ELEQbx+HJdAXtq6FYS1oeZsdsI1+
 4/Vfp1DY2/stPIcMtD5+4V1AnzuYXfXI+UfP/NCcvT3IBZQ9dGsshkVzeGfuXu+ft3+y
 qrPBpyK10x2TMHT0RwG+5MuXEvZjIQZzzx40TNNl+/DiFf6WvSh8GpRVrE4koC/CKOGf
 nhCgHzLjwNhYXOUcwMf/6wdR0YC//f7tqQitlkXIFVKcgFJcBWBVO3QtQiAIWULMTWiq
 63IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488100; x=1734092900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMVtNuBqtIXXm2C24hwxrJtPRQT47P73SaeeHd2lWK4=;
 b=IfB/PVVzYbTz8GRld+W92YqhjGgWsTGnItCV4j/k0DUVBCvdnNXphMQnImJUbmjJRn
 pb0m1DM/4T/Aqa9PZHkBtPuRmaIMXBylDblggXdcyNkrbCqBeXJH5IKiOOzXMu/Cw0zV
 tfHlKQrKkoebcdqBfyPWNRJeguVhEmNT5McbIH/UCA9UuD5TxSDfZgMrnjf3UX+HnXX5
 65YXAh2Txb3PSutqgd0fihMHyZehrpx2KeJBDnJheRyqFpe+rKuPap90yrOKt2X0PXhn
 OPwQkpqNYu2inK7EBERtYTN6KynnHILGxtsYud0/WiMT+S36eF5AWTMIGNqKAcZQNIzd
 SYug==
X-Gm-Message-State: AOJu0YzGDJOMXMKGRn7LjPKWS+B5x6WEdMk8mB+El2PtaIh/JAcV0rBP
 ummvX6cPd8L7lM1k2BX0Ra98ViRRij0phhi4/6gw+VbPgzdiREM=
X-Gm-Gg: ASbGncusGFVxO75zCRKuve0QUF8O6SCVjLqFaAf0EhGylnFJkbAjfXhT6IjT2Xxgy+Y
 X7BCzCR/wNuj4NfYe5bcvHHQIxKD6wvp5cZwgF+HEdew5cFI9pgIaqP8K0mShmIISPUTLZuUi7q
 E+L5nKXSZC6V4OQ3xfTEdaxoZuXv83F1FqEVr2A0BhZGoHhaa8X9JGtc6UCvRqr4+C12j9QpZ4O
 i6WCM96rSgPOjfzcdjjle+/wxop1eiJSwEHPPCF4W0/voMPhOCOgHdKtQ==
X-Google-Smtp-Source: AGHT+IFdzu6UBx6uy8wj9XCQFmYeHr/v0kMEdPLe1RtkivWLvxnhflrseuRRC/x5+4679b0O8esaog==
X-Received: by 2002:a05:6a20:4324:b0:1e0:dbc6:8647 with SMTP id
 adf61e73a8af0-1e1870ad665mr3957896637.1.1733488100421; 
 Fri, 06 Dec 2024 04:28:20 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:28:20 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 10/10] vfio/igd: add x-igd-gms option back to set DSM
 region size for guest
Date: Fri,  6 Dec 2024 20:27:48 +0800
Message-ID: <20241206122749.9893-11-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

DSM region is likely to store framebuffer in Windows, a small DSM
region may cause display issues (e.g. half of the screen is black).
Since 971ca22f041b ("vfio/igd: don't set stolen memory size to zero"),
the x-igd-gms option was functionally removed, QEMU uses host's
original value, which is determined by DVMT Pre-Allocated option in
Intel FSP of host bios.

However, some vendors do not expose this config item to users. In
such cases, x-igd-gms option can be used to manually set the data
stolen memory size for guest. So this commit brings this option back,
keeping its old behavior. When it is not specified, QEMU uses host's
value.

When DVMT Pre-Allocated option is available in host BIOS, user should
set DSM region size there instead of using x-igd-gms option.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 73c06bbf64..b0fef90240 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -14,6 +14,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
@@ -722,6 +723,31 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
+    /*
+     * Allow user to override dsm size using x-igd-gms option, in multiples of
+     * 32MiB. This option should only be used when the desired size cannot be
+     * set from DVMT Pre-Allocated option in host BIOS.
+     */
+    if (vdev->igd_gms) {
+        if (gen < 8) {
+            if (vdev->igd_gms <= 0x10) {
+                gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
+                gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
+            } else {
+                error_report(QERR_INVALID_PARAMETER_VALUE,
+                             "x-igd-gms", "0~0x10");
+            }
+        } else {
+            if (vdev->igd_gms <= 0x40) {
+                gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+                gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
+            } else {
+                error_report(QERR_INVALID_PARAMETER_VALUE,
+                             "x-igd-gms", "0~0x40");
+            }
+        }
+    }
+
     ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
-- 
2.45.2


