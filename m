Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E81BC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYQI-00044b-Sq; Mon, 10 Jun 2024 02:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQ5-0003Mw-H8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:20 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYQ0-0004Tk-NV
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:14 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52c85a7f834so1086080e87.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000531; x=1718605331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4OQnqhZPPe0S3e5bkGivQbSupbVDgnVRofBomnV0rI=;
 b=ovp38pmPvo3JYc//WTmyxUARhTc8Y/k+Mp9QN/lIU7oq+oZTKk+gPlVMDZP4+RgK42
 AUQgtGKZ1dHCPfGYOhUBnu11D+N1N6nFriPIXKZbDR1BMuqRgtFhfCd7zgM1DucpV3CU
 7irXbMcK8uDOH33O2xEPavH6JGUBFCCEPmbIUIQoFtdjyiE8v1Zz+0m9RbGp99gZ3t8y
 OQ6ezaMcx2P+d/MIjoWr4Nv/w7bOg9sk+JmIRrLKxBAjJA5vzsPt2QSVJjfBMgspNadT
 xQh+WRbZGpiCCv/l7bx1zEN+48H6E/9Yrweh+v5VXBsNJQKZYM3aBAPnc1M/9yKk08n7
 hEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000531; x=1718605331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4OQnqhZPPe0S3e5bkGivQbSupbVDgnVRofBomnV0rI=;
 b=YnC9jUohdDQsYxMkOcHoCOQmXgxAioNN3yY6BS51aNaULaG6E2DT0Ewx6oF33bnYTM
 l+MBrOIT9OyfASkgzrpbtnDcMFCPuaKFvLQle4C+KlSyu2KzBUt86e+iOVSoYZ9hUYqi
 WYPHyfNjnhu88TP/ceKCD9h+CNlwLGL09FvgCD+AxAhmw5rGeUmt7yzFxu2CX6jllIEA
 NkogqkdUALg7aIj+ldJlqbfW1qq7Z8isp4RX6NgaLhZ6I02WLsOgdnqEiSrbjzCKtrLf
 QZbeZIew7YihtgK9nHhu/jCahEQI1/YXXDSb24M/s22WX3zYsGbCcSOKy58Czh0EHF1m
 T1HQ==
X-Gm-Message-State: AOJu0YzqUScYbyYLi7Utk10GYv5AZbNT3mPxoEfVqnmZunOAkDElaBpv
 lYY/ldPMbIxutLaSmDTRvhb3NyF3Upq+baWthmNIfbs68QhsjhaysOn7nkWThhs7pw3eLDnHFeR
 /
X-Google-Smtp-Source: AGHT+IEq4HokXUpYB+gjsJGWe8mB8izk5nVKQiRCsvOnq3busMeOb+amL0uIo8QnI2rBrISOjm7FdQ==
X-Received: by 2002:ac2:4d1b:0:b0:52b:84bd:345e with SMTP id
 2adb3069b0e04-52bb9fc46fcmr4392918e87.43.1718000530791; 
 Sun, 09 Jun 2024 23:22:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f25907f15sm1290544f8f.45.2024.06.09.23.22.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:22:10 -0700 (PDT)
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
Subject: [PATCH 11/26] hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:49 +0200
Message-ID: <20240610062105.49848-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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
 include/hw/ppc/xive_regs.h |  2 +-
 hw/intc/pnv_xive.c         | 10 +++++-----
 hw/intc/xive.c             | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 51e9a2152e..dd4a76bcf0 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -167,7 +167,7 @@ typedef struct XiveEAS {
 #define xive_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS_VALID)
 #define xive_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS_MASKED)
 
-void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
+void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, GString *buf);
 
 static inline uint64_t xive_get_field64(uint64_t mask, uint64_t word)
 {
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 520d7e0acd..c377823522 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1864,19 +1864,19 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
     g_string_append_printf(buf, "XIVE[%x] #%d Source %08x .. %08x\n",
                            chip_id, blk, srcno0, srcno0 + nr_ipis - 1);
     xive_source_pic_print_info(&xive->ipi_source, srcno0, buf);
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 
-    monitor_printf(mon, "XIVE[%x] #%d EAT %08x .. %08x\n", chip_id, blk,
-                   srcno0, srcno0 + nr_ipis - 1);
+    g_string_append_printf(buf, "XIVE[%x] #%d EAT %08x .. %08x\n",
+                           chip_id, blk, srcno0, srcno0 + nr_ipis - 1);
     for (i = 0; i < nr_ipis; i++) {
         if (xive_router_get_eas(xrtr, blk, i, &eas)) {
             break;
         }
         if (!xive_eas_is_masked(&eas)) {
-            xive_eas_pic_print_info(&eas, i, mon);
+            xive_eas_pic_print_info(&eas, i, buf);
         }
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
     i = 0;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 1adb0439c5..b2203b721b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1921,17 +1921,17 @@ static const TypeInfo xive_router_info = {
     }
 };
 
-void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon)
+void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, GString *buf)
 {
     if (!xive_eas_is_valid(eas)) {
         return;
     }
 
-    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
-                   lisn, xive_eas_is_masked(eas) ? "M" : " ",
-                   (uint8_t)  xive_get_field64(EAS_END_BLOCK, eas->w),
-                   (uint32_t) xive_get_field64(EAS_END_INDEX, eas->w),
-                   (uint32_t) xive_get_field64(EAS_END_DATA, eas->w));
+    g_string_append_printf(buf, "  %08x %s end:%02x/%04x data:%08x\n",
+                           lisn, xive_eas_is_masked(eas) ? "M" : " ",
+                           (uint8_t)  xive_get_field64(EAS_END_BLOCK, eas->w),
+                           (uint32_t) xive_get_field64(EAS_END_INDEX, eas->w),
+                           (uint32_t) xive_get_field64(EAS_END_DATA, eas->w));
 }
 
 /*
-- 
2.41.0


