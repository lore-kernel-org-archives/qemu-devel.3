Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76ADC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKT-0005Cm-Af; Tue, 18 Jun 2024 12:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKQ-00059O-Bn
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:02 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKO-0007Lq-77
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:01 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6f51660223so338680866b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726698; x=1719331498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFkN9FtAnePRG8NjARWMoT/J4rXKp/M9AdXLddBQS3E=;
 b=eFM1UkJ4jVq/2pdXI0ZBLxvVn2S1K71wjepiJJGijmnSzHUVhT1iT9RgzIZgKudgyt
 WmCgx2xwz1OgYjPVCuVw5jCk7+Pw16SBiiuIeiv4hXwJdhC445yCQ/r5svPrhlFxjWDD
 yaUak3FNkttbOf6caHllg11LRizlv5Hom6KEFhcyZABhMyAC9ues9nMLpW6Xc2I/o/o1
 123CH/cmm4rgtSf3oGw0nh6NCoRfrIikLA03aw3KxO/NDhnSGgTWcVqEptCJEagGJeeb
 r9/tL5Kb2uUcQjImBs6UfX1UD1Rr88YGsUXGKD365vk+LKwEZyHDNUa2CVSIaf8fARe5
 7Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726698; x=1719331498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFkN9FtAnePRG8NjARWMoT/J4rXKp/M9AdXLddBQS3E=;
 b=ENcNgQELA7G6VkUbMCp8/XPmngaXx3PK9WjNPYVrp2F8OpKcKzsZYoE11PzBhPglwG
 IWieTL1DxgY7bjmGAaRwD+QlSgutZv4Qr14vfo78uWVbyt5h1XFtCtPae3xludOPGnee
 xRZ3q+afnHMA6lGAUQZqLURF+1Qq/pHXOBUmFnfq4cpcK9zAZw297tC2l7D4prYiaQ0y
 /idgrYAwCmIBd/Dmev7+N17HexFCRpxxjtOpYPr5dyP4RVj7KZI8RtFKMZJw08WRnY0r
 cB9u6/Vl/1XFH4yUhPFTqGj8A0vvBtqj0KSGEpF6lek+qBKLRLFKmYVk0Y9YiyK3K2r9
 sjeQ==
X-Gm-Message-State: AOJu0YzhXmS0VCb+FnIRighQrgxCVRzgDZV20GF9Wyj8hNNHseiD81cX
 mbISp1wvlvtJc0qyVz7eEGawnY3f4v8ZHrTcM8/JnBzRqL4ySny7lgOx656NPvrIFqYKZGlj5Pm
 a
X-Google-Smtp-Source: AGHT+IF5VYuYdcXr8FEttHuXFTG88fXhe1TjP/3O/M4UotbBJ1CiHXmrZX9rhkLHjOllZce6blKy0g==
X-Received: by 2002:a50:9314:0:b0:57a:70fa:8875 with SMTP id
 4fb4d7f45d1cf-57cbd8b9c3bmr9305086a12.40.1718726698155; 
 Tue, 18 Jun 2024 09:04:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da785sm7832728a12.28.2024.06.18.09.04.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 44/76] hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:06 +0200
Message-ID: <20240618160039.36108-45-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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
Message-Id: <20240610062105.49848-21-philmd@linaro.org>
---
 include/hw/ppc/xive2_regs.h |  2 +-
 hw/intc/pnv_xive2.c         |  8 +++----
 hw/intc/xive2.c             | 48 ++++++++++++++++---------------------
 3 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 4d32703c26..4e5e17cd89 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -130,7 +130,7 @@ static inline uint64_t xive2_end_qaddr(Xive2End *end)
         (be32_to_cpu(end->w3) & END2_W3_EQ_ADDR_LO);
 }
 
