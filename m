Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A78EC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJL-00013g-FN; Tue, 18 Jun 2024 12:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJJ-0000sd-3L
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:53 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJH-0007DC-7B
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:52 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6f177b78dcso716055366b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726629; x=1719331429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJr39dskipiLfu+a088UV+dPSqLj27VHgcPOwidtLFc=;
 b=tfx1q5VIPL9zEkH1m1DqdFSlUFMxSDlcFb/aBkH6y4O2QRMHmm0tugMlUMOj2uLeHd
 rkeFwzBo8KmO9s05WH2YWlZdVGfwSPo1wDh19iRNZiv1jDIjN+0e33jiQ7iJvdhDOXVV
 KhhX4EeVm0vsWvpWrdKjrJT9mQDA9tVF2tTS/Kxi2yO4b09h7aYZx7OR2O7memKUtVgF
 FE5Qw9V0pmRGVy+uWXu5eCy+SDNnOyios21rnwq2LS2AR+ah2T6/Ad77B291djDDVcly
 AurYRHIII9fhzqoC9mp8KpH47UvqGMeDxCx0TQDlBc9nQa20Ta6bKMcJOdi6HgGPl3YG
 4qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726629; x=1719331429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJr39dskipiLfu+a088UV+dPSqLj27VHgcPOwidtLFc=;
 b=fWomi9l2VbLTFZ8AhgYdAXM5Gr65/p/m8yaDG8JGmEeDMoOjah7FYfo99awORZ1Qwa
 VzJ175rKXoHKZsN/GAQ0c/jm+7TVBC4SgH/gT2A6248g84arGXmXMuMbEuWC6i0qBma7
 Fc1hMwLhSDD3PLHo5O0wHD0klspPihibucxrbe6zHAhaNtEkoPGdc1WQM5Dbmj3vT2H9
 825L/pSkqLpkUNs7W/zgSA4HdPMNXWB8NjVcNYuD9V1j+4UuO7oCqVcRiua7JcSMphlW
 pF4MIbHlZ8/eOP+bnRx8DmEENSRzzMVrc1vSlxkZ8iXdQdNySr3CRyw2DEi4qkZxdeQV
 fPhw==
X-Gm-Message-State: AOJu0YzDVYiDIv618uEKl5naSeJqRAqnd/VWPZ4J6eBYbmm2NqhrdAXt
 GxLK53d2Ut1eeyj1RI/MN6yHcgu8DX0MXC/kNX+obiG52NOmMxHB4ZmQ10MYVg21apa4Lu1V0M7
 R
X-Google-Smtp-Source: AGHT+IHN/xK50VLVJ75HFzdEqmNCAZYT489zzt4fkHzTBgNcBzBVH+2iWBRLjQt0XkkePXzdOB8SUQ==
X-Received: by 2002:a17:907:160b:b0:a6f:8264:4582 with SMTP id
 a640c23a62f3a-a6f8264463fmr557124866b.65.1718726629156; 
 Tue, 18 Jun 2024 09:03:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa6740sm630108566b.223.2024.06.18.09.03.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 32/76] hw/ppc: Avoid using Monitor in
 spapr_xive_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:54 +0200
Message-ID: <20240618160039.36108-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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
Message-Id: <20240610062105.49848-9-philmd@linaro.org>
---
 hw/intc/spapr_xive.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d571645e9e..9d0d5948ff 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -157,7 +157,7 @@ static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
 #define spapr_xive_in_kernel(xive) \
     (kvm_irqchip_in_kernel() && (xive)->fd != -1)
 
-static void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
+static void spapr_xive_pic_print_info(SpaprXive *xive, GString *buf)
 {
     XiveSource *xsrc = &xive->source;
     int i;
@@ -172,7 +172,7 @@ static void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
         }
     }
 
-    monitor_printf(mon, "  LISN         PQ    EISN     CPU/PRIO EQ\n");
+    g_string_append_printf(buf, "  LISN         PQ    EISN     CPU/PRIO EQ\n");
 
     for (i = 0; i < xive->nr_irqs; i++) {
         uint8_t pq = xive_source_esb_get(xsrc, i);
@@ -182,19 +182,17 @@ static void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
             continue;
         }
 
-        monitor_printf(mon, "  %08x %s %c%c%c %s %08x ", i,
-                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI",
-                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
-                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
-                       xive_source_is_asserted(xsrc, i) ? 'A' : ' ',
-                       xive_eas_is_masked(eas) ? "M" : " ",
-                       (int) xive_get_field64(EAS_END_DATA, eas->w));
+        g_string_append_printf(buf, "  %08x %s %c%c%c %s %08x ", i,
+                               xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI",
+                               pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                               pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                               xive_source_is_asserted(xsrc, i) ? 'A' : ' ',
+                               xive_eas_is_masked(eas) ? "M" : " ",
+                               (int) xive_get_field64(EAS_END_DATA, eas->w));
 
         if (!xive_eas_is_masked(eas)) {
             uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
             XiveEND *end;
-            g_autoptr(GString) buf = g_string_new("");
-            g_autoptr(HumanReadableText) info = NULL;
 
             assert(end_idx < xive->nr_ends);
             end = &xive->endt[end_idx];
@@ -203,10 +201,8 @@ static void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
                 spapr_xive_end_pic_print_info(xive, end, buf);
             }
 
-            info = human_readable_text_from_str(buf);
-            monitor_puts(mon, info->human_readable_text);
         }
-        monitor_printf(mon, "\n");
+        g_string_append_c(buf, '\n');
     }
 }
 
@@ -717,10 +713,10 @@ static void spapr_xive_print_info(SpaprInterruptController *intc, Monitor *mon)
 
         xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, buf);
     }
+    spapr_xive_pic_print_info(xive, buf);
+
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
-
-    spapr_xive_pic_print_info(xive, mon);
 }
 
 static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_servers,
-- 
2.41.0


