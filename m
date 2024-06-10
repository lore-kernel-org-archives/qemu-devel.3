Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE1EC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQT-0004Hf-TP; Mon, 10 Jun 2024 02:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQE-0003hb-La
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:26 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQC-0004Yu-HP
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:25 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52c819f6146so1840266e87.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000542; x=1718605342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDceS+tqCYF0MQZ5iXvWhCNVizg2COfjxHxnorTwaDQ=;
 b=YG45/8c9iFaJ6HAh39T3fAbHBw390MggBqe+TwTmWFYAayI8coeIE2aVn/ZkyFoPO+
 F3lpGgrwVI5x3N6xHBtK0Y32CRNktRZLV3tGdLIGH24v6GqNHd1PfOUxTsR4aZqp52kF
 JnKnbClPGW7hw5zce2V+6EY6X5gf2IIezV34felr4tDtJCXFyMFxXzJ0FGO9BCLgboN1
 OWBL+C9hIsk22LH/p1Q72s3CJK4mKprc1ZCwh71wcP7HSBCx47MPKVC74DOnPlwDuPVw
 WmNkHUwNgg+s0HdQ9/Pv57mGnTQIGsXkxnwwcMM8IpLM0l3IGRmVfzDw9SjTxchRoFic
 8j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000542; x=1718605342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDceS+tqCYF0MQZ5iXvWhCNVizg2COfjxHxnorTwaDQ=;
 b=FtLcom27Qkg4azpC40YZqAAYm747eVkeAbuW8+4szDnnErXPhUOAdvmXytJCTPeItT
 XWenfigd7skIXPLHbFPGD9lF7sJOaA2pjmryKvOHuhU5+u9QTy+4fOQfyw2plSWENTrW
 lQMRVZPGMcjYuAhf5Gcq+LFkmYJoPs82UYX5IoQptWg7TGDbXGNioT62/dwZE3cQSAJR
 Hn6ePFlacSqAkQrXDJj9emCxC+hxjIVBftVKsDBHMI1dcGJh6pVnMrnjOH5NcVPHjvrE
 hOGjaUVtqmTX2spgacuKiEFLL98hNoCyvTSN7BHGTvOUvWFjiD3hEREJwxZm+cKXbRy4
 UTwg==
X-Gm-Message-State: AOJu0YzMWmm8WH7zSvfyEp2M+UvB52NDkUU61iDary9VInX0Lr0Ez8hd
 YHW3iXJearo6CgDKzE8x0amF6ndwVUxEvfakxBuJDlmUcWwj4MbFvxLD2zgW35CvjzI4+Em4Llg
 F
X-Google-Smtp-Source: AGHT+IFxV9UeH9UQhKvWOvaB4+Tf+LVVGhN9IzSDz14F//nC8uhDa1xmeK6Rl1Yb+didB5E0OGzYbw==
X-Received: by 2002:ac2:551b:0:b0:52c:80db:bfe3 with SMTP id
 2adb3069b0e04-52c80dbc19dmr3017287e87.21.1718000542112; 
 Sun, 09 Jun 2024 23:22:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19e572sm130895795e9.10.2024.06.09.23.22.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:21 -0700 (PDT)
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
Subject: [PATCH 13/26] hw/ppc: Avoid using Monitor in
 xive_end_eas_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:51 +0200
Message-ID: <20240610062105.49848-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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
 include/hw/ppc/xive_regs.h |  2 +-
 hw/intc/pnv_xive.c         |  9 +++++----
 hw/intc/xive.c             | 22 ++++++++++------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 5e6f9d1be4..b9db7abc2e 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -263,7 +263,7 @@ static inline uint64_t xive_end_qaddr(XiveEND *end)
 
 void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, GString *buf);
 void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, GString *buf);
-void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon);
+void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx, GString *buf);
 
 /* Notification Virtual Target (NVT) */
 typedef struct XiveNVT {
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 1dddbf7827..a0c6dee5db 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1881,14 +1881,15 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_pic_print_info(&end, i++, buf);
     }
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
-    monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, blk);
+    g_string_append_printf(buf, "XIVE[%x] #%d END Escalation EAT\n",
+                           chip_id, blk);
     i = 0;
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
-        xive_end_eas_pic_print_info(&end, i++, mon);
+        xive_end_eas_pic_print_info(&end, i++, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] #%d NVTT %08x .. %08x\n", chip_id, blk,
                    0, XIVE_NVT_COUNT - 1);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f631d7cd6e..70f11f993b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -17,7 +17,6 @@
 #include "sysemu/reset.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "hw/irq.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
@@ -1419,8 +1418,7 @@ static void xive_end_enqueue(XiveEND *end, uint32_t data)
     end->w1 = xive_set_field32(END_W1_PAGE_OFF, end->w1, qindex);
 }
 
-void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx,
-                                   Monitor *mon)
+void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx, GString *buf)
 {
     XiveEAS *eas = (XiveEAS *) &end->w4;
     uint8_t pq;
@@ -1431,15 +1429,15 @@ void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx,
 
     pq = xive_get_field32(END_W1_ESe, end->w1);
 
-    monitor_printf(mon, "  %08x %c%c %c%c end:%02x/%04x data:%08x\n",
-                   end_idx,
-                   pq & XIVE_ESB_VAL_P ? 'P' : '-',
-                   pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
-                   xive_eas_is_valid(eas) ? 'V' : ' ',
-                   xive_eas_is_masked(eas) ? 'M' : ' ',
-                   (uint8_t)  xive_get_field64(EAS_END_BLOCK, eas->w),
-                   (uint32_t) xive_get_field64(EAS_END_INDEX, eas->w),
-                   (uint32_t) xive_get_field64(EAS_END_DATA, eas->w));
+    g_string_append_printf(buf, "  %08x %c%c %c%c end:%02x/%04x data:%08x\n",
+                           end_idx,
+                           pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                           pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                           xive_eas_is_valid(eas) ? 'V' : ' ',
+                           xive_eas_is_masked(eas) ? 'M' : ' ',
+                           (uint8_t)  xive_get_field64(EAS_END_BLOCK, eas->w),
+                           (uint32_t) xive_get_field64(EAS_END_INDEX, eas->w),
+                           (uint32_t) xive_get_field64(EAS_END_DATA, eas->w));
 }
 
 /*
-- 
2.41.0


