Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D8C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJt-0004FE-SM; Tue, 18 Jun 2024 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJs-00046D-9y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:28 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJq-0007FS-DN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:28 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52c9034860dso7113258e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726664; x=1719331464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0OrXW9b+XN8YsCIUyH/dpkBirMjCPjOco0x9NNBa2Y=;
 b=KCkXwesSj0HXqEOtm9OX84nlpySUPOvvRpX8SjCP4s9pSZ5yaFnpFymTW+HtzUNKkh
 1dHznbgvHIr6splMxTy6E0znGergPFiHfq1UkNa6+fEJbklt+mU1G1GlkPICUyWRsbxZ
 y+tCL4xLmIf4nGLYLFlpjR4UAHPnjC4dzAx1lW8NtTl6uIfjvsaub4kCQ6s4N72A9Edl
 lsGKCi7zMBPnyAwzsX9cDxyavGlf6n3+ifjySKsk6Sp858l5PtFGGMEGdtL0RtI1IMr5
 kqQGkeNlpsEf07XOu1R65T+Y31vW74JhJvkNfzOqJa+zjT2Aq/4n4O1mNPo5iNYeWrkK
 ON3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726664; x=1719331464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0OrXW9b+XN8YsCIUyH/dpkBirMjCPjOco0x9NNBa2Y=;
 b=N5Pv6ClMTMhbPU5fFBDVhYg+vBCYjVDFaww6YIEnxSw8RwIr8PQIo1OQYvZbd1zeqG
 MT4TZBiaExQ/aeyzRHF8wk5+vaq2rN+XKa6v5PwEO97CEWWlYgcg18fuL/j4EL1ibUyO
 BdpR/4twRUfOk95wdNIUn92DudpdiV8b5P0aM4ZTN6DKp/Pbj6UHZveGtZFFrq0hO1i5
 +LR7JHCQ2DFsK2GP7MMIte+hOQbt5deAj3REoDSjK3CodSSABEjllfVA1dDzwrEmaPmS
 WkhhwgESXPr/GwT2bDVWOp59HESwGhlKvNcIfmlokuX2LKlCTdBRkGFlrfM3Zw5mo1Bi
 fzcg==
X-Gm-Message-State: AOJu0YwiwadCrB25K5J9UOsewYXG/fdTxH6CP1MN2ipfX13E0hc2sf18
 FGZZyrB862Va3YNKJUX4a0o6c/WcnVX+IwhPIGG/f8sxnxaD6W25inxNlQuiIsdiIoWXjNY0dS4
 i
X-Google-Smtp-Source: AGHT+IGJFekd4SyH7Ya3cjSVBaA4VcnIV+ApX16mjo3H2sv4IfpCSac6Ht9kflhSO5p+EOKdvJ2S+g==
X-Received: by 2002:ac2:5b04:0:b0:52c:9523:f0db with SMTP id
 2adb3069b0e04-52ccaa523e4mr44812e87.45.1718726664248; 
 Tue, 18 Jun 2024 09:04:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da32c3sm638640566b.13.2024.06.18.09.04.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 38/76] hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:00 +0200
Message-ID: <20240618160039.36108-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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
Message-Id: <20240610062105.49848-15-philmd@linaro.org>
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


