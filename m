Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25B4C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYR4-0007xZ-2Q; Mon, 10 Jun 2024 02:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYR2-0007gU-IW
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:16 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYR0-0004hZ-P6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35f14af40c2so1092484f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000593; x=1718605393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4n9OOqL7M+4IkKSuwlfUH4OM5K7RDG2/fYwnLrV93N8=;
 b=D0FM79fc2UXMYFo088bpazc4Gp+Ah9m0pvNrZmA/Fk3Ga+hNrVwaxU9RbPYUn7UWOb
 uxWqUUl5iED3ozQTkDKzTLrXOvww9gkZEjgPYq59T/dYB1ZfuAVSyRuY4DvaB80a2TyN
 v9lfKnZ8XLrzO92NtoueAFu/kWdPmN1Gw6QCQeJOCG67auCqLzL1V1g0w3e/Xczo3d7h
 PDmcVeFfIqxc+ZtXPw8NN2Vx9K/V3T293hegHoNjp8OI8bJRmJkO3L6613mZaaPamKe6
 RRmG1m7Yyu7co+kMt9PSmM84hcJslXhZ1f0MZpQLa9vb+Rg162PCwLwE6I1+tqhuLx+/
 s1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000593; x=1718605393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4n9OOqL7M+4IkKSuwlfUH4OM5K7RDG2/fYwnLrV93N8=;
 b=Bo6fAOcY9mhgFQOj6IUyxcyIE0O8cWWYl+Du9oBliIiv1LawhC9CK7XyB5Lx+DvDWC
 Wvo/0ILAjZ59TRjNHvAjZgqhY+rl2+zcMnlRU4YrRNpuTHH5ePPKNuELdhydmhlJYBDS
 Ne8N6Nw14WO5kppPhXj4u0CzM40WKHG/A41srqrB04oIV7RwyH9RxAgKurOIOyp2GVoe
 xKXbvGh46DtHsTvkMAik7BtJxORg1sr9R1sGA0RzNkWqk22oS6OIjDB/O7BCmSIMOrtV
 DJm8/+5I0ok7i8JM5/4Zr4GcItuJeIV7CzuwddEBLTgtAi0EA1BGPJbPTJdCP7M26qjw
 LOJA==
X-Gm-Message-State: AOJu0YxqFvU9LlZ5K+Bk1ZtCw/p20c0FAWpY2jY8ZHLDFKdEIIr+6N6I
 4jv0j7QgxhLMtXwvUsLcffVtxS32rl8tcQaEtKQauo40hevrgbuHiMYnmhXJToucTT/ABUBmefC
 Z
X-Google-Smtp-Source: AGHT+IEZMgsqPxoaoTMQn7Afhc9ajwmbTN6xdejJd5pwa18p5UP/4Uj0MXBFV/hwj1aaOg9BDHgSpA==
X-Received: by 2002:a05:6000:22f:b0:35f:caa:1eb9 with SMTP id
 ffacd0b85a97d-35f0caa1f21mr3378081f8f.4.1718000593001; 
 Sun, 09 Jun 2024 23:23:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f224d5151sm2527449f8f.3.2024.06.09.23.23.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:23:12 -0700 (PDT)
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
Subject: [PATCH 22/26] hw/ppc: Avoid using Monitor in
 pnv_xive2_pic_print_info()
Date: Mon, 10 Jun 2024 08:21:00 +0200
Message-ID: <20240610062105.49848-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
 include/hw/ppc/pnv_xive.h | 2 +-
 hw/intc/pnv_xive2.c       | 9 +--------
 hw/ppc/pnv.c              | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 7d634e469c..5b4cb4167b 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -163,6 +163,6 @@ typedef struct PnvXive2Class {
     DeviceRealize parent_realize;
 } PnvXive2Class;
 
-void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon);
+void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf);
 
 #endif /* PPC_PNV_XIVE_H */
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 10914b04df..2fb4fa29d4 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -10,11 +10,9 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
-#include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
@@ -2105,7 +2103,7 @@ static uint64_t pnv_xive2_vst_per_subpage(PnvXive2 *xive, uint32_t type)
     return (1ull << page_shift) / info->size;
 }
 
-void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
+void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xive);
     uint8_t blk = pnv_xive2_block_id(xive);
@@ -2117,8 +2115,6 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
     Xive2Nvp nvp;
     int i;
     uint64_t xive_nvp_per_subpage;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
                            blk, srcno0, srcno0 + nr_esbs - 1);
@@ -2156,7 +2152,4 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
             xive2_nvp_pic_print_info(&nvp, i++, buf);
         }
     }
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4a1a302a25..5b9dbff754 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -864,7 +864,7 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
     g_autoptr(GString) buf = g_string_new("");
     g_autoptr(HumanReadableText) info = NULL;
 
-    pnv_xive2_pic_print_info(&chip10->xive, mon);
+    pnv_xive2_pic_print_info(&chip10->xive, buf);
 
     pnv_psi_pic_print_info(&chip10->psi, buf);
     info = human_readable_text_from_str(buf);
-- 
2.41.0


