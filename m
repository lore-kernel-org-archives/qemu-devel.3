Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64695C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYR2-0007ez-C3; Mon, 10 Jun 2024 02:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQy-00077Y-8M
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQv-0004ge-4I
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f1c490c13so1331393f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000587; x=1718605387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mz5qepmIMKoMtRNgH2g47GTUqOjYTHfYVOjGTI79PvM=;
 b=YoREaMCy4UphPB4ViB0APqwxUlW49X/BkinFtNoetmImPJn3g9aUep92u5ziZrqOBK
 8lz04d+bLx4m5C6rqYg3vpSNGH95PUPWeE110zxNBCn7kqRXq8xPYB/JEbfDNNquVbkq
 Xh+giqPwhhjs5bcaZ1+uS0bYmCIjRTj1SQelJShqCcalrJlWAU5tSEApVFCd3k6GiIcb
 5Z8O8LUZPtOWB+LgUm7Oa+SAS2dIh8mSMmRUKXCMgRK3WbHTweKopI8+x3dGa2HtOZBs
 NXbhwZD3Do8EKIzPzemnNLlK741V6aLm5MJdzt3y/cIzZlNofFKfEOy3mQCUYlFrgF5S
 oqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000587; x=1718605387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mz5qepmIMKoMtRNgH2g47GTUqOjYTHfYVOjGTI79PvM=;
 b=iNGP1380mLiY6UdbqSwKnwc2TJBnuwnGQRlI8CkMAWR2cFRxyrpiA24tFXLDJOYHe1
 qxWQOvQ1MZsG5zfzLTIxLx0VC1LkSQcM1mKHdaTyIjhwP6YheEle47jAfgH4nvRfbK7S
 a+IB99gmZladvnssT90UZ9jAIDrA4iU2bQLyHDowE324ERdUSwIgHNvPn3saguKsGRAe
 5omU/J8QgyCqfWhGPBj/jKhjYkZFf9H3Pje8C9XcGFi9lpE4lPGw4lt51wnOP1wk3wjs
 OuWlob7qS/RNr2JTF+oAQX11EDj3naScUtGpIM/hSFww12DiDv02jg957y1Wn6iU3REm
 lglA==
X-Gm-Message-State: AOJu0Yx6R7yiJdG2I5zUrpKyLqUCyXiaYkDtvl17thvKNZdPfPqDDrD1
 49yZms5oNN268+TfoHKdWD6Seok47NfheYudmy6SYZUl9Kt3nXBWbH0XPQgNMBEc88IYNFStDVW
 0
X-Google-Smtp-Source: AGHT+IG392FamtaMq6xYjbr14jetkKtkbbaBZ/YwxdtocZbtLdlVJLXCsf8+X/bYn3aDgw6exs7esg==
X-Received: by 2002:a05:6000:2ae:b0:35f:1ff8:32db with SMTP id
 ffacd0b85a97d-35f1ff833a5mr2837574f8f.62.1718000587438; 
 Sun, 09 Jun 2024 23:23:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f08b280d0sm7354482f8f.86.2024.06.09.23.23.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:23:07 -0700 (PDT)
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
Subject: [PATCH 21/26] hw/ppc: Avoid using Monitor in
 xive2_nvp_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:59 +0200
Message-ID: <20240610062105.49848-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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


