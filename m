Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957E4C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQd-0004rP-GH; Mon, 10 Jun 2024 02:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQQ-0004HJ-7O
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQN-0004aL-HW
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42179dafd6bso9445665e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000553; x=1718605353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y42ro60ATUXrF8F/0Mk1uGOj6R38Ep469XOeFB/EH6M=;
 b=ya5bGNoAPLBrJCpiuG5mIYSTh2vme96IFkxP/lJsDBWB/vzA7f4FmK8TPQmV83vaGJ
 UAnHwU988K7CM6J1RRmrulse26hh+hhjBiWaSs/H+tWv5nRuKoX21MKMOhQ1yv7Wk+Kd
 CgrBX71EkbmQoeE7zhzwsIERwp3iIM+UwmYU/kG5VPTFoFAeNBga+Op4YSrbzLyIxR/I
 GDhv7snlWSC9TqhZya5pn9UyFn/PnRZCixAFYCt3j3goaF0xoTo26lm18N7YOvymMN/J
 WY7WmBZHt/ENd23mNYKXK7NlwrB2V2KE+TuwJYCX6+StEafyTXYgEoKzs1ol+Uu6mfwZ
 sbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000553; x=1718605353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y42ro60ATUXrF8F/0Mk1uGOj6R38Ep469XOeFB/EH6M=;
 b=RR1+uBIwPlG1Ul1QOftQ3wsIfMSzYHWVNklnLSbbl3FKvo7HTsAo3C33V3xaT6/0Oq
 E/ZgWmv+8Ad9vhPFwqTCWgx51p+w1ooa7Wgf4+1npZvHod9JmZPyFCxcFaoiVRLVp5i3
 2mQbSR30mX3ujrzgkCpXDYnz72z6/o8vFwjrKl7oCikJ0gnvWqNq/BfDzvcb9BbPlVll
 cq4/PLBXQ2lB8vo8dhOaJUp3gcHWEJjsCu7WRHtFoecItti1urwzdLj2Re33WRgp1OBb
 KVY4GbMBoFlpkSrxNDjghL1+aKYacMjkCNoNhWPutpaqH8piNJitV2u7DZheI7c23+sm
 9L6w==
X-Gm-Message-State: AOJu0YwK+5c6pJ2swlm+j3DqDjdcmJJYeRlNUMSLIFZpy4JUOb3u1ZHA
 56sF7PepThmY+nhnskG9S7zTqsQ3gpjaxMIK4h91pxp/TPy08ovHjaUVqI25iz/QVKUkCiPW20B
 E
X-Google-Smtp-Source: AGHT+IG1Kjer/tA/hX6buJhpsmWu+IgUGH2jaDF7p5gzsMNg7UblnkM/bHDzg8Zfs8btyZwpmk5GBw==
X-Received: by 2002:a05:600c:198a:b0:421:81b1:7f45 with SMTP id
 5b1f17b1804b1-42181b17f87mr30836005e9.12.1718000553471; 
 Sun, 09 Jun 2024 23:22:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19e572sm130900745e9.10.2024.06.09.23.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:33 -0700 (PDT)
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
Subject: [PATCH 15/26] hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:53 +0200
Message-ID: <20240610062105.49848-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
---
 include/hw/ppc/pnv_xive.h | 2 +-
 hw/intc/pnv_xive.c        | 9 +--------
 hw/ppc/pnv.c              | 8 +++++++-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 9c48430ee4..7d634e469c 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -93,7 +93,7 @@ struct PnvXiveClass {
     DeviceRealize parent_realize;
 };
 
-void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
+void pnv_xive_pic_print_info(PnvXive *xive, GString *buf);
 
 /*
  * XIVE2 interrupt controller (POWER10)
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 3ad4ac8e7d..5bacbce6a4 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -11,12 +11,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
-#include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
@@ -1846,7 +1844,7 @@ static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
                            xive_get_field32(NVT_W4_IPB, nvt->w4));
 }
 
-void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
+void pnv_xive_pic_print_info(PnvXive *xive, GString *buf)
 {
     XiveRouter *xrtr = XIVE_ROUTER(xive);
     uint8_t blk = pnv_xive_block_id(xive);
@@ -1858,8 +1856,6 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
     XiveNVT nvt;
     int i;
     uint64_t xive_nvt_per_subpage;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     g_string_append_printf(buf, "XIVE[%x] #%d Source %08x .. %08x\n",
                            chip_id, blk, srcno0, srcno0 + nr_ipis - 1);
@@ -1897,9 +1893,6 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
             xive_nvt_pic_print_info(&nvt, i++, buf);
         }
     }
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static void pnv_xive_reset(void *dev)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index df187c5180..7e6f923c7e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -808,8 +808,14 @@ static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
 static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    pnv_xive_pic_print_info(&chip9->xive, buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
-    pnv_xive_pic_print_info(&chip9->xive, mon);
     pnv_psi_pic_print_info(&chip9->psi, mon);
 
     object_child_foreach_recursive(OBJECT(chip),
-- 
2.41.0


