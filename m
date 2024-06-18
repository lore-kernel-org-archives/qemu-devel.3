Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AA7C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKK-00055D-UQ; Tue, 18 Jun 2024 12:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKG-0004xz-8D
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:53 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKD-0007K7-Qr
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6e43dad8ecso975837966b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726687; x=1719331487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBbXvZQRPypaSl3gh9f7m2D/B8J51wUHOUkRF4HQox4=;
 b=iWjmmdba0prKDq2sEbpQ1q74fMadEOUqD0NEq9DBhkIjEt5qQPvyi2gZ/6VahlJMk1
 Jv7NplwN1VQixyoO5JckeyiL31/i88npeaQDB0YYq99ihoslzrUdEF7ZPJSZZ4O48ZYO
 uaPSgQ7fLi30VrBPEOhiMxajN4Bf2MEWq7Qvb/2Ld+o9NHVjY74gtgRDx2E6nYlZ50DT
 90SKKPn+F+pe6czTihR7sr+ZZs9+rHnI6F6OhkIDeF5qVIkGGXlenn1UlyND7zL8YLBX
 qS2RnWTJqHUzLechXkGa8kFPkHME2HMOGO82jm8feV3tv/ThaEnnjNwxxmUYvsMjzuuR
 H+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726687; x=1719331487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBbXvZQRPypaSl3gh9f7m2D/B8J51wUHOUkRF4HQox4=;
 b=J4zJwEKUEOxEsOtWZHiyBUpZFO4wHapO46fqRYOFg2o85XBR/S1+XbGeu96g0y/d4j
 YvMbGW2i1niQZZ0vujygaisLndTdB5n+mzYL4mO/JDI4BzFQjxahvGzKDPIp+Oc/CwfU
 ueqBVJ0FsLQaygqVQclLUgODxRGuW53mJnSGq/LAdhMfxMKi0XdsKfl2HIN78rSEW7Q8
 XD0QCeHkSBfmADnOQ05m4F2GwJw487C4uVg7/QVa/r1rpDa+IjhiDI3FiUdsnrai+9rX
 9OA7+rSZpewqE5Qrcji9noOu4pdeN3b2nuyOhM6kG52FWSQqVI85DZXaEPBAAF7HfT3C
 GlEQ==
X-Gm-Message-State: AOJu0YxOJ6TSft936Ly4qLNO8OvtkJrj9KLYyyhcqYfDZoCoGVFs/wMU
 jTNxz/J/BM8UxS/1DX4Oc/oriNhQ7R/QWPSomDjKVmX6s2js19FNMFuDj7z+wfUa2dcNQq4GvPo
 Q
X-Google-Smtp-Source: AGHT+IFnJLQXVqGHi9GbVeDHGWEysnGQ4lcbJ60Pu/yKn7KG2qnGcaQYXlWfUuu7tpAS7k5R9MNxfA==
X-Received: by 2002:a17:907:20f1:b0:a6e:6555:4bcd with SMTP id
 a640c23a62f3a-a6fa449aa71mr14354566b.35.1718726686860; 
 Tue, 18 Jun 2024 09:04:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f9c86esm629412166b.219.2024.06.18.09.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 42/76] hw/ppc: Avoid using Monitor in
 xive2_end_eas_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:04 +0200
Message-ID: <20240618160039.36108-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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
Message-Id: <20240610062105.49848-19-philmd@linaro.org>
---
 include/hw/ppc/xive2_regs.h |  2 +-
 hw/intc/pnv_xive2.c         | 10 +++++-----
 hw/intc/xive2.c             | 20 ++++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index f662f0e325..37f572ed6d 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -134,7 +134,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon);
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
                                     Monitor *mon);
 void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
-                                   Monitor *mon);
+                                  GString *buf);
 
 /*
  * Notification Virtual Processor (NVP)
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 649e5001fd..9535f60828 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2135,14 +2135,14 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
         }
     }
 
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
-
-    monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, blk);
+    g_string_append_printf(buf, "XIVE[%x] #%d END Escalation EAT\n",
+                           chip_id, blk);
     i = 0;
     while (!xive2_router_get_end(xrtr, blk, i, &end)) {
-        xive2_end_eas_pic_print_info(&end, i++, mon);
+        xive2_end_eas_pic_print_info(&end, i++, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
     i = 0;
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 0154ebb59c..23356acff7 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -116,7 +116,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, Monitor *mon)
 }
 
 void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
-                                  Monitor *mon)
+                                  GString *buf)
 {
     Xive2Eas *eas = (Xive2Eas *) &end->w4;
     uint8_t pq;
@@ -127,15 +127,15 @@ void xive2_end_eas_pic_print_info(Xive2End *end, uint32_t end_idx,
 
     pq = xive_get_field32(END2_W1_ESe, end->w1);
 
-    monitor_printf(mon, "  %08x %c%c %c%c end:%02x/%04x data:%08x\n",
-                   end_idx,
-                   pq & XIVE_ESB_VAL_P ? 'P' : '-',
-                   pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
-                   xive2_eas_is_valid(eas) ? 'v' : ' ',
-                   xive2_eas_is_masked(eas) ? 'M' : ' ',
-                   (uint8_t)  xive_get_field64(EAS2_END_BLOCK, eas->w),
-                   (uint32_t) xive_get_field64(EAS2_END_INDEX, eas->w),
-                   (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
+    g_string_append_printf(buf, "  %08x %c%c %c%c end:%02x/%04x data:%08x\n",
+                           end_idx,
+                           pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                           pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                           xive2_eas_is_valid(eas) ? 'v' : ' ',
+                           xive2_eas_is_masked(eas) ? 'M' : ' ',
+                           (uint8_t)  xive_get_field64(EAS2_END_BLOCK, eas->w),
+                           (uint32_t) xive_get_field64(EAS2_END_INDEX, eas->w),
+                           (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
-- 
2.41.0


