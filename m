Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9542C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQc-0004mG-VT; Mon, 10 Jun 2024 02:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQL-0004BT-UC
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQJ-0004Zb-47
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35f1a7386d5so1021837f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000548; x=1718605348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1X43X3u1MNBxinpMUxBqMIlo7Li/da4jfz1xla7hBs=;
 b=ukfSLDMw7I0TYktrQ3H7XYQNb28ArGlld5E5baKOH9ruGsgIKmAoc7SRBGvJo4GwG0
 q4bBBC9F3sAEu8n6Yoo6JR5avZHj1uSwiEQWr1MtxR26Az7GPk2G+mAOfUm8UYzb+1c5
 64+Z/p/ejJsK1fMT1Rw1MKK77II/ZJlHLlXrfj/11JxFjo28WokqxR8Yc9sLfv1la+6g
 kti0y0GZNR4VZHsW1HoiJcZv8xQFoSreWMi7n/7K7ydmwa3htYh0eYZoGvzndCY/+Fc3
 k7doD9ERtAf5pbM21wvPHc0MUcU5FZMnLMi2MX4pUlqegsAfThnaFruwK9+sUKb9mgu0
 0mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000548; x=1718605348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1X43X3u1MNBxinpMUxBqMIlo7Li/da4jfz1xla7hBs=;
 b=HI31tSkEmWqSIaxNs7Nn3RwHAH4xy6YLBm6oN9fIkzfJbKUIJDSlaAotZ1dn1pQpDm
 y2z4f0PUBcSGbaHFe9Int1JE5cDSWlQa9QUwyFBKW+vIrjU92Re5Njrd+gGG79e/1X19
 y8lrf9rVIJYd7hhxfFxXdMPOIhEwGk6K4yPDfOWi6LPQdXeLO2GU33yFe7fzNNdL53UJ
 G8EXcEllQu6HpEB9yz/xPDOQFRihmyQHAO4R3/+i2RQUc/ULKHY0NslpZpI4cnLcA4y4
 pSnd54DYhEiOvw+Hib5D4sQLVESIGtfGVnA2fli99tOX4MOvGYrjkDQ3XpBPAFuyAjj9
 vtdA==
X-Gm-Message-State: AOJu0YwrATAMLdlDUIfZWO/+rr7CdthS+fbvTXoV0rvBIURF82WJcdcr
 kd6QGt8oihRZI//9MK6Lr+gqRjMjINeemMcdu2pWF7HKB1y0HJD4nyDd0FXF9RGzTTs8DYH5Qmw
 5
X-Google-Smtp-Source: AGHT+IGufwLfrncU+oDPzB8GveCGCw+TFyFMPISEHjpsXR53RDc0OFs4GIs4cdFJmQYHSSPRaDd9Ig==
X-Received: by 2002:a5d:5009:0:b0:35f:1176:ae72 with SMTP id
 ffacd0b85a97d-35f1176af9cmr2634603f8f.6.1718000547771; 
 Sun, 09 Jun 2024 23:22:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f223dfce9sm2549837f8f.21.2024.06.09.23.22.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:27 -0700 (PDT)
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
Subject: [PATCH 14/26] hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:52 +0200
Message-ID: <20240610062105.49848-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
 hw/intc/pnv_xive.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index a0c6dee5db..3ad4ac8e7d 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1832,7 +1832,7 @@ static const MemoryRegionOps pnv_xive_pc_ops = {
 };
 
 static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
-                                    Monitor *mon)
+                                    GString *buf)
 {
     uint8_t  eq_blk = xive_get_field32(NVT_W1_EQ_BLOCK, nvt->w1);
     uint32_t eq_idx = xive_get_field32(NVT_W1_EQ_INDEX, nvt->w1);
@@ -1841,9 +1841,9 @@ static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
         return;
     }
 
-    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x\n", nvt_idx,
-                   eq_blk, eq_idx,
-                   xive_get_field32(NVT_W4_IPB, nvt->w4));
+    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x\n",
+                           nvt_idx, eq_blk, eq_idx,
+                           xive_get_field32(NVT_W4_IPB, nvt->w4));
 }
 
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
@@ -1888,17 +1888,18 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_eas_pic_print_info(&end, i++, buf);
     }
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
-    monitor_printf(mon, "XIVE[%x] #%d NVTT %08x .. %08x\n", chip_id, blk,
-                   0, XIVE_NVT_COUNT - 1);
+    g_string_append_printf(buf, "XIVE[%x] #%d NVTT %08x .. %08x\n",
+                           chip_id, blk, 0, XIVE_NVT_COUNT - 1);
     xive_nvt_per_subpage = pnv_xive_vst_per_subpage(xive, VST_TSEL_VPDT);
     for (i = 0; i < XIVE_NVT_COUNT; i += xive_nvt_per_subpage) {
         while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
-            xive_nvt_pic_print_info(&nvt, i++, mon);
+            xive_nvt_pic_print_info(&nvt, i++, buf);
         }
     }
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 static void pnv_xive_reset(void *dev)
-- 
2.41.0


