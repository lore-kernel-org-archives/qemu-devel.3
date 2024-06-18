Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896EDC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKN-00056h-UR; Tue, 18 Jun 2024 12:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKK-00054q-Cb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:56 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKI-0007Kq-2n
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:56 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so6076846a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726692; x=1719331492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4fKIHkIifq0nx9RAUE9jEIghQddp4LMxW3UC4IhhV4=;
 b=ff53kd3VH4CYl+x9AeDrZ21UhUghvLQ0LcA674onynN1+EqxXlaNL1HbXOVEJG64dd
 MRV/cboPvytytucICf4vP4MEJEIFnwyqZkUIPuEEIwKrQhsNNXXl7zxneDC+TpWtCx6a
 bp8jqltkSGLn+WJb8YhbxhSNyVfd8kcJxXGv6Ar5Bb+4GA7sHzF7+njRB2OjIIJcArNI
 cGYub8Vkjpp/jNSwHORKdpC65Vo5EDvOHtEmrRUnpZmRStlmCfdWId751c4JlRTPXt2d
 BKvF6znuIsF74PQFo6Sl649yPAPv2oQimAObVchdSWCz+KRUZ7p3Y3gw0G8AFJwLf8/c
 Z5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726692; x=1719331492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4fKIHkIifq0nx9RAUE9jEIghQddp4LMxW3UC4IhhV4=;
 b=kCSttbJo73sEn8scogVqK1CwjHYzn1DDnW4A4RBmVgcRyytnu+wc1pn3UAvNFJfL04
 ovF2GU0DhyENK1tiil8R0LtUtUKjz4p6YFRPVtdm+wjCzq/JFOj83NXtM0pEmq/98+rT
 vr2pCaZiemqZaAhcr8Nkv5ruIA0P8gj3MqV8+ZqEU2Sc6RCRZONCfgP7qQbaV9U79uvZ
 4UO6TNaNWEfVacqkKOmB/ZYFYu5DYX4qunYkaWmKZhyXZ8DA0D8yw/CwBZld8BTzTOCi
 4IEc86Gh6geb/7RP3Z28j9Y4V7VPjCJbqRqVFvqu3jyp2SsUF4vsRZFjU17MAkEIFCYT
 cAvw==
X-Gm-Message-State: AOJu0YyhaB12jyxoWKmRX3EIYTl5s+kTl//El5N6YvIdpx3lLJ31I/oS
 YmKRTA1McBshA4UVN/BVDPXyuiMpGOPFPgMwx56U7HefbKhlNW3QZPtU6nBZ6C3L2DbNK8w7e2F
 X
X-Google-Smtp-Source: AGHT+IFkx6l9KxGcs40BQnPCUpibZnOijYrErxL+2c5rdT0E8Lj1zOWM+tgIvvQSPIHAIdpe7nUuJQ==
X-Received: by 2002:a50:d59b:0:b0:57c:738c:2c84 with SMTP id
 4fb4d7f45d1cf-57cbd66a4e3mr10532877a12.10.1718726692396; 
 Tue, 18 Jun 2024 09:04:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e5aesm7826977a12.60.2024.06.18.09.04.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 43/76] hw/ppc: Avoid using Monitor in
 xive2_end_queue_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:05 +0200
Message-ID: <20240618160039.36108-44-philmd@linaro.org>
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
Message-Id: <20240610062105.49848-20-philmd@linaro.org>
---
 include/hw/ppc/xive2_regs.h |  2 +-
 hw/intc/xive2.c             | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 37f572ed6d..4d32703c26 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -132,7 +132,7 @@ static inline uint64_t xive2_end_qaddr(Xive2End *end)
 
 void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon);
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
-                                    Monitor *mon);
+                                    GString *buf);
 void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
                                   GString *buf);
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 23356acff7..6a15b4d1e4 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
@@ -40,8 +41,7 @@ void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
                            (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
-void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
-                                    Monitor *mon)
+void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width, GString *buf)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
     uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
@@ -52,7 +52,7 @@ void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
     /*
      * print out the [ (qindex - (width - 1)) .. (qindex + 1)] window
      */
-    monitor_printf(mon, " [ ");
+    g_string_append_printf(buf, " [ ");
     qindex = (qindex - (width - 1)) & (qentries - 1);
     for (i = 0; i < width; i++) {
         uint64_t qaddr = qaddr_base + (qindex << 2);
@@ -64,11 +64,11 @@ void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
                           HWADDR_PRIx "\n", qaddr);
             return;
         }
-        monitor_printf(mon, "%s%08x ", i == width - 1 ? "^" : "",
-                       be32_to_cpu(qdata));
+        g_string_append_printf(buf, "%s%08x ", i == width - 1 ? "^" : "",
+                               be32_to_cpu(qdata));
         qindex = (qindex + 1) & (qentries - 1);
     }
-    monitor_printf(mon, "]");
+    g_string_append_printf(buf, "]");
 }
 
 void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
@@ -108,9 +108,14 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
                    priority, nvp_blk, nvp_idx);
 
     if (qaddr_base) {
+        g_autoptr(GString) buf = g_string_new("");
+        g_autoptr(HumanReadableText) info = NULL;
+
         monitor_printf(mon, " eq:@%08"PRIx64"% 6d/%5d ^%d",
                        qaddr_base, qindex, qentries, qgen);
-        xive2_end_queue_pic_print_info(end, 6, mon);
+        xive2_end_queue_pic_print_info(end, 6, buf);
+        info = human_readable_text_from_str(buf);
+        monitor_puts(mon, info->human_readable_text);
     }
     monitor_printf(mon, "\n");
 }
-- 
2.41.0


