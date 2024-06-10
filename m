Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A8CC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQi-0005Xu-1a; Mon, 10 Jun 2024 02:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQg-0005II-7C
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQe-0004e6-BL
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f1cb7a40fso999881f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000570; x=1718605370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3rr/CUsYOR7MAOeZf0Zr5EWpEoeic30FuIkZJmnou0=;
 b=CHzwY+KXqWUGtFbB/QYxZjXDRRXm9c0IqK8NEjku3a50njY7eWNeP20dtZ38SMvrzf
 mylnizxlyjpqlNTeIebQYMnGDy2+9e7NJhy2nTqdjoDiPekYOF28VH21At1JTysD0LxG
 nw+sn/BrgOEj0zeHJkw5bdu7CmkCpJduXq/RhO76eVE/Q5u53n1oKFvx8OKq+ChkgUJ6
 grHf1TVGOvqJ2LHlKIWADYpMRTO2im7CGWRgRcotftqSZ0ULcB84Yuwcjzj8HT+0dSbw
 0/yqlmsVIJMuJUyyeLKXLwZfoDShUDv2J171l22wTvHcluHqxFIf/fcj/wVwxetK/bED
 6tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000570; x=1718605370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3rr/CUsYOR7MAOeZf0Zr5EWpEoeic30FuIkZJmnou0=;
 b=RJUPM8fiBHJYWkVatuFYfkVWlh/l3Le7oKiXq8PyBXgvTERcj2U4uGMOSpJAhTwOHG
 QLrLdbkFwxsP4CnWgvrZulWW2VX1tqxqUwjkw1D72FMjgXcjKQii4sjVRXGTaC2r7hZp
 AikP+0c+5HN22oCvc2VnmCl8sKmU0yJMa1Sr17sWPPBEVyl0lGW17vOBcl/oU+zgaeR8
 DEyDfuBuq6bE4+dcKv0/nwnntfkMcB2Jrxaa8rFR6B85lXVRx88z8Y1Ewzh6Qq2zjBXA
 g6KCFHt0QoW6gcMwS5X7dvXDn6Z6vPiTIaQRIdRlttOJ+byC5injjH7itVEA0wtRibRt
 8UWw==
X-Gm-Message-State: AOJu0YwkDoezBpmHzxU1kt/wdZ9IYWVUAJUE0d/AzvzX78X7Z4PryX5i
 PMCyiu8d+45SirBnFwfaWmhxdRG/Lw2VAX5ql8DdDO2rNGB6ES0dCb/AHq9kL44W7+C8l8lI0iF
 a
X-Google-Smtp-Source: AGHT+IH+P36nw3Kn+juT3aZJsfY3utFBemT9qOsNimJ6uliuKQbq82G+JUIGW9ZVAsjiWFonCkQgJA==
X-Received: by 2002:adf:ec02:0:b0:35d:bfac:1aae with SMTP id
 ffacd0b85a97d-35efed1b8d0mr5555434f8f.12.1718000570396; 
 Sun, 09 Jun 2024 23:22:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f252193d9sm1510358f8f.54.2024.06.09.23.22.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:49 -0700 (PDT)
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
Subject: [PATCH 18/26] hw/ppc: Avoid using Monitor in
 xive2_end_eas_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:56 +0200
Message-ID: <20240610062105.49848-19-philmd@linaro.org>
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


