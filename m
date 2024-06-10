Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAD8C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQe-00054P-Ej; Mon, 10 Jun 2024 02:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQa-0004iR-Rb
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQZ-0004dI-0Q
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35f1c567ae4so992638f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000565; x=1718605365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxe7HfN8JjME6wSReRSlFJ2qLete6tZ4Y332w2hrNvs=;
 b=w27ACW4wOTkGroFwxSNxuYlFpqPVNBW5T15CNkVtvBi4DX5do9HL+MS2/6di7kkydk
 7q5NCTqWtUcGZcp2qq1a/Kj1JCOSqtsxuSKqjFZukYoN84rg1RCOyRJ63X58w+UMCIGB
 D9ZncqZPq4n3x4uQdA3eJsqUahv4Agq9dMR6A9WurUhLodaVCY+gGusOWvc/2J1iBZlX
 ebuoFhVPiTJ6tOU53dWbGaxXZ773Dw3oUvajS3ET2jWkizw2a9HSZqO4GZ13N7XbRAbp
 BS0vfXEIF1v6HuBvLSYdYVJx2ueCi6wOR9XeqOgUR8F7pePOAMeCRhu2vTNc5vny8Zbz
 pYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000565; x=1718605365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxe7HfN8JjME6wSReRSlFJ2qLete6tZ4Y332w2hrNvs=;
 b=HY0X4pKZI1/hyDvdrXSD7aA880zY4GjLzewRWJLvRJxwWcKocNMrXLi4ohsKo0UWX7
 aK4ZF/v/GGvIHHfElDDqrjKxYgcug7E7oOxttaW49BMmQrK6IYivvgY2h9xs+VjfHHXa
 /C/g3ujfG2rtMhcRLMqgMhjm34/6kUJJ79an583eGwEYK3NylMQgkTA7PUk9KMDdJf2B
 nzErm0hbtOhZCuMja9wurKKJu59a7JDBfJeryucKTJPLdpxnkMjE1kNobGx05fiZBTGW
 8y9PYjgpDEBhDB9wSpw0IUFLQLZFM3sBlkoSWfXRhxOQKBsnyOGOPmozw+nIWYp/sQGf
 lC9g==
X-Gm-Message-State: AOJu0YzldFbQ1pisxuelic3tvAJzXdZizQgGeR1OcDWM4K7hEsdd+njE
 nvAgS1SRztbqtdDgu5Tg78vNTxYmE51qCTIgR/szPyn+dvGFflta3MzCY6IfNYNz66DPjn7P/es
 3
X-Google-Smtp-Source: AGHT+IFQheTOE3o6P6GWP0PwT3sBP8wcofzTbWHRCc/AG4scaImisjdr32yYXmlJBymZ6K5DFCZ6gA==
X-Received: by 2002:a05:6000:1743:b0:356:491f:27ec with SMTP id
 ffacd0b85a97d-35efed51586mr5175689f8f.39.1718000564777; 
 Sun, 09 Jun 2024 23:22:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0ccc5f03sm6855921f8f.88.2024.06.09.23.22.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:44 -0700 (PDT)
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
Subject: [PATCH 17/26] hw/ppc: Avoid using Monitor in
 xive2_eas_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:55 +0200
Message-ID: <20240610062105.49848-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 hw/intc/pnv_xive2.c         | 16 ++++++++--------
 hw/intc/xive2.c             | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 816f5d0e84..f662f0e325 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -48,7 +48,7 @@ typedef struct Xive2Eas {
 #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
 #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
 
-void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, Monitor *mon);
+void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf);
 
 /*
  * Event Notifification Descriptor (END)
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 83e0f6b09f..649e5001fd 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2120,24 +2120,24 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
     g_autoptr(GString) buf = g_string_new("");
     g_autoptr(HumanReadableText) info = NULL;
 
-    monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_esbs - 1);
+    g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
+                           blk, srcno0, srcno0 + nr_esbs - 1);
     xive_source_pic_print_info(&xive->ipi_source, srcno0, buf);
 
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
-
-    monitor_printf(mon, "XIVE[%x] EAT %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_esbs - 1);
+    g_string_append_printf(buf, "XIVE[%x] EAT %08x .. %08x\n",
+                           blk, srcno0, srcno0 + nr_esbs - 1);
     for (i = 0; i < nr_esbs; i++) {
         if (xive2_router_get_eas(xrtr, blk, i, &eas)) {
             break;
         }
         if (!xive2_eas_is_masked(&eas)) {
-            xive2_eas_pic_print_info(&eas, i, mon);
+            xive2_eas_pic_print_info(&eas, i, buf);
         }
     }
 
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
+
     monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, blk);
     i = 0;
     while (!xive2_router_get_end(xrtr, blk, i, &end)) {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 98c0d8ba44..0154ebb59c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -27,17 +27,17 @@ uint32_t xive2_router_get_config(Xive2Router *xrtr)
     return xrc->get_config(xrtr);
 }
 
-void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, Monitor *mon)
+void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
         return;
     }
 
-    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
-                   lisn, xive2_eas_is_masked(eas) ? "M" : " ",
-                   (uint8_t)  xive_get_field64(EAS2_END_BLOCK, eas->w),
-                   (uint32_t) xive_get_field64(EAS2_END_INDEX, eas->w),
-                   (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
+    g_string_append_printf(buf, "  %08x %s end:%02x/%04x data:%08x\n",
+                           lisn, xive2_eas_is_masked(eas) ? "M" : " ",
+                           (uint8_t)  xive_get_field64(EAS2_END_BLOCK, eas->w),
+                           (uint32_t) xive_get_field64(EAS2_END_INDEX, eas->w),
+                           (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width,
-- 
2.41.0


