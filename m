Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4D6C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQw-0006tt-US; Mon, 10 Jun 2024 02:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQr-0006iN-Qq
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQp-0004fr-F2
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421820fc26dso6641615e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000582; x=1718605382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8q+0Y0d43Q0CvsJjXe52jKMwNCokmUXcUWl+GpELRic=;
 b=bfQKoPwBxNrN1BCjEOpTXg/11ccETZw3f0utIEJyUjtNd6dtbZYjO0RiQhjfyXa9nN
 BfAd3d3gi+Jlq2Vi/ieox/8YsfaSciR3I++7wD0U0FpNK9RsVD2A0LWbabw+lAH2kxLg
 NjiqA++Uu61AFeETyz9YoNp4p6faU/10knEeRE3FgBiIin2utraiPcfJzAecMmiZW3Qx
 Fe4upOvtZLHj8wSpr99rxbBJcBCFWEs3wPZSe848pbiZZRikdMI4h2VLFlTvn6WAbbqz
 U24xOyyd1e9hMCO1F5YKRuzC4YiSMN4901gVUgQnV+Vb8a3Dt1QjjpaVv+NniywldIXi
 DVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000582; x=1718605382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8q+0Y0d43Q0CvsJjXe52jKMwNCokmUXcUWl+GpELRic=;
 b=HOvmPZNuYdaMu4B6vIxB1FxOnzoHE858xSMje1796a5pwbNmn3gQfBR/joNL/FIEog
 DDVIoApY8YXR06yGqx9/4rv3447uhbx0syFYGP+947aVpSksR9RU2qI3qv/e62VzIar0
 I9qU1PisQTRxzDfiFXuTLaWkqdtL+Qkwg4UU3rpcYsYoxNFadtW+pb5JmCXPgM5p1ERa
 8e0r/LRFrxJki5F/ZYxIco4bahAXi7qMayJX7ioX5FFe9pNMnCjddWUiFe43oD08t3sy
 VM5MJoZumQOCT9cPL/lQUPzuduDoMSDRm9fxNFs/wA4MJwyr2w7Xyd7Vdzq5N+4AgP0r
 GLEg==
X-Gm-Message-State: AOJu0YzhwyzjJESSBKqi1wl9BWS6s754gAYgtOuQJ8IBpfaxnMHXNWA7
 5E20hf0NjH6nYcy1aFQAE187VfCXs3TX7zhyeRgzcmp6gLGADEW2Mb0TQksmth8gPlfUjTFc99E
 6
X-Google-Smtp-Source: AGHT+IGsBmGulccdo0eoMhBQQ3igMoe15xwDwAWuvrCSkOCI7k3X8kT0ofSkOcZhOKpqe5gihYKJxQ==
X-Received: by 2002:a05:600c:190a:b0:421:7476:6ba1 with SMTP id
 5b1f17b1804b1-42174766d4fmr56860135e9.38.1718000581766; 
 Sun, 09 Jun 2024 23:23:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4216b398fd8sm96058135e9.23.2024.06.09.23.23.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:23:01 -0700 (PDT)
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
Subject: [PATCH 20/26] hw/ppc: Avoid using Monitor in
 xive2_end_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:58 +0200
Message-ID: <20240610062105.49848-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


