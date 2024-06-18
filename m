Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D5C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKI-00050q-S1; Tue, 18 Jun 2024 12:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKC-0004wK-87
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:50 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbK8-0007Js-Kx
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:47 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so724863066b.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726681; x=1719331481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1+oxv23q6Bk7GlvZzdYo0BA6/qyvhXfndKAl5a7yhw=;
 b=MX+jzLPHufI/r2Z3CzQvMTzGEtQBo33yIt6Fl+2Jc5D9vJ34WvyPkW1AErz6d2A3f6
 kdoWrUrp1xvS7Mkleyf6gUHAFxFFStP8KFgi6R7iJ5xydHOTURv86slat8sJkCO6xgJy
 7asXO6oFLhYqwA9i/ZB9N9v6YgbXB61undYDaq/eCopsdk39hiVhxc1P8rC0lyugsy+q
 QyXk4hGKbv9zNeUeKlV6j4Kja98W0m28W0juy6NkH55KSjDWhBMrOJvDo4YIIuz7Hwop
 ySsV2zCTlLMz0TtuQNgdORAlXYJmXIsBN0F3CdOx1VJTKyT+hvIt8/jtVR4M4eX6YOWN
 R4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726681; x=1719331481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1+oxv23q6Bk7GlvZzdYo0BA6/qyvhXfndKAl5a7yhw=;
 b=HWthAN0Htpt/8DDn8rYgosu6h+jY4yC+KHRHHGgpTtHi3zkN/KCTrEno8nyf7eIFgr
 9Nh5urBY4VMCOjLNWe9mfqGUJCjoClk0JvKDB49r+oHp84QQAPlnERR9K8e5iX7+ZSbW
 bSgfc3oau/+VQTHKjo/32TkcYlbm5dBtjMR9hz8lxWz2kMOJ9suNYclNT6F4PrpCItoY
 J4betDmdjy/bOPmallsJZWLjJqDwDJ478wwHlNiGfP4j/3ACYven+NmEu2xlt3QSmJxj
 0p/prvrZl8g1YImN+zf1ldlkaZD4arc9Lolqt9SQ+cNxLHeJvdOTh9qf5w0MrrNlhdGr
 Co6A==
X-Gm-Message-State: AOJu0Yz4NGJV0AoC/gojr88AFcBrvDsw4PhFMgbn9jSoNHK2pYlLiyj4
 b2vQzOoojIuu5DLll5k3LuIljw+R9SHBFhWH6VfrOgv9vwrB7PmzuvrUHqPwD7LJV9ZKIKvrVbw
 v
X-Google-Smtp-Source: AGHT+IGQ9jOhD4h5NHb32sjYRi0HHQQZHyshTdwxVV4bI9HPWKXsJOk9Z2FPg1chTxEI30sPyV6NWQ==
X-Received: by 2002:a17:906:3848:b0:a6f:507a:b0fe with SMTP id
 a640c23a62f3a-a6f60dc4ed6mr899341066b.62.1718726681325; 
 Tue, 18 Jun 2024 09:04:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f7ea3a5c9sm302023166b.169.2024.06.18.09.04.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 41/76] hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:03 +0200
Message-ID: <20240618160039.36108-42-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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
Message-Id: <20240610062105.49848-18-philmd@linaro.org>
---
 include/hw/ppc/xive2_regs.h |  2 +-
 hw/intc/pnv_xive2.c         | 16 ++++++++--------
 hw/intc/xive2.c             | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 816f5d0e84..f662f0e325 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -48,7 +48,7 @@ typedef struct Xive2Eas {
 #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
 #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
 
-void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, Monitor *mon);
+void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf);
 
 /*
  * Event Notifification Descriptor (END)
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 83e0f6b09f..649e5001fd 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2120,24 +2120,24 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
     g_autoptr(GString) buf = g_string_new("");
     g_autoptr(HumanReadableText) info = NULL;
 
-    monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_esbs - 1);
+    g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
+                           blk, srcno0, srcno0 + nr_esbs - 1);
     xive_source_pic_print_info(&xive->ipi_source, srcno0, buf);
 
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
-
-    monitor_printf(mon, "XIVE[%x] EAT %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_esbs - 1);
+    g_string_append_printf(buf, "XIVE[%x] EAT %08x .. %08x\n",
+                           blk, srcno0, srcno0 + nr_esbs - 1);
     for (i = 0; i < nr_esbs; i++) {
         if (xive2_router_get_eas(xrtr, blk, i, &eas)) {
             break;
         }
         if (!xive2_eas_is_masked(&eas)) {
-            xive2_eas_pic_print_info(&eas, i, mon);
+            xive2_eas_pic_print_info(&eas, i, buf);
         }
     }
 
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
+
     monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, blk);
     i = 0;
     while (!xive2_router_get_end(xrtr, blk, i, &end)) {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 98c0d8ba44..0154ebb59c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -27,17 +27,17 @@ uint32_t xive2_router_get_config(Xive2Router *xrtr)
     return xrc->get_config(xrtr);
 }
 
-void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, Monitor *mon)
+void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
         return;
     }
 
-    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
-                   lisn, xive2_eas_is_masked(eas) ? "M" : " ",
-                   (uint8_t)  xive_get_field64(EAS2_END_BLOCK, eas->w),
-                   (uint32_t) xive_get_field64(EAS2_END_INDEX, eas->w),
-                   (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
+    g_string_append_printf(buf, "  %08x %s end:%02x/%04x data:%08x\n",
+                           lisn, xive2_eas_is_masked(eas) ? "M" : " ",
+                           (uint8_t)  xive_get_field64(EAS2_END_BLOCK, eas->w),
+                           (uint32_t) xive_get_field64(EAS2_END_INDEX, eas->w),
+                           (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
-- 
2.41.0


