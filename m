Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65745C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPh-0002up-NU; Mon, 10 Jun 2024 02:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPf-0002tf-QQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:51 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPd-0004Oy-Rc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:51 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52c7f7fdd24so1589636e87.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000508; x=1718605308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3AV06pPtzbI7+PF3PUt7wjEhH3sPFaxkZhNhMweE8Y=;
 b=cAwLqkYz6vYy4hcNpJIAcyW05v+LMU0h5cqSZ7OLPMcfcdMsca3P+kofFB2yf0KwYg
 IGABAK2/7eOAxw2E88MlJbbhybOnRhYrFVvNsZ7eVI9hDGQk4NDTUYuLdOYa3P1Me7CU
 qFEUBmAlhf6RL6aMaMfQwWEwRmKqYEQ0bZTHPF0w4zAB0FUGjTVzDpXUoy+VQrrAdo3y
 jPNbiK8QNM8aF0yJ/gPGPtNj2yoBFQgGi50DHjioMZz+io4xBEQr2BxTfEdCtVsQyv+i
 BSWyQtVloddKAQuR3kJBPk6DuKOZcjAtqWQ8FAlmqQo4yHGbM/bmONslhCKw/dhL8DIU
 gXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000508; x=1718605308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3AV06pPtzbI7+PF3PUt7wjEhH3sPFaxkZhNhMweE8Y=;
 b=gCfOMldz5nZe6EZjQESZM8xkV29jXS7E5JP6vbuUV7vW7rlksrZGYl3IVMkmH5J//7
 sj/uLg/DOZcQs5ms4vjcnJN9pvVi4IugJvLj7bXpVz7FHyWYe+YUXdZRfIy+KVDDJYX2
 6N4eJw+3pJPzRJvK7z3qnLawiUN7kjek1csTRcItCwzltaqbd4Oh2GQMh8UoSpRxkqcV
 03knfsU9X9rLvxQj0wWX3qQLga5ZyDAFeCDB5dL87F4bBbSkZ35mgRLfwrSRjDJ+D3Fa
 GxqxQEkm8zY/C+701+JAwMpIBu9+hK13qpETb9vawKbFKd8bRGBOTc/Iy3LFhHfa2T9K
 eJDA==
X-Gm-Message-State: AOJu0Yz4MZkZMU8SRpRFJwKtxEseQ7b0xGzJu6N4ItRdLB+LtULOBoE8
 bkxJ1YurjfPKAuIJA4G0fgBxx4H4FzuptiyvWHbbQRvXNGQKh2GSufsmF1u11d72wTiWg9fxl2n
 H
X-Google-Smtp-Source: AGHT+IE0Ddg6TrtyAtPvtNVnNnezQildOj0PgB+MXZVprIe3zTw8PVmYWoqP91/re/DnWYNq3llLeg==
X-Received: by 2002:ac2:490b:0:b0:51d:1c86:a274 with SMTP id
 2adb3069b0e04-52bb9f818ebmr4502494e87.34.1718000507785; 
 Sun, 09 Jun 2024 23:21:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421f23d06ddsm11564355e9.8.2024.06.09.23.21.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:47 -0700 (PDT)
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
Subject: [PATCH 07/26] hw/ppc: Avoid using Monitor in
 spapr_xive_end_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:45 +0200
Message-ID: <20240610062105.49848-8-philmd@linaro.org>
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
 hw/intc/spapr_xive.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 3357f6325f..d571645e9e 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -133,7 +133,7 @@ static int spapr_xive_target_to_end(uint32_t target, uint8_t prio,
  * structure dumping only the information related to the OS EQ.
  */
 static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
-                                          Monitor *mon)
+                                          GString *buf)
 {
     uint64_t qaddr_base = xive_end_qaddr(end);
     uint32_t qindex = xive_get_field32(END_W1_PAGE_OFF, end->w1);
@@ -142,17 +142,12 @@ static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
     uint32_t qentries = 1 << (qsize + 10);
     uint32_t nvt = xive_get_field32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority = xive_get_field32(END_W7_F0_PRIORITY, end->w7);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
-    monitor_printf(mon, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
-                   spapr_xive_nvt_to_target(0, nvt),
-                   priority, qindex, qentries, qaddr_base, qgen);
+    g_string_append_printf(buf, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
+                           spapr_xive_nvt_to_target(0, nvt),
+                           priority, qindex, qentries, qaddr_base, qgen);
 
     xive_end_queue_pic_print_info(end, 6, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
@@ -198,13 +193,18 @@ static void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
         if (!xive_eas_is_masked(eas)) {
             uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
             XiveEND *end;
+            g_autoptr(GString) buf = g_string_new("");
+            g_autoptr(HumanReadableText) info = NULL;
 
             assert(end_idx < xive->nr_ends);
             end = &xive->endt[end_idx];
 
             if (xive_end_is_valid(end)) {
-                spapr_xive_end_pic_print_info(xive, end, mon);
+                spapr_xive_end_pic_print_info(xive, end, buf);
             }
+
+            info = human_readable_text_from_str(buf);
+            monitor_puts(mon, info->human_readable_text);
         }
         monitor_printf(mon, "\n");
     }
-- 
2.41.0


