Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D99C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQF-0003nh-Cn; Mon, 10 Jun 2024 02:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQ0-00038N-ER
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:12 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPv-0004RP-3u
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:08 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so8307361fa.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000525; x=1718605325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rw+kbtFvGBPcHZTq2AbRKqK9FSuZ88ZupuV0Vb6iIFg=;
 b=HMRgfTPKDDN0uDnu2JRqbAYfQHKSWUfrxFiyyOQyi7OEWdDf7U1u3qs/wH8pjZTWLO
 J1+Dwxrt4GsLH/I+eI2jdNRq+TU32dj5a/bGJL9s5bilsNmo908x0qgHqbhu2GSEFkJv
 4AV4b8fQh5LYZMahma590DBE7rD1edCP7NWoRWVRn/sNLKDTUx2NX5Mhp9aqh4ayaBAW
 nUReXEDNoPFWRluLFrSSGaGhHqPunkthmiLBLN5jYoHw9r5wZ6qdDrdqBvkup0Z88FJj
 FrPuoQCksM7a5y01BPUQMv7yUM/zDi4/xuGVxqmZDl8Zn3bkIEEWoKJeya+DvLyTKJtr
 kteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000525; x=1718605325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rw+kbtFvGBPcHZTq2AbRKqK9FSuZ88ZupuV0Vb6iIFg=;
 b=Ij3e2aejzOx14PmzKUVws0w5WXHiWRp+tboLlRCCHgQk4hik0eokY15cz9Uy8ut2JE
 Y0L7WKG0VnfVPm1bCQRhSOWslHAoj7zuKFgG7ievI9yk7zdY65JkAJyRG9lSxQ9hlkk9
 zG1AUW26PT2S7LJSXAsBPES6oc5Qcag5oHBhOq1r9EqfYMgbVVnkXpQCnAoPImQ/71eS
 36Ay/Jrw9H1hzg+UVFbA1gFovnyJmdMIZOY4z4bHUfoGisLgCotVIZDe2Dh16cDfh489
 1ZRKrr3mkRTC/BLIR+MpeuOSNtgrmAxTRUOUfwiDugO5kLsfCiaROj1x5sUemnwDK00g
 N36g==
X-Gm-Message-State: AOJu0YyM1icJdOVQpKvfPRPGzHgUoAefrz4RKkbPO+YFLP4Ov6yJ3hU/
 sS4S8eTqVAtquHp/dW5u21EwaCp3qo7Bkf28h/c7BwmuMYzTXIs1TIE0VQkIwFXJVrUCW2bZtoJ
 V
X-Google-Smtp-Source: AGHT+IHtUh3X2HHYnzq5x7bFVBXacxvAUoY7IlDTqnQBtlNWWdoigQZouMOu9jMm1vhAg7VPJiYWyg==
X-Received: by 2002:a05:6512:3b09:b0:523:91af:12d9 with SMTP id
 2adb3069b0e04-52bb9f66a7bmr7170529e87.9.1718000525125; 
 Sun, 09 Jun 2024 23:22:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f23fe7a64sm1839557f8f.89.2024.06.09.23.22.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/26] hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:48 +0200
Message-ID: <20240610062105.49848-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