-void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon);
+void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf);
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
                                     GString *buf);
 void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 9535f60828..52505fd1a4 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2141,14 +2141,14 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
     while (!xive2_router_get_end(xrtr, blk, i, &end)) {
         xive2_end_eas_pic_print_info(&end, i++, buf);
     }
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
-    monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
+    g_string_append_printf(buf, "XIVE[%x] #%d ENDT\n", chip_id, blk);
     i = 0;
     while (!xive2_router_get_end(xrtr, blk, i, &end)) {
-        xive2_end_pic_print_info(&end, i++, mon);
+        xive2_end_pic_print_info(&end, i++, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] #%d NVPT %08x .. %08x\n", chip_id, blk,
                    0, XIVE2_NVP_COUNT - 1);
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 6a15b4d1e4..3e7238c663 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -11,12 +11,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
 #include "hw/qdev-properties.h"
-#include "monitor/monitor.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
 #include "hw/ppc/xive2_regs.h"
@@ -71,7 +69,7 @@ void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width, GString *buf)
     g_string_append_printf(buf, "]");
 }
 
-void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
+void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
     uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
@@ -90,34 +88,30 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
 
     pq = xive_get_field32(END2_W1_ESn, end->w1);
 
-    monitor_printf(mon,
-                   "  %08x %c%c %c%c%c%c%c%c%c%c%c%c prio:%d nvp:%02x/%04x",
-                   end_idx,
-                   pq & XIVE_ESB_VAL_P ? 'P' : '-',
-                   pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
-                   xive2_end_is_valid(end)    ? 'v' : '-',
-                   xive2_end_is_enqueue(end)  ? 'q' : '-',
-                   xive2_end_is_notify(end)   ? 'n' : '-',
-                   xive2_end_is_backlog(end)  ? 'b' : '-',
-                   xive2_end_is_escalate(end) ? 'e' : '-',
-                   xive2_end_is_escalate_end(end) ? 'N' : '-',
-                   xive2_end_is_uncond_escalation(end)   ? 'u' : '-',
-                   xive2_end_is_silent_escalation(end)   ? 's' : '-',
-                   xive2_end_is_firmware1(end)   ? 'f' : '-',
-                   xive2_end_is_firmware2(end)   ? 'F' : '-',
-                   priority, nvp_blk, nvp_idx);
+    g_string_append_printf(buf,
+                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c "
+                           "prio:%d nvp:%02x/%04x",
+                           end_idx,
+                           pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                           pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                           xive2_end_is_valid(end)    ? 'v' : '-',
+                           xive2_end_is_enqueue(end)  ? 'q' : '-',
+                           xive2_end_is_notify(end)   ? 'n' : '-',
+                           xive2_end_is_backlog(end)  ? 'b' : '-',
+                           xive2_end_is_escalate(end) ? 'e' : '-',
+                           xive2_end_is_escalate_end(end) ? 'N' : '-',
+                           xive2_end_is_uncond_escalation(end)   ? 'u' : '-',
+                           xive2_end_is_silent_escalation(end)   ? 's' : '-',
+                           xive2_end_is_firmware1(end)   ? 'f' : '-',
+                           xive2_end_is_firmware2(end)   ? 'F' : '-',
+                           priority, nvp_blk, nvp_idx);
 
     if (qaddr_base) {
-        g_autoptr(GString) buf = g_string_new("");
-        g_autoptr(HumanReadableText) info = NULL;
-
-        monitor_printf(mon, " eq:@%08"PRIx64"% 6d/%5d ^%d",
-                       qaddr_base, qindex, qentries, qgen);
+        g_string_append_printf(buf, " eq:@%08"PRIx64"% 6d/%5d ^%d",
+                               qaddr_base, qindex, qentries, qgen);
         xive2_end_queue_pic_print_info(end, 6, buf);
-        info = human_readable_text_from_str(buf);
-        monitor_puts(mon, info->human_readable_text);
     }
-    monitor_printf(mon, "\n");
+    g_string_append_c(buf, '\n');
 }
 
 void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
-- 
2.41.0


