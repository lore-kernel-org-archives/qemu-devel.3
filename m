Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FA0C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJj-0003cA-SE; Tue, 18 Jun 2024 12:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJg-0003MN-P0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:16 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJe-0007EY-Nt
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:16 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6efae34c83so694534566b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726653; x=1719331453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khVkiqMrtLebSa9wzun/miaiMcGkBkr7V5nJnGtflmQ=;
 b=Ove9yzAuKgoLc07rzx2kBM4Tx7n85G7kRIkUNPTNwebprVXREkLOptTexnAhrfyCAG
 VxKuCZdzCdSQxNkvgO0Ty5j87q5xS+XueUJhT9elTGzTZVGLuCp0NvYw0QkefkZ8WjU+
 QVNIWrJXEDDzbV/dgYto/QPif6fQhhGQXVxMDR293LQ9WgE+zwGnZztn5HrpQiNrj9AT
 gvCoMyu9TVjuZSD1fWJ6PAib7vC4hBtCfRhJZiNE+1unwxqVS/7aun3CbL1XXhO9nJTA
 BsCE2vo+crpdVck9Xhf0+CJNFe7LVEVUe/yBj/1TMs6vQ54fOnYkR1o6AFJpdPqr+lYg
 otVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726653; x=1719331453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khVkiqMrtLebSa9wzun/miaiMcGkBkr7V5nJnGtflmQ=;
 b=cdUN2gWo4zvtQCrhPwXuwa/U74OyLHLbJQGkG/deEg3mseJuLae4bsRbFFkaehacd6
 e/khVOHCQ3X2k8Z6ZIqsecXUSCF+pNPCUGQy/uv1E9OtG0aZTYt8flEFin+IPKHAJo5I
 lmlHhN856ZStoAz+PLR0YTboDs25SMSot5B9nWS+LKKe7JpJCwbW+bkIbBSdpBWwvhL9
 pJ4IjqTyJKXukhF3Qy0I1GAH0ykbH1fA8ICH7z8FvTZmtCSSplkw3G+AFMlYyfopFBaE
 +2LVdrQdlc8oNqmcPrAQNXmEW2GliPCYggJmPrcA/Sw0QvfE28CgmpWx6DLemZn5jvm8
 kX8w==
X-Gm-Message-State: AOJu0YwfgqEimDKkphFoDgtBVq9KN3Y+ERBsJkcnP+JiAhPLWuo+lfdV
 YxUWA3gQV8dsD/727QpKOMRmO4RRRzy6d4WRweYoYDsv5pI9HELq/G/ulo5uTeeH3F9C9G+xQVz
 2
X-Google-Smtp-Source: AGHT+IGXKUbDz0p7mOE4uPtCHUQbJ1FhjmJcciMx8hcVPRCuErku3MzZ2qGlxZ6ddblFRn8e6RDl3A==
X-Received: by 2002:a17:907:6d08:b0:a66:c338:65cc with SMTP id
 a640c23a62f3a-a6f60d2991bmr1000055966b.19.1718726652710; 
 Tue, 18 Jun 2024 09:04:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd06sm625651966b.119.2024.06.18.09.04.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 36/76] hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:58 +0200
Message-ID: <20240618160039.36108-37-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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
Message-Id: <20240610062105.49848-13-philmd@linaro.org>
---
 include/hw/ppc/xive_regs.h |  2 +-
 hw/intc/pnv_xive.c         |  8 ++++----
 hw/intc/xive.c             | 40 +++++++++++++++++---------------------
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index dd4a76bcf0..5e6f9d1be4 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -261,7 +261,7 @@ static inline uint64_t xive_end_qaddr(XiveEND *end)
         be32_to_cpu(end->w3);
 }
 
-void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon);
+void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, GString *buf);
 void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, GString *buf);
 void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon);
 
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index c377823522..1dddbf7827 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1875,14 +1875,14 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
             xive_eas_pic_print_info(&eas, i, buf);
         }
     }
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
-    monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
+    g_string_append_printf(buf, "XIVE[%x] #%d ENDT\n", chip_id, blk);
     i = 0;
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
-        xive_end_pic_print_info(&end, i++, mon);
+        xive_end_pic_print_info(&end, i++, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, blk);
     i = 0;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b2203b721b..f631d7cd6e 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -11,7 +11,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
@@ -1352,7 +1351,7 @@ void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, GString *buf)
     g_string_append_c(buf, ']');
 }
 
-void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon)
+void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, GString *buf)
 {
     uint64_t qaddr_base = xive_end_qaddr(end);
     uint32_t qindex = xive_get_field32(END_W1_PAGE_OFF, end->w1);
@@ -1364,8 +1363,6 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon)
     uint32_t nvt_idx = xive_get_field32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority = xive_get_field32(END_W7_F0_PRIORITY, end->w7);
     uint8_t pq;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     if (!xive_end_is_valid(end)) {
         return;
@@ -1373,28 +1370,27 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon)
 
     pq = xive_get_field32(END_W1_ESn, end->w1);
 
-    monitor_printf(mon, "  %08x %c%c %c%c%c%c%c%c%c%c prio:%d nvt:%02x/%04x",
-                   end_idx,
-                   pq & XIVE_ESB_VAL_P ? 'P' : '-',
-                   pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
-                   xive_end_is_valid(end)    ? 'v' : '-',
-                   xive_end_is_enqueue(end)  ? 'q' : '-',
-                   xive_end_is_notify(end)   ? 'n' : '-',
-                   xive_end_is_backlog(end)  ? 'b' : '-',
-                   xive_end_is_escalate(end) ? 'e' : '-',
-                   xive_end_is_uncond_escalation(end)   ? 'u' : '-',
-                   xive_end_is_silent_escalation(end)   ? 's' : '-',
-                   xive_end_is_firmware(end)   ? 'f' : '-',
-                   priority, nvt_blk, nvt_idx);
+    g_string_append_printf(buf,
+                           "  %08x %c%c %c%c%c%c%c%c%c%c prio:%d nvt:%02x/%04x",
+                           end_idx,
+                           pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                           pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                           xive_end_is_valid(end)    ? 'v' : '-',
+                           xive_end_is_enqueue(end)  ? 'q' : '-',
+                           xive_end_is_notify(end)   ? 'n' : '-',
+                           xive_end_is_backlog(end)  ? 'b' : '-',
+                           xive_end_is_escalate(end) ? 'e' : '-',
+                           xive_end_is_uncond_escalation(end)   ? 'u' : '-',
+                           xive_end_is_silent_escalation(end)   ? 's' : '-',
+                           xive_end_is_firmware(end)   ? 'f' : '-',
+                           priority, nvt_blk, nvt_idx);
 
     if (qaddr_base) {
-        monitor_printf(mon, " eq:@%08"PRIx64"% 6d/%5d ^%d",
-                       qaddr_base, qindex, qentries, qgen);
+        g_string_append_printf(buf, " eq:@%08"PRIx64"% 6d/%5d ^%d",
+                               qaddr_base, qindex, qentries, qgen);
         xive_end_queue_pic_print_info(end, 6, buf);
     }
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
-    monitor_printf(mon, "\n");
+    g_string_append_c(buf, '\n');
 }
 
 static void xive_end_enqueue(XiveEND *end, uint32_t data)
-- 
2.41.0


