Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850DBC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKa-0005Si-UI; Tue, 18 Jun 2024 12:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKW-0005L2-3a
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKU-0007Xd-66
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f8ebbd268so291492366b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726704; x=1719331504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLTZXMk8f7jCos7Oua6eYCL2IKl5sjVIn9SYnGqK2mg=;
 b=Ed9tuF9arUeqezvHHqsmvy7lUbmTRf8TJ0RwFF6+cVyeXXthAhw9q6vDI0YeQzZnr6
 kvWHkV+udskLzAF3qkZ6yuYATtYrZH6O5onmQhZufpex1oFNZplo3c5Rur7Uw3HNZrKE
 h442zKzOErPSWq6NR/uy/NxWTo6TZR/EU1L9lj4JDtNPo6b2HPb6D1AHSITXI4QpD3Ky
 nN0dVljXFjztUJPlz9ojOWhigQUgCRxNbTJ7ss+21TZzoi9npTDEr3vxFGi6TNmuFCj5
 Rsmi/yysWKMnPYynfgsSd+HQR3ARdyZ/dzTym9aJVywtPpbWcbxlvyI1qssLklqmVSGS
 nAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726704; x=1719331504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLTZXMk8f7jCos7Oua6eYCL2IKl5sjVIn9SYnGqK2mg=;
 b=b7oOvn3uDZFFoDEi9wpghCOiAwhv2M5XV2HVvc41lpMk6rw/P+n1vRjcYkwzdD5JI6
 4MnGLszgyJMt7j+fUKc7ymbD3qkEvndYcMjFd/WMmwG+akCgYCqBinwh6YzOdawrHHu+
 InQAixTwyejCz8XendsU34dIOfMnZiLRYg88wMZgo/Gl0/c9SKF9NVK2BULYivcWyfzm
 Yr8G0pPXSwrQ+sYdN5eZjdaDN67os5Yd3MHnxwBtl0T77uHJYPRAA2kBOxJfjga1zIN7
 hT8QhrMKNznRLZxZHhp1lYkBPx0xdc3AazQR7ca6IqXFZXzD0GPT01q5xhuRAz2/4ju6
 WkpQ==
X-Gm-Message-State: AOJu0YzIxZ50825UkpOE79XVM4Q/BvurVQO59pTVVj+Kp9M3vu8ko0BK
 NmYCVTjaxIOaRBKwW4AIsai24HHlzCCQ8OopvTKJaa0j+gsjxlz+ugvVwMqe01G5+JTiQtfM/y6
 H
X-Google-Smtp-Source: AGHT+IHCaNlAuXFLj5Joc7lw1KLOxyN7+ofne1drqqBki719Da65EGsQ5zta81ZorTp5jro2kCn4jQ==
X-Received: by 2002:a17:906:99cf:b0:a6f:4ebd:1463 with SMTP id
 a640c23a62f3a-a6fa430f30amr17930166b.20.1718726703947; 
 Tue, 18 Jun 2024 09:05:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f41684sm628373866b.153.2024.06.18.09.05.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 45/76] hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:07 +0200
Message-ID: <20240618160039.36108-46-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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
Message-Id: <20240610062105.49848-22-philmd@linaro.org>
---
 hw/intc/pnv_xive2.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 52505fd1a4..10914b04df 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2028,7 +2028,7 @@ static void pnv_xive2_register_types(void)
 type_init(pnv_xive2_register_types)
 
 static void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx,
-                                     Monitor *mon)
+                                     GString *buf)
 {
     uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
     uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
@@ -2037,21 +2037,21 @@ static void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx,
         return;
     }
 
-    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x",
-                   nvp_idx, eq_blk, eq_idx,
-                   xive_get_field32(NVP2_W2_IPB, nvp->w2));
+    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
+                           nvp_idx, eq_blk, eq_idx,
+                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
     /*
      * When the NVP is HW controlled, more fields are updated
      */
     if (xive2_nvp_is_hw(nvp)) {
-        monitor_printf(mon, " CPPR:%02x",
-                       xive_get_field32(NVP2_W2_CPPR, nvp->w2));
+        g_string_append_printf(buf, " CPPR:%02x",
+                               xive_get_field32(NVP2_W2_CPPR, nvp->w2));
         if (xive2_nvp_is_co(nvp)) {
-            monitor_printf(mon, " CO:%04x",
-                           xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
+            g_string_append_printf(buf, " CO:%04x",
+                                   xive_get_field32(NVP2_W1_CO_THRID, nvp->w1));
         }
     }
-    monitor_printf(mon, "\n");
+    g_string_append_c(buf, '\n');
 }
 
 /*
@@ -2147,15 +2147,16 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
     while (!xive2_router_get_end(xrtr, blk, i, &end)) {
         xive2_end_pic_print_info(&end, i++, buf);
     }
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
-    monitor_printf(mon, "XIVE[%x] #%d NVPT %08x .. %08x\n", chip_id, blk,
-                   0, XIVE2_NVP_COUNT - 1);
+    g_string_append_printf(buf, "XIVE[%x] #%d NVPT %08x .. %08x\n",
+                           chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
     xive_nvp_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
     for (i = 0; i < XIVE2_NVP_COUNT; i += xive_nvp_per_subpage) {
         while (!xive2_router_get_nvp(xrtr, blk, i, &nvp)) {
-            xive2_nvp_pic_print_info(&nvp, i++, mon);
+            xive2_nvp_pic_print_info(&nvp, i++, buf);
         }
     }
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
-- 
2.41.0


