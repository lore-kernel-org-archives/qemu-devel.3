Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614BEC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJp-0003vD-T3; Tue, 18 Jun 2024 12:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJn-0003rJ-Ab
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJk-0007Ez-DW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57c778b5742so6562143a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726658; x=1719331458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFMERdu5BxdLlmHi+3GbOTwf7lyqGeSd5tYPeFoN3L0=;
 b=gVGPKBiDqFia8h3/YmO9Qb8WmIf5+YoAIMT/ZTIWNWiSSzfdhhgGMaszTJgbL1ocmD
 uyUWSEfcvKPrNSLJ6iFOGPy1PcwBKupapzHrB6lQJpdppj+Pf8AUNOrinwJWbYDDNi3S
 +ILMA3AU22ncZFk+8cWMMwbtnDcl0ssLAMWB0xS41J/l8q859KMAffCaEEsVoLy4SVjB
 6GuSdcqWevtN9+BPwi8OQmLMNLlahMRxtvgjJ2Sc3CmNbwgDns12ItBlovrOmx133S1J
 eDWhXJ6RRcV8oLckRYlA0FReXht3dr2SlzpuYgTA9IX52+46AV1i174hpBn/ZcOmkPta
 EzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726658; x=1719331458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFMERdu5BxdLlmHi+3GbOTwf7lyqGeSd5tYPeFoN3L0=;
 b=hu2N9u2aEaQwF50Qvi5gt5EdMdJTGqQ2MyTkX1vgHtWR8E/O7hp0JMg+1btMaRhsy4
 6zmDWodyvpz1Lp9JIZmsvQ0qRQNngrsZnmRb+Z7Uj604VGjPqZw/yPSLpnPn2s8MxdX0
 JwUWJkFtj+3wIFXjFRF/cc6dAcvbTLjXHwLFVgLndnussdufkHVVC3/Llyo+JNx6kAwD
 AwINEbRFwzZb/klBSY5TEs5beghhIicyvcQqdZvvtUqzifIjZVmwja6zu+9IIIpfUA0C
 GPuLT7agC4MVjXFBFtwtkPW0qzDXy3UOoTAK8ch9X4rPD4f3kmcX7gdInnKUiZzNo1PH
 m12g==
X-Gm-Message-State: AOJu0YwcNZ99NkrUTSOOdKmcLH1A7jTQ4q/D0/rWVViErq8s14E7b9SF
 c5F3hSe1/HXSgkKLH5MVt8vTx6jhv8OV+oH6mJm9XazfSUnaFvQ1Jmt3MnlsH9Wsl9lNHtvYlJE
 Z
X-Google-Smtp-Source: AGHT+IFP0UUUCCIrNHBq+l4kw1cseuEgYyEK+/UjXIGr7uaigPcKgEUUsJBR/SmOdFLrxE5tIOa98Q==
X-Received: by 2002:a17:906:9c89:b0:a6f:9f4a:fb11 with SMTP id
 a640c23a62f3a-a6f9f4afccfmr77583866b.28.1718726658513; 
 Tue, 18 Jun 2024 09:04:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f43220sm625702166b.185.2024.06.18.09.04.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 37/76] hw/ppc: Avoid using Monitor in
 xive_end_eas_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:59 +0200
Message-ID: <20240618160039.36108-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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
Message-Id: <20240610062105.49848-14-philmd@linaro.org>
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


