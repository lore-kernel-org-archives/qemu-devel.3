Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5867FC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQb-0004jG-Lt; Mon, 10 Jun 2024 02:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQ8-0003Rh-UK
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQ6-0004Y6-Gp
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35e1fcd0c0fso3399859f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000536; x=1718605336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImJWDtZBqlp+bMUJJjr4+M/fZWCSgOtIT3msJaq+OWA=;
 b=cTFduaCYDhpeg0kWwsPhbcTK5fs4WbMzqP559sjnBeIX8fIxNyxkxRC1XrXbTN9MbQ
 pAALOK+X9Nm9T0ibZEdWMd3GfMHlQpvWVdj//T1+e6ZzTWT9zqBplVNLabwlk6UxhyA3
 Brae7q+YzCwiiJtnfJbCkX1ejZwq3FxJy3FPWQOJp3DcXgk6whYyFvouAaTXkqwPpQ11
 givmqyxfpXWp4v/SOKT+EWBt7fXISzNrwQ8CFHW/kYfxQ9bs9hvir0CGc9IZ2lWkzECY
 hk930inO25Cdnw83/o+rp6JvKo/4MtY/4JLNnEP0rn9l+YdNUEvVrzVVdGIKc7OJodOC
 ksGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000536; x=1718605336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImJWDtZBqlp+bMUJJjr4+M/fZWCSgOtIT3msJaq+OWA=;
 b=b37+bD/tah4FMNrfMJbdi2WmmMj7Kzxd3/K1o6mQpZgdREWzFB1NzNiy8b4wFoBkTW
 M+/QObpgABS8GPYw9ZBD8pabMySeoaGNj4RcGqalbIpGaFkLzEAwL+E3RPiOPcmF9YwM
 zTVNpWkdN+Wrt7zop3eMsXc09mWsV/ISvys+0mgu6K75m//kF7pp35EXx+NckMYN1mzs
 wGLZuAsyhcb5i94Qz8j2as1PYNCCx1oszOC0VacHUMpSW240UKiOyP76mZ42tSL53+Xj
 jnPL+N3xN806TbrXrfQR7mN+410dFawCmkL0byRIyEm/mnQ7CP+tVYAXUTxqVtl4hq5U
 yAZQ==
X-Gm-Message-State: AOJu0YwROmZZYq+k/5DWBv/Ganogutxe4pRSZr4IVQejpTEJdr+9Wtgu
 knNJLUF4rY+0f6RSvYNsctfIfDvwq133efbkWg01AKx7C9o7KLMcNfFot0k/3eGS0rGQy+S5rCW
 0
X-Google-Smtp-Source: AGHT+IHRSINRlSM1+2TE5aZMt9nLtReCXKsc05msfPqQIGDeBlbwdRBPHNyGPhoL6FOMgXe4OlW9WQ==
X-Received: by 2002:a5d:6c69:0:b0:35f:22cd:120d with SMTP id
 ffacd0b85a97d-35f22cd1271mr1400315f8f.21.1718000536431; 
 Sun, 09 Jun 2024 23:22:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1846574esm5122917f8f.117.2024.06.09.23.22.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:16 -0700 (PDT)
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
Subject: [PATCH 12/26] hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:50 +0200
Message-ID: <20240610062105.49848-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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


