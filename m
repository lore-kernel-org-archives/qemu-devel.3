Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75407C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPn-0002wO-6J; Mon, 10 Jun 2024 02:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPk-0002vk-Tn
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPj-0004Pk-9T
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f1dc4ab9aso901073f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000513; x=1718605313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jX2GHhOc9H8vjkcZGjrbxVcD9p/2Wp7GIx+OlbcBx8Y=;
 b=KR6gQkBnnojbV93o3AsEemouJeR/04eF9ceHa5sYu0+9T7LXjs41lbGkWuERLwiCac
 GehJGTUc+uZVbuBdYWyzXAbEP99/px7JarzULMsUGaIr0aCdpsxRsLNzFFBMzu/Idhqi
 lW/1tt9DBSs0X30Kmjfmh/WuqaSCtr+df1u53/fs7310n7QzfHqXYivTfUvY6+pigw9b
 oN4xBq9QqTS/xEqkSBueZeX762m2G3JNX29bl7akbU1Nj3KgL297toHQ5hjKIFjyepKi
 YsbW+FlPQkLUTp7ix/0nLJLk4uhTjHV8Pkisadm8ikkn0L6BZH+4uYJHk+U+gJib/zd+
 XmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000513; x=1718605313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jX2GHhOc9H8vjkcZGjrbxVcD9p/2Wp7GIx+OlbcBx8Y=;
 b=JQoB58BZKQeqvfLbD45OGE1Lv0FBcTEjg/mR4RHpYFcBGLWPWm9n2GcQYef5GO+qF1
 eEQBqEDsozQjEmu7f7CKQIUIuFaYV8LFMvg6zPVfgXMBU1Sjtj4phcUwJTjUYZLcFgxY
 NNGSPPOfO2peHdpvsoWn300qUUvZT4sKo2mVHh3k3bP04HLkFvklH1+xJkRE63QNOHeP
 FGyTKaseu27nK6YksPpO8v4pYq/77ZnwHHEcfGAbuVYc2x3mfOKmIgG7d9XAqijKvazl
 V+uBab/tn+3AHubrfDX3YnrPTgAR+YpCiWTn1YXz/9/o+bzqP9UTeApqYN8qQIyNE+9C
 Mw9g==
X-Gm-Message-State: AOJu0Ywa+Bos10aclJLrkkitkXXLzlDglpXkkrcwhTRn3XJgwZ1NJYLb
 jH6j7HjJYOYDZcYdxE3aR+5rGmzrQf9YC1B++CmEejDeyVtUcwjbLX1qrpOwSekFyO1r1yGrORK
 I
X-Google-Smtp-Source: AGHT+IGSsvm7efserjKCuOOExBjJ/g/eBos93nGfuNGPupTJ6rdmWWVoQtluX44TLOU8BkcfTvLfyg==
X-Received: by 2002:a05:6000:1a8d:b0:35f:2621:e4b0 with SMTP id
 ffacd0b85a97d-35f2621e572mr626127f8f.2.1718000513539; 
 Sun, 09 Jun 2024 23:21:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f209c4a4asm2866920f8f.43.2024.06.09.23.21.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:53 -0700 (PDT)
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
Subject: [PATCH 08/26] hw/ppc: Avoid using Monitor in
 spapr_xive_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:46 +0200
Message-ID: <20240610062105.49848-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


